Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02F4D1F453
	for <e@80x24.org>; Mon,  5 Nov 2018 18:34:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbeKFDz0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 22:55:26 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:51894 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbeKFDz0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Nov 2018 22:55:26 -0500
Received: by mail-it1-f196.google.com with SMTP id h13so14183220itl.1
        for <git@vger.kernel.org>; Mon, 05 Nov 2018 10:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7Bbl4P61gCpnp2tzzgNJIbIuX61pecKMbK82+TqpYzI=;
        b=f+XFzDhVZBktZ/qibtnMAF4ZbJ1U0u+VLHrzNsvkY6OrN5CeU9kwafl5jK+daCVIiu
         hy4x7vs4JWmR1Vpdefxhdx9o5sejLzT5acGbsd7i/2ZkPjvOz6FDWer+k3AapM64gAdQ
         ZtyNfNHmePjKT/6aKhv1SVGUlk39igsa75a6fOHG4T8+ILVeY++LlpUGQGEo6gh7MaTq
         LaLs3WujWVwk29uXnfmKs1Qb7Afi8d1eXTDhjYeP1mjbEg78MJ27xEoAO0fwZv2SpBqq
         H9De4wdTjfdt/b95i5TzMtmGUpoGsdvL2MhFn4gs3NXt9XWqI+OW/gGgZTv0m9Hz8Pa5
         /DbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7Bbl4P61gCpnp2tzzgNJIbIuX61pecKMbK82+TqpYzI=;
        b=WgusLo3eLwwqGxwaUWgltcgghaO7TrbtSonVJinGokFz3hL2YCiS/eGJU+feLeXDJP
         xbOPZu00OYsATvAwQiO+6VhPPC4i1SNr7pB1uO0qvkavJ+myLXpScTQp9LuQ3r9yEpDP
         FbycPtgnLSxavPvlZoz/AaBa8vBc4QxYIlWxH8ooRebz62vTi2J+nBN+qLS4KdoyGHtc
         Xlc5az6aCAcNkJv5lV+Vo0hV1cP3cX7naOAKdVOsl7X/kcPkjeJ16jSTphz6VlakWYgu
         GbFh4jThLvBcj1SDJ9MQknmnDja5vKFZcZpoVkbeGKazH4OyfGgcnAVr8BssxVIEo6+C
         Hh8g==
X-Gm-Message-State: AGRZ1gJeKy0n8Bixz9DMudQDcLDR7ckAP4/BiQFZ8bS98+eheAKB22zC
        6mMIO0PGGmTQqFhBtksOJJk=
X-Google-Smtp-Source: AJdET5dnuPEQKCr2qkHVTObuvEcTXVDMwFYIIW9yIVvEhmS8eyhPFwtD2+05ONDJKY7m5itilr4XgA==
X-Received: by 2002:a02:4d99:: with SMTP id t25-v6mr19645077jad.4.1541442869499;
        Mon, 05 Nov 2018 10:34:29 -0800 (PST)
Received: from Carlos-MBP-2.sf.stch.co (50-207-95-178-static.hfc.comcastbusiness.net. [50.207.95.178])
        by smtp.gmail.com with ESMTPSA id e15-v6sm15152288iom.6.2018.11.05.10.34.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 05 Nov 2018 10:34:28 -0800 (PST)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     peff@peff.net
Cc:     git@vger.kernel.org,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH] parse-options: deprecate OPT_DATE
Date:   Mon,  5 Nov 2018 10:34:02 -0800
Message-Id: <20181105183402.9927-1-carenas@gmail.com>
X-Mailer: git-send-email 2.19.1.816.gcd69ec8cd
In-Reply-To: <20181105064427.GL25864@sigill.intra.peff.net>
References: <20181105064427.GL25864@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 Documentation/technical/api-parse-options.txt | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/Documentation/technical/api-parse-options.txt b/Documentation/technical/api-parse-options.txt
index 829b558110..2b036d7838 100644
--- a/Documentation/technical/api-parse-options.txt
+++ b/Documentation/technical/api-parse-options.txt
@@ -183,10 +183,6 @@ There are some macros to easily define options:
 	scale the provided value by 1024, 1024^2 or 1024^3 respectively.
 	The scaled value is put into `unsigned_long_var`.
 
-`OPT_DATE(short, long, &timestamp_t_var, description)`::
-	Introduce an option with date argument, see `approxidate()`.
-	The timestamp is put into `timestamp_t_var`.
-
 `OPT_EXPIRY_DATE(short, long, &timestamp_t_var, description)`::
 	Introduce an option with expiry date argument, see `parse_expiry_date()`.
 	The timestamp is put into `timestamp_t_var`.
-- 
2.19.1.816.gcd69ec8cd

