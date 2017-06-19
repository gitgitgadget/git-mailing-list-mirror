Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E59E81FA7B
	for <e@80x24.org>; Mon, 19 Jun 2017 15:45:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752557AbdFSPpr (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 11:45:47 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33257 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751757AbdFSPpp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 11:45:45 -0400
Received: by mail-pg0-f67.google.com with SMTP id u62so11014616pgb.0
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 08:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ozayVKORv5bZila6Jq4oHnHlxNE+lWyGHloDeIL0u2I=;
        b=KXvr8/Hrwg4tkdUQz7aT23R1PU8djxOQF6L37sBExn9qHv/3JuM0d0rxVCNDkrdbsI
         MGiKIU4KE5F1qGW42mShN1Q4FLRrTHzSTkQezsHl0hdtAOikCxN+AzQBCIZ6DZzNPiva
         BQAtNfOZedKGIqMbmOxa/mtzD3Qda7vb0RX6SiSy1yAPVqCSnODANik7vaYSyGpsRqc0
         FrBeBz87v5pv0P7JErw9YCJQOIcLBiXPaWnY/SoTCLevS1sNWvfFaY7foZ2NprtxmPNH
         QPqlNqfpnMtmjhEiU4M+cBbpYoURGfiOPpyvUDyQqhkHQ+Qovr80hZSkbDO9vNDbhHCz
         +BWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ozayVKORv5bZila6Jq4oHnHlxNE+lWyGHloDeIL0u2I=;
        b=WVL0VIAyXEvem+gNJ9hPmhAKu+AIryf9Ol6lNrbSURpsFkxpccf46vXoc9oOqWIgkU
         aj7namsdGlLYEZtNjlZx3UF4isBuaUe7a83isyVQWnxXNCJ5C66ihDy/WXAaP7Gs8nhD
         LVtbeT4/kijOsIdx+cli8TMtnwEA0EwPVC5eXFOvpSrpFnma8Mgh+Y8QvAC502GGaOcI
         miQ6dNFTwcZ90vzNY410l2K1JvTeX4ZuHisugyr462bQgtNYD2zLKgp2jP8Ia62evY8L
         igg71jfzwXShCRq919dAAye9eHuw9c7SR5gEtNWSa5Tr4AOVkU46Yhopj8DzL2dvARQ1
         3AyQ==
X-Gm-Message-State: AKS2vOyqzLgiV0grVWdclRB+JkOGNtRrf3M8iyQ2xKm0GeQ3RLG5MOFn
        CA7nzunUXgngMilJImw=
X-Received: by 10.84.194.228 with SMTP id h91mr30284366pld.171.1497887139649;
        Mon, 19 Jun 2017 08:45:39 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:7466:3d2b:4ee9:fc7])
        by smtp.gmail.com with ESMTPSA id u74sm23371796pfg.20.2017.06.19.08.45.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 19 Jun 2017 08:45:36 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 0/3] Add regression tests for rectent rebase -i fixes
References: <20170531104213.16944-1-phillip.wood@talktalk.net>
        <20170614102427.5220-1-phillip.wood@talktalk.net>
        <xmqqshj0yhq1.fsf@gitster.mtv.corp.google.com>
        <xmqqk24cygvm.fsf@gitster.mtv.corp.google.com>
        <xmqqfuf0ygmu.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.21.1.1706161527140.4200@virtualbox>
        <969f3069-d386-a2ec-736d-e67d6f17a590@talktalk.net>
Date:   Mon, 19 Jun 2017 08:45:35 -0700
In-Reply-To: <969f3069-d386-a2ec-736d-e67d6f17a590@talktalk.net> (Phillip
        Wood's message of "Mon, 19 Jun 2017 10:49:57 +0100")
Message-ID: <xmqqwp88t200.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

>> Phillip, would you mind picking those changes up as you deem appropriate?
>
> Will do, thanks for the patches

Thanks, both.
