From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: [PATCH 1/2] Documentation/git-checkout.txt: clarify usage
Date: Mon, 17 Dec 2012 19:53:19 +1100
Message-ID: <CAH5451=U47Aastune7==e67nK9X4A9khdtZvKzhpwkC-eR=o8A@mail.gmail.com>
References: <1355726702-27974-1-git-send-email-chris@rorvick.com>
 <1355726702-27974-2-git-send-email-chris@rorvick.com> <7vhanlnnz7.fsf@alter.siamese.dyndns.org>
 <50CED5D4.5040705@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Chris Rorvick <chris@rorvick.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Tomas Carnecky <tomas.carnecky@gmail.com>,
	Woody Wu <narkewoody@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Dec 17 09:53:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkWSU-0005l8-C1
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 09:53:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751884Ab2LQIxl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2012 03:53:41 -0500
Received: from mail-qa0-f53.google.com ([209.85.216.53]:59403 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751674Ab2LQIxk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2012 03:53:40 -0500
Received: by mail-qa0-f53.google.com with SMTP id a19so2141384qad.19
        for <git@vger.kernel.org>; Mon, 17 Dec 2012 00:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=k+HUq3XQNigpXLxLvFfvBnPsDDQiUQViCLLlcV2xQYk=;
        b=RhrWzH1sQvSqAkarQqgL7kYNSSR4lWNX4u9SStWUmTDMdsHRbL1ySd4+nywTPWI3PG
         ekb9A94esUxM6gtaLK/7qgGAPebYdBpUF73Kv/6Ks4pgjVRGQg6UxHMPCHE7Pqyqixwm
         5EUs4JHkjxkkbWtOukeQxmzG/7IHW5q4JHKguZng6JE2vEEQWGjRuX23j0gyrfXDl8qa
         VUUL/d9opO5JGFdZRFLdtkmXiUqtwZH8dMqS1BECU2bTpaxUMrN7yDYq25I9A9tPl741
         H2LvJpZnhxuqdCDC72fyYNY/adalpKME/BysqDlQgelpYZ8g9J1zpiaFU1VokUQ+mnuF
         NzPA==
Received: by 10.49.48.104 with SMTP id k8mr6835414qen.49.1355734419592; Mon,
 17 Dec 2012 00:53:39 -0800 (PST)
Received: by 10.49.14.3 with HTTP; Mon, 17 Dec 2012 00:53:19 -0800 (PST)
In-Reply-To: <50CED5D4.5040705@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211662>

Regards,

Andrew Ardill


On 17 December 2012 19:20, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Am 12/17/2012 8:21, schrieb Junio C Hamano:
>> Chris Rorvick <chris@rorvick.com> writes:
>>>  'git checkout' [<branch>]::
>
> Is <branch> really optional in this form?
>
> BTW, what does plain 'git checkout' do? Just report ahead/behind information?

I think it defaults to either HEAD or the current branch, which shows
uncommitted changes and relationship to upstream.

>>> +
>>> +    Update the index, working tree, and HEAD to reflect the
>>> +    specified branch.
> ...
>>> +'git checkout' [--detach] [<commit>]::
>
> The title here is better spelled as two lines:
>
> 'git checkout' <commit>::
> 'git checkout' --detach <branch>::
>
> I don't think that <commit> or <branch> should be indicated as optional here.

doing 'git checkout --detach' will detach from the current branch if
you have one, but maybe listing <branch> as optional would work in
that case?


Here is my suggestion, differing from what Junio put forward primarily
by first indicating that a checkout is a 'switch' to a different
branch or commit. This makes sense to me, and is used elsewhere in the
documentation, so I thought it might make sense here too.

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
