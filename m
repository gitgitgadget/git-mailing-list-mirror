Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5A21202DD
	for <e@80x24.org>; Mon, 30 Oct 2017 17:28:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932665AbdJ3R21 (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 13:28:27 -0400
Received: from mail-qt0-f174.google.com ([209.85.216.174]:52430 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932663AbdJ3R2Z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 13:28:25 -0400
Received: by mail-qt0-f174.google.com with SMTP id 31so17369071qtz.9
        for <git@vger.kernel.org>; Mon, 30 Oct 2017 10:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8rt9D2Aek4LIL7c2e29zUYJYJh9cntIWkkX/oIYKY+Q=;
        b=Ryu1Goj1Y0gk8Eb6ewBG9pG/F04UF3pY9DCY8K2ys7osixOMWDZvXbc+QWVIaF1j/Y
         WFI1U8oz4k6SQmoskAmeWareKQY+krpak1KfNSIOBg8SzBo7leX9Oxh3RvS+1+z8jLF2
         O43GfoPboIVPA2QAU2eWbWPF/AS7yR9gdpZL/5R5YVRAJffuDwDizSv3bnbuPkOhC4FC
         +UxuZZI+KCYLWyoFhY2CbssURHX2Uzbs32SV2Z2NGwR8tV63LPgYDN7eyNI4+KrhkEaU
         H2vq+4HUb6j2X3dT17LBJouJe/xGVLB/XQPy9EJQ32sJuF0YVU5WY4L/9wXCF5SjaGWa
         94Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8rt9D2Aek4LIL7c2e29zUYJYJh9cntIWkkX/oIYKY+Q=;
        b=DobGDFjbtFYL61Dqxjj26T8S8JSbsFESL6JQJ1B1+m74QXCr0XrkAm0/jGkfJoBxNF
         9RC0NJ7xFxM3gUoVeDl8Kry3/DUwg/W93SnOydwlHbtdssRJEG76z1HyAg4Ybtvcy1RZ
         Hdru4S8+nducsnDscx1jptX0gIpSG6l/0EMs+sPBWUywT1ySGNV7ZPdmWnwvxfEzy9on
         svTCNxZB7zHL+K35Tca9Yeg/0K51ci80ObNusQcC51f7Y3+X7esIHXUUN772gqR2FDcc
         P1pQtNzxCbgQhMcfrsj3mpdJoCJaHsN4RZYB2pHUEoa/wLXRhAWih1auHSbNy5MPnsFh
         Xklw==
X-Gm-Message-State: AMCzsaX9jSb6WAkqG+nKGIkpmfViD9fEtwrf3CvHOeaPM9l5r/d8NWPK
        s3YrlbGJZH9MSG60fV/M6kvpLYTG19cYxXn42G0=
X-Google-Smtp-Source: ABhQp+Q7KT7W9nH43Qa6GFUZxgd0DlBqR6zBlCWERD7nTxRajXTZdmbCakAOPH2ftXRLftkYQ0cuxf+uXOcfVEGvaRU=
X-Received: by 10.237.36.225 with SMTP id u30mr15156488qtc.13.1509384504161;
 Mon, 30 Oct 2017 10:28:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.28.246 with HTTP; Mon, 30 Oct 2017 10:28:23 -0700 (PDT)
In-Reply-To: <c26e1cab-a3d0-8cae-b18b-eaa02ce1240c@gmx.net>
References: <0102015f5e5ee171-f30f4868-886f-47a1-a4e4-b4936afc545d-000000@eu-west-1.amazonses.com>
 <0102015f5e5ee2f5-3d106a61-7f79-4973-851f-f55a691a6189-000000@eu-west-1.amazonses.com>
 <c26e1cab-a3d0-8cae-b18b-eaa02ce1240c@gmx.net>
From:   Pranit Bauva <pranit.bauva@gmail.com>
Date:   Mon, 30 Oct 2017 22:58:23 +0530
Message-ID: <CAFZEwPM5-e4DVApGPmeLr95t1YseSaswxitq5zY=EYpnucu-yg@mail.gmail.com>
Subject: Re: [PATCH v16 Part II 7/8] bisect--helper: `bisect_start` shell
 function partially in C
To:     Stephan Beyer <s-beyer@gmx.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Stephan,

On Mon, Oct 30, 2017 at 10:21 PM, Stephan Beyer <s-beyer@gmx.net> wrote:
> Hi,
>
>> +                     return error(_("unrecognised option: '%s'"), arg);
>
> Please write "unrecogni_z_ed".
>
> Since the string for translation changed from
>         "unrecognised option: '$arg'"
> to
>         "unrecognised option: '%s'"
> anyway, it does not result in further work for the translators to
> correct it to
>         "unrecognized option: '%s'"

Yeah Sure!

Regards,
Pranit Bauva
