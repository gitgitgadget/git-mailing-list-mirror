Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793198691;
	b=mAfFhS8/gx6w2V2kwapbJevNpu/3S1pQr/DS0WxrHd/V8TBkdCYkJHbW336NLcz7VWbn
	 8YgiFy8Xiy0wt+TJuPk7uB14F4JqZ6IDXuE8MzXbrVXVSZL2Z5FPBvmaQ+gxODMyOUXEh
	 VwJgyB5mE+YGtmHyKMsMRb2ps3JCoUJ5eD58X7+putA5oMKb2Sgn7mukmRIFKNYyw4JAq
	 anL/e+H1JFSAmmt6XjY+JPCZTJ9dRP1oyTmKRlAqQOnseI1J303qz2cMgt4In/Q3VNB2s
	 UkhJndTuMiSac3sHGF+FQ8QStmV2h0cL6SfPoBFxSaQyfaVBWErPtjh+BomA1eMzIYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793198691;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=mCKKqYUXd7rwYszWEgU74sjMszzvFOLcFu11hmRe17k=;
	b=tmzrjzhw56aNo/p2aZzKOhR2DCM3qyNuCU16dufMgBoJsG2vD4u213W3Erixz3is5fbn
	 /TR0pPZ7lOy3OTsb5tyVBjIn77RDPp6O6gc+ZJW5ckziNQXqzTikyhlFNx2ZBy+lqnt4c
	 /r+Cf6/kOhQnmWswvE1C/bBehrazaBj0utOYNWl+r6Bzr613G/TPfu2DiD8m3jOgMIH9D
	 O3e+tf8tVjWUsiJFfb4Asoeuc+HpQ/svBKpyKpAjDV4daaqSO38IsfSTV5Kwn19lgV5SP
	 oPgd58b9Xl7Jq5L1nWWnSHzMWvdS2xSpsNImHtxHBO58KiH9tUGQbBSUlx/SiSDlYLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HE43hjgF;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2297606A334
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 14:44:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2297606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HE43hjgF
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-156cbe59524so1158054c88.1
        for <git@vger.kernel.org>; Wed, 28 Oct 2026 07:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793198690; x=1793803490; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mCKKqYUXd7rwYszWEgU74sjMszzvFOLcFu11hmRe17k=;
        b=HE43hjgF9fRPbOnumNuMe/iJs/cD07fPolAJ6jqv9KXyhs2Bl1FiQ8WgpVC6Sok5kX
         8KoE3GLsr3S1yHuTasE9ZGyNtLtlyOj3uDHeSdtPQXIyi8jpb3R9YK7XZchvB4945Ix6
         tQGG19F4UmGxBtp46HIM6jpi5Opd3y77HRfL9k44FxEfY7AL63NY1WfKu0+7MFGUJTSj
         b/JGyHPTqFXVK0M35ZbHQiewhBQ+w6XQ90rBxeodslhWrklQ3FnjmZSm0Sl4mgdHwL/Y
         1gPjhr3XRDYv4g5NstO6PsdU3QBarLjvDy67x5Ogh9+MXHjvozGifUZtc9tIzbX5SDru
         KVGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793198690; x=1793803490;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mCKKqYUXd7rwYszWEgU74sjMszzvFOLcFu11hmRe17k=;
        b=tBESpAutgdnlEgPsbH0+EpMbFaygWbJqt8kvEX65cgCbppGw4/yfaVlUPl2GhdVAeC
         M8iXKfC0l99PqrVe7I/SVr9yj13XK5aK9UfTLPEBA8vYWS/1qm/q+OQqwdk/SkRDP3tP
         Oq7MTMaJU4vy4FfC1MikzlayxvBTP78JFAniLOy+e6uIFVnqSfKe1iqXL0Tg7bl6QgBH
         Zt1kq6ttA3pB9BC9t9c1j+jXDNV7PxhWpXlTCfgGHOFm2UIqf9nk8n+EPjhAwa+JFEoK
         eliUWqn6Rj6Uv+L7LE3PVY+3ccWOuASyREfaZQXaKsY0wK5SNtnDKTxyDtOX03B6oOWE
         gW3g==
X-Gm-Message-State: AFq9FYItGx+ON7BipCfBQzLAFbJKqGGnCVKUhFJt5YNWVgdkq/YO4RFO
	EsJOTe4GkimeyFDfjNnCWJqVJKzFwYSyfkmRGsNpPuhU1DfLlBJKSGIpchbqGMwO
