Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795554793;
	b=falRMJ1zgv6KXkKOUEe+2WLblNsk6GF/SCxRzaZ1oproQvxkoO9hI/sFvt/89ACfzS+o
	 dZ1xXH4dQ0QlCDPh11Cf/qL3YwortghNoD/U8o7zsSA1CQIjvC7HhAJzDcihRpyfbwHja
	 j2l3DM1E2JQx/dDF+v0YzoFWebVWZG9LzPGfeSlaaaK4yLPogE4h6jgoxxGdAKzRCksAs
	 i6X420onEnuFph899veJ3OVn+CBcnMLMtSAMpfJo3nNgVwjyzqMUDyhsjVYeDFTW+R/9K
	 ckpndsb38dK/jMYaIFtsFQNRKPYql/rTj1y4/UVjIy0GEYQDgBvCKshUFsy08ObJKuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795554793;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=Nb9tvfyC6biHaKCTkJv61zZUaJSPLvajCAITg/UaTDM=;
	b=eNErwS0DCy/98GVKm84HRT0Lv+RkNhGsKwXRuVqGgQ9ptayGtAsKMhY5HylHRQ8DKP5b
	 iXyxsM3DoEsnf7pRyO7bibownW6nBxECbl5YEwPF0qMXEClh8FSBrEOOWK7T20g4GPLhK
	 l6CjaH35RFAcM15pwLr5d1rZE7Q+In7tG1aojBq4R4GXeuw9TZGnvZiuhNNyQQtV98w6O
	 K+qdw9ka6aDLTiM1xt9TyMkjKq7es+6QbSDM4FxXsgHbhcd7RIY2bxLWv4cssQ2tsPcor
	 Zymy253jnQpXfD3FVzqfpel8H63ERXsqvnsJD0/5pcPZvPkOWRTAAQEXKVqvi2sJAog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JBhTp3hy;
	arc=none smtp.remote-ip=209.85.222.170
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780B9606A323
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 21:13:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 780B9606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JBhTp3hy
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-94961b68685so427666485a.3
        for <git@vger.kernel.org>; Tue, 24 Nov 2026 13:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795554791; x=1796159591; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Nb9tvfyC6biHaKCTkJv61zZUaJSPLvajCAITg/UaTDM=;
        b=JBhTp3hy+8XQdlUfvO7oOS0ncNFtirxBdMzolREy/P5yPXptGg6TNtHx6lHCwaUPxL
         xAOgqHnXhqmm1Lm59cXCyvkNiEhW+uUaZkLzIEE+awQaTL4z+nGADKYdufhUlqU4UF1A
         RcUYFIETN+yAmqi35r0r0ONuPqHHL7J6mkOYQmsnnfKpguD3KwkSkWmdoLpNDHklVtR4
         Meq74XDYot9xvUmvBgYqZJTniazcnOBoUdw8eptnUR7yJ/pX79fOE0o98uz3kjWThBG9
         Knd/W5mvdjj732Mzg/izf5NqJaSfwL4v/gXcmlzLXSegiB7qxtz7SYkmrGNU4CxFMDEH
         9Eyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795554791; x=1796159591;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Nb9tvfyC6biHaKCTkJv61zZUaJSPLvajCAITg/UaTDM=;
        b=AetJb22bO9bg4ld94fWIudMO2J3JeLUD8xbTkYVY7jSWz9rds1Z5vHTtRcPKWzBmTO
         dNEygRzcX31uKAW2BBcIkPAJMZZKoJgvqz/3nt92EBDOiUUmXaSIwP+QkBQBwoPkhiep
         SWxIGJSSJ2okMKZDl5VN8IIvSKx9hD0MHUovMFa/R6sWMnM+4znOoxXc8TbyJFBl+ZT2
         XWcXTtiJvgbSwK+hv82fALyOtud87/RSsP/T6I/f2yWfcTNrU2xEdjqqW9XS7YoT8t1A
         gJRUBlCUcUNQGziYmgliwGKsSLI4G0eEFovC8RX8KPTnanzTBfsocMJhJdooT3UESraW
         aTZg==
X-Gm-Message-State: APuU4Z+Nw9dsagSNhbhmoK1eUTu6XFbBhcDqG0ZJNVnXwGtMf8x6xRhO
	rYAetY82BW2RrFmcp3stuGiIrUW/ElGD7naB3X7WcfWhfC9NYaFqIcO5ihaqww==
X-Gm-Gg: AZFdTZeSKNw/xrqiPnedLmosj/EXSATJPvZrEZVYnRHVKmEpQuFlo3a+pBAMXnsBOUt
	fSmLrItMgNQ6wICTaUQAwHEPCihxsCeDa98f0RAVqh4bc8Dr88HRKGcLB5QtCl4GZFnMwOA1Qua
	A5GLxZbCtgYVZ2lwutsNXaLEAx0rjIiQqO0cHVjuQjOXPxK5wmhu7T554fgjDBwhJAP1jkScD1f
	f1rECFotWRhsVSdIexT0fw/yTeRtNkL3tB5QsLtoX+U9YiLaB5/MuO4eW0ShMx9ROZAks36TpP0
	sha2WsH89K0juQF0fUIvLh+ZLVIQlWZMolrltXhP8hgIFLoEQ1pt362RukZTXO4dRb+/X8MYVJR
	DXObljJAOqjMClAQdIvBruNX4zu1r3da19QYfqRYp45KXTqOKi1J/XefC8P8T4gmBLNIWnWK8Is
	ZPknMmWi4AfcZooUDsYc6N4N4uIPz9MD/2m2WrfRRVgOJOFUN2OB2E1OOUEY1tXkxSNQLFzyFcX
	4hbllk2fh/XOmAkfIOB/Auw7u7EL8KE0z+eLmiygEcNk8QZWUDawbrw5uP0Ko26xV/Dah304Kxa
	5ams1CuymrLONabvfcrp8W5AgNj6NgHa9FyqLyj4/CE54USEuvOTFZBy
X-Received: by 2002:a05:620a:270d:b0:949:3ea1:3021 with SMTP id af79cd13be357-949bab6d711mr2762442785a.68.1795554789754;
        Tue, 24 Nov 2026 13:13:09 -0800 (PST)
Received: from [127.0.0.1] ([172.178.117.219])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb3cb882sm1147107285a.27.2026.11.24.13.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 13:13:09 -0800 (PST)
Message-Id: <pull.2307.v2.git.1795554788715.gitgitgadget@gmail.com>
In-Reply-To: <pull.2307.git.1794259990263.gitgitgadget@gmail.com>
References: <pull.2307.git.1794259990263.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 24 Nov 2026 21:13:08 +0000
Subject: [PATCH v2] doc: add tutorial on branches for beginners
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
    Patrick Steinhardt <ps@pks.im>,
    Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

Because Git's branches are so flexible and the meaning of a branch is
only what people assign to it, it's important to talk about some of the
social context about branches. Do this in two ways:

1. Introduce some imaginary characters who are learning branches for the
   first time and examples of workflows they might use. Test readers
   said this was helpful because it helped them see different ways
   they might use branches.
2. Explain the importance of a "main" or "master" branch in many
   projects, and give a few examples of how projects might use it.

On `git log`:

- Use the output of `git log --graph` to visualize branches instead of
  a more abstract ASCII diagram, since it serves a double purpose of
  teaching people how to read `git log`'s output.
  But also mention that folks may prefer to use a GUI to visualize
  branches.
- Include two sections to explain the output of `git log`, since several
  test readers found it very hard to understand. In that explanation,
  only explain `HEAD` fairly briefly and instead keep the focus on the
  idea of a "current branch", since that's the term Git's UI normally
  uses.

On the conceptual introduction at the beginning:

- One of the biggest issues with explaining branches is that there are 3
  ways in Git to think of branches and it's not straightforward to
  explain how to reconcile them:
  1. just the commits that "branch off"
  2. the latest commit on the branch
  3. the full history since the beginning of time
  Handle this by starting with the "tree" metaphor where branches
  "branch off" a central trunk (way 1), since this makes sense with how
  people actually want to use branches. Point out some issues with the
  tree metaphor and talk about how it relates to the way Git represents
  branches (way 2).
