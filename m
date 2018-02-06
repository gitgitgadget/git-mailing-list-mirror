Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24A041F576
	for <e@80x24.org>; Tue,  6 Feb 2018 10:20:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752763AbeBFKUo (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 05:20:44 -0500
Received: from mail-oi0-f43.google.com ([209.85.218.43]:45399 "EHLO
        mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752278AbeBFKUm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 05:20:42 -0500
Received: by mail-oi0-f43.google.com with SMTP id c189so938337oib.12
        for <git@vger.kernel.org>; Tue, 06 Feb 2018 02:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lcP6jAS8t5OPTaD46LGtjgL/SxR5tZeEHqNVGoWziZs=;
        b=YZFAoMjUJOKx4GHo7pe64QdZkbIIZH0HXVv3RYugcN3LR+8xZAS4CQu9l0CWtsEJfi
         UxtSztuRxH5BNYlM2p2c2yhzqCsBJcxgiLcgyG2Urjhsm789x9BN3GYc2SUL5y7NMJ2J
         t3G1k8bR/Duj5fjKXU5u+au2nG8+CSdJVgxfHygalPbjAVR1NSoF40RQB/yDMLs5qf6E
         KJdNKIteSl4Nc26nzLHsO4+FYaKgWz1i83IUGujnNypXeXS9beJMXPtOsyTi7yiJ4swQ
         itlybtwhW/Z2j+hMXGahHSy/30QCNZku2oxUt0oqwnvDp9da74zPv5bAVcz0DeV7jmIa
         HK+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lcP6jAS8t5OPTaD46LGtjgL/SxR5tZeEHqNVGoWziZs=;
        b=lC2UVtZhsmY7mj/DSF9w72NGdvq3FTSizE9ryzoKNGH3dihNMT7MX4GcH501oLJbOM
         1TmonGKJ/ADDKq+Hv/9o42oQooeGkPjYTw6Rw+e5IXCZBuIi4CDLfD0hEPR+pK/gTYNI
         py7zOP/QJTsv4Yn9DgzytklCbolrOWtZn0nmvWQ7onHxQUFfY8f2pIVzH0La0V1OrPPL
         oHoS8tXTfjCx3gXN+AewRxKoHvWc1OSTfwEmgQ1KlMM9c+qcv4kp+1FBEero8mwZOEiF
         cWD+S0ndU9P2qCSiZ1yXBSDyelNntHQGPIn7vjbQmjTt2SdxSUPVq4MW0BYLegJct9hT
         4nxw==
X-Gm-Message-State: APf1xPDXXgWBTSYPFzFRgG6JeBoSuI9kQ9XGIXuwMthF8bzlr78tC0mU
        4rsHemoHrPwHQauurt1o608RL3ncUrG0CgEA1V0=
X-Google-Smtp-Source: AH8x225Id/i+YsoHxOY0WcwKAkrNWfeG6wLRrjSh3dRg3qvmQeitFBNOtaEfnxn2QQ57BYWVTrBfw2cKE9ycXoG5pis=
X-Received: by 10.202.177.136 with SMTP id a130mr1144813oif.252.1517912441931;
 Tue, 06 Feb 2018 02:20:41 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.102.205 with HTTP; Tue, 6 Feb 2018 02:20:11 -0800 (PST)
In-Reply-To: <xmqq8tc7b6yt.fsf@gitster-ct.c.googlers.com>
References: <20180201130221.15563-1-pclouds@gmail.com> <xmqqefm3cgd7.fsf@gitster-ct.c.googlers.com>
 <CACsJy8B5DYpSQnJiLK8r4naaBh0YWLGwn9FuvM6EhP74E4E_CA@mail.gmail.com> <xmqq8tc7b6yt.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 6 Feb 2018 17:20:11 +0700
Message-ID: <CACsJy8CQLnzX6vijE+WHE3_nwqVfFiNWFb_rcA-Lw_fvGf=aFw@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] diff: add --stat-with-summary (was --compact-summary)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 6, 2018 at 1:56 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> On Sat, Feb 3, 2018 at 2:59 AM, Junio C Hamano <gitster@pobox.com> wrote=
:
>>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:
>>>
>>>> Changes since v2 [1]:
>>>>
>>>> - goes back to my original version (yay!) where the extra info
>>>>   is appended after the path name. More is described in 2/2
>>>> - --compact-summary is now renamed --stat-with-summary and implies
>>>>   --stat
>>>> - 1/2 is just a cleanup patch to make it easier to add 2/2
>>>
>>> It may be just me and other old timers, but --X-with-Y naming means
>>> quite different thing around these commands, and --stat-with-summary
>>> would hint, at least to us, that it would behave as if the two
>>> options "--stat --summary" are given at the same time.
>>>
>>> And from that point of view, the new name is a bit confusing one.
>>
>> I don't have any good alternative name to be honest. It's kinda hard
>> to come up with another word that says "extended header information
>> such as creations, renames and mode changes", except maybe the vague
>> name --stat-extended?
>
> I actually think compact-summary was a good way to phrase it.
>
> Personally, I think it was a UI mistake that --summary can be given
> independently with or without --stat (instead, there shouldn't have
> been the --summary option, and instead when it was added, --stat
> just should have gained an extra kind of output).  A single option
> that can give both kinds of info may be a good way forward, so
> another possibility may be --summary-in-stat (meaning: the info
> given by summary is included in stat output).  I dunno.
>

+Eric maybe he has some idea (sorry I forgot to include people from
the last round).
--=20
Duy
