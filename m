Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 282BD20248
	for <e@80x24.org>; Tue,  9 Apr 2019 05:09:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbfDIFJB (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 01:09:01 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38866 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbfDIFJA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 01:09:00 -0400
Received: by mail-pl1-f196.google.com with SMTP id f36so4175299plb.5
        for <git@vger.kernel.org>; Mon, 08 Apr 2019 22:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oZ/sfyga2QU73WOTvJmn1U91TnPhXSLktcEDACSuUHo=;
        b=A/uXD7MOoCgJKocvf1KY/FA4KX/G+IK5ITkAg9ee6hB/fAcyruhwfOf2m9ZbFmwkKI
         xLLQScUhuld6IN/oUgM5m6A8+Dk8rE8E2t+SiXWlU0zIOtnHi+gf5VcExYeIz0SBeojz
         by2PA/De7mND0/EVnUTjWYvaVL2W48+pg/nPjUeMXp5fG4bwaIIdYHOIS4EItd2K5mOZ
         RBitGldZf7B06WI4YSOlNW6j8mHHrBEdrpezbGb860KoR3S4ss3FrB+eqH3BbWscVcr0
         V6sfb3NdvRIeNipguOuVdletiVtM1PcnQokrcH+0ECNVgDyLanJjZJbEHbaHuanGhlbr
         6kBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oZ/sfyga2QU73WOTvJmn1U91TnPhXSLktcEDACSuUHo=;
        b=ZPhmvA8ZtOP1h/24a8s8+AxEnW8IHWkDQIcY+YcFS+CMY81nb2gY7UxroCrkOiqPCk
         tNxjEYUvrzArT3TJu5dMZnJ1BTXEpJh1a04PK6cZYX+w4bK6uR7zuxtmw3CDBS5xOEeg
         rKsox1aImnrVwNEOqvn+SdGkhHWh/L2m84E/LvZJXztATqcrqvv75OdBz8dynbPK8ygG
         /l6dn+ZNfdYVRjIifhyH1TYcC/TjPF2FUMnWXpjzuURsSUK2z6R73Niyzbb9SVw9T7EZ
         MB9PX5ijAjhZTfB4Y+Ad/IqcrsCwmRDAr0L/rNI6cFi7BxM5DCgBgSb95H6PMvKeT6w5
         a5Uw==
X-Gm-Message-State: APjAAAXW74lt9YDk2bJR/ZZ/Brb/ebqOFOskxp2lwc5KJqssp861iVP5
        rLI2mFV1QrmCi4ZrMxdytScUPg==
X-Google-Smtp-Source: APXvYqwHOPIthNzks+mtQWynDS7730e5lKEaSCSLygjggRhR8AJeaPnEibz1VvymK3DbP6J57QPMXw==
X-Received: by 2002:a17:902:bf07:: with SMTP id bi7mr5836954plb.87.1554786539534;
        Mon, 08 Apr 2019 22:08:59 -0700 (PDT)
Received: from localhost ([2601:602:9200:32b0:d869:cd1a:616d:3c11])
        by smtp.gmail.com with ESMTPSA id y23sm45396647pfn.25.2019.04.08.22.08.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 22:08:58 -0700 (PDT)
Date:   Mon, 8 Apr 2019 22:08:57 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 2/7] t: introduce tests for unexpected object types
Message-ID: <20190409050857.GI81620@Taylors-MBP.hsd1.wa.comcast.net>
References: <cover.1554435033.git.me@ttaylorr.com>
 <ef6b4f380435d9743a56f47f68c18123bf0a0933.1554435033.git.me@ttaylorr.com>
 <20190405105033.GT32732@szeder.dev>
 <20190405182412.GC2284@sigill.intra.peff.net>
 <CAPig+cQ7f6C-YBE5LT3qiXSyjpqQQEknmE8eHdQJvzCAzkBNPA@mail.gmail.com>
 <xmqqbm1h9et2.fsf@gitster-ct.c.googlers.com>
 <20190409023055.GF81620@Taylors-MBP.hsd1.wa.comcast.net>
 <CAPig+cS+4tTAAWsp+KX2-__kcvgDABQQCmz63d6pQUa6Qu3LKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cS+4tTAAWsp+KX2-__kcvgDABQQCmz63d6pQUa6Qu3LKw@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Mon, Apr 08, 2019 at 11:28:19PM -0400, Eric Sunshine wrote:
