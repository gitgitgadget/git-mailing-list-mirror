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
	by dcvr.yhbt.net (Postfix) with ESMTP id 89F991F609
	for <e@80x24.org>; Wed, 28 Nov 2018 12:54:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbeK1X4V (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Nov 2018 18:56:21 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37545 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727811AbeK1X4V (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Nov 2018 18:56:21 -0500
Received: by mail-wm1-f65.google.com with SMTP id g67so2470495wmd.2
        for <git@vger.kernel.org>; Wed, 28 Nov 2018 04:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=5N+Bnr7+fK+ewzZx/F3IjLuMzCYCMucVZokMYg0hZV4=;
        b=cM94Z6aF78DB9/YOCkPsQCwBshm9lS+P0uGXKEdtTd7iuGWu/pi1XPmYOxY/ev0yiq
         plp1tm15/55CuED+ciUGlR+CtPYlMhst4/txIaNCb5GA16g5HviU7/HQqYQxizviWUy/
         KiKGDm1s2xxZdJv4d3FAv2fUXCvbo9NbiEuBSPjE92JpvIySHOuZfiq/HfvccuGwX5ot
         k2cc2pJopTM0mGukHBhHKPZvY9pJNS2LFLQeaWek9u0qLfvwRe59jZxVizjxASmCjdBB
         8taU9Mt4wsGBaurPRgQ4UPFog4mHzeFPlQ3M2iP5pJtVUfuolE1wb+T9EacT4f415+Bv
         vVaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=5N+Bnr7+fK+ewzZx/F3IjLuMzCYCMucVZokMYg0hZV4=;
        b=XnIfCVL/ONaEvK7cr7GGSWAFNqoIb4Hp6d9xfjsJ0K8ga7oR9mt7BqpuDFFpaZbQnj
         K+4p95WpP0+QcpAALlhIBB3NrbVgnGg5OrrXzP+3GOql2uxOeYOOEmMQkirG4OIp1NE0
         UtoE+VkjQKhqMQPm17aGfHBslZAPDK8U595fB/WNXbsFyvSFr4PU6BSJf1axoEUIcvLJ
         Eu5WG9Dw0HgEcVhYNgxAP6q66n8hQsjjxYKIDoXE8bAk8T2BPENTZ9qBqnemOg91xlRn
         gTkNe+BPxWdykG8KcrXPTplMqHnGG+XoEQv/aFLagtWJJMkY/GOI2CZ9UbCsCU2XXiPk
         nvQg==
X-Gm-Message-State: AA+aEWaJP2Tq6cvwA/1wshdSprpemKZJUCp7xeT+IzskZ687lHLcGhrO
        TKkjkBM4yq9sF33vKniQhzA=
X-Google-Smtp-Source: AFSGD/X5+wx9ZxXp4Ap2XC18GZjBMYOI8x6V0ufDRL0cbNQbBX4RJdq4BmW0mesKb/5YH2aSpXA75w==
X-Received: by 2002:a1c:9f0e:: with SMTP id i14mr2846862wme.10.1543409684502;
        Wed, 28 Nov 2018 04:54:44 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id c12sm4938021wrs.82.2018.11.28.04.54.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 04:54:43 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Thomas Braun <thomas.braun@virtuell-zuhause.de>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        sbeller@google.com
Subject: Re: [PATCH v2] log -G: Ignore binary files
References: <1535679074.141165.1542834055343@ox.hosteurope.de> <c4eac0b0ff0812e5aa8b081e603fc8bdd042ddeb.1543403143.git.thomas.braun@virtuell-zuhause.de>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <c4eac0b0ff0812e5aa8b081e603fc8bdd042ddeb.1543403143.git.thomas.braun@virtuell-zuhause.de>
Date:   Wed, 28 Nov 2018 13:54:42 +0100
Message-ID: <87a7ltz7jh.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 28 2018, Thomas Braun wrote:

Looks much better this time around.

> The -G<regex> option of log looks for the differences whose patch text
> contains added/removed lines that match regex.
>
> As the concept of patch text only makes sense for text files, we need to
> ignore binary files when searching with -G <regex> as well.
>
> The -S<block of text> option of log looks for differences that changes
> the number of occurrences of the specified block of text (i.e.
> addition/deletion) in a file. As we want to keep the current behaviour,
> add a test to ensure it.
> [...]
> diff --git a/Documentation/gitdiffcore.txt b/Documentation/gitdiffcore.txt
> index c0a60f3158..059ddd3431 100644
> --- a/Documentation/gitdiffcore.txt
> +++ b/Documentation/gitdiffcore.txt
> @@ -242,7 +242,7 @@ textual diff has an added or a deleted line that matches the given
>  regular expression.  This means that it will detect in-file (or what
>  rename-detection considers the same file) moves, which is noise.  The
>  implementation runs diff twice and greps, and this can be quite
> -expensive.
> +expensive.  Binary files without textconv filter are ignored.

Now that we support --text that should be documented. I tried to come up
with something on top:

    diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
    index 0378cd574e..42ae65fb57 100644
    --- a/Documentation/diff-options.txt
    +++ b/Documentation/diff-options.txt
    @@ -524,6 +524,10 @@ struct), and want to know the history of that block since it first
     came into being: use the feature iteratively to feed the interesting
     block in the preimage back into `-S`, and keep going until you get the
     very first version of the block.
    ++
    +Unlike `-G` the `-S` option will always search through binary files
    +without a textconv filter. [[TODO: Don't we want to support --no-text
    +then as an optimization?]].

     -G<regex>::
     	Look for differences whose patch text contains added/removed
    @@ -545,6 +549,15 @@ occurrences of that string did not change).
     +
     See the 'pickaxe' entry in linkgit:gitdiffcore[7] for more
     information.
    ++
    +Unless `--text` is supplied binary files without a textconv filter
    +will be ignored.  This was not the case before Git version 2.21..
    ++
    +With `--text`, instead of patch lines we <some example similar to the
    +above diff showing what we actually do for binary files. [[TODO: How
    +does that work?. Could just link to the "diffcore-pickaxe: For
    +Detecting Addition/Deletion of Specified String" section in
    +gitdiffcore(7) which could explain it]]

     --find-object=<object-id>::
     	Look for differences that change the number of occurrences of
    diff --git a/Documentation/gitdiffcore.txt b/Documentation/gitdiffcore.txt
    index c0a60f3158..26880b4149 100644
    --- a/Documentation/gitdiffcore.txt
    +++ b/Documentation/gitdiffcore.txt
    @@ -251,6 +251,10 @@ criterion in a changeset, the entire changeset is kept.  This behavior
     is designed to make reviewing changes in the context of the whole
     changeset easier.

    +Both `-S' and `-G' will ignore binary files without a textconv filter
    +by default, this can be overriden with `--text`. With `--text` the
    +binary patch we look through is generated as [[TODO: ???]].
    +
     diffcore-order: For Sorting the Output Based on Filenames
     ---------------------------------------------------------

