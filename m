Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36BC11F461
	for <e@80x24.org>; Tue, 27 Aug 2019 04:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbfH0EFT (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 00:05:19 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:43745 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbfH0EFT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 00:05:19 -0400
Received: by mail-io1-f66.google.com with SMTP id 18so42948740ioe.10
        for <git@vger.kernel.org>; Mon, 26 Aug 2019 21:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Z5KZm5ZG2tXk0hXUpg0lCKsRPTIfsSyVLHua7cQOfxg=;
        b=tjTBDDfgAaptq0CAs8HGarwj7ft9CRhuYdlfxquwFNhwM7uprnm7LnZiKj7CHn7+kB
         oTkoB/kVSH3m5RgCHIjC+0Can88qLY4aVoe+0AUPBJBiDxYfOqlIP8HZM8mE1chk75ZO
         7mE7rI5Q5ViVPxgPZuBVj1n9LoHDkF1iKilE9LUGzBsaO+IFJwIGpTro/Lwei8dcWq7O
         zo9wQZwj+3zgepKQMiITtksRoNnC+eOfUaVfJr9u+sdyw6qlJVy7xVpzN7pMcfQahzfJ
         SaYgfKVPka/x1srlQuJXxgKNclw7Q2VM/A1/Pvfxj48n/KOImO0JigOB2qF/O4o/pKOv
         gg6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Z5KZm5ZG2tXk0hXUpg0lCKsRPTIfsSyVLHua7cQOfxg=;
        b=eCdIlXvWHFDKtinj5IInDBeRBRTQ2jR9M1p4Me1HQCG0vh7W91mM1qD7quhUG3SAnw
         ziBqdZ/BletdbEOQOAD2fqXW18eKiQrhWYjV4oo/ia0egnZyz0J/sRRgWGLHsBayTEcr
         yDygdam+9ujWiLKdkCroLIRVlezqIc0+v+l1U0YKxaZE9PwNpdsuhdHBtuW8QeaRaxjA
         zq+q25UxOcio0trFD2YgqJt+kwIvqD8UfCQ2bZjdzTNqp8BKTK6sGusKU4jplLnX2+XP
         gAPR2xChElYfZ1yPaLyAZeKeVsSEgL7wtJAURwDTKUbWa0ktHxbMQ2cWW0gmqgFcDqWA
         H+jA==
X-Gm-Message-State: APjAAAVabK5ixyc1d42ubkGvEgo4uSUwmtiR7j+lfFzvspK9Yd8cF7tX
        bMInJKnCkyIvH+prB9Rqj3XYXRDD
X-Google-Smtp-Source: APXvYqwcOFOTvA3LdCeCK5NPkyxljKvETI7j1SiPF5KhatD00pzb4OV/LC8FwsOtWKMmvOjCDyhr7w==
X-Received: by 2002:a02:9f17:: with SMTP id z23mr20208754jal.19.1566878717591;
        Mon, 26 Aug 2019 21:05:17 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.89.95])
        by smtp.gmail.com with ESMTPSA id y5sm18299295ioc.86.2019.08.26.21.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 21:05:17 -0700 (PDT)
Date:   Tue, 27 Aug 2019 00:05:15 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH v2 11/13] t4014: stop losing return codes of git commands
Message-ID: <bc7355485f81af8a8d6ac8c29e1ffc82925c5fd1.1566878374.git.liu.denton@gmail.com>
References: <cover.1566635008.git.liu.denton@gmail.com>
 <cover.1566878373.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1566878373.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, there are two ways where the return codes of Git commands are
lost. The first way is when a command is in the upstream of a pipe. In a
pipe, only the return code of the last command is used. Thus, all other
commands will have their return codes masked. Rewrite pipes so that
there are no Git commands upstream.

The other way is when a command is in a non-assignment subshell. The
return code will be lost in favour of the surrounding command's. Rewrite
instances of this such that Git commands output to a file and
surrounding commands only call subshells with non-Git commands.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t4014-format-patch.sh | 197 ++++++++++++++++++++++++----------------
 1 file changed, 120 insertions(+), 77 deletions(-)

diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 67f4c62ed6..83f52614d3 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -33,7 +33,8 @@ test_expect_success setup '
 	git commit -m "Side changes #3 with \\n backslash-n in it." &&
 
 	git checkout master &&
-	git diff-tree -p C2 | git apply --index &&
+	git diff-tree -p C2 >patch &&
+	git apply --index <patch &&
 	test_tick &&
 	git commit -m "Master accepts moral equivalent of #2" &&
 
@@ -110,7 +111,8 @@ test_expect_success 'format-patch --ignore-if-in-upstream result applies' '
 '
 
 test_expect_success 'commit did not screw up the log message' '
-	git cat-file commit side | grep "^Side .* with .* backslash-n"
+	git cat-file commit side >actual &&
+	grep "^Side .* with .* backslash-n" actual
 '
 
 test_expect_success 'format-patch did not screw up the log message' '
@@ -119,7 +121,8 @@ test_expect_success 'format-patch did not screw up the log message' '
 '
 
 test_expect_success 'replay did not screw up the log message' '
-	git cat-file commit rebuild-1 | grep "^Side .* with .* backslash-n"
+	git cat-file commit rebuild-1 >actual &&
+	grep "^Side .* with .* backslash-n" actual
 '
 
 test_expect_success 'extra headers' '
@@ -153,63 +156,73 @@ test_expect_success 'extra headers with multiple To:s' '
 
 test_expect_success 'additional command line cc (ascii)' '
 	git config --replace-all format.headers "Cc: R E Cipient <rcipient@example.com>" &&
-	git format-patch --cc="S E Cipient <scipient@example.com>" --stdout master..side | sed -e "/^\$/q" >patch5 &&
-	grep "^Cc: R E Cipient <rcipient@example.com>,\$" patch5 &&
-	grep "^ *S E Cipient <scipient@example.com>\$" patch5
+	git format-patch --cc="S E Cipient <scipient@example.com>" --stdout master..side >patch5 &&
+	sed -e "/^\$/q" patch5 >hdrs5 &&
+	grep "^Cc: R E Cipient <rcipient@example.com>,\$" hdrs5 &&
+	grep "^ *S E Cipient <scipient@example.com>\$" hdrs5
 '
 
 test_expect_failure 'additional command line cc (rfc822)' '
 	git config --replace-all format.headers "Cc: R E Cipient <rcipient@example.com>" &&
-	git format-patch --cc="S. E. Cipient <scipient@example.com>" --stdout master..side | sed -e "/^\$/q" >patch5 &&
-	grep "^Cc: R E Cipient <rcipient@example.com>,\$" patch5 &&
-	grep "^ *\"S. E. Cipient\" <scipient@example.com>\$" patch5
+	git format-patch --cc="S. E. Cipient <scipient@example.com>" --stdout master..side >patch5 &&
+	sed -e "/^\$/q" patch5 >hdrs5 &&
+	grep "^Cc: R E Cipient <rcipient@example.com>,\$" hdrs5 &&
+	grep "^ *\"S. E. Cipient\" <scipient@example.com>\$" hdrs5
 '
 
 test_expect_success 'command line headers' '
 	git config --unset-all format.headers &&
-	git format-patch --add-header="Cc: R E Cipient <rcipient@example.com>" --stdout master..side | sed -e "/^\$/q" >patch6 &&
-	grep "^Cc: R E Cipient <rcipient@example.com>\$" patch6
+	git format-patch --add-header="Cc: R E Cipient <rcipient@example.com>" --stdout master..side >patch6 &&
+	sed -e "/^\$/q" patch6 >hdrs6 &&
+	grep "^Cc: R E Cipient <rcipient@example.com>\$" hdrs6
 '
 
 test_expect_success 'configuration headers and command line headers' '
 	git config --replace-all format.headers "Cc: R E Cipient <rcipient@example.com>" &&
