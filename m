Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BB251F404
	for <e@80x24.org>; Thu, 25 Jan 2018 20:13:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751321AbeAYUNH (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jan 2018 15:13:07 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:39880 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751235AbeAYUNG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jan 2018 15:13:06 -0500
Received: by mail-wr0-f194.google.com with SMTP id z48so8906875wrz.6
        for <git@vger.kernel.org>; Thu, 25 Jan 2018 12:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PoyBS9MTfpNp6/pYYi1ym8xVP0tUF4D0wbUsGOHr21c=;
        b=JHPKTi9Wu5SUl/hE5hBMh/aH01bixxjDZUDUgeDng8rytErt8Jn1CeN3dqe0Mb9uz/
         jqr+RiDWhb4/Ic4BaH8uO8xiHLD6r3MNX3AumJ+EHpeHXZTupYiUaZaQxSh0T4SNDcO9
         nXoZMD99OJQulsuCuBfImw3urYWj8TncUfXn+Y/NX831Xea68kp6cn7rW9/pxMDfwPEj
         298j2pv0i1JO/eyBuR1JsEZngDF0d7xnhiXfoJ20n+/sHFYSeXUToe/CKuQWO0TSbYjS
         g5WRBc9Npe8yJLu2/TP7j4nMDTxpoQFy8bbTawk+W73gs4t+0gZgizcIrC5cipQd05SC
         0EQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PoyBS9MTfpNp6/pYYi1ym8xVP0tUF4D0wbUsGOHr21c=;
        b=h0fWLz4Ik22m9QizqUe4DeBZ4R4DSPnZBhBwEoTGjiCBOOCmm8XmPdozfUTAW9v+ou
         HyUQjiV4VZ8eV1wqSYVX5/HkX3TLwAibeJKi/MKd48MX8XALcfqtRHjzq49I9837Ir2R
         Krq0KmRDsO4E3HlHkysQDTDBigSL69DgoFO9bcQIN67NiuAXChbJNcDorUWPGgT1YkHU
         wv/ORjKvAG9Oimu5J/eFWdtuFV0jRMv8wl9xXkcdhWaLcuwGET96zGmEWxBUEY4U71MM
         q7YbOqzfiJvlVuhMzN+S9IQr0Xy0xUkHX8fMe2TyEn6dUY3G3aaRLR6KObYas5nXVAQw
         2M3g==
X-Gm-Message-State: AKwxytfFgKbfJh/OPhNDaewxD28sBFMnyVnrR6dG+JGnY0CysUtlG79l
        KsxUdZWPh72TYMj/mOTyIM8=
X-Google-Smtp-Source: AH8x227r2hUsPRyXVgXaPDPWC2AaFWbrChfj4jyC1X7/VrNkcS051m4IDIgV8tXXHQiIQLbsBhcqmg==
X-Received: by 10.223.165.70 with SMTP id j6mr9456184wrb.132.1516911185210;
        Thu, 25 Jan 2018 12:13:05 -0800 (PST)
Received: from localhost.localdomain (x590e2a81.dyn.telefonica.de. [89.14.42.129])
        by smtp.gmail.com with ESMTPSA id h194sm2871989wma.8.2018.01.25.12.13.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Jan 2018 12:13:04 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     KES <kes-kes@yandex.ru>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>
Subject: Re: Feature request: Improve diff algorithm
Date:   Thu, 25 Jan 2018 21:12:50 +0100
Message-Id: <20180125201250.30171-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.1.155.g5159265b1
In-Reply-To: <446801516908691@web22j.yandex.ru>
References: <14657461479715884@web21h.yandex.ru> <CA+P7+xrKfqOb-3FhKxXdnF6g9PktNWNzY+ZnHJS=yuVo1YdXzg@mail.gmail.com> <CAGZ79kZbGPneUXVEqJYhQAn+dfYve7qCjhO7QFaV1JBs3HD1aA@mail.gmail.com> <CA+P7+xqMUPLC-aKW-fiS629_Owat8sCa5vp_bOwQTO8LP4hCzw@mail.gmail.com> <12531516812201@web36o.yandex.ru> <446801516908691@web22j.yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> One yet more:
> 
> @@ -141,5 +86,9 @@
>  	// }
>  
>  
> -	OP* o;
> +	SV *tvs =  newSVpvs( "ScalarHistory" );
> +	SV *tva =  newSVpvs( "ArrayHistory"  );
> +	SV *tvh =  newSVpvs( "HashHistory"   );
> +
> +	OP *o;
>  	while( PL_op ) {

What version of Git are you using?

The current version gives me this:

diff --git a/f b/f
index 30a292bbd..fa1e98292 100644
--- a/f
+++ b/f
@@ -1,5 +1,9 @@
 	// }
 
 
+	SV *tvs =  newSVpvs( "ScalarHistory" );
+	SV *tva =  newSVpvs( "ArrayHistory"  );
+	SV *tvh =  newSVpvs( "HashHistory"   );
+
 	OP* o;
 	while( PL_op ) {
