Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18EB620193
	for <e@80x24.org>; Mon, 24 Oct 2016 22:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757389AbcJXWda (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Oct 2016 18:33:30 -0400
Received: from mout.web.de ([212.227.17.12]:57434 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753002AbcJXWd2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2016 18:33:28 -0400
Received: from [192.168.178.36] ([79.197.211.11]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0Lvjn6-1czT8S2exY-017Uwf; Tue, 25 Oct 2016 00:33:08
 +0200
Subject: Re: [PATCH] hex: use unsigned index for ring buffer
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <ebf769d4-771f-499e-c7fc-f0377d8df18e@web.de>
 <20161023091146.p2kmqvgwxdf77dnn@sigill.intra.peff.net>
 <fb816dd5-8fb9-c6a6-2ec2-9ea4dddfdb26@web.de>
 <20161024130015.awlmgpfzixiy6wkb@sigill.intra.peff.net>
 <xmqqwpgx7jn6.fsf@gitster.mtv.corp.google.com>
 <xmqqshrl7j42.fsf@gitster.mtv.corp.google.com>
Cc:     Git List <git@vger.kernel.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <b1f9054e-fadb-c2d3-bf95-00e88e1fb85b@web.de>
Date:   Tue, 25 Oct 2016 00:33:03 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqshrl7j42.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:TLDUhum+CVLOeiMVNPY4We/sJOxs7vyh7IF4/gnvDKkgUzuSVZq
 s46IOJGFRQaIZrbB+b82y4OBO1Fe2Qa/xJ/fg5NX8jgMiwlGt3JhNv6KMSt6au/8PK6EHCA
 nqCx6IxUpA74vyA04L5YpXTXXRLdAC2A+wligUGjm6mMc7qF2eo8xEyVRNGaSN9b6tOSMop
 2fsfR0R4ahFT3OgcQqD1w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:L58TbXS87k0=:F6xtQegsXvf4T0wjMi5kV+
 iny7W3M4fLs81PHT+MSbdzdHyI4g0CSn8EMFWnPTX7wR2v0GTiJJysportqSkuDwMIHW6I9ul
 vGWdf1lKpf640nbjIfg1rVKNZZumHNwwnBMwt5xWN9XdtiBAHtCrRBdd27Yo+yqD14tsFnmaD
 3vT12MtQOXRQc9C2eNStj0DSMw24QnHbHGgxBoKxTD/778cjB4r/0u9yPsR33zvqSBQd7BrSt
 fTA5D+DepaF5Lpb3QcjqReBNaP0aSkaJEH3C16bxtGCluml+46R4FPJVbf6TuR4zoJWX3bNDL
 Xt5kmmpadUfyly0P/06yjLufuv3tf6HnR0zPqBzttksZACPJGzO5ick40DazDvGujN2IxZ/IK
 KQMtE7P7SIgfCaxrzbZpFfZYQY5q46uONYSOjvxT2fqUpo1alISZuqReKJheNWsAFWoCNJwHa
 WvLOqtbYpO1dXGfqQef1NEzhBT/02RVoXsXSGSlIV9TVhU2SXMH6+QpQptgnJl2Jl6LmUvz8u
 qQRk1fA/6yP5/+ZAsQMaQbuNEsggUkKOvzDbEJlRoAMJprZu6jsIengPjblmQMBHq+RXKY8bu
 h/YK6f0llGxpsnOcYAFibBOd50S/job5w5egNqx5t9/FZa44mPobRwNDuRWro6pD3jJAfHs0g
 GvBmQI3vFYsMRm3SofRQ0eLoYPVlaLogaKWyLBelSAPnw7iZEMHAm9zqfcI8zNIaVHEAjcrul
 CIdKR5EcFLBdLjORiC4PqUxq1DvzMr0LM/NUOXcQr5UhzYhfnRBojuDDprTYy/fBECAr75+u2
 w6o/3vO
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 24.10.2016 um 19:27 schrieb Junio C Hamano:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>>> I think it would be preferable to just fix it inline in each place.
>>
>> Yeah, probably.
>>
>> My initial reaction to this was
>>
>>  char *sha1_to_hex(const unsigned char *sha1)
>>  {
>> -	static int bufno;
>> +	static unsigned int bufno;
>>  	static char hexbuffer[4][GIT_SHA1_HEXSZ + 1];
>>  	return sha1_to_hex_r(hexbuffer[3 & ++bufno], sha1);
>>
>> "ah, we do not even need bufno as uint; it could be ushort or even
>> uchar".  If this were a 256 element ring buffer and the index were
>> uchar, we wouldn't even be having this discussion, and "3 &" is a
>> way to get a fake type that is a 2-bit unsigned integer that wraps
>> around when incremented.
>>
>> But being explicit, especially when we know that we can rely on the
>> fact that the compilers are usually intelligent enough, is a good
>> idea, I would think.
>>
>> Isn't size_t often wider than uint, by the way?  It somehow makes me
>> feel dirty to use it when we know we only care about the bottom two
>> bit, especially with the explicit "bufno %= ARRAY_SIZE(hexbuffer)",
>> but I may be simply superstitious in this case.  I dunno.
> 
> If we are doing the wrap-around ourselves, I suspect that the index
> should stay "int" (not even unsigned), as that is supposed to be the
> most natural and performant type on the architecture.  Would it
> still result in better code to use size_t instead?

Right.

Gcc emits an extra cltq instruction for x86-64 (Convert Long To Quad,
i.e. 32-bit to 64-bit) if we wrap explicitly and still use an int in
sha1_to_hex().  It doesn't if we use an unsigned int or size_t.  It
also doesn't for get_pathname().  I guess updating the index variable
only after use makes the difference there.

But I think we can ignore that; it's just an extra cycle.  I only
even noticed it when verifying that "% 4" is turned into "& 3"..
Clang and icc don't add the cltq, by the way.

So how about this?  It gets rid of magic number 3 and works for array
size that's not a power of two.  And as a nice side effect it can't
trigger a signed overflow anymore.

Just adding "unsigned" looks more attractive to me for some reason.
Perhaps I stared enough at the code to get used to the magic values
there..

René

---
 hex.c  | 3 ++-
 path.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/hex.c b/hex.c
index ab2610e..845b01a 100644
--- a/hex.c
+++ b/hex.c
@@ -78,7 +78,8 @@ char *sha1_to_hex(const unsigned char *sha1)
 {
 	static int bufno;
 	static char hexbuffer[4][GIT_SHA1_HEXSZ + 1];
-	return sha1_to_hex_r(hexbuffer[3 & ++bufno], sha1);
+	bufno = (bufno + 1) % ARRAY_SIZE(hexbuffer);
+	return sha1_to_hex_r(hexbuffer[bufno], sha1);
 }
 
 char *oid_to_hex(const struct object_id *oid)
diff --git a/path.c b/path.c
index a8e7295..52d889c 100644
--- a/path.c
+++ b/path.c
@@ -25,7 +25,8 @@ static struct strbuf *get_pathname(void)
 		STRBUF_INIT, STRBUF_INIT, STRBUF_INIT, STRBUF_INIT
 	};
 	static int index;
-	struct strbuf *sb = &pathname_array[3 & ++index];
+	struct strbuf *sb = &pathname_array[index];
+	index = (index + 1) % ARRAY_SIZE(pathname_array);
 	strbuf_reset(sb);
 	return sb;
 }
-- 
2.10.1
