From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-ls-files -l
Date: Tue, 30 Dec 2008 03:01:06 -0800 (PST)
Message-ID: <m3wsdiaptg.fsf@localhost.localdomain>
References: <87abae6hbn.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: jidanni@jidanni.org
X-From: git-owner@vger.kernel.org Tue Dec 30 12:02:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHcMr-0003K5-90
	for gcvg-git-2@gmane.org; Tue, 30 Dec 2008 12:02:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751870AbYL3LBL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2008 06:01:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751813AbYL3LBK
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Dec 2008 06:01:10 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:52252 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751738AbYL3LBJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2008 06:01:09 -0500
Received: by nf-out-0910.google.com with SMTP id d3so635055nfc.21
        for <git@vger.kernel.org>; Tue, 30 Dec 2008 03:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=opfUl2WPC1mMkzpJkh34uqowUnRT3x9lcoU/JidpqVM=;
        b=wWsnqPrSnyHSg02+Tyt+J55wvRWRFdzeHrFlRuH01WH+9SrRtkhhoFOsX9bW6Vv4fC
         54brw0Dgdc9ZDx/Xm5QeEQIVQY6ANczFzNsD1AEHIb54vjr+Z9KYiLl2M+s7xd++mfa5
         Io0xdCG8X1KvlFzVzaF1w3WdZ3+0VMZyMKBUI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=uZZJHxfcZiJScqGPlaJ7UbSUWqC6B8+zd2Ywi7h+NR4VvMGmJ1sS9ad0asXGlCpDAP
         wO7FBDz/LKgg52zNcy2sOXmaYgPsmV78m+eZTAmAw51DkJUkfW90LRf4SHYVIAHay2RW
         PtiYcU7k24gHoucJ2u3jru3A6RnINZ4FHPTxA=
Received: by 10.210.35.10 with SMTP id i10mr5140340ebi.86.1230634867206;
        Tue, 30 Dec 2008 03:01:07 -0800 (PST)
Received: from localhost.localdomain (abwi200.neoplus.adsl.tpnet.pl [83.8.232.200])
        by mx.google.com with ESMTPS id 23sm2850453eya.53.2008.12.30.03.01.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 30 Dec 2008 03:01:06 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id mBUB2bOW024422;
	Tue, 30 Dec 2008 12:02:37 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id mBUB2ZiO024419;
	Tue, 30 Dec 2008 12:02:36 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <87abae6hbn.fsf@jidanni.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104172>

jidanni@jidanni.org writes:

> Beginners, finding git-ls-files acts like ls,
> are baffled as to why they can't go on to ls -l.
> 
> The git-ls-files man page should reveal the secret of how also to see
> file sizes. Perhaps the closest one can get is
> $ git-ls-tree -l --abbrev ...

git-ls-tree has the '-l' option mimicking (somewhat) "ls -l" behaviour
only because it was thought to be useful for gitweb (to have file
sizes in 'tree' view, like cgit has it), although gitweb doesn't use
it yet.

I think it would be easy to add '-l' also to git-ls-files. Please
remember to provide size only for blobs, as provoding size for trees
would make it harder to change to future packv4, where tree objects
would be stored deconstructed.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
