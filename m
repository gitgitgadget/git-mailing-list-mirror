Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792421755;
	b=ouhdAWP8UJj1gx5pfos4mjLYAGv5pBVk7h6TCz1AJTrP58dslCfmkyOc4O06u80ACqjx
	 rQMmUCJRRxJTLuPOgttQQ6OamT55UlZgpVLqPJLxV0GXgA4mXEOJg+3gfz7ayQPNch5Rd
	 k4/5P33QFwFDTd/1BuJ9bU5F/OGKr97VMZ1S+fUBzMoT/Jin+C/S3Ft4T/5faVzLnpVAV
	 v73k13BtSHovk+WuyutemkTYHh5y0d7e7TZBsDC+0sp/6BMpKW2pdY2U8dO/sQ8bFR0dm
	 uKOubaUvjD630VxHXPlx/hsajc+hj7AI8Bq2OEMRL5g6HPogLLogvwVqACAne2Qd81Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792421755;
	h=Received:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=9N3e2Ama5SUIJZjGmrvW7jU7CKe676JHEry5/cIX2Sw=;
	b=oEZUzHWLB2PApzGJLbIlZfmtHkUcvX7o7RmNT6lRoChUS6FqjwVZ9YkIcqQ0Ca35alqO
	 MkX6j6wn5xmLkSKk8eJdzKGAbBm76B8ZHNNaegFfjtCIBNo7ol4ilU355pu76XzTxT3pD
	 o8qHUc0FS/uaX5U6cqa6lnjqpDMwizvGsAI/76uvwW5fn4IRPeM+nl0YWLcaCZL/MrtUG
	 pQZzb2jZGVAD9PT92pCUf3mlIRj7koWrplW3dN4EISCfU2I1N5FP5cqx9DAQw0JPeW89g
	 3fo0EHcLYL7pUNpo47pU6WmDj+xCfbxLjBY+zetqNMgsjyUUcRm/g/LTThBhrM8df7g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Q1rfnJ6D;
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
Received: from aws-us-west-2-korg-listserv-1.web.codeaurora.org (ip-10-30-226-211.us-west-2.compute.internal [10.30.226.211])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B27C60705E2
	for <git.vger.kernel.org@localhost.mlmmj>; Mon, 19 Oct 2026 14:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Q1rfnJ6D
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185136513FF
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 14:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792421754; cv=none; b=OCrti8Zob/w+jL149YWoGMLFuxg00e7KhJb+PHPZbznVP0DFx/COJ+EvFRutNKgLOe0Es8FwPelG1txDoGrmjouE45yrEneTCXXppXxzqSqtiXEUqq1mYhFxu3g8v1RvvZLdRcOtkhNr4iSBXkWP4T6RvCgLgQqZRpYYVbAkhu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792421754; c=relaxed/simple;
	bh=XeOHroAHvGYITNI8gnjR8T4ddFDINJOENCyCjBmTlZ0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=BghIH5BGFaYLce33MKDI6mtIPmncNSwTwXzyYSGysiTy7H3dmbyKa29+HupP5ucwIlNEMt+L7RgUCfvd6YrNTJIFj9Fp1qxbork+iwoUSuU8kmAhF5c5jRuUMRbIx6G5AzfghDWBtMZfe2zI7tSRePPFin16Cz5jET5TDqWxAy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q1rfnJ6D; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-846566246e8so326177a34.1
        for <git@vger.kernel.org>; Mon, 19 Oct 2026 07:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792421751; x=1793026551; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9N3e2Ama5SUIJZjGmrvW7jU7CKe676JHEry5/cIX2Sw=;
        b=Q1rfnJ6DtSk/xOQcHzE2oTkfAr/m9DDjoZQ+pCmXIsabmdlQP7vJr2fKHC9rjgLD+F
         bnDMF7ajcDWmeqkEzs2ZrIUs9OxWs79KcoX9wLfKWcrjXeScpoSY0pcTwA9K0kM7YN2l
         mPDg+PHARhKdmIBCeeh0ov2tXNuZ6JyeYAIv8UKU5OUoxXLJs2buhAXW75JyORTaWSzH
         ghGqkObGTmLlf/CSffj9fn0AnteLc4yDH/SFEDf55Tka80VU/pTYkIx9dkLAQwWQn9BN
         eKcBurlHmrc0ePfxA1MhJt0QFDLDs8gvBj7mwE9R67csUrCxShzZCR01uN+Qi17LenlZ
         hEcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792421751; x=1793026551;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9N3e2Ama5SUIJZjGmrvW7jU7CKe676JHEry5/cIX2Sw=;
        b=1EN0o1U2mtpZlXIXclKwSNY95GsOMY7qvnnVQUfrRr4Q6z0mSV0m2+YyMMrapvDOQM
         D5JMg9RyGwVjFu4Sn9DwnyU4FOa/NXbylAPjO2VlzqiuYLld5eH0IhA1dkBTaHuiYAo3
         iIn9V6LKj6IivoBWyZeJWrTtFtrY5PbVt9KB/hY+vrilcH65pbWqiUAvBtlLDm0qmt4E
         E9eWN1iT4Vu4l6eXraaSGQVnMqf47YBU5MbxByt8D387ZHHi9OGGKhSdO8jhzQwtYyVq
         sLyt+ljpOQQTHIrXgVMBS8NiC6ZX60FmknRtHRF73WD1NDCjC6mH1c3Q7ddqUmLLf2X4
         lMpA==
