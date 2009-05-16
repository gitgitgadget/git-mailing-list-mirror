From: John Tapsell <johnflux@gmail.com>
Subject: Re: git svn rebase problem
Date: Sat, 16 May 2009 06:52:08 +0300
Message-ID: <43d8ce650905152052w351f7766p3f7a4528c714c049@mail.gmail.com>
References: <4A0DDCC5.4010001@dlasys.net>
	 <32541b130905151653u436f3c5cwcf1d896c96148efa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "David H. Lynch J.r" <ml@dlasys.net>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 16 05:55:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5Azf-0005Yq-QA
	for gcvg-git-2@gmane.org; Sat, 16 May 2009 05:55:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755396AbZEPDwL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 May 2009 23:52:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754622AbZEPDwJ
	(ORCPT <rfc822;git-outgoing>); Fri, 15 May 2009 23:52:09 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:19855 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752453AbZEPDwH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 May 2009 23:52:07 -0400
Received: by yw-out-2324.google.com with SMTP id 5so1312979ywb.1
        for <git@vger.kernel.org>; Fri, 15 May 2009 20:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=WdHOAycVGv0PZGSjlPyQlSjRVZY90TPS3fbeWJqBtSg=;
        b=Zcgh5al7x5Hzo25h6in78X7CxyN70a0DqHUG3fX+euwyGROyH06opamvBN7nerbUCT
         kcfthNj91eDJnvjKD6Hxc2+RwEycBebkqZ4asnbYz5Hx+v4ZePkYe7SzwDxwcqHHRRXT
         C5awSVi9uVvv0DIDvBBFMQHpBksCOu0i0jNuc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=DYEJq3pAUYrG34mBYS9/wnmWvlcrTV1zKz2k+HbyJViDA6d8AzhfjDvqhBXvy+/iJT
         rXfi5t1X9mHJ8S+Tk+EXFBQOS62WIKZWQozIA73PbONCrVkIrQsHhYZBP40rdwxphBYx
         ru+ohs7fzLRcwgoq1ZxkK66aPsJrRTm+m7Vxo=
Received: by 10.151.135.12 with SMTP id m12mr7388288ybn.70.1242445928748; Fri, 
	15 May 2009 20:52:08 -0700 (PDT)
In-Reply-To: <32541b130905151653u436f3c5cwcf1d896c96148efa@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119321>

2009/5/16 Avery Pennarun <apenwarr@gmail.com>:
> On Fri, May 15, 2009 at 5:21 PM, David H. Lynch J.r <ml@dlasys.net> w=
rote:
>> A few days ago I did an
>> git svn rebase
>>
>> The rebase took a while and after it completed reported
>> fatal: bad object HEAD

We had this come up about once a week when using http as the
transport.  After switching most people over to ssh the problems
disappeared.  We never managed to find out why.

>> git status reports
>> root@hp-dhlii:/usr/src/pico/git# git status
>> # Not currently on any branch.
>> fatal: bad object HEAD
>>
>> and git fsck reports
>> root@hp-dhlii:/usr/src/pico/git# git fsck
>> dangling blob eb3afb4aa3aaf0003bac601a5db4fd76aafa2a87
>> dangling commit 5c496db25007c17c325f294bb8324097c9bc407d
>>
>> How can I recover without downloading the entire repository again wh=
ich
>> could take days?
>
> I don't know how this would happen; it would be great if you could
> find reproduction steps and send them in, or if you had the complete
> git rebase log, some of which probably explains the problem.
>
> You can probably recover your pre-rebased repository using 'git
> reflog'. =C2=A0Look through the reflog to find the commit you want, t=
hen do
> something like
>
> =C2=A0 =C2=A0git checkout whatever-the-commit-id-was-that-you-got-fro=
m-git-reflog
>
> and then optionally
>
> =C2=A0 =C2=A0git checkout -b master
>
> Good luck.
>
> Avery
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
