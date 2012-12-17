From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: [PATCH 1/2] Documentation/git-checkout.txt: clarify usage
Date: Tue, 18 Dec 2012 08:50:15 +1100
Message-ID: <CAH5451nVe1VcD3VzCO7EtKSkzv9CyJs=uqQ9MkMTJEXMTwEvmw@mail.gmail.com>
References: <1355726702-27974-1-git-send-email-chris@rorvick.com>
 <1355726702-27974-2-git-send-email-chris@rorvick.com> <7vhanlnnz7.fsf@alter.siamese.dyndns.org>
 <17103971665F4C4495C6C96086A58B8F@PhilipOakley> <7v1ueol6ut.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Philip Oakley <philipoakley@iee.org>,
	Chris Rorvick <chris@rorvick.com>,
	Git List <git@vger.kernel.org>,
	Tomas Carnecky <tomas.carnecky@gmail.com>,
	Woody Wu <narkewoody@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 17 22:50:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkiaM-0008Cd-Nr
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 22:50:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753844Ab2LQVuh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2012 16:50:37 -0500
Received: from mail-qa0-f53.google.com ([209.85.216.53]:47142 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750889Ab2LQVug (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2012 16:50:36 -0500
Received: by mail-qa0-f53.google.com with SMTP id a19so55279qad.19
        for <git@vger.kernel.org>; Mon, 17 Dec 2012 13:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=JJH4CezZR01ptdneiMoVJJbKL4WuWFuHMY3qpg8GZXE=;
        b=BmpJsISgjri5PG4QJGm3O2Eu2xYbTmJpNpHeM0TPmhB3zZDqRrkrEov0Ax0AXgbs7u
         SgIry1jhTBXkc4vuCO+C5Wi99pTOHR64aPC15l+6m4WZcWve+cywc4THB3jbgbByZLIy
         EURRqx80Xpka1om5EwbmkdCJKdeQuZsY266bw10qQl2DucyWcxN25kXsL24Y3sMnoB5B
         YTFS0cVaJVT1bdjyxoll0ImGF/BiXc5y+9PCZji0WRPL5X8a/l3ESgcceA0RQj92DtDc
         SYHNcdi3tr5DRlNs7IZEB1+O7LnT9l7zGChgtBDPWZPWUbypCDUeQAGpDLLIcdwppf8T
         JWow==
Received: by 10.49.48.104 with SMTP id k8mr7972862qen.49.1355781035381; Mon,
 17 Dec 2012 13:50:35 -0800 (PST)
Received: by 10.49.14.3 with HTTP; Mon, 17 Dec 2012 13:50:15 -0800 (PST)
In-Reply-To: <7v1ueol6ut.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211707>

On 18 December 2012 08:13, Junio C Hamano <gitster@pobox.com> wrote:
> "Philip Oakley" <philipoakley@iee.org> writes:
>
>> From: "Junio C Hamano" <gitster@pobox.com> Sent: Monday, December 17,
>>> This is to "check out the branch" ;-)
>>> ...
>>
>> From a user perspective it's better to refer to the working directory
>> first rather than the internal mechanics.
>>
>>    Prepare to work on <branch>, by updating the files in the
>>    working tree and index to the branch's previous content, and
>>    pointing HEAD to it.
>
> I agree that the mention of "pointing HEAD to" may be better to be
> rephrased in the user facing terms.
>
> Because the primary purpose of "git checkout <branch>" is to "check
> out the branch so that further work is done on that branch", that
> aspect of the behaviour should be mentioned first.  Updating of the
> working tree files and the index is the implemenation detail of
> starting to work on that branch.

Even if the primary purpose of "git checkout <branch>" is to "check
out the branch so that further work is done on that branch", I don't
believe that means it has to be stated first. In fact, I would say
that there are enough other use cases that the language should be
slightly more use-case agnostic in the first situation. For example,
someone might switch to another branch or commit simply to see what
state the tree was in at that point. Some people use checkout to
deploy a tag of the working tree onto a production server. The first
example in particular is, I think, a common enough operation that
restricting the opening lines of documentation to talking about
building further work is misleading.

My earlier submission dealt with this by using the 'Switch to the
specified ...' terminology. For me this is implicitly stating 'Switch
the state of the repository to be the same as the specified ...' but
perhaps it would do to be more explicit? I prefer the shorter form
myself.

By following this with the typical use case it makes it clear what the
intended use of the command is, and some idea about the mechanics of
its function.

I realised that my signature was improperly placed when I submitted my
suggestion last, so I will include it here as reference for anyone who
skipped over it. It builds on top of the two original patches.

Regards,

Andrew Ardill

-->8--

From: Andrew Ardill <andrew.ardill@gmail.com>
Date: Mon, 17 Dec 2012 18:53:41 +1100
Subject: [PATCH] Documentation/git-checkout.txt: Use consistent terminology

git checkout is described as 'switching' branches in places. Use this
terminology more consistently.

Expand on the purpose of switching to a branch or commit, which is
typically to prepare to build history on top of that branch or commit.

Signed-off-by: Andrew Ardill <andrew.ardill@gmail.com>
---
 Documentation/git-checkout.txt | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index db89cf7..e6db14f 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -23,8 +23,11 @@ branch.

 'git checkout' [<branch>]::

-       Update the index, working tree, and HEAD to reflect the
-       specified branch.
+       Switch to the specified <branch>. Prepares for building new
+       history on <branch>, by updating the index and the files in the
+       working tree, and by pointing HEAD at the branch. Local
+       modifications to the files in the working tree are kept, so that
+       they can be committed on the <branch>.
 +
 If <branch> is not found but there does exist a tracking branch in
 exactly one remote (call it <remote>) with a matching name, treat as
@@ -56,10 +59,13 @@ successful.

 'git checkout' [--detach] [<commit>]::

-       Update the index and working tree to reflect the specified
-       commit and set HEAD to point directly to <commit> (see
-       "DETACHED HEAD" section.)  Passing `--detach` forces this
-       behavior even if <commit> is a branch.
+       Switch to the specified <commit>. Prepares for building new
+       history on top of <commit>, by updating the index and the files
+       in the working tree, and by pointing HEAD at <commit>. Local
+       modifications to the files in the working tree are kept, so that
+       they can be committed on top of <commit>. Passing `--detach`
+       forces HEAD to point directly at <commit> even if <commit> is a
+       branch (see "DETACHED HEAD" section.)

 'git checkout' [-p|--patch] [<tree-ish>] [--] <pathspec>...::

--
