Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C3AB1F404
	for <e@80x24.org>; Mon, 16 Apr 2018 13:30:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754942AbeDPNaC (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Apr 2018 09:30:02 -0400
Received: from mail-lf0-f42.google.com ([209.85.215.42]:37724 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752824AbeDPNaB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Apr 2018 09:30:01 -0400
Received: by mail-lf0-f42.google.com with SMTP id b23-v6so3139654lfg.4
        for <git@vger.kernel.org>; Mon, 16 Apr 2018 06:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AUqjg2uuoG95IAwM1Xk5b8aycmjiU0JFw3r/jfAc//k=;
        b=pAVEdd0MyABQdLn423ooY0QyaBvCM/I6fKdcNzY7yHz3d0IgLL8eO65uZGxSvyGvsF
         PZ6qaKViKapZrnEACXO19VW3lhFbxQIrPpjaMiFB+LOBiS4nM9sBYRBZdahtiAFsmypa
         dTuPgt+ojm0PdDTdMvEkVZzHwqYhTw3XsfprsYyvtj8riXQLIu1gv1lF9ZedFlhBYEs8
         P/Oar0KtWqejPqMTiQ1/+8zveYegl0fF+zpRDulRME/f6Zfjc21QmXHVxHJrSgfoHdfu
         ipSZ/xXo1NTa4mDEmGofyuX/9fAq/H4aXkWwjnKTW1hmlPN/xtRiAYITdbzt57synj8/
         FFzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AUqjg2uuoG95IAwM1Xk5b8aycmjiU0JFw3r/jfAc//k=;
        b=Twr4+MlGxHJBUXQ56yram6W67OJcqLZlE9GDDj1c90+VQBT3srVBj5ecdVXa4qPRTk
         m8I2a0Kd+AGp/8Ss2dh5Crkn9/KzpSnLrFCp8vNnGiBxaK9LDQzB8HoKKVPTbckoGEFj
         p0ZrPRm2Jqum/mY2dnX1InsmmwnKroxiS08T+acWbcZmubFLbDpNr0Ghgz4tpMqAGlCq
         ETzfkIc8q+BBYpAeKyFfiIa6zGGRou0yHyF1p3TdI3bFHmiHG9B/eaNEVz4H25+5nuDh
         yC+Ji0H/vNJzKbvsJxumq1qvcWIwvqidHlc7hxnabu0SxQY9LDANU0EDQOt95afVmmr4
         IO5A==
X-Gm-Message-State: ALQs6tBA4OlBDhHwTgdybZDR85IKlkBtnRNfO1C+x0x/D1mNdZ+/e6u8
        +Ta5Yj4QA4zhLSO3It6fcbCTUGusyNFFA5irAxyL3A==
X-Google-Smtp-Source: AIpwx4/taRN5of9POw5p7TqTxW2C7eoq4i8c9EeDaOL3qgCC9tGLaN8d4PUun6xa5fCsYWfk6wHckUiLxuHjiKeZB9k=
X-Received: by 2002:a19:1895:: with SMTP id 21-v6mr8928855lfy.39.1523885399654;
 Mon, 16 Apr 2018 06:29:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:4a4c:0:0:0:0:0 with HTTP; Mon, 16 Apr 2018 06:29:19
 -0700 (PDT)
In-Reply-To: <CAM0VKjm=jyetT9ucNbOYxQ19BGYr8nWzAi+WUnsHPuRTrSG9SA@mail.gmail.com>
References: <ACE8F169-7700-4D60-85CB-786C6BEBF0B7@1eanda.com>
 <20180413103005.671-1-szeder.dev@gmail.com> <86604un5mz.fsf@gmail.com>
 <CAM0VKjkKE695mMPgmfgzWJPaJThdLDSESV9KmupQX_bm-6MW-w@mail.gmail.com>
 <xmqq7ep7ybw2.fsf@gitster-ct.c.googlers.com> <CAM0VKjm=jyetT9ucNbOYxQ19BGYr8nWzAi+WUnsHPuRTrSG9SA@mail.gmail.com>
From:   =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Date:   Mon, 16 Apr 2018 15:29:19 +0200
Message-ID: <CANQwDwf8sBFuKBXG6Yt5CH9+E2doqB6rB-_oQ4U7vjTOYBfu_g@mail.gmail.com>
Subject: Re: [PATCH] completion: reduce overhead of clearing cached --options
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matthew Coleman <matt@1eanda.com>,
        Stephon Harris <theonestep4@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 16 April 2018 at 15:15, SZEDER G=C3=A1bor <szeder.dev@gmail.com> wrote:
> On Mon, Apr 16, 2018 at 7:10 AM, Junio C Hamano <gitster@pobox.com> wrote=
:
> > SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:
> >> On Fri, Apr 13, 2018 at 11:44 PM, Jakub Narebski <jnareb@gmail.com> wr=
ote:
> >>> SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:
> >>>>
> >>>> In Bash we can do better: run the 'compgen -v __gitcomp_builtin_'
> >>>> builtin command, which lists the same variables, but without a
> >>>> pipeline and 'sed' it can do so with lower overhead.
> >>>
> >>> What about ZSH?
> >>
> >> Nothing, ZSH is unaffected by this patch.
> >
> > OK, do we want to follow it up with [PATCH 2/1] to add the LC_ALL=3DC
> > thing to the ZSH side to help that "sed", then?
>
> No.  'sed' would only need need help when its input comes from a buggy
> 'set' builtin of a particular version of Bash from a particular vendor.
>
> As far as I can test this in Travis CI's OSX builds, ZSH doesn't seem to
> be affected, neither the version Apple ships by default nor the version
> installed via homebrew.

That's nice - this means that the patch fixes all of the issue.
The above information should be, in my opinion, included
in the commit message, though.

Best,
--=20
Jakub Nar=C4=99bski
