Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEF737A485
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 19:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791402528; cv=pass; b=HvAu/VDZSwJVKDoZ8AZkxclDuwO28SZNxRBYiXi8J0fvqXcu+8/n6D0H6Yutye8afb++Zoq+jKq4fqhH2m8sVqbKHt/oi2eSkNIXFlmJtzyfUgqtDDyxDDrOOJBuKC7e1srunK2aJeVVIlQ+ak0KYvQNFhSWnOH6/qi+bdevEeM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791402528; c=relaxed/simple;
	bh=iyzlPYfAR7DCUKjP9To98DAB15lOcWGaiXJyIUdR6gQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E+ZhfOyYOBjDEeS6gZ/RTKBjnLiXtgQ8WJApCB5wyRLQ18ESSWGUWCRaETvFXsyn/yyYwIRR73uBc4mEFHoYHx/Z6g/KTJL6k5VN2eMqezJmM7LnKH9ff4eKBniXu8uO4fV3PczWREXB3FeagToqzasF+i5Pv/dJcwUhlUeYdTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dPAdCH3D; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPAdCH3D"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2dd9ec41bc4so15312445ad.2
        for <git@vger.kernel.org>; Wed, 07 Oct 2026 12:48:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791402526; cv=none;
        d=google.com; s=arc-20260327;
        b=qHmA+PbZpwX6VoiA1Xn7I49jGMsvZVCL0zgNAtuGXe+Zi1Kc2qsOgwEQ3/nRD4NDEN
         lVba7Hs+arbRSPYpsW2sQ4UHf6GENHgePcrR8B7+haOhcMySna/1uvosKwrha9WpSmja
         W92Tsrrr/dkaj8nzViSPaSEMm2b1CRQ5TPRdlFXh+DZa6BX85211YJGu7PolxFQFyFwd
         RZFpSozqtVjRxuFg8d7Ny4Tt08ezhPpwHoHfIF8YwTFcNEycmMfmhydOXXT44c6nupsY
         Z+SRwN1HtW3+vONeSZA1H0a11kDCIfVt4TAnf/7VkjhIQfdXaPrBWIO9anJSSeJQmS9u
         YHeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZkrucPrx9+DGJvth4ELMC/B8/Z+cdQOl9Q8zzkAXjOI=;
        fh=bzNSpxKo5LnoMuBj1zux8p/hcP2mdIHFfB1NDkOktHM=;
        b=QWVRiC2aEj1nwKBjmghVv1NECSXeTBefqIs1yAj5VOZ63f4SZZCCLGHwAzNmFmJ926
         3PL6V067AirjqFUOP3Bb9sTLfRiFvVVYU1pSZzCQ4hAoWkkLO5LPlifbrZRKNzufUmxn
         3nUqnjNrl/rm2kvEMCLdWsB/eV309u4fX7VbC5ckmLUa8AE7ubWo87oUVvTZdZjvOzcM
         QapCHAtdl9WbVFnG8CtpCUJoJOZuejYmUI6nbZuPQuF/+sU0iw+VVohQTUDvG1yGend1
         IN7402jq9AL0DMF66QOXri7H2DCWVUFQvtYq6tng23/a403msmeRNaau9wq/leRgYRIZ
         q+Ng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791402526; x=1792007326; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZkrucPrx9+DGJvth4ELMC/B8/Z+cdQOl9Q8zzkAXjOI=;
        b=dPAdCH3DtCgJcryUGgqPX9uhgw3jDd2KIfynUGFyHxtKWet67kZ1TwI6xY5vAY/8M8
         bQeVQ3eOLuicKOLHK6BXkwIPJ9rgmdOHY4IPMKnnSgu8FQyHYs0u0HIm7mPoFAfg9Bc5
         WkHuw9FHJ2ndedOOPdyqtxeqyn4MnqEZahZgxNlmwGg43Lf1wMjCNftDCFqvvZQ65MJF
         6uJa5BV3cDVfcXszUnn9xSrjRaQAPFNIzfJSN188FuIwDRuHip4JTqSYeCKo1aXefbLn
         FMr89cIe8leqF9XDzKWhTd/cz+HzRNTA/WjNs2GNn6gf/Nq1RvjvzlWsn7Lum5+5Wv68
         ZKBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791402526; x=1792007326;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZkrucPrx9+DGJvth4ELMC/B8/Z+cdQOl9Q8zzkAXjOI=;
        b=LkCuvk0Iu/C2EZXefDVaqjYVzTK/aQLZKLv3hEStim+VMJu6MI0S3dEppOKtrmomSR
         g4PmcGhI2UqAPqRd1Sx8vSKYDG6DXDvtkAicAxf7bhyNvyz3Hoc0RPtVLAahq0ZvjqcA
         yVNtDX1w5ko0hjjh4+vUDP1XMI7bMOJfcDlMWYbQfitW6cYgdsRjjFR9pnuw0+jgM+dM
         MQNrE/7Y9KkXjbwnfzPkNC8W2eL5wc2JXxwgGOXZXYxhMCpoDxD+n6tZHfH9psjDYvYx
         JRkU+dEeTbVjVd8O5bLGkuSqMRm1S4rTMSweiqEDuemfAs3LgzpqWdTI+6ByCcqXKSjm
         7zvw==
