Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB4A1215F4
	for <e@80x24.org>; Mon, 30 Apr 2018 14:45:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754475AbeD3Ope (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 10:45:34 -0400
Received: from mail-ot0-f173.google.com ([74.125.82.173]:44782 "EHLO
        mail-ot0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753910AbeD3Opd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Apr 2018 10:45:33 -0400
Received: by mail-ot0-f173.google.com with SMTP id g7-v6so9713225otj.11
        for <git@vger.kernel.org>; Mon, 30 Apr 2018 07:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dYuI6t2ux83V9TXzikdQQELpxDadsi5xJLd3WfK8MeE=;
        b=YDiLk3LIaXTo66zlqhaxi0xiuvv1zRwno+4ZqSw82F1jDPaSyf00sbbJXAjn2JABNm
         pDJaFRDuwePpzx7208tBVYuPQF9l6ZCK+WEydPcPIbiMvb0QkhzqOrJBYwEKYfmhbLS5
         0TbUvdpHxxWfQbn+moGzmXsc1pe3kShZ39n03d6gLAVJF58iBIXYrRTVxG6zMDQaD8CS
         Aa8R7qJH7HY/CPkZI6Oe0ueFUhNo3NP1/gUIHyr1HjQcwSsNwU56ag/1tz9kBzs1F9mO
         8CWq8g5xKsNK+xq3QQ1U7SDlUFf2AiVBCxlP3QhlrZbfUDIPBT1VPE4APws58aixdHi3
         D+rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dYuI6t2ux83V9TXzikdQQELpxDadsi5xJLd3WfK8MeE=;
        b=Zvru0BLklajyc/qw+Bt7uPVwGdX7jODXiOtFzi14QuNtzMWCOTlaFXWz0D310oNQxe
         Jwvl0FWaWR4BOjky1Gc4fZmK5vE+Nrqpl6TQqIH3/LQQH4ZgXCT6YtbvAWaIwmE51UqN
         rLy6Or5jPZR9xY0k+/M4hiOBms6+vFwQXzOKuEHUGM3lB6eeSBssOBiCwfsvOGHEi949
         j1kluwTu+VENaoktFB7hSgjUtNBAzJbqOoUz6WXW6g5cSTUeOXc0uOiSyppYoZWJoh7q
         DED1bw1eacxd1y+9ijtLFnTnjEE0+yM0bZ4WmbaUslCc1t9SweaW+GXS0MtSpo7/Sy7G
         nAJw==
X-Gm-Message-State: ALQs6tD7jaNNPeCSnF40LYNrBQ/HeQPIa78BtGh0Q4Wxbn1LDhSjXJtn
        cvUCU0DSMAt6x7B5jARQoR22DbtfhSMp+yt06To=
X-Google-Smtp-Source: AB8JxZrgByXYmbtk6YTINhhJk2fz7DJoHIKWPPgKAIusgAB+p1yEE1Zer18njddW8kjEHW526zlgSrVCSXaFtv5n2TY=
X-Received: by 2002:a9d:2995:: with SMTP id n21-v6mr9091846otb.152.1525099533316;
 Mon, 30 Apr 2018 07:45:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.198.152 with HTTP; Mon, 30 Apr 2018 07:45:02 -0700 (PDT)
In-Reply-To: <CACsJy8Cqq5c1QC=2EjfajS3=+ofAF8eoFG2V4QeY+LzSykJOFw@mail.gmail.com>
References: <xmqq604h717y.fsf@gitster-ct.c.googlers.com> <20180424065045.13905-1-newren@gmail.com>
 <CACsJy8DyP_mXXJKn52Jzqe63N3GLpXePCr8ha97Lv9hr6u-M0w@mail.gmail.com>
 <nycvar.QRO.7.76.6.1804292251000.79@tvgsbejvaqbjf.bet> <CACsJy8Cqq5c1QC=2EjfajS3=+ofAF8eoFG2V4QeY+LzSykJOFw@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 30 Apr 2018 16:45:02 +0200
Message-ID: <CACsJy8DhDDzLCQNoAdc=F6jLUSJK=dDWhhqLBecGG5ru01gRCw@mail.gmail.com>
Subject: Re: [PATCH v3] unpack_trees: fix breakage when o->src_index != o->dst_index
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 30, 2018 at 4:42 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sun, Apr 29, 2018 at 10:53 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>>> > @@ -1412,12 +1422,13 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
>>> >                                                   WRITE_TREE_SILENT |
>>> >                                                   WRITE_TREE_REPAIR);
>>> >                 }
>>> > -               move_index_extensions(&o->result, o->dst_index);
>>> > +               move_index_extensions(&o->result, o->src_index);
>>>
>>> While this looks like the right thing to do on paper, I believe it's
>>> actually broken for a specific case of untracked cache. In short,
>>> please do not touch this line. I will send a patch to revert
>>> edf3b90553 (unpack-trees: preserve index extensions - 2017-05-08),
>>> which essentially deletes this line, with proper explanation and
>>> perhaps a test if I could come up with one.
>>>
>>> When we update the index, we depend on the fact that all updates must
>>> invalidate the right untracked cache correctly. In this unpack
>>> operations, we start copying entries over from src to result. Since
>>> 'result' (at least from the beginning) does not have an untracked
>>> cache, it has nothing to invalidate when we copy entries over. By the
>>> time we have done preparing 'result', what's recorded in src's (or
>>> dst's for that matter) untracked cache may or may not apply to
>>> 'result'  index anymore. This copying only leads to more problems when
>>> untracked cache is used.
>>
>> Is there really no way to invalidate just individual entries?
>
> Grr.... the short answer is the current code (i.e. without Elijah's
> changes) works but in a twisted way. So you get to keep untracked
> cache in the end.

GAAAHH.. it works _with_ Elijah's changes (since he made the change
from dst to src) not without (and no performance regression). This
file really messes my brain up.
-- 
Duy
