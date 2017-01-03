Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 357041FEB3
	for <e@80x24.org>; Tue,  3 Jan 2017 12:14:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756676AbdACMO5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jan 2017 07:14:57 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:35951 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756245AbdACMO4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jan 2017 07:14:56 -0500
Received: by mail-it0-f66.google.com with SMTP id n68so50531259itn.3
        for <git@vger.kernel.org>; Tue, 03 Jan 2017 04:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hOmXyOtrxhphRJyQYtr8bXIau5vctRkVpR07LVGWQUo=;
        b=vAMx6sjYcZ9g3P4SF2/AK7PtthnA74Wx+yeQB5SltpNlsd1TPf4CY29NCOjyDSR/ll
         Y9+D7exp4q7VlU1/uAASQGhFQGS+oPhCbWon5aOQqnmEdJqJIYxJhFZBlyA068z98PR4
         ofexCF/rFg6FosjMDaLE2B9PQCQiuwgg/hY3jpEKSrI594/oIo9FRZdlE4qXeabA6Z5v
         jQxSjm/98tQbTCCXpH0f2Jkanc5vWljA4Zs6RzWy0Rbu35ubW1oXinFA3M0gPC1DduoL
         mIAbTwsa0aH5OpcHkdV6gqK+VFkBQyXvcHVieaD2fTMx8kstCCVLWo0a9CMB+S+x/ZW5
         yePw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hOmXyOtrxhphRJyQYtr8bXIau5vctRkVpR07LVGWQUo=;
        b=dFTQxHcyrT3iskl4gmld2E5r+7aMTMUrAncMH6JzsYh46tKH52DEFoBUPNKyIpKorI
         lAGi6z/6LYebGZmG8feWo1nQUss+g4qn+KcZ6Rd6MJl2niL902s3RuPqcCiX1JbfjYcZ
         ka1U6QZ+JLVBfpPQsr53WUYJ3pkksVVDqyxI/RuN5nllMz6K0MJgxbGAummHkwrXpi8W
         nz99cYqwWPL/K58sKgkAxp5/XocBOp3MRCzhSa47GSAnRaVv4gudRRr866Dg9rS0EnYN
         CsOluqput2OUs48GogW7Ocu+LzQgek4Ug4EdgQE+ESiJqDRm3rXWBjO8mVWo4Zj106vl
         aWxw==
X-Gm-Message-State: AIkVDXJODsYhFONY29n1T+0ncf6narX6yp0VkfP0I2GNZ+ka5thxUhsg7ogfs3MPpEGFOml+TiNdba3v2N64ww==
X-Received: by 10.36.66.76 with SMTP id i73mr50283221itb.50.1483445695768;
 Tue, 03 Jan 2017 04:14:55 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.69.3 with HTTP; Tue, 3 Jan 2017 04:14:25 -0800 (PST)
In-Reply-To: <1481670870-66754-9-git-send-email-bmwill@google.com>
References: <1481223550-65277-1-git-send-email-bmwill@google.com>
 <1481670870-66754-1-git-send-email-bmwill@google.com> <1481670870-66754-9-git-send-email-bmwill@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 3 Jan 2017 19:14:25 +0700
Message-ID: <CACsJy8Cja1um2oFDWufyk_7xaZbf9+=kyuWFx==Vb0nHiMqiwA@mail.gmail.com>
Subject: Re: [PATCH v3 08/16] pathspec: always show mnemonic and name in unsupported_magic
To:     Brandon Williams <bmwill@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 14, 2016 at 6:14 AM, Brandon Williams <bmwill@google.com> wrote:
> @@ -340,8 +336,9 @@ static void NORETURN unsupported_magic(const char *pattern,
>                         continue;
>                 if (sb.len)
>                         strbuf_addch(&sb, ' ');
> -               if (short_magic & m->bit)
> -                       strbuf_addf(&sb, "'%c'", m->mnemonic);
> +
> +               if (m->mnemonic)
> +                       strbuf_addf(&sb, "'(%c)%s'", m->mnemonic, m->name);
>                 else
>                         strbuf_addf(&sb, "'%s'", m->name);
>         }

The die() call is out of diff context, but it'll print

pathspec magic not supported by this command: (!)top

which looks too much like :(<name>)<mnemonic> pathspec syntax too me
and threw me off a bit. And it's a bit cryptic, isn't it? Since this
is meant for human, maybe we can just write

pathspec magic not supported by this command: top (mnemonic: '!')
-- 
Duy
