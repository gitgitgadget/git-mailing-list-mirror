From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Will git have a baseline feature or something alike?
Date: Sat, 1 Mar 2008 16:41:49 +0100
Message-ID: <200803011641.49874.jnareb@gmail.com>
References: <f17812d70802290123raa099bag17a6f7b89de65dd4@mail.gmail.com> <m3tzjrkie4.fsf@localhost.localdomain> <f17812d70803010610o39cdf327x995c9e2e75a9edba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "eric miao" <eric.y.miao@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 01 16:42:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVTr6-0000Iq-Dh
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 16:42:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755601AbYCAPlz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2008 10:41:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755225AbYCAPlz
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Mar 2008 10:41:55 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:54327 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753860AbYCAPly (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2008 10:41:54 -0500
Received: by ug-out-1314.google.com with SMTP id z38so906440ugc.16
        for <git@vger.kernel.org>; Sat, 01 Mar 2008 07:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=48lUiBqgRXUdHtzgtMBeiBjJe9neTR5TYY9qFfDhzKQ=;
        b=oTdqY/P49jCxmMrkLSlGavcXQeJTTQbNjG4aWheKLAZix0XEgROxJwx08IOSKFHevu4s+4ly0KHjII3IpnEz0I11E43nz/hw18AsgXCGUlGSVWpJ0brWRFpiM+aXnINcsVbtooucG09XxfpG3ROBa5+A5ddjV7KJaWQoBFPoUCE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=d9iPIo2nLpE/e/BYyuQTBAitp1XninYEIr4jHwlOsnrBDZvLCgoD/ypHorz8F2qS0pGgKuucqjsDxw4Mx3qfukwRbPLh2y2mxT0oyZyKL8kfOM0JT4ys+5Dg2KCQI7dN98UkQV/3AuPqIrd0Okas4NwFLDBnpaX3ZxAPqmHE37M=
Received: by 10.67.89.15 with SMTP id r15mr3076554ugl.12.1204386113367;
        Sat, 01 Mar 2008 07:41:53 -0800 (PST)
Received: from ?192.168.1.15? ( [83.8.199.142])
        by mx.google.com with ESMTPS id 19sm3718086ugl.13.2008.03.01.07.41.50
        (version=SSLv3 cipher=OTHER);
        Sat, 01 Mar 2008 07:41:51 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <f17812d70803010610o39cdf327x995c9e2e75a9edba@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75679>

On Sat, 1 Mar 2008, eric miao wrote:
> On Fri, Feb 29, 2008 at 9:21 PM, Jakub Narebski <jnareb@gmail.com> wrote:

[could you please remove irrelevant parts of the reply? TIA]

>> There is so called "shallow clone" feature, which allows to clone only
>> part of history. Currently it dupports only --depth, i.e. number of
>> commits from tips; it could I guess support providing tag as
>> delimiter. (You are welcome to implement it ;-).
>>
> 
> I haven't ever used the shallow clone, but it looks still a bit different
> from what I thought originally, say, if I download linux-2.6.24.tar.bz2
> from kernel.org, that's about 40MB and should be a fair amount.
> I then unpack and "git init", I expect it to recognize it's a v2.6.24,
> and I can thereafter use "git fetch" to fetch those commits after
> v2.6.24 from git.kernel.org. Is this possible?

No, this doesn't work and couldn't work. The tarfile contains only
_contents_ of the working directory, and perhaps commit-id, but it
doesn't contain even shred of history. Git has no information of
where this content is in linux kernel git history.

You have to do "git clone --depth=1 <url>"; surrently there is no
way to specify "git clone --from=<tag> <url>". I guess you can try
to get info browsing gitweb, and fudge with grafts.

-- 
Jakub Narebski
Poland
