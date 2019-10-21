Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 079CD1F4C0
	for <e@80x24.org>; Mon, 21 Oct 2019 20:32:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730052AbfJUUcp (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Oct 2019 16:32:45 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45206 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728914AbfJUUcp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Oct 2019 16:32:45 -0400
Received: by mail-qt1-f194.google.com with SMTP id c21so23184167qtj.12
        for <git@vger.kernel.org>; Mon, 21 Oct 2019 13:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Kk0GHOMxQPyozghxeX8Ug505SoUoWV4Uyk2nQNHg72w=;
        b=H2RLX3n2ncCu/ZNipOCeovLfcrrfp9z+w8Eny/kjfCHv+wrC2XsKkC01BXu2b6rVW1
         ITPhfufEif8GfwfvpQuuGvNEPYBf+U/jsebFPqZhRjWRRN6Oq3bYOBqFxSos/fCF07FF
         bxeYbiJBUUmqEb77kMc0MdnG63QvB5z3T37JlwMG2Pt9nw2OnNAwUQCygDEaVpOvOaIj
         zsjK+U9axcOfRKRoIusxpKZmOWCu3CeQ2wQCOmRGSp3ohAFeWBLW52AlXqXY9j1xuwHw
         lL0cpVxz9pMhfs46Oef7Wr/5tcFc6nufAzQ1CeLTau3zp6W5aq61wEkOUcXgM5sbzJji
         uVdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Kk0GHOMxQPyozghxeX8Ug505SoUoWV4Uyk2nQNHg72w=;
        b=SNBSytbNliLgNVuhA6uclXSKC2I9HfkGNvSwXYbSyqFKaoM15/xy/r6DEy0NDCpD8E
         m5STCjxY+KLoF9ReAuDk8J1yHCZCR1AwMNaS+VDLZvNsSaWBs/uw4DJFSXcIRoZ0rGkp
         xO+QdPN8VRka2AbiL3M4HOTq8IyMcL3lXHLfR7M0q0mIzSkoUqG7YbHwV2mGo6Te0k+/
         GGCuqbNgjBjVyJKJFebJYfguuXvDDaHdMHkspckGrKzw+ODTS4kSDnyve0XYMuyXyw7f
         kPn4Mvhs2sx3Wq48yb90DWbytlI5XQLfc2cBBiUCDKhVaOHULORw1meSl9YN2N1ZqtBX
         ZQhQ==
X-Gm-Message-State: APjAAAWDMCF+i5DkfWnyGZLk6tu40Of/vZXnTSWY1gFqpZgefp9zAuZV
        +zLFFjjD53kZtIRfLbTYKS8=
X-Google-Smtp-Source: APXvYqwOXPJKy9z6rHODFCMleqLHYQ3oZXCrFX0CaZ/NL7dMbjvpYp3rwgTccH1X7du1h2HfjHHyzw==
X-Received: by 2002:ac8:534a:: with SMTP id d10mr15998739qto.349.1571689962762;
        Mon, 21 Oct 2019 13:32:42 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:4018:ebea:d287:d7b3? ([2001:4898:a800:1010:f14d:ebea:d287:d7b3])
        by smtp.gmail.com with ESMTPSA id m63sm8537242qkc.72.2019.10.21.13.32.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2019 13:32:42 -0700 (PDT)
Subject: Re: [Git Developer Blog] [PATCH] post: a tour of git's object types
To:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Cc:     pedro rijo <pedrorijo91@gmail.com>,
        James Ramsay <james@jramsay.com.au>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Andrew Ardill <andrew.ardill@gmail.com>
References: <20191019002045.148579-1-emilyshaffer@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <5dab3dc6-3942-422e-d29d-3e8682ebc4df@gmail.com>
Date:   Mon, 21 Oct 2019 16:32:41 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101
 Thunderbird/70.0
MIME-Version: 1.0
In-Reply-To: <20191019002045.148579-1-emilyshaffer@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/18/2019 8:20 PM, Emily Shaffer wrote:
> An overview of what Git object types mean and how they loosely translate
> into filesystem types users are already familiar with is a good start to
> making Git's internals less scary to users. This post is an interactive
> overview of the various types, demonstrating subcommands which show what
> the objects look like and how their names are generated.
> 
> This is related to https://gitlab.com/git-scm/blog/issues/15
> 
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
> Hi all,
> 
> In the hopes of getting some more momentum on the developer blog, here's
> a crosspost from my personal blog some months ago, targeted for the Git
> Developer Blog (as discussed in the Virtual Contributor Summit and
> on-list). During those conversations I emphasized my wish to make sure
> posts on this developer blog are vetted by the Git development community
> - to that end, the textual contents of this blog post are being sent to
> the vger.kernel.org list in their entirety. Feel free to provide
> comments here, or on the merge request in GitLab:
> https://gitlab.com/git-scm/blog/merge_requests/4
> Or, if you have another idea about how you'd like this review process to
> look, we may as well discuss it on this patch too.
> 
> I hope this post also shows what I hoped to achieve with the Git
> Developer Blog - in-depth, accurate information presented in a casual
> tone which helps users better understand Git.
> 
> At this time I've simply copied the blog post verbatim from my personal
> blog; I didn't do a lot of review on it because I was hoping to focus on
> the process of getting posts reviewed and accepted to the GitLab repo.
> It's probable that the tone is actually more conversational than we want
> for a developer blog, and the post itself didn't go through any kind of
> peer review, so I welcome comments on any and all aspects of the post.

Thanks for getting the conversation started (again)! I've got a post that
I've been tinkering with for some time now, and you gave me the motivation
to actually finish it.

> +Naming is one of the hard problems in computer science, right? It's hard for
> +Git developers too. One of the more arcane concepts in Git - object
> +reachability - becomes simpler to understand with a little bit of naming
> +indirection.
> +
> +Reachability is an important concept in Git. It's how the server determines
> +what objects you need in order to get it up to what the server itself knows.
> +It's also how merges and rebases work. With all this big stuff riding on
> +reachability, it seems intimidating to try to understand - but it turns out if
> +we give it a slightly simpler name, things become a little clearer.
> +
> +## Git's four object types
> +
> +Under the covers, Git is mostly a directed graph of objects. Those objects come
> +in four flavors; from root to leaf (generally), those flavors are:
> +
> +- Tag
> +- Commit
> +- Tree
> +- Blob
> +
> +We'll take a closer look in the opposite order, though.
> +
> +# Blob
> +
> +Surprise! It's a file. Well, kind of - it can also be a symlink to a file - but
> +this is the most atomic type of object. We'll explore these a little more later,
> +but really, it's just a file.

When I teach people about blobs [1], I take special care to point out that
a blob is only the file _content_. It does not actually store any information about
the filename or permissions.

It could help to describe an example: maybe `git cat-file -p HEAD:README` for a
well-known repo? I'm using "HEAD:<path>" here because it is easier to understand
where the file reference comes from, but perhaps it would be better to use a
"git rev-parse" and "git cat-file" pair:

$ git rev-parse HEAD:README.md
88f126184c52bfe4859ec189d018872902e02a84

$ git cat-file -p 88f126184c52bfe4859ec189d018872902e02a84
[![Build Status](https://dev.azure.com/git/git/_apis/build/status/git.git)](https://dev.azure.com/git/git/_build/latest?definitionId=11)

Git - fast, scalable, distributed revision control system
=========================================================

...

[1] https://stolee.dev/docs/git.pptx

> +
> +# Tree
> +
> +A tree references zero or more trees or blobs. Said another way, a tree holds
Perhaps "A tree references blobs and other trees." Saying "zero or more" makes
me get spun up about what it would mean for a tree to have zero entries, which
is not possible in porcelain Git.

> +one or more trees or files. This sounds familiar - basically, a tree is a
> +directory. (Okay, or a symlink to a directory.) It points to more trees
> +(subdirectories) or blobs (files). It can also point to commits in the case
> +of submodules, but that's another conversation.

Here is a great time to mention that filenames happen in a tree. You can
use `git cat-file -p HEAD:docs/` (or something) to show more contents of a tree.

> +By the way, "tree" is one that gets a little sticky, because we also talk about
> +"working tree" as well as "worktree". We'll touch back on that in a minute.

This paragraph did not seem particularly useful to me. Instead, you could take
some time to mention that the tree is separated from where in the file system
the corresponding folder would live.

> +
> +# Commit
> +
> +This is the one we're all familiar with - commits are those things we write at
> +1am, angry at a pesky bug, and label with something like "really fix it this
> +time", right?
> +
> +A commit references exactly one tree. That's the root directory of your project.

"That's the root directory of your project." could be better stated as "That tree
is a snapshot of the root directory of our project." I've found describing commits
as "snapshots" and "NOT DIFFS" is extremely important. That is the critical reason
people still ask for things like "it would be nice if 'git rebase' preserved commit
ids".

> +It also references zero or more other commits - and this is where we diverge
> +from the filesystem parallel, because the other commits it references are its
> +parent(s), each of which has its own copy of the project at that commit's point
> +in time. (Commits with more than one parent are merge commits; otherwise, your
> +commit only has the one parent.)
> +
> +Commits represent a specific state of the repository which someone thought was
> +worth saving - a new feature, or a small step of progress which you don't want
> +to lose as you're hacking your way through that homework assignment. Each commit
> +points to a complete image of the repository - but that's not as bad as it
> +sounds, as we'll see when we try it out.
> +
> +# Tag
> +
> +Tags are a little lackluster after all the exciting types up until now. They are
> +essentially a label; they serve as an entry point into the graph and point to
> +either another tag or a commit. They're generally used to mark releases, and you
> +can see them pretty easily with `git log --oneline --decorate=full`.

I usually ignore tags when I talk to people about Git objects. They are confusing,
and this paragraph doesn't really warn enough about how strange they are:

1. A tag is a ref in "refs/tags/".

2. An annotated tag is an object in the repo that contains a message and an object
   reference. That referenced object can be _anything_, including a tree or blob.
   (That has bit me a number of times working on server code.)

For these "complications", I recommend ignoring them OR presenting a "this is
complicated" warning. (Maybe even at the very end, as you don't need tags to
describe a typical workflow.)

> +# A quick return to an overloaded word
> +
> +"Tree", "worktree", and "working tree" seem to refer to different concepts. A
> +tree is a folder. Your working tree is your project state (and we can talk about
> +having a "clean" working tree, which means you don't have any staged or unstaged
> +changes pending). And "worktree" is a way for you to work on multiple branches
> +simultaneously in a different directory in a safe way (read `git help worktree`
> +for more - worktrees are awesome). But they're all named tree!

Add a link: https://git-scm.com/docs/git-worktree

> +It's a little clearer now that we know that every commit points to one tree -
> +the root of the project, a.k.a. your working tree, a.k.a. your worktree. `git
> +worktree` lets you put the tree associated with the commit at the tip of your
> +current branch in a different directory than the one you cloned into, and

"current branch" is incorrect: you cannot have multiple worktrees checking out
the same branch. You can detach at your current HEAD, or check out a different
branch.

> +having a clean working tree means that your filesystem is the same as the tree
> +your `HEAD` points to.
> +
> +## Try It And See<sup>TM</sup>
> +
> +It turns out the details of what objects Git knows about and what those objects
> +contain isn't as opaque as we might think. Git exposes a number of "plumbing
> +commands" which aren't so handy for interactive use but which are very useful
> +for scripting, as they describe the state of the repository in a concise and
> +predictable way. Let's walk through creating a pretty basic repository and
> +examining it with some low-level plumbing commands!
> +
> +# An empty repo
> +
> +For starters, we'll make a new, shiny, totally empty repo.
> +
> +{% highlight shell_session %}
> +$ mkdir demo
> +$ cd demo
> +$ git init
> +{% endhighlight %}
> +
> +We've got nothing. If we try `git log`, we'll be assured that we have no
> +commits, and if we try `git branch -a` we'll see we have no branches, either.
> +So let's make a very simple first commit.
> +
> +# A single commit
> +
> +{% highlight shell_session %}
> +$ echo "abcd" >foo.txt
> +$ git add foo.txt
> +$ git commit -m "first commit"
> +{% endhighlight %}
> +
> +I know this is boring, but bear with me and run `git ls-tree HEAD`.
> +
> +Hey, look, a blob! You'll see the object mode, the type, the _object ID_, and
> +the name of the file. For the rest of the post, I'll refer to the object ID as
> +the OID.
> +
> +The OID is a hash of the file contents. You can verify this for yourself with
> +`git hash-object foo.txt` - it's the same as your new blob's OID. The new blob
> +is literally just your file foo.txt, which you can verify by running `git
> +cat-file -p <oid>`:
> +
> +{% highlight shell_session %}
> +$ git ls-tree HEAD
> +100644 blob acbe86c7c89586e0912a0a851bacf309c595c308	foo.txt
> +$ git cat-file -p acbe86c7c89586e0912a0a851bacf309c595c308
> +abcd
> +{% endhighlight %}
> +
> +While we're here, we can also take a look at the commit object. Use `git log`
> +to determine your commit's OID, then use `git cat-file -p` to print the
> +contents:
> +
> +{% highlight shell_session %}
> +$ git log
> +commit a491754d3256b5823607d7ea4afb835c07f9fc2c (HEAD -> master)
> +Author: Emily Shaffer <nasamuffin@gmail.com>
> +Date:   Wed Jun 5 22:56:25 2019 -0700
> +
> +    first commit
> +$ git cat-file -p a491754d3256b5823607d7ea4afb835c07f9fc2c
> +tree 7376230624de9a38f4ea6ca4c41d47e41304b1bd
> +author Emily Shaffer <nasamuffin@gmail.com> 1559800585 -0700
> +committer Emily Shaffer <nasamuffin@gmail.com> 1559800585 -0700
> +
> +first commit
> +{% endhighlight %}
> +
> +This gave us the OID of our root tree, which we can also examine:
> +
> +{% highlight shell_session %}
> +emily@xenaTWP:~/demo$ git cat-file -p 7376230624de9a38f4ea6ca4c41d47e41304b1bd
> +100644 blob acbe86c7c89586e0912a0a851bacf309c595c308	foo.txt
> +{% endhighlight %}
> +
> +And what do you know - it's precisely the same output as `git ls-tree HEAD`.
> +Because we are literally printing the tree pointed to by HEAD.
> +
> +# A new file
> +
> +Let's see what happens when we add another file.
> +
> +{% highlight shell_session %}
> +$ echo "efgh" >bar.txt
> +$ git add bar.txt
> +$ git commit -m "The noise you make after too much time at the bar."
> +[master acc255b] The noise you make after too much time at the bar.
> + 1 file changed, 1 insertion(+)
> + create mode 100644 bar.txt
> +{% endhighlight %}
> +
> +Now we'll take a look at `git ls-tree HEAD` again and compare it to the output
> +from the prior commit (if you've scrolled past, you can run `git ls-tree
> +HEAD^`).
> +
> +{% highlight shell_session %}
> +$ git ls-tree HEAD^
> +100644 blob acbe86c7c89586e0912a0a851bacf309c595c308	foo.txt
> +$ git ls-tree HEAD
> +100644 blob ac38e5aa3826c56e2f32df05d23d2c27f09e7782	bar.txt
> +100644 blob acbe86c7c89586e0912a0a851bacf309c595c308	foo.txt
> +{% endhighlight %}
> +
> +It looks like we didn't actually create a new blob for foo.txt. That's why this
> +concept of each commit containing a copy of every file in the repository is
> +actually okay - the only new objects of substance being created are new copies
> +of whatever thing you've changed. (This is also why it's historically a bad idea
> +to check in your compiled binaries - someone doing `git clone` with no arguments
> +will get not just your latest release binary, but every release binary you ever
> +checked in. Oof.)
> +
> +But wait - if we shouldn't check in our 50MB release build, why is it okay for
> +us to check in our 5000-line legacy monolithic class? (Don't be embarrassed. It
> +happens to all of us.) It turns out that I'm not being totally honest when I say
> +we store "a copy of every file". All the objects are stored in `.git/objects/`,
> +so we can have a look with `cat
> +.git/objects/ac/be86c7c89586e0912a0a851bacf309c595c308`. Breathe a sigh of
> +relief; blobs are stored in a compressed state and `git cat-file` unpacks it for
> +us. The issue here is that your binary is much more difficult to compress than
> +a text file.
> +
> +# A modified file
> +
> +So what happens when we modify a file?
> +
> +{% highlight shell_session %}
> +$ echo "aaaa" >foo.txt
> +$ git add foo.txt
> +$ git commit -m "the scream of despair"
> +$ git ls-tree HEAD
> +100644 blob ac38e5aa3826c56e2f32df05d23d2c27f09e7782	bar.txt
> +100644 blob 5d308e1d060b0c387d452cf4747f89ecb9935851	foo.txt
> +{% endhighlight %}
> +
> +Looks like our bar.txt object remains, but we've got a new OID for foo.txt. So
> +what exactly lives in the blob of a file modification?
> +
> +{% highlight shell_session %}
> +$ git cat-file -p 5d308e1d060b0c387d452cf4747f89ecb9935851
> +aaaa
> +{% endhighlight %}
> +
> +No diff. It's the whole file. And our old version isn't gone; we can still pull
> +out the OID we used to know about:
> +
> +{% highlight shell_session %}
> +$ git cat-file -p acbe86c7c89586e0912a0a851bacf309c595c308
> +abcd
> +{% endhighlight %}
> +
> +# A subdirectory
> +
> +We mentioned earlier that trees can point to trees. Let's put it into practice:
> +
> +{% highlight shell_session %}
> +$ mdkir baz
> +$ echo frotz >baz/zork.txt
> +$ git add baz
> +$ git commit -m "ran out of placeholder words"
> +{% endhighlight %}
> +
> +So we expect to see a new tree and a new blob. A first crack at `git ls-tree
> +HEAD` doesn't go so well:
> +
> +{% highlight shell_session %}
> +$ git ls-tree HEAD
> +100644 blob ac38e5aa3826c56e2f32df05d23d2c27f09e7782	bar.txt
> +040000 tree 22741c26d13c9539d0ab7476ce09074dbd62a977	baz
> +100644 blob 5d308e1d060b0c387d452cf4747f89ecb9935851	foo.txt
> +{% endhighlight %}
> +
> +What happened to `zork.txt`? It's still there:
> +
> +{% highlight shell_session %}
> +$ git ls-tree 22741c26d13c9539d0ab7476ce09074dbd62a977
> +100644 blob 8e4020bb5a8d8c873b25de15933e75cc0fc275df	zork.txt
> +{% endhighlight %}
> +
> +By default, `git ls-tree` kind of behaves like `ls` - it doesn't recurse into
> +the trees it finds.  So we'll ask it to recurse (`-r`) and to also show the
> +names of tags it's recursing into (`-t`):
> +
> +{% highlight shell_session %}
> +$ git ls-tree -rt HEAD
> +100644 blob ac38e5aa3826c56e2f32df05d23d2c27f09e7782	bar.txt
> +040000 tree 22741c26d13c9539d0ab7476ce09074dbd62a977	baz
> +100644 blob 8e4020bb5a8d8c873b25de15933e75cc0fc275df	baz/zork.txt
> +100644 blob 5d308e1d060b0c387d452cf4747f89ecb9935851	foo.txt
> +{% endhighlight %}
> +
> +# Summary
> +
> +In the end, we have four commits:
> +
> +{% highlight shell_session %}
> +$ git log --oneline
> +230a4e9 (HEAD -> master) ran out of placeholder words
> +a0aa5e4 the scream of despair
> +acc255b The noise you make after too much time at the bar.
> +a491754 first commit
> +{% endhighlight %}
> +
> +Each one has its own tree:
> +
> +{% highlight shell_session %}
> +$ git ls-tree 230a4e9
> +100644 blob ac38e5aa3826c56e2f32df05d23d2c27f09e7782	bar.txt
> +040000 tree 22741c26d13c9539d0ab7476ce09074dbd62a977	baz
> +100644 blob 5d308e1d060b0c387d452cf4747f89ecb9935851	foo.txt
> +$ git ls-tree a0aa5e4
> +100644 blob ac38e5aa3826c56e2f32df05d23d2c27f09e7782	bar.txt
> +100644 blob 5d308e1d060b0c387d452cf4747f89ecb9935851	foo.txt
> +$ git ls-tree acc255b
> +100644 blob ac38e5aa3826c56e2f32df05d23d2c27f09e7782	bar.txt
> +100644 blob acbe86c7c89586e0912a0a851bacf309c595c308	foo.txt
> +$ git ls-tree a491754
> +100644 blob acbe86c7c89586e0912a0a851bacf309c595c308	foo.txt
> +{% endhighlight %}
> +
> +And in total, we should have **4** blob objects (two versions of `foo.txt` and
> +one version each of `bar.txt` and `zork.txt`), referenced by **5** tree objects
> +(one tree per commit, plus one tree for `baz/`), which are tracked through time
> +by **4** commits, giving us a total of 13 objects.
> +
> +We can check:
> +
> +{% highlight shell_session %}
> +$ git rev-list --all --objects
> +230a4e968f007b822d780c70e2f145f5b46ed170
> +a0aa5e491bb62906dc746aa10c548566e5dc8e4c
> +acc255b3a1ba1a3471133ff3aa7c2630437dd38c
> +a491754d3256b5823607d7ea4afb835c07f9fc2c
> +f2e243fb4052f01287a1d2225a231f9131af6840 
> +ac38e5aa3826c56e2f32df05d23d2c27f09e7782 bar.txt
> +22741c26d13c9539d0ab7476ce09074dbd62a977 baz
> +8e4020bb5a8d8c873b25de15933e75cc0fc275df baz/zork.txt
> +5d308e1d060b0c387d452cf4747f89ecb9935851 foo.txt
> +5a684389c10291eb7a187d37c5fb5e6ae6e44b3a 
> +076c36567233c1e9c22becf6008a96af7f6e865d 
> +acbe86c7c89586e0912a0a851bacf309c595c308 foo.txt
> +7376230624de9a38f4ea6ca4c41d47e41304b1bd 
> +$ git rev-list --all --objects | wc -l
> +13
> +{% endhighlight %}
> +
> +We can prove it to ourselves a little more easily with some pretty formatting:
> +
> +{% highlight shell_session %}
> +$ git rev-list --all --objects --header
> +230a4e968f007b822d780c70e2f145f5b46ed170
> +tree f2e243fb4052f01287a1d2225a231f9131af6840
> +parent a0aa5e491bb62906dc746aa10c548566e5dc8e4c
> +author Emily Shaffer <nasamuffin@gmail.com> 1559803688 -0700
> +committer Emily Shaffer <nasamuffin@gmail.com> 1559803688 -0700
> +
> +    ran out of placeholder words
> +a0aa5e491bb62906dc746aa10c548566e5dc8e4c
> +tree 5a684389c10291eb7a187d37c5fb5e6ae6e44b3a
> +parent acc255b3a1ba1a3471133ff3aa7c2630437dd38c
> +author Emily Shaffer <nasamuffin@gmail.com> 1559802687 -0700
> +committer Emily Shaffer <nasamuffin@gmail.com> 1559802687 -0700
> +
> +    the scream of despair
> +acc255b3a1ba1a3471133ff3aa7c2630437dd38c
> +tree 076c36567233c1e9c22becf6008a96af7f6e865d
> +parent a491754d3256b5823607d7ea4afb835c07f9fc2c
> +author Emily Shaffer <nasamuffin@gmail.com> 1559801779 -0700
> +committer Emily Shaffer <nasamuffin@gmail.com> 1559801779 -0700
> +
> +    The noise you make after too much time at the bar.
> +a491754d3256b5823607d7ea4afb835c07f9fc2c
> +tree 7376230624de9a38f4ea6ca4c41d47e41304b1bd
> +author Emily Shaffer <nasamuffin@gmail.com> 1559800585 -0700
> +committer Emily Shaffer <nasamuffin@gmail.com> 1559800585 -0700
> +
> +    first commit
> +f2e243fb4052f01287a1d2225a231f9131af6840 
> +ac38e5aa3826c56e2f32df05d23d2c27f09e7782 bar.txt
> +22741c26d13c9539d0ab7476ce09074dbd62a977 baz
> +8e4020bb5a8d8c873b25de15933e75cc0fc275df baz/zork.txt
> +5d308e1d060b0c387d452cf4747f89ecb9935851 foo.txt
> +5a684389c10291eb7a187d37c5fb5e6ae6e44b3a 
> +076c36567233c1e9c22becf6008a96af7f6e865d 
> +acbe86c7c89586e0912a0a851bacf309c595c308 foo.txt
> +7376230624de9a38f4ea6ca4c41d47e41304b1bd 
> +{% endhighlight %}

This section has some good details. My earlier comments about adding 'git cat-file'
commands are not super-relevant any more. The only thing I can say is that I prefer
the "examples first" [2] direction. Readers could tune out and get lost in the weeds
without some more concrete examples in-line.

[2] https://gowers.wordpress.com/2007/10/19/my-favourite-pedagogical-principle-examples-first/

> +## Back to reachability
> +
> +We're usually worried about finding out which objects are accessible from which
> +other objects. It turns out that "reachability" can be described in a couple
> +ways. Most succinctly, we can say it means that an object can be reached from
> +another object during a revision walk. But we can also describe it by explaining
> +what reachability means for each type of object.
> +
> +- Tag A is reachable from tag B if tag B can eventually be dereferenced to tag
> +A. Tags can be thought of as pointers, so if `*b==a` or `***b==a` or so on is
> +true, then tag A is reachable by tag B.
> +
> +- Commit A is reachable from commit B if commit A is an ancestor of commit B.
> +For commits, "reachability" is synonymous with "ancestry".
> +
> +- Tree A is reachable from tree B if it is a subdirectory of the directory tree
> +B is talking about. That is, if `find b-dir -name a-dir -type d` would succeed.
> +
> +- Blobs don't point to other blobs. But blob A is reachable from tree B if blob
> +A is contained within the directory of tree B - that is, if `find b-dir -name
> +a-file -type f` would succeed.
> +
> +- Tree A is reachable from commit B if it's commit B's root tree, or if it's a
> +subdirectory of that root tree.
> +
> +- Commit A is reachable from tag B if tag B can eventually be dereferenced to a
> +tag which points directly to commit A, since tags can point to other tags or to
> +commits.
> +
> +So while it means something a little different for each object, it's ultimately
> +trying to answer the question: "Somewhere in my history, did I know about this
> +object?"

Thanks for this! I hope my comments are helpful. They do not all
require a response.

What I like most about this post is that it communicates a personal voice.
This is _not_ documentation. The Git book has that kind of prose [3] (maybe
include a link for those who want to dig further?) A blog is temporary:
it exists to be a person saying "this is interesting at this moment!"
Having those extra flourishes keep some readers' interest more than
formal style.

[3] https://git-scm.com/book/en/v2/Git-Internals-Git-Objects


Thanks,
-Stolee


