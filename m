Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D7C11F576
	for <e@80x24.org>; Fri,  2 Mar 2018 11:40:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1946449AbeCBLkP (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Mar 2018 06:40:15 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:39897 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936005AbeCBLkK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Mar 2018 06:40:10 -0500
Received: by mail-qk0-f194.google.com with SMTP id z197so11502139qkb.6
        for <git@vger.kernel.org>; Fri, 02 Mar 2018 03:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=8LmhRdkoY+cOht9KhZbUpL3vbPwdqcbU35ZPW3QJ6yc=;
        b=ZlgzD8+0VDend/sbS/PK/u39VfOJBcNrBdZKztOtRTX8vpYEIDr+y0ldOwUtP3HWKb
         qNW71O7vAk3B+zGshcxrzzJH7lJnjGP0rSZ1s0DWbV3PMGbmhz1QMNKjLmdVOnr6fsX/
         RPpuApSFs/gZXr7COChYRUsByKUqKACt7BNuSpl9WyYIQV2bdR1jmIErOxrzQa9yYo/I
         GLKdre3pRl8CHnSjBl5l8+eE/Du8uzOQFSnZPIoXlDYRhGk97Rc1bQ2zNN+BjlhqVES5
         XmtnmM4Pxe3m/ffwI0dUCZyA/AZixQWVeQlChtHSiU6P37zODfAT9GMfOSi+YIfFv9o8
         7I/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=8LmhRdkoY+cOht9KhZbUpL3vbPwdqcbU35ZPW3QJ6yc=;
        b=C/oZTgNEZtNG2hqJjF6YRLQ/rM6pTjvorGW2a3Ut0rbh5qhIIYZD0XoIJRb5Hfoijo
         jdtzwUwMSK0CcU+eMof44Tps2j7xYEqMOrYqWxn2ycA9zbdYUhubazOID0W02DmJOF5p
         y9ew7+m/nyDrQj8WLM91d+ArRYtEOuSa5NxmFgTHcCDcgfgfIE27aA8R5a3C8WxCXY2T
         F79iQi3QP1xwDnjTN6EDqz3rCV2gUOgN3vkSmUWVU2D/kZT49eKZ4WAFi/sXM+rPZGAh
         K65tDY96HZ1rm1LyuHAsBqnxP/X1eI6FTEbIc6JqDPXuMDtg4DkY4xeohEunrsFMfWux
         u0nw==
X-Gm-Message-State: AElRT7HRd0CRusIWDS9GkAB/7awdRoz1Yz59I31xMQeSrgpRZ0qZc8EF
        76PYKeWLYXPEI0sIOkeO8zoPsreB3doGXsuiAUI=
X-Google-Smtp-Source: AG47ELsYWIHD8KaIaP5E+aFbPuK7gTr3SE5H2yHjIW0F30PfrFeDII6GfgIA0SZA1RrLfhIeAtq2g67HwByYzb4cHXA=
X-Received: by 10.55.133.131 with SMTP id h125mr7902511qkd.79.1519990809340;
 Fri, 02 Mar 2018 03:40:09 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.142.14 with HTTP; Fri, 2 Mar 2018 03:40:08 -0800 (PST)
In-Reply-To: <b34d74fa-f4c7-fb4a-49df-cd7ebd996d95@aegee.org>
References: <aa98f187-4b1a-176d-2a1b-826c995776cd@aegee.org>
 <CAPig+cSGJhNR8dapLXN0TU8ZpTqi7m6OQf_cCGmHc9FLGcwNyg@mail.gmail.com>
 <adf7a7a0-3571-5b68-5d15-30a9067e3826@aegee.org> <CAPig+cTPFSbT7WxyoNEOSg=3Ft1pVzkgieGp44kHnZ9=NbYsqg@mail.gmail.com>
 <CACsJy8BUKCG-yiYX3ouMVa44iEo0swHpTkhW3ho_T0PCP81DSw@mail.gmail.com> <b34d74fa-f4c7-fb4a-49df-cd7ebd996d95@aegee.org>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 2 Mar 2018 06:40:08 -0500
X-Google-Sender-Auth: PWUdfebIkHjvWKzAfz6Vk7Verlo
Message-ID: <CAPig+cRSMOUTQDA0NKNg_nx9HASmnqpFuyRjcSFjdKbVwAuvrw@mail.gmail.com>
Subject: Re: Worktree silently deleted on git fetch/gc/log
To:     =?UTF-8?B?0JTQuNC70Y/QvSDQn9Cw0LvQsNGD0LfQvtCy?= 
        <dilyan.palauzov@aegee.org>
Cc:     Duy Nguyen <pclouds@gmail.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 2, 2018 at 6:34 AM, =D0=94=D0=B8=D0=BB=D1=8F=D0=BD =D0=9F=D0=B0=
=D0=BB=D0=B0=D1=83=D0=B7=D0=BE=D0=B2
<dilyan.palauzov@aegee.org> wrote:
> Your assumption is correct: when renaming the directory apparently I have
> not adjusted /git/A/.git/worktrees/B/gitdir to the new location.
>
> I fixed the situation by renaming /git/B to /git/B.bak, creating a new
> worktree pointing to /git/B (with branch g), then deleting /git/B and mov=
ing
> /git/B.bak to /git/B .

Duy's patch series to add a "git worktree move" command[1] should help
avoid such problems in the future.

[1]: https://public-inbox.org/git/20180124095357.19645-1-pclouds@gmail.com/
