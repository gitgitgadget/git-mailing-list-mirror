Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7698B32548B
	for <git@vger.kernel.org>; Mon, 27 Oct 2025 19:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761593546; cv=none; b=J4IwnAAkkMMom0jutS4xnbsNTpsB39CyB7hqW1ywFgG/aJV9B2bHxdlYryd6gUcpKdvZpN46hJdtOaFbJyBhhTbRcK6D8hB0xDQEBRtv7Ag4i7LByT0XgPJqPXrThtwHTrNrWXSUWYzmk45PpxlK0dYUy7r5/OC+xrSexVSS1NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761593546; c=relaxed/simple;
	bh=P4jryAmKfxokvFUFdqBTeIgHB2NaDgRcklU6xfuguY0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=s55GYx8KnqvUEBGZeQeS9JKvUVxClsQduLS2+RbwAO53rmCaLS4QGAJCgALbutNrCQM+MtMxF85Chevw03PED9xxCFnU/mi+FWWfM7OXQGDREWAovHjU3tG1tZrFK2MlAuAW9NY+Y39hMyEBeA07fWpO+ob0za5ewQBWGwDoN8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QIgk9CoW; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QIgk9CoW"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-430a5fe0c5cso46747495ab.0
        for <git@vger.kernel.org>; Mon, 27 Oct 2025 12:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761593542; x=1762198342; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PXMh5h3u8Kw4q2ocDhCeFxVACoiKJ9DM1RGdNg0ePlo=;
        b=QIgk9CoW0aoOrPoN9kvMpzvqDXdpxb0vDyOhxTR69Zp1UbTIqzWIJX6cjDwci2UdId
         hmNnQ7xdsslAof3b88k04l9CmT8SJ9+iioOWTtZtyxf9M4UQyWuFeWjhB9GWkap+e4w2
         raGwgiwAjSkq4zJWHdd7CU4YBDGP3jIzBAFtIkJ7BzMkiuZSWat0HVsGyb1ZDaJaeOrr
         WqUB+NXg1R6zqxz6tW6POAFF54M990cXnUQv1UuaYelqlCVTOEOv0GMq6+eplqyXJuww
         egMrmrl6XMoFZfJuiijQ/jUkGv6d3VanWXHtTEqzvabOyUoR61o+O/GH0GcAPxhSIsYN
         pHFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761593542; x=1762198342;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PXMh5h3u8Kw4q2ocDhCeFxVACoiKJ9DM1RGdNg0ePlo=;
        b=WfzPckKAyBv3T+EZQxbX5gaAk12toJhd6iaYPxB5DjysQ0RGSd9xNbJ3jt56OiCj5d
         V1UdChSCDHO7nvAlQqA4eivd58JzXfKJhMSoHm4CrSYCKjr1HUXHAjePHOODZUzCADYX
         8g3R0l1PKp0B48HpzS59X1ceN4osz/dnaJClCyvKCs26gQ9QG00P4R9GAT5OaLyy+Agx
         nvYDnbis3RxABLY7F1rdwAyOsmdEhgNTMx/g/glzjyAS97q4+mZAYIGe2jT1lNsgUHQp
         vqxUqpU/UIAJMm45HGWGX2n3CgBkDbD6QyK3eGOexmvYErnttNTclpTyiAnm+0k4HcU3
         JGPg==
X-Gm-Message-State: AOJu0YwWrkYH89HyoZgmxkdVyDhzEC/q7P4BpMzoaO672xjWMDXjT6n7
	57+TRIfQ16OtUZwg7AiDbOyj5X6ZYCVnaiV1c3KQpTn3IFGqDi221I9d6K22uA==
X-Gm-Gg: ASbGncuUXDimJmot2Gg1t/1/ly+kS6BJEWu+2IQeXg5FclRRn5y2TIcTlxONgzR6rI2
	3GyaD7wWB9SoRpBNE6DOYQFUZdo9iZvuRhoHvbfU1hMu6huGpKejeE1gV2lZAHEHjZfPqKLiTyu
	iIAnKCDqnisaDemxJ2SQEevBFKawBOkatzk0geUoTVElkKL0KPonvHz2rAhBWvG1C++qkwKB/u6
	eB/ZvSKRtitsme+nnCstBYbdYHehfiZUHaJBw/rPRHhSZwWI9QlyKgNodJCTaCTSvK7PrFnF1k5
	OgvEhIOrBeLBAZJilfLDs/kPGhFHd5FLGckxUPAcVjKvKERaD/eAOYktYdiOt25Z6tLLKcdyKzK
	AA5zH7DA3FGY87HJiBneC6hwjhRMAnlyrbo+MbXXsY/7TVND2sDi+hnZuJn5CY+I2UQgaawmEI6
	F6
X-Google-Smtp-Source: AGHT+IGdd4qfSxYwIM/7LIAI/UGfGPUtcspMn6QLSWRiEe2VYuMPq1/+VN/dsUpMn4+i5f0P9zIaZg==
X-Received: by 2002:a05:6e02:378e:b0:430:b290:b6c5 with SMTP id e9e14a558f8ab-4320f7ba73cmr16076845ab.30.1761593539173;
        Mon, 27 Oct 2025 12:32:19 -0700 (PDT)
Received: from [127.0.0.1] ([52.165.58.34])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-431f688b3d6sm34255655ab.24.2025.10.27.12.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 12:32:18 -0700 (PDT)
Message-Id: <pull.1981.v4.git.1761593537924.gitgitgadget@gmail.com>
In-Reply-To: <pull.1981.v3.git.1760476346040.gitgitgadget@gmail.com>
References: <pull.1981.v3.git.1760476346040.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 27 Oct 2025 19:32:17 +0000
Subject: [PATCH v4] doc: add an explanation of Git's data model
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