X-Gm-Message-State: AFq9FYKR9IC5bHswg1XTcvr+A+YaExUfFQblnZIeDkhDnMAFQ9EXTPnA
	iPQuNTyE0VqK8VKOjWAAN4jOR7fdOaQUixWZ+R1aHMrC4cXgKFTny/N2RuoHOQ==
X-Gm-Gg: AYBFou1g794XMTMgLNzIVRXWod+B0Qcm8DnHctr0e9UxFhdJQle0Ov3tUcgizWstra0
	McCwgeNDhoSbQrph3oG8VwReqA/EJaAyYtihLdsDTwxQEmXO6PgRX9uzyinxUkUD6o5t6lGDQ+b
	XlajXZeLjKj1it+7HAYqOYQH6slaW05nM8B6mjv+839GeZVDkl7GxeL4RUr1XNitPf4RAcogd4z
	GOktRt5o8/FmeAmmulhZqftnC+I0+nDfjF0GpWPbF114MiIsQMgNwShxfzPQKAMFOZ0QIIi2TYz
	xBJsuwnJNEca41xy8UAqnEcM/NaFxI6FZ/l9z9IEXWaFVUQ/ojvbsJSI17+pqeIbtgeMWthscKm
	jrUxPEvlLnJHA2OpX5sUSSiHpkQFAzwLrrng8WXMqpjdEqklsL2IBWiVN2n2CsM3zKJSy6rYD3F
	zcz/u7INbHRZTvEtUyCft0hBKQpORs1vGqnM0fZpzIOga2eNQdCDkGLhQjYSe2zETTT7BXmAAoA
	LHJ25BxoznIZg==
X-Received: by 2002:a05:6830:6aed:b0:846:5a56:a7a9 with SMTP id 46e09a7af769-8465a56a9efmr4092632a34.2.1792421750085;
        Mon, 19 Oct 2026 07:55:50 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.224.97])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-842a4a00f15sm9111272a34.8.2026.10.19.07.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 07:55:49 -0700 (PDT)
Message-Id: <pull.2248.v2.git.1792421748.gitgitgadget@gmail.com>
In-Reply-To: <pull.2248.git.1791315422.gitgitgadget@gmail.com>
References: <pull.2248.git.1791315422.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 19 Oct 2026 14:55:46 +0000
Subject: [PATCH v2 0/2] doc: add new git tutorial
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
    Julia Evans <julia@jvns.ca>

So far we've gotten 112 comments from 30ish beta testers who have tried to
learn Git for the first using this tutorial. Most of them were able to
finish it successfully. By far the most common piece of feedback was that
people want to learn more about collaboration and branching. I've written a
draft of a tutorial on branching, but this is already quite a lot of words
so definitely we can't cover it in this series.

I don't know if it's possible to get this merged quickly, but if it were I
think it would be amazing since people are so eager for a tutorial on
branching. If we spend a huge amount of time revising this I think there's a
real risk I'll run out of funding before we have time to write about
branching. Ideally I think it would be great if we could merge a "good
enough" version and then have a way on the website for users to give
feedback on it, so that we can later incorporate that feedback and
iteratively make it better over time.

Here's all the "any other feedback?" comments that people left on the
tutorial (positive and negative), just to give a feeling for the overall
sentiment. I thought it was surprising but great that several people
described the tutorial as short or quick, because there are 14 steps and the
document is a bit long. this was feedback that people left as we were making
revisions, so some of it was on previous versions of the tutorial.

"I really enjoyed the tutorial. It didn't use too many words, when not
necessary and was precise, which I find appealing. The short explanations
were insightful and just the amount of information I was looking for (e.g.
that -m stands for message). I was looking for an easy tutorial that would
stretch just a little into collaboration, which I did not find here. Since I
already started learning git now, I will try to get there myself. So maybe
that's all I needed? I'll see. What this tutorial did to is take fear. At
least for me. I did get the hang of these commands in a short time, so I
want to keep going."

