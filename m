Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51A721F42D
	for <e@80x24.org>; Mon, 21 May 2018 07:07:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751058AbeEUHHJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 03:07:09 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:55008 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750898AbeEUHHJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 03:07:09 -0400
Received: by mail-wm0-f54.google.com with SMTP id f6-v6so23466695wmc.4
        for <git@vger.kernel.org>; Mon, 21 May 2018 00:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=DCajXhrMKlRmOVMwLyR+AOBe69wqt6GgZMqBp2499VI=;
        b=Pdhqs0QMFebUM1DABtBAH5p9SJLjScaOEFbmMFETth/jy2UJGGeYViANIWXJb8i4DG
         WQ1hML9NvN0MIlR0oWGtWQwzIV06ATw0pUzmXRm1bzIFcg3eAjCFnzX1PiOOnk9p2GdR
         ZdEak4Ud4Bzlvrndm+8aJ9I1sUbazzsUkC+B74E2F+yICam9EvXy1gaxVnp9x0XCH5HA
         V8nUWP5zrTBgKqIg6he1icb9sVJoZmzWZbb+IuLPV/eVIrPURIYcZx0mqtigZGE7i1Cg
         rSO9abuYKSw8hZV9yHy5uJ+Fh+zdDyBWqC3gYaH1f8GKzVcljRo+x68S8yesqxLnac/X
         0ekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=DCajXhrMKlRmOVMwLyR+AOBe69wqt6GgZMqBp2499VI=;
        b=Fvr7bUjFzkM2Z1Ndc+0moltyIBx8NPRx0aCxA2vs768GK480H4ToW7wrGsIWw96Z6s
         DjkfGXqi0kF6EBjBmsbOj3s4OKXLe8yeOfVuMgbmMdTZpW4l7iiMajaio6Y36evRd+j+
         h8ZCWjRndH+7vOrAwDn42ib6UcnVGeUQGWyclfGFPeTvyjCiXOFaaO5eXxuV8+3hoX30
         p5dKcXn98XogBEOk2N6RTtkA/GFyyfx4qvXHHcYPdZfuzOOIS/DFnpPifxP8oJaBl4bu
         yj4H9s75NXpIxgI3Dvj+rO78hXNudjNenmAiPjDpgcUcHFHnbCX/21dOa9ErkKM/csbJ
         zJbg==
X-Gm-Message-State: ALKqPwfIqpQU/c1G7k3xyzOMJEdAUCGgMiYFsz6a/L/PEEaYPB4xyPu/
        DNGePe0DqaR6xGDxL17z+V9V/Zto
X-Google-Smtp-Source: AB8JxZpAN9rCO4xerXZfLYA4CYaCv/SS8pY3uLDDhaVfLJxUdLhWo5xJAuHYr0KHiNxfEQbB4tMjkg==
X-Received: by 2002:a1c:8583:: with SMTP id h125-v6mr9400496wmd.98.1526886427587;
        Mon, 21 May 2018 00:07:07 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id m69-v6sm25979910wmd.47.2018.05.21.00.07.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 May 2018 00:07:06 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Luke Diamand <luke@diamand.org>, git@vger.kernel.org,
        Romain Merland <merlorom@yahoo.fr>,
        Miguel Torroja <miguel.torroja@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        George Vanburgh <gvanburgh@bloomberg.net>
Subject: Re: [PATCHv4 1/1] git-p4: add unshelve command
References: <20180520144916.5064-1-szeder.dev@gmail.com>
Date:   Mon, 21 May 2018 16:07:06 +0900
In-Reply-To: <20180520144916.5064-1-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Sun, 20 May 2018 16:49:16 +0200")
Message-ID: <xmqqd0xp1o85.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

>> diff --git a/t/t9832-unshelve.sh b/t/t9832-unshelve.sh
>> new file mode 100755
>> index 0000000000..cca2dec536

... in short, I'd queue a fix-up on top like this to be later
squashed after getting an ack?

 t/t9832-unshelve.sh | 23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/t/t9832-unshelve.sh b/t/t9832-unshelve.sh
index cca2dec536..3513abd21a 100755
--- a/t/t9832-unshelve.sh
+++ b/t/t9832-unshelve.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-last_shelved_change() {
+last_shelved_change () {
 	p4 changes -s shelved -m1 | cut -d " " -f 2
 }
 
@@ -17,7 +17,7 @@ test_expect_success 'init depot' '
 		cd "$cli" &&
 		echo file1 >file1 &&
 		p4 add file1 &&
-		p4 submit -d "change 1"
+		p4 submit -d "change 1" &&
 		: >file_to_delete &&
 		p4 add file_to_delete &&
 		p4 submit -d "file to delete"
@@ -120,29 +120,14 @@ EOF
 	)
 '
 
-diff_adds_line() {
-	text="$1" &&
-	file="$2" &&
-	grep -q "^+$text" $file || (echo "expected \"text\" $text not found in $file" && exit 1)
-}
-
-diff_excludes_line() {
-	text="$1" &&
-	file="$2" &&
-	if grep -q "^+$text" $file; then
-		echo "unexpected text \"$text\" found in $file" &&
-		exit 1
-	fi
-}
-
 # Now try to unshelve it. git-p4 should refuse to do so.
 test_expect_success 'try to unshelve the change' '
 	test_when_finished cleanup_git &&
 	(
 		change=$(last_shelved_change) &&
 		cd "$git" &&
-		! git p4 unshelve $change >out.txt 2>&1 &&
-		grep -q "cannot unshelve" out.txt
+		test_must_fail git p4 unshelve $change 2>err.txt &&
+		grep -q "cannot unshelve" err.txt
 	)
 '
 
