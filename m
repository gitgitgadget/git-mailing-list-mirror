From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/2] Add a section to the users manual documenting shallow clones.
Date: Mon, 21 Dec 2015 22:47:16 -0500
Message-ID: <CAPig+cQOAGzQMj5oNMEsD0u7Wqj80kyyYcOwi-Y0q1yHtX4s4A@mail.gmail.com>
References: <1450750180-1811-1-git-send-email-ischis2@cox.net>
	<1450750180-1811-2-git-send-email-ischis2@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: "Stephen P. Smith" <ischis2@cox.net>
X-From: git-owner@vger.kernel.org Tue Dec 22 04:47:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBDv0-0008UJ-LI
	for gcvg-git-2@plane.gmane.org; Tue, 22 Dec 2015 04:47:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752497AbbLVDrS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Dec 2015 22:47:18 -0500
Received: from mail-vk0-f53.google.com ([209.85.213.53]:35612 "EHLO
	mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751585AbbLVDrR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Dec 2015 22:47:17 -0500
Received: by mail-vk0-f53.google.com with SMTP id a189so111575471vkh.2
        for <git@vger.kernel.org>; Mon, 21 Dec 2015 19:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=IxCfrIzkupIxXSrI/Km1S+cvfv6Y5iKAwwJyD+7Z7+0=;
        b=SzytNKfDkL4/iEB5nnTSUYNy1BhnYWS6jBQSPqouG/hl2Nuc0XmEU7Wh4zbEXKHOtY
         whGPjOzHGoS66JsuF1+9OWdPrp1c1DuOXaI4znFqhRcZXbTys98PY8GHcBjMG1lU+cOz
         oXzx/w13R6BgTm8bmkZ5kJluoIZaViCN/+lyir+ljiWnEdvbC1UCIdgukVeg2KmDLSqR
         i8m5gybP5Oq0ZO3uq7lt/cVCPWeRkWfEDkG2rxswxvzrb4kNzRjIHDA/Fn+hSf6Mf9oq
         Q0UHWZ/kxpV1gti+E8ksQYuavajqCNVxBT4nAMBuNvEHrhNLMo4dhJL2D+GI1eCqbeU7
         8XYg==
X-Received: by 10.31.13.205 with SMTP id 196mr14501172vkn.37.1450756036694;
 Mon, 21 Dec 2015 19:47:16 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Mon, 21 Dec 2015 19:47:16 -0800 (PST)
In-Reply-To: <1450750180-1811-2-git-send-email-ischis2@cox.net>
X-Google-Sender-Auth: UUiJk2OihlR69AV2l7BW6KtBiMc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282831>

On Mon, Dec 21, 2015 at 9:09 PM, Stephen P. Smith <ischis2@cox.net> wrote:
> Add a section to the users manual documenting shallow clones.

For the subject, prefix by section/module you're touching; drop
capitalization; drop full-stop (period).

> The todo section previously noted that documentation of shallow clones
> was not in the manual and had references to the 1.5.0 release notes.
>
> The patch adds a section to the manual and removes the entry in the
> ToDo list.

You might want to switch these two sentences around and drop
unnecessary "the patch" and "previously", etc. In fact, you don't even
need to mention removing the entry from the to-do list since that's a
natural byproduct of the change. Also write in imperative mood. So,
the full commit message might say something like this:

    user-manual: document shallow clones

    Rather than merely pointing readers at the 1.5 release notes to
    learn about shallow clones, document them formally.

> Signed-off-by: Stephen P. Smith <ischis2@cox.net>
> ---
> diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
> @@ -39,7 +39,6 @@ without any explanation.
>  Finally, see <<todo>> for ways that you can help make this manual more
>  complete.
>
> -

You typically should avoid sneaking in changes unrelated to the stated
purpose of the patch, even minor whitespace changes like this one
since such changes are distracting noise. If this was the only such
double-spaced line anomaly, then perhaps it would be okay, however,
there are a number of other such double-spaced line anomalies
throughout the file, so it doesn't make sense to fix only this one. If
*might*, however, make sense to fix all of them as a preparatory
cleanup patch which does only cleanups, and nothing else.

>  [[repositories-and-branches]]
>  Repositories and Branches
>  =========================
> @@ -72,6 +71,25 @@ called the <<def_working_tree,working tree>>, together with a special
>  top-level directory named `.git`, which contains all the information
>  about the history of the project.
>
> +[[how-to-get-a-git-repository-with-minimal-history]]
> +How to get a Git repository with minimal history
> +------------------------------------------------

Is this a good placement for this topic? Shallow repositories are not
heavily used, yet this placement amidst the very early and important
topics of cloning and checking out branches assigns potentially
significant (and perhaps unwarranted) weight to something used so
rarely.

> +Sometimes there is a need to view recent history or send email patches
> +for a project with lots of history.

This justification reads weakly since you can view recent history or
send patches even with full history. Perhaps you meant to say that
that there are times when one has an interest in *only* recent
history, and downloading and storing the full history would be
*wasteful* or *painful* or something.

> In such cases a <<def_shallow_clone,shallow
> +clone>> can be used to create a <<def_shallow_repository,shallow
> +repository>>.

This reads a bit oddly, as if "shallow clone" is some sort of entity
from which a "shallow repository" can be derived, rather than "shallow
clone" being a particular invocation of the git-clone command.

It also might be helpful to borrow some of the terminology from the
1.5.0 release notes when describing a shallow clone/repository. In
particular, its mention of "truncated history" may be valuable for
people to understand the concept.

> +A <<def_shallow_clone,shallow clone>> is created by specifying the
> +depth when creating a clone of a repository using the
> +linkgit:git-clone[1] --depth switch.

Backquote the switch: `--depth`. Ditto below.

> The depth can later be changed
> +by using the linkgit:git-fetch[1] --depth switch.

Does the --unshallow switch also merit mention?

> +------------------------------------------------
> +       # the Linux kernel:
> +$ git clone --depth=20 git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> +------------------------------------------------

I realize that you copied the indentation of the comment line from the
very first example block in the file, however, none of the other
examples follow suit. In other cases, the comment is flush-left.

More importantly, however, this comment adds no useful information to
the example, thus probably ought to be dropped.

>  [[how-to-check-out]]
>  How to check out a different version of a project
>  -------------------------------------------------
> @@ -4645,9 +4663,6 @@ standard end-of-chapter section?
>
>  Include cross-references to the glossary, where appropriate.
>
> -Document shallow clones?  See draft 1.5.0 release notes for some
> -documentation.
> -
>  Add a section on working with other version control systems, including
>  CVS, Subversion, and just imports of series of release tarballs.
>
> --
> 2.6.3.368.gf34be46