X-Gm-Gg: AYBFou1Rf+0QRIxyRR02GIsUP30pw2eFiszkjrPL2XsfwJuIhiaQkehMSyEUOEUyzoS
	EsQtxBsPhF6SVowyFfyam6UXchP4h4etxt6Yi0U01JytmXo9ijcY+onY2OjhTiyYj2vUIYa3QNR
	kTHRtI/lwQb6d17c3y9A/W+6VJ62+lLpCvqNllJU9rcIKgqUKB5ZnOU3FeO+SNRNexoTr6oZwBQ
	COll1cl0r6E3X9uDRcTxyVHute7Ppdwhqng25OaqXn/AKvrpHbuiALTR9lVBCuwCHLCmtgF90dN
	icG0r+a8AIfe9t1nn69xFlF3+wgb9XoS96X58Sx6NkebGma/kdGDgHxUHXzYmte0goi+fGst8cM
	6nvqGdbeI7RsMTpo+3Sr9RUyM6JfbPBQz9iksTXE+8wm7MwcMB8r5aUBiIcDpcQhWRn6HXpEmjk
	2VHcFG6hz0dr6iWm18DxCOflhGcteoa5HMHZAcikZtystGSkAUI1prhvTtYetG+BbX+UERTW4aN
	qEaQ1fsU5qYc9kH4cuoSgkYbO/7JQsyYExi4xA85sf//MtTvhsNW8YQnEZ87BPL5eQRTfZpQez7
	GxP1nDo7BEtz+yn5z03iYTskmtx/smDf
X-Received: by 2002:a05:7022:2582:b0:198:b1e:90d9 with SMTP id a92af1059eb24-1a6cd498bf6mr4081044c88.10.1793198689481;
        Wed, 28 Oct 2026 07:44:49 -0700 (PDT)
Received: from [127.0.0.1] ([128.24.160.231])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a75e0098basm5926655c88.12.2026.10.28.07.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 07:44:48 -0700 (PDT)
Message-Id: <pull.2248.v4.git.1793198687.gitgitgadget@gmail.com>
In-Reply-To: <pull.2248.git.1791315422.gitgitgadget@gmail.com>
References: <pull.2248.git.1791315422.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 28 Oct 2026 14:44:45 +0000
Subject: [PATCH v4 0/2] doc: add new git tutorial
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
    Tuomas Ahola <taahol@utu.fi>,
    Richard Kerry <richard.kerry@atos.ai>,
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

Thanks to Paula, Agavi, Ken Wells, Michael / Chgowiz, Ishmaeel, and all 20
or so other test readers.

changes in v3: (v2 was the "first" real version since v1 was a WIP)

 * Say that the tutorial supports any version above 2.23.0, when git switch
   was introduced, since the next part of the tutorial on branches will use
   git switch
 * Mention that on Windows the tutorial will work best in Git Bash for and
   it might need adapting for PowerShell. (thanks to Ben)
 * Add a warning about how Git can dump you into vi, how to handle that
   situation, and how to write a longer commit message. I tried to strike a
   balance between lightly suggesting that it might be good to write longer
   commit messages, while making it clear that you can just use -m"" if
   you're not ready to navigate the world of editor configuration. I don't
   think we can use Pro Git here though since it's a bit outdated. (thanks
   to Ben)
 * Add Helped-by: Ben ...
 * Add output of "ls ~/.ssh/*.pub" (thanks to a test reader)
 * Suggest cat ~/.ssh/whatever.pub to make it clearer how to copy the
   contents of the file. One of the test readers said this was unclear as
   well. (thanks to Junio)
 * Mention that the public key might not be called ed25519.pub (thanks to
   Junio)
 * Add a short section on the importance of git status
 * Fixed the formatting around the headings. Kept it in the same style
   because I had issues with the docs linter when using == DESCRIPTION
   (thanks to Junio)
 * explain what --set-upstream does (thanks to Ben)
 * A few other small phrasing fixes from test readers

non-changes in v3:

 * didn't use git config set since the tutorial claims to be compatible with
   Git 2.23.0
 * kept using the term "folders" since my impression is that Mac OS and
   Windows use the term "folder" and those operating systems are more
   popular than Linux. I don't think any test readers were confused by this
   term, though "directories" might be fine too.
 * leave git init instead of git init myproject so that folks can use the
   same process when setting up Git in an existing project

