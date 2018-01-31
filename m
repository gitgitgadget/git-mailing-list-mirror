Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22F271F576
	for <e@80x24.org>; Wed, 31 Jan 2018 09:40:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753052AbeAaJkt (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 04:40:49 -0500
Received: from mail-qk0-f193.google.com ([209.85.220.193]:41678 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752837AbeAaJkr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jan 2018 04:40:47 -0500
Received: by mail-qk0-f193.google.com with SMTP id l29so13896522qkj.8
        for <git@vger.kernel.org>; Wed, 31 Jan 2018 01:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=scif6HK6WoAqU4L5UxO4EeKspaiZup0lstEnCeppbEg=;
        b=oS9waXOiBs0Cy70hF4qH+zNOt7ewdFa/STjK44strPrLZhm2e3EeifueKDU4QhQOHc
         9GVM4MoTMx7swIln7Nto+xBQqo1NbnsbIarTLdGZNmAqK2TW0ALH9xnvOFY9QGmni6Sp
         V7eVyhVVQ7ORWB3nuWykV888znavJyaneQW7garWDkHFDtyvaFrUXCXMvkQ991m9U7c9
         WW1K/oZQIW22BB6Y/F2xiuND2mFhWLW8cmcgVBE1MjPjKuBQ0+TLyAqtrx+gKYzJ2kJ7
         mBbguXncKmbDCfbF67ASGY1yqzNn2GlxobZw32ydsGXh7tkRWTgtEnT1rR3wisMwB6MN
         iZXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=scif6HK6WoAqU4L5UxO4EeKspaiZup0lstEnCeppbEg=;
        b=VVS5r9T141vQ6u2dc6ymSai48JEgaBGHTE3Pd3Pw93q7nB2iLbHRtVdHUyrRE/exB5
         bgxo0TQETV1HuWtA2iMu+OxzkLib7J3/POBuf9g199MNT/PX/snYWReDENs/lN0dZDuC
         iueOV8nBPikgmnWVrg2tZjBvk3ZOu/CDCcnMgByj1Q4fuP0weV7UwPTz5q1mw7bkKyAD
         p0VLhN4lgSg3QQQKrZTQajzi89sQtb9pGNQr6YnUMHaYUQMtAMOa/aCgZDJhV4Ue44Md
         mRjRkNjxFbuOZV03CmbO155a6+bbuRjG6L8+p8dwe0wqLNmFxvQ0L7gpPJTp1y95Ed7i
         6Dhg==
X-Gm-Message-State: AKwxytefDaYUkb9sN0xN4UDUon+jt8Z1poFTEEjGNb34pf+oGH/yP4Hb
        82e9KTH/IEDNAiVkSoA4PGlo8P/engyGUZdEfbc=
X-Google-Smtp-Source: AH8x225CEvrsyYYJH4/CJfTHxn+52KhPkI7Ui+wz5WbCKjlskh1PfLJMKPXzrWE+xnefiu4rOyYjv32bz+XUUtmx9b8=
X-Received: by 10.55.177.135 with SMTP id a129mr17606704qkf.112.1517391646813;
 Wed, 31 Jan 2018 01:40:46 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.175.239 with HTTP; Wed, 31 Jan 2018 01:40:46 -0800 (PST)
In-Reply-To: <20180131093051.15525-2-pclouds@gmail.com>
References: <20180126095520.919-1-pclouds@gmail.com> <20180131093051.15525-1-pclouds@gmail.com>
 <20180131093051.15525-2-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 31 Jan 2018 04:40:46 -0500
X-Google-Sender-Auth: hksrBPnCDjPMpv9gk--vJxS4584
Message-ID: <CAPig+cR24=0_NPekYaF+oG9OovDkv1Et-RpNvAHqE7Qd7g7QQA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] am: add --show-current-patch
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        tim@tim-landscheidt.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 31, 2018 at 4:30 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
> Pointing the user to $GIT_DIR/rebase-apply may encourage them to mess
> around in there, which is not a good thing. With this, the user does
> not have to keep the path around somewhere (because after a couple of
> commands, the path may be out of scrollback buffer) when they need to
> look at the patch.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> ---
> diff --git a/builtin/am.c b/builtin/am.c
> @@ -2121,6 +2120,22 @@ static void am_abort(struct am_state *state)
> +static int show_patch(struct am_state *state)
> +{
> +       struct strbuf sb =3D STRBUF_INIT;
> +       int len;
> +
> +       len =3D strbuf_read_file(&sb, am_path(state, msgnum(state)), 0);
> +       if (len < 0)
> +               die_errno(_("failed to read '%s'"),
> +                         am_path(state, msgnum(state)));

Isn't this am_path() invocation inside die_errno() likely to clobber
the 'errno' from strbuf_read_file() which you want to be reporting?

> +       setup_pager();
> +       write_in_full(1, sb.buf, sb.len);
> +       strbuf_release(&sb);
> +       return 0;
> +}