- Avoid using computer science jargon, because it's a major barrier to
  folks without a CS background. It's not useful or realistic to teach
  most beginners the term "directed acyclic graph" just so they can
  learn branches. Mention the term "directed acyclic graph" briefly in a
  note for folks who are already familiar with that term and link folks
  to the data model if they'd like more information.
- Include some basic facts about commits. Folks seemed to find this
  helpful, one person said they didn't realize it would be so hard to
  change their email address later.

To keep it readable:
- Don't assume that the reader has read `gittutorial`, and instead
  refer back to it explicitly if it's relevant.
- Always include the output for every command. Test readers said
  this was helpful.

Other choices about material that is/isn't included:

- `git-prompt.sh` (yes): Mention how important it is to be aware
  what branch you're on, and suggest using `git-prompt.sh`. Link to
  git-prompt.sh on GitHub since several test readers couldn't find it on
  their machine. The test readers liked this.
- fast-forward merges (yes): Explain the difference between a fast-forward
  merge and a merge commit by giving examples of what each one looks
  like.
- upstreams/rebase (no): Don't explain what an upstream is or introduce
  rebase, since we're already introducing a lot of concepts. Instead
  include a "Where to learn more" section with some pointers to where to
  continue learning.
- GUIs (yes): Some readers wanted a suggestion for what GUI to use. It's
  very hard to suggest an appropriate GUI because there are so many and
  so many of them are not open source, but give a couple of suggestions
  of open source tools that seem to be popular with the community. Also
  mention that many non-open-source IDEs have built-in Git integrations
  for folks who are already using those tools who might not be aware,
  since they're a popular way to use Git.