-	git format-patch --add-header="Cc: S E Cipient <scipient@example.com>" --stdout master..side | sed -e "/^\$/q" >patch7 &&
-	grep "^Cc: R E Cipient <rcipient@example.com>,\$" patch7 &&
-	grep "^ *S E Cipient <scipient@example.com>\$" patch7
+	git format-patch --add-header="Cc: S E Cipient <scipient@example.com>" --stdout master..side >patch7 &&
+	sed -e "/^\$/q" patch7 >hdrs7 &&
+	grep "^Cc: R E Cipient <rcipient@example.com>,\$" hdrs7 &&
+	grep "^ *S E Cipient <scipient@example.com>\$" hdrs7
 '
 
 test_expect_success 'command line To: header (ascii)' '
 	git config --unset-all format.headers &&
-	git format-patch --to="R E Cipient <rcipient@example.com>" --stdout master..side | sed -e "/^\$/q" >patch8 &&
-	grep "^To: R E Cipient <rcipient@example.com>\$" patch8
+	git format-patch --to="R E Cipient <rcipient@example.com>" --stdout master..side >patch8 &&
+	sed -e "/^\$/q" patch8 >hdrs8 &&
+	grep "^To: R E Cipient <rcipient@example.com>\$" hdrs8
 '
 
 test_expect_failure 'command line To: header (rfc822)' '
-	git format-patch --to="R. E. Cipient <rcipient@example.com>" --stdout master..side | sed -e "/^\$/q" >patch8 &&
-	grep "^To: \"R. E. Cipient\" <rcipient@example.com>\$" patch8
+	git format-patch --to="R. E. Cipient <rcipient@example.com>" --stdout master..side >patch8 &&
+	sed -e "/^\$/q" patch8 >hdrs8 &&
+	grep "^To: \"R. E. Cipient\" <rcipient@example.com>\$" hdrs8
 '
 
 test_expect_failure 'command line To: header (rfc2047)' '
-	git format-patch --to="R Ä Cipient <rcipient@example.com>" --stdout master..side | sed -e "/^\$/q" >patch8 &&
-	grep "^To: =?UTF-8?q?R=20=C3=84=20Cipient?= <rcipient@example.com>\$" patch8
+	git format-patch --to="R Ä Cipient <rcipient@example.com>" --stdout master..side >patch8 &&
+	sed -e "/^\$/q" patch8 >hdrs8 &&
+	grep "^To: =?UTF-8?q?R=20=C3=84=20Cipient?= <rcipient@example.com>\$" hdrs8
 '
 
 test_expect_success 'configuration To: header (ascii)' '
 	git config format.to "R E Cipient <rcipient@example.com>" &&
-	git format-patch --stdout master..side | sed -e "/^\$/q" >patch9 &&
-	grep "^To: R E Cipient <rcipient@example.com>\$" patch9
+	git format-patch --stdout master..side >patch9 &&
+	sed -e "/^\$/q" patch9 >hdrs9 &&
+	grep "^To: R E Cipient <rcipient@example.com>\$" hdrs9
 '
 
 test_expect_failure 'configuration To: header (rfc822)' '
 	git config format.to "R. E. Cipient <rcipient@example.com>" &&
-	git format-patch --stdout master..side | sed -e "/^\$/q" >patch9 &&
-	grep "^To: \"R. E. Cipient\" <rcipient@example.com>\$" patch9
+	git format-patch --stdout master..side >patch9 &&
+	sed -e "/^\$/q" patch9 >hdrs9 &&
+	grep "^To: \"R. E. Cipient\" <rcipient@example.com>\$" hdrs9
 '
 
 test_expect_failure 'configuration To: header (rfc2047)' '
 	git config format.to "R Ä Cipient <rcipient@example.com>" &&
