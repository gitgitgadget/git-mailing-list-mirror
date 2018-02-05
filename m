Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F86E1F404
	for <e@80x24.org>; Mon,  5 Feb 2018 13:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752927AbeBEN2n (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 08:28:43 -0500
Received: from mail-ot0-f177.google.com ([74.125.82.177]:41218 "EHLO
        mail-ot0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752316AbeBEN2l (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 08:28:41 -0500
Received: by mail-ot0-f177.google.com with SMTP id r23so25374727ote.8
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 05:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3n7pqOmLeie+tGGhGNXNxhoM4YF7kamqZYPkMQfxiTI=;
        b=Hw0m9gBc8xzNjFxZpU7nWV9U2t3ninD+i9LJjS881kzOTawJo+m3u3kLbOtGFaauKD
         fNGDNy8EDtRy5Ang2tRdCeXyToFxRmnXMBQix8oL2JwNSyCLAhf4J7PJdihkH+sYQU1q
         ChQnyp2G12lmATw27pILMvwh7wD5Z9ishKp7kaNsj+3EeeO6c0tMEL8OjintGUxBHuSH
         fpT2GdaXcxLwLv1luU2TSJz1OvnK49HLUlEmnL1ldBiW69P6HcZNTLLBvkFvy6dl5TVw
         M2DW11vhIzzXgw1PU0CJak2M8d1dVedbjXDlLX9A8v6dCj1kUk3CjEvcsQg5l+rlyRxE
         drRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3n7pqOmLeie+tGGhGNXNxhoM4YF7kamqZYPkMQfxiTI=;
        b=D6H+jccq0veHx/ue09NYKbO3HGQ2i4aG93c2QXie9CXyREYC9pCUosEGvlsuF8R1P5
         txvezhNxchgeT0MZCurnbgAC2+tKe4aPG6/tzcvEvNzMtksAY5sY/EZyjltWFs27EKZ7
         0IvSaF9o89JaXTE96IzOMMhbYq/sW0S0KRu2MK7zzU6GWCabSrEmWvlzAuXbQyHBoB80
         MXEyTMLoRod8coxCc5T7G8I+Wyj20n8vV6RIxhpWdRw/z/ufrpqxwRG5B+ZuBBID7PAb
         e6SyyUFIqIDeAVsYmthDGzQcoTtUjGaxNIaJvBIYsHrTYG3B2kSR2m2aN+UNd8ibsQgG
         fjjg==
X-Gm-Message-State: AKwxytcrx/mRUlIt4ASatVuxx/zCvS2woH7YH+/jYF77rSx3+2Vl+GJt
        ggf2Vhg8Tk3WBTLpafV3go9M6ZCEmz9ZDC9BGUk=
X-Google-Smtp-Source: AH8x2250V1kNU7OrguoFNxKzISISbR0J+d5bVa3sZMEWKkxDv/x4AR9CUqH1FL/5JXjn37lwXlgwh+qFDLT17JiQH8U=
X-Received: by 10.157.47.177 with SMTP id r46mr27547729otb.301.1517837321158;
 Mon, 05 Feb 2018 05:28:41 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.102.205 with HTTP; Mon, 5 Feb 2018 05:28:10 -0800 (PST)
In-Reply-To: <CAPig+cRYL6-jEgsQoiQokNSd0zq5zoFkMHBA0Vp9kqa0LvMnsA@mail.gmail.com>
References: <20180124095357.19645-1-pclouds@gmail.com> <20180124095357.19645-4-pclouds@gmail.com>
 <CAPig+cQeQRppb2y4YyQnqWWnCO0TXE-PjfTAhxakCJNk45ec1w@mail.gmail.com> <CAPig+cRYL6-jEgsQoiQokNSd0zq5zoFkMHBA0Vp9kqa0LvMnsA@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 5 Feb 2018 20:28:10 +0700
Message-ID: <CACsJy8A+zMTC2N8Y0Ua-KyLF6Wp2oHL=8mbsSXck6mKZGG=37g@mail.gmail.com>
Subject: Re: [PATCH 3/7] worktree move: new command
To:     Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 2, 2018 at 6:23 PM, Eric Sunshine <sunshine@sunshineco.com> wro=
te:
> On Fri, Feb 2, 2018 at 4:15 AM, Eric Sunshine <sunshine@sunshineco.com> w=
rote:
>> On Wed, Jan 24, 2018 at 4:53 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
>>> +static int move_worktree(int ac, const char **av, const char *prefix)
>>> +{
>>> +       [...]
>>> +       worktrees =3D get_worktrees(0);
>>> +       wt =3D find_worktree(worktrees, prefix, av[0]);
>>> +       if (!wt)
>>> +               die(_("'%s' is not a working tree"), av[0]);
>>
>> This is still leaking 'worktrees'[1]. You probably want
>> free_worktrees() immediately after the find_worktree() invocation.
>
> Sorry, free_worktrees() after the last use of 'wt' since you still
> need to access its fields, which would be the end of the function.

I learned SANITIZE=3Dleak today! It not only catches this but also "dst".

Jeff is there any ongoing effort to make the test suite pass with
SANITIZE=3Dleak? My t2038 passed, so I went ahead with the full test
suite and saw so many failures. I did see in your original mails that
you focused on t0000 and t0001 only..
--=20
Duy
