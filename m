Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B01CA1F404
	for <e@80x24.org>; Fri,  9 Feb 2018 20:33:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752817AbeBIUc7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 15:32:59 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:56220 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752592AbeBIUc4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 15:32:56 -0500
Received: by mail-wm0-f65.google.com with SMTP id 143so17481553wma.5
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 12:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=1WrxTkh98DH+TFHpxID1FzlF81l1yoJr9/YarWyPbhU=;
        b=T/dznO5mx2WoOEseSg0AsrMSbtyaFxhEP541WiYJoecfMRamNaIDsARHCXOXmGE+t5
         ZyfwwdYBaQkjqHcpNx4xaJhmd/YP7839FyOfyR9Z7AksQW5bm5BtjbxGtuci0ayQhB3w
         0lOBXz/hG8/D77HVxhB16vqFgEj5enKjqGY6ZJWi2MGj27m4+Hs5GwWMUpXQuCrt6ktK
         68cyT5/X2ICn6QqWo4gdP8MufgMT9LPZixgE/zu5nlSZJc61EBgDuDBOl34BkLduM2Z4
         3b5VbbsKGmsRd0N0oTVk6yvVZbI5gQWqR+UKNSCymb/BQuZoNQ93fyAHx9hJM96Bsjmf
         qXyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=1WrxTkh98DH+TFHpxID1FzlF81l1yoJr9/YarWyPbhU=;
        b=VKNKDB/NVhq7Qd3V0dCDSRA8+a/iSvH7TxtkInl71tmjfqRgZ1U6zlFAP15K+/F1Y5
         U9jYvhTdd8wEFNAdbI0A324aFeWbi1ORImTYRv1+JvsGCSqHc/eqqKiVNtAQUeJeTgAq
         oyi0nL7uLRaB8vaV0cMsrLRAoO1vfgBuRriKjHLFB4/c/M0hGVFlB29akUuuQ/1ScHax
         74b3Rnmkjt+hs1KazAtBZMBnEArssN5A5VjBhPDIBxjboHICBEpHBDGLqybIfAr9hqNl
         39nD9tVu/iK/MJX32Ww3As7TVg+tmlM8ZPfbsyITWHI1NjeGokuTt076UeuI4Bb+tcWF
         Gl9g==
X-Gm-Message-State: APf1xPD7qwiaBpMylJ/pecjuJN3nCPhYcsrdGHKDZ4+sUR3qtCgLQ0s3
        CCC9r/R3c1JF7V8MCZ2CTPte8ESa
X-Google-Smtp-Source: AH8x226w1Zv9njRvp7JhQvSB3XoKzYYbJ7ukdDqDwmHvCeRyGir3zuCurnxObuYurKEotX6UmgOjCQ==
X-Received: by 10.28.247.11 with SMTP id v11mr3330558wmh.27.1518208374420;
        Fri, 09 Feb 2018 12:32:54 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id y90sm5750233wrc.24.2018.02.09.12.32.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Feb 2018 12:32:53 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Giuffrida <michaelpg@chromium.org>,
        Michael Schubert <mschub@elegosoft.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Daniel Barkalow <barkalow@iabervon.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 11/17] fetch tests: fetch <url> <spec> as well as fetch [<remote>]
Date:   Fri,  9 Feb 2018 20:32:10 +0000
Message-Id: <20180209203216.11560-12-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180209203216.11560-1-avarab@gmail.com>
References: <20180209203216.11560-1-avarab@gmail.com>
In-Reply-To: <20180121000304.32323-1-avarab@gmail.com>
References: <20180121000304.32323-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a remote URL is supplied on the command-line the internals of the
fetch are different, in particular the code in get_ref_map(). An
earlier version of the subsequent fetch.pruneTags patch hid a segfault
because the difference wasn't tested for.

Now all the tests are run as both of the variants of:

    git fetch
    git -c [...] fetch $(git config remote.origin.url) $(git config remote.origin.fetch)

I'm using -c because while the [fetch] config just set by
set_config_tristate will be picked up, the remote.origin.* config
won't override it as intended.

Work around that and turn this into a purely command-line test by
always setting the variables on the command-line, and translate any
setting of remote.origin.X into fetch.X.

The reason for choosing the names "name" and "link" as opposed to
e.g. "named" and "url" is because they're the same length, which makes
the test output easier to read as it will be aligned.

Due to shellscript quoting madness it's not worthwhile to do all of
this within a test_expect_success, but do the parts that can easily be
done there, including the one-time setting of variables that don't
change between runs to be used by subsequent runs in the 'prune_type
setup' test.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5510-fetch.sh | 44 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 40 insertions(+), 4 deletions(-)

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index dfc749f576..9c87fa6106 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -548,18 +548,49 @@ set_config_tristate () {
 		;;
 	*)
 		git config "$1" "$2"
+		key=$(echo $1 | sed -e 's/^remote\.origin/fetch/')
+		git_fetch_c="$git_fetch_c -c $key=$2"
 		;;
 	esac
 }
 
 test_configured_prune () {
+	test_configured_prune_type "$@" "name"
+	test_configured_prune_type "$@" "link"
+}
+
+test_configured_prune_type () {
 	fetch_prune=$1
 	remote_origin_prune=$2
 	expected_branch=$3
 	expected_tag=$4
 	cmdline=$5
-
-	test_expect_success "prune fetch.prune=$1 remote.origin.prune=$2${5:+ $5}; branch:$3 tag:$4" '
+	mode=$6
+
+	if test -z "$cmdline_setup"
+	then
+		test_expect_success 'setup cmdline_setup variable for subsequent test' '
+			remote_url="file://$(git -C one config remote.origin.url)" &&
+			remote_fetch="$(git -C one config remote.origin.fetch)" &&
+			cmdline_setup="\"$remote_url\" \"$remote_fetch\""
+		'
+	fi
+
+	if test "$mode" = 'link'
+	then
+		new_cmdline=""
+
+		if test "$cmdline" = ""
+		then
+			new_cmdline=$cmdline_setup
+		else
+			new_cmdline=$(printf "%s" "$cmdline" | perl -pe 's[origin(?!/)]["'"$remote_url"'"]g')
+		fi
+
+		cmdline="$new_cmdline"
+	fi
+
+	test_expect_success "$mode prune fetch.prune=$1 remote.origin.prune=$2${5:+ $5}; branch:$3 tag:$4" '
 		# make sure a newbranch is there in . and also in one
 		git branch -f newbranch &&
 		git tag -f newtag &&
@@ -567,7 +598,7 @@ test_configured_prune () {
 			cd one &&
 			test_unconfig fetch.prune &&
 			test_unconfig remote.origin.prune &&
-			git fetch &&
+			git fetch '"$cmdline_setup"' &&
 			git rev-parse --verify refs/remotes/origin/newbranch &&
 			git rev-parse --verify refs/tags/newtag
 		) &&
@@ -579,10 +610,15 @@ test_configured_prune () {
 		# then test
 		(
 			cd one &&
+			git_fetch_c="" &&
 			set_config_tristate fetch.prune $fetch_prune &&
 			set_config_tristate remote.origin.prune $remote_origin_prune &&
 
-			git fetch '"$cmdline"' &&
+			if test "$mode" != "link"
+			then
+				git_fetch_c=""
+			fi &&
+			git$git_fetch_c fetch '"$cmdline"' &&
 			case "$expected_branch" in
 			pruned)
 				test_must_fail git rev-parse --verify refs/remotes/origin/newbranch
-- 
2.15.1.424.g9478a66081