-	git format-patch --stdout master..side | sed -e "/^\$/q" >patch9 &&
-	grep "^To: =?UTF-8?q?R=20=C3=84=20Cipient?= <rcipient@example.com>\$" patch9
+	git format-patch --stdout master..side >patch9 &&
+	sed -e "/^\$/q" patch9 >hdrs9 &&
+	grep "^To: =?UTF-8?q?R=20=C3=84=20Cipient?= <rcipient@example.com>\$" hdrs9
 '
 
 # check_patch <patch>: Verify that <patch> looks like a half-sane
@@ -221,76 +234,76 @@ check_patch () {
 }
 
 test_expect_success 'format.from=false' '
-	git -c format.from=false format-patch --stdout master..side |
-	sed -e "/^\$/q" >patch &&
+	git -c format.from=false format-patch --stdout master..side >patch &&
+	sed -e "/^\$/q" patch >hdrs &&
 	check_patch patch &&
-	! grep "^From: C O Mitter <committer@example.com>\$" patch
+	! grep "^From: C O Mitter <committer@example.com>\$" hdrs
 '
 
 test_expect_success 'format.from=true' '
-	git -c format.from=true format-patch --stdout master..side |
-	sed -e "/^\$/q" >patch &&
-	check_patch patch &&
-	grep "^From: C O Mitter <committer@example.com>\$" patch
+	git -c format.from=true format-patch --stdout master..side >patch &&
+	sed -e "/^\$/q" patch >hdrs &&
+	check_patch hdrs &&
+	grep "^From: C O Mitter <committer@example.com>\$" hdrs
 '
 
 test_expect_success 'format.from with address' '
-	git -c format.from="F R Om <from@example.com>" format-patch --stdout master..side |
-	sed -e "/^\$/q" >patch &&
-	check_patch patch &&
-	grep "^From: F R Om <from@example.com>\$" patch
+	git -c format.from="F R Om <from@example.com>" format-patch --stdout master..side >patch &&
+	sed -e "/^\$/q" patch >hdrs &&
+	check_patch hdrs &&
+	grep "^From: F R Om <from@example.com>\$" hdrs
 '
 
 test_expect_success '--no-from overrides format.from' '
-	git -c format.from="F R Om <from@example.com>" format-patch --no-from --stdout master..side |
-	sed -e "/^\$/q" >patch &&
-	check_patch patch &&
-	! grep "^From: F R Om <from@example.com>\$" patch
+	git -c format.from="F R Om <from@example.com>" format-patch --no-from --stdout master..side >patch &&
+	sed -e "/^\$/q" patch >hdrs &&
+	check_patch hdrs &&
+	! grep "^From: F R Om <from@example.com>\$" hdrs
 '
 
 test_expect_success '--from overrides format.from' '
-	git -c format.from="F R Om <from@example.com>" format-patch --from --stdout master..side |
-	sed -e "/^\$/q" >patch &&
-	check_patch patch &&
-	! grep "^From: F R Om <from@example.com>\$" patch
+	git -c format.from="F R Om <from@example.com>" format-patch --from --stdout master..side >patch &&
+	sed -e "/^\$/q" patch >hdrs &&
+	check_patch hdrs &&
+	! grep "^From: F R Om <from@example.com>\$" hdrs
 '
 
 test_expect_success '--no-to overrides config.to' '
 	git config --replace-all format.to \
 		"R E Cipient <rcipient@example.com>" &&
-	git format-patch --no-to --stdout master..side |
-	sed -e "/^\$/q" >patch10 &&
-	check_patch patch10 &&
-	! grep "^To: R E Cipient <rcipient@example.com>\$" patch10
+	git format-patch --no-to --stdout master..side >patch10 &&
+	sed -e "/^\$/q" patch10 >hdrs10 &&
+	check_patch hdrs10 &&
+	! grep "^To: R E Cipient <rcipient@example.com>\$" hdrs10
 '
 
 test_expect_success '--no-to and --to replaces config.to' '
 	git config --replace-all format.to \
 		"Someone <someone@out.there>" &&
 	git format-patch --no-to --to="Someone Else <else@out.there>" \
