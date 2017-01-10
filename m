Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C717B205C9
	for <e@80x24.org>; Tue, 10 Jan 2017 11:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965090AbdAJLmT (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jan 2017 06:42:19 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:34896 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934298AbdAJLmR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2017 06:42:17 -0500
Received: by mail-it0-f67.google.com with SMTP id 203so9286033ith.2
        for <git@vger.kernel.org>; Tue, 10 Jan 2017 03:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/zsDr4ZU9mS+Rwz2RnpGmRv2vGTjtnWUWQGhcali5/Q=;
        b=XaBrTwXOWFMgCrlPyQD9EuYdFTVSQF18YOB43yu/1ldVB8INMgacJKziQLQApT5eTF
         2lw118mdk9jFjSpnLTR2Lb9W9H25Fry8S4Sn0Zpm2IVzAShqzqNNGW7iyONrSJyByYq2
         4c23BcaJ/X5nbtyIbUox7LR82edSVt33nO3EN1pIFkyqAO6rDZiw+DrXTKuPOn1//WqT
         7u7cbTJsKZCQyOhHcW1tKf92qgB5T7JrFfg1rlVH9sqvDxFaEoGqMqco1/8xMlu2vdP0
         LlgEIKA/HdF37Yr3MSGkxdYAWni7zmTabKWZIITYxfRuZNZtyokZyEV/tNA9GMYQoAVD
         KveA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/zsDr4ZU9mS+Rwz2RnpGmRv2vGTjtnWUWQGhcali5/Q=;
        b=d2RS2ZJbNL3AWloINbZ3oCyT8R0KasrZ7Ih45+JDC4EBRxbBU3lIUOCmW41o+LjYGw
         8Ygvas/OytDj/6b+S1cxbfCgkR4MCm2ioptrkwH34Y7Bf9dWOSwbIuVHB0jxllwz+r/U
         nd9lQo5zId2n/e/y81j+e5Cy65zaYbvYap4Hb3DN7WSzN4I1SKMPSHCafdTrtBonyxea
         twDgf9tsAQiIZYBDxVCYwdLNCrDBmXQmjStBtv7zyhwfLLj+RDdwaSKUaGSXn7iPi8Gk
         OGU7EJfD9aNJ2iWnC3qy38tIcxHh1Mi5n4GvphwTUeiKfiErqjArc9/qG49oYT2n1eCD
         s9dg==
X-Gm-Message-State: AIkVDXJ2R2w+8PjAMl++VQNsNOOwZ67iwuOskJoR75gpUXe1edDCuFKAz9S0hp0vHZS2C06TSw3V9gsmpCfp+Q==
X-Received: by 10.36.26.148 with SMTP id 142mr13750023iti.74.1484048536621;
 Tue, 10 Jan 2017 03:42:16 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.69.3 with HTTP; Tue, 10 Jan 2017 03:41:45 -0800 (PST)
In-Reply-To: <20170110112524.12870-1-pclouds@gmail.com>
References: <20170110112524.12870-1-pclouds@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 10 Jan 2017 18:41:45 +0700
Message-ID: <CACsJy8CGr56X7p19T=4Urq77NLO-fYeYEHbJJBwt9QafVRFVvg@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] Per-worktree config file support
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael J Gruber <git@drmicha.warpmail.net>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Max Kirillov <max@max630.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 10, 2017 at 6:25 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
> Not much has changed from v4, except that the migration to new config
> layout is done automatically _update_ a config variable with "git
> config --worktree".

I accidentally two words that may make it hard to understand this
sentence. It should be "... is done automatically when you update.."
--=20
Duy
