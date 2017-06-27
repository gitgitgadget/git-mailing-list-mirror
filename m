Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A45F20401
	for <e@80x24.org>; Tue, 27 Jun 2017 17:04:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752526AbdF0REK (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 13:04:10 -0400
Received: from mout.web.de ([212.227.15.14]:53313 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752795AbdF0REH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 13:04:07 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M3Spk-1dhQij2tzk-00r2jn; Tue, 27
 Jun 2017 19:03:49 +0200
Subject: Re: [PATCH 2/2] apply: handle assertion failure gracefully
To:     Vegard Nossum <vegard.nossum@oracle.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Michal Zalewski <lcamtuf@google.com>
References: <20170225101307.24067-1-vegard.nossum@oracle.com>
 <20170225101307.24067-2-vegard.nossum@oracle.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <ef6886c0-d567-ced1-3caf-98bd5557c580@web.de>
Date:   Tue, 27 Jun 2017 19:03:47 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170225101307.24067-2-vegard.nossum@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:pcgHkN9m9mG7ITACO9DGv3Uzym/vOIN0w3W4+vTVeHzsYjneHhS
 yIPbuirEj6UVSa9z8/VIGkXWzGo4i3kUr5tJZHZcpXeSja+PztiBeulb9ENpdGXzZ5s3+zY
 R5rxP6kdI8VD/fmT4VR9Ba0wvX/rEYqi5xBe5jDSDua41teBsXsm/5MUKW1istDZuPpy0r3
 3DYQFalxsRmf5jso8c3AQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:SxQ640hFZWU=:DszTMeG/3/OwExvx3q3yPf
 rZ5XuM2uodH8DS7cIAttAP/a8Z36hBLgvP1/XpR/KgceWkxsel9r6MgOIWD6Bp+Rh7u1AykK2
 XxXV6dbU2sS2qrXGwiwHuChTgI+q9BOL5qB8jjmYP6FmI1l6aagel1651EN1eMD3XG4PtltVn
 uk8Md2y69JSrKiRHfFNjIUkJ1ZXRU+rkPNnrsYXxMUjp5AVfwCnhysaeonXcg/qvOkjyGte4J
 Z0yuqD0PhkPO6JBzPMimJ2bBmgsK3131nsvdyoSI1N0veGwbKQmIfLDRevKv4bT0BHpggIpyy
 1+jbckRwGqgfSInbup26DOzk5gqqRl3hi2krKJMPtXoLyFG+9zCaMFz+U9+g6tuB3rEkYoJox
 /stch83H0CKymXfW4nHjXQUodikIpD9Yh7zdM1hwIztUyCUsQmxhGMx/Fjj6iTXqP8V+d3ciz
 wsPULzzB6asaULxvYt3HRDnPNAF3O6T5aU8apxJoKCS5UZLCD5qbrWejQrffVMCwzh17yRFI5
 DeS6bE1LKZjpBtJtznlisLe5tsgVCKvRQfTvi9B2W9N2rVHR3vVOBefPNHRv5mATN/0pKng12
 TbMsJgvuPZ32VQDNnYfEmIR9+oJUbCjGhV2eDYVf7VlBZ6yzL3mzlozbU5bubL3+HXpYd4bUY
 K92kafRBG1qg9ntGAxgFZbt6Sr2RbFRtkjwnnSDLIq46C2xuXnr8YxrNklSYT/915+H5Uy0UD
 MTc2k4Vj5/ZRlrmJ0VO+2u6Uu4Fjjn1SDwNAZWsXo3B2HzeUZAkJacK17oQKJRM+DbyUTrCkR
 M4/5Axl
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 25.02.2017 um 11:13 schrieb Vegard Nossum:
> For the patches in the added testcases, we were crashing with:
> 
>      git-apply: apply.c:3665: check_preimage: Assertion `patch->is_new <= 0' failed.


> diff --git a/t/t4154-apply-git-header.sh b/t/t4154-apply-git-header.sh
> index d651af4a2..c440c48ad 100755
> --- a/t/t4154-apply-git-header.sh
> +++ b/t/t4154-apply-git-header.sh
> @@ -12,4 +12,40 @@ rename new 0
>   EOF
>   '
>   
> +test_expect_success 'apply deleted file mode / new file mode / wrong mode' '
> +	test_must_fail git apply << EOF
> +diff --git a/. b/.
> +deleted file mode
> +new file mode
> +EOF
> +'

-- >8 --
Subject: [PATCH] apply: check git diffs for invalid file modes

An empty string as mode specification is accepted silently by git apply,
as Vegard Nossum found out using AFL.  It's interpreted as zero.  Reject
such bogus file modes, and only accept ones consisting exclusively of
octal digits.

Reported-by: Vegard Nossum <vegard.nossum@oracle.com>
Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 apply.c                   | 17 ++++++++++++-----
 t/t4129-apply-samemode.sh | 16 +++++++++++++++-
 2 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/apply.c b/apply.c
index 8a5e44c474..db38bc3cdd 100644
--- a/apply.c
+++ b/apply.c
@@ -1001,20 +1001,27 @@ static int gitdiff_newname(struct apply_state *state,
 				   DIFF_NEW_NAME);
 }
 
+static int parse_mode_line(const char *line, int linenr, unsigned int *mode)
+{
+	char *end;
+	*mode = strtoul(line, &end, 8);
+	if (end == line || !isspace(*end))
+		return error(_("invalid mode on line %d: %s"), linenr, line);
+	return 0;
+}
+
 static int gitdiff_oldmode(struct apply_state *state,
 			   const char *line,
 			   struct patch *patch)
 {
-	patch->old_mode = strtoul(line, NULL, 8);
-	return 0;
+	return parse_mode_line(line, state->linenr, &patch->old_mode);
 }
 
 static int gitdiff_newmode(struct apply_state *state,
 			   const char *line,
 			   struct patch *patch)
 {
-	patch->new_mode = strtoul(line, NULL, 8);
-	return 0;
+	return parse_mode_line(line, state->linenr, &patch->new_mode);
 }
 
 static int gitdiff_delete(struct apply_state *state,
@@ -1128,7 +1135,7 @@ static int gitdiff_index(struct apply_state *state,
 	memcpy(patch->new_sha1_prefix, line, len);
 	patch->new_sha1_prefix[len] = 0;
 	if (*ptr == ' ')
-		patch->old_mode = strtoul(ptr+1, NULL, 8);
+		return gitdiff_oldmode(state, ptr + 1, patch);
 	return 0;
 }
 
diff --git a/t/t4129-apply-samemode.sh b/t/t4129-apply-samemode.sh
index c268298eaf..5cdd76dfa7 100755
--- a/t/t4129-apply-samemode.sh
+++ b/t/t4129-apply-samemode.sh
@@ -13,7 +13,9 @@ test_expect_success setup '
 	echo modified >file &&
 	git diff --stat -p >patch-0.txt &&
 	chmod +x file &&
-	git diff --stat -p >patch-1.txt
+	git diff --stat -p >patch-1.txt &&
+	sed "s/^\(new mode \).*/\1/" <patch-1.txt >patch-empty-mode.txt &&
+	sed "s/^\(new mode \).*/\1garbage/" <patch-1.txt >patch-bogus-mode.txt
 '
 
 test_expect_success FILEMODE 'same mode (no index)' '
@@ -59,4 +61,16 @@ test_expect_success FILEMODE 'mode update (index only)' '
 	git ls-files -s file | grep "^100755"
 '
 
+test_expect_success FILEMODE 'empty mode is rejected' '
+	git reset --hard &&
+	test_must_fail git apply patch-empty-mode.txt 2>err &&
+	test_i18ngrep "invalid mode" err
+'
+
+test_expect_success FILEMODE 'bogus mode is rejected' '
+	git reset --hard &&
+	test_must_fail git apply patch-bogus-mode.txt 2>err &&
+	test_i18ngrep "invalid mode" err
+'
+
 test_done
-- 
2.13.2