X-Gm-Message-State: AFq9FYKSsoKoRz4/GBWb9hTAKPxFrn2RQu/okEeHrCazCHFRudWVw28/
	afqdRh+Zu4DvrQ14ewE/mdMSr51bpsg3idWmPyviY6IAopVO86Jtha02z0f/tG6qN+mR4dwkR8e
	htA0auk+GkbWGkM3VPTin+LmhIbgADZE8/z0f
X-Gm-Gg: AYBFou03Ils0bnat6JeprWOu8igWzXF+M0nm9QcxaQi7e0IBHvKIM8p/dGp48cYx5p9
	L0yf2eTSTpgUa4EPIed5lHD1qWLQcTxMDXYURGHTyFKWmLVUWWXytGEv7DmqFQLbPWdqXOvkhup
	gpEsG0AlxVXEwy6PV7F+NjxVjw4nEuNNgWDe7st4yK6nqqE07ND/MuKSX5W8i+UMczLjM1darJQ
	rCAoaOd0Q3s5oos9F2A/SIUdWrmmAx23ffERolOTgEYeNqPxy4xOwQMMpnZX9pR3at/qzW3pdL+
	CQCWLaWRcjW4jyRmQ7w6CtMBHytDaYUhz1FhxdjoBhCyE1e0oi1XcdeZ/zLwQdZ754obLqJebYT
	aIzkO6CiFmfVYoFhPP7LEKdb7I5xTRKJCq7UFP+PbnYCFO16BZOWWKt3htJOvtwgKMm1Rs+1+rb
	sH8NgaeQ+0mHqPHCZIuHq3eqQRZoeT3R30jwtLWv+9
X-Received: by 2002:a17:903:41c8:b0:2df:b3ea:1 with SMTP id
 d9443c01a7336-2e6005314c4mr31526405ad.36.1791402525397; Wed, 07 Oct 2026
 12:48:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2248.git.1791315422.gitgitgadget@gmail.com> <41dca2e8e0c5fadb8ad9ed8707029356e56cc540.1791315422.git.gitgitgadget@gmail.com>
