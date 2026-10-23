Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792768629;
	b=bNROb1ReIAx3T29xkQ/A6BeSOu91m6jSNfi9K3cPset13RdKmDTEJrbVrJKu9uYqx02m
	 RuW/IduUCQvl5PMSzPlfj4bo7gSj5ITVT/zOZSh5BgLglLrKUYR71QDskFW9Rd1Ir4pm1
	 rPGRtTa2hyb2NJ8j0GVkpkPhSrrWKBBghlXLOLsIDhU8W+BXuwBAbc9jNZ/L97uLX2bgt
	 FLCWq29Jf93eDaKKnx3u+rCJJRXZS3jbREJCLQ6KttY8E2N1zZZqDH8IJILlVH0KpnD1I
	 gsfSsaGCgy8kj94XHVjjEcSa3W29TBGa4rmWHh3fUWuU2OuptF568ZK/HXqKPqEDwPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792768629;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=Hw4fWvbiQClicGoA3dEyPjM7K7Erq/9yK46BqwyoCUg=;
	b=BbVN0CgQSCR7M+Ru0rNZS0L32+CRcF/iCDfLXhsY0wY5VJKRLYnBwePaYov3sdXN+5FA
	 Tha55sQDO5VuOWHFw1O5Wt1hZikDvcxbAqTmk0kFq4pgopbKmHeLx5z6++WhegtIToLce
	 r+bKvrx9K/aFj+nBpBBr7mIPj/akYgChyLURMSgOaiy2Du0nXbv0l2Chh/xttj7qJ8XTn
	 kI2kD/0WgXg9TR/sb5LbE1QNn8MDGoYBfb9TKtkPRBWiJTteoNGT+j99pf6r2dHsnB2Ye
	 95jM2nz5j7RXxf+R/PLS40sdoFEAisfYVQjJg4oIdQRhNV3EUcxS8CBkMO89Km9ihDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kz9r+39H;
	arc=none smtp.remote-ip=209.85.160.54
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED67606A31B
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 15:17:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5ED67606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kz9r+39H
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-4a6fb4040cfso338972fac.3
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 08:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792768627; x=1793373427; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Hw4fWvbiQClicGoA3dEyPjM7K7Erq/9yK46BqwyoCUg=;
        b=kz9r+39HtdW4OYUEgW0lCIVNsmHYTxthpE91s3u8psOc8cZkGlvjqP5BdUgQEFiKjR
         oyWGKjvuSQ1nyin8WbIlq57YLfc/+cT0/Gz7N4aoXXQfvfIXGO6m7hkSjnCM3hbpB3VI
         l5YVzbszP27pU017IWsD9VBHiaHZFNd1EQ8IpuDVogNuI2oQIS5uoD8evPc00QTkJ54c
         VqPj6+gFCXHSeMOzRvnWDzX9TZLd1TzGADDQZuBo/rLc2V5ucdnPhRGAg5ybGfnKkzjU
         JgYODRShDYotnCI0mjMRO6GALjtAq+mbv1VOSeYm48+PAhJRBGAcy3Tt/Ba0ebRdzoGe
         zPdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792768627; x=1793373427;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Hw4fWvbiQClicGoA3dEyPjM7K7Erq/9yK46BqwyoCUg=;
        b=zBbF/MpCxIWOHGpFBrFbawwTLMGtifFJT+u/VEUN2heS8l7e6lrbYTBLnM0lj3IThz
         Ejgg7R8sp2o6AeOzbrBsNsBOf/H3mhWYEJuuQI+rioLUaZjfydZRAwyFI29KCsdgnB8z
         0Cby8ehpcm7B7jKDF03TdWVWvFw2XxDYcA6PhuRYG1dqsBRIP82upaw9e+OQRLPrRg1/
         /swWw7NoOhSEuWcFwiLyTD6nrQOQCOByP84YIPs/FI5Px/gD42hzR7Cmhhm49xMa72An
         f5pdfDCKQZmZFLttaNJ1zpsb//10Hsnm2EoeolnNRTNyTlFw3bkwZNLcZCL4cuNPc3ia
         nLYw==
X-Gm-Message-State: AFq9FYKR6OEHuShQb8k57E0KnGxi8FxNZL9AXfIs5WUAno2mgZTRT1Yh
	7CAZN24XV/7KkbqSr2jZRFEB1gMbNKWWD/tIUTElyXHkCN3rLGtBZpSDmBtKnfPg