But as you can see given the TODO comments I don't know how this works
exactly. I *could* dig, but that's my main outstanding problem with this
patch, the commit message / docs aren't being updated to reflect the new
behavior.

I.e. let's leave the docs in some state where the reader can as
unambiguously know what to expect with -G and these binary diffs we've
been implicitly supporting as with the textual diffs. Ideally with some
examples of how to generate them (re my question about the base85 output
in v1).

Part of that's obviously behavior we've had all along, but it's much
more convincing to say:

    We are changing X which we've done for ages, it works exactly like
    this, and here's a switch to get it back.

Instead of:

    X doesn't make sense, let's turn it off.

Also the diffcore docs already say stuff about how slow/fast things are,
and in a side-thread you said:

    My main motiviation is to speed up "log -G" as that takes a
    considerable amount of time when it wades through MBs of binary
    files which change often.

Makes sense, but then let's say something about that in that section of
the docs.

>  When `-S` or `-G` are used without `--pickaxe-all`, only filepairs
>  that match their respective criterion are kept in the output.  When
> diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
> index 69fc55ea1e..4cea086f80 100644
> --- a/diffcore-pickaxe.c
> +++ b/diffcore-pickaxe.c
> @@ -154,6 +154,12 @@ static int pickaxe_match(struct diff_filepair *p, struct diff_options *o,
>  	if (textconv_one == textconv_two && diff_unmodified_pair(p))
>  		return 0;
>
> +	if ((o->pickaxe_opts & DIFF_PICKAXE_KIND_G) &&
> +	    !o->flags.text &&
> +	    ((!textconv_one && diff_filespec_is_binary(o->repo, p->one)) ||
> +	     (!textconv_two && diff_filespec_is_binary(o->repo, p->two))))
> +		return 0;
> +
>  	mf1.size = fill_textconv(o->repo, textconv_one, p->one, &mf1.ptr);
>  	mf2.size = fill_textconv(o->repo, textconv_two, p->two, &mf2.ptr);
>
> diff --git a/t/t4209-log-pickaxe.sh b/t/t4209-log-pickaxe.sh
> index 844df760f7..5c3e2a16b2 100755
> --- a/t/t4209-log-pickaxe.sh
> +++ b/t/t4209-log-pickaxe.sh
> @@ -106,4 +106,44 @@ test_expect_success 'log -S --no-textconv (missing textconv tool)' '
>  	rm .gitattributes
>  '
>
> +test_expect_success 'log -G ignores binary files' '
> +	git checkout --orphan orphan1 &&
> +	printf "a\0a" >data.bin &&
> +	git add data.bin &&
> +	git commit -m "message" &&
> +	git log -Ga >result &&
> +	test_must_be_empty result
> +'
> +
> +test_expect_success 'log -G looks into binary files with -a' '
> +	git checkout --orphan orphan2 &&
> +	printf "a\0a" >data.bin &&
> +	git add data.bin &&
> +	git commit -m "message" &&
> +	git log -a -Ga >actual &&
> +	git log >expected &&
> +	test_cmp actual expected
> +'

A large part of the question(s) I have above & future readers would
presumably have would be answered by these tests using more realistic
test data. I.e. also with \n in there to see whether -G is also
line-based in this binary case.

> +test_expect_success 'log -G looks into binary files with textconv filter' '
> +	git checkout --orphan orphan3 &&
> +	echo "* diff=bin" > .gitattributes &&
> +	printf "a\0a" >data.bin &&
> +	git add data.bin &&
> +	git commit -m "message" &&
> +	git -c diff.bin.textconv=cat log -Ga >actual &&
> +	git log >expected &&
> +	test_cmp actual expected
> +'
> +
> +test_expect_success 'log -S looks into binary files' '
> +	git checkout --orphan orphan4 &&
> +	printf "a\0a" >data.bin &&
> +	git add data.bin &&
> +	git commit -m "message" &&
> +	git log -Sa >actual &&
> +	git log >expected &&
> +	test_cmp actual expected
> +'
> +
>  test_done

These tests have way to much repeated boilerplate for no reason. This
could just be (as-is, without the better test data suggested above):

diff --git a/t/t4209-log-pickaxe.sh b/t/t4209-log-pickaxe.sh
index 844df760f7..23ed6cc4b1 100755
--- a/t/t4209-log-pickaxe.sh
+++ b/t/t4209-log-pickaxe.sh
@@ -106,4 +106,34 @@ test_expect_success 'log -S --no-textconv (missing textconv tool)' '
 	rm .gitattributes
 '

+test_expect_success 'setup log -[GS] binary & --text' '
+	git checkout --orphan GS-binary-and-text &&
+	printf "a\0a" >data.bin &&
+	git add data.bin &&
+	git commit -m "message" &&
+	git log >full-log
+'
+
+test_expect_success 'log -G ignores binary files' '
+	git log -Ga >result &&
+	test_must_be_empty result
+'
+
+test_expect_success 'log -G looks into binary files with -a' '
+	git log -a -Ga >actual &&
+	test_cmp actual full-log
+'
+
+test_expect_success 'log -G looks into binary files with textconv filter' '
+	echo "* diff=bin" >.gitattributes &&
+	git -c diff.bin.textconv=cat log -Ga >actual &&
+	test_cmp actual full-log
+'
+
+test_expect_success 'log -S looks into binary files' '
+	>.gitattributes &&
+	git log -Sa >actual &&
+	test_cmp actual full-log
+'
+
 test_done