Git very often uses the terms "object", "reference", or "index" in its
documentation.

However, it's hard to find a clear explanation of these terms and how
they relate to each other in the documentation. The closest candidates
currently are:

1. `gitglossary`. This makes a good effort, but it's an alphabetically
    ordered dictionary and a dictionary is not a good way to learn
    concepts. You have to jump around too much and it's not possible to
    present the concepts in the order that they should be explained.
2. `gitcore-tutorial`. This explains how to use the "core" Git commands.
   This is a nice document to have, but it's not necessary to learn how
   `update-index` works to understand Git's data model, and we should
   not be requiring users to learn how to use the "plumbing" commands
   if they want to learn what the term "index" or "object" means.
3. `gitrepository-layout`. This is a great resource, but it includes a
   lot of information about configuration and internal implementation
   details which are not related to the data model. It also does
   not explain how commits work.

The result of this is that Git users (even users who have been using
Git for 15+ years) struggle to read the documentation because they don't
know what the core terms mean, and it's not possible to add links
to help them learn more.

Add an explanation of Git's data model. Some choices I've made in
deciding what "core data model" means:

1. Omit pseudorefs like `FETCH_HEAD`, because it's not clear to me
   if those are intended to be user facing or if they're more like
   internal implementation details.
2. Don't talk about submodules other than by mentioning how they
   relate to trees. This is because Git has a lot of special features,
   and explaining how they all work exhaustively could quickly go
   down a rabbit hole which would make this document less useful for
   understanding Git's core behaviour.
3. Don't discuss the structure of a commit message
   (first line, trailers etc).
4. Don't mention configuration.
5. Don't mention the `.git` directory, to avoid getting too much into
   implementation details

