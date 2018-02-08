Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4277F1F404
	for <e@80x24.org>; Thu,  8 Feb 2018 16:20:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752517AbeBHQUY (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 11:20:24 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35915 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752493AbeBHQUW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 11:20:22 -0500
Received: by mail-wm0-f68.google.com with SMTP id f3so11061053wmc.1
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 08:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=UrvrHvv35LWrJf3NOOqQsY4HeV4gaap00hxcCIijMp8=;
        b=SFX+FVesfggfzytfs1IRUcZ5dQD2kdNfnrF9zUsQ0ELYsekktKCGlUR9elmlhDGul6
         7D/dsFoCORM61jrPkW0GAOi6wRIr85l8Y00mcHX6F0rsKGmjzt2eQEsCdEEGRIn5/1lt
         4VVJqNhPi0ceAmnjT4tlTT413FlGgpjnnWVTb51K9PYC47cgj7Njm0ACw6pLIW9eZQHO
         Yi1GPHu7ns9LaqHFMOu1kIF85V6J76mybwbQOG+akC10GsFNJSDcIb5IEmSrj0Q9aWL+
         KTZRblyKrrUGBm/PGuMzCPUtnSvsy+cAFx0hrun3MF0614PN1M6jJIjLBFahKXkFeBnl
         STjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=UrvrHvv35LWrJf3NOOqQsY4HeV4gaap00hxcCIijMp8=;
        b=AVm7Ej2E31xuAwTcdGLVcqK1OVQuL3HViLk83RPYN0/Y/l3hzfjzPLmKbqSJFZ2VGW
         bTSQ14LGA8RtUi9ypAylgbDAGMo/cEyUHyvf2ngMIfA/OoTrI66utbq4fMUhigppqfks
         AF4ldAD0FOCR9INBzlzZDArD5rlVQDzOi3T8PDLC60okc5pVlDEKtrU8DA1Aa7fPkoRr
         Auukgg/5czDtiLr8Fy0ynsCxktJnad4YiXOnfjtqxPJPM/rWNMVi90oJaElfCfx6fy7n
         GwvNXsOKdu1i1kJ4Yya1alEcZwjvUFvl5DGrp/Kry38QnkY83LFJP+AK7BTTvKa7PfDT
         nnlg==
X-Gm-Message-State: APf1xPBdaj1P8Ot7ZugmPOCwGv903Ruqb+YJuOnDltcCN8npQlfYTy/F
        iTQxedXN4HdofmW+DBlqC6GbjKIA
X-Google-Smtp-Source: AH8x224/Ar+1URIy/OQrxWVTI4FQn2w37IyuFCHEQo9G8ku7+Nnp1l1tylWcyM7v3G1K5qIYxG5CVQ==
X-Received: by 10.28.182.86 with SMTP id g83mr1500016wmf.75.1518106820649;
        Thu, 08 Feb 2018 08:20:20 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id m1sm332532wrb.78.2018.02.08.08.20.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Feb 2018 08:20:19 -0800 (PST)
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
Subject: [PATCH v2 11/17] fetch tests: fetch <url> <spec> as well as fetch [<remote>]
Date:   Thu,  8 Feb 2018 16:19:30 +0000
Message-Id: <20180208161936.8196-12-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180208161936.8196-1-avarab@gmail.com>
References: <20180208161936.8196-1-avarab@gmail.com>
In-Reply-To: <20180123221326.28495-1-avarab@gmail.com>
References: <20180123221326.28495-1-avarab@gmail.com>
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
 t/t5510-fetch.sh | 47 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 43 insertions(+), 4 deletions(-)

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index dfc749f576..73ba83454f 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -548,18 +548,52 @@ set_config_tristate () {
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
+	if ! test -e prune-type-setup-done
+	then
+		test_expect_success 'prune_type setup' '
+			git -C one config remote.origin.url >one.remote-url &&
+			git -C one config remote.origin.fetch >one.remote-fetch &&
+			remote_url="file://$(cat one.remote-url)" &&
+			remote_fetch="$(cat one.remote-fetch)" &&
+			cmdline_setup="\"$remote_url\" \"$remote_fetch\"" &&
+			touch prune-type-setup-done
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
@@ -567,7 +601,7 @@ test_configured_prune () {
 			cd one &&
 			test_unconfig fetch.prune &&
 			test_unconfig remote.origin.prune &&
-			git fetch &&
+			git fetch '"$cmdline_setup"' &&
 			git rev-parse --verify refs/remotes/origin/newbranch &&
 			git rev-parse --verify refs/tags/newtag
 		) &&
@@ -579,10 +613,15 @@ test_configured_prune () {
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

