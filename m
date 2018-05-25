Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DA871FD4F
	for <e@80x24.org>; Fri, 25 May 2018 21:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030258AbeEYVQk (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 May 2018 17:16:40 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:35407 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030216AbeEYVQj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 May 2018 17:16:39 -0400
Received: by mail-qk0-f196.google.com with SMTP id h140-v6so5120618qke.2
        for <git@vger.kernel.org>; Fri, 25 May 2018 14:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=XlyU0iInkyHMgcftRL1Hgke10rAo5YWrfKNeXFlqG9Q=;
        b=lF0cOuaaMbSVdYmtPMRRA3G45+YZbsKDgnnqy84vMIQ7t5+TopIvXE4kFEK3EGY7CI
         bL3Z/5r+iwueD3SkW3BnGPwgfzdF8OXMRjzkO6+U9a+nx/ejhC0zslz9p74VlEgxwNpS
         Tw0aEpPVZidvEcY2Uv4aJA/LwiT8mjCEWTgMl5apbEWXXzeg/7uG7V0fGb2N2nf9XxH7
         S1aYSnLA+MZP6dLoifOBPhjYcd52oVo+7JKA+SjTZq9uUt9ySK/ny4grmHjKr3pzdJju
         O50AoDXwsH5Q2ZBeUtol/Gu5pq98OzLuydif/+Z7nZW/V/Ujt5t74idQPW4/Xd3mj9oC
         W0ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=XlyU0iInkyHMgcftRL1Hgke10rAo5YWrfKNeXFlqG9Q=;
        b=STw7DTgZrVOFgaM2IDDlBq6XwE65ZutEvO6L5SIjINZS21YYxmJ1C8dwZuTsPGJjAS
         0n3S26Dyod3VZLIEpA65Xphz9Xqt5oRyit7mfpJ/UI9keFdA81iVspLPyyJxuk/qOtpD
         wht3kMkwDMitOu+arF23KXc2q9F9typu/2ob3QL3lBVZhOx5Ld8RwfLnD+5tlCMKS4N1
         mO2hEcOnWCMVun6THoyFfNZ+hkZ9Y0aj1EU7i4ZB+3YOFWdM3VjralxEi0wH3csXOwIZ
         ulLuZF0irgH9vCpc/XGndBhfGc6xFv9mvrNNdTjC1hi393b4tVMECwAzPYRJTITqyo9S
         9dWg==
X-Gm-Message-State: ALKqPwew1UIt0pYohkRp4hPkI26qJbCP4z2oquegVvqZDrTZv0lWmdtG
        O+4MEU+3NF6RhDbL/matQjAit4+gaZWko1GGaw0=
X-Google-Smtp-Source: ADUXVKJR5+TjqypzFgizeyxUNaAJpDyDqKh/kDFni0E7BGVoQP/spd4Mvs0CBWmD5Wq9mSX/w7d8Q4SMRa+WyhRje9E=
X-Received: by 2002:a37:6d04:: with SMTP id i4-v6mr3451464qkc.361.1527282998911;
 Fri, 25 May 2018 14:16:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:aa4b:0:0:0:0:0 with HTTP; Fri, 25 May 2018 14:16:38
 -0700 (PDT)
In-Reply-To: <20180525192811.25680-3-avarab@gmail.com>
References: <20180524193516.28713-1-avarab@gmail.com> <20180525192811.25680-1-avarab@gmail.com>
 <20180525192811.25680-3-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 25 May 2018 17:16:38 -0400
X-Google-Sender-Auth: gdcMlg4S6k17rF-Y6TkuV1T6p_E
Message-ID: <CAPig+cT=i0XYOrMymNjsBJqcLfJ38Ft_=MZPZD3N-AMo8raAHQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] config doc: unify the description of fsck.* and receive.fsck.*
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

On Fri, May 25, 2018 at 3:28 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
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
> @@ -1554,23 +1554,42 @@ filter.<driver>.smudge::
> +Depending on the circumstances it might be better to use
> +`fsck.skipList` instead to explicitly whitelist those objects that
> +have issues, otherwise new occurrences of the same issue will be
> +hidden going forward, although that's unlikely to happen in practice
> +unless someone is being deliberately malicious.

Is it worth mentioning buggy tools and/or other buggy Git
implementations as sources?

>  fsck.skipList::
>         The path to a sorted list of object names (i.e. one SHA-1 per
> -       line) that are known to be broken in a non-fatal way and should
> -       be ignored. This feature is useful when an established project
> -       should be accepted despite early commits containing errors that
> -       can be safely ignored such as invalid committer email addresses.
> -       Note: corrupt objects cannot be skipped with this setting.
> +       line) that are known to be broken in a non-fatal way and
> +       should be ignored. This feature is useful when an established
> +       project should be accepted despite early commits containing
> +       errors that can be safely ignored such as invalid committer
> +       email addresses. Note: corrupt objects cannot be skipped with
> +       this setting.

Not sure why this paragraph got re-wrapped (without, as far as I can
see, any other changes), thus making the patch unnecessarily noisy.

> +Like `fsck.<msg-id>` this variable has a corresponding
> +`receive.fsck.skipList` variant.
