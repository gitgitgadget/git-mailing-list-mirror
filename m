Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CD7C21847
	for <e@80x24.org>; Wed,  2 May 2018 15:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751752AbeEBP0b (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 May 2018 11:26:31 -0400
Received: from mail-ot0-f179.google.com ([74.125.82.179]:36529 "EHLO
        mail-ot0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751597AbeEBPVr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 May 2018 11:21:47 -0400
Received: by mail-ot0-f179.google.com with SMTP id m11-v6so10845317otf.3
        for <git@vger.kernel.org>; Wed, 02 May 2018 08:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xVpr2aHAptKeMys1W4oWv6EWIq1QzLYSBLtbjBl6kUc=;
        b=TtjuiMagoj5MqZ6465ZMNP5r58xVNGD7EitB9BmPmPzqqZ8YmF74n99niTq8qJHFQr
         ApeRI4WOs/bveIJ1cU3sSxetwH6nom+7akfz/TmyYXPEKe1Kiw0y1xsFmbgCtGOrOO7D
         9zV8acrRud4MDrF6Rm6GXvG+xpCShfHR9jywwq2FMjy/H9jmboWusESvqMDSWOOkBzvP
         1lpH1vvC2DnJeGSI75YvZFJUQlaIzY8cWq8FGncWkD1r/7FESXKYi/Ic4X6WZfNVH+q0
         xASc8oQjF3zmJfAq+xJfIZbZzxXwfFxnpPxpM655Hn1I/VZuQgpy1m02wlkKcuVzqHTJ
         DPPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xVpr2aHAptKeMys1W4oWv6EWIq1QzLYSBLtbjBl6kUc=;
        b=qGBkV3qgd3V3LCRHr0dWljfU4ga0NJsi+hvg3N6BKoEildktatGJIndOL4P3ekEZUm
         CvjognEdURb30WIVVws10f2jUjD4MHLoNBTqPIfRiThUJ0VJUKTSya9mdNwKvoMFyQqp
         fF7qPJRnd8q1MJvCUd+DMbeRFFkh6hOqziLFQrE8fywozuWj1botZKzX+v6nNY6FkFNM
         jOaOdYea5tbiVP28cVnZ77xC5anx/AiYGW9MxWf3Vup9lXXnahdYefi1vXyhiu8z2Fy6
         ke/7LMqNXtC1nGIaKcaMaLBw3To+uR93Lzui2ggEVmqNmIoI74gb8F7sSfZqSBpBhWJa
         P2hA==
X-Gm-Message-State: ALQs6tCduBTQPHb4OkA0iIixZG5JqQ4CZq/YY5e1HXN+6LlDP4L078WK
        MJGYpok5j3lpJ/DDjFH04D+7WIVE/58UgVqq9iY=
X-Google-Smtp-Source: AB8JxZrEISf8qznLTMRw6VckjACJrTesJBRVWogU453D+ipWe4tSNQXm6hBoEDDcqWXYiSVoOJ6WGilfP0TyuOeFDn4=
X-Received: by 2002:a9d:e8f:: with SMTP id 15-v6mr4130599otj.14.1525274506827;
 Wed, 02 May 2018 08:21:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.178.133 with HTTP; Wed, 2 May 2018 08:21:16 -0700 (PDT)
In-Reply-To: <20180502105452.17583-1-avarab@gmail.com>
References: <20180502105452.17583-1-avarab@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 2 May 2018 17:21:16 +0200
Message-ID: <CACsJy8Ae9PP8BMbyX5mPJukGpC06jMvvbg0fMFL+fu+EUg1kPw@mail.gmail.com>
Subject: Re: [PATCH] checkout & worktree: introduce a core.DWIMRemote setting
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 2, 2018 at 12:54 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> Introduce a core.DWIMRemote setting which can be used to designate a
> remote to prefer (via core.DWIMRemote=3Dorigin) when running e.g. "git
> checkout master" to mean origin/master, even though there's other
> remotes that have the "master" branch.

Do we anticipate more dwimy customizations to justify a new dwim group
in config (i.e. dwim.remote instead of core.dwimRemote)?
--=20
Duy
