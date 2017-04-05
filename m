Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB7FE20966
	for <e@80x24.org>; Wed,  5 Apr 2017 17:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932444AbdDERDy (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Apr 2017 13:03:54 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36270 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755352AbdDERDp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2017 13:03:45 -0400
Received: by mail-pg0-f68.google.com with SMTP id 81so2726668pgh.3
        for <git@vger.kernel.org>; Wed, 05 Apr 2017 10:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hn/FaXgMFoXNO6hqinUe0pCga7NZVc7AN76W0WAGkFQ=;
        b=IozZxuUhQrCVQlAuVZDbJjoLG73bfSss5kUB0Rsg4aYuyr9haQMMYQjCtfz4ixn6aX
         nRNqum+G0JIs0qcrJX9ZCXUg/Oar7gd8LncRlgftiiucO0WHiXFJ/QfI0vspceGcrB2e
         m84CQqaHzQDLZk6MoRghYFK7lEVtfghPZjzPdBlaOupa8ebSyFXQC+reeM6GKpPdA8ig
         1ObhhJ66yyrqGJQux5/fhxQZCOcyVwOZF0u4SXjSwlPac6YuQTbeqL3Wnil7F9JjbkIU
         6SjaG3Dc6gWwezZHdWgkhCP33E+Crk2lJOPsKzVYxm36OT07UzEbbv6b98shYUYbSfRh
         h2GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hn/FaXgMFoXNO6hqinUe0pCga7NZVc7AN76W0WAGkFQ=;
        b=cEE1tipRj1gxdsDVH4VQjMexy0N/JXY6zmQyElC9cF7kZVq5czRrHrZgZiGi99hphb
         WhlzNKi6UG8WOwKzD8E/r7y+9FF4Mw4pg1INk/pz+m6eufp31DpIF3kViMf0H0ZJDXn4
         zLZcAvWAWrx6o5Dq2k2bw7wwTUc6CPnaPwaml9QYm7MlEALoqyzmJbmzqb9m3xON3tvk
         W76lBN+O1sN2UmrYLMt5N/TdLg9EVmieVOV532GIc8elMfIddZ/W/H7or723lQj7pPJ4
         6junlPu5agA7pLkiCEgKSiHbDElDM8igevJZ7I6eOA2HRRqyAdTupyWYppLbpt1L/w26
         NaMA==
X-Gm-Message-State: AFeK/H2fTPZf9+0p/QXGRldB2cJPhM9rGpy3Qf+kZ7huADiDzD6fKZTSJRLnqMhMdN0NIQ==
X-Received: by 10.99.98.135 with SMTP id w129mr31619335pgb.134.1491411819020;
        Wed, 05 Apr 2017 10:03:39 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:55a8:b4cb:debd:758b])
        by smtp.gmail.com with ESMTPSA id h25sm38610702pfk.119.2017.04.05.10.03.38
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 05 Apr 2017 10:03:38 -0700 (PDT)
Date:   Wed, 5 Apr 2017 10:03:36 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@jeffhostetler.com
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v5] read-cache: force_verify_index_checksum
Message-ID: <20170405170336.GE8741@aiede.mtv.corp.google.com>
References: <20170405145510.2324-1-git@jeffhostetler.com>
 <20170405145510.2324-2-git@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170405145510.2324-2-git@jeffhostetler.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

git@jeffhostetler.com wrote:

> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---
>  builtin/fsck.c  |  1 +
>  cache.h         |  2 ++
>  read-cache.c    |  7 +++++++
>  t/t1450-fsck.sh | 11 +++++++++++
>  4 files changed, 21 insertions(+)

Yay!  I love this version.

