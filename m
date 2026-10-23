Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792778494;
	b=yvuT9dFXNhh5mcTA4JoZAuOM04kQEbBw8dyUPGC23RgXzMjz+P3ZGwXA0Bh7YcTkmzUG
	 1FRliuPnQx+BsL5UL/yHDT/p9+9wTDJqzdTt2wzL78hnsFq/MmuQgPWLYgy3+27s+HnJo
	 3CU0gwb5lMMi928QqUx4UNhsAgNUBcKWlzrPq4Sf0KWJy+SYbEq0J41UmGITjYvb5UPd1
	 yLnOn0jaGalRSloABaxaqxwuJ6E7ft1fIDkQZ9HxLa9s3yKUFsy3XVnaayXSRIHvvFbBF
	 qQZGaWg0tS0wv9sODhLE13BputV/kGupMN6JmHa7FPy6QTfRlEv+CBk8W/aDV97Ljng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792778494;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 Content-Transfer-Encoding:From:Mime-Version:Subject:Date:Message-Id:
	 References:Cc:In-Reply-To:To:X-Mailer;
	bh=fN+8VQZTj7h/ATzAcbg9os9WimON625yJM217AAtd+8=;
	b=znVYGF/ycLWctsbVNKIbQ7fLVZiG2H/H9rvo2iYIJClg3u2yXx5tOIYtWnPbUiupsX+D
	 cOQUTrsEL5Yg5z3EA6WSYYNSu1dBnpysskFOj4716tQc14+jBBmGysIPSIdMhyfj+sl6F
	 8BbQwADrkwYUPb4xM7ZtHvfUYQe/oViUSvdwNhQ0VU2CLSsKcSfB0A3Rj67IYq6pwBQ1U
	 cURpGIOR7DH2AyL/LPJBQtTtm6nT8ggFa9Yps0QmAo2zfCeAswsI2F0aVp0/lK6F8RQOK
	 ju4fSyZRMf8YP7+0H6RbeB3smajjyS8CcsThB2GcBjkEUFmyWt09Ct7/CMf0Bv4yEZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="MJ1v3u/8";
	arc=none smtp.remote-ip=209.85.128.170
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EB2606A31B
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 18:01:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6EB2606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MJ1v3u/8
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-8b0dba37a7fso10321757b3.0
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 11:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792778493; x=1793383293; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fN+8VQZTj7h/ATzAcbg9os9WimON625yJM217AAtd+8=;
        b=MJ1v3u/82DCWhQHi5WIJJCDuGSUFbAFUQAabAKI+5vxePsqteUcvhp6FMrtJo+gqg5
         tID16qFVg01mSb8OhrjqAcONeBm03+LP34vH1CZb6xVAQwc58tYtM7i5d7PGmjxk+tQV
         tqBrksX8wfshj6UO9fS3inmWNuUxCNKX2vvVqN+6VOGqqPI0T5mWMnXODNfBIIdxLgx1
         LFJ+/VbxEx0E2uizQJ0zOk2MNB2qUy4FbcJK/WumetyRznYb4moNv2nm6ULLq/+TeYoJ
         XSqlcAjODcFoMrKe+Isy/eGdFjD+hPYIi2vGuuK/sHQElsXzOXVuMUleq2ceOWqpRBNh
         57fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792778493; x=1793383293;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fN+8VQZTj7h/ATzAcbg9os9WimON625yJM217AAtd+8=;
        b=Ii2BTVoCKj+uVGCODSCuYhYVQZzjhpyvtZoA70WQi5WY/+dT1nnbv5XFARJYJvDWi2
         uPCHRVpAUtcm/zFOnvLZrDKUnPkhEz7Cj+vE/wNZqoJA1F1F2nsKvcxi0b2097uMAN07
         ohYoy4aAk6Ns5/OP/f+lwZDa2VZwkEFKVp/83V8flUCTVYWi5cDUZh/N9IRk3vTE6+7+
         4l7LY8aRoIr95xpnVPPTXuuc55WU527fs4RVZLzCqUoyK/cgU988lXFvSE92MUUD65xM
         VDAuacSI3p8+YHXEwKSW8Qt2g9Yykfv8ZZCIhdLGNnxKOKcpnPATUI3+0lbEmB0C2ADO
         ApfQ==