changes in v4:

Make the instructions more Windows-friendly (thanks to Richard Kerry), by:

 * mentioning that Git for Windows will ask you to configure a text editor
   when you install it
 * saying that the SSH instructions are Mac/Linux only and suggesting using
   Git Credential Manager on Windows, and update the instructions for
   whether to use an HTTPS/SSH URL accordingly
 * using "folder" instead of "directory" in a few more places Also:
 * Say "bottom left" (thanks to Ben)
 * Add a link to how to configure various text editors
   https://git-scm.com/book/en/v2/Appendix-C:-Git-Commands-Setup-and-Config#ch_core_editor
   (thanks to Ben)

non-changes in v4:

 * leave the comment about how vim is "extremely difficult if you're not
   used to it" alone, I couldn't come up with a better way to communicate it
   and I really don't want anyone to think that being able to use vim is
   expected.

Julia Evans (2):
  doc: remove gittutorial
  doc: add new Git tutorial for beginners

 Documentation/gittutorial.adoc | 1051 ++++++++++++++++++--------------
 1 file changed, 589 insertions(+), 462 deletions(-)


base-commit: 47fdf2208c5b94c8cc01c106b8f7c85efb91c926
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2248%2Fjvns%2Fgit-tutorial-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2248/jvns/git-tutorial-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/2248

