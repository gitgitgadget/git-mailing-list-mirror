Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9B27203EA
	for <e@80x24.org>; Sat, 10 Dec 2016 11:03:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752845AbcLJLDQ (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Dec 2016 06:03:16 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:33899 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752704AbcLJLDP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Dec 2016 06:03:15 -0500
Received: by mail-io0-f196.google.com with SMTP id y124so11911956iof.1
        for <git@vger.kernel.org>; Sat, 10 Dec 2016 03:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5EeOYKQNS7aUtRckFfqmvzlnkSlzADGozkZ22y0iIRQ=;
        b=iYnm4o5Xrxvw+km1HauOqOzWC+zYcUSnHr8dwTNeGg7B6xPZOSHqBC7hLelZ5tY7y2
         uKdGR1vLWYaFzpdJlX0qttK6cgaizZaOMNw2pbqCP1/q1ql8ZX1/+k3DKsfgQ7MGCuCU
         Ijq4I+dERsb0UiTgSn3czkwLZ1JUppm8Kk44RM+LpjTBDTHksogEucuYqXGdJI11KhoJ
         +h66MJj0E9nA3/cBNFGW/W5Np3oqSDDzMC4NPKySdaK1GPxcX9ZTSERCeM8EQKeAhVYE
         7JQ6WDt0xLOtWB4/7W0f6ljeqrZJZgQeDWLfucSW4PbFO4MDv6poN61P7f6TI7TVGvf7
         vjoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5EeOYKQNS7aUtRckFfqmvzlnkSlzADGozkZ22y0iIRQ=;
        b=lvh7ENGDMUKK4DghYJFVZeTT1y+tdxWy1v/DN7UVMQaTjSYAjDz3/1h4SR7z4g2KnQ
         UN+o+RdlpqYgMLe6/aGXkwv5BmaWBb+XlEjDNM5VrdUDA1qT9aHyGLwvtWjd7f8PoWI8
         uSz6F0hTRO9HiXIVn7jlRAjEtONTp4cub4LtbwmypswkaJ0yDIeIEjIT1NMaQjN3+3AL
         riwElbCKtVlXv7Tvt9wpCDW+/NWNzS3F6i5qXwY5Z5tGO/lkwFc/kaG0RYGYUTobI0Mz
         TiHNKJPghshOV3F1ffrazx2/UU+bXPHYN4Q/SRP5A/QYPE+m4dLbti7VQlg29d+GNTX6
         qBAA==
X-Gm-Message-State: AKaTC01CtrpPfLe9+LN0wuYKEkzRwscNC5LWub6OwFYd08Cvhv2CGvB+nQCtMpl/ahj11veZVNeovTXakt4l5w==
X-Received: by 10.36.66.76 with SMTP id i73mr10509507itb.50.1481367794932;
 Sat, 10 Dec 2016 03:03:14 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.69.3 with HTTP; Sat, 10 Dec 2016 03:02:44 -0800 (PST)
In-Reply-To: <20161209194232.GC88637@google.com>
References: <1480964316-99305-1-git-send-email-bmwill@google.com>
 <1481241494-6861-1-git-send-email-bmwill@google.com> <CACsJy8A2M_G34MeHh6vGsrf5ePOOduM6u=n17_EZLtu31uDAYg@mail.gmail.com>
 <20161209194232.GC88637@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 10 Dec 2016 18:02:44 +0700
Message-ID: <CACsJy8C=0SPYcwC34zTzfVg=U8xiN=XYWuiEVqP_OK5dJF_SfQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] road to reentrant real_path
To:     Brandon Williams <bmwill@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        Jacob Keller <jacob.keller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 10, 2016 at 2:42 AM, Brandon Williams <bmwill@google.com> wrote:
> On 12/09, Duy Nguyen wrote:
>> On Fri, Dec 9, 2016 at 6:58 AM, Brandon Williams <bmwill@google.com> wrote:
>> > diff --git a/setup.c b/setup.c
>> > index fe572b8..0d9fdd0 100644
>> > --- a/setup.c
>> > +++ b/setup.c
>> > @@ -254,10 +254,12 @@ int get_common_dir_noenv(struct strbuf *sb, const char *gitdir)
>> >                 if (!is_absolute_path(data.buf))
>> >                         strbuf_addf(&path, "%s/", gitdir);
>> >                 strbuf_addbuf(&path, &data);
>> > -               strbuf_addstr(sb, real_path(path.buf));
>> > +               strbuf_realpath(sb, path.buf, 1);
>>
>> This is not the same because of this hunk in strbuf_realpath()
>
> Then perhaps I shouldn't make this change (and just leave it as is)
> since the way real_path_internal/strbuf_realpath is written requires
> that the strbuf being used for the resolved path only contains the
> resolved path (see the lstat(resolved->buf &st) call).  Sidenote it
> looks like strbuf_getcwd() also does a reset, though more subtlety,
> since it just passes its buffer to getcwd().

Yeah that's ok too (I did not see this subtlety when I suggested the change).
-- 
Duy
