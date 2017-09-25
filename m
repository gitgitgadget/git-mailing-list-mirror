Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97F6520281
	for <e@80x24.org>; Mon, 25 Sep 2017 08:09:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933052AbdIYIJM (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 04:09:12 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:35329 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932117AbdIYIJG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 04:09:06 -0400
Received: by mail-io0-f196.google.com with SMTP id d16so2523213ioj.2
        for <git@vger.kernel.org>; Mon, 25 Sep 2017 01:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mrFRycx7paYddcZxlp2IN5Nb7KsE3192BfTqDkPe++k=;
        b=ZoTwci9tZpRAnW6E23cDaEwTxUbUh+c6ts3CbwhSUV/71Bn+fhPisjlPPwM0Fuy0id
         gOTdhoeD4dstcazTSNLftZx+qRM1YG7BLyGdmFXCOihMJnSFyzofRVUDprRIIPQCbwVI
         LEueNk84tP6tvwzKuZrJL6muP8Ab/l+kQ2YOCjg/L8kKmn7eBsTJ8a0yegZZXn3/vY7M
         6dQ1pQzugPUYY3Taa5fN8UaQLBjpkiiXVrIur694tr9RiGwqp4RuubBUYrR0BYSLJ2/R
         0rb8ToIwK/WsLorUWd0yiJa07a1uUpDFUJChoRl2k5FUYRJRVLKcAJuU0HM18l5/YEAw
         uLPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mrFRycx7paYddcZxlp2IN5Nb7KsE3192BfTqDkPe++k=;
        b=GpW3pbCE4WZHCUX1HuK1U37Q6chfhevuCFtAMNRVCxX89wXXQ2kbiNcXhN2PNyTTm8
         Aq/NE6Cq987WuuLsy3pRi5LxVXRHritLMpoPtWdpXcmezhY+oKT0nuehnvb/LMQq7gDZ
         0HcrNrK8nhw50y9GejLWJan0X5rhhvapYzveTuMJ1sZGDZsZ2MU9hbfvqctDOe7ETFhu
         9HQhEII1LgmIhCkW+JwqCTQGpFEambwCa2nNS0WHt3IC5B40e1bUnWiDj7L4inLejnwF
         oQ976qeXYlEwdrDJUTNKkTzvTqPAs4A0vKAgfBsFPUGyX/1z9FPsPCBkWUrH331VF+Dr
         Tcpw==
X-Gm-Message-State: AHPjjUjp/hQvZlrOubPBPdnGX4Is1KbgmUzDA/WgfXFyE3HVUILjOXnT
        odzaCoMxUEIeIMMQDZxVg4ne3cGo
X-Google-Smtp-Source: AOwi7QBNocHmHQ1DfvRL3AME2yQrQ6iRvTY4/gzM6L5IYTneDh+oBb0tTe9NqHtPx0dOqa160vftYg==
X-Received: by 10.107.222.20 with SMTP id v20mr8448890iog.20.1506326945777;
        Mon, 25 Sep 2017 01:09:05 -0700 (PDT)
Received: from r ([122.180.203.98])
        by smtp.gmail.com with ESMTPSA id v5sm2628285iob.5.2017.09.25.01.09.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Sep 2017 01:09:05 -0700 (PDT)
From:   Manav Rathi <mnvrth@gmail.com>
X-Google-Original-From: Manav Rathi <mnv@r>
Date:   Mon, 25 Sep 2017 13:39:00 +0530
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Manav Rathi <mnvrth@gmail.com>, git@vger.kernel.org,
        pclouds@gmail.com
Subject: [PATCHv2] docs: improve discoverability of exclude pathspec
Message-ID: <20170925080900.GA60206@r>
References: <CAEuZsW8vR0LesL=+ZoiFa=BBwhhm=KON+U3H2H9sNdTT+jgBkQ@mail.gmail.com>
 <xmqq1smvh9my.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1smvh9my.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Sep 25, 2017 at 10:03:49AM +0900, Junio C Hamano wrote:
> Manav Rathi <mnvrth@gmail.com> writes:
>
> > The ability to exclude paths in pathspecs is not mentioned in the man
> > pages of git grep and other commands where it might be useful.
> 
> My reading stutters around "exclude paths in pathspecs" in the
> above.  Perhaps "exclude paths with a negative pathspec" instead?

Changed

> > diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
> 
> This does a lot more than what the log message claims to do, unlike
> the changes to other documentation pages.  Splitting the existing
> paragraph in "git add" into multiple pagagraphs and changing a few
> words here and there wasn't part of the bargain.
> 
> It would be easier to judge the merit of the patch if you split it
> into two steps, if you want all the changes in it.  One would do
> only what the log message claimed it did, i.e. "refer to glossary,
> give an example where appropriate and add test".  That part I think
> everybody can agree that it is a good change.  The change to the
> introduction part I am not so sure about.
> 

I have undone the auxiliary edits to git-add.txt.

> > -test_expect_success 'exclude only no longer errors out' '
> > +test_expect_success 'exclude only pathspec uses default implicit pathspec' '
> 
> This is a very good change.
> 

Thank you.

> > +test_expect_success 'multiple exclusions' '
> > + git ls-files -- :^*/file2 :^sub2 >actual &&
> 
> Please quote these patterns inside "pair of dqs".
> 

Done

> > + cat <<EOF >expect &&
> > +file
> > +sub/file
> > +sub/sub/file
> > +sub/sub/sub/file
> > +EOF
> 
> By using <<-\EOF, you can indent (with tab) the contents of the here
> document, like so:
> 
> 	cat >expect <<-EOF &&
> 	file
> 	...
>         EOF
> 

Done

> By the way, please check your e-mail settings.  Your MUA seems to
> have lost all tabs, and this patch does not apply.

I am sorry about that. The instructions in SubmittingPatches clearly
mentioned that this will happen, but still I was not careful enough.

Hopefully this one should not be broken.

-- >8 --

Subject: [PATCH v2] docs: improve discoverability of exclude pathspec

The ability to exclude paths with a negative pathspec is not mentioned
in the man pages for git grep and other commands where it might be
useful.

Add an example and a pointer to the pathspec glossary entry in the man
page for git grep to help the user to discover this ability.

Add similar pointers from the git-add and git-status man pages.

Additionally,

- Add a test for the behaviour when multiple exclusions are present.
- Add a test for the ^ alias.
- Improve name of existing test.
- Improve grammar in glossary description of the exclude pathspec.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Manav Rathi <mnvrth@gmail.com>
---
 Documentation/git-add.txt          |  3 +++
 Documentation/git-grep.txt         |  6 ++++++
 Documentation/git-status.txt       |  2 ++
 Documentation/glossary-content.txt |  2 +-
 t/t6132-pathspec-exclude.sh        | 13 ++++++++++++-
 5 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index f4169fb..b700bea 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -61,6 +61,9 @@ OPTIONS
 	the working tree.  Note that older versions of Git used
 	to ignore removed files; use `--no-all` option if you want
 	to add modified or new files but ignore removed	ones.
++
+For more details about the <pathspec> syntax, see the 'pathspec' entry
+in linkgit:gitglossary[7].
 
 -n::
 --dry-run::
diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 720c785..18b4947 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -289,6 +289,9 @@ providing this option will cause it to die.
 <pathspec>...::
 	If given, limit the search to paths matching at least one pattern.
 	Both leading paths match and glob(7) patterns are supported.
++
+For more details about the <pathspec> syntax, see the 'pathspec' entry
+in linkgit:gitglossary[7].
 
 Examples
 --------
@@ -305,6 +308,9 @@ Examples
 	Looks for a line that has `NODE` or `Unexpected` in
 	files that have lines that match both.
 
+`git grep solution -- :^Documentation`::
+	Looks for `solution`, excluding files in `Documentation`.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index d47f198..9f3a78a 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -111,6 +111,8 @@ configuration variable documented in linkgit:git-config[1].
 	without options are equivalent to 'always' and 'never'
 	respectively.
 
+<pathspec>...::
+	See the 'pathspec' entry in linkgit:gitglossary[7].
 
 OUTPUT
 ------
diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index b71b943..6b8888d 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -407,7 +407,7 @@ these forms:
 
 exclude;;
 	After a path matches any non-exclude pathspec, it will be run
-	through all exclude pathspec (magic signature: `!` or its
+	through all exclude pathspecs (magic signature: `!` or its
 	synonym `^`). If it matches, the path is ignored.  When there
 	is no non-exclude pathspec, the exclusion is applied to the
 	result set as if invoked without any pathspec.
diff --git a/t/t6132-pathspec-exclude.sh b/t/t6132-pathspec-exclude.sh
index 9dd5cde..eb829fc 100755
--- a/t/t6132-pathspec-exclude.sh
+++ b/t/t6132-pathspec-exclude.sh
@@ -25,7 +25,7 @@ EOF
 	test_cmp expect actual
 '
 
-test_expect_success 'exclude only no longer errors out' '
+test_expect_success 'exclude only pathspec uses default implicit pathspec' '
 	git log --oneline --format=%s -- . ":(exclude)sub" >expect &&
 	git log --oneline --format=%s -- ":(exclude)sub" >actual &&
 	test_cmp expect actual
@@ -183,4 +183,15 @@ EOF
 	test_cmp expect actual
 '
 
+test_expect_success 'multiple exclusions' '
+	git ls-files -- ":^*/file2" ":^sub2" >actual &&
+	cat <<-\EOF >expect &&
+	file
+	sub/file
+	sub/sub/file
+	sub/sub/sub/file
+	EOF
+	test_cmp expect actual
+'
+
 test_done
-- 
2.10.1
