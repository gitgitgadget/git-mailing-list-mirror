Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98F3A1F404
	for <e@80x24.org>; Thu, 29 Mar 2018 01:29:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751193AbeC2B3I (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 21:29:08 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:35298 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751088AbeC2B3H (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 21:29:07 -0400
Received: by mail-pg0-f50.google.com with SMTP id j3so2015045pgf.2
        for <git@vger.kernel.org>; Wed, 28 Mar 2018 18:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1aMu0kHWU218PxTyfLQ0eTrc/cBuWqYzHjdFW3Df71A=;
        b=jEjjwEdqJEAIoOxWrWVUQBsMkC8KMhxvqWAtXgpA9dgi0afbemdMnfo2K5P82rdqYh
         Pjb3s274a/YsIt5NKG1Lxfw4+t5BeOXIjcSaDQrvdEMm8tPQlgYmJg8FWTZqt9y8KDb0
         ekQMm4lS3FozUfbU6eJHTpTM3PyJvRIgF59tUCOlo7xPWhIaCVd8A/Ft/y+H1zrUhJAO
         g9lluWcqrFiyruOiqdOfejPMNZZfDrRQhEvxXyCiUGz3dX9T+TLD+mE1NBoVyxiPmnW3
         D02/7H+voRgM6MIydH/SPVw+C7I7a9+fqX/UOy83WEPa8epQBk8n9s0dEpkcl5jCkA5P
         Fjrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1aMu0kHWU218PxTyfLQ0eTrc/cBuWqYzHjdFW3Df71A=;
        b=M4w6vqnbBhHtD+VHXmQcS7BzWWbWMd/DftkrhxAUhKcmnhxMeNdDVxeHg3Afz/8d2e
         zz7ZFRvYT7dajJ7lalCghL6bummKgaGLkOpfkqeaKSEJlTV9vsJ89O26dWyCbPGa+rOf
         sJTxoHmnPAIx2K9apsEjjtOL+0eIDONGHuPrhXe65W/jagWLgDFhJrLx9Lpv+CvhvjRa
         IfTremztRdujlvRI28LDTweiP0zZfd071u41UJVYlf9YtgdLr4p8pbUPRUgYwFRoOLue
         kFkXZGu+nXqp5kVJW5JoyUjzNmMQZC8ltFCxmKXszQ0msj4aMaj/Z0Xe1c231F0Wosx4
         jj7w==
X-Gm-Message-State: AElRT7EvkRTgbvwIIHG28fKzESUVDU5Zo9gyngXJuLux8PoA5Whaqybn
        jFYr7WvbN14GUf7xuJs5io8TQw==
X-Google-Smtp-Source: AIpwx4+5SFACp6rhBTeB69Z2tFgAh9mSrkK74OQpLqrx6UmWpcsEvMHSJt9x3X5MeVHK5+wWmiMYHQ==
X-Received: by 2002:a17:902:9895:: with SMTP id s21-v6mr884625plp.177.1522286946989;
        Wed, 28 Mar 2018 18:29:06 -0700 (PDT)
Received: from localhost ([2601:602:9500:3a4f:ec10:419d:d341:c920])
        by smtp.gmail.com with ESMTPSA id f4sm9496009pfn.150.2018.03.28.18.29.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Mar 2018 18:29:05 -0700 (PDT)
Date:   Wed, 28 Mar 2018 18:29:05 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     peff@peff.net, gitster@pobox.com
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 0/4] Teach `--default` to `git-config(1)`
Message-ID: <20180329012905.GA71044@syl.local>
References: <20180324005556.8145-1-me@ttaylorr.com>
 <20180329011634.68582-1-me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180329011634.68582-1-me@ttaylorr.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 28, 2018 at 06:16:31PM -0700, Taylor Blau wrote:
> Attached is 'v3' of my patch series to add a `--default` option to `git config`.

My apologies, this patch series is only 3 long, so the subject line of
this message is incorrect.


Thanks,
Taylor