X-Gm-Message-State: AFq9FYIBIFpb6JSduYS0cmLPJUI2kJfqxx/fl/AmOq9ESR8SBQlB6dXv
	Cne0H6q0xxFNUmmmx9ZEa0HUnZUkiv9Rnhb2zZUnngBrr+tgIKtEjjZSLzCCnMJ3
X-Gm-Gg: AYBFou1wkKZLhSRKtGOEcxQldU6xbqW1heLSbG2wqzznQOztylvRHee+Cw7i2axOCXl
	On7Gkfn8+wXXXhJTrlxB7MvD3/OctfpxbfQ4pzIEVPdLQDqAHNqhW8eClp1cIMdtxfJ2QFiPDn3
	s5puUpA0+kSmVyIqOWpOrXkBVGLbaEfwoLuNAINYfJxALIoWGUUUrvO3ARUIjrXA2Fal7CDpe4S
	8hekB2NLVJd+/iykzBgqUXpm+4p1S2CcRZ7t0yfS/ZEak1xeivJR3s0lxp5WDtFI/Naq7+UAOUv
	Q0rKUm9IfC2eUvBoy/15cYE4VmKVc7bWh2g2qEIgkmAkwMC7k9fSwBFXKAQfBN3NNl+LQz22+gZ
	j3n1h92I1r73gm4WLxQQ5KIAUDTNLzMqqPYTrJvt5vXJk5hQAqQDdw3tdzEhQN4+oKvM5VvKoWE
	eJWlxmvQoYk5pMMpUkIu7vVzQFWVL5AOpDcx8U0c3lrsErI5rR898mqvqNjCpXbxApFb/OxmCnW
	Ha7Zcy86U/vquEemedoZ8Jz8DvQE9+Y4xqIjWa7KaYm2wkBNnkyo/WSr9tPmgsW4x/Jae40SnIT
	ToHJT40dzihoyXOorK/XwosPH4WJgz0mh52/XBVcVgiWB4yEB7jogWaVaMjeJlJdKOjbrU+6pYX
	DBY1CmfI5LFo/DI89UzkthV29ig==
X-Received: by 2002:a05:690c:c1c7:20b0:8b1:e7c:cde6 with SMTP id 00721157ae682-8b157dbd737mr15817117b3.14.1792778492285;
        Fri, 23 Oct 2026 11:01:32 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:9d17:3000:1d:477:fbde:1358])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b163f201f5sm2954017b3.45.2026.10.23.11.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 11:01:31 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v3 0/2] doc: add new git tutorial
Date: Fri, 23 Oct 2026 14:01:19 -0400
Message-Id: <F2555C10-8453-4196-9D07-02870D19199D@gmail.com>
References: <pull.2248.v3.git.1792768625.gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Tuomas Ahola <taahol@utu.fi>,
 Julia Evans <julia@jvns.ca>
In-Reply-To: <pull.2248.v3.git.1792768625.gitgitgadget@gmail.com>
To: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>
X-Mailer: iPhone Mail (23D8133)


> Le 23 oct. 2026 =C3=A0 11:17, Julia Evans via GitGitGadget <gitgitgadget@g=
mail.com> a =C3=A9crit :
>=20
> =EF=BB=BFSo far we've gotten 112 comments from 30ish beta testers who have=
 tried to
> learn Git for the first using this tutorial. Most of them were able to
> finish it successfully. By far the most common piece of feedback was that
> people want to learn more about collaboration and branching. I've written a=

> draft of a tutorial on branching, but this is already quite a lot of words=

> so definitely we can't cover it in this series.
>=20
> I don't know if it's possible to get this merged quickly, but if it were I=

> think it would be amazing since people are so eager for a tutorial on
> branching. If we spend a huge amount of time revising this I think there's=
 a
