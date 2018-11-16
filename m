Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61E5F1F87F
	for <e@80x24.org>; Fri, 16 Nov 2018 20:04:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725840AbeKQGSQ (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Nov 2018 01:18:16 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42612 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbeKQGSQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Nov 2018 01:18:16 -0500
Received: by mail-pl1-f195.google.com with SMTP id x21-v6so8905235pln.9
        for <git@vger.kernel.org>; Fri, 16 Nov 2018 12:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Zo+kELgunwpHMe/GmFouhHvWQzOgkWXl99nn/hDNtjs=;
        b=LC6kjp1MUTcOqISAghcJJGi/IR0mh2puf0zwE8VrHrUGL7q85842poOrYdy4YzFJdX
         5q6W791IAFzEWsstk3PUj7ByYJF/qNl+62fAC0SKbnP4b7Jd97+U5hoZ9piaNM3sc3fK
         ZLYPruDonI4lZQ1biJOTb0WvEFsCxYSL60Y4Nw0TtCLAp6Sx9B8THZWMIf3cNfcFs+IZ
         b6sQ0PSCUgrua5ACLIdzof0TgZtpez2+dMoG7DflF/HSX3P0mx3VQnyAobY6vQd1F8WC
         O8afnPG88cBJrAQ0P4IHoPq9t0xWa6QtoIC1UisFJZmD5lC+KSbMKB/V9+WbYlAU6xdu
         3vEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=Zo+kELgunwpHMe/GmFouhHvWQzOgkWXl99nn/hDNtjs=;
        b=NFnuVmB9riRYtXekfCvqfJ1vsEQJ4IlXuO4FG6m6VXfww1NFwlHk6p26bi9fWmRQx1
         +qvWjzdqS3nyyekdlAnkmLGB1RQKdkFq6Yuj50uSEuURCumda18cm3cNpxZ+zyHWH31k
         li25gIzh54wVhva72sqnvDRL4N4prH54hECZEWI7N3Aj8fFmzu4jTaee+AqRgDbyeEvn
         NHpoR16m5+tPmvWMEgdUN0Zcknpm7x31D9P4M0oCoU8W2o2xO2O6tD7wOTxqW+bnYs+Q
         HEMp75ESmFjRwVmP1qq04d1lv3q42L58LsOkBGpuEH7UeUlMYlqJ7ARo8HMslzgaMLu8
         WPHQ==
X-Gm-Message-State: AGRZ1gLkF3mYeVXGaLkUIcXV2uZFGjL778ez6QX9DhMuqUAoteipaHPL
        HYQECtP6SX3yQ0icM07uwmPCsaaQ78/YHw==
X-Google-Smtp-Source: AJdET5fzZqRLdvcQrKY39lzWChqMuZ8qn6IksndnZRo8nK92TPZ8SrirQlyS0BKiNVrrQ1vgLrBZYg==
X-Received: by 2002:a17:902:24c:: with SMTP id 70-v6mr11859849plc.120.1542398668075;
        Fri, 16 Nov 2018 12:04:28 -0800 (PST)
Received: from google.com ([2620:0:100e:913:5bb:3076:546:99b0])
        by smtp.gmail.com with ESMTPSA id r76sm6203834pfb.69.2018.11.16.12.04.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Nov 2018 12:04:27 -0800 (PST)
Date:   Fri, 16 Nov 2018 12:04:21 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/3] remote-curl smart-http discovery cleanup
Message-ID: <20181116200421.GB9703@google.com>
Mail-Followup-To: Jeff King <peff@peff.net>, git@vger.kernel.org
References: <9a89e54e79593f6455b52e01d802695362f4ec21.1542062657.git.steadmon@google.com>
 <20181113142624.GA17128@sigill.intra.peff.net>
 <20181113222540.GE126896@google.com>
 <20181114004915.GA5059@sigill.intra.peff.net>
 <20181114070052.GA19904@sigill.intra.peff.net>
 <20181115215152.GK126896@google.com>
 <20181116084427.GA31493@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181116084427.GA31493@sigill.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018.11.16 03:44, Jeff King wrote:
[...]
> Amusingly, this does break the test you just added, because it tries to
> issue an ERR after claiming "text/html" (and after my patch, we
> correctly fall back to dumb-http).

Heh yeah, I copied the script from a dumb-http test without reading the
spec.
