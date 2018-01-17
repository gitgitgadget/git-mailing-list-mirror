Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F28601FADF
	for <e@80x24.org>; Wed, 17 Jan 2018 09:34:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752062AbeAQJel (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Jan 2018 04:34:41 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:37832 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750815AbeAQJej (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jan 2018 04:34:39 -0500
Received: by mail-pl0-f66.google.com with SMTP id s3so8400841plp.4
        for <git@vger.kernel.org>; Wed, 17 Jan 2018 01:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=qyYv1bFc4O1WSdoPX8qnMgiJog4+fbW0t7dbUmIFJ3w=;
        b=ERPaHEew6bK2CjLdTpE+bYRy1T11gHiBjzJWlEtZeyLKQDcFZqMO/o2jHyIRXgIkub
         UoJCJ+OpP6YX9xUkugtOWYHO1dCA/H8QD18O3EEbAcX1J+OFUKhTQbjxqpPvcTjwvghh
         4s8XtLVhaywIu1xNadld33BkjDbaZwc2Ts+YsR9k5P4QzbggXZyshwCTv0s4BjOUIP+y
         Tle4b33gAvqMKl1ppZtIKMG3Zn5cmkKdVH+xcjsPDJzFIrbucGJPi5Fu4zWjqf/06X4J
         4EPrNDormN+xImbEiLkpbjaIhD5kRjhfv0c3IQftL24v9IgqxZmF+mdxeCrnPSg4sZ9J
         HVOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=qyYv1bFc4O1WSdoPX8qnMgiJog4+fbW0t7dbUmIFJ3w=;
        b=E79I5/Z7XyrGTHSzLVm2/FGSBJGWoZHCBl26ovpE1UEbiQg3Cue1bn20I3N5Tuhc37
         7T9EvStzA69RdqJoOcvk/phwLCVZgJs0tAIIBSFAwts70K9Seyksz4oP41uebp/J6K4Y
         yAe+Ag7mUQNvqw7m8xecxoXTVOv3HY81Kt+pQwiQR3BkZsbqoMz4NYcX+vW9EWlAgmtE
         INNqg7uapARn1ECtt+evdNwdKcMc7g12aqkhy+kQcWl0Dg23KiSKY2+a770k9ze7Dz2E
         gnDHAN/FaOyiKYyyS+pr7T7Y6neQNKeTAXVxnFPXBPuv5NNGqo9I33B6b3hVZjv/ESoR
         PsuQ==
X-Gm-Message-State: AKwxytdJbBtP0BnesY+anBeSzjIaP9od0nImhsk1nK32sgJcAeWimsLk
        sExP0iAgCy66HZE+JmXdWWk=
X-Google-Smtp-Source: ACJfBotvhY6544YCrumC4frQunEzwEOCUpDlM1V4qXOxkLD9gI+408LygSFYXH18q7lV8f5+M6AXBA==
X-Received: by 10.159.197.6 with SMTP id bj6mr25214985plb.87.1516181678730;
        Wed, 17 Jan 2018 01:34:38 -0800 (PST)
Received: from ash ([27.75.129.14])
        by smtp.gmail.com with ESMTPSA id j29sm7278015pgn.47.2018.01.17.01.34.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jan 2018 01:34:38 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 17 Jan 2018 16:34:32 +0700
Date:   Wed, 17 Jan 2018 16:34:32 +0700
From:   Duy Nguyen <pclouds@gmail.com>
To:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH/RFC 0/2] Automate updating git-completion.bash a bit
Message-ID: <20180117093432.GA19189@ash>
References: <20180116103700.4505-1-pclouds@gmail.com>
 <CAM0VKjkz8-VsLJ8i64OHHUH4R4WY5fT6x3X+s=FKuZyfM9txkA@mail.gmail.com>
 <CACsJy8D3wRmP_o5iFJwWtODOJpj-r=JZsJ3P8XxWOCD8rJJrHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACsJy8D3wRmP_o5iFJwWtODOJpj-r=JZsJ3P8XxWOCD8rJJrHA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Actually I forgot another option. What if we automate updating the
script at "compile" time instead of calling git at run time? E.g. with
something like below, a contributor could just run

    make update-completion

then add git-completion.bash changes to the same patch that introduces
new options. If they forget, Junio could always run this near -rc0.

I know this output is a bit ugly. I probably could try to make the
update work with wrapped __gitcomp lines to be friendlier to human
eyes.

-- 8< --
diff --git a/Makefile b/Makefile
index 1a9b23b679..05eb7c8742 100644
--- a/Makefile
+++ b/Makefile
@@ -2834,3 +2834,5 @@ cover_db: coverage-report
 cover_db_html: cover_db
 	cover -report html -outputdir cover_db_html cover_db
 
+update-completion:
+	contrib/completion/update.sh contrib/completion/git-completion.bash ./git
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 3683c772c5..e8c224f486 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1585,21 +1585,7 @@ _git_grep ()
 
 	case "$cur" in
 	--*)
