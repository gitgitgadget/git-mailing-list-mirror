Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 618831F453
	for <e@80x24.org>; Wed,  7 Nov 2018 19:06:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbeKHEih (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Nov 2018 23:38:37 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36577 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbeKHEih (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Nov 2018 23:38:37 -0500
Received: by mail-pg1-f193.google.com with SMTP id z17-v6so7717264pgv.3
        for <git@vger.kernel.org>; Wed, 07 Nov 2018 11:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YUFzdZQX5QZvq1SCpVh22qUCw1wjExH4/1LKbTT/ILY=;
        b=sKeO0uP2/b2tGDGwsQAO+lC0cNuZaFwjk0EUjinJa+pWTzGSZ3ZWPlji598GqdWbdz
         Ifp+U65+HXwAXZownkXAepEYL3F70sP5ptME/JuOTJQPvUeEYSPSX8dPb0CUlTbIjCqz
         yK/MLRi1ugvyBF565bQzJCccU+848pQv3YmrYEmU+ET3WL32kKvmC2/h/PfnTrdTHGPR
         OAm4yxxw7RJ2hHE2kbqOJMBIIk5NNxelhVMMUyKEQH3xvzUhxB0n/tT1dygD8+J1zwF9
         vC39GXQS+cJgXdg0W3/SvhmCtrpv6ZCaVoKJ2tXbae/mlU2MlcQALdWjvEppU6yvIRqx
         uUBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YUFzdZQX5QZvq1SCpVh22qUCw1wjExH4/1LKbTT/ILY=;
        b=VCzW7eoN1jJLinFo1JHQ7wUiaN5F6kS7z0nUZUBPxaAQgQRNNDvXCdSRn5TMguWeu6
         Dj8xJNjd/dUxw5XuggkVOo1MM/0dW6xfa/8T+5oXbRlxGXhDDfiTkwtSewlSAgbxqIFL
         e1jbLeuHIRkRDOnWM4ypvAkClBJv0eU4niGxSOtAwNg0lnkMxrYLHA5HpVSDFvNeSOSE
         UilW8MHYQobcrM2/0O2baB0EEJvHjN9rAofs9qSDLrKzi4/hartiMPjmUgfNhGieEITp
         diPWia05jakyxzMhB8Zq7g4D+qzkfPktUiBhA+xkWpPuPNW4ok9LMI75PCOtWe8KnB7I
         Oz/w==
X-Gm-Message-State: AGRZ1gL6Vt7bgU6F0ljcEIort0zKfSm4v2+xLzPHKgyVcIM+DoK7/xaW
        cWi3NLWvr7InrpAOAQ3eAWXitk3iN524QchvJos=
X-Google-Smtp-Source: AJdET5exYr3pHI9WfTwxYMVZgxx++o/WdtrkhkGb7e3pu8b5kmS94AAxq/uDCEc/UJ3lq+5EWNaTtOP0uBZx3YaoeKc=
X-Received: by 2002:a63:b90a:: with SMTP id z10-v6mr1196697pge.221.1541617616524;
 Wed, 07 Nov 2018 11:06:56 -0800 (PST)
MIME-Version: 1.0
References: <nycvar.QRO.7.76.6.1811071202480.39@tvgsbejvaqbjf.bet> <20181107122202.1813-2-avarab@gmail.com>
In-Reply-To: <20181107122202.1813-2-avarab@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 7 Nov 2018 20:06:42 +0100
Message-ID: <CAN0heSqPGQOYYQOc=J4NRJbRC1yCd4NTUi3nh5Dt54eCHTib8g@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] range-diff doc: add a section about output stability
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, lucas.demarchi@intel.com,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 7 Nov 2018 at 13:22, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab=
@gmail.com> wrote:
> +
> +This is particularly true when passing in diff options. Currently some
> +options like `--stat` can as an emergent effect produce output that's
> +quite useless in the context of `range-diff`. Future versions of
> +`range-diff` may learn to interpret such options in a manner specifc

s/specifc/specific/

> +to `range-diff` (e.g. for `--stat` summarizing how the diffstat
> +changed).