Signed-off-by: Julia Evans <julia@jvns.ca>
---
    doc: Add a explanation of Git's data model
    
    Changes in v2:
    
    The biggest change is to remove all mentions of the .git directory, and
    explain references in a way that doesn't refer to "directories" at all,
    and instead talks about the "hierarchy" (from Kristoffer and Patrick's
    reviews).
    
    Also:
    
     * objects: Mention that an object ID is called an "object name", and
       update the glossary to include the term "object ID" (from Junio's
       review)
     * objects: Replace "SHA-1 hash" with "cryptographic hash" which is more
       accurate (from Patrick's review)
     * blobs: Made the explanation of git gc a little higher level and took
       some ideas from Patrick's suggested wording (from Patrick's and
       Kroftoffer's reviews)
     * commits: Mention that tag objects and commits can optionally have
       other fields. I didn't mention the GPG signature specifically, but
       don't have any objections to adding it. (from Patrick and Junio's
       reviews)
     * commits: Remove one of the mentions of git gc, since it perhaps opens
       up too much of a rabbit hole: "how does git gc decide which commits
       to clean up?". (from Kristoffer's review)
     * tag objects: Add an example of how a tag object is represented (from
       user feedback on the draft)
     * index: Use the term "file mode" instead of "permissions", and list
       all allowed file modes (from Patrick's review)
     * index: Use "stage number" instead of "number" for index entries (from
       Patrick's review)
     * reflogs: Remove "any ref can be logged", it raises some questions of
       "how do you tell Git to log a ref that it isn't normally logging?"
       and my guess is that it's uncommon to ask Git to log more refs. I
       don't think it's a "lie" to omit this but I can bring it back if
       folks disagree. (from Patrick's review)
     * reflogs: Fix an error I noticed in the explanation of reflogs: tags
       aren't logged by default and remote-tracking branches are, according
       to man git-config
     * branches and tags: Be clearer about how branches are usually updated
       (by committing), and make it a little more obvious that only branches
       can be checked out. This is a bit tricky because using the word
       "check out" introduces a rabbit hole that I want to avoid (what does
       "check out" mean?). I've dealt this by just talking about the
       "current branch" (HEAD) since that is defined here, and making it
       more explicit that HEAD must either be a branch or a commit, there's
       no "HEAD is a tag" option. (from Patrick's review)
     * tags: Explain the differences between annotated and lightweight tags
       (this is the main piece of user feedback I've gotten on the draft so
       far)
     * Various style/typo changes ("2 or more", linkgit:git-gc[1], removed
       extra asterisks, added empty SYNOPSIS, "commits -> tags" typo fix,
       add to meson build)
    
    non-changes:
    
     * I still haven't mentioned things that aren't part of the "data
       model", like revision params and configuration. I think there could
       be a place for them but I haven't found it yet.
     * tag objects: I noticed that there's a "tag" header field in tag
       objects (like tag v1.0.0) but I didn't mention it yet because I
       couldn't figure out what the purpose of that field is (I thought the
       tag name was stored in the reference, why is it duplicated in the tag
       object?)
    
    Changes in v3:
    
    I asked for feedback from Git users on Mastodon and got 220 pieces of
    feedback from 48 different users. People seemed very excited to read
    about Git's data model. Usually I judge explanations by what folks
    report learning from them. Here people reported learning:
    
     * how branches are stored (that a branch is "a name for a commit")
     * how objects work
     * that Git has separate "author" and "committer" fields
     * that amending a commit does not change it
     * that a tree is "just a directory" (not something more complicated),
       and how trees are stored
     * that Git repos can contain symlinks
     * that Git saves modes separately from the OS.
     * how the stage number works
     * that when you git add a file, Git will create an object
     * that third-party tools can create their own refs.
     * that the reflog stores the history of branches (not just HEAD), and
       what reflogs are for
    
    Also (of course) there were quite a few points of confusion! The main 4
    pieces of feedback were
    
     1. The index section doesn't explain what the word "staged" means, and
        one person says that it makes it sounds like only files that you
        "git add"ed are in the index. Rewrite the explanation to avoid using
        the word "staged" to define the index and instead define the word
        "staging".
     2. Explain the difference between "annotated tags" and "lightweight
        tags" (done)
     3. Add examples for tag objects and reflogs (done)
     4. Mention a little more about where things are stored in the .git
        directory, which I'd removed in v2. This seems most important for
        .git/refs, so I added a hopefully accurate note about how refs are
        stored by default, with a comment about one of the major
        implications. I did not discuss where objects or the index are
        stored, because I don't think the implementation details of how
        objects are stored are as important, and there are better tools for
        viewing the "raw" state of objects and the index (with git cat-file
        -p or git ls-files --staged).
    
    Here's every other change I made in response to the feedback, as well as
    a few comments that I did not address.
    
    intro:
    
     * Give a 1-sentence intro to "reflog"
    
    objects:
    
     * people really like having git ls-files --stage as a way to view the
       index, so add git cat-file -p as well in a note
    
    commits:
    
     * 2 people asked "Are commits stored as a diff?". Say that diffs are
       calculated at runtime, this is very important.
     * The order the fields are given in don't match the order in the
       example. Make them match.
     * "All the files in the commit, stored as a tree" is throwing a few
       people off. Be clearer that it's the tree ID of the base directory.
     * Several people asked "What's the difference between an author and
       committer? I added an example using git cherry-pick that I'm not 100%
       happy with (what if the reader doesn't know what cherry-pick does?).
       There might be a better example to give here.
     * In the note about commits being amended: one person suggested saying
       "creates a new commit with the same parent" to make it clearer what
       the relationship between the new and old commit are. I liked that
       idea so I did it.
    
    trees:
    
     * file modes. 2 people want to know more about "The file mode, for
       example 100644". Also 2 people are curious about what relationship
       these have to Unix permissions. Say that they're inspired by Unix
       permissions, and move the list of possible file modes up to make the
       relationship clearer
     * On "so git-gc(1) periodically compresses objects to save disk space",
       there are a few follow up comments wondering about more, which makes
       me think the comment about compression is actually a distraction. Say
       something simpler instead, ("Git only needs to store new versions of
       files which were changed in that commit"), from Junio's suggestion
     * Re "commit (a Git submodule)": 2 people say it's not clear how trees
       relate to submodules. Say that it refers to a commit in a different
       repository.
     * One person says they're not sure if the "object ID" is a hash. Link
       it to the definition of "object ID".
    
    tag objects:
    
     * Requests for an example, added one.
     * Requests to explain the difference between "lightweight" and
       "annotated" tags, added it.
    
    tags:
    
     * one person thinks "It’s expected that a tag will never change after
       you create it." is too strong (since of course you can change it with
       git tag -f). Say instead that tags are "usually" not changed.
    
    HEAD:
    
     * Several people are asking for more detail about detached HEAD state.
       There's actually quite a lot to talk about here (what it means, how
       it happens, what it implies, and how you might adjust your workflow
       to avoid it by using git switch). I don't think we can get into all
       of that here, so refer to the DETACHED HEAD section of git-checkout
       instead. I'm not totally happy with the current version of that
       section but that seems like the most practical solution right now.
    
    remote-tracking branches:
    
     * discuss refs/remotes/<remote>/HEAD.
    
    the index:
    
     * "permissions" should be "file mode" (like with trees). Changed.
     * "filename" should be "file path". Changed.
     * the stage number can only be 0, 1, 2, or 3, since it's 2 bits. Also
       maybe say that the numbers have specific meanings. Said it can only
       be 0/1/2/3 but did not give the specific meanings.
    
    reflogs
    
     * Request for an example. Added one.
     * It's not clear if there's one reflog per branch/tag/HEAD, or if
       there's one universal reflog. Make this clearer.
     * Mention the role of the reflog in retrieving "lost" commits or
       undoing bad rebases.
    
    Not fixed:
    
     * intro: A couple of people say that it's confusing that tags are both
       "an object" and "a reference". Handled this by just explaining the
       difference between an annotated and a lightweight tag further down.
       I'd like to make this clearer in the intro but not sure if there's a
       way to do it.
     * commits and tag objects: one person asks if there's a reference for
       the other "optional fields", like "encoding" and "gpgsig". I couldn't
       find one, so left this as is.
     * HEAD: A couple of people ask if there are any other symbolic
       references other than HEAD, or if they can make their own symbolic
       references. I don't know the answer to this.
     * HEAD: the HEAD: HEAD thing looks weird, it made more sense when it
       was HEAD: .git/HEAD. Will think about this.
     * reflogs: One person asks: if reflogs only store local changes, why
       does it track the user who made the change? Is that for remote
       operations like fetches and pulls? Or for cases where more than one
       user is using the same repo on a system? I don't know the answer to
       this.
     * reflogs: How can you see the full data in the reflog? git reflog show
       doesn't list the user who made the change. git reflog show <refname>
       --format="%h | %gd | %gn <%ge> | %gs" --date=iso seems to work but
       it's really a mouthful, not sure it's useful to include all that.
     * index: Is it worth mentioning that the index can be locked? I don't
       have an opinion about this.
     * other: One person asks what a "working tree" is. It made me wonder if
       "the current working directory" has a place in Git's data model. My
       feeling is "no" but I could be convinced otherwise.
     * overall: "How can Git be so fast? If I switch branches, how does it
       figure out what to add, remove or replace?". I don't think this is
       the right place for that discussion but it would
     * there are some docs CI errors I haven't figured out yet (IDREF
       attribute linkend references an unknown ID "tree")
    
    changes in v4:
    
    This is a combination of trying to make some of the intro text a little
    more "friendly" for someone new to Git's data model, avoiding implying
    things that are false, and removing information that isn't relevant to
    the data model.
    
    intro:
    
     * Add a 1-line description of what a "reflog" is (from user feedback)
    
    objects:
    
     * Start with a "friendly" description of what an object is, similar to
       what we do for references and the reflog
     * Rename "commits" to "commit" and similarly for trees etc (from
       Junio's review)
     * Remove the explanation of what git cat-file -p does, since it might
       be misleading and if people want to know they can read the man page
       (from Junio's review)
    
    commits:
    
     * Start by saying that the commit contains the full directory structure
       of all the files (from Junio's comment about how it may not be clear
       that the commit contains all the files' exact contents at the time of
       the commit)
     * Remove the comment about cherry-pick (from Junio's review)
     * Replace "ask Git for a diff" with "ask Git to show the commit with
       git show" (from Junio's review)
    
    trees:
    
     * Make the description a little more friendly
     * Reorder so that "type" is defined before we refer to the "type"
     * Say that file modes are "only spiritually related" to Unix
       permissions instead of talking about what Git "supports" (from
       Junio's review)
    
    blobs:
    
     * Try to make it clearer how "commits use relatively little disk space"
       is true while not implying that commits are diffs, by using an
       example (from Junio's review)
    
    branches:
    
     * Replace "a branch is a name for a commit ID" with "a branch refers to
       a commit ID" (except in the intro sentence for the "references"
       section). Similarly for tags etc. (from Junio's review)
     * Remove the note about how branches are stored in .git (from Junio's
       review)
    
    HEAD:
    
     * Be clearer that HEAD is not always the current branch, because there
       may not be a current branch (from Junio's review)
    
    index:
    
     * Be a little more specific about how exactly the index is converted
       into a commit. (from Junio's comment about how it's not clear what
       "every file in the repository" means)
    
    reflog:
    
     * Be clearer that there are many reflogs (one for each reference with a
       log), not just one reflog (from Junio and Patrick's reviews)
     * Omit the user and "Before" commit IDs from the list of fields,
       because you usually don't see them (from Junio's review)
     * Show the output of git reflog main in the example instead of the
       contents of the reflog file, to avoid showing the user and before
       commit ID

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1981%2Fjvns%2Fgitdatamodel-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1981/jvns/gitdatamodel-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1981

Range-diff vs v3:

 1:  39da4e04cf ! 1:  92249b5b08 doc: add a explanation of Git's data model
     @@ Metadata
      Author: Julia Evans <julia@jvns.ca>
      
       ## Commit message ##
     -    doc: add a explanation of Git's data model
     +    doc: add an explanation of Git's data model
      
          Git very often uses the terms "object", "reference", or "index" in its
          documentation.
     @@ Documentation/gitdatamodel.adoc (new)
      +OBJECTS
      +-------
      +
     -+Commits, trees, blobs, and tag objects are all stored in Git's object database.
     ++All of the commits and files in a Git repository are stored as "Git objects".
     ++Git objects never change after they're created, and every object has an ID,
     ++like `1b61de420a21a2f1aaef93e38ecd0e45e8bc9f0a`.
     ++
     ++This means that if you have an object's ID, you can always recover its
     ++exact contents as long as the object hasn't been deleted.
     ++
      +Every object has:
      +
      +[[object-id]]
     @@ Documentation/gitdatamodel.adoc (new)
      +   and <<tag-object,tag objects>>.
      +3. *contents*. The structure of the contents depends on the type.
      +
     -+Once an object is created, it can never be changed.
     -+Here are the 4 types of objects:
     ++Here's how each type of object is structured:
      +
      +[[commit]]
     -+commits::
     -+    A commit contains these required fields
     ++commit::
     ++    A commit contains the full directory structure of every file
     ++    in that version of the repository and each file's contents.
     ++    It has these these required fields
      +    (though there are other optional fields):
      ++
     -+1. All the *files* in the commit, stored as the *<<tree,tree>>* ID of
     -+   the commit's base directory.
     ++1. The *files* in the commit, stored as the *<<tree,tree>>* ID
     ++   of the commit's base directory.
      +2. Its *parent commit ID(s)*. The first commit in a repository has 0 parents,
      +  regular commits have 1 parent, merge commits have 2 or more parents
      +3. An *author* and the time the commit was authored
      +4. A *committer* and the time the commit was committed.
     -+   If you cherry-pick (linkgit:git-cherry-pick[1]) someone else's commit,
     -+   then they will be the author and you'll be the committer.
      +5. A *commit message*
      ++
      +Here's how an example commit is stored:
     @@ Documentation/gitdatamodel.adoc (new)
      +For example, "amending" a commit with `git commit --amend` creates a new
      +commit with the same parent.
      ++
     -+Git does not store the diff for a commit: when you ask Git for a
     -+diff it calculates it on the fly.
     ++Git does not store the diff for a commit: when you ask Git to show
     ++the commit with linkgit:git-show[1], it calculates the diff from its
     ++parent on the fly.
      +
      +[[tree]]
     -+trees::
     -+    A tree is how Git represents a directory. It lists, for each item in
     -+    the tree:
     ++tree::
     ++    A tree is how Git represents a directory.
     ++    It can contain files or other trees (which are subdirectories).
     ++    It lists, for each item in the tree:
      ++
     -+[[file-mode]]
     -+1. The *file mode*, for example `100644`. The format is inspired by Unix
     -+   permissions, but Git's modes are much more limited. Git only supports these file modes:
     ++1. The *filename*, for example `hello.py`
     ++2. The *type*: either <<blob,`blob`>> (a file), `tree` (a directory),
     ++  or <<commit,`commit`>> (a Git submodule, which is a
     ++  commit from a different Git repository)
     ++3. The *file mode*. Git has these file modes. which are only
     ++   spiritually related to Unix permissions:
      ++
      +  - `100644`: regular file (with type `blob`)
      +  - `100755`: executable file (with type `blob`)
     @@ Documentation/gitdatamodel.adoc (new)
      +  - `040000`: directory (with type `tree`)
      +  - `160000`: gitlink, for use with submodules (with type `commit`)
      +
     -+2. The *type*: either <<blob,`blob`>> (a file), `tree` (a directory),
     -+  or <<commit,`commit`>> (a Git submodule, which is a
     -+  commit from a different Git repository)
     -+3. The <<object-id,*object ID*>>
     -+4. The *filename*
     ++4. The <<object-id,*object ID*>> with the contents of the file or directory
      ++
      +For example, this is how a tree containing one directory (`src`) and one file
      +(`README.md`) is stored:
     @@ Documentation/gitdatamodel.adoc (new)
      +040000 tree 89b1d2e0495f66d6929f4ff76ff1bb07fc41947d src
      +----
      +
     -+
      +[[blob]]
     -+blobs::
     -+    A blob is how Git represents a file. A blob object contains the
     -+    file's contents.
     ++blob::
     ++    A blob object contains a file's contents.
      ++
     -+When you make a new commit, Git only needs to store new versions of
     -+files which were changed in that commit. This means that commits
     -+can use relatively little disk space even in a very large repository.
     ++When you make a commit, Git stores the full contents of each file that
     ++you changed as a blob.
     ++For example, if you have a commit that changes 2 files in a repository
     ++with 1000 files, that commit will create 2 new blobs, and use the
     ++previous blob ID for the other 998 files.
     ++This means that commits can use relatively little disk space even in a
     ++very large repository.
      +
      +[[tag-object]]
     -+tag objects::
     ++tag object::
      +    Tag objects contain these required fields
      +    (though there are other optional fields):
      ++
     @@ Documentation/gitdatamodel.adoc (new)
      +----
      +
      +NOTE: All of the examples in this section were generated with
     -+`git cat-file -p <object-id>`, which shows the contents of a Git object.
     ++`git cat-file -p <object-id>`.
      +
      +[[references]]
      +REFERENCES
     @@ Documentation/gitdatamodel.adoc (new)
      +branch" than "the changes are in commit bb69721404348e".
      +Git often uses "ref" as shorthand for "reference".
      +
     -+References can either be:
     ++References can either refer to:
      +
     -+1. References to an object ID, usually a <<commit,commit>> ID
     -+2. References to another reference. This is called a "symbolic reference".
     ++1. An object ID, usually a <<commit,commit>> ID
     ++2. Another reference. This is called a "symbolic reference".
      +
      +References are stored in a hierarchy, and Git handles references
      +differently based on where they are in the hierarchy.
     @@ Documentation/gitdatamodel.adoc (new)
      +
      +[[branch]]
      +branches: `refs/heads/<name>`::
     -+    A branch is a name for a commit ID.
     ++    A branch refers to a commit ID.
      +    That commit is the latest commit on the branch.
      ++
      +To get the history of commits on a branch, Git will start at the commit
     @@ Documentation/gitdatamodel.adoc (new)
      +
      +[[tag]]
      +tags: `refs/tags/<name>`::
     -+    A tag is a name for a commit ID, tag object ID, or other object ID.
     -+    Tags that reference a tag object ID are called "annotated tags",
     -+    because the tag object contains a tag message.
     -+    Tags that reference a commit, blob, or tree ID are
     -+    called "lightweight tags".
     ++    A tag refers to a commit ID, tag object ID, or other object ID.
     ++    There are two types of tags:
     ++    1. "Annotated tags", which reference a <<tag-object,tag object>> ID
     ++       which contains a tag message
     ++    2. "Lightweight tags", which reference a commit, blob, or tree ID
     ++       directly
      ++
     -+Even though branches and tags are both "a name for a commit ID", Git
     ++Even though branches and tags both refer to a commit ID, Git
      +treats them very differently.
      +Branches are expected to change over time: when you make a commit, Git
     -+will update your <<HEAD,current branch>> to reference the new changes.
     ++will update your <<HEAD,current branch>> to point to the new commit.
      +Tags are usually not changed after they're created.
      +
      +[[HEAD]]
      +HEAD: `HEAD`::
     -+    `HEAD` is where Git stores your current <<branch,branch>>.
     -+    `HEAD` can either be:
     -+    1. A symbolic reference to your current branch, for example `ref:
     -+       refs/heads/main` if your current branch is `main`.
     -+    2. A direct reference to a commit ID. This is called "detached HEAD
     -+	   state", see the DETACHED HEAD section of linkgit:git-checkout[1] for more.
     ++    `HEAD` is where Git stores your current <<branch,branch>>,
     ++    if there is a current branch. `HEAD` can either be:
     +++
     ++1. A symbolic reference to your current branch, for example `ref:
     ++   refs/heads/main` if your current branch is `main`.
     ++2. A direct reference to a commit ID. In this case there is no current branch.
     ++   This is called "detached HEAD state", see the DETACHED HEAD section
     ++   of linkgit:git-checkout[1] for more.
      +
      +[[remote-tracking-branch]]
     -+remote tracking branches: `refs/remotes/<remote>/<branch>`::
     -+    A remote-tracking branch is a name for a commit ID.
     ++remote-tracking branches: `refs/remotes/<remote>/<branch>`::
     ++    A remote-tracking branch refers to a commit ID.
      +    It's how Git stores the last-known state of a branch in a remote
      +    repository. `git fetch` updates remote-tracking branches. When
      +    `git status` says "you're up to date with origin/main", it's looking at
     @@ Documentation/gitdatamodel.adoc (new)
      ++
      +Git may also create references other than `HEAD` at the base of the
      +hierarchy, like `ORIG_HEAD`.
     -++
     -+NOTE: By default, Git references are stored as files in the `.git` directory.
     -+For example, the branch `main` is stored in `.git/refs/heads/main`.
     -+This means that you can't have branches named both `maya` and `maya/some-task`,
     -+because there can't be a file and a directory with the same name.
      +
      +[[index]]
      +THE INDEX
      +---------
     -+
     -+The index, also known as the "staging area", contains a list of every
     -+file in the repository and its contents. When you commit, the files in
     -+the index are used as the files in the next commit.
     -+
     -+You can add files to the index or update the version in the index with
     -+linkgit:git-add[1]. Adding a file to the index or updating its version
     -+is called "staging" the file for commit.
     ++The index, also known as the "staging area", is a list of files and
     ++the contents of each file, stored as a <<blob,blob>>.
     ++You can add files to the index or update the contents of a file in the
     ++index with linkgit:git-add[1]. This is called "staging" the file for commit.
      +
      +Unlike a <<tree,tree>>, the index is a flat list of files.
     ++When you commit, Git converts the list of files in the index to a
     ++directory <<tree,tree>> and uses that tree in the new <<commit,commit>>.
     ++
      +Each index entry has 4 fields:
      +
     -+1. The *<<file-mode,file mode>>*
     ++1. The *<<tree,file mode>>*
      +2. The *<<blob,blob>> ID* of the file
      +3. The *file path*, for example `src/hello.py`
      +4. The *stage number*, either 0, 1, 2, or 3. This is normally 0, but if
     @@ Documentation/gitdatamodel.adoc (new)
      +REFLOGS
      +-------
      +
     -+Git stores a history called a "reflog" for every branch, remote-tracking
     -+branch, and HEAD. This means that if you make a mistake and "lose" a
     -+commit, you can generally recover the commit ID by running
     -+`git reflog <reference>`.
     ++Every time a branch, remote-tracking branch, or HEAD is updated, Git
     ++updates a log called a "reflog" for that <<references,reference>>.
     ++This means that if you make a mistake and "lose" a commit, you can
     ++generally recover the commit ID by running `git reflog <reference>`.
      +
     -+Each reflog entry has:
     ++A reflog is a list of log entries. Each entry has:
      +
     -+1. Before/after *commit IDs*
     -+2. *User* who made the change, for example `Maya <maya@example.com>`
     -+3. *Timestamp* when the change was made
     -+4. *Log message*, for example `pull: Fast-forward`
     ++1. The *commit ID*
     ++2. *Timestamp* when the change was made
     ++3. *Log message*, for example `pull: Fast-forward`
      +
      +Reflogs only log changes made in your local repository.
      +They are not shared with remotes.
      +
     -+For example, here's how the reflog for `HEAD` in a repository with 2
     -+commits is stored:
     ++You can view a reflog with `git reflog <reference>`.
     ++For example, here's the reflog for a `main` branch which has changed twice:
      +
      +----
     -+0000000000000000000000000000000000000000 4ccb6d7b8869a86aae2e84c56523f8705b50c647 Maya <maya@example.com> 1759173408 -0400      commit (initial): Initial commit
     -+4ccb6d7b8869a86aae2e84c56523f8705b50c647 750b4ead9c87ceb3ddb7a390e6c7074521797fb3 Maya <maya@example.com> 1759173425 -0400      commit: Add README
     ++$ git reflog main --date=iso --no-decorate
     ++750b4ea main@{2025-09-29 15:17:05 -0400}: commit: Add README
     ++4ccb6d7 main@{2025-09-29 15:16:48 -0400}: commit (initial): Initial commit
      +----
      +
      +GIT


 Documentation/Makefile              |   1 +
 Documentation/gitdatamodel.adoc     | 286 ++++++++++++++++++++++++++++
 Documentation/glossary-content.adoc |   4 +-
 Documentation/meson.build           |   1 +
 4 files changed, 290 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/gitdatamodel.adoc

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 6fb83d0c6e..5f4acfacbd 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -52,6 +52,7 @@ MAN7_TXT += gitcli.adoc
 MAN7_TXT += gitcore-tutorial.adoc
 MAN7_TXT += gitcredentials.adoc
 MAN7_TXT += gitcvs-migration.adoc
+MAN7_TXT += gitdatamodel.adoc
 MAN7_TXT += gitdiffcore.adoc
 MAN7_TXT += giteveryday.adoc
 MAN7_TXT += gitfaq.adoc
diff --git a/Documentation/gitdatamodel.adoc b/Documentation/gitdatamodel.adoc
new file mode 100644
index 0000000000..e36e833f66
--- /dev/null
+++ b/Documentation/gitdatamodel.adoc
@@ -0,0 +1,286 @@
+gitdatamodel(7)
+===============
+
+NAME
+----
+gitdatamodel - Git's core data model
+
+SYNOPSIS
+--------
+gitdatamodel
+
+DESCRIPTION
+-----------
+
+It's not necessary to understand Git's data model to use Git, but it's
+very helpful when reading Git's documentation so that you know what it
+means when the documentation says "object", "reference" or "index".
+
+Git's core operations use 4 kinds of data:
+
+1. <<objects,Objects>>: commits, trees, blobs, and tag objects
+2. <<references,References>>: branches, tags,
+   remote-tracking branches, etc
+3. <<index,The index>>, also known as the staging area
+4. <<reflogs,Reflogs>>: logs of changes to references ("ref log")
+
+[[objects]]
+OBJECTS
+-------
+
+All of the commits and files in a Git repository are stored as "Git objects".
+Git objects never change after they're created, and every object has an ID,
+like `1b61de420a21a2f1aaef93e38ecd0e45e8bc9f0a`.
+
+This means that if you have an object's ID, you can always recover its
+exact contents as long as the object hasn't been deleted.
+
+Every object has:
+
+[[object-id]]
+1. an *ID* (aka "object name"), which is a cryptographic hash of its
+  type and contents.
+  It's fast to look up a Git object using its ID.
+  This is usually represented in hexadecimal, like
+  `1b61de420a21a2f1aaef93e38ecd0e45e8bc9f0a`.
+2. a *type*. There are 4 types of objects:
+   <<commit,commits>>, <<tree,trees>>, <<blob,blobs>>,
+   and <<tag-object,tag objects>>.
+3. *contents*. The structure of the contents depends on the type.
+
+Here's how each type of object is structured:
+
+[[commit]]
+commit::
+    A commit contains the full directory structure of every file
+    in that version of the repository and each file's contents.
+    It has these these required fields
+    (though there are other optional fields):
++
+1. The *files* in the commit, stored as the *<<tree,tree>>* ID
+   of the commit's base directory.
+2. Its *parent commit ID(s)*. The first commit in a repository has 0 parents,
+  regular commits have 1 parent, merge commits have 2 or more parents
+3. An *author* and the time the commit was authored
+4. A *committer* and the time the commit was committed.
+5. A *commit message*
++
+Here's how an example commit is stored:
++
+----
+tree 1b61de420a21a2f1aaef93e38ecd0e45e8bc9f0a
+parent 4ccb6d7b8869a86aae2e84c56523f8705b50c647
+author Maya <maya@example.com> 1759173425 -0400
+committer Maya <maya@example.com> 1759173425 -0400
+
+Add README
+----
++
+Like all other objects, commits can never be changed after they're created.
+For example, "amending" a commit with `git commit --amend` creates a new
+commit with the same parent.
++
+Git does not store the diff for a commit: when you ask Git to show
+the commit with linkgit:git-show[1], it calculates the diff from its
+parent on the fly.
+
+[[tree]]
+tree::
+    A tree is how Git represents a directory.
+    It can contain files or other trees (which are subdirectories).
+    It lists, for each item in the tree:
++
+1. The *filename*, for example `hello.py`
+2. The *type*: either <<blob,`blob`>> (a file), `tree` (a directory),
+  or <<commit,`commit`>> (a Git submodule, which is a
+  commit from a different Git repository)
+3. The *file mode*. Git has these file modes. which are only
+   spiritually related to Unix permissions:
++
+  - `100644`: regular file (with type `blob`)
+  - `100755`: executable file (with type `blob`)
+  - `120000`: symbolic link (with type `blob`)
+  - `040000`: directory (with type `tree`)
+  - `160000`: gitlink, for use with submodules (with type `commit`)
+
+4. The <<object-id,*object ID*>> with the contents of the file or directory
++
+For example, this is how a tree containing one directory (`src`) and one file
+(`README.md`) is stored:
++
+----
+100644 blob 8728a858d9d21a8c78488c8b4e70e531b659141f README.md
+040000 tree 89b1d2e0495f66d6929f4ff76ff1bb07fc41947d src
+----
+
+[[blob]]
+blob::
+    A blob object contains a file's contents.
++
+When you make a commit, Git stores the full contents of each file that
+you changed as a blob.
+For example, if you have a commit that changes 2 files in a repository
+with 1000 files, that commit will create 2 new blobs, and use the
+previous blob ID for the other 998 files.
+This means that commits can use relatively little disk space even in a
+very large repository.
+
+[[tag-object]]
+tag object::
+    Tag objects contain these required fields
+    (though there are other optional fields):
++
+1. The *ID* and *type* of the object (often a commit) that they reference
+2. The *tagger* and tag date
+3. A *tag message*, similar to a commit message
+
+Here's how an example tag object is stored:
+
+----
+object 750b4ead9c87ceb3ddb7a390e6c7074521797fb3
+type commit
+tag v1.0.0
+tagger Maya <maya@example.com> 1759927359 -0400
+
+Release version 1.0.0
+----
+
+NOTE: All of the examples in this section were generated with
+`git cat-file -p <object-id>`.
+
+[[references]]
+REFERENCES
+----------
+
+References are a way to give a name to a commit.
+It's easier to remember "the changes I'm working on are on the `turtle`
+branch" than "the changes are in commit bb69721404348e".
+Git often uses "ref" as shorthand for "reference".
+
+References can either refer to:
+
+1. An object ID, usually a <<commit,commit>> ID
+2. Another reference. This is called a "symbolic reference".
+
+References are stored in a hierarchy, and Git handles references
+differently based on where they are in the hierarchy.
+Most references are under `refs/`. Here are the main types:
+
+[[branch]]
+branches: `refs/heads/<name>`::
+    A branch refers to a commit ID.
+    That commit is the latest commit on the branch.
++
+To get the history of commits on a branch, Git will start at the commit
+ID the branch references, and then look at the commit's parent(s),
+the parent's parent, etc.
+
+[[tag]]
+tags: `refs/tags/<name>`::
+    A tag refers to a commit ID, tag object ID, or other object ID.
+    There are two types of tags:
+    1. "Annotated tags", which reference a <<tag-object,tag object>> ID
+       which contains a tag message
+    2. "Lightweight tags", which reference a commit, blob, or tree ID
+       directly
++
+Even though branches and tags both refer to a commit ID, Git
+treats them very differently.
+Branches are expected to change over time: when you make a commit, Git
+will update your <<HEAD,current branch>> to point to the new commit.
+Tags are usually not changed after they're created.
+
+[[HEAD]]
+HEAD: `HEAD`::
+    `HEAD` is where Git stores your current <<branch,branch>>,
+    if there is a current branch. `HEAD` can either be:
++
+1. A symbolic reference to your current branch, for example `ref:
+   refs/heads/main` if your current branch is `main`.
+2. A direct reference to a commit ID. In this case there is no current branch.
+   This is called "detached HEAD state", see the DETACHED HEAD section
+   of linkgit:git-checkout[1] for more.
+
+[[remote-tracking-branch]]
+remote-tracking branches: `refs/remotes/<remote>/<branch>`::
+    A remote-tracking branch refers to a commit ID.
+    It's how Git stores the last-known state of a branch in a remote
+    repository. `git fetch` updates remote-tracking branches. When
+    `git status` says "you're up to date with origin/main", it's looking at
+    this.
++
+`refs/remotes/<remote>/HEAD` is a symbolic reference to the remote's
+default branch. This is the branch that `git clone` checks out by default.
+
+[[other-refs]]
+Other references::
+    Git tools may create references anywhere under `refs/`.
+    For example, linkgit:git-stash[1], linkgit:git-bisect[1],
+    and linkgit:git-notes[1] all create their own references
+    in `refs/stash`, `refs/bisect`, etc.
+    Third-party Git tools may also create their own references.
++
+Git may also create references other than `HEAD` at the base of the
+hierarchy, like `ORIG_HEAD`.
+
+[[index]]
+THE INDEX
+---------
+The index, also known as the "staging area", is a list of files and
+the contents of each file, stored as a <<blob,blob>>.
+You can add files to the index or update the contents of a file in the
+index with linkgit:git-add[1]. This is called "staging" the file for commit.
+
+Unlike a <<tree,tree>>, the index is a flat list of files.
+When you commit, Git converts the list of files in the index to a
+directory <<tree,tree>> and uses that tree in the new <<commit,commit>>.
+
+Each index entry has 4 fields:
+
+1. The *<<tree,file mode>>*
+2. The *<<blob,blob>> ID* of the file
+3. The *file path*, for example `src/hello.py`
+4. The *stage number*, either 0, 1, 2, or 3. This is normally 0, but if
+   there's a merge conflict there can be multiple versions of the same
+   filename in the index.
+
+It's extremely uncommon to look at the index directly: normally you'd
+run `git status` to see a list of changes between the index and <<HEAD,HEAD>>.
+But you can use `git ls-files --stage` to see the index.
+Here's the output of `git ls-files --stage` in a repository with 2 files:
+
+----
+100644 8728a858d9d21a8c78488c8b4e70e531b659141f 0 README.md
+100644 665c637a360874ce43bf74018768a96d2d4d219a 0 src/hello.py
+----
+
+[[reflogs]]
+REFLOGS
+-------
+
+Every time a branch, remote-tracking branch, or HEAD is updated, Git
+updates a log called a "reflog" for that <<references,reference>>.
+This means that if you make a mistake and "lose" a commit, you can
+generally recover the commit ID by running `git reflog <reference>`.
+
+A reflog is a list of log entries. Each entry has:
+
+1. The *commit ID*
+2. *Timestamp* when the change was made
+3. *Log message*, for example `pull: Fast-forward`
+
+Reflogs only log changes made in your local repository.
+They are not shared with remotes.
+
+You can view a reflog with `git reflog <reference>`.
+For example, here's the reflog for a `main` branch which has changed twice:
+
+----
+$ git reflog main --date=iso --no-decorate
+750b4ea main@{2025-09-29 15:17:05 -0400}: commit: Add README
+4ccb6d7 main@{2025-09-29 15:16:48 -0400}: commit (initial): Initial commit
+----
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Documentation/glossary-content.adoc b/Documentation/glossary-content.adoc
index e423e4765b..20ba121314 100644
--- a/Documentation/glossary-content.adoc
+++ b/Documentation/glossary-content.adoc
@@ -297,8 +297,8 @@ This commit is referred to as a "merge commit", or sometimes just a
 	identified by its <<def_object_name,object name>>. The objects usually
 	live in `$GIT_DIR/objects/`.
 
-[[def_object_identifier]]object identifier (oid)::
-	Synonym for <<def_object_name,object name>>.
+[[def_object_identifier]]object identifier, object ID, oid::
+	Synonyms for <<def_object_name,object name>>.
 
 [[def_object_name]]object name::
 	The unique identifier of an <<def_object,object>>.  The
diff --git a/Documentation/meson.build b/Documentation/meson.build
index e34965c5b0..ace0573e82 100644
--- a/Documentation/meson.build
+++ b/Documentation/meson.build
@@ -192,6 +192,7 @@ manpages = {
   'gitcore-tutorial.adoc' : 7,
   'gitcredentials.adoc' : 7,
   'gitcvs-migration.adoc' : 7,
+  'gitdatamodel.adoc' : 7,
   'gitdiffcore.adoc' : 7,
   'giteveryday.adoc' : 7,
   'gitfaq.adoc' : 7,

base-commit: bb69721404348ea2db0a081c41ab6ebfe75bdec8
-- 
gitgitgadget
