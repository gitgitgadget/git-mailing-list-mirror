Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3906C1F404
	for <e@80x24.org>; Thu, 25 Jan 2018 19:31:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751191AbeAYTbf (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jan 2018 14:31:35 -0500
Received: from forward100j.mail.yandex.net ([5.45.198.240]:42247 "EHLO
        forward100j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751106AbeAYTbe (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 25 Jan 2018 14:31:34 -0500
Received: from mxback14j.mail.yandex.net (mxback14j.mail.yandex.net [IPv6:2a02:6b8:0:1619::90])
        by forward100j.mail.yandex.net (Yandex) with ESMTP id E8A3F5D84D0A;
        Thu, 25 Jan 2018 22:31:32 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback14j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id Blk63YvFQ6-VV4iljjW;
        Thu, 25 Jan 2018 22:31:31 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1516908691;
        bh=31HGuMrPA7d8MO8luKjD6LTYDIh21YHdlP+2SaoEta4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date;
        b=DY3VQAi1NE/sfIpedfstu4WriCYiJJlNH5BybgORc1ETUY0D9u0ri6n8yPfvlkvad
         /ulAarFlLPw+AI2emjlaGI6WtqRCTzrDU5U3M/Lg5OrDClFE+N30TU2cZxoZXb3Qlc
         xkFShb+VWByp9jsWnoBhcr6drtcC08qFxaxpFawI=
Authentication-Results: mxback14j.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by web22j.yandex.ru with HTTP;
        Thu, 25 Jan 2018 22:31:31 +0300
From:   KES <kes-kes@yandex.ru>
Envelope-From: kes-kes@yandex.com
To:     Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>
In-Reply-To: <12531516812201@web36o.yandex.ru>
References: <14657461479715884@web21h.yandex.ru> <CA+P7+xrKfqOb-3FhKxXdnF6g9PktNWNzY+ZnHJS=yuVo1YdXzg@mail.gmail.com>
         <CAGZ79kZbGPneUXVEqJYhQAn+dfYve7qCjhO7QFaV1JBs3HD1aA@mail.gmail.com> <CA+P7+xqMUPLC-aKW-fiS629_Owat8sCa5vp_bOwQTO8LP4hCzw@mail.gmail.com> <12531516812201@web36o.yandex.ru>
Subject: Re: Feature request: Improve diff algorithm
MIME-Version: 1.0
Message-Id: <446801516908691@web22j.yandex.ru>
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Thu, 25 Jan 2018 21:31:31 +0200
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

One yet more:

@@ -141,5 +86,9 @@
 	// }
 
 
-	OP* o;
+	SV *tvs =  newSVpvs( "ScalarHistory" );
+	SV *tva =  newSVpvs( "ArrayHistory"  );
+	SV *tvh =  newSVpvs( "HashHistory"   );
+
+	OP *o;
 	while( PL_op ) {

