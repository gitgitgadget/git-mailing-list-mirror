Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AC501F51C
	for <e@80x24.org>; Wed, 23 May 2018 03:20:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753787AbeEWDUy (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 May 2018 23:20:54 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:37884 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753732AbeEWDUx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 May 2018 23:20:53 -0400
Received: by mail-pf0-f175.google.com with SMTP id e9-v6so9758812pfi.4
        for <git@vger.kernel.org>; Tue, 22 May 2018 20:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=hleeMZohNS0OBH/qoPQzwtLknXfNFyvXIcMdNybjKmk=;
        b=Vt1FFekjiq8Rziq/OrAU8JUiuqbNRU8bkqen0kdNA3mBruvyNRCyDPmfW98A0p6bha
         WISdT5loG3oIc3k0o3DZ0k62wMsGLUcTc7W6J6pLR+H83OgZtxkshotCys/+mep8cdNH
         L1PDb3F7PI2AEaV01BiPJbWH3LlH0LUmB1gKEpYVp8xXrvt9B56xvHbCiyR6NBDH2XfA
         zMCaAOm11Z7A5mBRlQD8X+cTSAf4L+xpLRvqtr7WokkQdVSx3mRhuU4HgT9EEAnyXlTu
         W/vV3ZwBpvkkdf/Qz2laATu3IGy2uKjr1cWs2ctQoQ9gp+jf9mM4qXYqG3nuxqEmIv0N
         hlVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=hleeMZohNS0OBH/qoPQzwtLknXfNFyvXIcMdNybjKmk=;
        b=IcCMGmQ2cBlwTBvQ8jOS44JvaYeUKqdm+vF6PRYFy1DcwhORymMc7DWvMvYT3T5ya8
         0dRgmLmzLRzBia57izIuwVr2kC71BjLLXmPRzFfoDlup4DkGoAifDLbT1LOIQ7Vrh070
         DWR7jKX+veIcQtAaDKpphxvvvk5LyDrABF7xSd9jPV6OEN1nSaFc0eKyC+wdnmzx3yK0
         LCrC5rx9IiEeEXu9pMTNpOL72xkK+h2UEG4iQkaX7KgkGaXWnsN36qagpJSR6gI/Z/4Z
         ru+WmdHzLTuM/Eu7ss9KoRWS4XhqH7O2Q95/CR86Z3yd6Z+60rd1h00LOonHApK5Zhfl
         27kA==
X-Gm-Message-State: ALKqPwc+OMRdZIyiHkWBoAdldqUqIj0wF7KqaQUZMNev7L75UMuR/t6v
        ZlIiHlko4zP7Be4XpTb/g80=
X-Google-Smtp-Source: AB8JxZp64r7WA8UCfKGlUY2ClLTgGLx6TvPryFl5UIIPR5lAzDZVopFMjdfBHsTSNJqqCsR7ztpY2A==
X-Received: by 2002:a62:f58b:: with SMTP id b11-v6mr1089457pfm.113.1527045653026;
        Tue, 22 May 2018 20:20:53 -0700 (PDT)
Received: from [10.17.11.41] ([117.246.23.215])
        by smtp.gmail.com with ESMTPSA id h75-v6sm34989827pfh.148.2018.05.22.20.20.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 May 2018 20:20:51 -0700 (PDT)
Date:   Wed, 23 May 2018 08:50:42 +0530
User-Agent: K-9 Mail for Android
In-Reply-To: <e0029f5e-87eb-7531-c32d-9a58469faaa5@gmail.com>
References: <67e6d306-0885-9340-13c8-3e3d4333dc20@gmail.com> <ef15b063-c0e3-a5e9-7418-35d2d6b954f3@gmail.com> <e8a81d38-57d7-2974-b5c7-3489e8ceb1fc@gmail.com> <68b913de-8f4a-9203-1d63-32104a35628b@gmail.com> <be353b0e-1cba-3765-b920-f7307f9b7d40@gmail.com> <nycvar.QRO.7.76.6.1805171106370.77@tvgsbejvaqbjf.bet> <1729567e-3b95-ab37-d845-1980795542b0@gmail.com> <e0029f5e-87eb-7531-c32d-9a58469faaa5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [GSoC] A blog about 'git stash' project
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
CC:     Git Mailing List <git@vger.kernel.org>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <F0339A6E-C416-41C1-B1F4-350B103A87AE@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 21 May 2018 01:03:22 GMT+05:30, Paul-Sebastian Ungureanu <ungureanupaul=
sebastian@gmail=2Ecom> wrote:
>
> I actually wrote a=20
>short paragraph about one of them (the one regarding -p option) on the=20
>blog (the first post)=2E
>

That's interesting=2E I didn't realise that you wrote about one of the bug=
s in your blog=2E I might have missed it, somehow=2E

Anyhow, it happens to me all the time ;-)
--=20
Sivaraam

Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
