Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA5BC1F404
	for <e@80x24.org>; Wed, 28 Mar 2018 18:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752832AbeC1SF5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 14:05:57 -0400
Received: from mail-oi0-f46.google.com ([209.85.218.46]:35552 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752349AbeC1SF4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 14:05:56 -0400
Received: by mail-oi0-f46.google.com with SMTP id z8-v6so2930190oix.2
        for <git@vger.kernel.org>; Wed, 28 Mar 2018 11:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZK1FrhXPFc39PVIVehvssyEMeDnJ6/X4HFtow9ugHVY=;
        b=g6bk0giCxEQt4oBz/b5XIw2wrJ8UV0obi7h04Iq0WWgfL1S6wnSHvXthZlY4BUWbP8
         zuYGs87IkjaUDn+SQ6jQ0q1p4GOexDmvEmCPkSQODueXeTYmsQdnNqlKbtqP10Dmuy/L
         rMS+BFD2XN2QJXIXGkdJGjO3T3ij/bKcgmhI5a1qm3ohRzsOlkMaU/L8vtmlsEVrNOEJ
         5V6XrdPcvPulzLvu2sB+saYyPc6ovDXHPxo94XvBgluUvPcZz8ISUWZThYXgyBhrH7jz
         63rEtwhH/HWAbDiqf2ecAmwiD1Rv8CP7fqfG7Z1ZccK4dhQidgerw13n1CYDeYt+HzlP
         Bbbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZK1FrhXPFc39PVIVehvssyEMeDnJ6/X4HFtow9ugHVY=;
        b=p7lc4oiV4JqxhIfABhRLX6moC6v8CzQ2/P5kKutktjvR+B8hnVDyl14LIJwEZdn/rL
         qRFoOf6G3f++HINHuCtZnbv+A8eZiyA5yX5H8QT1vh8BRX9l5Cfwah17TzqfDhpp1ztm
         u0kEHUlyDW3GUjT77TMna8iUnT+Bxp46qeJUb1mCdJFztoM1zewD+eA2s7n7xB2iEIO0
         tZed2681dvI+GjI0org5K9p5/BXHhLUqdo+F4Jy2W7iUxUzh2w0e0XWcc+gip09R56zi
         iU/rpaEmeuRbB91X/rI6q/e2AnK4vhgCtEhGkogNR8K2+XD24DklJP8YvlGA+zNR+t40
         1LHA==
X-Gm-Message-State: ALQs6tCXwEVXeDVWLRzuOhDm6RZC79Fe2QBF8P7w2c4Pd4OgdE7lOW6B
        0C29lS6pJzaas6Pe0fuQ/Z0NehiVhVsP1FglfrQ=
X-Google-Smtp-Source: AIpwx482AixBMdRMDK5Lrgv3Bsj+4Z7Un9WTr3ux9IAW+DtKKqcqjKXeliXz8mhE3cwR9Qk3Trws4lxgd39CVEgVwXY=
X-Received: by 10.202.64.85 with SMTP id n82mr2687301oia.30.1522260356293;
 Wed, 28 Mar 2018 11:05:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.211.131 with HTTP; Wed, 28 Mar 2018 11:05:25 -0700 (PDT)
In-Reply-To: <CAGZ79kbofCd+8iscOFUNHTfQ2Y1cUDUjp5kOQQr_b1uPgPC2Eg@mail.gmail.com>
References: <20180328094733.GA1523@sigill.intra.peff.net> <20180328175537.17450-1-pclouds@gmail.com>
 <20180328175537.17450-3-pclouds@gmail.com> <CAGZ79kbofCd+8iscOFUNHTfQ2Y1cUDUjp5kOQQr_b1uPgPC2Eg@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 28 Mar 2018 20:05:25 +0200
Message-ID: <CACsJy8D6h_t0LTD6ML8o4imEaU7vqxZJyzaBU6McCfVqWOQkWA@mail.gmail.com>
Subject: Re: [PATCH 2/8] strbuf.c: reintroduce get_pwd_cwd() (with strbuf_ prefix)
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Rafael Ascensao <rafa.almas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 28, 2018 at 8:02 PM, Stefan Beller <sbeller@google.com> wrote:
> On Wed, Mar 28, 2018 at 10:55 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy
> <pclouds@gmail.com> wrote:
>> +/**
>> + * Return the current directory, fall back to $PWD if the
>> + * current directory does not exist.
>> + */
>> +extern void strbuf_get_pwd_cwd(struct strbuf *sb);
>
> Please see 89a9f2c862 (CodingGuidelines: mention "static" and "extern",
> 2018-02-08) and drop the extern if you need to reroll.

I'm aware (and in favor) of that actually. But this whole strbuf.h
uses extern. Either I had to delete all extern first, or go with old
style and maybe do the whole deletion later. I chose the former. Maybe
be I'll delete all "extern" as a prep patch.
--=20
Duy