> real risk I'll run out of funding before we have time to write about
> branching. Ideally I think it would be great if we could merge a "good
> enough" version and then have a way on the website for users to give
> feedback on it, so that we can later incorporate that feedback and
> iteratively make it better over time.
>=20
> Thanks to Paula, Agavi, Ken Wells, Michael / Chgowiz, Ishmaeel, and all 20=

> or so other test readers.
>=20
> changes in v3: (v2 was the "first" real version since v1 was a WIP)
>=20
> * Say that the tutorial supports any version above 2.23.0, when git switch=

>   was introduced, since the next part of the tutorial on branches will use=

>   git switch
> * Mention that on Windows the tutorial will work best in Git Bash for and
>   it might need adapting for PowerShell. (thanks to Ben)
> * Add a warning about how Git can dump you into vi, how to handle that
>   situation, and how to write a longer commit message. I tried to strike a=

>   balance between lightly suggesting that it might be good to write longer=

>   commit messages, while making it clear that you can just use -m"" if
>   you're not ready to navigate the world of editor configuration. I don't
>   think we can use Pro Git here though since it's a bit outdated. (thanks
>   to Ben)

I noticed some discussion in Discord about the main text being out of date,=20=

but while the appendix makes copious references to editors
that have fallen out of style I think it also covers common cases
like VS Code and so on.

> * Add Helped-by: Ben ...
> * Add output of "ls ~/.ssh/*.pub" (thanks to a test reader)
> * Suggest cat ~/.ssh/whatever.pub to make it clearer how to copy the
>   contents of the file. One of the test readers said this was unclear as
>   well. (thanks to Junio)
> * Mention that the public key might not be called ed25519.pub (thanks to
>   Junio)
> * Add a short section on the importance of git status
> * Fixed the formatting around the headings. Kept it in the same style
>   because I had issues with the docs linter when using =3D=3D DESCRIPTION
>   (thanks to Junio)
> * explain what --set-upstream does (thanks to Ben)
> * A few other small phrasing fixes from test readers
>=20
> non-changes in v3:
>=20
> * didn't use git config set since the tutorial claims to be compatible wit=
h
>   Git 2.23.0
> * kept using the term "folders" since my impression is that Mac OS and
>   Windows use the term "folder" and those operating systems are more
>   popular than Linux. I don't think any test readers were confused by this=

>   term, though "directories" might be fine too.
> * leave git init instead of git init myproject so that folks can use the
>   same process when setting up Git in an existing project
>=20
> Julia Evans (2):
>  doc: remove gittutorial
>  doc: add new Git tutorial for beginners
>=20
> Documentation/gittutorial.adoc | 1035 ++++++++++++++++++--------------
> 1 file changed, 573 insertions(+), 462 deletions(-)
>=20
>=20
> base-commit: 47fdf2208c5b94c8cc01c106b8f7c85efb91c926
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2248%2Fj=
vns%2Fgit-tutorial-v3
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2248/jvns/g=
it-tutorial-v3
> Pull-Request: https://github.com/gitgitgadget/git/pull/2248

The range-diff below looks fine to me! A few small nits, but I don=E2=80=99t=

want to hold things up.

> Range-diff vs v2:
>=20
> 1:  42035aa84a =3D 1:  8c0366e996 doc: remove gittutorial
> 2:  6532e60e30 ! 2:  d8ea142af6 doc: add new Git tutorial for beginners
>     @@ Commit message
>=20
>          Some design choices:
>=20
>     +    - Only use commands present in 2.23.0 (when `git switch` as intro=
duced),
>     +      to support older versions of Git.
>          - Introduce a much smaller set of commands than the old tutorial,=
 to
