From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [RFC PATCH 00/12] Sparse checkout
Date: Thu, 24 Jul 2008 17:58:57 +0700
Message-ID: <fcaeb9bf0807240358l6584c063u85179196bd6db30a@mail.gmail.com>
References: <20080723145518.GA29035@laptop>
	 <m3tzefvd3q.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 13:00:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLyYE-000231-9R
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 13:00:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752345AbYGXK7B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 06:59:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752508AbYGXK7B
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 06:59:01 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:27107 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751704AbYGXK7A (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 06:59:00 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1367152fgg.17
        for <git@vger.kernel.org>; Thu, 24 Jul 2008 03:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=9+icTu6Jmtch8gXhFL1fHNbINfWSqg6PrdH9VbNaMns=;
        b=g6lEmhkm9imyI1NbenRSdt01lMD9kLkUq3b/reQtHdLtaDvNg0VpbNS7us/C0KCkUG
         XInl8Grhv+evxhHsnvV5PI7FVKvMOJniVTXfo2YM7vCwPvzsD0xHOY4F1fHXu5QD62fN
         ZBJ6b9SISTPvahQ6jEwER9KhcRlmKE2lxM5hs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Kt5pEDKbD4Ejy4OQ79kdehgCiOfDD9y9opBW04TZG9lSNzR9zX2mmMn/faGuc99gWv
         5Q3tbKsCuPNvNZf6VzSMo4OVyzPGwEsb3V/WVDe+0xFsbL0WMsIiTvf68m0JbzhtHrRk
         wPg5/ZGDGwyxvSCCx4+UVfJHeH1lS0GcRJGjQ=
Received: by 10.86.70.11 with SMTP id s11mr722010fga.79.1216897137792;
        Thu, 24 Jul 2008 03:58:57 -0700 (PDT)
Received: by 10.86.91.2 with HTTP; Thu, 24 Jul 2008 03:58:57 -0700 (PDT)
In-Reply-To: <m3tzefvd3q.fsf@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89865>

On 7/24/08, Jakub Narebski <jnareb@gmail.com> wrote:
>  Second, I think you can simply special case .git* files (.gitignore,
>  .gitattributes, .gitmodules), and always check them out for all
>  intermediate directories (unless configured otherwise, of course).
>  So for example if you have the following directory structure:
>
>   A/.gitignore
>   A/a
>   A/B1/.gitignore
>   A/B1/b
>   A/B2/.gitignore
>   A/B2/c
>
>  and you are checking out only subdirectory 'B1' (and all files in it;
>  if subdirectories are checked out recursively it depends on
>  configuration), and if for example there is .gitignore in every
>  directory, then checked out tree would look like this:
>
>   A/.gitignore
>   A/B1/.gitignore
>   A/B1/b
>
>  The ability to do this is one of advantages of 'sparse' checkout over
>  'subtree' checkout.

Or teach git to use index version of those files. Or collect all those
files, combine them and put the result to .git/info/exclude (and
similar places). Anyway well organized repos won't have this problem.

Checking some files out as read-only (like this case) may be
interesting. Though I do not how much complicated it can be.
-- 
Duy
