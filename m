From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git mergetool
Date: Sat, 17 May 2008 13:21:10 -0700 (PDT)
Message-ID: <m3tzgw4r7w.fsf@localhost.localdomain>
References: <b6840c770805171021g63df7d0dm4532655ed49209bc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, tytso@mit.edu
To: Evgeny <evgeny.zislis@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 17 22:22:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JxSut-00033h-UR
	for gcvg-git-2@gmane.org; Sat, 17 May 2008 22:22:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758742AbYEQUVS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 May 2008 16:21:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758690AbYEQUVR
	(ORCPT <rfc822;git-outgoing>); Sat, 17 May 2008 16:21:17 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:53100 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758601AbYEQUVQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 May 2008 16:21:16 -0400
Received: by ug-out-1314.google.com with SMTP id h2so164394ugf.16
        for <git@vger.kernel.org>; Sat, 17 May 2008 13:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=6/QcSHIcdbmoEj5YzC/CYEZa9qaHn2VVgud81u44+Wk=;
        b=SSNBIIblC2/y/fhc1xQDMFuxWgZpZAiF382hPRXzGKxOSqglYQtB4jXvg2M5fsOHA2kJQot2cWjXU4lpYVEH0mnFMH24DvCnpAkWxrC0eWzTgTZ6vr9SIux0Mbi73ZPsRBudAzlP2r7xQtchWPKj1YEn8a19CAjMmMF5VE++4r4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=Y7seWJZwXstVyP7nidxFtvtH+5TJrEIqFygPv4Bcc8YuE5K+4TY2JP3qzAnjUViMLZeXpZzkzbIX2pkzwaFRukzouSG6Pqie7fHIaFPDIyvGLOq8oWD7nIoNL6SVMB7DPjcWRC9qgohREta7Df7250DbsxfVE97QmzVFAxbDzB4=
Received: by 10.67.119.8 with SMTP id w8mr1416650ugm.34.1211055671942;
        Sat, 17 May 2008 13:21:11 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.254.121])
        by mx.google.com with ESMTPS id g11sm11222553gve.8.2008.05.17.13.21.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 17 May 2008 13:21:10 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m4HKL9af021146;
	Sat, 17 May 2008 22:21:09 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m4HKL80l021143;
	Sat, 17 May 2008 22:21:08 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <b6840c770805171021g63df7d0dm4532655ed49209bc@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82360>

Evgeny <evgeny.zislis@gmail.com> writes:

> Background:
>    I am trying to use a custom mergetool with git.
>    P4Merge from http://www.perforce.com/perforce/products/merge.html
> 
>    The documentation explains that environment variables 
>    $BASE, $LOCAL, $REMOTE, $MERGED
>    are set for the invocation of the mergetool command.
> 
> Problem:
>    I wrote a wrapper for P4Merge, and I check for these environment
>    variables - but they are not there.   After a closer inspection
>    of git-mergetool I see that infact these variables are not being
>    sent to the external command at all, and are just in the context
>    of the git-mergetool script.

>From what I know of git-mergetool, you can use one of the predefined
merge tools: kdiff3, tkdiff, meld, xxdiff, emerge, vimdiff, gvimdiff,
ecmerge, and opendiff (optionally providing path to the tool)

To add support for P4Merge you would have either modify
git-mergetool.sh (and, optionally, send a patch to git mailing list),
or make use of `mergetool.<tool>.cmd` configuration option.
Unfortunately there is no example...

-- 
Jakub Narebski
Poland
ShadeHawk on #git