-		--stdout master..side |
-	sed -e "/^\$/q" >patch11 &&
-	check_patch patch11 &&
-	! grep "^To: Someone <someone@out.there>\$" patch11 &&
-	grep "^To: Someone Else <else@out.there>\$" patch11
+		--stdout master..side >patch11 &&
+	sed -e "/^\$/q" patch11 >hdrs11 &&
+	check_patch hdrs11 &&
+	! grep "^To: Someone <someone@out.there>\$" hdrs11 &&
+	grep "^To: Someone Else <else@out.there>\$" hdrs11
 '
 
 test_expect_success '--no-cc overrides config.cc' '
 	git config --replace-all format.cc \
 		"C E Cipient <rcipient@example.com>" &&
-	git format-patch --no-cc --stdout master..side |
-	sed -e "/^\$/q" >patch12 &&
-	check_patch patch12 &&
-	! grep "^Cc: C E Cipient <rcipient@example.com>\$" patch12
+	git format-patch --no-cc --stdout master..side >patch12 &&
+	sed -e "/^\$/q" patch12 >hdrs12 &&
+	check_patch hdrs12 &&
+	! grep "^Cc: C E Cipient <rcipient@example.com>\$" hdrs12
 '
 
 test_expect_success '--no-add-header overrides config.headers' '
 	git config --replace-all format.headers \
 		"Header1: B E Cipient <rcipient@example.com>" &&
-	git format-patch --no-add-header --stdout master..side |
-	sed -e "/^\$/q" >patch13 &&
-	check_patch patch13 &&
-	! grep "^Header1: B E Cipient <rcipient@example.com>\$" patch13
+	git format-patch --no-add-header --stdout master..side >patch13 &&
+	sed -e "/^\$/q" patch13 >hdrs13 &&
+	check_patch hdrs13 &&
+	! grep "^Header1: B E Cipient <rcipient@example.com>\$" hdrs13
 '
 
 test_expect_success 'multiple files' '
@@ -808,20 +821,25 @@ test_expect_success 'format-patch --ignore-if-in-upstream HEAD' '
 	git format-patch --ignore-if-in-upstream HEAD
 '
 