-		__gitcomp "
-			--cached
-			--text --ignore-case --word-regexp --invert-match
-			--full-name --line-number
-			--extended-regexp --basic-regexp --fixed-strings
-			--perl-regexp
-			--threads
-			--files-with-matches --name-only
-			--files-without-match
-			--max-depth
-			--count
-			--and --or --not --all-match
-			--break --heading --show-function --function-context
-			--untracked --no-index
-			"
+		__gitcomp_auto grep "--cached --text --ignore-case --word-regexp --invert-match --full-name --line-number --extended-regexp --basic-regexp --fixed-strings --perl-regexp --threads --files-with-matches --name-only --files-without-match --max-depth --count --and --or --not --all-match --break --heading --show-function --function-context --untracked --no-index"
 		return
 		;;
 	esac
diff --git a/contrib/completion/update.sh b/contrib/completion/update.sh
new file mode 100755
index 0000000000..99c4841152
--- /dev/null
+++ b/contrib/completion/update.sh
@@ -0,0 +1,8 @@
+#!/bin/sh
+
+file="$1"
+git="$2"
+
+grep __gitcomp_auto "$file" | while read a cmd b; do
+    sed -i "s/\\(.*$a $cmd \).*/\\1$("$git" $cmd --git-completion-helper)/" "$file"
+done
-- 8< --




On Wed, Jan 17, 2018 at 04:16:22PM +0700, Duy Nguyen wrote:
> On Wed, Jan 17, 2018 at 7:51 AM, SZEDER Gábor <szeder.dev@gmail.com> wrote:
> > On Tue, Jan 16, 2018 at 11:36 AM, Nguyễn Thái Ngọc Duy
> > <pclouds@gmail.com> wrote:
> >> I noticed --recurse-submodules was missing from git-grep complete
> >> list. Then I found a couple more should be on the list as well and
> >> many more in future may face the same faith. Perhaps this helps remedy
> >> this situation?
> >>
> >> This lets us extract certain information from git commands and feed it
> >> directly to git-completion.bash. Now long options by default will
> >> be complete-able (which also means it's the reviewer's and coder's
> >> responsibility to add "no complete" flag appropriately) but I think
> >> the number of new dangerous options will be much fewer than
> >> completeable ones.
> >>
> >> This is not really a new idea. Python has argcomplete that does more
> >> or less the same thing.
> >
> > This has come up before for Git as well, see:
> >
> >   https://public-inbox.org/git/1334140165-24958-1-git-send-email-bebarino@gmail.com/T/#u
> 
> Thanks! I did search the archive but couldn't find this one.
> 
> >
> > I see that your approach solves one of the shortcomings of those older
> > patches, namely it makes possible to omit dangerous options from
> > completion.  Great.
> >
> > I also see that you want to invoke git in a subshell every time the user
> > attempts to complete an --option.  Not so great, at least for Windows
> > users.  That older thread contains a few ideas about how to do it only
> > once by lazy-initializing a variable for each command to hold its
> > options.
> 
> Noted.
> 
> I see you also pointed out the problem with running commands like
> "git-status" without a repository. I'll try to address this too if
> possible (I'm thinking about making struct options[] available outside
> cmd_*(); then we could handle it more like "git --version" which
> always works)
> -- 
> Duy
