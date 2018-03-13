Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AABF1FAE2
	for <e@80x24.org>; Tue, 13 Mar 2018 11:22:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752439AbeCMLWy (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Mar 2018 07:22:54 -0400
Received: from mail-oi0-f53.google.com ([209.85.218.53]:36206 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752434AbeCMLWy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Mar 2018 07:22:54 -0400
Received: by mail-oi0-f53.google.com with SMTP id u73so14962848oie.3
        for <git@vger.kernel.org>; Tue, 13 Mar 2018 04:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lvAI7I5Mjtkq5zVHYcM/bpIPQefysZP/3MvPydgZ+BM=;
        b=Q12L0z54EhYx+cTeYIhg0G9t7D16TTRY2aFJIvFQzinVEoSFB6saLQ8Gaf5+gx9TB7
         b4vSNwGXw20BKRcy/eYcbGlIEBy1wD4NF8/2TTTXFSDvbouy8r51YJ0wAhniCavAoSIj
         q0fF6ordkB5TFapIyOOHwK5xtZy2wEpq0+8dbxycZB2zMXD2uQyynaFE+HSpEYR5oGuv
         6Y40rXfGkK/2Qv4I5irRvZO2Ple5rgUJvfqpf5ZWfugVSli4ddlpCRrO1aI0m8dhqbSk
         pmeG2eUPK7l0tdfhKiCBDeWVZKFYZ1KFN7J228Ms9cqrO9ZQLjIjR1cpCpD39nsopDmq
         vOvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lvAI7I5Mjtkq5zVHYcM/bpIPQefysZP/3MvPydgZ+BM=;
        b=gTDeeA3f/XAhuvRLRE6YqCyUfGDEe8YudLG784hJQ+StyOadkV2j9O/j8DYVnUiN/G
         wIXoJ5SjD/vki9JxMOQ1A51nhP43SymYjQiGpgvAGbREyutzJpXsCyTxs6CRTDlOwx0n
         WGnI7xtk2vtRfvHbjKa4Jb7Nma4vgDeYk7UibIDuwAC6DZn9svz9Br19Tf2B27o7ZkB+
         LGrlYRUs+/zkQQAWMg9zsxFzbd0dKzgDfgfKmKBv9IM4xteO2isJ4xrQiTuzjQMMHI91
         Tpi5sBSH89pQL25oU01UkdZM4ehF22XVgt84YJ0wnkiph3QVnNw4Wxh46wvz4R++XOZ/
         oFaQ==
X-Gm-Message-State: AElRT7HP154J2LcHoYJU1oA4zTHX2IzZ3a2Tltl2l+GD/Pl7Kj+V3ee1
        UYG8WdmVekU/agjguocxMjkyt68vwkBXG1Btbnk=
X-Google-Smtp-Source: AG47ELvLHT6TYAMDzYgIhDCyPc/q7NbUhUviRS+9xSjeBUpS6jLUlbDagRRfhmSXC2HCYLXgBbOwPWxIKheha2+69+I=
X-Received: by 10.202.83.129 with SMTP id h123mr156980oib.228.1520940173520;
 Tue, 13 Mar 2018 04:22:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.25.140 with HTTP; Tue, 13 Mar 2018 04:22:23 -0700 (PDT)
In-Reply-To: <878taxq8gm.fsf@evledraar.gmail.com>
References: <CAE5ih78nLL6UhKPObvFEA9xQZUtc1XpPvGJNaYTH9fJ0RyFRvA@mail.gmail.com>
 <CAE5ih7_uuVVrze9gNr3JMg5HNH8eAcH_wM4wrc2kH6u=Hw0JOg@mail.gmail.com>
 <xmqqtvxvyz3m.fsf@gitster.mtv.corp.google.com> <CAE5ih79wG3ws=OyXqvbd+QKyyAmM-D2JVO5r9G5VHtoOfiXdug@mail.gmail.com>
 <878taxq8gm.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 13 Mar 2018 12:22:23 +0100
Message-ID: <CACsJy8CQWBy71-TJCZ7aj4Kt8KawCAACLm3hBLnBX5L8jHv7_Q@mail.gmail.com>
Subject: Re: Bug in "revision.c: --all adds HEAD from all worktrees" ?
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Luke Diamand <luke@diamand.org>,
        Junio C Hamano <gitster@pobox.com>,
        Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 12, 2018 at 10:39 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> Now, obviously the root cause is that the repo is corrupt through some
> other bug (since fixed?), but the error message here is really bad, and
> should at least say "fatal: bad object HEAD in worktree blah" or
> something like that.

I know. I know. I'm working on it. I hit a wall and had to re-think my
approach, but I think it should be ok this time. Will be posting a
series soonish, which should also fix fsck ignoring HEADs from other
worktrees.
--=20
Duy