Co-Authored-By: Marie Claire LeBlanc Flanagan <hello@marieflanagan.com>
Signed-off-by: Marie Claire LeBlanc Flanagan <hello@marieflanagan.com>
Signed-off-by: Julia Evans <julia@jvns.ca>
---
    doc: add tutorial on branches for beginners
    
    This was reviewed by 17 test readers who overall said it helped them
    understand branches. We addressed the feedback from the test readers to
    improve it before submitting it here.
    
    I think it would be good to add a little table of contents to
    gittutorial.adoc to match this one's TOC as well. I'm not sure what the
    best way to do that is since my understanding is that rebasing on the
    latest master causes problems.
    
    Changes in v2:
    
     * Use a $ for the commands for consistency (thanks to Junio)
     * Add more details in the example workflows to make sure they make
       sense logically (thanks to Junio)
     * Make sure the characters are alphabetized in the section order and in
       sentences. Rename Emilia -> Anita, Abdul -> Bruno, Betsy -> Carmen,
       Carmen and Daniela -> Daniela and Emilia. Keep the genders the same
       so we don't have to change all the pronouns. (thanks to Junio)
     * Deal with the poorly structured sections that Ben pointed at the end
       as follows:
       * Add a summary at the beginning to explain the overall structure
       * Move "3 ways to think about a branch" to the middle, right after
         creating the branch we're using as an example
       * Move the merge conflicts section to a note at the end of Step 13
       * Rename some of the headings to more clearly explain the structure
         (around "the step by step tutorial" and "Examples of using branches
         to collaborate")
     * Delete the "We normally start from main because if you create a
       branch called two..." explanation and instead just say that we want
       to keep branches independent (thanks to Ben)
     * One test reader said that in "3 ways to think about a branch", it was
       confusing to them than #1 and #3 were the same (just one commit). Add
       an extra commit to the add-fruits branch so that the branch has 2
       commits, to make it more clear what a branch with multiple commits on
       it looks like.
    
    Note: I used this script
    https://gist.github.com/jvns/bcd36fdd42952b9ec9a67ec139dba13e to create
    the example repository used in this document and to copy and paste the
    example output from. Not sure if we should store the contents of that
    script somewhere: it's very annoying to update the examples without it.
    I also realized there's an issue with that script where, because it
    hardcodes GIT_COMMITTER_DATE, all the commits happen at the same time,
    which makes the order of git log a bit weird. I manually adjusted Step
    12 to account for that.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2307%2Fjvns%2Ftutorial-branches-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2307/jvns/tutorial-branches-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2307

Range-diff vs v1:

 1:  5eaecda843 ! 1:  d6824feca4 doc: add tutorial on branches for beginners
     @@ Documentation/gittutorial-branches.adoc (new)
      +- Part 1 (linkgit:gittutorial[7]): Introduction to commits and `git push`
      +- Part 2 (you are here): Introduction to branches
      +
     ++This tutorial contains:
     ++
     ++1. <<intro,An introduction to branches>>
     ++2. <<tutorial,A step-by-step practical tutorial>>
     ++3. <<workflows,Example collaboration workflows>>
     ++4. <<tip,Tips, GUI tools, and where to learn more>>
     ++
     ++
      +Meet some example Git users
      +---------------------------
      +
     @@ Documentation/gittutorial-branches.adoc (new)
      +branches differently in different situations, so it might be useful for
      +you to think about which is closest to your situation.
      +
     -+1. Abdul is making his first contribution to Python, a large open
     ++1. Anita is using Git on her own to write her PhD thesis with LaTeX.
     ++2. Bruno is making his first contribution to Python, a large open
      +   source project.
     -+2. Betsy is a Go developer for a social media website which has 100
     ++3. Carmen is a Go developer for a social media website which has 100
      +   other software developers. All of her changes need to be reviewed by a
      +   coworker before they're released.
     -+3. Carmen and Daniela are building a website for their local cat
     ++4. Daniela and Emilia are building a website for their local cat
      +   shelter. They're the only two people on the project.
     -+4. Emilia is using Git on her own to write her PhD thesis with LaTeX.
      +
     ++[[intro]]
      +Why use branches?
      +-----------------
      +
     @@ Documentation/gittutorial-branches.adoc (new)
      +`Another update to README.md` could originally have been created on a
      +different branch that was deleted after merging it into `main`.
      +
     -+The practical part
     -+------------------
     ++[[tutorial]]
     ++Step-by-step tutorial
     ++---------------------
      +
      +Now let's talk about how to actually use branches.
      +
     @@ Documentation/gittutorial-branches.adoc (new)
      +First, create an empty directory, move into it, and start a new Git repository:
      +
      +----
     -+mkdir myproject
     -+cd myproject
     -+git init
     ++$ mkdir myproject
     ++$ cd myproject
     ++$ git init
      +----
      +
      +Then open your text editor and create a file called `README.md`, with
     @@ Documentation/gittutorial-branches.adoc (new)
      +Then add the file and commit it, by running these commands:
      +
      +----
     -+git add README.md
     -+git commit -m "Initial commit"
     ++$ git add README.md
     ++$ git commit -m "Initial commit"
      +----
      +
      +Next, edit README.md and make another commit, like this:
      +
      +----
     -+git commit -am "Update README.md"
     ++$ git commit -am "Update README.md"
      +----
      +
      +`git commit -am` commits the current version of all files that Git is
     @@ Documentation/gittutorial-branches.adoc (new)
      +
      +
      +----
     -+git log --oneline
     ++$ git log --oneline
      +----
      +
      +The output should look something like this, though with
     @@ Documentation/gittutorial-branches.adoc (new)
      +We're only going to talk about 2 kinds of decorations here:
      +`(main)` and `(HEAD -> main)`. Here's how to read each of them:
      +
     -+- `e9c0b17 (main)` means that `e9c0b17` is the latest commit on the `main` branch.
     ++- `e9c0b17 (main)` means that `e9c0b17` is the latest commit
     ++  on the `main` branch.
      +- `e9c0b17 (HEAD -> main)` means that `e9c0b17` is the latest commit on
      +  the `main` branch, AND that `main` is the current branch.
      +
     @@ Documentation/gittutorial-branches.adoc (new)
      +Now make a third commit, by editing `README.md` again, and running this command:
      +
      +----
     -+git commit -am "Another update to README.md"
     ++$ git commit -am "Another update to README.md"
      +----
      +
      +Now run `git log --oneline` again to see how our branch looks now.
     @@ Documentation/gittutorial-branches.adoc (new)
      +First, create the branch and switch to it, by running this command:
      +
      +----
     -+git switch -c add-fruits
     ++$ git switch -c add-fruits
      +----
      +
      +The `-c` flag stands for "create". You should see the output:
     @@ Documentation/gittutorial-branches.adoc (new)
      +some fruits in it. Then add it and commit, like this:
      +
      +----
     -+git add fruits.txt
     -+git commit -m "Add fruit list"
     ++$ git add fruits.txt
     ++$ git commit -m "Add fruit list"
     ++----
     ++
     ++Now edit `fruits.txt` again and commit it again, so that we can see what
     ++it looks like when you make 2 commits on a branch.
     ++
     ++----
     ++$ git add fruits.txt
     ++$ git commit -m "Update fruit list"
      +----
      +
      +Run `git log --oneline` again to get a list of all the commits on the
      +current branch.
      +
      +----
     -+cd4bb48 (HEAD -> add-fruits) Add fruit list
     ++36d0cbf (HEAD -> add-fruits) Update fruit list
     ++cd4bb48 Add fruit list
      +37634fd (main) Another update to README.md
      +e9c0b17 Update README.md
      +2e018a5 Initial commit
     @@ Documentation/gittutorial-branches.adoc (new)
      +See <<read_oneline,How to read `git log --oneline`'s output>> above for
      +an explanation of how to interpret this output.
      +
     -+To summarize, this tells us that there's been 1 commit ("Add fruit list")
     -+since our `add-fruits` branch split off from the `main` branch.
     ++To summarize, this tells us that there have been 2 commits
     ++("Add fruit list" and "Update fruit list") since our `add-fruits` branch
     ++split off from the `main` branch.
     ++
     ++3 ways to think about a branch
     ++------------------------------
     ++
     ++In Git there are always 3 ways to think about a branch, and different
     ++commands will treat a branch in different ways. For example, let's look
     ++at the 3 ways to think about this `add-fruits` branch.
     ++
     ++-----
     ++* 36d0cbf (HEAD -> add-fruits) Update fruit list
     ++* cd4bb48 Add fruit list
     ++* 37634fd (main) Another update to README.md
     ++* e9c0b17 Update README.md
     ++* 2e018a5 Initial commit
     ++-----
     ++
     ++We can think of the `add-fruits` branch as:
     ++
     ++1. Just the 2 commits that "branched off" of the `main` branch
     ++   (`cd4bb48` and `36d0cbf`).
     ++2. The full history of the branch since the beginning of the repository,
     ++   including all the commits on `main` (5 commits in this case).
     ++   For example, `git log add-fruits` will show you the full history.
     ++3. Just the latest commit on that branch (`36d0cbf`).
     ++   For example, `git show add-fruits` will show you the latest commit.
      +
      +Step 6: Get a list of all branches
      +----------------------------------
     @@ Documentation/gittutorial-branches.adoc (new)
      +You can get a list of all branches by running this command:
      +
      +----
     -+git branch
     ++$ git branch
      +----
      +
      +The output should look like this:
     @@ Documentation/gittutorial-branches.adoc (new)
      +Change your current branch to `main` by running:
      +
      +----
     -+git switch main
     ++$ git switch main
      +----
      +
      +This command:
     @@ Documentation/gittutorial-branches.adoc (new)
      +README.md
      +-----
      +
     ++[NOTE]
     ++Older Git tutorials used `git checkout` to switch branches.
     ++`git switch` is a newer command which is easier to learn because it
     ++only has one job.
     ++
      +Step 8: Create another branch
      +-----------------------------
      +
     @@ Documentation/gittutorial-branches.adoc (new)
      +branches to show what the process of working on multiple changes at the
      +same time looks like.
      +
     -+First, switch back to the `main` branch. This is important because
     -+normally when you start a new branch, you'll start it from the
     -+current `main`.
     -+
     -+We normally start from `main` because if you create a branch called `two`
     -+while on the `one` branch, merging `two` into `main` will also
     -+merge `one`. Starting from `main` keeps all the branches separate.
     ++You'll usually want to start all new branches from the `main` branch
     ++to keep your branches independent from each other. Right now
     ++we're on the `add-fruits` branch, so we need to switch back to the
     ++`main` branch:
      +
      +-----
     -+git switch main
     ++$ git switch main
      +-----
      +
      +Then create a branch called `add-animals`.
      +
      +-----
     -+git switch -c add-animals
     ++$ git switch -c add-animals
      +-----
      +
      +Now create a file named `animals.txt` with some animal names in it, add
      +it, and commit it.
      +
      +-----
     -+git add animals.txt
     -+git commit -m "Add animal list"
     ++$ git add animals.txt
     ++$ git commit -m "Add animal list"
      +-----
      +
      +Step 9: Look at our branches and commits
     @@ Documentation/gittutorial-branches.adoc (new)
      +Run this command to show all branches and commits:
      +
      +-----
     -+git log --oneline --graph --all
     ++$ git log --oneline --graph --all
      +-----
      +
      +The output should look like this:
      +
      +-----
      +* 1ceb7b4 (HEAD -> add-animals) Add animal list
     -+| * cd4bb48 (add-fruits) Add fruit list
     ++| * 36d0cbf (add-fruits) Update fruit list
     ++| * cd4bb48 Add fruit list
      +|/
      +* 37634fd (main) Another update to README.md
      +* e9c0b17 Update README.md
     @@ Documentation/gittutorial-branches.adoc (new)
      +
      +-----
      +* 1ceb7b4 (HEAD -> add-animals) Add animal list
     -+| * cd4bb48 (add-fruits) Add fruit list
     ++| * 36d0cbf (add-fruits) Update fruit list
     ++| * cd4bb48 Add fruit list
      +|/
      +* 37634fd (main) Another update to README.md
      +* e9c0b17 Update README.md
     @@ Documentation/gittutorial-branches.adoc (new)
      +See <<read_oneline,How to read `git log --oneline`'s output>> above for
      +how to read the decorations like `(main)` or `(HEAD -> add-animals)`.
      +
     -+Overall this shows that the `add-animals` and `add-fruits` branches have
     -+both added one new commit since they split off from the `main` branch.
     ++Overall this shows that the `add-animals` branch has added 1 commit and
     ++`add-fruits` has added 2 commits since they split off from the `main`
     ++branch.
      +
      +Step 10: Merge the `add-animals` branch into `main`
      +---------------------------------------------------
     @@ Documentation/gittutorial-branches.adoc (new)
      +Merge `add-animals` into the main branch by running these two commands:
      +
      +----
     -+git switch main
     -+git merge add-animals
     ++$ git switch main
     ++$ git merge add-animals
      +----
      +
      +The output should look like this:
     @@ Documentation/gittutorial-branches.adoc (new)
      +Step 11: Delete the `add-animals` branch
      +----------------------------------------
      +
     -+Now that you've integrated `add-animals` branch into `main`, you can
     ++Now that you've integrated the `add-animals` branch into `main`, you can
      +safely delete it. Delete the branch by running this command. `-d` stands
      +for "delete":
      +
      +-----
     -+git branch -d add-animals
     ++$ git branch -d add-animals
      +-----
      +
      +Running this is safe: it'll refuse to delete any branch that hasn't
     @@ Documentation/gittutorial-branches.adoc (new)
      +and commits again:
      +
      +-----
     -+git log --oneline --graph --all
     ++$ git log --oneline --graph --all
      +-----
      +
      +The output should look like this:
      +
      +-----
     -+* cd4bb48 (add-fruits) Add fruit list
     -+| * 1ceb7b4 (HEAD -> main) Add animal list
     ++* 1ceb7b4 (HEAD -> main) Add animal list
     ++| * 36d0cbf (add-fruits) Update fruit list
     ++| * cd4bb48 Add fruit list
      +|/
      +* 37634fd Another update to README.md
      +* e9c0b17 Update README.md
     @@ Documentation/gittutorial-branches.adoc (new)
      +Now run `git merge` to see what happens:
      +
      +----
     -+git merge --no-edit add-fruits
     ++$ git merge --no-edit add-fruits
      +----
      +
      +The `--no-edit` option tells `git merge` to use the default commit
     @@ Documentation/gittutorial-branches.adoc (new)
      +Once the branch is merged, delete it by running:
      +
      +----
     -+git branch -d add-fruits
     ++$ git branch -d add-fruits
      +----
      +
      +To see what `git merge` did, run `git log --oneline --graph` again.
      +
      +----
     -+*   e3c630d (HEAD -> main) Merge branch 'add-fruits'
     ++*   576d053 (HEAD -> main) Merge branch 'add-fruits'
      +|\
     ++| * 36d0cbf Update fruit list
      +| * cd4bb48 Add fruit list
      +* | 1ceb7b4 Add animal list
      +|/
     @@ Documentation/gittutorial-branches.adoc (new)
      +* 2e018a5 Initial commit
      +----
      +
     -+Here you can see that it created a new commit `e3c630d`. This commit
     ++Here you can see that it created a new commit `576d053`. This commit
      +looks different from the other commits because it has two parents:
     -+cd4bb48 ("Add fruit list") and 1ceb7b4 ("Add animal list"). This kind
     ++`36d0cbf` ("Update fruit list") and `1ceb7b4` ("Add animal list"). This kind
      +of commit with two parents is called a "merge commit".
      +
     -+Note: merge conflicts
     -+---------------------
     -+
     -+Git has an automatic merge algorithm to combine the code from two
     -+branches. In the example from Step 13, it's simple: one side added
     -+`fruits.txt` and the other side added `animals.txt`, so the merge adds
     -+both files.
     -+
     -+But if the two branches both edited the same lines of the same files,
     -+Git will ask you to decide how to handle it. This is called a "merge
     -+conflict".
     -+
     -+See linkgit:gitmergeconflicts[7] (`git help mergeconflicts`) for a
     -+guide to handling merge conflicts.
     -+
     -+3 ways to think about branches
     -+------------------------------
     -+
     -+In Git there are always 3 ways to think about a branch, and different
     -+commands will treat a branch in different ways. For example, let's look
     -+at the earlier setup again with the `add-fruits` branch. It has a `main`
     -+branch with 3 commits on it, and an `add-fruits` branch with one commit.
     -+
     -+-----
     -+  * cd4bb48 (add-fruits) Add fruit list
     -+ /
     -+* 37634fd (main) Another update to README.md
     -+* e9c0b17 Update README.md
     -+* 2e018a5 Initial commit
     -+-----
     -+
     -+We can think of the `add-fruits` branch as:
     -+
     -+1. Just the 1 commit that "branched off" of the `main` branch (`cd4bb48`).
     -+2. The full history of the branch since the beginning of the repository,
     -+   including all the commits on `main` (4 commits in this case).
     -+   For example, `git log add-fruits` will show you the full history.
     -+3. Just the latest commit on that branch.
     -+   For example, `git show add-fruits` will show you the latest commit.
     ++[NOTE]
     ++If you merge two branches which both edited the same lines of the
     ++same files, Git will ask you to decide how to handle it. This is
     ++called a "merge conflict". See linkgit:gitmergeconflicts[7]
     ++(`git help mergeconflicts`) for a guide to handling merge conflicts.
      +
     -+How to use branches to collaborate: it depends
     -+----------------------------------------------
     ++[[workflows]]
     ++Examples of using branches to collaborate
     ++-----------------------------------------
      +
      +There are lots of ways to use branches to collaborate with other people.
      +We don't have space for a full guide to collaborating with Git here, but
     -+after a very quick introduction to `git pull`, we'll give examples of
     ++we'll give a quick introduction to `git pull` and examples of
      +how each of our characters from the beginning might use branches.
      +
      +In these examples we're going to use `git push`, `git pull`, `git
      +clone`, and `git remote add`. For a basic introduction to `git push` and
      +`git remote add`, see Step 14 of linkgit:gittutorial[7].
      +
     -+Using `git pull`: the basics
     -+----------------------------
     ++Intro to `git pull`
     ++-------------------
      +
      +Here's the simplest way to use `git pull`.
      +
     @@ Documentation/gittutorial-branches.adoc (new)
      +branch.
      +
      +-------
     -+git clone https://example.com/example.git
     ++$ git clone https://example.com/example.git
      +-------
      +
      +After cloning a repository, you can run `git pull` while on the main
      +branch to update it with the latest version, like this:
      +
      +-------
     -+git switch main
     -+git pull
     ++$ git switch main
     ++$ git pull
      +-------
      +
      +This is all you need to know about `git pull` to understand these
      +examples.
      +
     -+Example: Emilia the PhD student
     -+-------------------------------
     ++Example: Anita the PhD student
     ++------------------------------
      +
     -+Emilia is writing her PhD thesis. She follows the steps from
     ++Anita is writing her PhD thesis. She follows the steps from
      +linkgit:gittutorial[7] to set up a Git repository on the Internet so
      +that she can back up her work.
      +
      +To back up her work after making a commit, she runs:
      +
      +----
     -+git push origin main
     ++$ git push origin main
      +----
      +
      +Sometimes, she creates a branch to make an experimental change she's not
     @@ Documentation/gittutorial-branches.adoc (new)
      +She does this by running:
      +
      +----
     -+git switch -c rewrite-chapter-5
     ++$ git switch -c rewrite-chapter-5
      +----
      +
     -+If she decides that the experimental change should be merged, she merges
     ++Then she makes an experimental change, like rewriting Chapter 5 and commits it.
     ++If she decides that the change should be merged, she merges
      +it into `main` like this:
      +
      +----
     -+git switch main
     -+git merge rewrite-chapter-5
     ++$ git switch main
     ++$ git merge rewrite-chapter-5
      +----
      +
      +Or if she decides the rewrite of chapter 5 was a bad idea, she can
     -+delete the branch:
     ++switch back to `main` and delete the branch:
      +
      +----
     -+git branch -D rewrite-chapter-5
     ++$ git switch main
     ++$ git branch -D rewrite-chapter-5
      +----
      +
     -+Example: Abdul the open source contributor
     ++Example: Bruno the open source contributor
      +------------------------------------------
      +
     -+Abdul is contributing to an open source project for the first time.
     ++Bruno is contributing to an open source project for the first time.
      +
      +First, he finds the official Git repository for the project and clones
      +it, like this:
      +
      +----
     -+git clone https://example.com/project/project
     ++$ git clone https://example.com/project/project
      +----
      +
      +He doesn't have permission to push changes directly to that
      +project, so he creates his own copy of the repository at
     -+https://example.com/abdul/project.
     ++https://example.com/bruno/project.
      +
      +Then he adds that repository as a second remote, like this:
      +
      +----
     -+git remote add abdul https://example.com/abdul/project
     ++$ git remote add bruno https://example.com/bruno/project
      +----
      +
      +Before starting work on his branch, he makes sure that he has the
      +latest version of the `main` branch using `git pull`, like this:
      +
      +----
     -+git switch main
     -+git pull
     ++$ git switch main
     ++$ git pull
      +----
      +
      +Then he creates a new branch, like this:
      +
      +----
     -+git switch -c new-feature
     ++$ git switch -c new-feature
      +----
      +
      +Once he's done with his branch, he pushes the branch to his Git
      +repository, like this:
      +
      +----
     -+git push abdul new-feature
     ++$ git push bruno new-feature
      +----
      +
      +Then he goes through the open source project's process to submit his
      +branch for review.
      +
     -+Example: Betsy the corporate employee
     -+-------------------------------------
     ++Example: Carmen the corporate employee
     ++--------------------------------------
      +
      +On her first day of work, she clones the company's Git repository by
      +running:
      +
      +----
     -+git clone git@example.com:company/project
     ++$ git clone git@example.com:company/project
      +----
      +
      +She has access to push new branches to this repository with her work,
     @@ Documentation/gittutorial-branches.adoc (new)
      +latest version of the `main` branch using `git pull`, like this:
      +
      +----
     -+git switch main
     -+git pull
     ++$ git switch main
     ++$ git pull
      +----
      +
      +Then she creates a new branch, like this:
      +
      +----
     -+git switch -c new-feature
     ++$ git switch -c new-feature
      +----
      +
      +Once she's done with her branch, she pushes the branch to the company
      +Git repository, like this:
      +
      +----
     -+git push origin new-feature
     ++$ git push origin new-feature
      +----
      +
      +Then she goes through her company's process for getting branches merged.
      +
     -+Example: Daniela and Carmen with the cat shelter website
     ++Example: Daniela and Emilia with the cat shelter website
      +--------------------------------------------------------
      +
     -+Daniela and Carmen create a Git repository for their cat shelter website.
     ++Daniela and Emilia create a Git repository for their cat shelter website.
      +
      +They both clone it onto their computer like this:
      +
      +----
     -+git clone git@example.com:cat-shelter/kitties.git
     ++$ git clone git@example.com:cat-shelter/kitties.git
      +----
      +
      +They decide to work together by just pushing all of their commits to the
      +`main` branch, without using any other branches.
      +
     -+When Daniela wants to do work, she first runs `git pull` on the main
     ++When Emilia wants to do work, she first runs `git pull` on the main
      +branch, like this:
      +
      +----
     -+git pull
     ++$ git pull
      +----
      +
     -+She also checks in with Carmen to make sure they won't be working on
     -+the same files. Then she works on her changes. Then, before pushing her
     -+changes, she runs this command to merge any changes Carmen has made.
     ++She also checks in with Daniela to make sure they won't be working on
     ++the same files. Then she works on her changes and commits them.
     ++Then, before pushing her changes, she runs this command to merge any
     ++changes Daniela has made.
      +
      +----
     -+git pull --no-rebase
     ++$ git pull --no-rebase
      +----
      +
      +We don't have space for a full introduction to linkgit:git-pull[1]
     -+here, but `git pull` fetches Carmen's changes and merges them into the
     ++here, but `git pull` fetches Daniela's changes and merges them into the
      +current branch. The `--no-rebase` flag tells Git to use `git merge` to
      +do the merge.
      +
      +Then she pushes her changes with:
      +
      +----
     -+git push
     ++$ git push
      +----
      +
     ++[[tip]]
      +Tip: put your current branch in your shell prompt
      +-------------------------------------------------
      +


 Documentation/Makefile                  |   1 +
 Documentation/gittutorial-branches.adoc | 964 ++++++++++++++++++++++++
 Documentation/meson.build               |   1 +
 command-list.txt                        |   1 +
 4 files changed, 967 insertions(+)
 create mode 100644 Documentation/gittutorial-branches.adoc

diff --git a/Documentation/Makefile b/Documentation/Makefile
index b574ca2044..4f3fc9a97f 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -65,6 +65,7 @@ MAN7_TXT += gitremote-helpers.adoc
 MAN7_TXT += gitrevisions.adoc
 MAN7_TXT += gitsubmodules.adoc
 MAN7_TXT += gittutorial-2.adoc
+MAN7_TXT += gittutorial-branches.adoc
 MAN7_TXT += gittutorial.adoc
 MAN7_TXT += gitworkflows.adoc
 
diff --git a/Documentation/gittutorial-branches.adoc b/Documentation/gittutorial-branches.adoc
new file mode 100644
index 0000000000..579975ba4d
--- /dev/null
+++ b/Documentation/gittutorial-branches.adoc
@@ -0,0 +1,964 @@
+gittutorial-branches(7)
+=======================
+
+NAME
+----
+gittutorial-branches - How to use branches
+
+DESCRIPTION
+-----------
+
+This is part of a 2-part series on Git for beginners:
+
+- Part 1 (linkgit:gittutorial[7]): Introduction to commits and `git push`
+- Part 2 (you are here): Introduction to branches
+
+This tutorial contains:
+
+1. <<intro,An introduction to branches>>
+2. <<tutorial,A step-by-step practical tutorial>>
+3. <<workflows,Example collaboration workflows>>
+4. <<tip,Tips, GUI tools, and where to learn more>>
+
+
+Meet some example Git users
+---------------------------
+
+To start, we're going to introduce a few imaginary people who are learning
+to use Git branches for the first time. This is because people use
+branches differently in different situations, so it might be useful for
+you to think about which is closest to your situation.
+
+1. Anita is using Git on her own to write her PhD thesis with LaTeX.
+2. Bruno is making his first contribution to Python, a large open
+   source project.
+3. Carmen is a Go developer for a social media website which has 100
+   other software developers. All of her changes need to be reviewed by a
+   coworker before they're released.
+4. Daniela and Emilia are building a website for their local cat
+   shelter. They're the only two people on the project.
+
+[[intro]]
+Why use branches?
+-----------------
+
+Branches are a tool to organize your work and collaborate. For example,
+if you're working on a website, you might be working on multiple
+unrelated changes at the same time, like:
+
+* an update to the FAQ
+* making the website faster
+* adding a translation into Bengali
+
+With branches, you can work on each change at its own pace without them
+interfering with each other.
+
+The "tree" mental model of branches
+-----------------------------------
+
+A useful mental model for Git branches is a tree where the "trunk"
+is the main branch, and there are other branches branching "off" of
+main.
+
+Each of the branches branching off has only a few commits of their own.
+When you finish working on a branch, you can merge its commits back into
+the main branch. This is where the metaphor starts to break down: in a
+real tree, branches that branch off from the trunk don't merge back in
+later, but in Git they can.
+
+For example, here's an ASCII art diagram of a Git repository. The most
+recent commits are at the top. The main branch is in the center and the
+others come off the sides.
+
+---------
+  \ |
+   \| /
+    |/
+    |
+    |
+    |
+---------
+
+This mental model doesn't represent every single thing you can do with
+Git branches, but you can go a long way with it.
+
+[NOTE]
+When the Git documentation uses the word "tree", it means something more
+like "directory tree of files", which is a completely different concept.
+If you want some jargon: the computer science term for "a tree where the
+branches can come back together" is "directed acyclic graph".
+
+The main branch
+---------------
+
+When you run `git init`, Git creates a default branch. Usually this is
+called `main` or `master`. Git mostly doesn't treat this branch in any
+special way (you could even delete that branch if you really want!),
+but for most people using Git this branch does have a special meaning.
+For example:
+
+* In an open source project like Python, the "main" branch might have
+  changes that the maintainers have approved to be in a future release
+* A website's "main" branch might be deployed to the server every time
+  it's updated
+* A PhD student's "main" branch might have the latest version of their
+  PhD thesis
+
+When joining a new project, it's important to understand how that
+project uses its main branch.
+
+In this tutorial we'll call this branch `main`.
+
+Some important facts about Git commits
+--------------------------------------
+
+Before explaining how branches work, here are some important facts about
+Git commits.
+
+**Every commit has an ID**. The ID is made of the numbers 0-9 and letters
+a-f, for example `501584c1bf29ab88e815c09ffb99c887da81241c`. You can
+find the current commit's ID by running `git log`: it's on the first
+line. In this tutorial you're going to see a lot of "short" commit IDs
+(for example `501584c`), which are the first 7 characters or so of the
+commit ID.
+
+**Commits never change**. If you have a commit ID, then the files,
+author, and history of that commit with that ID will never change in any
+way. This is one of Git's biggest strengths, but it also has drawbacks.
+It guarantees that if you have a commit's ID then you can always get
+back its exact contents, but it also makes it difficult to change old
+commits. For example, if someone changes their email address and wants
+to update it on their old commits, it can be very disruptive. You'd need
+to replace all the old commits with new commits with a different email
+address.
+
+**Every commit has a parent** (except the first commit).
+This means that if you have a commit ID, you can follow the pointers to
+the commit's parent(s) to get the whole history of the project up to that
+point.
+
+See linkgit:gitdatamodel[7] for more about how Git represents commits.
+
+
+How Git represents branches
+---------------------------
+
+Even though the way people think about the "main" branch and other
+branches is quite different (one is the "trunk", the others "branch off"
+of main), Git represents all branches in the same way.
+
+Git stores branches as a name and a commit ID. They're stored in the
+`.git` directory in your local Git repository, for example:
+
+----
+main: 37634fd
+add-fruits: cd4bb48
+----
+
+At first, this might seem totally unrelated to the "tree" mental model
+we talked about before. But because every commit has a reference to its
+parent, Git can follow the links from a commit to its parent to get the
+structure (the "tree") of the whole repository.
+
+For example, in this ASCII diagram, the commit below a commit is its
+parent:
+
+-------
+  * cd4bb48 (latest 'add-fruits' commit) Add fruit list
+ /
+* 37634fd (latest 'main' commit) Another update to README.md
+* e9c0b17 Update README.md
+* 2e018a5 Initial commit
+-------
+
+Branches are very cheap to create: when you create a new branch, Git
+just needs to store one commit ID. But this also means that we don't
+always know the history of how a branch evolved over time. For example
+`Another update to README.md` could originally have been created on a
+different branch that was deleted after merging it into `main`.
+
+[[tutorial]]
+Step-by-step tutorial
+---------------------
+
+Now let's talk about how to actually use branches.
+
+This tutorial is from the point of view of someone who's using branches
+to organize their own work, because it's simpler. There are some
+examples at the end of how this might change if you're using Git to
+collaborate, like one of the example users at the beginning.
+
+Step 1: Create an empty repository with two commits
+---------------------------------------------------
+
+Before we start working with branches, we need a Git repository to work
+with.
+
+First, create an empty directory, move into it, and start a new Git repository:
+
+----
+$ mkdir myproject
+$ cd myproject
+$ git init
+----
+
+Then open your text editor and create a file called `README.md`, with
+these contents:
+
+-----
+This is an example file.
+It has two lines.
+-----
+
+Then add the file and commit it, by running these commands:
+
+----
+$ git add README.md
+$ git commit -m "Initial commit"
+----
+
+Next, edit README.md and make another commit, like this:
+
+----
+$ git commit -am "Update README.md"
+----
+
+`git commit -am` commits the current version of all files that Git is
+tracking.
+
+Now we're set up and we can start creating branches.
+
+Step 2: Find your current branch
+--------------------------------
+
+In Git, you normally have a "current branch". You can see your current
+branch by running `git status`. It's usually on the first line, like this:
+
+----
+$ git status
+
+On branch main
+----
+
+Step 3: Look at the commits on your current branch
+--------------------------------------------------
+
+Run this command to get a list of all commits on your current
+branch.
+
+
+----
+$ git log --oneline
+----
+
+The output should look something like this, though with
+different commit IDs:
+
+----
+e9c0b17 (HEAD -> main) Update README.md
+2e018a5 Initial commit
+----
+
+In this tutorial, we're going to use `git log --oneline` over and over
+again to visualize our branch. If you have a Git GUI installed, its
+visualization might be easier to read.
+See <<guis,GUI tools>> for a list of GUIs.
+
+[[read_oneline]]
+How to read `git log --oneline`'s output
+----------------------------------------
+
+In `git log`'s output, the latest commit is at the top.
+Here's an example of what the output might look like:
+
+----
+e9c0b17 (HEAD -> main) Update README.md
+2e018a5 Initial commit
+----
+
+Each line has 3 parts:
+
+1. The commit ID (like `e9c0b17`)
+2. Optional extra info (like `(HEAD -> main)`). Git calls this a "decoration".
+3. The commit message (like `Update README.md`)
+
+We're only going to talk about 2 kinds of decorations here:
+`(main)` and `(HEAD -> main)`. Here's how to read each of them:
+
+- `e9c0b17 (main)` means that `e9c0b17` is the latest commit
+  on the `main` branch.
+- `e9c0b17 (HEAD -> main)` means that `e9c0b17` is the latest commit on
+  the `main` branch, AND that `main` is the current branch.
+
+[NOTE]
+`HEAD` is a special file in the `.git` directory where Git stores the
+name of your current branch. So you can read `HEAD -> main` as "current
+branch is main".
+
+Step 4: Make another commit
+---------------------------
+
+When you make a new commit, Git updates your current branch to point
+at that commit. Right now, `git log --oneline` looks like this, because
+we've made 2 commits:
+
+----
+e9c0b17 (HEAD -> main) Update README.md
+2e018a5 Initial commit
+----
+
+Now make a third commit, by editing `README.md` again, and running this command:
+
+----
+$ git commit -am "Another update to README.md"
+----
+
+Now run `git log --oneline` again to see how our branch looks now.
+
+----
+37634fd (HEAD -> main) Another update to README.md
+e9c0b17 Update README.md
+2e018a5 Initial commit
+----
+
+This shows us that the latest commit on the `main` branch is now
+"Another update to README.md".
+
+Step 5: Create a branch
+-----------------------
+
+Here's how to create a new branch and make a commit on it. We're going
+to create a branch called `add-fruits` that adds a list of fruits.
+
+First, create the branch and switch to it, by running this command:
+
+----
+$ git switch -c add-fruits
+----
+
+The `-c` flag stands for "create". You should see the output:
+
+----
+Switched to a new branch 'add-fruits'
+----
+
+Now, in your text editor, create a new file called `fruits.txt` with
+some fruits in it. Then add it and commit, like this:
+
+----
+$ git add fruits.txt
+$ git commit -m "Add fruit list"
+----
+
+Now edit `fruits.txt` again and commit it again, so that we can see what
+it looks like when you make 2 commits on a branch.
+
+----
+$ git add fruits.txt
+$ git commit -m "Update fruit list"
+----
+
+Run `git log --oneline` again to get a list of all the commits on the
+current branch.
+
+----
+36d0cbf (HEAD -> add-fruits) Update fruit list
+cd4bb48 Add fruit list
+37634fd (main) Another update to README.md
+e9c0b17 Update README.md
+2e018a5 Initial commit
+----
+
+See <<read_oneline,How to read `git log --oneline`'s output>> above for
+an explanation of how to interpret this output.
+
+To summarize, this tells us that there have been 2 commits
+("Add fruit list" and "Update fruit list") since our `add-fruits` branch
+split off from the `main` branch.
+
+3 ways to think about a branch
+------------------------------
+
+In Git there are always 3 ways to think about a branch, and different
+commands will treat a branch in different ways. For example, let's look
+at the 3 ways to think about this `add-fruits` branch.
+
+-----
+* 36d0cbf (HEAD -> add-fruits) Update fruit list
+* cd4bb48 Add fruit list
+* 37634fd (main) Another update to README.md
+* e9c0b17 Update README.md
+* 2e018a5 Initial commit
+-----
+
+We can think of the `add-fruits` branch as:
+
+1. Just the 2 commits that "branched off" of the `main` branch
+   (`cd4bb48` and `36d0cbf`).
+2. The full history of the branch since the beginning of the repository,
+   including all the commits on `main` (5 commits in this case).
+   For example, `git log add-fruits` will show you the full history.
+3. Just the latest commit on that branch (`36d0cbf`).
+   For example, `git show add-fruits` will show you the latest commit.
+
+Step 6: Get a list of all branches
+----------------------------------
+
+You can get a list of all branches by running this command:
+
+----
+$ git branch
+----
+
+The output should look like this:
+
+----
+* add-fruits
+  main
+----
+
+This says that you have 2 branches (`main` and `add-fruits`). The one
+with the `*` next to it is the current branch.
+
+Step 7: Switch branches
+-----------------------
+
+Change your current branch to `main` by running:
+
+----
+$ git switch main
+----
+
+This command:
+
+1. Updates the files in your working directory to match the `main` branch.
+   For example, if `main` is at the commit `aa33bb`, then `git switch main`
+   will give you the files from the commit `aa33bb`.
+2. Sets your current branch to `main`, so that any new commits
+   you make will be on that branch
+
+
+Run `ls`. You should see that the new `fruits.txt` file you created is gone:
+
+-----
+$ git switch main
+$ ls
+README.md
+-----
+
+Of course, `fruits.txt` is not actually gone: it's stored in the `.git`
+directory and we can switch back to the `add-fruits` branch to get it
+back.
+
+Run `git switch add-fruits` to switch back to the `add-fruits`
+branch, and run `ls` again. The `fruits.txt` file should reappear:
+
+-----
+$ git switch add-fruits
+$ ls
+fruits.txt
+README.md
+-----
+
+[NOTE]
+Older Git tutorials used `git checkout` to switch branches.
+`git switch` is a newer command which is easier to learn because it
+only has one job.
+
+Step 8: Create another branch
+-----------------------------
+
+Now create a second branch called `add-animals`. We're creating two
+branches to show what the process of working on multiple changes at the
+same time looks like.
+
+You'll usually want to start all new branches from the `main` branch
+to keep your branches independent from each other. Right now
+we're on the `add-fruits` branch, so we need to switch back to the
+`main` branch:
+
+-----
+$ git switch main
+-----
+
+Then create a branch called `add-animals`.
+
+-----
+$ git switch -c add-animals
+-----
+
+Now create a file named `animals.txt` with some animal names in it, add
+it, and commit it.
+
+-----
+$ git add animals.txt
+$ git commit -m "Add animal list"
+-----
+
+Step 9: Look at our branches and commits
+----------------------------------------
+
+In Git it's extremely useful to be able to visualize your branches.
+There are many GUIs built by the community which can do this, but in
+this tutorial we're going to use the command line because it's the only
+interface we can guarantee everyone reading the tutorial has.
+
+Run this command to show all branches and commits:
+
+-----
+$ git log --oneline --graph --all
+-----
+
+The output should look like this:
+
+-----
+* 1ceb7b4 (HEAD -> add-animals) Add animal list
+| * 36d0cbf (add-fruits) Update fruit list
+| * cd4bb48 Add fruit list
+|/
+* 37634fd (main) Another update to README.md
+* e9c0b17 Update README.md
+* 2e018a5 Initial commit
+-----
+
+How to read `git log --graph`'s output
+--------------------------------------
+
+`git log --oneline --graph --all` prints out a text-based visualization
+of all your Git branches and their history.
+
+This isn't the best visualization, but to use branches well you need
+some way to get this information, and it's the only visualization the
+command line Git interface has. Almost every Git GUI will have another
+visualization you can use.
+
+Here's some example output:
+
+-----
+* 1ceb7b4 (HEAD -> add-animals) Add animal list
+| * 36d0cbf (add-fruits) Update fruit list
+| * cd4bb48 Add fruit list
+|/
+* 37634fd (main) Another update to README.md
+* e9c0b17 Update README.md
+* 2e018a5 Initial commit
+-----
+
+How to read this:
+
+* Every `*` is a commit
+* As usual with `git log`, the latest commit is at the top
+* The `|` and `/` are ASCII art lines that Git uses to show
+  what the parents of a commit are. Here they're showing that `37634fd`
+  is the parent of both `cd4bb48` and `1ceb7b4`.
+
+See <<read_oneline,How to read `git log --oneline`'s output>> above for
+how to read the decorations like `(main)` or `(HEAD -> add-animals)`.
+
+Overall this shows that the `add-animals` branch has added 1 commit and
+`add-fruits` has added 2 commits since they split off from the `main`
+branch.
+
+Step 10: Merge the `add-animals` branch into `main`
+---------------------------------------------------
+
+Now imagine that you're done with your work on the `add-animals` branch, and
+you're ready to bring that work onto your `main` branch.
+
+Right now `add-animals` is one commit "ahead" of the `main` branch.
+To bring all the work in `add-animals` into `main`, we can just move
+`main` forward to match the `add-animals` branch.
+
+This is the simplest possible situation when trying to bring the work
+from one branch into another branch, and Git calls it a **fast-forward
+merge**.
+
+Merge `add-animals` into the main branch by running these two commands:
+
+----
+$ git switch main
+$ git merge add-animals
+----
+
+The output should look like this:
+
+----
+Updating 37634fd..1ceb7b4
+Fast-forward
+ animals.txt | 1 +
+ 1 file changed, 1 insertion(+)
+ create mode 100644 animals.txt
+----
+
+The `Fast-forward` output means that this was a fast-forward merge.
+
+Step 11: Delete the `add-animals` branch
+----------------------------------------
+
+Now that you've integrated the `add-animals` branch into `main`, you can
+safely delete it. Delete the branch by running this command. `-d` stands
+for "delete":
+
+-----
+$ git branch -d add-animals
+-----
+
+Running this is safe: it'll refuse to delete any branch that hasn't
+already been integrated into the current branch.
+
+It's useful to delete branches after they've been merged because it
+stops them from cluttering up your branch list (from `git branch`).
+
+Step 12: Look at our branches and commits again
+-----------------------------------------------
+
+Now that we've made some changes, run this command to show all branches
+and commits again:
+
+-----
+$ git log --oneline --graph --all
+-----
+
+The output should look like this:
+
+-----
+* 1ceb7b4 (HEAD -> main) Add animal list
+| * 36d0cbf (add-fruits) Update fruit list
+| * cd4bb48 Add fruit list
+|/
+* 37634fd Another update to README.md
+* e9c0b17 Update README.md
+* 2e018a5 Initial commit
+-----
+
+Step 13: Merge the `add-fruits` branch into `main`
+--------------------------------------------------
+
+The output from the last step shows that we still have an `add-fruits`
+branch that's branched off a previous version of the `main` branch.
+
+In this situation where `main` and `add-fruits` both have new commits,
+we say that the two branches have "diverged". Having diverged branches
+is very common when working together on a team, because usually on a
+large team many people are making commits at the same time.
+
+If two branches have diverged, you still use the command `git merge`
+to combine them, but it does something different from our previous merge
+in Step 10.
+
+Now run `git merge` to see what happens:
+
+----
+$ git merge --no-edit add-fruits
+----
+
+The `--no-edit` option tells `git merge` to use the default commit
+message. Normally `git merge` will open a text editor to ask you to
+write a commit message, but we're skipping that step here.
+
+You should see the output:
+
+----
+Merge made by the 'ort' strategy.
+ fruits.txt | 1 +
+ 1 file changed, 1 insertion(+)
+ create mode 100644 fruits.txt
+----
+
+Once the branch is merged, delete it by running:
+
+----
+$ git branch -d add-fruits
+----
+
+To see what `git merge` did, run `git log --oneline --graph` again.
+
+----
+*   576d053 (HEAD -> main) Merge branch 'add-fruits'
+|\
+| * 36d0cbf Update fruit list
+| * cd4bb48 Add fruit list
+* | 1ceb7b4 Add animal list
+|/
+* 37634fd Another update to README.md
+* e9c0b17 Update README.md
+* 2e018a5 Initial commit
+----
+
+Here you can see that it created a new commit `576d053`. This commit
+looks different from the other commits because it has two parents:
+`36d0cbf` ("Update fruit list") and `1ceb7b4` ("Add animal list"). This kind
+of commit with two parents is called a "merge commit".
+
+[NOTE]
+If you merge two branches which both edited the same lines of the
+same files, Git will ask you to decide how to handle it. This is
+called a "merge conflict". See linkgit:gitmergeconflicts[7]
+(`git help mergeconflicts`) for a guide to handling merge conflicts.
+
+[[workflows]]
+Examples of using branches to collaborate
+-----------------------------------------
+
+There are lots of ways to use branches to collaborate with other people.
+We don't have space for a full guide to collaborating with Git here, but
+we'll give a quick introduction to `git pull` and examples of
+how each of our characters from the beginning might use branches.
+
+In these examples we're going to use `git push`, `git pull`, `git
+clone`, and `git remote add`. For a basic introduction to `git push` and
+`git remote add`, see Step 14 of linkgit:gittutorial[7].
+
+Intro to `git pull`
+-------------------
+
+Here's the simplest way to use `git pull`.
+
+When you use `git clone` to clone a repository, it checks out a branch
+by default. The branch it checks out is usually the "main" branch.
+This is the one exception to "Git mostly doesn't treat the main branch
+in any special way". Technically the repository's owner can set the
+default branch to anything, but normally they'll set it to the main
+branch.
+
+-------
+$ git clone https://example.com/example.git
+-------
+
+After cloning a repository, you can run `git pull` while on the main
+branch to update it with the latest version, like this:
+
+-------
+$ git switch main
+$ git pull
+-------
+
+This is all you need to know about `git pull` to understand these
+examples.
+
+Example: Anita the PhD student
+------------------------------
+
+Anita is writing her PhD thesis. She follows the steps from
+linkgit:gittutorial[7] to set up a Git repository on the Internet so
+that she can back up her work.
+
+To back up her work after making a commit, she runs:
+
+----
+$ git push origin main
+----
+
+Sometimes, she creates a branch to make an experimental change she's not
+sure that she's going to keep, like `rewrite-chapter-5`.
+
+She does this by running:
+
+----
+$ git switch -c rewrite-chapter-5
+----
+
+Then she makes an experimental change, like rewriting Chapter 5 and commits it.
+If she decides that the change should be merged, she merges
+it into `main` like this:
+
+----
+$ git switch main
+$ git merge rewrite-chapter-5
+----
+
+Or if she decides the rewrite of chapter 5 was a bad idea, she can
+switch back to `main` and delete the branch:
+
+----
+$ git switch main
+$ git branch -D rewrite-chapter-5
+----
+
+Example: Bruno the open source contributor
+------------------------------------------
+
+Bruno is contributing to an open source project for the first time.
+
+First, he finds the official Git repository for the project and clones
+it, like this:
+
+----
+$ git clone https://example.com/project/project
+----
+
+He doesn't have permission to push changes directly to that
+project, so he creates his own copy of the repository at
+https://example.com/bruno/project.
+
+Then he adds that repository as a second remote, like this:
+
+----
+$ git remote add bruno https://example.com/bruno/project
+----
+
+Before starting work on his branch, he makes sure that he has the
+latest version of the `main` branch using `git pull`, like this:
+
+----
+$ git switch main
+$ git pull
+----
+
+Then he creates a new branch, like this:
+
+----
+$ git switch -c new-feature
+----
+
+Once he's done with his branch, he pushes the branch to his Git
+repository, like this:
+
+----
+$ git push bruno new-feature
+----
+
+Then he goes through the open source project's process to submit his
+branch for review.
+
+Example: Carmen the corporate employee
+--------------------------------------
+
+On her first day of work, she clones the company's Git repository by
+running:
+
+----
+$ git clone git@example.com:company/project
+----
+
+She has access to push new branches to this repository with her work,
+but their system doesn't allow pushing to the `main` branch directly.
+
+Before starting work on her new feature, she makes sure that she has the
+latest version of the `main` branch using `git pull`, like this:
+
+----
+$ git switch main
+$ git pull
+----
+
+Then she creates a new branch, like this:
+
+----
+$ git switch -c new-feature
+----
+
+Once she's done with her branch, she pushes the branch to the company
+Git repository, like this:
+
+----
+$ git push origin new-feature
+----
+
+Then she goes through her company's process for getting branches merged.
+
+Example: Daniela and Emilia with the cat shelter website
+--------------------------------------------------------
+
+Daniela and Emilia create a Git repository for their cat shelter website.
+
+They both clone it onto their computer like this:
+
+----
+$ git clone git@example.com:cat-shelter/kitties.git
+----
+
+They decide to work together by just pushing all of their commits to the
+`main` branch, without using any other branches.
+
+When Emilia wants to do work, she first runs `git pull` on the main
+branch, like this:
+
+----
+$ git pull
+----
+
+She also checks in with Daniela to make sure they won't be working on
+the same files. Then she works on her changes and commits them.
+Then, before pushing her changes, she runs this command to merge any
+changes Daniela has made.
+
+----
+$ git pull --no-rebase
+----
+
+We don't have space for a full introduction to linkgit:git-pull[1]
+here, but `git pull` fetches Daniela's changes and merges them into the
+current branch. The `--no-rebase` flag tells Git to use `git merge` to
+do the merge.
+
+Then she pushes her changes with:
+
+----
+$ git push
+----
+
+[[tip]]
+Tip: put your current branch in your shell prompt
+-------------------------------------------------
+
+Accidentally doing a Git operation on the wrong branch can be really
+annoying to undo. Because of this, it's extremely useful in Git to
+always know what your current branch is.
+
+To help with this, Git comes with a shell script called `git-prompt.sh`
+that has instructions for how to make sure your current Git branch is
+always in your shell prompt. If it's not already on your machine, you can
+find it in the https://github.com/git/git/blob/master/contrib/completion/git-prompt.sh[official Git repository here].
+There are also many shell plugins to do this.
+
+For example, if you're on the `main` branch, this can make your shell
+prompt look like this:
+
+----
+[user@host myproject (main)]$
+----
+
+[[guis]]
+GUI tools
+---------
+
+Here are a few open source GUI tools. All of them work on Linux, Mac,
+and Windows unless otherwise mentioned:
+
+- `gitk` and `git gui` both come with Git. `git gui` focuses on making
+  commits and `gitk` visualizes the project's history.
+  See linkgit:gitk[1] and linkgit:git-gui[1] for more info, and
+  https://git-scm.com/install/ for install instructions.
+- TortoiseGit (https://tortoisegit.org/) for Windows
+- GitUp (https://gitup.co/) for Mac
+
+Interactive terminal UIs:
+
+- LazyGit (https://github.com/jesseduffield/lazygit)
+- tig (https://jonas.github.io/tig/)
+
+Many text editors have Git integrations, for example:
+
+- Magit (https://magit.vc/) for Emacs
+- Fugitive (https://github.com/tpope/vim-fugitive) for Vim
+- Many IDEs (VS Code, Eclipse, JetBrains, etc) have built-in Git
+  integrations. This can be a good option if you're already using one
+  of them.
+
+Where to learn more
+-------------------
+
+- When merging two branches, there can be a conflict if both sides
+  edited the same lines of a file. linkgit:gitmergeconflicts[7]
+  (or `git help mergeconflicts`) is a guide to handling merge conflicts.
+- The UPSTREAM BRANCHES section in linkgit:git-pull[1] explains how to
+  configure where `git push` or `git pull` will push or pull from.
+- Some teams prefer to use linkgit:git-rebase[1] and a fast-forward
+  merge to combine branches instead of using merge commits.
+- linkgit:gitdatamodel[7] explains how Git represents branches and
+  commits.
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Documentation/meson.build b/Documentation/meson.build
index b290557834..23634ebd7e 100644
--- a/Documentation/meson.build
+++ b/Documentation/meson.build
@@ -208,6 +208,7 @@ manpages = {
   'gitrevisions.adoc' : 7,
   'gitsubmodules.adoc' : 7,
   'gittutorial-2.adoc' : 7,
+  'gittutorial-branches.adoc' : 7,
   'gittutorial.adoc' : 7,
   'gitworkflows.adoc' : 7,
 }
diff --git a/command-list.txt b/command-list.txt
index 56d0d7ed9b..0e3e3fc378 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -245,6 +245,7 @@ gitrepository-layout                    userinterfaces
 gitrevisions                            userinterfaces
 gitsubmodules                           guide
 gittutorial                             guide
+gittutorial-branches                    guide
 gitweb                                  ancillaryinterrogators
 gitworkflows                            guide
 scalar                                  mainporcelain

base-commit: 3c60ef1e38ee80337025a1b908327f7879386329
-- 
gitgitgadget
