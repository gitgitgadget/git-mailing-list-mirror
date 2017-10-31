Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01103202A0
	for <e@80x24.org>; Tue, 31 Oct 2017 08:15:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752764AbdJaIP3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Oct 2017 04:15:29 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:47336 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751969AbdJaIP1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Oct 2017 04:15:27 -0400
Received: by mail-pg0-f67.google.com with SMTP id r25so14006973pgn.4
        for <git@vger.kernel.org>; Tue, 31 Oct 2017 01:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=X2bgwu4aLWJzWcXsKrbth61EvWDigUf59MV6QVA8C3w=;
        b=RAxZvTOgsTqP78uc//YwkZWKZaM1mxpVGY/BtERtBLjreHkGIVMtUTMC1bsUMbBwan
         Ei+EAs28/719apC2Vh4r24MroOauRxBww3mt6D+DP8iZrIwKzHSboI41JMAj3eCH9UzQ
         jDftSE+94uHK4Ea/oKkmE0MUiKQYAfJKbuoe40eK23EA0astyI6ejuL2pueI5pQVSsfI
         AYq1KkdtNjiAo6U8iMuoDDl+/WHcKV0Br1yCGgyypQne3ItAV/ZLxAaHNX8Q49ljlyci
         4rA6b8YNhVVT1RUAR9kQ7Qt0Ovm2TijWJAwXYr5PJH8eefuWzPHRzgw51xFVQ8DJ6yuf
         1aWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=X2bgwu4aLWJzWcXsKrbth61EvWDigUf59MV6QVA8C3w=;
        b=LusYq8R++YSOEXzcP7Gm6ezwtAS9nX59qSQ3F2UkQOefEpJtNmPqXXoKIikWGzL5hn
         Ww61lZOBESHUlEqVn1iwNgaj8IEa2sUcHdUfTpq4mU0S9oQJqaGLIgSzQ7ODup6ZfREL
         Y7mxkWyIfj7a6zqWB+k/hhJJInuKd71EMwR7ZN8oz+vEQJ2Q/Rw4I3bIEeQ71SzY24rj
         82Ggtv0seUhe15UpJxlitQWRLl0fzm4cAYdzovI3d9dRuQ586wQSPwYzo0mJc1eyvlvc
         OEZUR6G9BnSKXjT3MP06eRj0CBBLeK6deb65BP+QjPjuSsYGzmMBq2Q6DLwO9sBsK742
         HXQg==
X-Gm-Message-State: AMCzsaWmVKID7Ic273YGk/Iyrzu2yQAnwEU8kgvj4CkjErBTVDQS3xsT
        hGygJp6mFfD+iKCE3UYX67GPLewl
X-Google-Smtp-Source: ABhQp+ScWbOPNL+6PBdrX1o/WWrYdPPtMF7+en82Hv/EfFCLoIxxOPR/M8H/pUQK+VkFPjSXGCEXPw==
X-Received: by 10.84.173.4 with SMTP id o4mr1135231plb.266.1509437727014;
        Tue, 31 Oct 2017 01:15:27 -0700 (PDT)
Received: from [192.168.1.126] (50-39-169-152.bvtn.or.frontiernet.net. [50.39.169.152])
        by smtp.gmail.com with ESMTPSA id n62sm1997374pfh.95.2017.10.31.01.15.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Oct 2017 01:15:26 -0700 (PDT)
Date:   Tue, 31 Oct 2017 01:15:22 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <20171031003351.22341-4-sbeller@google.com>
References: <20171028004419.10139-1-sbeller@google.com> <20171031003351.22341-1-sbeller@google.com> <20171031003351.22341-4-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 3/7] builtin/describe.c: rename `oid` to avoid variable shadowing
To:     Stefan Beller <sbeller@google.com>, sbeller@google.com
CC:     git@vger.kernel.org, me@ikke.info, Johannes.Schindelin@gmx.de
From:   Jacob Keller <jacob.keller@gmail.com>
Message-ID: <DD1C140E-E5AE-4BD9-86CF-46B828BF4289@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On October 30, 2017 5:33:47 PM PDT, Stefan Beller <sbeller@google=2Ecom> w=
rote:
>The function `describe` has already a variable named `oid` declared at
>the beginning of the function for an object id=2E  Do now shadow that

Nit, s/now/not/

>variable with a pointer to an object id=2E
>
>Signed-off-by: Stefan Beller <sbeller@google=2Ecom>
>---
> builtin/describe=2Ec | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
>
>diff --git a/builtin/describe=2Ec b/builtin/describe=2Ec
>index 29075dbd0f=2E=2Efd61f463cf 100644
>--- a/builtin/describe=2Ec
>+++ b/builtin/describe=2Ec
>@@ -381,9 +381,9 @@ static void describe(const char *arg, int last_one)
> 	}
>=20
> 	if (!match_cnt) {
>-		struct object_id *oid =3D &cmit->object=2Eoid;
>+		struct object_id *cmit_oid =3D &cmit->object=2Eoid;
> 		if (always) {
>-			printf("%s", find_unique_abbrev(oid->hash, abbrev));
>+			printf("%s", find_unique_abbrev(cmit_oid->hash, abbrev));
> 			if (suffix)
> 				printf("%s", suffix);
> 			printf("\n");
>@@ -392,11 +392,11 @@ static void describe(const char *arg, int
>last_one)
> 		if (unannotated_cnt)
> 			die(_("No annotated tags can describe '%s'=2E\n"
> 			    "However, there were unannotated tags: try --tags=2E"),
>-			    oid_to_hex(oid));
>+			    oid_to_hex(cmit_oid));
> 		else
> 			die(_("No tags can describe '%s'=2E\n"
> 			    "Try --always, or create some tags=2E"),
>-			    oid_to_hex(oid));
>+			    oid_to_hex(cmit_oid));
> 	}
>=20
> 	QSORT(all_matches, match_cnt, compare_pt);

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
