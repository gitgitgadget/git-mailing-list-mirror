From: Ricky Clarkson <ricky.clarkson@gmail.com>
Subject: Re: I've been pushing to one branch from both git-svn and git
Date: Wed, 5 May 2010 10:09:58 +0100
Message-ID: <m2q7eeb06461005050209jee92b415v68d8918f13d3a406@mail.gmail.com>
References: <z2h7eeb06461005040443ib2fb7405i39e7d5b4220bfb08@mail.gmail.com> 
	<w2s32541b131005040934o339e3e79vf386427ed282ce64@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 05 11:12:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with smtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9aeJ-0001w6-Eq
	for gcvg-git-2@lo.gmane.org; Wed, 05 May 2010 11:12:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757255Ab0EEJKW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 May 2010 05:10:22 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:53797 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755064Ab0EEJKV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 May 2010 05:10:21 -0400
Received: by fxm10 with SMTP id 10so4011471fxm.19
        for <git@vger.kernel.org>; Wed, 05 May 2010 02:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=KCmxPJbfvnGmw0ay1EnKEn7AwmfnTUbcZziWZGIozys=;
        b=Hsn+0830hhKKv6fqgFT+hR7Ih4PGRCcZyXRZbKRsA21tzzZngH19HbdzhNQ7peUAfx
         boSRnvC+3ip21FxDK57CpB9/SkEkKO5KMAp/Kn8s/R7CglJsH+qLA+mfBnlmFoXpzebW
         3ykmRxs2SxieorfJg87VWZ7P+EXIgkJwfs5CY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Rc9BtfqF12+GH+qysFllCXc3sZ6ZcneovDn6kzP55aZSdtWxnPLtlpvAa8j6CBvMgl
         ld2quvCK0Aeanu9PacoJ8a7O7t2h4VjMsJ7b330zpItRHZeRO8DuAj2LDF/Rq5gEZBQq
         uX7R9izjpDoMfbsn+ddCtm5RR1ZHxOFavhyWg=
Received: by 10.223.99.156 with SMTP id u28mr5038148fan.53.1273050618423; Wed, 
	05 May 2010 02:10:18 -0700 (PDT)
Received: by 10.223.126.3 with HTTP; Wed, 5 May 2010 02:09:58 -0700 (PDT)
In-Reply-To: <w2s32541b131005040934o339e3e79vf386427ed282ce64@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146384>

Hi Avery,

Thanks.  I solved it a slightly different but hopefully equivalent way:

Create a new branch named master locally, and merge the changes from
trunk into it (I don't think any merge was needed as it would be a
copy of trunk).  Push master.  From the git svn repo, git push -f
origin, then git pull in the local repo and git merge trunk (the
current branch is master).

Ricky.

--
Ricky Clarkson
Java and Scala Programmer, AD Holdings
+44 1928 706373
Skype: ricky_clarkson
Google Talk: ricky.clarkson@gmail.com
Google Wave: ricky.clarkson@googlewave.com



On 4 May 2010 17:34, Avery Pennarun <apenwarr@gmail.com> wrote:
> On Tue, May 4, 2010 at 7:43 AM, Ricky Clarkson <ricky.clarkson@gmail.=
com> wrote:
>> I have a git repository we'll call the git svn repo, in which I only
>> perform git svn fetch and git push bare.
>>
>> bare is a bare git repository, which I push to from a local
>> repository. =C2=A0The mistake I've been making is to push to the bra=
nch
>> 'trunk' in bare, from my local repository. =C2=A0The reason this is =
a
>> mistake is because git push bare from the git svn repo also pushes t=
o
>> there.
>>
>> Today I've been forced to learn of my mistake, as I cannot push from
>> the git svn repo without possibly losing commits. =C2=A0It turns out=
 (which
>> is probably obvious to you all) that I should have been pushing to,
>> say, bare's 'master' branch instead of its trunk one.
>>
>> I don't intend to push back to svn from any of these repos, but I
>> would like to be able to continue pulling changes from svn at least
>> for the time being. =C2=A0What should I do?
>
> If you don't intend to push back to svn, then life is relatively simp=
le.
>
> First, on your PC where you've been making other commits, rename the
> trunk branch to master and push that:
>
> =C2=A0 git branch -m trunk master
> =C2=A0 git push bare master
>
> Then delete the 'trunk' branch on bare, and re-push it from the git s=
vn repo:
>
> =C2=A0 git push bare :trunk
> =C2=A0 git push bare trunk
>
> And probably you'll go back to your PC and merge the latest trunk int=
o
> your master:
>
> =C2=A0 git pull bare trunk
> =C2=A0 =C2=A0 # resolve any conflicts
> =C2=A0 git push bare master
>
> Have fun,
>
> Avery
>
