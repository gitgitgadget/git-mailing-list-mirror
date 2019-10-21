Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_20,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57D8F1F4C0
	for <e@80x24.org>; Mon, 21 Oct 2019 20:43:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730317AbfJUUnH (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Oct 2019 16:43:07 -0400
Received: from mail-qt1-f182.google.com ([209.85.160.182]:42653 "EHLO
        mail-qt1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730308AbfJUUnH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Oct 2019 16:43:07 -0400
Received: by mail-qt1-f182.google.com with SMTP id w14so23253175qto.9
        for <git@vger.kernel.org>; Mon, 21 Oct 2019 13:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JvtLZLWnbnx/2Zl8ZDGYv9DiVBIV1gKTvfWUQBOpAIs=;
        b=rV43quh3FKc9BKuCVHJtOO1YixgRf5l2huZ1ncPILECgRQcNIPqCyZ5bbTgu/OffxM
         BW3wtVOV3xBK99UTzHOsbvZlazFEv1J8WDNCsapGs0yDefXqszPLbk2SDjXAoZU1x35R
         rF9PTryyzpyj32L6KoGrAlKxwyQ033fq534MrYlqL8LX1t2sK0FqSLp8AwFV4NaEHIHm
         FovEW0Ino+2Im2nzbPB2a1ONqcYTkFQDek1YTHdGCqTG17eC71tnYKsrLo8SFcHgk+vr
         6mkH2wjCcAmovFBrJm2vWUJ3SL1LUmSZ4fJagaLp4DUQo9IR5EEFNhXiMROCWH4EHaaX
         RHxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JvtLZLWnbnx/2Zl8ZDGYv9DiVBIV1gKTvfWUQBOpAIs=;
        b=WvidI9RPPoEP2E7avs+Pko+IBlRiCwgqQQHKxY2dWvoRiO9KLnu+ANs4A2OdhsnXfZ
         59njxKd5fYuZtSwTG04s1Xzax7DoBxaqnHH3ueMO+LEwAL5hXgloY8mgQFN4CGMwo8sf
         luBYFTcXd33Lw7OReRlI5BnbnAD4oI+dm86tzrwuQ9w0wgo6eoMFt2yk4RXQyVfB2V3T
         4e8ZwIZAPX6I0VbcYigu9JytopXPixBc9Kj9KlgVz3L6xvYqFaQKsnqWkssiQAsHLOV8
         vNbTUc839QaCouRCmgHesU1uLalGdCuT2/ZVCJLiZsnKQ76M9q8oeFK0sb+8ul0Wsp1k
         90yw==
X-Gm-Message-State: APjAAAV0k15hetjQKC0qL+9fdu3mh6/tIAbZTJdrX/bu6sjZp2ACgyiZ
        g4gESoh0VAODBolWkXHLt13rICoAP/Y=
X-Google-Smtp-Source: APXvYqzVDf4xwtjFQFKhgLQTuY7oMX99sVQTDWTamEMukPuU3UPXNHDZ5p4M5hdT+s1cOHVBWfivZA==
X-Received: by 2002:a05:6214:192:: with SMTP id q18mr3160730qvr.36.1571690584546;
        Mon, 21 Oct 2019 13:43:04 -0700 (PDT)
Received: from localhost.localdomain ([2001:4898:a800:1010:f14d:ebea:d287:d7b3])
        by smtp.gmail.com with ESMTPSA id n65sm8927753qkb.19.2019.10.21.13.43.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Oct 2019 13:43:04 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     emilyshaffer@google.com, me@jramsay.com.au,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [Git Developer Blog] [Blog Post] Updates to the Git Commit Graph Feature
Date:   Mon, 21 Oct 2019 16:42:53 -0400
Message-Id: <20191021204253.10196-1-dstolee@microsoft.com>
X-Mailer: git-send-email 2.23.0.vfs.1.1.87.g1f3c9be
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In this blog post, we discuss updates in to the Git commit-graph
feature since it was announced shortly after Git 2.18.0. This
answers the following:

1. What is the commit-graph?
2. Why should I enable the commit-graph?
3. How do I enable it now, or disable in time for 2.24.0?
4. How do I write it during fetch?
5. What is a commit-graph chain?

I intended the post to start at a level that any experienced Git
user could understand, but then it ramps up in detail by the end
to include some very deep technical details. I expect most readers
to give up after the first couple sections, but those who stick
to the end will learn something valuable.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---

Inspired by Emily's first contribution in the space [1], I now finished this
post that I've been working on here-and-there since Git 2.23.0. Now that 2.24.0
is imminent, the post is even more relevant. This is available as a Merge
Request [2] on the git-blog repo. You should be able to see the markdown style
and the SVG better there.

To create the image, I used Inkscape, then SVGMinify.com to reduce the file
size, which hopefully makes this patch less obnoxious.

[1] https://public-inbox.org/git/20191019002045.148579-1-emilyshaffer@google.com/

[2] https://gitlab.com/git-scm/blog/merge_requests/5/diffs#241fcd5d0d81901ba224af0d603905f593aaf821

 .../post/2019-10-31-commit-graph-updates.md   | 268 ++++++++++++++++++
 content/post/img/2019-commit-graph-chain.svg  |  85 ++++++
 2 files changed, 353 insertions(+)
 create mode 100644 content/post/2019-10-31-commit-graph-updates.md
 create mode 100644 content/post/img/2019-commit-graph-chain.svg

diff --git a/content/post/2019-10-31-commit-graph-updates.md b/content/post/2019-10-31-commit-graph-updates.md
new file mode 100644
index 0000000..abf6a14
--- /dev/null
+++ b/content/post/2019-10-31-commit-graph-updates.md
@@ -0,0 +1,268 @@
+---
+title: Updates to the Git Commit Graph Feature
+author: Derrick Stolee, Microsoft
+date: '2019-10-31'
+draft: true
+categories:
+  - Feature Announcement
+tags:
+  - commit-graph
+  - performance
+  - features
+---
+
+In [a previous blog series](https://devblogs.microsoft.com/devops/supercharging-the-git-commit-graph/),
+we announced that Git has a new _commit graph_ feature, and described some
+future directions. Since then, the commit-graph feature has grown and evolved.
+In the upcoming Git version 2.24.0, [the commit-graph will be enabled by default!](https://github.com/git/git/commit/31b1de6a09bad59cc0d88419925486afc7add277#diff-ec15845924b3ae854680823745518271)
+Today, we discuss what you should know about the feature, and what you can
+expect when you upgrade.
+
+# What is the commit-graph, and what is it good for?
+
+The commit-graph file is a binary file format that creates a structured
+representation of Git's commit history. At minimum, the commit-graph file
+is [faster to parse](https://github.com/git/git/blob/master/commit-graph.c#L606-L668)
+than decompressing commit files and [parsing them](https://github.com/git/git/blob/master/commit.c#L395-L455)
+to find their parents and root trees. This faster parsing can lead to 10x
+performance improvements.
+
+To get even more performance benefits, Git does not just use the commit-graph
+file to parse commits faster, but the commit-graph includes extra information
+to help avoid parsing some commits altogether. The critical idea is that an
+extra value -- the [generation number](https://devblogs.microsoft.com/devops/supercharging-the-git-commit-graph-iii-generations/)
+of a commit -- can significantly reduce the number of commits we need to walk
+to decide reachability. Since Git 2.19.0, the commit-graph
+[stores generation numbers](https://github.com/git/git/commit/3258c66332abaf6e3e8fd81cab07ae804760cd08).
+
+Since then, multiple algorithms were introduced to speed up Git commands such as
+[force push](https://github.com/git/git/commit/1e3497a24cf13fe907b247d1b93a997d6537cca1) or
+[fetch negotiation](https://github.com/git/git/commit/4fbcca4effc1c6f8431120f88f5a4bd1c8e38ca3).
+
+Finally, the most immediately visible improvement is the time it takes to sort
+commits by topological order. This algorithm is the critical path for `git log
+--graph`. Before the commit-graph, Git needed to walk every reachable commit
+before returning a single result.
+
+For example, here is a run of `git log --graph` in the Linux repository without
+the commit-graph feature, timing how long it takes to return ten results:
+
+```
+$ time git -c core.commitGraph=false log --graph --oneline -10 >/dev/null
+
+real    0m6.103s
+user    0m5.803s
+sys     0m0.300s
+```
+
+The reason it takes so long is because [Kahn's algorithm](https://en.wikipedia.org/wiki/Topological_sorting#Kahn's_algorithm)
+computes the "in-degrees" of every reachable commit before it can start to
+select commits of in-degree zero for output. When the commit-graph is present
+with generation numbers, Git now [uses an iterative version of Kahn's algorithm](https://github.com/git/git/commit/b45424181e9e8b2284a48c6db7b8db635bbfccc8)
+to avoid walking too far before knowing that some of the commits have in-degree
+zero and can be sent to output.
+
+Here is that same command again, this time with the commit-graph feature enabled:
+
+```
+$ time git -c core.commitGraph=true log --graph --oneline -10 >/dev/null
+
+real    0m0.009s
+user    0m0.000s
+sys     0m0.008s
+```
+
+Six seconds to nine milliseconds is a 650x speedup! Since most users asking
+for `git log --graph` actually see the result in a paged terminal window,
+this allows Git to load the first page of results almost instantaneously, and
+the next pages are available as you scroll through the history.
+
+The incremental nature of the algorithm can really be seen in real-time by
+using `git log --graph -- <file>` to investigate file history. When asking for
+a file that is not edited frequently, Git will still need to walk many commits
+to return the few results. For example, the Linux kernel `README` was edited
+in 46 of the 870,000+ commits of the repo. Running `git log --graph -- README`
+takes 0.33 seconds, but even in that time you can see the commits filling the
+page one-by-one. Without the commit-graph, the command pauses while it computes,
+then all results fill the page at the same time.
+
+# Sounds Great! What do I need to do?
+
+If you are using Git 2.23.0 or later, then you have all of these benefits
+available to you! You just need to enable the following config settings:
+
+* `git config --global core.commitGraph true`: this enables every Git repo to
+  use the commit-graph file, if present.
+
+* `git config --global gc.writeCommitGraph true`: this setting tells the `git gc`
+  command to write the commit-graph file whenever you do non-trivial garbage
+  collection. Rewriting the commit-graph file is a relatively small operation
+  compared to a full GC operation.
+
+* `git commit-graph write --reachable`: this command will update your
+  commit-graph file to contain all reachable commits. You can run this to create
+  the commit-graph file immediately, instead of waiting for your first GC operation.
+
+In the upcoming Git version 2.24.0, `core.commitGraph` and `gc.writeCommitGraph` 
+are [on by default](https://github.com/git/git/commit/31b1de6a09bad59cc0d88419925486afc7add277),
+so you don't need to set the config manually. If you _don't_ want commit-graph
+files, then explicitly disable these settings.
+
+# Write during fetch
+
+The point of the `gc.writeCommitGraph` is to keep your commit-graph updated
+with some frequency. As you add commits to your repo, the commit-graph gets
+further and further behind. That means your commit walks will parse more
+commits the old-fashioned way until finally reaching the commits in the
+commit-graph file.
+
+When working in a Git repo with many collaborators, the primary source of
+commits is not your own `git commit` calls, but your `git fetch` calls.
+However, if your repo is large enough, writing the commit-graph after each
+fetch can actually make a significant impact on your performance. Perhaps
+you downloaded a thousand new commits, but your repo has a million total
+commits. Writing the full commit-graph operates on the size of your repo,
+not on the size of your fetch, so writing those million commits is costly.
+
+During garbage collection, you are already paying for a full repack of all
+of your Git objects. That operation is already on the scale of your entire
+repository, so adding a full commit-graph write on top of that is not
+a problem.
+
+There is a solution: don't write the whole commit-graph every time! We'll
+go into how this works in more detail in the next section, but first you
+can enable the [`fetch.writeCommitGraph`](https://github.com/git/git/commit/50f26bd035816c2bb79582b834d59b49292502a9#diff-ec15845924b3ae854680823745518271)
+config setting to write the commit-graph after every `git fetch` command:
+
+```
+git config --global fetch.writeCommitGraph true
+```
+
+This ensures that your commit-graph is updated frequently and your Git
+commands are always as fast as possible.
+
+# Incremental Commit-Graph Format
+
+Before getting too far into the inremental file format, we need to refresh some
+details about the commit-graph file itself.
+
+## A Single Commit-Graph File
+
+The [commit-graph file format](https://github.com/git/git/blob/master/Documentation/technical/commit-graph-format.txt)
+stores commit data in a set of tables.
+
+One table is a sorted list of commit IDs. This row number of a commit ID in this
+table defines the _lexicographical position_ -- _lex_ position for short -- of
+a commit in the file.
+
+Another table contains metadata about the commits. The _n_th row of the metadata
+table corresponds to the commit with lex position _n_. This table contains the
+root tree ID, commit time, generation number, and information on the first two
+parents of the commit. We use special constants to say "this commit does not
+have a second parent", and use a pointer to a third "extra edges" table in the
+case of octopus merges.
+
+The two parent columns are stored as integers, and this is very important! If
+we store parents as commit IDs, then we waste a lot of space. Further, if we
+only have a commit ID, then we need to perform a binary search on the commit
+list to find the lex position. By storing the position of a parent, we can
+navigate to the metadata row for that parent as a random-access lookup.
+
+For that reason, the commit-graph file is _closed under reachability_, meaning
+that if a commit is in the file, then so is its parent. Otherwise, we could not
+refer to the parent using an integer.
+
+Before incremental writes, Git stored the commit-graph file as
+`.git/objects/info/commit-graph`. Git looks for that file, and parses the data
+there if it exists.
+
+## Multiple Commit-Graph Files
+
+If the single `.git/objects/info/commit-graph` file does not exist, Git looks
+for a file called `.git/objects/info/commit-graphs/commit-graph-chain`. This file
+contains a list of SHA-1 hashes separated by newlines. To demonstrate, we
+will use this list of placeholders:
+
+```
+{hash0}
+{hash1}
+{hash2}
+```
+
+These hashes correspond to files named
+`.git/objects/info/commit-graphs/graph-{hash0}.graph`. The chain of the three
+files combine to describe a set of commits.
+
+The first graph file, `graph-{hash0}.graph`, is a normal commit-graph file. It
+does not refer to any other commit-graph and is closed under reachability.
+
+The second graph file, `graph-{hash1}.graph` is no longer a normal commit-graph
+file. To start, it contains a pointer to `graph-{hash0}.graph` by storing an
+extra "base graphs" table containing only "{hash0}". Second, the parents of the
+commits in `graph-{hash1}.graph` may exist in that file _or_ in `graph-{hash0}.graph`.
+Each graph file stores the commits in lexicographic order, but we now need a
+second term for the position of a commit in the combined order.
+
+We say the _graph position_ of a commit in the commit-graph chain is the lex
+position of a commit in the sorted list plus the number of commits in the base
+commmit-graph files. We now modify our definition of a parent position to use
+the graph position. This allows the `graph-{hash1}.graph` file to not be closed
+under reachability: the parents can exist in either file.
+
+Extending to `graph-{hash2}.graph`, the parents of those commits can be in any
+of the three commit-graph files. The figure below shows this stack of files and
+how one commit row in `graph-{hash2}.graph` can have parents in `graph-{hash1}.graph`
+and `graph-{hash0}.graph`.
+
+![A chain of three commit-graphs](img/2019-commit-graph-chain.svg)
+
+To create your own commit-graph chain, you can start with an existing commit-graph
+file (created by `git commit-graph write --reachable`, for instance) then create
+new commits and run `git commit-graph write --reachable --split`. The `--split`
+option enables creating a chain of commit-graph files. If you ever run the command
+without the `--split` option, then the chain will merge into a single file.
+
+If you enable `fetch.writeCommitGraph`, then Git will write a commit-graph
+chain after every `git fetch` command. This is much faster than rewriting the
+entire file, since the top layer of the chain can consist of only the new
+commits. At least, it will _usually_ be faster.
+
+The figure above hints at the sizes of the commit-graph files in a chain. The
+base file is large and contains most of the commits. As we look higher in the
+chain, the sizes should shrink.
+
+There is a problem, though. What happens when we fetch 100 times? Will we get
+a chain of 100 commit-graph files? Will our commit lookups suddenly get much
+slower? The way to avoid this is to occasionally merge layers of the chain.
+This results in better [amortized time](https://en.wikipedia.org/wiki/Amortized_analysis),
+but will sometimes result in a full rewrite of the entire commit-graph file.
+
+## Merging Commit-Graph Files
+
+To ensure that the commit-graph chain does not get too long, Git will occasionally
+merge layers of the chain. This merge operation is always due to some number of
+incoming commits causing the "top" of the chain to be too large. There are two
+reasons Git would merge layers, given by these options to `git commit-graph
+write`:
+
+1. `--size-multiple=<X>`: Ensure that a commit-graph file is `X` times larger
+   than any commit-graph file "above" it. `X` defaults to 2.
+
+2. `--max-commits=<M>`: When specified, make sure that only the base layer
+   has more than `M` commits.
+
+The size-multiple option ensures that the commit-graph chain never has more
+than log(_N_) layers, where _N_ is total number of commits in the repo. If those
+chains seem to be too long, the max-commits setting (in conjunction with size-multiple)
+guarantees that there are a constant number of possible layers.
+
+In all, you should not see the incremental commit-graph taking very long during
+a fetch. You are more likely to see the automatic garbage collection trigger, and
+that will cause your commit-graph chain to collapse to a single layer.
+
+# Try it Yourself!
+
+We would love your feedback on the feature! Please test out the `--split` option
+for writing commit-graphs in Git 2.23.0 or later, and the `fetch.writeCommitGraph`
+option in Git 2.24.0. Release candidates for Git 2.24.0 are out now, and ready
+for testing!
diff --git a/content/post/img/2019-commit-graph-chain.svg b/content/post/img/2019-commit-graph-chain.svg
new file mode 100644
index 0000000..b426853
--- /dev/null
+++ b/content/post/img/2019-commit-graph-chain.svg
@@ -0,0 +1,85 @@
+<?xml version="1.0" encoding="UTF-8"?>
+<svg width="5.6894in" height="5.2459in" version="1.1" viewBox="0 0 144.51104 133.24566" xmlns="http://www.w3.org/2000/svg" xmlns:cc="http://creativecommons.org/ns#" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
+<defs>
+<marker id="b" overflow="visible" orient="auto">
+<path transform="matrix(-.4 0 0 -.4 -4 0)" d="m0 0 5-5-17.5 5 17.5 5z" fill-rule="evenodd" stroke="#000" stroke-width="1pt"/>
+</marker>
+<marker id="g" overflow="visible" orient="auto">
+<path transform="matrix(-.4 0 0 -.4 -4 0)" d="m0 0 5-5-17.5 5 17.5 5z" fill-rule="evenodd" stroke="#000" stroke-width="1pt"/>
+</marker>
+<marker id="c" overflow="visible" orient="auto">
+<path transform="scale(.8)" d="m0 5.65v-11.3" fill="none" stroke="#000" stroke-width="1pt"/>
+</marker>
+<marker id="d" overflow="visible" orient="auto">
+<path transform="scale(.8)" d="m0 5.65v-11.3" fill="none" stroke="#000" stroke-width="1pt"/>
+</marker>
+<marker id="e" overflow="visible" orient="auto">
+<path transform="scale(.8)" d="m0 5.65v-11.3" fill="none" stroke="#000" stroke-width="1pt"/>
+</marker>
+<marker id="f" overflow="visible" orient="auto">
+<path transform="scale(.8)" d="m0 5.65v-11.3" fill="none" stroke="#000" stroke-width="1pt"/>
+</marker>
+<marker id="a" overflow="visible" orient="auto">
+<path transform="scale(.8)" d="m0 5.65v-11.3" fill="none" stroke="#000" stroke-width="1pt"/>
+</marker>
+</defs>
+<metadata>
+<rdf:RDF>
+<cc:Work rdf:about="">
+<dc:format>image/svg+xml</dc:format>
+<dc:type rdf:resource="http://purl.org/dc/dcmitype/StillImage"/>
+<dc:title/>
+</cc:Work>
+</rdf:RDF>
+</metadata>
+<g transform="translate(4.2812 -168.05)">
+<rect x="-4.21" y="168.04" width="144.45" height="133.58" fill="#fff" stroke="#fff" stroke-width=".31055"/>
+<path d="m121.93 180.78h5.6241c1.662 0 3 1.338 3 3v28.341c0 1.662-1.338 3-3 3h-3.5074" fill="none" marker-end="url(#g)" stroke="#000" stroke-width=".3"/>
+<path d="m121.93 180.78h8.7991c1.662 0 3 1.338 3 3v62.208c0 1.662-1.338 3-3 3h-6.6824" fill="none" marker-end="url(#b)" stroke="#000" stroke-width=".3"/>
+<path d="m27.217 173.08h94.37c0.554 0 1 0.446 1 1v13.612c0 0.554-0.446 1-1 1h-94.37c-0.554 0-1-0.446-1-1v-13.612c0-0.554 0.446-1 1-1z" fill="#f2f2f2" stroke="#000"/>
+<path d="m27.217 196.28h94.37c0.554 0 1 0.446 1 1v29.487c0 0.554-0.446 1-1 1h-94.37c-0.554 0-1-0.446-1-1v-29.487c0-0.554 0.446-1 1-1z" fill="#f2f2f2" stroke="#000"/>
+<path d="m27.217 235.44h94.37c0.554 0 1 0.446 1 1v61.766c0 0.554-0.446 1-1 1h-94.37c-0.554 0-1-0.446-1-1v-61.766c0-0.554 0.446-1 1-1z" fill="#f2f2f2" stroke="#000"/>
+<path d="m26.414 178.35h95.909" fill="none" stroke="#000" stroke-width=".26458px"/>
+<path d="m26.414 183.64h95.909" fill="none" stroke="#000" stroke-width=".26458px"/>
+<path d="m26.414 201.63h95.909" fill="none" stroke="#000" stroke-width=".26458px"/>
+<path d="m26.414 206.93h95.909" fill="none" stroke="#000" stroke-width=".26458px"/>
+<path d="m26.414 212.22h95.909" fill="none" stroke="#000" stroke-width=".26458px"/>
+<path d="m26.414 217.51h95.909" fill="none" stroke="#000" stroke-width=".26458px"/>
+<path d="m26.414 222.8h95.909" fill="none" stroke="#000" stroke-width=".26458px"/>
+<path d="m26.414 240.79h95.909" fill="none" stroke="#000" stroke-width=".26458px"/>
+<path d="m26.414 246.08h95.909" fill="none" stroke="#000" stroke-width=".26458px"/>
+<path d="m26.414 251.38h95.909" fill="none" stroke="#000" stroke-width=".26458px"/>
+<path d="m26.414 256.67h95.909" fill="none" stroke="#000" stroke-width=".26458px"/>
+<path d="m26.414 261.96h95.909" fill="none" stroke="#000" stroke-width=".26458px"/>
+<path d="m26.414 267.25h95.909" fill="none" stroke="#000" stroke-width=".26458px"/>
+<path d="m26.414 272.54h95.909" fill="none" stroke="#000" stroke-width=".26458px"/>
+<path d="m26.414 277.83h95.909" fill="none" stroke="#000" stroke-width=".26458px"/>
+<path d="m26.414 283.13h95.909" fill="none" stroke="#000" stroke-width=".26458px"/>
+<path d="m26.414 288.42h95.909" fill="none" stroke="#000" stroke-width=".26458px"/>
+<path d="m26.414 293.71h95.909" fill="none" stroke="#000" stroke-width=".26458px"/>
+<path d="m21.281 188.13v-9.7292" fill="none" marker-end="url(#a)" marker-start="url(#a)" stroke="#000" stroke-width=".265"/>
+<path d="m8.0517 299.26v-120.85" fill="none" marker-end="url(#e)" marker-start="url(#f)" stroke="#000" stroke-width=".265"/>
+<path d="m21.281 299.26v-103.39" fill="none" marker-end="url(#c)" marker-start="url(#d)" stroke="#000" stroke-width=".265"/>
+<text transform="rotate(-90)" x="-230.33467" y="6.1092191" fill="#000000" font-family="Arial" font-size="7.0556px" letter-spacing="0px" stroke-width=".26458" text-align="center" text-anchor="middle" word-spacing="0px" style="line-height:1.25" xml:space="preserve"><tspan x="-230.33467" y="6.1092191" font-size="5.6444px" stroke-width=".26458">graph position</tspan></text>
+<text transform="rotate(-90)" x="-239.95189" y="19.898293" fill="#000000" font-family="Arial" font-size="7.0556px" letter-spacing="0px" stroke-width=".26458" text-align="center" text-anchor="middle" word-spacing="0px" style="line-height:1.25" xml:space="preserve"><tspan x="-239.95189" y="19.898293" font-size="5.6444px" stroke-width=".26458">number of base commits</tspan></text>
+<text transform="rotate(-90)" x="-178.97917" y="18.012175" fill="#000000" font-family="Arial" font-size="7.0556px" letter-spacing="0px" stroke-width=".26458" text-align="center" text-anchor="middle" word-spacing="0px" style="line-height:1.25" xml:space="preserve"><tspan x="-178.97917" y="18.012175" font-size="5.6444px" stroke-width=".26458" style="line-height:0">position</tspan></text>
+<text transform="rotate(-90)" x="-184.98222" y="13.381416" fill="#000000" font-family="Arial" font-size="7.0556px" letter-spacing="0px" stroke-width=".26458" text-align="center" text-anchor="middle" word-spacing="0px" style="line-height:1.25" xml:space="preserve"><tspan x="-184.98222" y="13.381416" font-size="5.6444px" stroke-width=".26458" style="line-height:0">lex</tspan></text>
+<rect x="26.414" y="178.35" width="95.909" height="5.2917" fill="#fca" stroke="#000" stroke-width=".3026"/>
+<text x="40.151272" y="182.74898" fill="#000000" font-family="Arial" font-size="4.9389px" letter-spacing="0px" stroke-width=".26458" text-align="center" text-anchor="middle" word-spacing="0px" style="line-height:1.25" xml:space="preserve"><tspan x="40.151272" y="182.74898" font-size="4.9389px" stroke-width=".26458" style="line-height:0">commit id</tspan></text>
+<text x="69.255447" y="182.74898" fill="#000000" font-family="Arial" font-size="4.9389px" letter-spacing="0px" stroke-width=".26458" text-align="center" text-anchor="middle" word-spacing="0px" style="line-height:1.25" xml:space="preserve"><tspan x="69.255447" y="182.74898" font-size="4.9389px" stroke-width=".26458" style="line-height:0">tree id</tspan></text>
+<text x="101.99261" y="182.67987" fill="#000000" font-family="Arial" font-size="4.9389px" letter-spacing="0px" stroke-width=".26458" text-align="center" text-anchor="middle" word-spacing="0px" style="line-height:1.25" xml:space="preserve"><tspan x="101.99261" y="182.67987" font-size="4.9389px" stroke-width=".26458" style="line-height:0">parent positions</tspan></text>
+<path d="m56.847 173.34v15.348" fill="none" stroke="#000" stroke-width=".26458px"/>
+<path d="m81.718 173.34v15.348" fill="none" stroke="#000" stroke-width=".26458px"/>
+<path d="m56.847 196.62v30.694" fill="none" stroke="#000" stroke-width=".26458px"/>
+<path d="m81.718 196.62v30.694" fill="none" stroke="#000" stroke-width=".26458px"/>
+<path d="m56.847 235.78v63.502" fill="none" stroke="#000" stroke-width=".26458px"/>
+<path d="m81.718 235.78v63.502" fill="none" stroke="#000" stroke-width=".26458px"/>
+<path d="m103.41 173.34v15.348" fill="none" stroke="#000" stroke-dasharray="2.1199999, 2.1199999" stroke-width=".265"/>
+<path d="m103.41 196.62v31.223" fill="none" stroke="#000" stroke-dasharray="2.1199999, 2.1199999" stroke-width=".265"/>
+<path d="m103.41 235.78v62.973" fill="none" stroke="#000" stroke-dasharray="2.1199999, 2.1199999" stroke-width=".265"/>
+<text x="44.008171" y="171.36497" fill="#000000" font-family="Arial" font-size="4.4781px" letter-spacing="0px" stroke-width=".16793" text-align="center" text-anchor="middle" word-spacing="0px" style="line-height:1.25" xml:space="preserve"><tspan x="44.008171" y="171.36497" font-size="3.5825px" stroke-width=".16793" style="line-height:0">graph-{hash2}.graph</tspan></text>
+<text x="44.008171" y="171.36497" fill="#000000" font-family="Arial" font-size="4.4781px" letter-spacing="0px" stroke-width=".16793" text-align="center" text-anchor="middle" word-spacing="0px" style="line-height:1.25" xml:space="preserve"><tspan x="44.008171" y="171.36497" font-size="3.5825px" stroke-width=".16793" style="line-height:0">graph-{hash2}.graph</tspan></text>
+<text x="44.008171" y="195.17746" fill="#000000" font-family="Arial" font-size="4.4781px" letter-spacing="0px" stroke-width=".16793" text-align="center" text-anchor="middle" word-spacing="0px" style="line-height:1.25" xml:space="preserve"><tspan x="44.008171" y="195.17746" font-size="3.5825px" stroke-width=".16793" style="line-height:0">graph-{hash1}.graph</tspan></text>
+<text x="44.008171" y="234.3358" fill="#000000" font-family="Arial" font-size="4.4781px" letter-spacing="0px" stroke-width=".16793" text-align="center" text-anchor="middle" word-spacing="0px" style="line-height:1.25" xml:space="preserve"><tspan x="44.008171" y="234.3358" font-size="3.5825px" stroke-width=".16793" style="line-height:0">graph-{hash0}.graph</tspan></text>
+</g>
+</svg>
-- 
2.23.0.vfs.1.1.87.g1f3c9be

