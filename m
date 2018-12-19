Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F9AD1F405
	for <e@80x24.org>; Wed, 19 Dec 2018 17:38:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730612AbeLSRiQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Dec 2018 12:38:16 -0500
Received: from mail-wr1-f42.google.com ([209.85.221.42]:46610 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730601AbeLSRiM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Dec 2018 12:38:12 -0500
Received: by mail-wr1-f42.google.com with SMTP id l9so20326090wrt.13
        for <git@vger.kernel.org>; Wed, 19 Dec 2018 09:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=bnLZPv3St78+jBNfytSY0Q/yUHSi/xGiUFiVWqf5cwQ=;
        b=Vr1nj7QVZQP9Eu7RlDrWaO8f2BJaFivwlEHMnn1sS5v+xsmQeyrFFXzq2W76vC4g0a
         eaC5VPJ17+Z6MAnOgHCBfg20SIFwEzVtmtghpFX+LUhh71HqXQKUQu3cfZT+NRCe5zfO
         E4CuUQVeqyL6eVyUbUgqRvdP+WHyacEDhoJC8viBQQ+mJt3iDQnySdtVGAJjtJ+UHL6D
         hhgJXghm8k6mvtj2fSdSzN89Qxt00npNWah2P16bQ7IPcKCCrsfF6WrzM7nEEE9RMaP4
         eKzx6qEyyOSyJpA0ksUZDh50RfxaQ8RDdftzO7HqbBRVUmUEYqe1P1RMXM5xHq0I1pw2
         Semw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=bnLZPv3St78+jBNfytSY0Q/yUHSi/xGiUFiVWqf5cwQ=;
        b=JmEdOL+ejLXeJF8ukgyGdKz1vp3UMj2FkorhgjkvxrsQve7zZLh3MFnQG8lqluL85H
         7XkXmhnElyLoE1Lffq9fpYmYkutSnj4TqUm+AKuzqeAsgyehh51sh6XG9AaIyvs9NfIn
         8lAdmsdRgpbyzsMsRbQxF0M1wQ+JvLvsTPA8ZYP8ViXzlmtTMJUiOZXLJHxsrMbKRL+8
         r2Sg2BoWOsU2WGpcidDjc/DnJpFkjNb9YhVlJTc7sCbpUeah5fqqui7hncJQQwUB3BHj
         cvtExIAWF2bPaW2agTJxTqnuuukqLtJoAmP2Q+Uq29vHdVTrPEiCVJ/RW6vh74Ud1cW9
         NcXw==
X-Gm-Message-State: AA+aEWZKdy7xRtaC46pWH1X2MwrD0bNGYaeOD84Ifl/PW4KMGKkvMSNJ
        tMxLrvQaIcjkDiU6IFzJaSY=
X-Google-Smtp-Source: AFSGD/VF2C7kT1SnTRWX6lpcQmMg3swSa+VHACEvkJFaHj2JR5vMJKYJ1lymX2wYGygEoEnaTL7KNQ==
X-Received: by 2002:adf:f605:: with SMTP id t5mr18325504wrp.229.1545241091036;
        Wed, 19 Dec 2018 09:38:11 -0800 (PST)
Received: from szeder.dev (x4db2d5f5.dyn.telefonica.de. [77.178.213.245])
        by smtp.gmail.com with ESMTPSA id w12sm6286826wrr.23.2018.12.19.09.38.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 09:38:10 -0800 (PST)
Date:   Wed, 19 Dec 2018 18:38:08 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Han-Wen Nienhuys <hanwen@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: Referring to commits in commit messages
Message-ID: <20181219173808.GA30222@szeder.dev>
References: <20181217165957.GA60293@google.com>
 <877eg5fwd5.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <877eg5fwd5.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 19, 2018 at 03:02:14PM +0100, Ævar Arnfjörð Bjarmason wrote:
> 
> On Mon, Dec 17 2018, Jonathan Nieder wrote:
> 
> > v2.11.0-rc3~3^2~1 (stripspace: respect repository config, 2016-11-21)
> 
> Minor nit not just on this patch, but your patches in general: I think
> you're the only one using this type of template instead of the `%h
> ("%s", %ad)` format documented in SubmittingPatches.

Or the '%h (%s, %ad)' format, which is more widely used in Git's
history, and those double quotes don't add any value whatsoever.