I have failed to learn to use git on a couple of previous occasions. This
was a really good way of stripping it down to the essentials. I think now
that my problem is that I speak English. This document is mostly written in
English, successfully enough that "make a commit" was the only part where
screeched to a halt. At the command line, "commit" was a verb again, so I
could proceed without confusion.

Thank you for your work.

Thank you for the tutorial

At first I was not sure I liked the long scrolling page. I'm still not sure
I like it. I thought the content was good for someone new to git. We never
did anything with the python file, so I found it odd we made it? (note from
julia: removed the python file in response to this)

This was a great tutorial and very easy to follow. Thank you!

A few explanations about why you do things would go a long way to make this
more useful

Sorry about the confusion, I jump around a lot so things admittedly get
jumbled..."

"aaaaa sorry i misremembered the ssh trouble I was having, my problem was
that the command in the tutorial didn't work for me so I just used the
regular url and entered my password... then looked up somewhere else how to
generate the ssh key later.

not at this time!! thank you for the tutorial :)

I think the tutorial is great ! It was very clear and the step by step is
well done

i will keep practicing using git and maybe some more good reasons will
appear in why should do revision control in this way. it has got me to make
more test cases.

Solid tutorial. Some topics took me 2 reads to get a grasp of but that may
be due to English not being my native language

I learned something new with "git -am" - all in all this was concise and
easy to follow. Thank you for your work!

It is short and felt quick. That my be good. But I would have liked to
continue for a bit more before I start using it more and collect practical
experience.

I would add that I was taking notes in a notebook while doing the tutorial
(I would also do it in a final tutorial), so maybe it took me more time. I
also wanted to thank you, I feel I got a structured knowledge.

What I was hoping to find is how to work with git in a team. When should I
merge, when should I branch, basically; how am I a good git-citizen

Thank you so much for the opportunity to participate! I learned a lot,
especially from the top offline section.

that was very useful. "git diff" or any "diff" i still find hard on the
eyes, but I noticed in my terminal it was different colors which helped me
work out the info that was being presented. I think in the past it was all
one color which made it harder to absorb. But so far so good. Thank you. I
learnt new stuff today.

Overall, I liked this tutorial a lot. I've done a bit with Git before and
never felt comfortable. Now I feel a bit more confident. I'm also open to
testing more and answering questions anytime you need. And "Thanks". Every
little bit I learn helps.

Overall though I really like the tutorial, it's easy to follow and I learned
a lot!

Julia Evans (2):
  doc: remove gittutorial
  doc: add new Git tutorial for beginners

 Documentation/gittutorial.adoc | 944 ++++++++++++++++++---------------
 1 file changed, 506 insertions(+), 438 deletions(-)


base-commit: c51408889c3b372814bc20b9431c3b74d0d268eb
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2248%2Fjvns%2Fgit-tutorial-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2248/jvns/git-tutorial-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2248