In-Reply-To: <41dca2e8e0c5fadb8ad9ed8707029356e56cc540.1791315422.git.gitgitgadget@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Wed, 7 Oct 2026 15:48:33 -0400
X-Gm-Features: AclHuK_wiVxkO5acGVAMN70b_V3S9GvQkVJgsAeUrImxcP8c0rtuAMjZwaXuzRg
Message-ID: <CALnO6CB0ApqKSfdmnekS7NKATJL4WrP4jpNBfryoOGKsFrz7+Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] doc: add new Git tutorial for beginners
To: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Julia Evans <julia@jvns.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 6, 2026 at 3:37=E2=80=AFPM Julia Evans via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Julia Evans <julia@jvns.ca>
>
> This tutorial covers:
>
> 1. Creating an empty repo with `git init`
> 2. Making commits with `git add`, `git commit`, `git diff`, and
>    `git status`
> 3. Pushing to code to a Git host on the internet, including creating an
>    SSH key
>
> Signed-off-by: Julia Evans <julia@jvns.ca>
> ---
>  Documentation/gittutorial.adoc | 616 +++++++++++++++++++++++++++++++++
>  1 file changed, 616 insertions(+)
>  create mode 100644 Documentation/gittutorial.adoc
>
> diff --git a/Documentation/gittutorial.adoc b/Documentation/gittutorial.a=
doc
> new file mode 100644
> index 0000000000..617dbae096
> --- /dev/null
> +++ b/Documentation/gittutorial.adoc
> @@ -0,0 +1,616 @@
> +gittutorial(7)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +NAME
> +----
> +gittutorial - Introduction to Git for beginners
> +
> +DESCRIPTION
> +-----------
> +
> +This tutorial explains how to import a project's code into Git, make
> +changes to it, and upload the project to the Internet.
> +
> +We'll show you how to use the commands `git commit`, `git add`,
> +`git diff`, `git status`, and `git push`.
> +
> +Command line vs GUI
> +-------------------
> +
> +Git is a command line program, but there are many excellent GUIs for
> +Git built by the community. For example, if you use an IDE to edit your
> +code, it might already have a built-in Git integration that you can use.
> +
> +In this tutorial, we'll give instructions for the command line version
> +of Git, but you can also follow along in a GUI. You can also do some
> +tasks in a GUI and some tasks on the command line. It's up to you.

Since we assume a *nix-ish environment, should we mention that this
tutorial works best on UNIX-like OSs, or in a Git-for-Windows Bash
environment, and may need adapting for folks using PowerShell, CMD, or
some other userspace (not a piece of jargon I would use here,
probably)? Or does that get covered incidentally by the installation
instructions?

I'm especially thinking of not confusing a user who sees something
different or doesn't have an "ls", "cd", etc. (Maybe my Windows
command line knowledge is shoddy, though, and those parts just kind of
work close enough for our purposes?)

> +
> +What we'll be doing
> +-------------------
> +
> +Git lets you take snapshots of your code, like a checkpoint in a video
> +game. In this tutorial we're going to explain a very basic Git
> +workflow, which is:
> +
> +1. Create an empty folder
> +2. Start using Git to manage the code in that folder
> +3. Create 2 files and tell Git to save a snapshot of them
> +4. Make changes to one of the files
> +5. Tell Git to take another snapshot
> +6. Repeat steps 4-5 any time you want to update your code

I'm very tempted to nitpick "folder" vs "directory," but I'm not sure
it's worth our time or that of the target audience :) Just note that,
while "git grep folder" finds way more hits than I was expecting, it
seems the primary use in our documentation is in reference to IMAP.

> +We'll also explain how to use Git to put your code on the Internet.
> +
> +Step 1: Make sure Git is installed
> +----------------------------------
> +
> +To do this tutorial, you'll need:
> +
> +1. Git to be installed. You might already have it installed,
> +   and if not there are directions at https://git-scm.com/install/
> +2. A folder on your computer with code that you want to start managing
> +   with Git.
> +
> +You can check if Git is installed by running this in your terminal:
> +
> +------------------------------------------------
> +$ git --version
> +------------------------------------------------
> +
> +[[step_2]]
> +Step 2: Introduce yourself to Git
> +---------------------------------
> +
> +The first time you use Git on a computer, it's a good idea to tell Git
> +your name and public email address. If you don't, you'll get a lot of
> +warnings from Git. To do this, run:
> +
> +------------------------------------------------
> +$ git config --global user.name "Namey McName"
> +$ git config --global user.email you@example.com
> +------------------------------------------------
> +
> +The name and email is so that other people you're collaborating with can
> +know who made the changes. You can set them to anything you want.
> +
> +To check if the name and email have been set, you can run these
> +commands:
> +
> +------------------------------------------------
> +$ git config user.name
> +$ git config user.email
> +------------------------------------------------

