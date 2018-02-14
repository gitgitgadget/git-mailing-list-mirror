Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7153E1F404
	for <e@80x24.org>; Wed, 14 Feb 2018 22:42:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031853AbeBNWmS (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 17:42:18 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:34445 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031849AbeBNWmR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 17:42:17 -0500
Received: by mail-pl0-f66.google.com with SMTP id bd10so4519069plb.1
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 14:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=eH6t5VBZ6ZOdFYQiWnVBQvLO644CPs1+V+vmCdV+lZc=;
        b=AVd0YtLCD+i+PJtMlfdyDmWivtoMGxDcb9oSKp4qpzxdCYRZxR0zCO42w1NGU7Wa4B
         du9yZcy6Ihy7QldpFrNLdxt40RXzGGC8g3HDcww6YRddalUg7MOti/yZHBeYouX2kqz3
         c/G2izS1SnecN1DBTjlFXZIhl+uzQgOmOfqyQ0JyjDxMpF7UFxDl549Bhero0o9k6jaJ
         77ZvYsrEwNJLVbIwa/Jnykz4O9N8ykZGd/LucPNmiKB6SUDWUuXcDRRriUH8gMXbegdY
         Ye7s0z3JcLX5O9P0K1oUW+0G5Hl6GNyCL0V6ayUKv4mNAuJMMc5DysbT5Phh+0dXJGWe
         5hSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=eH6t5VBZ6ZOdFYQiWnVBQvLO644CPs1+V+vmCdV+lZc=;
        b=FfAlPtotX+iLWPW3b8fY01kAX9cTSG1UGVBamoEN/SeOOgAfSqhmdRSICMZGr08+UD
         M3jubzkhqegmZSzdi4wXdb8/f68SvT6YMCSPOofJXXBdssgaj8fRFn+V+CJpfdQbQ9AJ
         6zQhCPUdRK2PlA9RVIE6TwUTxPvH1BTnloWueowfsN+nPJbT116c9ipoI4JfvjHBbqby
         0VK7zzivyXrALZ1mmW9CKT8n+VyYprKDxxRqeSfexCKfFkNMyx1SMpXuCLvCKnJopHZK
         lzF4sDXGkH0sVOxLtjBDhc4kQvYU/BHAdoXQ0D2SomfrppO8vrMKXVnXwp4pyxPlEkrp
         egHA==
X-Gm-Message-State: APf1xPDJpFP0SX7AE1CO9vZPmGGljkyq9F6UIQQ7pO69gI1awpvQx5PD
        uI3WRV7AwRNcZMwn8CwjRgoAW9dO
X-Google-Smtp-Source: AH8x226ohgcxXGSYvTlncdI3eqAkMbGq8n5HYCeIHRudrYCsUzvArE7bGmGgOH1ZX1ntY1ehzuDiwQ==
X-Received: by 2002:a17:902:123:: with SMTP id 32-v6mr537958plb.278.1518648137032;
        Wed, 14 Feb 2018 14:42:17 -0800 (PST)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id u19sm39852502pfl.75.2018.02.14.14.42.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Feb 2018 14:42:16 -0800 (PST)
Date:   Wed, 14 Feb 2018 14:41:37 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>, Petr Baudis <pasky@ucw.cz>,
        Benoit Bourbie <bbourbie@slb.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jari Aalto <jari.aalto@cante.net>,
        Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
        Marcus Griep <marcus@griep.us>
Subject: Re: [PATCH 1/8] perl: *.pm files should not have the executable bit
Message-ID: <20180214224137.GA136185@aiede.svl.corp.google.com>
References: <20180214222146.10655-1-avarab@gmail.com>
 <20180214222146.10655-2-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180214222146.10655-2-avarab@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Ævar Arnfjörð Bjarmason wrote:

> The Git::Mail::Address file added in bd869f67b9 ("send-email: add and
> use a local copy of Mail::Address", 2018-01-05) had the executable bit
> set, this should not be the case with *.pm files, it breaks nothing,
> but is redundant and confusing as none of the other files have it, and
> it's never executed as a stand-alone program.

Needs a period somewhere to break up the long sentence with comma
splices.  How about:

	The Git::Mail::Address file added in bd869f67b9 ("send-email: add and
	use a local copy of Mail::Address", 2018-01-05) had the executable bit
	set. That bit should not be set for *.pm files. It breaks nothing but
	but it is redundant and confusing as none of the other files have it
	and these files are never executed as stand-alone programs.

> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

With or without such a tweak,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