Range-diff vs v1:

 1:  d47c730431 ! 1:  42035aa84a doc: remove gittutorial
     @@ Documentation/gittutorial.adoc (deleted)
      -----
      -gittutorial - A tutorial introduction to Git
      -
     --SYNOPSIS
     ----------
     --[verse]
     --git *
     --
      -DESCRIPTION
      ------------
      -
 2:  41dca2e8e0 ! 2:  6532e60e30 doc: add new Git tutorial for beginners
     @@ Metadata
       ## Commit message ##
          doc: add new Git tutorial for beginners
      
     -    This tutorial covers:
     +    Introduce Git in two parts:
      
     -    1. Creating an empty repo with `git init`
     -    2. Making commits with `git add`, `git commit`, `git diff`, and
     -       `git status`
     -    3. Pushing to code to a Git host on the internet, including creating an
     -       SSH key
     +    Steps 1-7: Create an empty repo & make 2 commits (`git init`,
     +    `git add`, `git commit`, `git status`, `git diff`)
     +    Steps 8-12: Push the repo to a remote host like GitHub or GitLab
     +    (`git remote add`, `git push`)
      
     +    Some design choices:
     +
     +    - Introduce a much smaller set of commands than the old tutorial, to
     +      keep the tutorial quick (doable in an hour). Some users found it to be
     +      very fast and some wanted to stop early (after step 7) so this seems
     +      to be a good balance.
     +    - Have users start with an empty repository instead of an existing
     +      project, because many of the testers did not have an existing project
     +      to test, or were scared of using an existing project.
     +    - Add a troubleshooting section, since in the testing some users got
     +      extremely stuck (for 4+ hours) on minor issues like needing to say
     +      "yes" when SSHing to a new host.
     +    - Don't explain branches, because explaining branches and collaboration
     +      is complicated and deserves its own tutorial. Instead just tell users
     +      we're not going to explain them in this document.
     +    - Tell users to set their default branch to `main`, because many Git
     +      hosts use it as their default branch and it really simplifies things.
     +    - Keep it as vendor neutral as possible, while acknowledging the reality
     +      that Git hosting services like GitHub, GitLab, etc are extremely
     +      popular. Do this by creating the repo locally and then optionally
     +      pushing it later.
     +    - Use SSH for authentication, explaining how to set up SSH in the
     +      easiest way possible (with disclaimers to check your security team's
     +      policy if applicable since the "easiest way" may not be the best), and
     +      giving some instructions for how to translate an HTTPS URL to an SSH
     +      URL.
     +
     +    At least 20 people have successfully completed it, and feedback was
     +    incorporated from problems the testers ran into.
     +
     +    Co-authored-by: Marie Claire LeBlanc Flanagan <hello@marieflanagan.com>
     +    Signed-off-by: Marie Claire LeBlanc Flanagan <hello@marieflanagan.com>
          Signed-off-by: Julia Evans <julia@jvns.ca>
      
       ## Documentation/gittutorial.adoc (new) ##
     @@ Documentation/gittutorial.adoc (new)
      +DESCRIPTION
      +-----------
      +
     -+This tutorial explains how to import a project's code into Git, make
     -+changes to it, and upload the project to the Internet.
     ++Git is a program that lets you collaborate with others on code, back up
     ++your code, roll back to an earlier version of your project, track how
     ++your project has changed over time, and much more.
     ++
     ++This tutorial explains how to create a new Git project, make
     ++changes to it, and upload the project to the Internet. It usually takes
     ++less than an hour if you have a little previous experience with Git, and
     ++1-2 hours if not.
      +
      +We'll show you how to use the commands `git commit`, `git add`,
      +`git diff`, `git status`, and `git push`.
      +
     -+Command line vs GUI
     -+-------------------
     -+
     -+Git is a command line program, but there are many excellent GUIs for
     -+Git built by the community. For example, if you use an IDE to edit your
     -+code, it might already have a built-in Git integration that you can use.
     -+
     -+In this tutorial, we'll give instructions for the command line version
     -+of Git, but you can also follow along in a GUI. You can also do some
     -+tasks in a GUI and some tasks on the command line. It's up to you.
     -+
      +What we'll be doing
      +-------------------
      +
      +Git lets you take snapshots of your code, like a checkpoint in a video
     -+game. In this tutorial we're going to explain a very basic Git
     -+workflow, which is:
     ++game. These snapshots are called "commits". Which files to save in a
     ++commit is up to you.
     ++
     ++When Git stores a commit, it stores a copy of every file in the commit
     ++in a database in a directory called `.git`. This is called a "Git repository".
      +
     -+1. Create an empty folder
     -+2. Start using Git to manage the code in that folder
     -+3. Create 2 files and tell Git to save a snapshot of them
     -+4. Make changes to one of the files
     -+5. Tell Git to take another snapshot
     -+6. Repeat steps 4-5 any time you want to update your code
     ++In this tutorial we're going to show you how to:
     ++
     ++1. Create a Git repository in a directory with the command `git init`.
     ++   This creates the `.git` directory where Git stores all your commits.
     ++2. Tell Git which files you want to put in a commit
     ++3. Make a commit
     ++4. Change a file and make a new commit with the new version
     ++5. Make experimental changes and throw them away
      +
      +We'll also explain how to use Git to put your code on the Internet.
      +
     ++Command line vs graphical interfaces
     ++------------------------------------
     ++
     ++Git is a command line program, but there are many graphical interfaces
     ++for Git built by the community. Your text editor might even have a
     ++built-in Git integration.
     ++
     ++In this tutorial, we'll give instructions for using Git from the
     ++command line. We can't give you instructions for how to do it in your
     ++graphical interface because there are so many of them.
     ++
     ++You can always switch back and forth between using the command line and
     ++a graphical interface at any time.
     ++
      +Step 1: Make sure Git is installed
      +----------------------------------
      +
     @@ Documentation/gittutorial.adoc (new)
      +
      +1. Git to be installed. You might already have it installed,
      +   and if not there are directions at https://git-scm.com/install/
     -+2. A folder on your computer with code that you want to start managing
     -+   with Git.
     ++2. A terminal to use. On Windows, you can use Git Bash which comes
     ++   when you install Git.
      +
      +You can check if Git is installed by running this in your terminal:
      +
     @@ Documentation/gittutorial.adoc (new)
      +$ git --version
      +------------------------------------------------
      +
     ++It should output something like this:
     ++
     ++------------------------------------------------
     ++git version 2.54.0
     ++------------------------------------------------
     ++
     ++The exact version isn't too important: this tutorial is designed to work
     ++with any version of Git after 2.0.
     ++
      +[[step_2]]
      +Step 2: Introduce yourself to Git
      +---------------------------------
     @@ Documentation/gittutorial.adoc (new)
      +$ git config --global user.email you@example.com
      +------------------------------------------------
      +
     -+The name and email is so that other people you're collaborating with can
     -+know who made the changes. You can set them to anything you want.
     ++The name and email is so that other people you're collaborating with
     ++can know who made the changes. You can set them to anything you want.
      +
      +To check if the name and email have been set, you can run these
     -+commands:
     ++commands. They should display your name and email:
      +
      +------------------------------------------------
      +$ git config user.name
      +$ git config user.email
      +------------------------------------------------
      +
     -+Set your default branch name to `main`, by running this command.
     -+Git is going to change its default branch name to `main` soon, so this
     -+sets you up well for the future.
     ++Next, configure Git to set the default branch name to `main` (instead
     ++of `master`) by running this command. We can't explain what a branch is
     ++yet, but Git is going to
     ++https://sfconservancy.org/news/2020/jun/23/gitbranchname/[make `main` the default soon],
     ++and setting this avoids some extremely annoying problems in Step 14.
      +
      +------------------------------------------------
      +$ git config --global init.defaultBranch main
     @@ Documentation/gittutorial.adoc (new)
      +
      +If there's no output, then it succeeded.
      +
     -+Step 3: Create an empty folder and 2 files
     ++[NOTE]
     ++It's also possible to set a different email address for every project,
     ++but we're not covering that here.
     ++
     ++Step 3: Create an empty folder and 1 file
      +------------------------------------------
      +
      +In your terminal, create an empty folder and change directories into it.
     @@ Documentation/gittutorial.adoc (new)
      +$ cd myproject
      +------------------------------------------------
      +
     -+Create 2 files in this directory, so we have something to work with.
     ++Next, using your text editor, create a file in this directory, so we
     ++have something to work with.
      +
      +Make a file called README.md, with these contents:
      +
     @@ Documentation/gittutorial.adoc (new)
      +We need 2 lines in this file so here's a second one
      +------------------------------------------------
      +
     -+And a file called `hello.py`, with these contents:
     -+
     -+------------------------------------------------
     -+print("hello world")
     -+------------------------------------------------
     -+
     -+Save the two files and keep them open in your text editor so you can
     -+easily edit them later. The exact contents aren't too important, but
     ++Save `README.md` and keep it open in your text editor so you can
     ++easily edit it later. The exact contents aren't too important, but
      +we'll use those contents in the example output later.
      +
     -+You can check that the files are in the right place by running `ls`,
     ++You can check that the file is in the right place by running `ls`,
      +like this:
      +
     -+
      +------------------------------------------------
      +$ ls
      +------------------------------------------------
      +
     -+The output should be like this:
     ++The output should look like this:
      +
      +------------------------------------------------
     -+hello.py
      +README.md
      +------------------------------------------------
      +
      +Step 4: Create a Git repository
      +-------------------------------
      +
     -+A Git repository is a folder which stores snapshots. It's usually a
     -+hidden folder called `.git`. Every time you take a snapshot, Git stores
     -+a copy of the contents of every file you're tracking.
     ++A Git repository lets you save snapshots of your code. Every time you make a
     ++snapshot, Git stores a copy of the contents of every file in the snapshot.
      +
      +This might feel unbelievable, but Git uses compression so you can easily
      +store tens of thousands of snapshots without using too much disk space.
     @@ Documentation/gittutorial.adoc (new)
      +------------------------------------------------
      +
      +You might notice a new hidden folder was created, named `.git`.
     ++You don't need to use this folder directly in any way, but it's where
     ++your commits will be stored.
      +
     -+Step 5: Take your first snapshot
     -+--------------------------------
     ++Step 5: Make your first commit
     ++------------------------------
      +
      +Next, we're going to take a snapshot of all the files in the directory
     -+and tell Git to store them. Taking a snapshot in Git is a two step
     -+process: first you need to run `git add` and then `git commit`.
     ++and tell Git to store them. Git calls these snapshots "commits".
     ++Making a commit in Git is a two step process: first you need to run `git
     ++add` and then `git commit`.
      +
      +The reason it's a two step process is that sometimes you might not
     -+actually want Git to store a snapshot of _all_ the files in a folder.
     -+For example, if you have a file full of private personal information
     -+called `personal.csv`, and a Python script called `process_data.py`, you
     -+might want Git to keep a snapshot of the Python script but not the
     -+private data.
     ++actually want Git to store a commit with _all_ the files in a folder.
     ++For example, if you're compiling your program to a binary, you might
     ++want Git to put the program's source code in your commit but not
     ++compiled binary. You can also use a `.gitignore` file to help with this.
      +
     -+For now, we're going to store a snapshot of every file in your folder,
     ++For now, we're going to store a commit with every file in your folder,
      +as well as in every subfolder.
      +
     -+The first step of creating a snapshot is to tell Git which files you
     -+want to include in the next snapshot using `git add`. To tell Git
     ++The first step of making a commit is to tell Git which files you
     ++want to include in the commit using `git add`. To tell Git
      +"include all files", run this command:
      +
      +------------------------------------------------
      +$ git add .
      +------------------------------------------------
      +
     -+Next you can create the snapshot using the `git commit` command, like
     -+this. The `-m` flag stands for "message", and it lets you set a reminder
     -+for your future self of what you were doing. The message ("Initial
     -+commit" in this example) can say anything you want.
     ++To check if it succeeded, you can run `git status`.
     ++The output should look like this:
     ++
     ++
     ++------------------------------------------------
     ++$ git status
     ++On branch main
     ++
     ++No commits yet
     ++
     ++Changes to be committed:
     ++  (use "git rm --cached <file>..." to unstage)
     ++        new file:   README.md
     ++------------------------------------------------
     ++
     ++Next you can create the commit using the `git commit` command, like
     ++this:
      +
      +------------------------------------------------
      +$ git commit -m "Initial commit"
      +------------------------------------------------
      +
     -+You've now stored the first version of your project in Git! From now on
     -+we're going to use the word "commit" instead of "snapshot", since that's
     -+the term Git uses.
     ++The `-m` flag stands for "message", and it lets you set a reminder
     ++for your future self of what you were doing. The message
     ++("Initial commit" in this example) can say anything you want.
     ++
     ++The output should look like this:
     ++
     ++------------------------------------------------
     ++[main (root-commit) 4a7e367] Initial commit
     ++ 1 file changed, 2 insertions(+)
     ++ create mode 100644 README.md
     ++------------------------------------------------
     ++
     ++You've now stored the first version of your project in Git!
      +
      +Step 6: Make a change
      +---------------------
     @@ Documentation/gittutorial.adoc (new)
      +different file.
      +
      +First open `README.md` in your favourite text editor, make a tiny or
     -+silly change, and save it.
     ++silly change, and save it. In our example, we'll edit the first line to
     ++add more exclamation marks:
     ++
     ++------------------------------------------------
     ++We're doing a Git tutorial!!!!
     ++------------------------------------------------
     ++
      +
      +Next, in the terminal, run the command `git status` to get a summary of
      +what you changed since the last Git commit.
     @@ Documentation/gittutorial.adoc (new)
      +
      +------------------------------------------------
      +diff --git a/README.md b/README.md
     -+index 7ebaecb3..5a4ff712 100644
     ++index ffa8b85..a49e4b0 100644
      +--- a/README.md
      ++++ b/README.md
      +@@ -1,2 +1,2 @@
     -+ Here are some Python scripts!
     -++I hope you like them.
     ++-We're doing a Git tutorial!
     +++We're doing a Git tutorial!!!!
     ++ We need 2 lines in this file so here's a second one
      +------------------------------------------------
      +
     -+This output says that we added one line, saying "I hope you like them.".
     -+By default Git will show the lines you removed in red, and the lines you
     -+added in green.
     ++This output says that we deleted one line (`We're doing a Git
     ++tutorial!`) and added one line (`We're doing a Git tutorial!!!!`). By
     ++default Git will show the lines you removed in red, and the lines you
     ++added in green. Removed lines start with a minus `-` and added lines
     ++start with a plus `+`.
     ++
     ++Step 7a: Make a second commit
     ++-----------------------------
      +
     -+Step 7: Make another commit (easy way)
     -+--------------------------------------
     ++Now that we've changed `README.md`, let's make another commit.
     ++We're going to follow the same steps as before when we made our first
     ++commit.
      +
     -+Now let's tell Git to save the new version of `README.md` by making
     -+another commit! To tell Git to snapshot all files that Git is tracking
     -+and commit them, run this command:
     ++First, tell Git that we want to include the new version of `README.md`
     ++in the next commit:
      +
      +------------------------------------------------
     -+$ git commit -am "Update README"
     ++$ git add README.md
      +------------------------------------------------
      +
     -+This is similar to the two step process in Step 4 where we used `git
     -+add` and `git commit` to make a commit, but with a shortcut that lets
     -+you do both in just one command. The `-a` stands for "all".
     ++and then run `git commit`, like this:
      +
     -+Step 7b: Make another commit (longer way)
     -+-----------------------------------------
     ++------------------------------------------------
     ++$ git commit -m "Update README"
     ++------------------------------------------------
      +
     -+`git commit -am` is a fast way to snapshot all the files that Git is
     -+tracking. But if you want Git to ignore changes to certain files, you
     -+can instead do a 2-step process like in Step 4 where first you run `git
     -+add` for every file that's been changed and that you want to include in
     -+the next commit, like this:
     ++The output should look like this:
      +
      +------------------------------------------------
     -+$ git add README.md
     ++[main 32e0171] Update README
     ++ 1 file changed, 1 insertion(+), 1 deletion(-)
      +------------------------------------------------
      +
     -+and then run `git commit` (without the `-a`), like this:
     ++This says that the new commit is the same as the previous commit,
     ++except that we changed 1 line of 1 file.
     ++
     ++Step 7b: Make a second commit (the short way)
     ++---------------------------------------------
     ++
     ++Instead of running the two commands in Step 7a above, you
     ++could also run this command as a shortcut. It will:
     ++
     ++1. Get a list of every file in the most recent commit
     ++2. Commit the current version of all of those files
      +
      +------------------------------------------------
     -+$ git commit -m "Update README"
     ++$ git commit -am "Update README"
      +------------------------------------------------
      +
     ++The `-a` stands for "all".
     ++
     ++Understanding `git status` output: "untracked files"
     ++----------------------------------------------------
     ++
     ++Now let's talk about a term you'll see in the `git status` output:
     ++"untracked files".
     ++
     ++First create a new file called `example.txt`. It can be empty.
     ++
     ++Then run the command `git status`. You should see this output:
     ++
     ++----------
     ++On branch main
     ++
     ++Untracked files:
     ++  (use "git add <file>..." to include in what will be committed)
     ++        example.txt
     ++
     ++nothing added to commit but untracked files present (use "git add" to track)
     ++----------
     ++
     ++This has a list of "untracked files". An untracked file is a file which
     ++was not part of the latest commit. By default Git will ignore these
     ++files.
     ++
     ++If you want to commit an untracked file, you can add it like this:
     ++
     ++----------
     ++$ git add example.txt
     ++----------
     ++
     ++Then you can run `git commit` to commit it.
     ++
      +Step 8: Make a change and throw it away
      +---------------------------------------
      +
     @@ -1,2 +1,2 @@
      +
      +Navigating the Git host's UI can be tricky, and it's hard for us to
      +give you exact directions because the UIs change a lot.
     ++There's a rich tradition of people learning Git from their "Git friend"
     ++who already knows Git, and if you have one of those it might be useful
     ++to ask them if you get stuck. There are many ways to do things in Git,
     ++so they might suggest a slightly different way.
     ++There's also a troubleshooting guide at the end with the most common
     ++issues folks have run into while doing this tutorial.
      +
      +Step 9: Create an account on a Git host
      +---------------------------------------
     @@ -1,2 +1,2 @@
      +Once you've done this, you're done! Git will automatically use your SSH
      +key to try to connect.
      +
     ++[[step_12]]
      +Step 12: Create an empty Git repository on the Git host
      +-------------------------------------------------------
      +
     -+Go to the Git host's website and create a new Git repository.
     ++Go to the Git host's website and create a new Git repository. If there's
     ++an option to "create a README.md", "add a license", or something
     ++similar, make sure to say no to all of them.
      +
      +**WARNING**: If you create a public repository and push your repository
      +to it, then your name and email address, as well as the contents of
     @@ -1,2 +1,2 @@
      +replace with "git@"    replace with ":"
      +-------------------------------------------
      +
     ++[[step_14]]
      +Step 14: push your changes
      +--------------------------
      +
     @@ -1,2 +1,2 @@
      +(if this doesn't work, read the "Troubleshooting `git push`" section for advice!):
      +
      +-------------------------------------------
     -+$ git push -u origin main
     ++$ git push --set-upstream origin main
      +-------------------------------------------
      +
     -+`origin` refers to the URL we just added (`git@example.com:username/repo.git`),
     -+and `main` is the name of your current Git branch. You can use any name
     -+(not just `origin`), but using `origin` often makes things easier
     -+because it's the default for `git push` and `git pull`.
     -+We haven't covered branches yet, but `main` is the default branch name.
     ++Let's break down this `git push` command:
      +
     -+Any time you want to set up a new repository, you can repeat steps
     -+11-13, with one exception: you only need to pass `-u` the first time
     -+you push. Afterwards you can just run the command:
     ++* `origin` refers to the Git repository that we just added with
     ++  `git remote add` (`git@example.com:username/repo.git`).
     ++  You can use any name (not just `origin`), but using `origin` often
     ++  makes things easier because it's the default for `git push` and `git pull`.
     ++* `main` is the name of your current Git branch.
     ++  We haven't covered branches yet, but `main` is the default branch name.
     ++* `--set-upstream` tells Git to make this the default for `git push` for
     ++  the `main` branch. After you set the upstream, `git status` will
     ++  also tell you if you have commits that haven't been pushed.
     ++
     ++The output should look like this:
      +
      +-------------------------------------------
     -+$ git push origin main
     ++Enumerating objects: 7, done.
     ++Counting objects: 100% (7/7), done.
     ++Delta compression using up to 8 threads
     ++Compressing objects: 100% (6/6), done.
     ++Writing objects: 100% (7/7), 662 bytes | 662.00 KiB/s, done.
     ++Total 7 (delta 0), reused 0 (delta 0), pack-reused 0 (from 0)
     ++To example.com:username/repo
     ++ * [new branch]      main -> main
     ++branch 'main' set up to track 'origin/main'.
      +-------------------------------------------
      +
     -+It should output something like this:
     ++Any time you want to set up a new repository, you can repeat steps
     ++12-14, with one exception: you only need to pass `--set-upstream` the first time
     ++you push. Afterwards you can just run the command:
      +
     -+-------------------------------------------
     -+To example.com:example_username/example
     -+ * [new branch]        main -> main
     -+-------------------------------------------
     ++-------
     ++$ git push origin main
     ++-------
      +
      +Troubleshooting `git push`
      +--------------------------
     @@ -1,2 +1,2 @@
      +
      +Here's a guide to why they're happening and how to fix them.
      +
     -+**Problem 1**: You pushed to `main`, but your branch actually isn't called `main`
     ++**Problem 1: You pushed to `main`, but your branch actually isn't called `main`**
      +
      +Here's the error:
     -+```
     ++
     ++-------
      +$ git push origin main
      +error: src refspec main does not match any
     -+```
     ++-------
      +
      +This might happen if you didn't set `init.defaultBranch` to `main` in
      +<<step_2,Step 2>>.
     @@ -1,2 +1,2 @@
      +
      +The easiest way to handle this is to type "yes" and press Enter.
      +
     -+**Problem 3: the repository already exists**
     ++**Problem 3: the repository already has commits in it**
      +
      +Here's the error:
      +
      +---------------------
      +$ git push origin main
      +! [rejected]        main -> main (fetch first)
     -+error: failed to push some refs to 'example.com:example/example.git'
     ++error: failed to push some refs to 'example.com:username/repo.git'
      +hint: Updates were rejected because the remote contains work that you do not
      +hint: have locally.
      +---------------------
      +
      +If you see an error like this, it means that when you created the
     -+repository on your Git host, it created a repository with a file in it
     -+to try to help you out. (that's the "work that you do not have locally"
     -+in the error message)
     ++repository on your Git host, it added a commit to try to help you out.
     ++That's the "work that you do not have locally" in the error message.
      +
     -+You can fix this either by deleting the repository and recreating it, or
     -+by running:
     -+
     -+---------------------
     -+$ git push --force origin main
     -+---------------------
     -+
     -+**WARNING**: In general it's quite dangerous to use `--force` because
     -+it can erase work on the online repository in a way that's difficult to
     -+recover. But if you know for sure that you just created the repository 2
     -+minutes ago and there's nothing in it, then it's okay.
     ++You should be able to fix this by redoing <<step_12,Step 12>>.
     ++Then <<step_14,Step 14>> should work.
      +
      +MORE USEFUL GIT COMMANDS
      +------------------------
      +
     ++We're not going to cover collaboration at all in this tutorial, but here are a
     ++few more commands that might be useful when using Git on your own:
     ++
     ++* To download a Git repository to use on your computer you can run
     ++  `git clone https://example.com/some/repo` (linkgit:git-clone[1]).
      +* To tell Git to "un-add" a file that you added by accident, run
     -+  `git rm --cached FILENAME`
     ++  `git rm --cached FILENAME` (linkgit:git-rm[1])
     ++* To get a list of past commits, run `git log` (linkgit:git-log[1])
     ++* Every commit has an ID that looks something like this:
     ++  `497588f53141b531a59ed888c7d2d9b8f8a6742d`.
     ++  If you see a commit with `git log` that you want more details about,
     ++  you can run `git show COMMIT_ID` to see what changes that made since
     ++  the previous commit (linkgit:git-show[1])
      +
      +SEE ALSO
      +--------

-- 
gitgitgadget
