Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A18301F42D
	for <e@80x24.org>; Tue, 15 May 2018 08:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752488AbeEOImA (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 May 2018 04:42:00 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:55627 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752449AbeEOIl6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 May 2018 04:41:58 -0400
Received: by mail-wm0-f53.google.com with SMTP id a8-v6so17857596wmg.5
        for <git@vger.kernel.org>; Tue, 15 May 2018 01:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=z4KfHvALSXJ6N2R2h4a7T8X0J94kLoSfrnBgm93oh7I=;
        b=eN1ETLOk/djENWNhgNcrGssyWAvX30OHO2mhhV5WIu79+eAHYBKeiPPNUKCDFgfw4Z
         SiOlrk7bJGBureqUw/4cnabzKKYtOHCJvx0ZdI4+VxLbVWtLj+JMUCru4MGQI+f/Fscz
         9m+GqSfd1NCbOc+Dj6yqw9slNF1V6sowVui9aYHqoMZDLGSvWxvrVf258Ozb6CQu+Ng0
         hIuXqRG2TvAeZ3fazDf5GL/aCOXDURqYF8zXtc+4wb7kFJSa2QXa8neNdN4+yfMdo8+z
         CtWbllH0aiUWV7IHsLC5TUOIA5fRrGRMH9uNkmOVlTxMNJIvVLVEvmnvNJ5J+vqZJr32
         BRKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=z4KfHvALSXJ6N2R2h4a7T8X0J94kLoSfrnBgm93oh7I=;
        b=IK9OWcWrmUldf1cSCCEy9iRxfG2pjGyHMtzeoJzwqmnrOJ4wvUd5fVcsmLj3Xxx9tf
         SV2SEgmStnGP45+YpluSBGYYf8NhLGe9Sw7RAw8J9GcmVW9VF1h2w+6/h7CAogDPtRmN
         M+1Tf+JwA7l4AngF+zstEcg33PPIq44t2QbsVwnsbDYcnJnXfpNhbQbciWKKCx7WsN8s
         F+FXW2tUj6DikpxmMXDwP2NdG7Nd73s6UA5IeftGstj/VrqBhtI+WVAH+Rn+j/WCVty2
         RjHiEuraFcnJkJ4CqBNZZB6Zj3qe7Z1bnqy0R/V89+BWnbWr4nni58yeWqRpKtFpyYWQ
         OsnA==
X-Gm-Message-State: ALKqPwf6GITOI/4CJuLC9EnY5hzDN9YfUABKvzVV8zkLX5NbAy/Al3hj
        NvkgAQIM0hRfeU99fqwzQSj54/Q7
X-Google-Smtp-Source: AB8JxZpSfi/sJXtbbZ4O/bJGNucz2Kb0AYtbX2nwVYv2dIxTRX1nxrs7YEJcn7ZHIbFNYZuGAPOIZg==
X-Received: by 2002:a50:b6e2:: with SMTP id f31-v6mr16790978ede.23.1526373716553;
        Tue, 15 May 2018 01:41:56 -0700 (PDT)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id i22-v6sm5727651eds.28.2018.05.15.01.41.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 May 2018 01:41:55 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v1 2/8] Add initial odb remote support
References: <20180513103232.17514-1-chriscool@tuxfamily.org> <20180513103232.17514-3-chriscool@tuxfamily.org>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180513103232.17514-3-chriscool@tuxfamily.org>
Date:   Tue, 15 May 2018 10:41:54 +0200
Message-ID: <87fu2t2tv1.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, May 13 2018, Christian Couder wrote:

> "sha1_file.c"[...]

sha1-file.c these days :)