-git_version="$(git --version | sed "s/.* //")"
+test_expect_success 'get git version' '
+	git_version=$(git --version) &&
+	git_version=${git_version##* }
+'
 
 signature() {
 	printf "%s\n%s\n\n" "-- " "${1:-$git_version}"
 }
 
 test_expect_success 'format-patch default signature' '
-	git format-patch --stdout -1 | tail -n 3 >output &&
+	git format-patch --stdout -1 >patch &&
+	tail -n 3 patch >output &&
 	signature >expect &&
 	test_cmp expect output
 '
 
 test_expect_success 'format-patch --signature' '
-	git format-patch --stdout --signature="my sig" -1 | tail -n 3 >output &&
+	git format-patch --stdout --signature="my sig" -1 >patch &&
+	tail -n 3 patch >output &&
 	signature "my sig" >expect &&
 	test_cmp expect output
 '
@@ -1606,19 +1624,40 @@ test_expect_success 'format-patch -o overrides format.outputDirectory' '
 
 test_expect_success 'format-patch --base' '
 	git checkout patchid &&
-	git format-patch --stdout --base=HEAD~3 -1 | tail -n 7 >actual1 &&
-	git format-patch --stdout --base=HEAD~3 HEAD~.. | tail -n 7 >actual2 &&
+
+	git format-patch --stdout --base=HEAD~3 -1 >patch &&
+	tail -n 7 patch >actual1 &&
+
+	git format-patch --stdout --base=HEAD~3 HEAD~.. >patch &&
+	tail -n 7 patch >actual2 &&
+
 	echo >expect &&
-	echo "base-commit: $(git rev-parse HEAD~3)" >>expect &&
-	echo "prerequisite-patch-id: $(git show --patch HEAD~2 | git patch-id --stable | awk "{print \$1}")" >>expect &&
-	echo "prerequisite-patch-id: $(git show --patch HEAD~1 | git patch-id --stable | awk "{print \$1}")" >>expect &&
+	git rev-parse HEAD~3 >commit-id-base &&
+	echo "base-commit: $(cat commit-id-base)" >>expect &&
+
+	git show --patch HEAD~2 >patch &&
+	git patch-id --stable <patch >patch.id.raw &&
+	awk "{print \"prerequisite-patch-id:\", \$1}" <patch.id.raw >>expect &&
+
+	git show --patch HEAD~1 >patch &&
+	git patch-id --stable <patch >patch.id.raw &&
+	awk "{print \"prerequisite-patch-id:\", \$1}" <patch.id.raw >>expect &&
+
 	signature >>expect &&
 	test_cmp expect actual1 &&
 	test_cmp expect actual2 &&
+
 	echo >fail &&
-	echo "base-commit: $(git rev-parse HEAD~3)" >>fail &&
-	echo "prerequisite-patch-id: $(git show --patch HEAD~2 | git patch-id --unstable | awk "{print \$1}")" >>fail &&
-	echo "prerequisite-patch-id: $(git show --patch HEAD~1 | git patch-id --unstable | awk "{print \$1}")" >>fail &&
+	echo "base-commit: $(cat commit-id-base)" >>fail &&
+
+	git show --patch HEAD~2 >patch &&
+	git patch-id --unstable <patch >patch.id.raw &&
+	awk "{print \"prerequisite-patch-id:\", \$1}" <patch.id.raw >>fail &&
+
+	git show --patch HEAD~1 >patch &&
+	git patch-id --unstable <patch >patch.id.raw &&
+	awk "{print \"prerequisite-patch-id:\", \$1}" <patch.id.raw >>fail &&
+
 	signature >>fail &&
 	! test_cmp fail actual1 &&
 	! test_cmp fail actual2
@@ -1629,7 +1668,8 @@ test_expect_success 'format-patch --base errors out when base commit is in revis
 	test_must_fail git format-patch --base=HEAD~1 -2 &&
 	git format-patch --stdout --base=HEAD~2 -2 >patch &&
 	grep "^base-commit:" patch >actual &&
-	echo "base-commit: $(git rev-parse HEAD~2)" >expect &&
+	git rev-parse HEAD~2 >commit-id-base &&
+	echo "base-commit: $(cat commit-id-base)" >expect &&
 	test_cmp expect actual
 '
 
@@ -1668,7 +1708,8 @@ test_expect_success 'format-patch --base=auto' '
 	test_commit N2 &&
 	git format-patch --stdout --base=auto -2 >patch &&
 	grep "^base-commit:" patch >actual &&
-	echo "base-commit: $(git rev-parse upstream)" >expect &&
+	git rev-parse upstream >commit-id-base &&
+	echo "base-commit: $(cat commit-id-base)" >expect &&
 	test_cmp expect actual
 '
 
@@ -1705,7 +1746,8 @@ test_expect_success 'format-patch format.useAutoBaseoption' '
 	git config format.useAutoBase true &&
 	git format-patch --stdout -1 >patch &&
 	grep "^base-commit:" patch >actual &&
-	echo "base-commit: $(git rev-parse upstream)" >expect &&
+	git rev-parse upstream >commit-id-base &&
+	echo "base-commit: $(cat commit-id-base)" >expect &&
 	test_cmp expect actual
 '
 
@@ -1714,7 +1756,8 @@ test_expect_success 'format-patch --base overrides format.useAutoBase' '
 	git config format.useAutoBase true &&
 	git format-patch --stdout --base=HEAD~1 -1 >patch &&
 	grep "^base-commit:" patch >actual &&
-	echo "base-commit: $(git rev-parse HEAD~1)" >expect &&
+	git rev-parse HEAD~1 >commit-id-base &&
+	echo "base-commit: $(cat commit-id-base)" >expect &&
 	test_cmp expect actual
 '
 
-- 
2.23.0.248.g3a9dd8fb08