>            keep the tutorial quick (doable in an hour). Some users found i=
t to be
>            very fast and some wanted to stop early (after step 7) so this s=
eems
>     @@ Commit message
>            policy if applicable since the "easiest way" may not be the bes=
t), and
>            giving some instructions for how to translate an HTTPS URL to a=
n SSH
>            URL.
>     +    - Warn people about how `vi` is the default text editor and give s=
ome
>     +      instructions for how to escape
>=20
>          At least 20 people have successfully completed it, and feedback w=
as
>          incorporated from problems the testers ran into.
>=20
>     +    Helped-by: D. Ben Knoble <ben.knoble@gmail.com>
>          Co-authored-by: Marie Claire LeBlanc Flanagan <hello@marieflanaga=
n.com>
>          Signed-off-by: Marie Claire LeBlanc Flanagan <hello@marieflanagan=
.com>
>          Signed-off-by: Julia Evans <julia@jvns.ca>
>     @@ Documentation/gittutorial.adoc (new)
>      +1. Git to be installed. You might already have it installed,
>      +   and if not there are directions at https://git-scm.com/install/
>      +2. A terminal to use. On Windows, you can use Git Bash which comes
>     -+   when you install Git.
>     ++   when you install Git. For Windows this tutorial will assume you'r=
e
>     ++   using Git Bash and if not you might need to adjust some commands l=
ike
>     ++   `ls` and `cat`.
>      +
>      +You can check if Git is installed by running this in your terminal:
>      +
>     @@ Documentation/gittutorial.adoc (new)
>      +------------------------------------------------
>      +
>      +The exact version isn't too important: this tutorial is designed to w=
ork
>     -+with any version of Git after 2.0.
>     ++with any version of Git after 2.23.0.
>      +
>      +[[step_2]]
>      +Step 2: Introduce yourself to Git
>     @@ Documentation/gittutorial.adoc (new)
>      +but we're not covering that here.
>      +
>      +Step 3: Create an empty folder and 1 file
>     -+------------------------------------------
>     ++-----------------------------------------
>      +
>     -+In your terminal, create an empty folder and change directories into=
 it.
>     ++In your terminal, create an empty folder and move into it.
>      +Later on you could follow the same steps in this tutorial to take an=

>      +existing project and start managing it with Git, but we're going to u=
se
>      +an empty project so that everyone following this tutorial has the ex=
act
>      +same files.
>      +
>     -+For example, run these commands to make a folder called `myproject`
>     ++For example, run these commands to make a folder called `myproject`:=

>      +
>      +------------------------------------------------
>      +$ mkdir myproject
>     @@ Documentation/gittutorial.adoc (new)
>      +
>      +You've now stored the first version of your project in Git!
>      +
>     ++`git status` is very important
>     ++------------------------------
>     ++
>     ++`git status` shows you the current state of your Git repository.
>     ++It can give a huge amount of different information that takes
>     ++practice to interpret, so this tutorial has several examples of
>     ++how to interpret the output of `git status` in different situations.=

>     ++
>     ++It's often useful to run `git status` before and after running a Git=

>     ++command to see how it changed things.
>     ++
>      +Step 6: Make a change
>      +---------------------
>      +
>     @@ -1,2 +1,2 @@
>      +$ git add example.txt
>      +----------
>      +
>     -+Then you can run `git commit` to commit it.
>     ++Then you can run `git commit` to commit it (though see the warning i=
n
>     ++the next section!).
>     ++
>     ++Warning about terminal text editors
>     ++-----------------------------------
>     ++
>     ++If you run `git commit` without any arguments, Git will open a
>     ++text editor in the terminal for you to use to edit your commit messa=
ge.
>     ++This lets you write a longer commit message with more details.
>     ++By default, Git uses the `vi` text editor, which is extremely diffic=
ult

Personally, I=E2=80=99d drop =C2=AB extremely =C2=BB here to avoid casting a=
 judgement?

>     ++to use if you're not used to it.
>     ++
>     ++Some signs that you're trapped in `vi`: suddenly typing doesn't work=

>     ++anymore, and there are tilde `~` characters on the left of the scree=
n.

Perhaps =C2=AB bottom-left =C2=BB; they aren=E2=80=99t in the rows with text=
,
for example.

>     ++
>     ++If Git opens `vi` and you'd rather use a different editor, you can
>     ++handle it like this:
>     ++
>     ++1. Quit by typing `Escape`, then `:q!` and then `Enter`

I never know if I=E2=80=99m over-indexing on this, but: perhaps
=C2=AB press the Escape key, type =E2=80=A6, and press Enter =C2=BB? One pro=
bably
does not want to type the word Escape ;)