> --- a/builtin/fsck.c
> +++ b/builtin/fsck.c
> @@ -771,6 +771,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
>  	}
>  
>  	if (keep_cache_objects) {
> +		force_verify_index_checksum = 1;

nit: now that there isn't a config this is overriding, this isn't
"force_verify" so much as "verify".

[...]
> +++ b/t/t1450-fsck.sh
> @@ -689,4 +689,15 @@ test_expect_success 'bogus head does not fallback to all heads' '
>  	! grep $blob out
>  '
>  
> +test_expect_success PERL 'detect corrupt index file in fsck' '
> +	cp .git/index .git/index.backup &&
> +	echo zzzzzzzz >zzzzzzzz &&
> +	git add zzzzzzzz &&
> +	perl -pi -e "s/zzzzzzzz/yyyyyyyy/" .git/index &&
> +	test_must_fail git fsck --cache &&
> +	rm .git/index &&
> +	mv .git/index.backup .git/index &&
> +	rm zzzzzzzz
> +'

This is great.

optional: you can do the cleanup commands in test_when_finished to
make sure they happen even if the test fails.

Tests don't seem to use "perl -pi" anywhere else.  This instance could
be simplified by using sed.

With whatever subset of the changes below look good,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

diff --git i/builtin/fsck.c w/builtin/fsck.c
index 92324e130c..b5e13a4556 100644
--- i/builtin/fsck.c
+++ w/builtin/fsck.c
@@ -771,7 +771,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 	}
 
 	if (keep_cache_objects) {
-		force_verify_index_checksum = 1;
+		verify_index_checksum = 1;
 		read_cache();
 		for (i = 0; i < active_nr; i++) {
 			unsigned int mode;
diff --git i/cache.h w/cache.h
index 48b47083d3..9834d71f28 100644
--- i/cache.h
+++ w/cache.h
@@ -706,7 +706,7 @@ extern void update_index_if_able(struct index_state *, struct lock_file *);
 extern int hold_locked_index(struct lock_file *, int);
 extern void set_alternate_index_output(const char *);
 
-extern int force_verify_index_checksum;
+extern int verify_index_checksum;
 
 /* Environment bits from configuration mechanism */
 extern int trust_executable_bit;
diff --git i/read-cache.c w/read-cache.c
index 13326464d4..008b335844 100644
--- i/read-cache.c
+++ w/read-cache.c
@@ -1372,7 +1372,7 @@ struct ondisk_cache_entry_extended {
 			    ondisk_cache_entry_size(ce_namelen(ce)))
 
 /* Allow fsck to force verification of the index checksum. */
-int force_verify_index_checksum;
+int verify_index_checksum;
 
 static int verify_hdr(struct cache_header *hdr, unsigned long size)
 {
@@ -1386,7 +1386,7 @@ static int verify_hdr(struct cache_header *hdr, unsigned long size)
 	if (hdr_version < INDEX_FORMAT_LB || INDEX_FORMAT_UB < hdr_version)
 		return error("bad index version %d", hdr_version);
 
-	if (!force_verify_index_checksum)
+	if (!verify_index_checksum)
 		return 0;
 
 	git_SHA1_Init(&c);
diff --git i/t/t1450-fsck.sh w/t/t1450-fsck.sh
index 86757ffa52..e69b32f219 100755
--- i/t/t1450-fsck.sh
+++ w/t/t1450-fsck.sh
@@ -689,15 +689,15 @@ test_expect_success 'bogus head does not fallback to all heads' '
 	! grep $blob out
 '
 
-test_expect_success PERL 'detect corrupt index file in fsck' '
+test_expect_success 'detect corrupt index file in fsck' '
 	cp .git/index .git/index.backup &&
+	test_when_finished "mv .git/index.backup .git/index" &&
 	echo zzzzzzzz >zzzzzzzz &&
+	test_when_finished "rm zzzzzzzz" &&
 	git add zzzzzzzz &&
-	perl -pi -e "s/zzzzzzzz/yyyyyyyy/" .git/index &&
-	test_must_fail git fsck --cache &&
-	rm .git/index &&
-	mv .git/index.backup .git/index &&
-	rm zzzzzzzz
+	sed -e "s/zzzzzzzz/yyyyyyyy/" .git/index >.git/index+ &&
+	mv .git/index+ .git/index &&
+	test_must_fail git fsck --cache
 '
 
 test_done
