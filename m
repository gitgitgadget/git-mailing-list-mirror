From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH] If deriving SVN_SSH from GIT_SSH on msys, also add quotes
Date: Sat, 23 Jan 2010 21:11:17 +0100
Message-ID: <bdca99241001231211o97aa0eamacc40bf982a9f022@mail.gmail.com>
References: <4B5ACDD5.8080007@gmail.com>
	 <fabb9a1e1001230322t708756fahce326511d3f0bda5@mail.gmail.com>
	 <4B5B05AC.2050200@gmail.com> <7vd410d3as.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org,
	Eric Wong <normalperson@yhbt.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	jugg@hotmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 23 21:11:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYmKJ-0006H3-UX
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jan 2010 21:11:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753838Ab0AWULU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jan 2010 15:11:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752915Ab0AWULU
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jan 2010 15:11:20 -0500
Received: from fg-out-1718.google.com ([72.14.220.153]:38537 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752636Ab0AWULT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jan 2010 15:11:19 -0500
Received: by fg-out-1718.google.com with SMTP id 16so389588fgg.1
        for <git@vger.kernel.org>; Sat, 23 Jan 2010 12:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=kTQaqRXLpjJw7/Hr4jTCHjNP7t5xbXyOGCQQFWuIiUw=;
        b=hbttKOmkPp3hXOxfaNigbstV+sOVrEw2R18ZHSdwsjqOzsmGh43Bn4JijspxLmVhG6
         wJ3S55SyCxqxK07iLhlKXWZ5ZJ26Gv84CWQaZNRQpVaFK6X6HAzw1op7ahpIEhfqtEvz
         fix2HaKlAlZ6PQELKEWKbrmJ1/pt1I0YgncI0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=nLITqlpKKv4tTWbRkTT1KMdaNCAgsvGRdBnwIXSIkDL/Bkcw+4MkNPI/Cln69TjsH4
         d7rvHUa8vkEDsx11cBvEs1CsHqmK44xIalWkCci+w6ie3RfNXLR7ZggV7ycsvA69WNQn
         nX5j4yExi0CxPVO8ipZ6CmAhsSi/CNzbk2pYw=
Received: by 10.87.42.33 with SMTP id u33mr7470264fgj.8.1264277477534; Sat, 23 
	Jan 2010 12:11:17 -0800 (PST)
In-Reply-To: <7vd410d3as.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137860>

On Sat, Jan 23, 2010 at 20:33, Junio C Hamano <gitster@pobox.com> wrote:

>> This fixes msysGit issue 385, see
>> http://code.google.com/p/msysgit/issues/detail?id=385
>>
>> Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
>
> As the patch clearly is inside "msys-only" codepath, I don't mind
> bypassing Eric and apply this directly to my tree before I tag 1.7.0-rc0,
> but may I ask why this quoting magic matters only on msys?

To be honest, I'm not exactly sure why this is required. Maybe the SVN
Perl module does some different path mangling than a normal MSYS SVN
binary would do. We're already setting SVN_SSH like this (that is,
using double-backslashes and quotes) in the msysGit installer, see the
discussion at [1]. This patch basically just does the same thing for
people that initially chose to not modify the environment during the
msysGit installation, but later change GIT_SSH manually, and forget to
set SVN_SSH, too.

[1] http://code.google.com/p/msysgit/issues/detail?id=305#c8

-- 
Sebastian Schuberth
