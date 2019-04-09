Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F16DC20248
	for <e@80x24.org>; Tue,  9 Apr 2019 17:44:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfDIRox convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 9 Apr 2019 13:44:53 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36885 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfDIRox (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 13:44:53 -0400
Received: by mail-wr1-f68.google.com with SMTP id w10so22039650wrm.4
        for <git@vger.kernel.org>; Tue, 09 Apr 2019 10:44:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Wwe8iPn5kehFUIShcoqDBLTwR7VczQ/kgZ8f1KycSwQ=;
        b=m3cfYmqE3/vztD7ldqTXWxawMg6XoehCDdL+O9Nq3Nin9BDXoUreZM1ls5UDIsaq8k
         /OpXVS8h+J8g1bLb6NqTPofSFJ2O2uVt73Zi0yYSo+J4U0k/yEdYpQXB5qMuLSNhnLu0
         kUsTJ5kX64JMnBdJ5CQhFQFod+28aVBva+IVhlLQCNwk+FFLpPFOUR0zPaiCQzyv0Jrc
         AVJTDQT/xAkBSSC6xo6jBrfteuZFybKVlq+SQ2kZ2CoOOkclO58s7DER/2MUr/KoH89A
         bUmQvyXI2UPp68ep++ar7lqIDrV6Y6MzMeZ9bP/UIkSPwF2iaG6kmn+FEHBDyiJWwXOH
         MLlw==
X-Gm-Message-State: APjAAAV3vGMelBCWiTK7WHhhN9cWY85ubo054iXBLJ2wZidrDawVnM0b
        VUWerjkWdg7X/pLueBM8XrlpkmQjwWWuH30i39o=
X-Google-Smtp-Source: APXvYqz8OcUtfVOuYtY9vM92FJeb7vwx+aEfTMLxUtpPEsukwGnp+lTmKV8zSoH/4wrPplLbrSUZSgv+k4JOC27sq7o=
X-Received: by 2002:adf:eaca:: with SMTP id o10mr25116462wrn.273.1554831891684;
 Tue, 09 Apr 2019 10:44:51 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqimvpb0bd.fsf@gitster-ct.c.googlers.com> <20190409102649.22115-1-pclouds@gmail.com>
In-Reply-To: <20190409102649.22115-1-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 9 Apr 2019 13:44:40 -0400
Message-ID: <CAPig+cTxWGfCDxH7t=AS0jJqpAeScsvAs3UTPFE2K2V23bErcA@mail.gmail.com>
Subject: Re: [PATCH] Introduce "precious" file concept
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 9, 2019 at 6:27 AM Nguyễn Thái Ngọc Duy <pclouds@gmail.com> wrote:
> A new attribute "precious" is added to indicate that certain files
> have valuable content and should not be easily discarded even if they
> are ignored or untracked.
> [...]
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
> diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
> @@ -669,4 +669,44 @@ test_expect_success 'git clean -d skips untracked dirs containing ignored files'
> +test_expect_success 'git clean -xd still deletes them all' '
> +       [...]
> +'
>  test_done

Nit: The blank line before 'test_done' got lost.
