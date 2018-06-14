Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E69D1F403
	for <e@80x24.org>; Thu, 14 Jun 2018 16:39:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755286AbeFNQjm (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Jun 2018 12:39:42 -0400
Received: from mail-vk0-f42.google.com ([209.85.213.42]:34607 "EHLO
        mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755208AbeFNQjl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jun 2018 12:39:41 -0400
Received: by mail-vk0-f42.google.com with SMTP id q135-v6so4058229vkh.1
        for <git@vger.kernel.org>; Thu, 14 Jun 2018 09:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lbMPHz3P8d772osOXSLTA8vm78BuDanUibssXP1tI0I=;
        b=Od1hi7xKhVbuaPLCDxaVW9RRK9UXHRlKXcXzKm2+fAVggJUOGMVGgllfgQxc//G2P7
         VckwLWCS1l2AyOwp0DQoIp426UcMT2+g0Sipsxg883gV3VsCpEp+j/OLGDi99ax/2XIV
         7PY2ar32/Hvcjzz16E+33LnXOH3UKURigCabARdb7K7zTQe8onv8FolHKB7+EcxfQG0X
         rcbZiQWrfe9nhYwlx9lKAEqPlUC3AGw/tX0J6eGZ4iKpM9e9sC2PlicJ5uuViApVibnn
         CtADawBwsJl5F8hH41KkpjpazEgzVXdBoAYH6pORv/RU/V/AeEzwV8ilaoBaKSlXHPes
         T0+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lbMPHz3P8d772osOXSLTA8vm78BuDanUibssXP1tI0I=;
        b=lbDnNFPWAdj67qh0Tn4yEoFmXODrvOGPBBhXnG0ds+6LkfbeRkxqvNcj+qCvQObsto
         dksBcmNHnZmBk5abBHb77EkfSu3ovLS2my9A0jK0W0gEgyf8o5k4x5a9jeuY0YSQt9il
         m/tnVCF7FpYxbrkUYNAmcNiIK1gDqKGJDpgLgXAJl4Xfrb5qeelGDNDuS/9eBELKX74J
         SvJfu4bkzTxuyAo/00e85rPZAqgJbyuUbTqI+mXJNMFLsrhMgmbF4dbRFjueC/B3pEv1
         zCVZUzFXu3pfOa4emiq/CQORYd48ZqegoAgi+CFlX5NcsENPQz5jyO6L6OHjHg5cO2Vk
         Zr+A==
X-Gm-Message-State: APt69E2bMcY1hfZs5QQX5CjUBVZwc7AKtwBIB+s2NM6aQMalbAx/QOH/
        5ovSpnKiJSAAH4euDLayPrUAY/HSjCvKw4BLGUCiiQ==
X-Google-Smtp-Source: ADUXVKLCTHnR2+ifOc79+PcbdM0hHdKvsk13gru5Bo/HtdVxHOhezGZ+cIIk5YD1IMnzX25T/BbECKopM1Tuk+UTKi8=
X-Received: by 2002:a1f:4313:: with SMTP id q19-v6mr2027384vka.83.1528994380162;
 Thu, 14 Jun 2018 09:39:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:3105:0:0:0:0:0 with HTTP; Thu, 14 Jun 2018 09:39:39
 -0700 (PDT)
In-Reply-To: <20180614123107.11608-5-szeder.dev@gmail.com>
References: <20180614123107.11608-1-szeder.dev@gmail.com> <20180614123107.11608-5-szeder.dev@gmail.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Thu, 14 Jun 2018 18:39:39 +0200
Message-ID: <CAM0VKjkfLiEoTOfkC=jXx5TVmbbVvHRDB6KEPinW6Gb98p0vgA@mail.gmail.com>
Subject: Re: [RFC PATCH 4/4] t/lib-httpd: sort log based on timestamp to avoid
 occasional failure
To:     Git mailing list <git@vger.kernel.org>
Cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 14, 2018 at 2:31 PM, SZEDER G=C3=A1bor <szeder.dev@gmail.com> w=
rote:

> When a test sends a HTTP request, it can continue execution after
> 'git-http-backend' fulfilled that request, but Apache writes the
> corresponding access log entry only after 'git-http-backend' exited.
> Some time inevitably passes between fulfilling the request and writing
> the log entry, and, under unfavourable circumstances, enough time
> might pass for the subsequent request to be sent and fulfilled, and
> then Apache writes access log entries racily.
>
> This effect can be exacerbated by adding a bit of variable delay after
> the request is fulfilled but before 'git-http-backend' exits, e.g.
> like this:
>
>   diff --git a/http-backend.c b/http-backend.c
>   index f3dc218b2..bbf4c125b 100644
>   --- a/http-backend.c
>   +++ b/http-backend.c
>   @@ -709,5 +709,7 @@ int cmd_main(int argc, const char **argv)
>                                            max_request_buffer);
>
>         cmd->imp(&hdr, cmd_arg);
>   +     if (getpid() % 2)
>   +             sleep(1);
>         return 0;
>    }
>
> This delay considerably increases the chances of log entries being
> written out of order, and in turn makes t5561's last test fail almost
> every time.  Alas, it doesn't seem to be enough to trigger a similar
> failure in t5541 and t5551.

A bit of addendum here:

There are basically two "kinds" of requests:

  1. requests asking for regular files, e.g.:

     GET  /smart/repo.git/HEAD HTTP/1.1 200
     GET  /smart/repo.git/info/refs HTTP/1.1 200
     GET  /smart/repo.git/objects/info/packs HTTP/1.1 200

  2. requests asking for 'git-receive-pack' or 'git-upload-pack',
     e.g.:

     GET  /smart/repo.git/info/refs?service=3Dgit-receive-pack HTTP/1.1 200
     POST /smart/repo.git/git-receive-pack HTTP/1.1 200 -

This artificial variable delay shuffles only the access log entries
written for the first kind of requests, but doesn't appear to have any
effect on the order of log entries written for the second kind of
requests.

t5561 sends both kinds of requests, so this variable delay is
sufficient to make the test fail most of the time.

t5541 and t5551, however, send only requests of the second kind, so
that's why this variable delay can't trigger a similar failure in
these test scripts.

I haven't investigated any further what else would be necessary to
trigger a failure in t5541 and t5551.