X-Gm-Gg: AYBFou2UhtqwOTlISNt33gJON9/ANkaj6GoCogX414fSfwWH33emBt4X/vmakfhf4EL
	4XUdWSfrQJZh163msCrTwbt8hilCU4wM6r6hkOSgkDqqjfAyCgfWDBBp9VxHu3k98ACxAh6uehy
	uusQiuyR09u3BWVZ/w/fpswkP0Am5fA+pPuev2/3IeNFSAlRiKS3vAcPD+bT2ib8HSn+GWBl2pR
	9jEYDs2tgaGE8rVkxfglCNf36rCTcOF3ZztHfKO13F6Ic5c9831DJvx+vElZVAEkALYcftm38Nc
	rBA2wnCrMsWdloJu+v3cbFTiajSsOBZ/1ejNCwaSlsSbMZ9YfxGf6Tr/O+1wHMlxkkZvf4S8aS2
	sn0EXsWGjxTusYuB9iG8eNTpxl0lkhV0zbnOxGnhn3W1Kc0oHYF0KhqTMbaS2xTExv1FE/WSNfz
	fs0vEzlWOfOZti5K3AB98nhJ+zEOdQ/dVgsttMId1tKTxb4jQP0LozzQCzt1rwnR9x+IyASEP+w
	2nNMwF0Iza1qouxh+89hau7MwYVjqCeoqWFwMFF+Dx+i91NfK2cOKdre5G2
X-Received: by 2002:a05:6870:1f14:b0:49e:1c69:1f57 with SMTP id 586e51a60fabf-4a8224277a8mr1344468fac.41.1792768626959;
        Fri, 23 Oct 2026 08:17:06 -0700 (PDT)
Received: from [127.0.0.1] ([135.119.21.214])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a838207cb9sm300438fac.5.2026.10.23.08.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 08:17:06 -0700 (PDT)
Message-Id: <pull.2248.v3.git.1792768625.gitgitgadget@gmail.com>
In-Reply-To: <pull.2248.git.1791315422.gitgitgadget@gmail.com>
References: <pull.2248.git.1791315422.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 23 Oct 2026 15:17:03 +0000
Subject: [PATCH v3 0/2] doc: add new git tutorial
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

Julia Evans (2):
  doc: remove gittutorial
  doc: add new Git tutorial for beginners

 Documentation/gittutorial.adoc | 1035 ++++++++++++++++++--------------
 1 file changed, 573 insertions(+), 462 deletions(-)


base-commit: 47fdf2208c5b94c8cc01c106b8f7c85efb91c926
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2248%2Fjvns%2Fgit-tutorial-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2248/jvns/git-tutorial-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/2248

