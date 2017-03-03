Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D73602023D
	for <e@80x24.org>; Fri,  3 Mar 2017 10:58:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751143AbdCCK6q (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 05:58:46 -0500
Received: from mail-ot0-f179.google.com ([74.125.82.179]:35783 "EHLO
        mail-ot0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751332AbdCCK6p (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 05:58:45 -0500
Received: by mail-ot0-f179.google.com with SMTP id x37so26600080ota.2
        for <git@vger.kernel.org>; Fri, 03 Mar 2017 02:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DTiCjNWsEFoCvUyY+EaVvpOC151KSXVIwiaPwLvKftk=;
        b=cvcWES1wZnJw8WDhPQyYoB7n/Jiz7Z4ZfHaWHPOrXmg2RRK2T0j8vGyukwLdS6GEri
         iCP+r6Xj81iCo+9jqJvZ6i2yDzB2blahtRo5v91WIVu2N/wzQkPLgrnFZAymKzdm2uRV
         +GkwbN/IXYo11eunjPAE0D9M7xR1aLlUb8W3RPmvzhZfHuhNlAPAPITQtjeRJmL079/m
         +mmPtqSiQ5ZZ6lFtPCsvqKPgVWVCtpTrG01B0LPKlOfBByq1EfspSceP6GqCwhQcoQpo
         hUxJa91Z2KnFoGDw+De67IttJc4Yx0kgOFFHGXOUH0qM7gUseuvpLjkckdcj9Yf+mu4k
         XeUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DTiCjNWsEFoCvUyY+EaVvpOC151KSXVIwiaPwLvKftk=;
        b=Cwqivj6EvwNAaES+aJk5AIcKvJx7tKtKZIVwz5XIfMvneXwqzmwM6cYzb3froAUKuv
         GYv+3bXeTTHR3U+2z87mXnGJd+YrjoR3SUcRXsZoSaTeneoKIyoADZMYHpn14wP9+i5s
         cpwH0XiDbhWUvkQOeANLVT28Ywxp6XAehpsN1P7IQc6y43TMxWYKrkOHnX2xc9loytIc
         GLMcB0sh5zTxnARxPYEN6Hullsod1bbfAEVrkvfe6BYtRJK/5LT9oU8u99j+qxPOM36i
         rXKqvcjKVew3efVXaT/uAtrhHXGbSOlvCs9ydJmUD9JtsDkX/xGKS7uqyaH1WVcq4pJB
         gLHw==
X-Gm-Message-State: AMke39ksaHu4kyMuO2WmbVvbKovfGHK+kUh3XaGXGnDVbvYAs4kVVNCgUbDLdrgQUL1Tt3WmpH7cweF/UUBG0w==
X-Received: by 10.157.46.26 with SMTP id q26mr1148829otb.28.1488537017749;
 Fri, 03 Mar 2017 02:30:17 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.158.84 with HTTP; Fri, 3 Mar 2017 02:29:47 -0800 (PST)
In-Reply-To: <20170303101503.lf2ub2c7i6w7kg3t@sigill.intra.peff.net>
References: <20170303094252.11706-1-pclouds@gmail.com> <20170303094252.11706-2-pclouds@gmail.com>
 <20170303095351.rgifjpfuvafx33jy@sigill.intra.peff.net> <CACsJy8DU7-o06mfuw1L02CFFR2wmoNa0MQJ8KqsV79ULzjRaRQ@mail.gmail.com>
 <20170303101503.lf2ub2c7i6w7kg3t@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 3 Mar 2017 17:29:47 +0700
Message-ID: <CACsJy8CDOBUe7S3sYz=_tAJy2ajM5h2v+ZypD6Cr1uJo7XAnGQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] config: check if config path is a file before parsing it
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 3, 2017 at 5:15 PM, Jeff King <peff@peff.net> wrote:
> But I do think option (a) is cleaner. The only trick is that for errno
> to be valid, we need to make sure we check ferror() soon after seeing
> the EOF return value. I suspect it would work OK in practice for the
> git_config_from_file() case.

stdio error handling is a pain. Maybe we're better of with open() and
mmap() (or even read_in_full)? I/O error handling would be at the
beginning, not buried deep in the parser. Hmm.. since we already have
"fgetc' version for config blobs, this could kill some code...
-- 
Duy
