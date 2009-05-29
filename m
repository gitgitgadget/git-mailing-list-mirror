From: =?ISO-8859-1?Q?Thorben_Schr=F6der?= <stillepost@gmail.com>
Subject: Re: After update to 1.6.3.1. I get this error: error: bad index file 
	sha1 signature
Date: Fri, 29 May 2009 15:09:01 +0200
Message-ID: <64fe838e0905290609i7e8e1e87o2bb4100f9bd5cfcf@mail.gmail.com>
References: <64fe838e0905290025h6bf2172agea4beb1ccff6dd6e@mail.gmail.com>
	 <4A1FABCC.7000808@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri May 29 15:09:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MA1pf-0005a3-Cu
	for gcvg-git-2@gmane.org; Fri, 29 May 2009 15:09:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758466AbZE2NJC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 May 2009 09:09:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758309AbZE2NJB
	(ORCPT <rfc822;git-outgoing>); Fri, 29 May 2009 09:09:01 -0400
Received: from mail-bw0-f222.google.com ([209.85.218.222]:45400 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755776AbZE2NJA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 May 2009 09:09:00 -0400
Received: by bwz22 with SMTP id 22so6116066bwz.37
        for <git@vger.kernel.org>; Fri, 29 May 2009 06:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=n+VV4/v5ekhGMzU1uOuKkpW/15csOZq1MSHmDHQkO0A=;
        b=s1fGzXdFIMlj3bZTmjfkcXOQtodObfaMYNPTN7oAzblHFYRMG0XGtExuP7S1OnFQRI
         FO8wQlvSvvU6a2AQ+iedq4Fxh8e9vD/OujjoY0Jfwzd6/19qGBH6WDu89lmMX1WHsQRF
         rlYRuNW1sgg/5j58y4r2qKuJIkNiWpNTIeSqI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=cSDD9c+tilRDd/XtN/E8+wAuN8BkS2JxHv2qSFpejWCsjfcvW32cPc7AFr6nYZph5p
         Sm6WbWkeRY+rg//545yEyzox4YDjPyCobyH/T3TQNua26D9xVoRZixyvNXS2exDLmYac
         edukAI752Ukq2pbz0fl8yk3MMOp65G94RYZ9g=
Received: by 10.223.111.134 with SMTP id s6mr2046539fap.37.1243602541361; Fri, 
	29 May 2009 06:09:01 -0700 (PDT)
In-Reply-To: <4A1FABCC.7000808@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120276>

This does the trick for me but only with the result to get an other
error on any pull or clone:

E.g. when I do git pull:
remote: Counting objects: 575, done.
remote: Compressing objects: 100% (260/260), done.
remote: Total 384 (delta 157), reused 0 (delta 0)
Receiving objects: 100% (384/384), 41.48 KiB, done.
fatal: pack is corrupted (SHA1 mismatch)
fatal: index-pack failed

:/ I had this problem before and could solve it with recompiling
OpenSSL and then recompiling git pointing to that new compiled OpenSSL
lib. I've tried this again but it didn't help.

Any idea? Would be so great!

Thorben

2009/5/29 Johannes Sixt <j.sixt@viscovery.net>:
> Thorben Schr=F6der schrieb:
>> I've recently updated from 1.6.1.2 to 1.6.3.1 on OS X. And after tha=
t
>> transition I get this:
>>
>> =A0 error: bad index file sha1 signature
>> =A0 fatal: index file corrupt
>>
>> on any git command I invoke in any of my repositories. I even tried =
to
>> go back to 1.6.1.2 but the error still occurs.
>>
>> Is there any thing I can do to fix this? Would be great, otherwise a=
ll
>> my local repositories are busted :/
>
> In one of your less important repositories you can try:
>
> =A0 $ mv .git/index .git/index.prev
> =A0 $ git reset
>
> This reconstructs the index file from the HEAD commit. You loose only=
 what
> you might have staged for the next commit, but otherwise this will ne=
ither
> change you repostitory nor your working directory.
>
> You can keep .git/index.prev around for a while; perhaps someone from=
 this
> list wants it for more diagnoses.
>
> As to why this happened, I don't know, but it's certainly interesting=
=2E
>
> -- Hannes
>
>
