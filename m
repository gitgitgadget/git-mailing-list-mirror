Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09EA41F954
	for <e@80x24.org>; Thu, 23 Aug 2018 15:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbeHWTXc (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 15:23:32 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54202 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbeHWTXc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 15:23:32 -0400
Received: by mail-wm0-f66.google.com with SMTP id s9-v6so5711768wmh.3
        for <git@vger.kernel.org>; Thu, 23 Aug 2018 08:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=ZzDfdym39C29MLJHr2UVgjpU13LagEFpJzeno5cNRf8=;
        b=gSo5qf4FXwyGfwwj9L2NKKkTVIWiGM6AwXVlcynhLBBNFTWzWvKw89MxcFrstX3XFO
         udW02uKoUU1TIovgHxwZMhojrG92OIaIn7wRqjz92twU3aktOSGguHwuEYVoUc7TwqHz
         Ft9dLhAvfUCWkWRjNURzWdMIFIePuq+eufpCcds2FZYrkg9KgWMmCzdThErACRjYzZmC
         Kgu3UcHr2HjsS/ai59M4tE+qt1xOwU1HRYOr0mcTurDLTGLDtG+oF2bcPBp1sz3ALpsD
         DOv7/QdM36deykd3t96ZEDKWtY8pAwwhf8BuuDq0X2JH8s2aOSQerh9LhP8hjf3ucjcV
         UAXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=ZzDfdym39C29MLJHr2UVgjpU13LagEFpJzeno5cNRf8=;
        b=Gmm7IN/qVwVg1vBLbjB3IvfBLsW6xpeE+vlJ9PK8FcphRYGCMqmle2pRvGDtHuLxQU
         RXFFnWeds0rw6FyHc9T12p6huO00mxqSEuRgIzJ2cLVD63AHg0od2U4/9ZLAhwELrdSd
         st5pwyo1Bpgp/emdL8VFL2gqKs23Motg7dNxR5Eh0wVhFtrrkv+wTEPXG87huUxahLJG
         rprFI70L2b+u2wDDbqtnM9s13ahh1PozoOFDE+f6nkYyFcAYyFY1EZQAzxPfGGGS0kJF
         bVoKwGZn1LO9T3BduDL9YgHuXnDqhROX2oYsfROOClPxedrASV5sVvffWZiCbLN0vDPQ
         8QNg==
X-Gm-Message-State: APzg51AsPLKkA4lxQlgAKcnPt8UfX/8oEPjGJrI/u4wu6F68yhD2mSra
        lw8n8tremyxLOcExiaxq3KsPIAWe
X-Google-Smtp-Source: ANB0VdZ6qsatuk5Zx0NV34bK1xPwLE7UKfZJ0/jQOHiJKmi1U+/yjJ+vhQDI/BNjpl3QgYyEXTC9PA==
X-Received: by 2002:a1c:9c56:: with SMTP id f83-v6mr5330325wme.135.1535039595209;
        Thu, 23 Aug 2018 08:53:15 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 185-v6sm6366271wmy.38.2018.08.23.08.53.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Aug 2018 08:53:14 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Benoit Lecocq <benoit@openbsd.org>, kn@openbsd.org,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: Test failures on OpenBSD
References: <87a7pdfltp.fsf@evledraar.gmail.com>
Date:   Thu, 23 Aug 2018 08:53:14 -0700
In-Reply-To: <87a7pdfltp.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Thu, 23 Aug 2018 11:56:18 +0200")
Message-ID: <xmqqin41jd05.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

>     + echo Error (-1) reading configuration file a-directory.
>     + > expect 
>     + mkdir a-directory
>     + test_expect_code 2 test-tool config configset_get_value foo.bar a-directory
>     + 2> output 
>     Value not found for "foo.bar"
>     test_expect_code: command exited with 1, we wanted 2 test-tool config configset_get_value foo.bar a-directory
>     error: last command exited with $?=1
>     not ok 23 - proper error on directory "files"

A blind guess.  is this "BSD allows opening a FILE* on a directory
and reading bytes from it" aka FREAD_READS_DIRECTORIES?

I wonder why FreeBSD sets it but not OpenBSD in config.mak.uname.

>     + make_dir extract
>     + tar xf subtree-all.tar -C extract
>     tar: Cannot identify format. Searching...
>     tar: End of archive volume 1 reached
>     tar: Sorry, unable to determine archive format.
>     error: last command exited with $?=1

Perhaps modern tar elements like extended headers are not supported
on the platform-supplied "tar"?  "make TAR=gnutar"?

>     + seq 11
>     ./t5552-skipping-fetch-negotiator.sh: seq: not found

This must use test_seq.

 t/t5552-skipping-fetch-negotiator.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t5552-skipping-fetch-negotiator.sh b/t/t5552-skipping-fetch-negotiator.sh
index 5ad5bece55..30857b84a8 100755
--- a/t/t5552-skipping-fetch-negotiator.sh
+++ b/t/t5552-skipping-fetch-negotiator.sh
@@ -46,7 +46,7 @@ test_expect_success 'commits with no parents are sent regardless of skip distanc
 	test_commit -C server to_fetch &&
 
 	git init client &&
-	for i in $(seq 7)
+	for i in $(test_seq 7)
 	do
 		test_commit -C client c$i
 	done &&
@@ -89,7 +89,7 @@ test_expect_success 'when two skips collide, favor the larger one' '
 	test_commit -C server to_fetch &&
 
 	git init client &&
-	for i in $(seq 11)
+	for i in $(test_seq 11)
 	do
 		test_commit -C client c$i
 	done &&
@@ -168,14 +168,14 @@ test_expect_success 'do not send "have" with ancestors of commits that server AC
 	test_commit -C server to_fetch &&
 
 	git init client &&
-	for i in $(seq 8)
+	for i in $(test_seq 8)
 	do
 		git -C client checkout --orphan b$i &&
 		test_commit -C client b$i.c0
 	done &&
-	for j in $(seq 19)
+	for j in $(test_seq 19)
 	do
-		for i in $(seq 8)
+		for i in $(test_seq 8)
 		do
 			git -C client checkout b$i &&
 			test_commit -C client b$i.c$j
@@ -205,7 +205,7 @@ test_expect_success 'do not send "have" with ancestors of commits that server AC
 
 	# fetch-pack should thus not send any more commits in the b1 branch, but
 	# should still send the others (in this test, just check b2).
-	for i in $(seq 0 8)
+	for i in $(test_seq 0 8)
 	do
 		have_not_sent b1.c$i
 	done &&