> On Mon, Apr 8, 2019 at 10:31 PM Taylor Blau <me@ttaylorr.com> wrote:
> > On Mon, Apr 08, 2019 at 03:44:25PM +0900, Junio C Hamano wrote:
> > > Eric Sunshine <sunshine@sunshineco.com> writes:
> > > >> > > +   git cat-file commit $commit |
> > > >> > > +           perl -lpe "/^author/ && print q(parent $blob)" \
> > > >> > > +           >broken-commit &&
> > > >
> > > > Trivial and portable 'sed' equivalent:
> > > >
> > > > git cat-file commit $commit | sed "/^author/ { h; s/.*/parent $blob/; G; }"
> > >
> > > Looks good.  I had a bit of head scratching moment when I saw that
> > > "perl -lpe" one-liner; this sed expression may not be crystal clear
> > > to those who are not used to, but it is not so bad, either.
> >
> > Should I take this as your endorsement of putting 'git' on the left-hand
> > side of a pipe? ;-).
>
> I suspect that Junio's "Looks good" was referring to the 'sed expression.

I think that you are right -- and I'll happily _not_ introduce more Git
on the left-hand-side of a pipe instances.

I noticed a few more instances in t6102 where we do something similar
to:

  git cat-file -p <something> | sed ... >broken-<something> &&

I wrote the following patch, which I've folded into my local copy (and
will send with v2):

diff --git a/t/t6102-rev-list-unexpected-objects.sh b/t/t6102-rev-list-unexpected-objects.sh
index b9d82f9542..15072ecce3 100755
--- a/t/t6102-rev-list-unexpected-objects.sh
+++ b/t/t6102-rev-list-unexpected-objects.sh
@@ -7,7 +7,8 @@ test_description='git rev-list should handle unexpected object types'
 test_expect_success 'setup well-formed objects' '
 	blob="$(printf "foo" | git hash-object -w --stdin)" &&
 	tree="$(printf "100644 blob $blob\tfoo" | git mktree)" &&
-	commit="$(git commit-tree $tree -m "first commit")"
+	commit="$(git commit-tree $tree -m "first commit")" &&
+	git cat-file commit $commit >good-commit
 '

 test_expect_success 'setup unexpected non-blob entry' '
@@ -37,8 +38,8 @@ test_expect_failure 'traverse unexpected non-tree entry (seen)' '
 '

 test_expect_success 'setup unexpected non-commit parent' '
-	git cat-file commit $commit | \
-		sed "/^author/ { h; s/.*/parent $blob/; G; }" >broken-commit &&
+	sed "/^author/ { h; s/.*/parent $blob/; G; }" <good-commit \
+		>broken-commit &&
 	broken_commit="$(git hash-object -w --literally -t commit \
 		broken-commit)"
 '
@@ -55,8 +56,7 @@ test_expect_success 'traverse unexpected non-commit parent (seen)' '
 '

 test_expect_success 'setup unexpected non-tree root' '
-	git cat-file commit $commit |
-	sed -e "s/$tree/$blob/" >broken-commit &&
+	sed -e "s/$tree/$blob/" <good-commit >broken-commit &&
 	broken_commit="$(git hash-object -w --literally -t commit \
 		broken-commit)"
 '
@@ -71,8 +71,9 @@ test_expect_failure 'traverse unexpected non-tree root (seen)' '

 test_expect_success 'setup unexpected non-commit tag' '
 	git tag -a -m "tagged commit" tag $commit &&
+	git cat-file tag tag >good-tag &&
 	test_when_finished "git tag -d tag" &&
-	git cat-file -p tag | sed -e "s/$commit/$blob/" >broken-tag &&
+	sed -e "s/$commit/$blob/" <good-tag >broken-tag &&
 	tag=$(git hash-object -w --literally -t tag broken-tag)
 '

@@ -87,9 +88,9 @@ test_expect_success 'traverse unexpected non-commit tag (seen)' '

 test_expect_success 'setup unexpected non-tree tag' '
 	git tag -a -m "tagged tree" tag $tree &&
+	git cat-file tag tag >good-tag &&
 	test_when_finished "git tag -d tag" &&
-	git cat-file -p tag |
-	sed -e "s/$tree/$blob/" >broken-tag &&
+	sed -e "s/$tree/$blob/" <good-tag >broken-tag &&
 	tag=$(git hash-object -w --literally -t tag broken-tag)
 '

@@ -104,9 +105,9 @@ test_expect_success 'traverse unexpected non-tree tag (seen)' '

 test_expect_success 'setup unexpected non-blob tag' '
 	git tag -a -m "tagged blob" tag $blob &&
+	git cat-file tag tag >good-tag &&
 	test_when_finished "git tag -d tag" &&
-	git cat-file -p tag |
-	sed -e "s/$blob/$commit/" >broken-tag &&
+	sed -e "s/$blob/$commit/" <good-tag >broken-tag &&
 	tag=$(git hash-object -w --literally -t tag broken-tag)
 '

> With all the recent work of moving away from having Git upstream of a
> pipe, let's not intentionally introduce a new instance. I wrote the
> example 'sed' expression that way merely to mirror how the original
> 'perl' version was written to make it easier to see the equivalence
> (not because it was intended as an endorsement of having Git upstream
> of a pipe).

I see, and thank you for the clarification. Let me know if you like the
patch above.

Thanks,
Taylor
