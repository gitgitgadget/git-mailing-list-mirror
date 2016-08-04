Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6ECB1F855
	for <e@80x24.org>; Thu,  4 Aug 2016 21:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932387AbcHDV5G (ORCPT <rfc822;e@80x24.org>);
	Thu, 4 Aug 2016 17:57:06 -0400
Received: from mout.web.de ([212.227.15.3]:53085 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758985AbcHDV5E (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2016 17:57:04 -0400
Received: from [192.168.178.36] ([79.213.122.241]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0MFNpM-1bS5763ZJc-00EMbn; Thu, 04 Aug 2016 23:56:56
 +0200
Subject: Re: [PATCH 2/2] nedmalloc: work around overzealous GCC 6 warning
To:	Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
References: <cover.1470326812.git.johannes.schindelin@gmx.de>
 <57360f4885bdd5c36e190bea288f1e1f7f706071.1470326812.git.johannes.schindelin@gmx.de>
Cc:	Junio C Hamano <gitster@pobox.com>
From:	=?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <57A3BA26.5080601@web.de>
Date:	Thu, 4 Aug 2016 23:56:54 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
MIME-Version: 1.0
In-Reply-To: <57360f4885bdd5c36e190bea288f1e1f7f706071.1470326812.git.johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:abGg7xNLWD/uB6sgs+aMp9ADDC9ynfo1ptr+uqfwqj7O4YCqZ8J
 lwejOGqGbrMvxGgyUuJd9/T/LVYZi+OvmKFmd+8mk22+gI+/HEqW+vNGcCo0JKfmdPvCWmS
 MmJDMjQSglfoyVW7fJMro3/+aqMWXvVkRR8pNCIuHZBdQLkYqxl8oFQKMb6/5EsvV7ECQWZ
 bXRNQ2xhneFJsz8UtebSQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:CM9cSpwFT3U=:4Xbiq/48bYdyrSbZKMApPR
 OdrLhLK2+/Bm+cXY9g2S3MSiGeC+OR/v5MzBa97uSwCoTVSkyV+0JxkTJ8HG0ryfHTH+6Vqpw
 NfdaAJ5UoG3ZoKtT/mhvaNMuaAsSv7ZZ0+QJ1lU8b7BLTMb2YzyuVDc/qxpOdhT4DoGtACZMC
 pV6NAYanaiFKTo2VLz7PEBPsbpU0ByjsyVqQnByPKYlrJfapYx2G5QLm7wXBRDTxbOQkiRNg4
 QaKyCTtS+Cm5LLaq2XmtO7e0RHk34pRUnQ374LfWitLj9ZCaiKemgm2mD7QXmFAA98AeNWQJ/
 QwCTlzj+M9/0CJch7zzLHS4y93TcO7nKy2OXcWDiu8nwfNhrNtoGcnlFHfnZXLcc2KVwS2d+b
 xStM+Xn3GMg2XgI3FbwRa5wMyCZGeUEM6Rp8HnzqEj+hB/7ky2M7aUDcHNqD/M97A82/1/gGK
 KI+38TivnJilsIrqlSKc7LYfvKhfQXVY8q8VXS5wvzzzNTSEyyInMp3Bu/beCgMxUOErNi10/
 cybOSY9wai8n4iycPDeq+a1LxiPt8olbk77ggFGUHdQ/6CRMuWZ+KJKuG/8wwYL98vvhZjzdB
 08hTSslLOcQ7IOGTPHru038OJpZFpPia8a262w8RKR9dMNmjLBEvg/uZthvuriaQSlsgkLU6d
 9akj1/JXvCAU2BokId5g9e2jUz48jn2j0zyCq3TZH436uSuqEqpjILkNze8kUw/giKmVqUFNl
 EyxGJNwcyI8vRgsNPkYdjC0sfbmlREoX+3eKWL7zHf/nDU2J5NwP1jrM0121OvMbvbHGbTft3
 wdguned
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Am 04.08.2016 um 18:07 schrieb Johannes Schindelin:
> With GCC 6, the strdup() function is declared with the "nonnull"
> attribute, stating that it is not allowed to pass a NULL value as
> parameter.
>
> In nedmalloc()'s reimplementation of strdup(), Postel's Law is heeded
> and NULL parameters are handled gracefully. GCC 6 complains about that
> now because it thinks that NULL cannot be passed to strdup() anyway.
>
> Let's just shut up GCC >= 6 in that case and go on with our lives.

This version of strdup() is only compiled if nedmalloc is used instead
of the system allocator.  That means we can't rely on strdup() being
able to take NULL -- some (most?) platforms won't like it.  Removing
the NULL check would be a more general and overall easier way out, no?

But it should check the result of malloc() before copying.
---
  compat/nedmalloc/nedmalloc.c | 8 +++-----
  1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/compat/nedmalloc/nedmalloc.c b/compat/nedmalloc/nedmalloc.c
index a0a16eb..cc18f0c 100644
--- a/compat/nedmalloc/nedmalloc.c
+++ b/compat/nedmalloc/nedmalloc.c
@@ -955,12 +955,10 @@ void **nedpindependent_comalloc(nedpool *p, size_t 
elems, size_t *sizes, void **
   */
  char *strdup(const char *s1)
  {
-	char *s2 = 0;
-	if (s1) {
-		size_t len = strlen(s1) + 1;
-		s2 = malloc(len);
+	size_t len = strlen(s1) + 1;
+	char *s2 = malloc(len);
+	if (s2)
  		memcpy(s2, s1, len);
-	}
  	return s2;
  }
  #endif
-- 
2.9.2

