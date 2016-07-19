Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39F6F2018F
	for <e@80x24.org>; Tue, 19 Jul 2016 19:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751864AbcGSTF4 (ORCPT <rfc822;e@80x24.org>);
	Tue, 19 Jul 2016 15:05:56 -0400
Received: from mout.web.de ([212.227.17.12]:53641 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751842AbcGSTFz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2016 15:05:55 -0400
Received: from [192.168.178.36] ([79.237.58.95]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0M4I6Z-1b7mP82oXD-00rmsB; Tue, 19 Jul 2016 21:05:49
 +0200
To:	Git List <git@vger.kernel.org>
Cc:	Stefan Beller <sbeller@google.com>,
	Lars Schneider <larsxschneider@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>
From:	=?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] submodule-config: use explicit empty string instead of strbuf
 in config_from()
Message-ID: <578E7A07.8080006@web.de>
Date:	Tue, 19 Jul 2016 21:05:43 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:IKUvGKdfOBxHnXrQ8AyuDw0JhjotWU1UiD7CbkxVfwdsxacMV0b
 5ASq6UhY5RgFUZbXugfIl5VgnOy52wOl7w9T94hx16byF4wa3U2WA0qdGPLeg93Q2ALl4sB
 wejgfOGZNEbeC9abUT6R6J2i234hlmUoV8aNTP8TCE3sGBlLcT3YvTKT5dw2LGdoCa/b0kM
 Yzx3t7azLIM0DGb+OtG7g==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:jPD49voLGSQ=:HNgJncTOdGUlpkzpMiNii2
 xqPdLJr6OcXSDcxbUBbGn+8CnQFmxdCVyzoJ7e/lvg+JpdhorL+Co4iRcAjOtdCTl+Zt+N2KP
 nkJ3RCKukkRN+EB90X1NfsZ58rjn6cemoyWLJ/0ZeE714ALHG4C32vTV5z6Z16frMnCvcFLl1
 LAE81xhBlAd7otFpaxhoP4hfUFDYVx7XKGxx63U1b6M2OtjN9G1zAAoYYMh4xqfhAKkMC9ZvC
 7PC4ByoC5xFCN4vZ7Z1ubtySSOYND2KVg+qGIQ24Dl3LSx5T7qKGvorbeU1mYACqWc0T7CaSp
 Pvv03Iql29MglWTKDTTW5bNAwpJF5lVWy8qEWBo21MhDPMuOuXwc/fHYuleRnXGXQsl7xy2NB
 IgwtaX4ePg5ng9Pemc9wHmqhyIrR/76wgXxlyRPsQ974Qm8L+wKtWe5i1u4hBDaG5hUQSOHiO
 ELs3cn9YVBD9syB+459PzKljVn4w6HpT1n+9xNR6IsFilO0DjJ0SRUsAMdFEvQv8ehxKfO42c
 3dbGVZPVWNs0pstF2/jXF03lTwKJqOf09lBCl+TJAGdqC6S9cxf7G/mFfZRfN8/4RIYk8R8kU
 Fihzr6yQVWIzqIPE97f+efs++mOgl+Ww3+Ug6AxVbiQSg2RlYZwOWdiUSpR6NorpmM7q2T54n
 6Y36dZ/M/wcvh5laT8aukXGwHF0VCyUZ32vzYZGdCcYDWMxOwmsTT6Xv/Yph4+H1g6AO6pcAA
 ZhGSDKpzrxFD6jFMKTsSiBUlnXKcUd6t+LibgvulxOWv1Q8u/eDMoksevD8ZzTQQr2SG8owIY
 Bm1vxXQ
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Use a string constant instead of an empty strbuf to shorten the code
and make it easier to read.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
... unless someone can come up with a suitable non-empty string to feed
to git_config_from_mem() as its name parameter.

 submodule-config.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/submodule-config.c b/submodule-config.c
index db1847f..44eb162 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -397,7 +397,6 @@ static const struct submodule *config_from(struct submodule_cache *cache,
 		const unsigned char *commit_sha1, const char *key,
 		enum lookup_type lookup_type)
 {
-	struct strbuf rev = STRBUF_INIT;
 	unsigned long config_size;
 	char *config;
 	unsigned char sha1[20];
@@ -448,7 +447,7 @@ static const struct submodule *config_from(struct submodule_cache *cache,
 	parameter.commit_sha1 = commit_sha1;
 	parameter.gitmodules_sha1 = sha1;
 	parameter.overwrite = 0;
-	git_config_from_mem(parse_config, "submodule-blob", rev.buf,
+	git_config_from_mem(parse_config, "submodule-blob", "",
 			config, config_size, &parameter);
 	free(config);
 
-- 
2.9.2

