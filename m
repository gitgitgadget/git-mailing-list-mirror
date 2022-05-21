Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C91C433EF
	for <git@archiver.kernel.org>; Sat, 21 May 2022 15:07:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244656AbiEUPGv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 May 2022 11:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243649AbiEUPGr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 May 2022 11:06:47 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926F83E5C9
        for <git@vger.kernel.org>; Sat, 21 May 2022 08:06:46 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id y15so5474690qtx.4
        for <git@vger.kernel.org>; Sat, 21 May 2022 08:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uXDdGx24lxiyGGrpOL3amJeFXzjIKzBmvwRYrPA9aJc=;
        b=KgDHQ2Bf26pX/Xvlt3VFVcFkXXsSWJd03yzBdX5TQUZE8ldIsA+mjXFHlcK2QoUlRs
         g2GRzKYtNGMxPkj0t7rPcw0d9gTymvsHhGf+S7b5FU+GLouG+Cff9qw4LT0Qui/uRQ0E
         MeBEkSFFudNddt4RhiYaCOiOynEfLCGmSK6cnThu/DXJAhUqBjqS0j9tzTBgRYRY43DH
         RYr1crxdY06SY1LQ3231s0Dwodql5m0G7u8JhTtzHDMNLes3FWw0w0vOf6BzSZmK9xI0
         5sOO0BrYG7+bgC+RjukHjyFYDzTP2n7jcmYKTy9EkfMr1hpC3ppx4gJilGRBFJyMpi4G
         bNFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uXDdGx24lxiyGGrpOL3amJeFXzjIKzBmvwRYrPA9aJc=;
        b=dwte4iMqVUkHUX4t9W7YGBFHaD7EtJImJwQd5HLoOh7KwWh10uo345dIeYNCPSyUEd
         b5inM0jMrReZtyl6xp6VBEZBQ6pBlT3alMvdA/a7dGBMPMscW7ZXhvYsHfzUekYsgTSn
         o/QHRZTmYcl5ZlYqBKsr3srsNy41x1jt6FGyxe/VNbCwDBwPaEIqz8VieS5cqmOJKbRb
         EkHHCL2ITe+2cEj25xVMGAeUt0aYQErjsE7mEWH9sp/wb2XYZ55DhskejQ36WF4k67xC
         9u6aQi6tI0NptnxWvUNh//DzmMp3pQzIWW53vMUY9KLkFC4Rgq20E/pg1JtXGjCT79Oi
         skNQ==
X-Gm-Message-State: AOAM530WKKPh1W/wjKWYKMO3E62gPLqrcX+fPERdgPNPqvX5+UoPky61
        ruudrSRXrccAkPh/QguHNV8ubByV/XXgJD4YrY8=
X-Google-Smtp-Source: ABdhPJxWUFbCXNzCRc7pFCYRwUzXh8pesj+cmdd0ETQDxUVawNshZ40CNfADI+F8O3dnoYEtoRQ9I5miPSlVY+i2DeY=
X-Received: by 2002:ac8:5896:0:b0:2f3:d231:58a9 with SMTP id
 t22-20020ac85896000000b002f3d23158a9mr11272540qta.131.1653145605702; Sat, 21
 May 2022 08:06:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220503132354.9567-1-worldhello.net@gmail.com>
 <20220519081548.3380-10-worldhello.net@gmail.com> <xmqqfsl5phjw.fsf@gitster.g>
In-Reply-To: <xmqqfsl5phjw.fsf@gitster.g>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Sat, 21 May 2022 23:06:33 +0800
Message-ID: <CANYiYbH3D5Kk3W1LX-v7pgWU+fEgXs_JEbF+wJja6Ctkj6ZKvw@mail.gmail.com>
Subject: Re: [PATCH v2 9/9] l10n: Document the new l10n workflow
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        =?UTF-8?Q?Matthias_R=C3=BCster?= <matthias.ruester@gmail.com>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        =?UTF-8?Q?Christopher_D=C3=ADaz?= <christopher.diaz.riv@gmail.com>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>, Arusekk <arek_koz@o2.pl>,
        Daniel Santos <dacs.git@brilhante.top>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        Emir SARI <bitigchi@me.com>,
        =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Fangyi Zhou <me@fangyi.io>, Yi-Jyun Pan <pan93412@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 20, 2022 at 1:18 AM Junio C Hamano <gitster@pobox.com> wrote:
> XX was called "the two character language translation codes"
> (mouthful isn't it) in much earlier part of the documentation, but
> here it stands for more than the language part.  I wonder if that
> is confusing and we'd better use something other than XX.
>
> In any case, we should define "locale" and tell the readers that
> language "XX" can be followed by territory "_YY" that clarifies the
> variant of the language, probably at the same place where we
> explained the two-letter language code and to the same degree by
> explaining the two-letter country codes and where they come from
> (i.e. ISO 3166-1).

May change like this:

-- snip --
@@ -9,8 +9,15 @@

     https://github.com/git-l10n/git-po/

-The two character language translation codes are defined by ISO\_639-1, as
-stated in the gettext(1) full manual, appendix A.1, Usual Language Codes.
+We will use XX as an alias to refer to the language translation code in
+the following paragraphs, for example we use "po/XX.po" to refer to a
+translation file for a specific language. But this doesn't mean that
+the language code has only two letters. We should know that the language
+code can be in one of two forms: "ll" or "ll\_CC". Here "ll" is the ISO
+639 two-letter language code and "CC" is the ISO 3166 two-letter code
+for country names and subdivisions. For example, for German, the language
+code is "de", and for Chinese in mainland China, the language code is
+"zh\_CN".
-- snap --