Ideally we=E2=80=99d recommend :cquit!, too, to exit with an error
in case the user accidentally edited the buffer and managed to write it,
in which case they may create a commit and the recovery may be confusing.
But POSIX doesn=E2=80=99t require that of vi/ex even though most distros
ship Vim as the implementation. So :q! will have to do.=20

>     ++2. Run `git config --global core.editor YOUR_PREFERRED_EDITOR`

This is probably ok for now. Long term I encourage folks to set
EDITOR and/or VISUAL environment variables, so all
programs know what to do, but shell configuration is way
off-topic here :)

>     ++   to configure which editor to use. For example, `nano` is availabl=
e
>     ++   on a lot of systems and has basic instructions on the screen for h=
ow
>     ++   to use it.
>     ++3. Run `git commit` again
>     ++
>     ++If you don't want to set up a text editor yet, you can also just use=

>     ++`git commit -m"your message"` like we did earlier in this tutorial.
>      +
>      +Step 8: Make a change and throw it away
>      +---------------------------------------
>     @@ -1,2 +1,2 @@
>      +This "working tree clean" message means that there haven't been any
>      +changes since your last commit.
>      +
>     -+Now make a change to your code, and run `git status` again. Like las=
t
>     ++Now make a change to `README.md`, and run `git status` again. Like l=
ast
>      +time, you should see a message like this:
>      +
>      +------------------------------------------------
>     @@ -1,2 +1,2 @@
>      +source Git forge software to your server.
>      +
>      +Step 10: Create an SSH key (if needed)
>     -+-------------------------------------
>     ++--------------------------------------
>      +
>      +For Git to upload changes to another Git repository, it needs a way t=
o
>      +login to that repository. One of the most popular ways to do this is=

>     @@ -1,2 +1,2 @@
>      +$ ls ~/.ssh/*.pub
>      +-------------------------------------------
>      +
>     -+That will output something like
>     ++That will output something like this. The exact filename depends on t=
he type
>     ++of key. The important thing is that you're looking for a filename th=
at
>     ++ends in `.pub` ("pub" stands for "public"):
>      +
>      +-------------------------------------------
>      +/home/alice/.ssh/id_ed25519.pub
>      +-------------------------------------------
>      +
>     -+Copy the contents of that file to your clipboard. It's important tha=
t
>     -+the filename ends in `.pub` ("pub" stands for "public").
>     ++Copy the contents of that file to your clipboard. One way to do that=
 is
>     ++to run this command (replacing the filename with the right filename)=
,
>     ++and then copy the output.
>     ++
>     ++-------------------------------------------
>     ++cat /home/alice/.ssh/id_ed25519.pub
>     ++-------------------------------------------
>      +
>      +Then login to your account on the Git host you chose and paste the S=
SH
>      +key into the appropriate place. Depending on the Git host, it's like=
ly
>     @@ -1,2 +1,2 @@
>      +-------------------------------------------
>      +
>      +[[step_14]]
>     -+Step 14: push your changes
>     ++Step 14: Push your changes
>      +--------------------------
>      +
>      +Finally, we're ready to send the information in your local Git repos=
itory
>     @@ -1,2 +1,2 @@
>      +You should be able to fix this by redoing <<step_12,Step 12>>.
>      +Then <<step_14,Step 14>> should work.
>      +
>     -+MORE USEFUL GIT COMMANDS
>     ++More useful Git commands
>      +------------------------
>      +
>      +We're not going to cover collaboration at all in this tutorial, but h=
ere are a
>     @@ -1,2 +1,2 @@
>      +  If you see a commit with `git log` that you want more details abou=
t,
>      +  you can run `git show COMMIT_ID` to see what changes that made sin=
ce
>      +  the previous commit (linkgit:git-show[1])
>     -+
>     -+SEE ALSO
>     -+--------
>     -+linkgit:git-help[1],
>     ++* To get a list of common Git commands, run `git help` (linkgit:git-=
help[1])
>      +
>      +GIT
>      +---
>=20
> --
> gitgitgadget
