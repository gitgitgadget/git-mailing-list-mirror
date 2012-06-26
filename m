From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: Re: Master and origin/master diverged
Date: Mon, 25 Jun 2012 19:49:18 -0700
Message-ID: <CAE1pOi24EVq__XzxtBoAryzQ+F=sAy8-hY23M-P4YoQFXdpSSw@mail.gmail.com>
References: <CAE1pOi1Ot0Fyv=2_XYKyUcsKp-m+CkT-miF=jC=wt9Rbz_dXqQ@mail.gmail.com>
 <4FE4C0F7.2080309@gmail.com> <CAE1pOi2MN_c76UBeRzdRbU8s+0LzYVoVcJ13V0di=HQobj+aDg@mail.gmail.com>
 <4FE50411.8080800@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Users <git@vger.kernel.org>
To: Neal Kreitzinger <nkreitzinger@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 26 04:51:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjLr7-0007Gd-Ff
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jun 2012 04:51:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756373Ab2FZCtk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Jun 2012 22:49:40 -0400
Received: from mail-yw0-f51.google.com ([209.85.213.51]:36157 "EHLO
	mail-yw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755736Ab2FZCtj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jun 2012 22:49:39 -0400
Received: by yhnn12 with SMTP id n12so4047129yhn.10
        for <git@vger.kernel.org>; Mon, 25 Jun 2012 19:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=DT+z2W+CPj8ZXYpwRy8la46T4LHwXzcCX9Aq/czspZQ=;
        b=xebK2fFiOxd7gztKNI6HdZCtULiVtz0jItKOnk5Cu6gdkAJCn5cObhLZXQlxSUsW6+
         9exurh8GqLE3Mk17RSBnMjyuZ5I9YKS9QWH/sQzKyD4vGm2oUVK3gXPSf0qdthtWvZq6
         vPpXNja/WrcEqkUEYSp6yaCmmZh8qG1joHHyHR22G3cMF2SAheEbTxHsn7i/YtJO3IW3
         t+TzHfWDoWKyWHnRGLtNYW9btjNCaw95Q9Q/CWvud0oIZWiVPceEZ3CfTR1UNrAnzhN8
         Rxy9RjGN0io2iTJpi5Yzj54gfUi7rpeKSSqwlXiH9gjwUp+dkD0vV5JYEHqyts0OnBJt
         QkXQ==
Received: by 10.236.185.198 with SMTP id u46mr16063598yhm.33.1340678978442;
 Mon, 25 Jun 2012 19:49:38 -0700 (PDT)
Received: by 10.236.29.230 with HTTP; Mon, 25 Jun 2012 19:49:18 -0700 (PDT)
In-Reply-To: <4FE50411.8080800@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200621>

On 22 June 2012 16:47, Neal Kreitzinger <nkreitzinger@gmail.com> wrote:
> On 6/22/2012 3:18 PM, Hilco Wijbenga wrote:
>>
>>
>> On 22 June 2012 12:01, Neal Kreitzinger <nkreitzinger@gmail.com> wro=
te:
>>>
>>> On 6/22/2012 12:53 PM, Hilco Wijbenga wrote:
>>>>
>>>>
>>>> One of my developers managed to push something that somehow "diver=
ged"
>>>> origin/master from everyone else's local master.
>>>>
>>>> A --> B --> C --> D (everybody's local master)
>>>> |
>>>> \--> B' --> C' --> D' --> E (origin/master)
>>>>
>>>> (i.e., A is the commit where things diverged; everyone's local mas=
ter
>>>> points to D but the new commit (E) that was pushed to origin/maste=
r
>>>> uses different SHA1s for B, C, and D)...
>>>>
>>>>
>>>> Now running git pull creates a merge commit joining D and E.
>>>>
>>>> ...Does anyone have any idea as to what might have happened? Perha=
ps if
>>>> I
>>>>
>>>> understand how this happened I might be able to prevent it from
>>>> happening again.
>>>>
>>> Some ways you can prevent it from happening again:
>>
>>
>>> (2) have your devs do git pull --ff-only
>>
>>
>> Is this something that can be set in git config? I looked but didn't
>> see anything obvious.
>
>
> OTTOMH, you could change the git fetch config for master and take awa=
y the
> leading '+' sign which would not allow non-fastforward fetches of mas=
ter.
> =C2=A0That in turn would prevent merging such a non-ff remote trackin=
g branch of
> master into your branch master.
>
>
> Actually, I guess what I really want is
>>
>> something for git push, right?
>>
> Some ways to do it:
> (1) I think you could have rebase and commit hooks locally that preve=
nt
> someone from rewriting history on master. =C2=A0That in turn would pr=
event
> someone from pushing a rewritten history.

Yes, I have been thinking about that.

How does one create "portable" hooks? I have to deal with GNU/Linux,
OS X, and MS Windows. We all have Java installed so I first thought of
using JGit but I am not clear on how well JGit supports using it in a
hooks. Should I make Ruby a required part of the dev environment and
use Ruby hooks?

> (2) When merging topic branches to master use git merge --ff-only. =C2=
=A0Then
> when you push it to remote master you know it's a fastforward and not=
 a
> history rewrite.

Given how hard it is to teach devs to only push fast-forward merges, I
am not sure how well this would work.
