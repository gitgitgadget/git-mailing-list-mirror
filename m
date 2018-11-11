Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE9BD1F87F
	for <e@80x24.org>; Sun, 11 Nov 2018 13:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbeKKWzB (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Nov 2018 17:55:01 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45992 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727510AbeKKWzB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Nov 2018 17:55:01 -0500
Received: by mail-ed1-f68.google.com with SMTP id d39so1932428edb.12
        for <git@vger.kernel.org>; Sun, 11 Nov 2018 05:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=lk0dYNeFsCj4nTHYQTFCyhAdGFtevx6eYh3dnGyUuhk=;
        b=PApDyHEKagsc2RYvXB7lYZRA+TiGmEC0QJ1YsaCs57Jsfz/xvXW6o8bssxIsMZSP0u
         SZlTpG7mVDvsaLhMlDxCWZvPXZKKIpbG1ABkzR2gv3UN0HjURKyStYmEJIvJw4L6BAUT
         V4QwXTO5Ls8Ns/z/36wMnzk5GPCNA6S5eKtBs5tzYpaeyXXpYvneHfdEouqIevv7IafE
         jmFsNGUY0XuNnGGLDMOp5eBmOO+r0gZyMGuE9saqbElEPIAjWpj8qlEJ80nsGXfTTYjk
         Zardks2RgFRnZ8RmXtNLNiOYUvr6T2584OZY+JgA8SxHn3FCtb4sVTDRs2KlCZsVIzh6
         4jXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=lk0dYNeFsCj4nTHYQTFCyhAdGFtevx6eYh3dnGyUuhk=;
        b=MBk7HnkggnMg/QyqWtsJZtu5EARTzlX6A2J2MlGnD6amLC1CIdsJnHLxETc/OKSOes
         bdZsHep6QBn4qH1B+7+J0pZrXGO6cW5oNHWXa+mewOQbU53wWDSEb1S+FU4kRiUjZamH
         jfTJTXkgP8RtcQr4XWnVD0ZerPbAJ5QCkdbz/RFvOyt7/0LjRHVGXgOZrm0E9j5AN5yU
         ZWQ9UPu30sbMZ6DuAUMXrismyXmXtjkrFzdjItyMs9oAek786r/vMgSnWHY7pyYh7asX
         cZ54lSuDZIRXLYJqAzynyrRjlFpNHXy+SJ+Pz1mk7KgVVpi+EAbgKy/K1sa1dl4yVheJ
         /dtQ==
X-Gm-Message-State: AGRZ1gLC6ELdaVZtpBfjXQZfk7QScSk59NhL8a2yoL8e9ihRqLeUtNcr
        621jKOWO10Tgvk5DXwfDrTM=
X-Google-Smtp-Source: AJdET5evY/iJr1tGDiYG3dbhQvjeEQiRxbCnS1g2noVF7AxBIU+3bwvz+KcG2lNc9GkpS33GxKLhsQ==
X-Received: by 2002:a17:906:138d:: with SMTP id f13-v6mr6892042ejc.176.1541941585976;
        Sun, 11 Nov 2018 05:06:25 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id m13sm295628edd.2.2018.11.11.05.06.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 11 Nov 2018 05:06:24 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Steffen Jost <jost@tcs.ifi.lmu.de>,
        Joshua Jensen <jjensen@workspacewhiz.com>,
        Per Lundberg <per.lundberg@hibox.tv>,
        Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Clemens Buchacher <drizzd@gmx.net>,
        Holger Hellmuth <hellmuth@ira.uka.de>,
        Kevin Ballard <kevin@sb.org>
Subject: Re: [RFC PATCH] Introduce "precious" file concept
References: <20181111095254.30473-1-pclouds@gmail.com> <875zxa6xzp.fsf@evledraar.gmail.com> <871s7r4wuv.fsf@evledraar.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <871s7r4wuv.fsf@evledraar.gmail.com>
Date:   Sun, 11 Nov 2018 14:06:23 +0100
Message-ID: <87zhuf3gs0.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Nov 11 2018, Ævar Arnfjörð Bjarmason wrote:

> [CC-ing some of the people involved in recent threads about this]
>
> On Sun, Nov 11 2018, Nguyễn Thái Ngọc Duy wrote:
>
>> Since this topic has come up twice recently, I revisited this
>> "precious" thingy that I started four years ago and tried to see if I
>> could finally finish it. There are a couple things to be sorted out...
>>
>> A new attribute "precious" is added to indicate that certain files
>> have valuable content and should not be easily discarded even if they
>> are ignored or untracked (*).
>>
>> So far there are two parts of Git that are made aware of precious
>> files: "git clean" will leave precious files alone and unpack-trees.c
>> (i.e. merges and branch switches) will not overwrite
>> ignored-but-precious files.
>>
>> Is there any other parts of Git that should be made aware of this
>> "precious" attribute?
>>
>> Also while "precious" is a fun name, but it does not sound serious.
>> Any suggestions? Perhaps "valuable"?
>>
>> Very lightly tested. The patch is more to have something to discuss
>> than is bug free and ready to use.
>>
>> (*) Note that tracked files could be marked "precious" in the future
>>     too although the exact semantics is not very clear since tracked
>>     files are by default precious.
>>
>>     But something like "index log" could use this to record all
>>     changes to precious files instead of just "git add -p" changes,
>>     for example. So these files are in a sense more precious than
>>     other tracked files.
>>
>> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
>> ---
>>  Documentation/git-clean.txt     |  3 ++-
>>  Documentation/gitattributes.txt | 13 +++++++++++++
>>  attr.c                          |  9 +++++++++
>>  attr.h                          |  2 ++
>>  builtin/clean.c                 | 19 ++++++++++++++++---
>>  unpack-trees.c                  |  3 ++-
>>  6 files changed, 44 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
>> index 03056dad0d..a9beadfb12 100644
>> --- a/Documentation/git-clean.txt
>> +++ b/Documentation/git-clean.txt
>> @@ -21,7 +21,8 @@ option is specified, ignored files are also removed. This can, for
>>  example, be useful to remove all build products.
>>
>>  If any optional `<path>...` arguments are given, only those paths
>> -are affected.
>> +are affected. Ignored or untracked files with `precious` attributes
>> +are not removed.
>>
>>  OPTIONS
>>  -------
>> diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
>> index b8392fc330..c722479bdc 100644
>> --- a/Documentation/gitattributes.txt
>> +++ b/Documentation/gitattributes.txt
>> @@ -1188,6 +1188,19 @@ If this attribute is not set or has an invalid value, the value of the
>>  (See linkgit:git-config[1]).
>>
>>
>> +Precious files
>> +~~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +`precious`
>> +^^^^^^^^^^
>> +
>> +This attribute is set on files to indicate that their content is
>> +valuable. Many commands will behave slightly different on precious
>> +files. linkgit:git-clean[1] will leave precious files alone. Merging
>> +and branch switching will not silently overwrite ignored files that
>> +are marked "precious".
>> +
>> +
>>  USING MACRO ATTRIBUTES
>>  ----------------------
>>
>> diff --git a/attr.c b/attr.c
>> index 60d284796d..d06ca0ae4b 100644
>> --- a/attr.c
>> +++ b/attr.c
>> @@ -1186,3 +1186,12 @@ void attr_start(void)
>>  	pthread_mutex_init(&check_vector.mutex, NULL);
>>  #endif
>>  }
>> +
>> +int is_precious_file(struct index_state *istate, const char *path)
>> +{
>> +	static struct attr_check *check;
>> +	if (!check)
>> +		check = attr_check_initl("precious", NULL);
>> +	git_check_attr(istate, path, check);
>> +	return check && ATTR_TRUE(check->items[0].value);
>> +}
>
> If we merge two branches is this using the merged post-image of
> .gitattributes as a source?
>
>>  	if (o->dir &&
>> -	    is_excluded(o->dir, o->src_index, name, &dtype))
>> +	    is_excluded(o->dir, o->src_index, name, &dtype) &&
>> +	    !is_precious_file(o->src_index, name))
>>  		/*
>>  		 * ce->name is explicitly excluded, so it is Ok to
>>  		 * overwrite it.
>
> I wonder if instead we should just be reverting c81935348b ("Fix
> switching to a branch with D/F when current branch has file D.",
> 2007-03-15), which these days (haven't dug deeply) would just be this,
> right?:
>
>>    diff --git a/unpack-trees.c b/unpack-trees.c
>     index 7570df481b..b3efaddd4f 100644
>     --- a/unpack-trees.c
>     +++ b/unpack-trees.c
>     @@ -1894,13 +1894,6 @@ static int check_ok_to_remove(const char *name, int len, int dtype,
>      	if (ignore_case && icase_exists(o, name, len, st))
>      		return 0;
>
>     -	if (o->dir &&
>     -	    is_excluded(o->dir, o->src_index, name, &dtype))
>     -		/*
>     -		 * ce->name is explicitly excluded, so it is Ok to
>     -		 * overwrite it.
>     -		 */
>     -		return 0;
>      	if (S_ISDIR(st->st_mode)) {
>      		/*
>      		 * We are checking out path "foo" and
>
> Something like the approach you're taking will absolutely work from a
> technical standpoint, but I fear that it's going to be useless in
> practice.
>
> The users who need protection against git deleting their files the most
> are exactly the sort of users who aren't expert-level enough to
> understand the nuances of how the semantics of .gitignore and "precious"
> are going to interact before git eats their data.
>
> This is pretty apparent from the bug reports we're getting about
> this. None of them are:
>
>     "Hey, I 100% understood .gitignore semantics including this one part
>     of the docs where you say you'll do this, but just forgot one day
>     and deleted my work. Can we get some more safety?"
>
> But rather (with some hyperbole for effect):
>
>     "ZOMG git deleted my file! Is this a bug??"
>
> So I think we should have the inverse of this "precious"
> attribute". Just a change to the docs to say that .gitignore doesn't
> imply these eager deletion semantics on tree unpacking anymore, and if
> users want it back they can define a "garbage" attribute
> (s/precious/garbage/).
>
> That will lose no data, and in the very rare cases where a checkout of
> tracked files would overwrite an ignored pattern, we can just error out
> (as we do with the "Ok to overwrite" branch removed) and tell the user
> to delete the files to proceed.
>
> Three tests in our test suite fail with that patch applied, and they're
> explicitly testing for exactly the sort of scenario where users are likely to lose data. I.e.:
>
>  1. Open a tracked file in an editor
>  2. Save it
>  3. Switch to a topic branch, that has different .gitignore semantics
>     (e.g. let's say a build/ dir exists there)
>  4. Have their work deleted
>
> So actually in writing this out I've become convinced that this
> "precious" approach can't work either, because *even if* you're an
> expert who manages to perfectly define their .gitignore and "precious"
> rules in advance to avoid data deletion, those rules will *also* need to
> take into account switching between branches (or even different
> histories) where you have other sorts of rules.
>
> So really, if there's ambiguity let's just not delete stuff by default
> and ask the user to resolve it.

Here's a patch to implement that (which borrows from some of yours). It
passes all of our tests:

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index b8392fc330..a6cad17899 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -1188,6 +1188,17 @@ If this attribute is not set or has an invalid value, the value of the
 (See linkgit:git-config[1]).


+Trashable files
+~~~~~~~~~~~~~~~
+
+`trashable`
+^^^^^^^^^^
+
+Provides an escape hatch for re-enabling a potentially data destroying
+feature which was enabled by default between Git versions 1.5.2 and
+2.20. See the `NOTES` section of linkgit:gitignore[5] for details.
+
+
 USING MACRO ATTRIBUTES
 ----------------------

diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index d107daaffd..39c6d5955a 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -140,6 +140,13 @@ not tracked by Git remain untracked.
 To stop tracking a file that is currently tracked, use
 'git rm --cached'.

+Between Git versions 1.5.2 and 2.20 untracked files or directories
+which were ignored and conflicted with a file about to be checked out
+(e.g. during linkgit:git-checkout[1] or linkgit:git-merge[1]) would be
+deleted. This could lead to loss of user data and is no longer the
+default, See `trashable` in linkgit:gitattributes[5]. for how to
+selectively enable this behavior.
+
 EXAMPLES
 --------

diff --git a/attr.c b/attr.c
index 60d284796d..930af78650 100644
--- a/attr.c
+++ b/attr.c
@@ -1186,3 +1186,12 @@ void attr_start(void)
 	pthread_mutex_init(&check_vector.mutex, NULL);
 #endif
 }
+
+int is_trashable_file(struct index_state *istate, const char *path)
+{
+	static struct attr_check *check;
+	if (!check)
+		check = attr_check_initl("trashable", NULL);
+	git_check_attr(istate, path, check);
+	return check && ATTR_TRUE(check->items[0].value);
+}
diff --git a/attr.h b/attr.h
index b0378bfe5f..ccf4d4e6b5 100644
--- a/attr.h
+++ b/attr.h
@@ -82,4 +82,6 @@ void git_attr_set_direction(enum git_attr_direction new_direction);

 void attr_start(void);

+int is_trashable_file(struct index_state *istate, const char *path);
+
 #endif /* ATTR_H */
diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index 016391723c..d2ceee33d2 100755
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -844,6 +844,8 @@ test_submodule_switch_recursing_with_args () {
 			git branch -t add_sub1 origin/add_sub1 &&
 			: >sub1 &&
 			echo sub1 >.git/info/exclude &&
+			test_must_fail $command add_sub1 &&
+			echo sub1 trashable >.gitattributes &&
 			$command add_sub1 &&
 			test_superproject_content origin/add_sub1 &&
 			test_submodule_content sub1 origin/add_sub1
diff --git a/t/t1004-read-tree-m-u-wf.sh b/t/t1004-read-tree-m-u-wf.sh
index c13578a635..2243cd955e 100755
--- a/t/t1004-read-tree-m-u-wf.sh
+++ b/t/t1004-read-tree-m-u-wf.sh
@@ -63,8 +63,10 @@ test_expect_success 'two-way with incorrect --exclude-per-directory (2)' '
 	fi
 '

-test_expect_success 'two-way clobbering a ignored file' '
+test_expect_success 'two-way keeping a ignored file, trashing a trashable file' '

+	read_tree_u_must_fail -m -u --exclude-per-directory=.gitignore master side &&
+	echo file2 trashable >.gitattributes &&
 	read_tree_u_must_succeed -m -u --exclude-per-directory=.gitignore master side
 '

@@ -106,7 +108,7 @@ test_expect_success 'three-way not clobbering a working tree file' '

 echo >.gitignore file3

-test_expect_success 'three-way not complaining on an untracked file' '
+test_expect_success 'three-way complaining on an untracked file, trashing a trashable file' '

 	git reset --hard &&
 	rm -f file2 subdir/file2 file3 subdir/file3 &&
@@ -114,6 +116,8 @@ test_expect_success 'three-way not complaining on an untracked file' '
 	echo >file3 file three created in master, untracked &&
 	echo >subdir/file3 file three created in master, untracked &&

+	read_tree_u_must_fail -m -u --exclude-per-directory=.gitignore branch-point master side &&
+	echo file3 trashable >.gitattributes &&
 	read_tree_u_must_succeed -m -u --exclude-per-directory=.gitignore branch-point master side
 '

diff --git a/unpack-trees.c b/unpack-trees.c
index 7570df481b..e9a7fb6583 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1895,9 +1895,10 @@ static int check_ok_to_remove(const char *name, int len, int dtype,
 		return 0;

 	if (o->dir &&
-	    is_excluded(o->dir, o->src_index, name, &dtype))
+	    is_excluded(o->dir, o->src_index, name, &dtype) &&
+	    is_trashable_file(o->src_index, name))
 		/*
-		 * ce->name is explicitly excluded, so it is Ok to
+		 * ce->name is explicitly trashable, so it is Ok to
 		 * overwrite it.
 		 */
 		return 0;
