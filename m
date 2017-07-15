Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 843A62082F
	for <e@80x24.org>; Sat, 15 Jul 2017 18:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751231AbdGOSe2 (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Jul 2017 14:34:28 -0400
Received: from mout.web.de ([217.72.192.78]:62713 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751105AbdGOSe1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Jul 2017 14:34:27 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MOzwh-1dbhLP0Uhr-006Nk1; Sat, 15
 Jul 2017 20:33:56 +0200
Subject: Re: [PATCH v3 06/20] builtin/receive-pack: convert portions to struct
 object_id
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1?= =?UTF-8?Q?y?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
References: <20170331014001.953484-1-sandals@crustytoothpaste.net>
 <20170331014001.953484-7-sandals@crustytoothpaste.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <cb9c62dc-0171-19f2-7d37-ebb726426a4d@web.de>
Date:   Sat, 15 Jul 2017 20:33:54 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170331014001.953484-7-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:9j+hI3L6+Wxu/H1jsIsFD4MCrGBeorh+PwSYl1yrCwv02OU54bV
 MZDWLHzKGRjOfLykTt6lN3pupUFojlSoTGWCRoHHraVoSsD60izGff5dV0WLWMsgjDgQso1
 YJzFRb64pnSx93x/IVyPCuW4u4k4Q0ofu07hKdNTJV5Tukuc0wyCKsZDAxFQPyRCDRxAyyh
 XA2PGp9C1OpCqN2Erdv2Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:CaM5pxRgTBA=:YpGru2b1nu048uyq2O92K5
 u6uFlKNidr/5USPIjWm1fjUtH1U0VnkfhU5b6/4yjo8kWnqpwtIiEbZwl5gTYr7hebzo7dIsd
 KlXQ5KE5lR4X+7vXCBTfDppTF8+nO4AHHX9hYo0EVTNaqgvZ0Q9vxCyvzgzo/5q/oFST/CkV/
 EeXOECkDqjl1D2MHlfDTv0aKgPFc13vjQhCqAyEZARjcdG3w50QgARw0K6qha2xjOTcxnM1JN
 dELIc98Uip4MvbcjnDoiacw/0hRLZVhpqAdVbEnGt3n3RQKHk+y5RjEEEwnsL94/kNQPe0HIh
 /9PbL0IIFTmEkIUEfatPSPSUdjZ2sc5gviBaZVL6L1qOIG6KYsl8pNbAX4FWOXVWHyao+X8xD
 9t+cxp6Q+Xm+m+T+CTc7Ut/y2lPmZEa7yxIvvgIikYgkF0xOlZdoMQGa4zO5XK8YC+Zuf7twv
 KbbIjdEdMb2OC/s1c4bymd8WtKB5Ue5HJQ1L6Sml13bz36EICU5pLmJZDChGfZsF94TJ/U6sC
 fZWk4q0EpRPMvJwK7YoEcqcM05vFT0W21wiGBgx+XNVy6cNCF1w+03j+tuS8RtUk7Z1OIl4LL
 wovtZPZrj6qjLWLhYsSlDnII4mrUP0j7HqH8UsvLTvoHC/hSzy67ixaPIT7+gQe/nDXxUED7/
 UgwBIukwTnepvnb1pzJHh0NGA8CpRQCiaXqaqkotiXTLzGOs+qrqwlsw5o4oLq6QrC87jTtUj
 UIsBMXAdiw6+DZ4H+kcbtUy+I28rRDUZAyvCW82IwUtrmp3pmSrEkgEqUrfWO737sP6D96XsM
 DE2mUHjLLv9aPj4ZWkB3pno5kvygn1n1WgqzjpSdiNrTfTYcHQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 31.03.2017 um 03:39 schrieb brian m. carlson:
> @@ -1081,10 +1081,10 @@ static const char *update(struct command *cmd, struct shallow_info *si)
>   		return "hook declined";
>   	}
>   
> -	if (is_null_sha1(new_sha1)) {
> +	if (is_null_oid(new_oid)) {
>   		struct strbuf err = STRBUF_INIT;
> -		if (!parse_object(old_sha1)) {
> -			old_sha1 = NULL;
> +		if (!parse_object(old_oid->hash)) {
> +			old_oid = NULL;

So old_oid can become NULL...

>   			if (ref_exists(name)) {
>   				rp_warning("Allowing deletion of corrupt ref.");
>   			} else {
> @@ -1094,7 +1094,7 @@ static const char *update(struct command *cmd, struct shallow_info *si)
>   		}
>   		if (ref_transaction_delete(transaction,
>   					   namespaced_name,
> -					   old_sha1,
> +					   old_oid->hash,

... and here we dereference it.

-- >8 --
Subject: [PATCH] receive-pack: don't access hash of NULL object_id pointer

We set old_oid to NULL if we found out that it's a corrupt reference.
In that case don't try to access the hash member and pass NULL to
ref_transaction_delete() instead.

Found with Clang's UBSan.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
That's the last bug of this kind which "make SANITIZE=undefined test"
turned up.

 builtin/receive-pack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index cabdc55e09..946cf55138 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1138,7 +1138,7 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 		}
 		if (ref_transaction_delete(transaction,
 					   namespaced_name,
-					   old_oid->hash,
+					   old_oid ? old_oid->hash : NULL,
 					   0, "push", &err)) {
 			rp_error("%s", err.buf);
 			strbuf_release(&err);
-- 
2.13.3