Ought we recommend the newer forms (git config set, git config get)?
Or is the idea to remain compatible with older versions, such as the
2.32 I happen to have in /usr/bin on unsupported macOS 12.7.6 from
very old (?) XCode?

> +
> +Set your default branch name to `main`, by running this command.
> +Git is going to change its default branch name to `main` soon, so this
> +sets you up well for the future.
> +
> +------------------------------------------------
> +$ git config --global init.defaultBranch main
> +------------------------------------------------
> +
> +If there's no output, then it succeeded.
> +
> +Step 3: Create an empty folder and 2 files
> +------------------------------------------
> +
> +In your terminal, create an empty folder and change directories into it.
> +Later on you could follow the same steps in this tutorial to take an
> +existing project and start managing it with Git, but we're going to use
> +an empty project so that everyone following this tutorial has the exact
> +same files.
> +
> +For example, run these commands to make a folder called `myproject`
> +
> +------------------------------------------------
> +$ mkdir myproject
> +$ cd myproject
> +------------------------------------------------

I don't know, and I'll probably bias towards what you've already
written over asking for changes, but: does it make things any easier
to read and follow along with if we "git init myproject" instead?
Perhaps this version plants the seed that it's not too late to start
tracking any existing project, though, which is valuable :)

I wonder if you had some rationale for choosing this particular
sequence? Just curious, now.

