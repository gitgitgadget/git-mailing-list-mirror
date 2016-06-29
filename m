Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD8121FF40
	for <e@80x24.org>; Wed, 29 Jun 2016 14:15:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752744AbcF2OPH (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 10:15:07 -0400
Received: from mout.gmx.net ([212.227.15.19]:57635 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752643AbcF2OPF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2016 10:15:05 -0400
Received: from virtualbox ([37.24.143.100]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MSMKx-1atCzm28UN-00TT1V; Wed, 29 Jun 2016 16:15:01
 +0200
Date:	Wed, 29 Jun 2016 16:15:00 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/5] Skip blank lines when matching <commit>^{/foo}
In-Reply-To: <cover.1467209576.git.johannes.schindelin@gmx.de>
Message-ID: <7cebdcd80a93d1604258e9dc9cb286cd6ba97ba8.1467209576.git.johannes.schindelin@gmx.de>
References: <cover.1467209576.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:0qZcqdtg+YC/VexyDqmHIm+1AZnanjhkTVI4vLbkIGd5jImtn+r
 JSxCiGrRks9RYgq7zCdc63OvgeAOaQKRHY8Ia7pjFiXbCdedNINrBVtDNvvjXFNi8gdUs+r
 bCRmor5hpCpKkHbBRxEZv2WTgQezd2/oShcegYa+llO7eek2U//Vb1L1IWKcXHaQUh0lWBJ
 Py8cPj7ok1VvKyg998hYw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:btKpgfkXQXs=:L/mfLAgWzdoxT1aZrwStvI
 6tH3LhmAUENyWoGEPGURR+3PQklWZoPp9x/k8w4tFb4jkxMyBvbYl3576SFBZloOTvSrs0Veg
 zG4+0yPwKvPOkWecl18gW+PI55WX1MD07O6ToAWJEtT/AkIE4Njntvyp4wGET+2TvYVismrZ/
 qdZnANj39i4N/0hFHhbA4f4nWbBb0s5NI0JrXym5DunsrIEO1939N7W7jo80xsEaOHforCysh
 2r1CxAfIt9JuoM4C3DXTkXEmWgqY02SdPGJNibH7N1TKEaWj2wk6gSQwc7r7CZPiW9EszRXbA
 J0h3H7X2AmxBsU3tXIfP32rNEph42nf8WH6tRrcDhjSga62q6OKFHbaiJmXA36rQALdYHiQWP
 NTzAA/4HCZf6JSlAMTnXcHGMu45MhY07A9sPcKq9xoRraxzx7UMj8ly0igmE6sGsbQalIzXcs
 ohfZfIyozzmPZ6hc/bz1B6C7VQWeNM4ENHemcQzlLpueTFQ4kmZNmpUgZVMQE998ciAvwuTaQ
 iFI7KIdFziXX7WUGwSugZE03RsffBrJCc65H1lo5UnnWsvmlaltBdqWZqCqM5ErSZjUaFLs9x
 i7LgRlsW1yTRGsJ/juSY8ZFZzmpphKlfX3+LtQsxYgO3tpFHdcZzo9Tvwycu+KuKNTRNxQ93G
 BcWnV5KJf7n+Ddw32pDRD8AxLe/o+9PYvuu3hYc0D65QMvf8zBI+gvwZiZGqiroNhFkcGb39Q
 Yr4UITA7Ko/Oc87TwIANM5PKUF3EYGQTsn8y4LKhCkwdktY8LHXfkuTlksy+pf93UvNNfoiXD
 7VbQ/ZH
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

When trying to match a pattern in the commit subject, simply skip leading
blank lines in the commit message. This is consistent with the
pretty-printing machinery: it silently ignores leading blank lines in the
commit object's body.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sha1_name.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sha1_name.c b/sha1_name.c
index ca7ddd6..da354a5 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -912,7 +912,8 @@ static int get_sha1_oneline(const char *prefix, unsigned char *sha1,
 			continue;
 		buf = get_commit_buffer(commit, NULL);
 		p = strstr(buf, "\n\n");
-		matches = negative ^ (p && !regexec(&regex, p + 2, 0, NULL, 0));
+		matches = negative ^ (p && !regexec(&regex,
+			skip_blank_lines(p + 2), 0, NULL, 0));
 		unuse_commit_buffer(commit, buf);
 
 		if (matches) {
-- 
2.9.0.270.g810e421
