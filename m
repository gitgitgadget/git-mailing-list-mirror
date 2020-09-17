Return-Path: <SRS0=cV3L=C2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E554C433E2
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 13:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 016AB206DC
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 13:45:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbgIQNpc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 09:45:32 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:51215 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727119AbgIQNde (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 09:33:34 -0400
Received: from mail.cetitecgmbh.com ([87.190.42.90]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MO9qz-1k7aAe1o2T-00Ob0n; Thu, 17 Sep 2020 15:26:13 +0200
Received: from pflvmailgateway.corp.cetitec.com (unknown [127.0.0.1])
        by mail.cetitecgmbh.com (Postfix) with ESMTP id DC98B1E01E7;
        Thu, 17 Sep 2020 13:26:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at cetitec.com
Received: from mail.cetitecgmbh.com ([127.0.0.1])
        by pflvmailgateway.corp.cetitec.com (pflvmailgateway.corp.cetitec.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id SQO3seRnxJCk; Thu, 17 Sep 2020 15:26:12 +0200 (CEST)
Received: from pflmari.corp.cetitec.com (unknown [10.10.5.94])
        by mail.cetitecgmbh.com (Postfix) with ESMTPSA id B18D11E01E6;
        Thu, 17 Sep 2020 15:26:12 +0200 (CEST)
Received: by pflmari.corp.cetitec.com (Postfix, from userid 1000)
        id 87B398051A; Thu, 17 Sep 2020 15:26:12 +0200 (CEST)
Date:   Thu, 17 Sep 2020 15:26:12 +0200
From:   Alex Riesen <alexander.riesen@cetitec.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] Config option to set the transport protocol version for
 network fetches
Message-ID: <20200917132612.GD8079@pflmari>
References: <20200916200203.GA37225@coredump.intra.peff.net>
 <20200917132047.GA14771@pflmari>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917132047.GA14771@pflmari>
X-Provags-ID: V03:K1:CDsBLvbdy4F67RWp4wLFZyRCThxLYQ3jAIqrA2OMPBvfNwLMElI
 QkqayqY8cbYQeqz9ndmIJ64xK+Suw6B/5RtoP2U3z6svTxrZ++iEr59dLqWm7zh5J6hSQmR
 KgzOI/CzinCt+1mNOjIhW7MV+jwxUkk7CS5jfEYwettYCgbItHLsk+x6GLP/ystS31omGoi
 P6zkvT+vHbsldouT8vvBw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:B7s5JmsQ9So=:357+I5AQuvBmOT5TTYtfAf
 6j5RGx9qFZjd2r1ClghQtlIh6H4kXpZNv4jZ1lcIWDyUv8bwWr58njclTVvO8FBxm3q7f04CJ
 oZz4wJVs2a8Kyz11uJin6yQ13qzq+07j+oVNOcLn4OhAM9aCrQXru43Rr9wHTeO/64/Pz/5Aj
 c9ea49dwfMlfTYUYWcnofXqM3eKSPga9ExDluxkxJqAvz0wGMjN3znKtgo8nSTTKLGvQ3xFx2
 KW2GCfC4h3KEtWUgV/kqN4qmfE7y+shAn9Ohi0b17QLI2XtJO9k+/rwoBb8p8d1zobq9PC6dC
 MMxoCLDIPsfXUaWPgDYcHnRCbpmD43NMZcH0YmboqLCSUn84LgzyeYg4Gg9N3NQB7km7EikRF
 fj1xXGED1ZheQ4lSaCKqJyEcFoMHuefDeIiqE7KBPyq2RglZyOfVC+jqUrAartBuJbUbx6TP4
 krKbnNHS/vGtcrZdtnFghSZV99/tQI68g4E3psLc8fxTIi6h4B2r++RC5GKKze420aRJ6QFMJ
 DW7XgUWWOJru6ybocypljW9JWX7f4Q1oV/VVmCjI9sC6bp3qPKTju2QhdUPYw4PLkCBaC2Z42
 rvyQf/tojaA1tQN4n7rRb1N9V3rJs0/nOiOhh4IW7rTF9s2q4AYyiuJu8QB700uBU5W1xZ3Y2
 hSZRneKKrsE0kz48IzPmkkSwZgo3SbD82weXHAuh3nP7BAaVuQnR7TU8xNI5v+Dldv+Uxet3Q
 b0+tuOSLAscdfFvqF5Y+l9+6MsapVW4kdMorCW+U2a9CS7d4p4+HXlbUZ/8v4t6z3sw5IhuVk
 KO8KMna0TgmmPi6NC8ANs5kEKFaw0bjF/SaLemGt1soKcvYd39Clm9bud6OIh77PoBUYBHvFW
 ovblm0w8/L0QWLpTXmbg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Riesen, Thu, Sep 17, 2020 15:20:47 +0200:
> diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
> index 74619a9c03..dcb7db9799 100644
> --- a/Documentation/config/core.txt
> +++ b/Documentation/config/core.txt
> @@ -626,3 +626,10 @@ core.abbrev::
>  	in your repository, which hopefully is enough for
>  	abbreviated object names to stay unique for some time.
>  	The minimum length is 4.
> +
> +core.ipversion::
> +	Limit the network operations to the specified version of the transport
> +	protocol. Can be specified as `4` to allow IPv4 only, `6` for IPv6, or
> +	`all` to allow all protocols.

Eh. Option values are "ipv4" and "ipv6" indeed, not "4" and "6".

And I compiled and ran the code by now. Feels ok.

