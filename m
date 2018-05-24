Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3145D200B9
	for <e@80x24.org>; Thu, 24 May 2018 19:54:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968660AbeEXTx7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 15:53:59 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:41698 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967986AbeEXTx6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 15:53:58 -0400
Received: by mail-qk0-f193.google.com with SMTP id d125-v6so2295210qkb.8
        for <git@vger.kernel.org>; Thu, 24 May 2018 12:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=vZWsQ6sQlnFTYxVITV7wnkBjL0K9jgxpwCIU8Ufu7NM=;
        b=QEY6d6las4HnEIyVQj5ocBNQeJeDKgTYJmnNgce1OAjQnbcvEmkqkQciKXI8CeU6dW
         +gS24JDdg/o1SYTUItMMsq5okZLi90vyLPsDcgacnCJZhJJCpGRi9jPRREifIYaazqDL
         QNqqCQDWzI8/d7UTIVnqcGpxGZbEZYqvOgtXBvLgyRPy2AgwXHNXa/FTd/g35q3VFAn1
         maicxHdqE8/dOrcFhJaGjKgi+gNqK+c00V27ooVTo/ffo3uS65sm7zbutJQf9cFKGN+0
         j/mfy3baG1xDm+L8I9QX6Iqt5zuOMnbxK1/RsA79+cI2a8+L9ZxqR+7nxVxO/F03vYYS
         jbEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=vZWsQ6sQlnFTYxVITV7wnkBjL0K9jgxpwCIU8Ufu7NM=;
        b=aV6u97TvjWzQf0bjT7D8MH5pj0U6cEzdIdVbdELE+bp8z5jkNMpflVUyKgEDRp5BbN
         DtVZhchfuDVaAI/CjEwCTAJz8sjBTZXOmhGya4RauIkjandHKCXYXIoi+3Ue1x9IWx5k
         Cur/H6SvAWCNU19l3Uzf3VsErJv/DrRPUoPT3bMTg5Z7vw8ducoUFXpXrb1CE2Gh72UB
         0qBZW8l85PMzUfpM5eiST95tRCC6IVxi8VXtM0pKc7F36D3eBLurL96KUPG/5HxnUFUT
         sfEVT6xxDa0tCfokindEb5YWXw5tuBPMRWKVBdKdL55mpNKEyeIBEAc5n9s9cGdFWxNV
         dCow==
X-Gm-Message-State: ALKqPweqcnXXgn1/EedcppZE0qiAbY/+jAbcHwm4UWiQbHRV22lLvrHA
        Jp0LYTv1fkv7PVrpT9R4BbC6t0cF87O/D7bSn9w=
X-Google-Smtp-Source: AB8JxZr1j0BkXbmhX4u7lMdjv3mvxB9hmV7uVxf/+1NUZGDIqy2YmH5oQNRAnIqBdrVIg/rzEiNfPkxBK4LAiY4OQlY=
X-Received: by 2002:a37:6d04:: with SMTP id i4-v6mr7567839qkc.361.1527191637435;
 Thu, 24 May 2018 12:53:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:aa4b:0:0:0:0:0 with HTTP; Thu, 24 May 2018 12:53:57
 -0700 (PDT)
In-Reply-To: <20180524193516.28713-3-avarab@gmail.com>
References: <20180524190214.GA21354@sigill.intra.peff.net> <20180524193516.28713-1-avarab@gmail.com>
 <20180524193516.28713-3-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 24 May 2018 15:53:57 -0400
X-Google-Sender-Auth: tQl03gqFjKUBbxBwjWT52Ag3g7s
Message-ID: <CAPig+cTr2J6yj39NNdV1vT8CQP2qyPxNB1ggaE9bGgXukuq1yQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] config doc: unify the description of fsck.* and receive.fsck.*
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 24, 2018 at 3:35 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> The documentation for the fsck.<msg-id> and receive.fsck.<msg-id>
> variables was mostly duplicated in two places, with fsck.<msg-id>
> making no mention of the corresponding receive.fsck.<msg-id>, and the
> same for fsck.skipList.
> [...]
> Rectify this situation by describing the feature in general terms
> under the fsck.* documentation, and make the receive.fsck.*
> documentation refer to those variables instead.
> [...]
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> @@ -1554,23 +1554,41 @@ filter.<driver>.smudge::
>  fsck.skipList::
> -       The path to a sorted list of object names (i.e. one SHA-1 per
> -       line) that are known to be broken in a non-fatal way and should
> -       be ignored. This feature is useful when an established project
> -       should be accepted despite early commits containing errors that
> -       can be safely ignored such as invalid committer email addresses.
> -       Note: corrupt objects cannot be skipped with this setting.
> +       Like `fsck.<msg-id>` this variable has a corresponding
> +       `receive.fsck.skipList` variant.
> ++
> +The path to a sorted list of object names (i.e. one SHA-1 per line)
> +that are known to be broken in a non-fatal way and should be
> +ignored. This feature is useful when an established project should be
> +accepted despite early commits containing errors that can be safely
> +ignored such as invalid committer email addresses. Note: corrupt
> +objects cannot be skipped with this setting.

Nit: This organization seems backward. Typically, one would describe
what the option is for and then add the incidental note ("Like
fsck.<...>, this variable...") at the end. It's not clear why this
patch demotes the description to a secondary paragraph and considers
the incidental note as primary.