Range-diff vs v3:

 1:  8c0366e996 = 1:  64d9811539 doc: remove gittutorial
 2:  d8ea142af6 ! 2:  4b40588c90 doc: add new Git tutorial for beginners
     @@ Commit message
            policy if applicable since the "easiest way" may not be the best), and
            giving some instructions for how to translate an HTTPS URL to an SSH
            URL.
     +    - Use Git Credential Manager for authentication on Windows, since it's
     +      simpler, SSH auth is a very "unixy" thing to do,  and it comes with
     +      Git for Windows
          - Warn people about how `vi` is the default text editor and give some
            instructions for how to escape
      
     @@ Documentation/gittutorial.adoc (new)
      +commit is up to you.
      +
      +When Git stores a commit, it stores a copy of every file in the commit
     -+in a database in a directory called `.git`. This is called a "Git repository".
     ++in a database in a folder called `.git`. This is called a "Git repository".
      +
      +In this tutorial we're going to show you how to:
      +
     -+1. Create a Git repository in a directory with the command `git init`.
     -+   This creates the `.git` directory where Git stores all your commits.
     ++1. Create a Git repository in a folder with the command `git init`.
     ++   This creates the `.git` folder where Git stores all your commits.
      +2. Tell Git which files you want to put in a commit
      +3. Make a commit
      +4. Change a file and make a new commit with the new version
     @@ Documentation/gittutorial.adoc (new)
      +1. Git to be installed. You might already have it installed,
      +   and if not there are directions at https://git-scm.com/install/
      +2. A terminal to use. On Windows, you can use Git Bash which comes
     -+   when you install Git. For Windows this tutorial will assume you're
     -+   using Git Bash and if not you might need to adjust some commands like
     -+   `ls` and `cat`.
     ++   when you install Git.
      +
      +You can check if Git is installed by running this in your terminal:
      +
     @@ Documentation/gittutorial.adoc (new)
      +$ cd myproject
      +------------------------------------------------
      +
     -+Next, using your text editor, create a file in this directory, so we
     ++Next, using your text editor, create a file in this folder, so we
      +have something to work with.
      +
      +Make a file called README.md, with these contents:
     @@ -1,2 +1,2 @@
      +text editor in the terminal for you to use to edit your commit message.
      +This lets you write a longer commit message with more details.
      +By default, Git uses the `vi` text editor, which is extremely difficult
     -+to use if you're not used to it.
     ++to use if you're not used to it. On Windows, the Git installer asks you
     ++to set your text editor during the install to avoid this problem.
      +
      +Some signs that you're trapped in `vi`: suddenly typing doesn't work
     -+anymore, and there are tilde `~` characters on the left of the screen.
     ++anymore, and there are tilde `~` characters on the bottom left of the
     ++screen.
      +
      +If Git opens `vi` and you'd rather use a different editor, you can
      +handle it like this:
      +
     -+1. Quit by typing `Escape`, then `:q!` and then `Enter`
     ++1. Quit by pressing the `Escape` key, then typing `:q!` and then `Enter`
      +2. Run `git config --global core.editor YOUR_PREFERRED_EDITOR`
      +   to configure which editor to use. For example, `nano` is available
      +   on a lot of systems and has basic instructions on the screen for how
     -+   to use it.
     ++   to use it. Here is a list of
     ++   https://git-scm.com/book/en/v2/Appendix-C:-Git-Commands-Setup-and-Config#ch_core_editor[how to configure some common editors].
      +3. Run `git commit` again
      +
      +If you don't want to set up a text editor yet, you can also just use
     @@ -1,2 +1,2 @@
      +a Git repository on the internet, like connecting through SSH or open
      +source Git forge software to your server.
      +
     -+Step 10: Create an SSH key (if needed)
     -+--------------------------------------
     -+
     ++Step 10 (Mac/Linux only): Create an SSH key if needed
     ++-----------------------------------------------------
      +For Git to upload changes to another Git repository, it needs a way to
      +login to that repository. One of the most popular ways to do this is
      +with an SSH key.
      +
     -+If you don't already have an SSH key, you'll need to create one. On Mac
     -+or Linux, you can check if you already have an SSH key by running:
     ++On Windows, you can skip this step and the next one because Git for
     ++Windows comes with
     ++https://github.com/git-ecosystem/git-credential-manager[Git Credential Manager]
     ++to handle logging in. 
     ++
     ++If you don't already have an SSH key, you'll need to create one.
     ++You can check if you already have an SSH key by running:
      +
      +-------------------------------------------
      +$ ls ~/.ssh/*.pub
     @@ -1,2 +1,2 @@
      +security team in your organization, they might have very different
      +opinions about the appropriate way to configure authentication with Git.
      +
     -+Step 11: Tell the Git host your SSH public key
     -+----------------------------------------------
     ++Step 11 (Mac/Linux only): Tell the Git host your SSH public key
     ++---------------------------------------------------------------
      +
     -+First, find your SSH key like this (on Mac or Linux):
     ++First, find your SSH key like this:
      +
      +-------------------------------------------
      +$ ls ~/.ssh/*.pub
     @@ -1,2 +1,2 @@
      +Step 13: Find the address of the repository
      +-------------------------------------------
      +
     -+Now, find the address of the repository on your Git host. It should look
     -+something like this:
     ++Now, find the address of the repository on your Git host.
     ++
     ++If you followed the Mac/Linux instructions to set up an SSH key, look
     ++for an "SSH" address like this:
      +
      +-------------------------------------------
      +git@git.example.com:username/repo.git
      +-------------------------------------------
      +
     ++If you're on Windows, look for an "HTTPS" address like this:
     ++
     ++-------------------------------------------
     ++https://git.example.com/username/repo.git
     ++-------------------------------------------
     ++
      +(where `example.com`, `username` and `repo` will be replaced with the
      +actual values).
      +
     -+If you can only find an address starting with `https://`, then
     -+you can often translate it to the SSH format by replacing `https://`
     -+with `git@` and replacing the `/` after the domain name with an `:`.
     -+Here's how:
     ++If you can only find an address starting with `https://` and you need
     ++an SSH address then you can often translate it to the SSH format by
     ++replacing `https://` with `git@` and replacing the `/` after the domain
     ++name with an `:`. Here's how:
      +
      +-------------------------------------------
      +https://git.example.com/username/repo
     @@ -1,2 +1,2 @@
      +
      +First, tell Git about the other repository by running `git remote add`
      +in your terminal
     -+(replace `git@example.com:username/repo.git` with the actual address):
     ++(replace `git@example.com:username/repo.git` with the address from Step 13):
      +
      +-------------------------------------------
      +$ git remote add origin git@example.com:username/repo.git
     @@ -1,2 +1,2 @@
      +$ git push --set-upstream origin main
      +-------------------------------------------
      +
     ++On Windows, this should pop up a dialog from Git Credential Manager
     ++asking you to log in to the Git host in your browser.
     ++
      +Let's break down this `git push` command:
      +
      +* `origin` refers to the Git repository that we just added with

-- 
gitgitgadget
