Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0A5D1F576
	for <e@80x24.org>; Mon,  5 Feb 2018 11:29:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752877AbeBEL3U (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 06:29:20 -0500
Received: from mail-ot0-f179.google.com ([74.125.82.179]:45457 "EHLO
        mail-ot0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752756AbeBEL3T (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 06:29:19 -0500
Received: by mail-ot0-f179.google.com with SMTP id 73so17425366oti.12
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 03:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kVQivYZvdgRf2RPTVRKY1ljxNCvgPcQsErxXm2xu0Hw=;
        b=ktNU3BMPac1/ZOAoYVFiZfuKjk/bxzLs/1qEI0zfo0pULhkQrHmHzUvzBRNkOT49i+
         UJFRdhhQsIhYhFceUNlX0zm1LpstIAVVV4nn5Izf6s6EsVCDpqjm5fw77Fih8Hx/LKdE
         MFQZmnN1p6tvCrTRlM9jGecD37a3PXXPu+y2ycAJAqiZz9x/MdWG1tLQtMmojviXqN8P
         OpM0VMthjMtSJ//qhgE6e7AXJUk6aZjabZNN8w9CSAtfo6q5GorhVkkRy79o+WNKWBVC
         5tBDi1TlQBuz2mjrX/f3kQXLL1e6tKxWaR3OX0+l5cYx1K7LlqBsz4MCwMsAFPSmhVJp
         mRJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kVQivYZvdgRf2RPTVRKY1ljxNCvgPcQsErxXm2xu0Hw=;
        b=i/tGeh4myGs26tJt8dA4fMkMYcrzGu3GwPL8xLC3XepwYh+dOvDHeF9n/an+HPYeNG
         8Ji22AK62Ba9lnSl+qCZ8PQJBCaw7qX+QqjO+fOkxAhO4YDcKab4/0oCgDNNOu17c8wa
         JUmJM+hNOyuNLnBP8k1geS1jRfmtbYPnft6f7ARNNhh/CjXVw8s7NS5OQ4VFJ/3XhAde
         fhuLmI6ZZcdJl41oXLkf0KkQT5B6x1Fm0idf4RWtk13KyPRV7wRi9HmghsOxxXYkcK5n
         C65o+6w31goZcv459C2heX7V4TwEe8p/MnKIdssjrX8ihqemJb5yDIA1WDTqjryFKPvR
         0NFg==
X-Gm-Message-State: AKwxytdCf/nPe8PFBY75yB0d5pzviGx3nSZBaTePhTYCAu4BLwATi5PL
        A1rmG7DSjzk0vM5pldNDXy1bv5fdNHuMZ5rDWk0Peg==
X-Google-Smtp-Source: AH8x224UrVvrMggwpfiqK43nd880pn2dmrG/Kr4jEut80fn1EnAVM2DN/p84mxc07rLUJ1vVdp3U4rIvV1q5nbEtBng=
X-Received: by 10.157.47.177 with SMTP id r46mr27249708otb.301.1517830158381;
 Mon, 05 Feb 2018 03:29:18 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.102.205 with HTTP; Mon, 5 Feb 2018 03:28:47 -0800 (PST)
In-Reply-To: <xmqqefm3cgd7.fsf@gitster-ct.c.googlers.com>
References: <20180201130221.15563-1-pclouds@gmail.com> <xmqqefm3cgd7.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 5 Feb 2018 18:28:47 +0700
Message-ID: <CACsJy8B5DYpSQnJiLK8r4naaBh0YWLGwn9FuvM6EhP74E4E_CA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] diff: add --stat-with-summary (was --compact-summary)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 3, 2018 at 2:59 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:
>
>> Changes since v2 [1]:
>>
>> - goes back to my original version (yay!) where the extra info
>>   is appended after the path name. More is described in 2/2
>> - --compact-summary is now renamed --stat-with-summary and implies
>>   --stat
>> - 1/2 is just a cleanup patch to make it easier to add 2/2
>
> It may be just me and other old timers, but --X-with-Y naming means
> quite different thing around these commands, and --stat-with-summary
> would hint, at least to us, that it would behave as if the two
> options "--stat --summary" are given at the same time.
>
> And from that point of view, the new name is a bit confusing one.

I don't have any good alternative name to be honest. It's kinda hard
to come up with another word that says "extended header information
such as creations, renames and mode changes", except maybe the vague
name --stat-extended?
--=20
Duy