> +Create 2 files in this directory, so we have something to work with.
> +
> +Make a file called README.md, with these contents:
> +
> +------------------------------------------------
> +We're doing a Git tutorial!
> +We need 2 lines in this file so here's a second one
> +------------------------------------------------
> +
> +And a file called `hello.py`, with these contents:
> +
> +------------------------------------------------
> +print("hello world")
> +------------------------------------------------
> +
> +Save the two files and keep them open in your text editor so you can
> +easily edit them later. The exact contents aren't too important, but
> +we'll use those contents in the example output later.
> +
> +You can check that the files are in the right place by running `ls`,
> +like this:
> +
> +
> +------------------------------------------------
> +$ ls
> +------------------------------------------------
> +
> +The output should be like this:
> +
> +------------------------------------------------
> +hello.py
> +README.md
> +------------------------------------------------
> +
> +Step 4: Create a Git repository
> +-------------------------------
> +
> +A Git repository is a folder which stores snapshots. It's usually a
> +hidden folder called `.git`. Every time you take a snapshot, Git stores
> +a copy of the contents of every file you're tracking.
> +
> +This might feel unbelievable, but Git uses compression so you can easily
> +store tens of thousands of snapshots without using too much disk space.
> +
> +You can create a Git repository for any folder in your computer by
> +running the command `git init`.
> +
> +Run `git init` in the folder you just created, like this:
> +
> +------------------------------------------------
> +$ git init
> +------------------------------------------------
> +
> +Git will reply:
> +
> +------------------------------------------------
> +Initialized empty Git repository in .git/
> +------------------------------------------------
> +
> +You might notice a new hidden folder was created, named `.git`.
> +
> +Step 5: Take your first snapshot
> +--------------------------------
> +
> +Next, we're going to take a snapshot of all the files in the directory
> +and tell Git to store them. Taking a snapshot in Git is a two step
> +process: first you need to run `git add` and then `git commit`.
> +
> +The reason it's a two step process is that sometimes you might not
> +actually want Git to store a snapshot of _all_ the files in a folder.
> +For example, if you have a file full of private personal information
> +called `personal.csv`, and a Python script called `process_data.py`, you
> +might want Git to keep a snapshot of the Python script but not the
> +private data.
> +
> +For now, we're going to store a snapshot of every file in your folder,
> +as well as in every subfolder.
> +
> +The first step of creating a snapshot is to tell Git which files you
> +want to include in the next snapshot using `git add`. To tell Git
> +"include all files", run this command:
> +
> +------------------------------------------------
> +$ git add .
> +------------------------------------------------
> +
> +Next you can create the snapshot using the `git commit` command, like
> +this. The `-m` flag stands for "message", and it lets you set a reminder
> +for your future self of what you were doing. The message ("Initial
> +commit" in this example) can say anything you want.
> +
> +------------------------------------------------
> +$ git commit -m "Initial commit"
> +------------------------------------------------
> +
> +You've now stored the first version of your project in Git! From now on
> +we're going to use the word "commit" instead of "snapshot", since that's
> +the term Git uses.

I know we want to limit scope=E2=80=A6 but I would love to not accidentally
encourage more use of "-m" for short (often useless?) messages.
Unfortunately, that drags in the can of worms that is editor
configuration. At least we can maybe point to
https://git-scm.com/book/en/v2/Getting-Started-First-Time-Git-Setup#_editor
and https://git-scm.com/book/en/v2/Appendix-C:-Git-Commands-Setup-and-Confi=
g#ch_core_editor
? idk.

> +
> +Step 6: Make a change
> +---------------------
> +
> +Now, let's learn how to make a change to a file and review the change yo=
u made.
> +In this example, we'll update the file `README.md`, but you can edit a
> +different file.
> +
> +First open `README.md` in your favourite text editor, make a tiny or
> +silly change, and save it.
> +
> +Next, in the terminal, run the command `git status` to get a summary of
> +what you changed since the last Git commit.
> +
> +------------------------------------------------
> +$ git status
> +------------------------------------------------
> +
> +The output will look something like this:
> +
> +------------------------------------------------
> +On branch main
> +
> +Changes not staged for commit:
> +  (use "git add <file>..." to update what will be committed)
> +  (use "git restore <file>..." to discard changes in working directory)
> +        modified:   README.md
> +------------------------------------------------
> +
> +This output says that we've changed `README.md` since the last time
> +we committed.
> +
> +Next, if you want to see the details of how you've changed `README.md`,
> +you can run `git diff`.
> +
> +------------------------------------------------
> +$ git diff
> +------------------------------------------------
> +
> +The output will look something like this:
> +
> +------------------------------------------------
> +diff --git a/README.md b/README.md
> +index 7ebaecb3..5a4ff712 100644
> +--- a/README.md
> ++++ b/README.md
> +@@ -1,2 +1,2 @@
> + Here are some Python scripts!
> ++I hope you like them.
> +------------------------------------------------
> +
> +This output says that we added one line, saying "I hope you like them.".
> +By default Git will show the lines you removed in red, and the lines you
> +added in green.

I would perhaps prefer to focus on the leading sigils (-, +) than the
color, if only because colorblindness can lead to all sorts of
situations with different color setups in the terminal's palette or
even (probably not our target audience) Git configuration. We could
probably mention that Git shows added and removed lines in *different*
colors without being too concerned with which colors those are? (That
avoids having to twist our words like "your terminal palette's green
and red" or w/e.)

> +
> +Step 7: Make another commit (easy way)
> +--------------------------------------
> +
> +Now let's tell Git to save the new version of `README.md` by making
> +another commit! To tell Git to snapshot all files that Git is tracking
> +and commit them, run this command:
> +
> +------------------------------------------------
> +$ git commit -am "Update README"
> +------------------------------------------------
> +
> +This is similar to the two step process in Step 4 where we used `git
> +add` and `git commit` to make a commit, but with a shortcut that lets
> +you do both in just one command. The `-a` stands for "all".
> +
> +Step 7b: Make another commit (longer way)
> +-----------------------------------------
> +
> +`git commit -am` is a fast way to snapshot all the files that Git is
> +tracking. But if you want Git to ignore changes to certain files, you
> +can instead do a 2-step process like in Step 4 where first you run `git
> +add` for every file that's been changed and that you want to include in
> +the next commit, like this:
> +
> +------------------------------------------------
> +$ git add README.md
> +------------------------------------------------
> +
> +and then run `git commit` (without the `-a`), like this:
> +
> +------------------------------------------------
> +$ git commit -m "Update README"
> +------------------------------------------------
> +
> +Step 8: Make a change and throw it away
> +---------------------------------------
> +
> +One of the most useful things about Git is that it lets you safely
> +experiment: you never need to be scared to change your code because you
> +can always go back to the old version.
> +
> +Before starting to experiment, run `git status` to check the current
> +state of your Git repository:
> +
> +------------------------------------------------
> +$ git status
> +On branch main
> +
> +nothing to commit, working tree clean
> +------------------------------------------------
> +
> +This "working tree clean" message means that there haven't been any
> +changes since your last commit.
> +
> +Now make a change to your code, and run `git status` again. Like last
> +time, you should see a message like this:
> +
> +------------------------------------------------
> +$ git status
> +On branch main
> +
> +Changes not staged for commit:
> +  (use "git add <file>..." to update what will be committed)
> +  (use "git restore <file>..." to discard changes in working directory)
> +        modified:   README.md
> +------------------------------------------------
> +
> +This tells us that `README.md` has been changed since the last commit.
> +But we don't actually want this change, so let's undo it! We can restore
> +`README.md` back to how it was at the most recent commit using the `git
> +restore` command.
> +
> +**WARNING**: `git restore` can't be reversed! Any time you run it it's
> +important to be absolutely sure that you're okay with throwing away your
> +changes since the last commit.
> +
> +------------------------------------------------
> +$ git restore README.md
> +------------------------------------------------
> +
> +Now open `README.md` again. You should see that your changes have been u=
ndone.
> +
> +You can stop here!
> +------------------
> +
> +The commands we've learned so far (`git init`, `git add`, `git commit`,
> +`git diff`, `git status`, and `git restore`) are enough to get a lot out
> +of Git on their own.
> +
> +With these commands, you can keep copies of past versions of your code
> +on your computer and safely experiment with big changes to your code.
> +
> +When using Git this way, all of your code just lives on your computer.
> +But if you want to put your code on the Internet so that other people
> +can use it or back it up, then you'll need to learn about one more
> +command: `git push`.
> +
> +The rest of this tutorial is about how to upload your code to a Git
> +repository on the Internet. The high level process is:
> +
> +1. Create an account on the Git host
> +2. Configure Git so that it can login to the Git host to make changes
> +3. Run `git push origin main` to upload your code
> +
> +Navigating the Git host's UI can be tricky, and it's hard for us to
> +give you exact directions because the UIs change a lot.
> +
> +Step 9: Create an account on a Git host
> +---------------------------------------
> +
> +To put your code on the Internet, you need it to be hosted somewhere.
> +The easiest way to do this is to sign up with a Git host. There's a list
> +of Git hosts (many of them offer free accounts) at
> +https://git-scm.com/tools/hosting. GitHub and GitLab are two popular hos=
ts.
> +
> +If you're comfortable running a server, there are other ways to host
> +a Git repository on the internet, like connecting through SSH or open
> +source Git forge software to your server.
> +
> +Step 10: Create an SSH key (if needed)
> +-------------------------------------
> +
> +For Git to upload changes to another Git repository, it needs a way to
> +login to that repository. One of the most popular ways to do this is
> +with an SSH key.
> +
> +If you don't already have an SSH key, you'll need to create one. On Mac
> +or Linux, you can check if you already have an SSH key by running:
> +
> +-------------------------------------------
> +$ ls ~/.ssh/*.pub
> +-------------------------------------------
> +
> +If you don't already have an SSH key, run:
> +
> +-------------------------------------------
> +$ ssh-keygen
> +-------------------------------------------
> +
> +`ssh-keygen` will ask you for some details.
> +The easiest way to do this is to just press Enter at every prompt until
> +it's done.
> +
> +NOTE: All of the advice about how to use SSH in this tutorial is aimed
> +at getting it to work as quickly as possible. Setting up SSH in a secure
> +way is very far outside the scope of this tutorial. If you have a
> +security team in your organization, they might have very different
> +opinions about the appropriate way to configure authentication with Git.
> +
> +Step 11: Tell the Git host your SSH public key
> +----------------------------------------------
> +
> +First, find your SSH key like this (on Mac or Linux):
> +
> +-------------------------------------------
> +$ ls ~/.ssh/*.pub
> +-------------------------------------------
> +
> +That will output something like
> +
> +-------------------------------------------
> +/home/alice/.ssh/id_ed25519.pub
> +-------------------------------------------
> +
> +Copy the contents of that file to your clipboard. It's important that
> +the filename ends in `.pub` ("pub" stands for "public").
> +
> +Then login to your account on the Git host you chose and paste the SSH
> +key into the appropriate place. Depending on the Git host, it's likely
> +under "SSH keys" in your settings. If it asks you what type of SSH key,
> +look for something like "Authentication Key".
> +
> +Once you've done this, you're done! Git will automatically use your SSH
> +key to try to connect.
> +
> +Step 12: Create an empty Git repository on the Git host
> +-------------------------------------------------------
> +
> +Go to the Git host's website and create a new Git repository.
> +
> +**WARNING**: If you create a public repository and push your repository
> +to it, then your name and email address, as well as the contents of
> +any files you committed and every previous version of those files, will
> +be on the public internet. Some Git hosts have the option to create
> +a private repository instead, to keep your information private.
> +
> +Step 13: Find the address of the repository
> +-------------------------------------------
> +
> +Now, find the address of the repository on your Git host. It should look
> +something like this:
> +
> +-------------------------------------------
> +git@git.example.com:username/repo.git
> +-------------------------------------------
> +
> +(where `example.com`, `username` and `repo` will be replaced with the
> +actual values).
> +
> +If you can only find an address starting with `https://`, then
> +you can often translate it to the SSH format by replacing `https://`
> +with `git@` and replacing the `/` after the domain name with an `:`.
> +Here's how:
> +
> +-------------------------------------------
> +https://git.example.com/username/repo
> +^^^^^^^^               ^
> +replace with "git@"    replace with ":"
> +-------------------------------------------

This is, of course, forge- and remote- dependent :) but I think it's
*probably* ok for the tutorial.

When you mentioned HTTPS-to-SSH translation, I was thinking of the
config-based URL rewrite mechanism, aha! I definitely don't think we
should go there ;)

> +
> +Step 14: push your changes
> +--------------------------
> +
> +Finally, we're ready to send the information in your local Git repositor=
y
> +to the one on the internet!
> +
> +First, tell Git about the other repository by running `git remote add`
> +in your terminal
> +(replace `git@example.com:username/repo.git` with the actual address):
> +
> +-------------------------------------------
> +$ git remote add origin git@example.com:username/repo.git
> +-------------------------------------------
> +
> +This tells Git to save the URL `git@example.com:username/repo.git` in
> +your Git repository's configuration under the name `origin`, so that you
> +can use it later. If you make a mistake while doing this, you can run
> +`git remote remove origin` and try again.
> +
> +Then tell Git to send the information, with `git push`
> +(if this doesn't work, read the "Troubleshooting `git push`" section for=
 advice!):
> +
> +-------------------------------------------
> +$ git push -u origin main
> +-------------------------------------------
> +
> +`origin` refers to the URL we just added (`git@example.com:username/repo=
.git`),
> +and `main` is the name of your current Git branch. You can use any name
> +(not just `origin`), but using `origin` often makes things easier
> +because it's the default for `git push` and `git pull`.
> +We haven't covered branches yet, but `main` is the default branch name.

I'm not sure if we should recommend "-u" without being able to explain
what it does, and=E2=80=A6 well=E2=80=A6 you and I have discussed how that'=
s difficult
:)

Doesn't the tutorial's recipe of always using "git push origin main"
work just fine? And if we later introduce pull and other
branch-/remote-stuff that cares about upstreams, we can mention this
shorthand then?

> +
> +Any time you want to set up a new repository, you can repeat steps
> +11-13, with one exception: you only need to pass `-u` the first time
> +you push. Afterwards you can just run the command:
> +
> +-------------------------------------------
> +$ git push origin main
> +-------------------------------------------
> +
> +It should output something like this:
> +
> +-------------------------------------------
> +To example.com:example_username/example
> + * [new branch]        main -> main
> +-------------------------------------------
> +
> +Troubleshooting `git push`
> +--------------------------
> +
> +There are 3 main errors you might run into when running `git push origin=
 main`.
> +Getting errors when running `git push` is actually a big part of using
> +Git, so congratulations! If you get to this part of the tutorial, you
> +get a little bonus experience in debugging.
> +
> +Here's a guide to why they're happening and how to fix them.
> +
> +**Problem 1**: You pushed to `main`, but your branch actually isn't call=
ed `main`
> +
> +Here's the error:
> +```
> +$ git push origin main
> +error: src refspec main does not match any
> +```
> +
> +This might happen if you didn't set `init.defaultBranch` to `main` in
> +<<step_2,Step 2>>.
> +
> +If you want to check the name of your current branch, you can run `git
> +status`. For example, in this output, the current branch is "master".
> +
> +-------------------------------------------
> +$ git status
> +On branch master
> +
> +...
> +-------------------------------------------
> +
> +To push your branch, you have a few options:
> +
> +* rename your branch to `main`, by running `git branch -m main`
> +  and then run `git push origin main`
> +* run `git push origin master`
> +  (where `master` is the name of your actual current branch)
> +
> +**Problem 2: SSH error**
> +
> +Here's the error:
> +
> +-----
> +$ git push origin main
> +The authenticity of host 'github.com (140.82.116.3)' can't be establishe=
d.
> +ED25519 key fingerprint is: SHA256:+DiY3wvvV6TuJJhbpZisF/zLDA0zPMSvHdkr4=
UvCOqU
> +This key is not known by any other names.
> +Are you sure you want to continue connecting (yes/no/[fingerprint])?
> +-----
> +
> +Git uses SSH to connect during `git push`, and this message happens when
> +SSH connects to a new site that you haven't connected to before.
> +
> +The easiest way to handle this is to type "yes" and press Enter.
> +
> +**Problem 3: the repository already exists**
> +
> +Here's the error:
> +
> +---------------------
> +$ git push origin main
> +! [rejected]        main -> main (fetch first)
> +error: failed to push some refs to 'example.com:example/example.git'
> +hint: Updates were rejected because the remote contains work that you do=
 not
> +hint: have locally.
> +---------------------
> +
> +If you see an error like this, it means that when you created the
> +repository on your Git host, it created a repository with a file in it
> +to try to help you out. (that's the "work that you do not have locally"
> +in the error message)
> +
> +You can fix this either by deleting the repository and recreating it, or
> +by running:
> +
> +---------------------
> +$ git push --force origin main
> +---------------------
> +
> +**WARNING**: In general it's quite dangerous to use `--force` because
> +it can erase work on the online repository in a way that's difficult to
> +recover. But if you know for sure that you just created the repository 2
> +minutes ago and there's nothing in it, then it's okay.
> +
> +MORE USEFUL GIT COMMANDS
> +------------------------
> +
> +* To tell Git to "un-add" a file that you added by accident, run
> +  `git rm --cached FILENAME`
> +
> +SEE ALSO
> +--------
> +linkgit:git-help[1],
> +
> +GIT
> +---
> +Part of the linkgit:git[1] suite
> --
> gitgitgadget

Overall I think this is excellent (and I wish bottom-post replies
encouraged saying this up front, hm).

Thanks!

--=20
D. Ben Knoble
