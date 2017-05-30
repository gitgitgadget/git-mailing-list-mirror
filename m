Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0ADB22027C
	for <e@80x24.org>; Tue, 30 May 2017 14:36:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751501AbdE3OgF (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 10:36:05 -0400
Received: from mail-io0-f170.google.com ([209.85.223.170]:33845 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751370AbdE3OgE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 10:36:04 -0400
Received: by mail-io0-f170.google.com with SMTP id k91so57538285ioi.1
        for <git@vger.kernel.org>; Tue, 30 May 2017 07:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HUYxtcY6SN0dOgW/YaCjvtrnFL5hdxRNIlokPM5wlIc=;
        b=LExq3bQ6FMatW6dxexcQDkoob5mJncEYWkMh9ba6449iGIoNJ1WYPjAsbb1L3iXkmL
         5T9Hw91rtJ/w9s1Tas8AteFGqxQfAn3LLNh5ybGdcdsBjtJo3DN4CPWfyquqbZ/52IHA
         GfnhZZcq2hicGkEBSEtLlVU7WwywijKKkO+630o+AuW16NgSNOKzYZqKzvnzO+Ii4KAS
         lIOjdqcZYRpNn+GxT+2OGmgitlimN81841fCUIirQEF3Q4nDc474lSbB500L1hvdeHRx
         xYc3QNJFlBNKZHlYc8NWcxoDmZAxOqNlW9K0s7rEBsZlApxEC6PazbcwxElFdYgMHk02
         WwEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HUYxtcY6SN0dOgW/YaCjvtrnFL5hdxRNIlokPM5wlIc=;
        b=MF1pgqrSTXnj3NDR7/EvRACSWhgrldPKNoy7rDlctVWjkTKFddNTDaXflpKzWgx8Ty
         EAkIE4gVYeXKWpiU3B22IflO7q+TAz4mcf1SiHM34Frondihe+3E4/hnOO2VuxYMWNY9
         /ZuPYHVaPo7pC7fYUtMTL8+zj5NW55xqAiWYf4DqR7W1GBuRDsKWQI1yVR8tW8lw7vUc
         TM+24HFsApA+zxA2H8TDEsbj6wXyRY2E3xNvwclJ8DzZsZB8lYV6rsUizpgfhcGClMoa
         7jxpLQPjxf93J0vaGF/Ae7ptGhQHqKqE8MuqTrmLamx3uW3cRmIwjGOw/2PEpN4NWlKk
         JiwA==
X-Gm-Message-State: AODbwcBefSqlCML6dbi7LzDe5JJk+mqz3FenVhTt/ARAUVrz+rE6jQfI
        bVptR5BuqB6gmjz7PCEPMgaAvux0Ww==
X-Received: by 10.107.138.21 with SMTP id m21mr17387581iod.80.1496154963473;
 Tue, 30 May 2017 07:36:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Tue, 30 May 2017 07:35:42 -0700 (PDT)
In-Reply-To: <xmqqfufmbh4f.fsf@gitster.mtv.corp.google.com>
References: <99ac8ee7-67b5-5ae7-51cf-6be38de6217f@redhat.com>
 <CACBZZX5U=U1bpiFuuxH2t8ZWnmQQAjWm1ji8XYq_6-SJPGL1sw@mail.gmail.com>
 <c2453701-979b-ebc7-dcc3-483a27d4c157@redhat.com> <85970ab4-e9c8-c6b6-11d3-faafd3ed0708@redhat.com>
 <CACBZZX4-T50q_eVWwJuBzoC6ocuG+v14Tm8wfK8h7FB_cMQzdQ@mail.gmail.com> <xmqqfufmbh4f.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 30 May 2017 16:35:42 +0200
Message-ID: <CACBZZX7x7s-RfQMZjHuq=fbGtOeQzYin_Owqx7dK3v7dudh8zA@mail.gmail.com>
Subject: Re: FORMAT_PATCH_NAME_MAX increase
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Laszlo Ersek <lersek@redhat.com>,
        Git Mailing List <git@vger.kernel.org>,
        Thomas Rast <tr@thomasrast.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 30, 2017 at 3:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> Just curious do you know about https://github.com/trast/tbdiff ? If
>> not it might have a high overlap with what you're doing.
>
> Yes, that is a very good suggestion.  You'd need to be able to
> actually apply the patches but the way I often do a review is very
> similar to (actually, I'd say it is identical workflow) Laszlo's,
> and it goes like this:
>
>     $ git checkout topic ;# previous round
>     $ git checkout master... ;# check out the fork point of previous one
>     $ git am mbox ;# apply the updated one
>     $ git tbdiff ..@{-1} @{-1}..

I wonder if this tool seemingly everyone on-list uses should just be
integrated into git.git.

I only learned about it <2 weeks ago and it's been great. The diff
output was a bit nonsensical in some cases because it uses python's
diff engine instead of git's.

Would you mind patches to just integrate it to git in python as-is,
then we could slowly convert it to C as we're doing with everything
else.
