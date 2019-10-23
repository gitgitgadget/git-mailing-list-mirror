Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36BC31F4C0
	for <e@80x24.org>; Wed, 23 Oct 2019 11:09:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404684AbfJWLJ4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Oct 2019 07:09:56 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38623 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404635AbfJWLJ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Oct 2019 07:09:56 -0400
Received: by mail-pf1-f194.google.com with SMTP id c13so1515281pfp.5
        for <git@vger.kernel.org>; Wed, 23 Oct 2019 04:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=PIlrCc40iY5iE7BePdeTEoFNg2O7hUaohtgghmrEsRI=;
        b=Qmb6U953Kz/6X/HWBC7QfXLwip/8Ck55p7r8mHRUbZzdR1uapWlxY4kSeDHRINwqMC
         oCFXZWSlQAAyzk7O7eEP6h6eJpSPAxBFgodaIfckgDttbZBFQc6oFVgBwRYJw2OY7QKl
         spHLVbt4tVI/UhDxDPS0PezvOyOP9xiTGVWzS7XXyhIWN5rpnztcLnTTNHYy4YP6QinG
         f0G4bhPKwqYae+u4ihEj+4/HC1BnjlBHkydaLmy4KM9nD4IxhQ7LyCYTwRrBU3vRtOw5
         EX29dhw65zyAvPBTeiyn09Ns80ixfD7LM3d04dhChaNO/GZPH0YzLVZTAYoovwheWlT3
         5W+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=PIlrCc40iY5iE7BePdeTEoFNg2O7hUaohtgghmrEsRI=;
        b=a3IRmn4xcZgY4oUQSfbatOtkudu2qTBtZ0L6nRKPNgBmLIdTJR/fBkcY0usLSdw8h0
         DALezEs020z6V9EZIwTZCShUdxe6b/7Kzo3sUdJFIF9F50Xaq4poLrZQv9QmmUXDKlxu
         0jV7rGUtdjrY6+zkPhAXH9JIOZF8NmHqaFYvV7sK4rHwBMaUbHllfB920Cp3Us5yJlaQ
         PoHwd0Qzv19DEyeA7+d4IPhzgS4IynTHUXQdDRz449jloINsTgzUd3uBK2hDNqpmH6PS
         xWMk3b7Y5gK3OemjzNVklVA3pb+Xc7ShKKmVRsmiFrZQuoLXVDyMMsTOv+LzUOc45NvM
         ifuQ==
X-Gm-Message-State: APjAAAVPoCYtNlTw8E8XFqp2FCoV45qUZ/cyafQQyGBvkNnUclTPyyjx
        rhETpkH+FtEyeEfMWY1YnoY=
X-Google-Smtp-Source: APXvYqw1rF/j+VLvK8eZ84nCzzhrMB4rRg7Xf9Xns1yjkh09MFrXnbocSBAFbllAscVbtQlhZCATrg==
X-Received: by 2002:a63:798c:: with SMTP id u134mr9205308pgc.255.1571828995219;
        Wed, 23 Oct 2019 04:09:55 -0700 (PDT)
Received: from generichostname ([2601:646:280:1b30:80db:d816:4d15:ae2a])
        by smtp.gmail.com with ESMTPSA id q88sm19995408pjq.9.2019.10.23.04.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 04:09:53 -0700 (PDT)
Date:   Wed, 23 Oct 2019 04:09:51 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Jerome Pouiller <Jerome.Pouiller@silabs.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [BUG] "--show-current-patch" return a mail instead of a patch
Message-ID: <20191023110951.GA716725@generichostname>
References: <2154192.LVDMpRDY2h@pc-42>
 <1791353.RaUiIlXgNR@pc-42>
 <20191023085503.GA652469@generichostname>
 <2720546.GJdFeal64i@pc-42>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2720546.GJdFeal64i@pc-42>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 23, 2019 at 10:15:15AM +0000, Jerome Pouiller wrote:
> On Wednesday 23 October 2019 10:55:03 CEST Denton Liu wrote:
> > I am currently have a WIP patchset that will print the location of the
> > failed patch file (.git/rebase-apply/patch) in the case of a failure as
> > well as the line number. Will this be sufficient for your purposes?
> 
> It would be a clear improvement (the perfection would be to be able to
> use mergetool with git-am :) ).

You should be able to do that with the --3way (-3) flag.

> 
> Thank you,
> 
> -- 
> Jérôme Pouiller
> 