Range-diff vs v2:

 1:  42035aa84a = 1:  8c0366e996 doc: remove gittutorial
 2:  6532e60e30 ! 2:  d8ea142af6 doc: add new Git tutorial for beginners
     @@ Commit message
      
          Some design choices:
      
     +    - Only use commands present in 2.23.0 (when `git switch` as introduced),
     +      to support older versions of Git.
          - Introduce a much smaller set of commands than the old tutorial, to
            keep the tutorial quick (doable in an hour). Some users found it to be
            very fast and some wanted to stop early (after step 7) so this seems
     @@ Commit message
            policy if applicable since the "easiest way" may not be the best), and
            giving some instructions for how to translate an HTTPS URL to an SSH
            URL.
     +    - Warn people about how `vi` is the default text editor and give some
     +      instructions for how to escape
      
          At least 20 people have successfully completed it, and feedback was
          incorporated from problems the testers ran into.
      
     +    Helped-by: D. Ben Knoble <ben.knoble@gmail.com>
          Co-authored-by: Marie Claire LeBlanc Flanagan <hello@marieflanagan.com>
          Signed-off-by: Marie Claire LeBlanc Flanagan <hello@marieflanagan.com>
          Signed-off-by: Julia Evans <julia@jvns.ca>
     @@ Documentation/gittutorial.adoc (new)
      +1. Git to be installed. You might already have it installed,
      +   and if not there are directions at https://git-scm.com/install/
      +2. A terminal to use. On Windows, you can use Git Bash which comes
     -+   when you install Git.
     ++   when you install Git. For Windows this tutorial will assume you're
     ++   using Git Bash and if not you might need to adjust some commands like
     ++   `ls` and `cat`.
      +
      +You can check if Git is installed by running this in your terminal:
      +
     @@ Documentation/gittutorial.adoc (new)
      +------------------------------------------------
      +
      +The exact version isn't too important: this tutorial is designed to work
     -+with any version of Git after 2.0.
     ++with any version of Git after 2.23.0.
      +
      +[[step_2]]
      +Step 2: Introduce yourself to Git
     @@ Documentation/gittutorial.adoc (new)
      +but we're not covering that here.
      +
      +Step 3: Create an empty folder and 1 file
     -+------------------------------------------
     ++-----------------------------------------
      +
     -+In your terminal, create an empty folder and change directories into it.
     ++In your terminal, create an empty folder and move into it.
      +Later on you could follow the same steps in this tutorial to take an
      +existing project and start managing it with Git, but we're going to use
      +an empty project so that everyone following this tutorial has the exact
      +same files.
      +
     -+For example, run these commands to make a folder called `myproject`
     ++For example, run these commands to make a folder called `myproject`:
      +
      +------------------------------------------------
      +$ mkdir myproject
     @@ Documentation/gittutorial.adoc (new)
      +
      +You've now stored the first version of your project in Git!
      +
     ++`git status` is very important
     ++------------------------------
     ++
     ++`git status` shows you the current state of your Git repository.
     ++It can give a huge amount of different information that takes
     ++practice to interpret, so this tutorial has several examples of
     ++how to interpret the output of `git status` in different situations.
     ++
     ++It's often useful to run `git status` before and after running a Git
     ++command to see how it changed things.
     ++
      +Step 6: Make a change
      +---------------------
      +
     @@ -1,2 +1,2 @@
      +$ git add example.txt
      +----------
      +
     -+Then you can run `git commit` to commit it.
     ++Then you can run `git commit` to commit it (though see the warning in
     ++the next section!).
     ++
     ++Warning about terminal text editors
     ++-----------------------------------
     ++
     ++If you run `git commit` without any arguments, Git will open a
     ++text editor in the terminal for you to use to edit your commit message.
     ++This lets you write a longer commit message with more details.
     ++By default, Git uses the `vi` text editor, which is extremely difficult
     ++to use if you're not used to it.
     ++
     ++Some signs that you're trapped in `vi`: suddenly typing doesn't work
     ++anymore, and there are tilde `~` characters on the left of the screen.
     ++
     ++If Git opens `vi` and you'd rather use a different editor, you can
     ++handle it like this:
     ++
     ++1. Quit by typing `Escape`, then `:q!` and then `Enter`
     ++2. Run `git config --global core.editor YOUR_PREFERRED_EDITOR`
     ++   to configure which editor to use. For example, `nano` is available
     ++   on a lot of systems and has basic instructions on the screen for how
     ++   to use it.
     ++3. Run `git commit` again
     ++
     ++If you don't want to set up a text editor yet, you can also just use
     ++`git commit -m"your message"` like we did earlier in this tutorial.
      +
      +Step 8: Make a change and throw it away
      +---------------------------------------
     @@ -1,2 +1,2 @@
      +This "working tree clean" message means that there haven't been any
      +changes since your last commit.
      +
     -+Now make a change to your code, and run `git status` again. Like last
     ++Now make a change to `README.md`, and run `git status` again. Like last
      +time, you should see a message like this:
      +
      +------------------------------------------------
     @@ -1,2 +1,2 @@
      +source Git forge software to your server.
      +
      +Step 10: Create an SSH key (if needed)
     -+-------------------------------------
     ++--------------------------------------
      +
      +For Git to upload changes to another Git repository, it needs a way to
      +login to that repository. One of the most popular ways to do this is
     @@ -1,2 +1,2 @@
      +$ ls ~/.ssh/*.pub
      +-------------------------------------------
      +
     -+That will output something like
     ++That will output something like this. The exact filename depends on the type
     ++of key. The important thing is that you're looking for a filename that
     ++ends in `.pub` ("pub" stands for "public"):
      +
      +-------------------------------------------
      +/home/alice/.ssh/id_ed25519.pub
      +-------------------------------------------
      +
     -+Copy the contents of that file to your clipboard. It's important that
     -+the filename ends in `.pub` ("pub" stands for "public").
     ++Copy the contents of that file to your clipboard. One way to do that is
     ++to run this command (replacing the filename with the right filename),
     ++and then copy the output.
     ++
     ++-------------------------------------------
     ++cat /home/alice/.ssh/id_ed25519.pub
     ++-------------------------------------------
      +
      +Then login to your account on the Git host you chose and paste the SSH
      +key into the appropriate place. Depending on the Git host, it's likely
     @@ -1,2 +1,2 @@
      +-------------------------------------------
      +
      +[[step_14]]
     -+Step 14: push your changes
     ++Step 14: Push your changes
      +--------------------------
      +
      +Finally, we're ready to send the information in your local Git repository
     @@ -1,2 +1,2 @@
      +You should be able to fix this by redoing <<step_12,Step 12>>.
      +Then <<step_14,Step 14>> should work.
      +
     -+MORE USEFUL GIT COMMANDS
     ++More useful Git commands
      +------------------------
      +
      +We're not going to cover collaboration at all in this tutorial, but here are a
     @@ -1,2 +1,2 @@
      +  If you see a commit with `git log` that you want more details about,
      +  you can run `git show COMMIT_ID` to see what changes that made since
      +  the previous commit (linkgit:git-show[1])
     -+
     -+SEE ALSO
     -+--------
     -+linkgit:git-help[1],
     ++* To get a list of common Git commands, run `git help` (linkgit:git-help[1])
      +
      +GIT
      +---

-- 
gitgitgadget
