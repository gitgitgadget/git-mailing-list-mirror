Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 782021F404
	for <e@80x24.org>; Sat, 27 Jan 2018 01:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751457AbeA0Bme (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 20:42:34 -0500
Received: from mail-oi0-f65.google.com ([209.85.218.65]:41017 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751169AbeA0Bmd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jan 2018 20:42:33 -0500
Received: by mail-oi0-f65.google.com with SMTP id m83so1525924oik.8
        for <git@vger.kernel.org>; Fri, 26 Jan 2018 17:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=q0/Bzv8LR3nrHBEcBbxJ6zSiWU8DyJZht3loImaG1CI=;
        b=oiIyQO69LgNUYD0+liY7UE6d9dMM3i5a4KHv0Svapl026THl0zWAlvYjSyBBzO5EjG
         AsyapYyDxAKKPk9AHRCRbAlNKkJVGLO35BhJBXnu3xLT1QhI+0hNaApLDpH9lpz638VG
         15k1LYujnC+V41kAA5j+FGWUPyIycWjfNcvhYNQLG0ngTUpgKbEiJBpZi1E8ryZNWWWV
         1oLxeFKqk/mwne/dkvU+HVU2tkyeT1Ymb3XoKkP5REJesBZNiVxXv+oYih4WhNB19cix
         XwHo0TZJ02uadGqNeWAWsOm/ee199zmRKG8DeXpKkqzURdWk4C0HLQYA6DCcy2QcRAqc
         Kd4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=q0/Bzv8LR3nrHBEcBbxJ6zSiWU8DyJZht3loImaG1CI=;
        b=c6S8ZlL31BI7tBHerGPt2ceK6bc0Gai4lxmgLo2n60GGEUhIT1U6nKH/FCYLtpRoyF
         YpFQIr2SSnANb2ARXCEWvz78qFiKCn2jUsvyNjuMnDDDBE7YuFdFQ5ZpcP/0zlTdywZF
         NHJZLg+PJ8P5piUyxsl2ADXmDe7HCsRzrLAtPVj1jjKwqX13yeeaX1rgqQEWVBp8dqE6
         ToOLDRRipuoddmTqTSmLWZ1HLlcjczwIx1VwfXgNck5NCWm3ssocGkaonbqi44BpBkG4
         QlSv2PX/pxP0rciRLUoSbFhhHp20JF6CpCt7KXeiDhzeQ5gaHCecE8/YfAhqSc9W6OCw
         w5NA==
X-Gm-Message-State: AKwxytdbloNTc7ZFmRQpZznaUUb+RkuQKoxMitKDMYigO5DJQSojsFfT
        2sqUe7QTUtqSmAZVmPntufUVatg8kwPV94V2jkY=
X-Google-Smtp-Source: AH8x227+jD1BObWYdHbTo6px0/krN+n4wKM6+yYH0F6F969ifG7oN611V/fxEZISfVeHCjaSRjmuFO5QgpG1PJdhLSM=
X-Received: by 10.202.60.134 with SMTP id j128mr2822589oia.268.1517017353359;
 Fri, 26 Jan 2018 17:42:33 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.8.133 with HTTP; Fri, 26 Jan 2018 17:42:02 -0800 (PST)
In-Reply-To: <CAPig+cSjxiOTEKuOR9zGrY=Z_RoSBPHaiyNkzp-tXjSVNj3RHg@mail.gmail.com>
References: <20180126095520.919-1-pclouds@gmail.com> <20180126095520.919-3-pclouds@gmail.com>
 <CAPig+cSjxiOTEKuOR9zGrY=Z_RoSBPHaiyNkzp-tXjSVNj3RHg@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 27 Jan 2018 08:42:02 +0700
Message-ID: <CACsJy8C4LO0x3HHYQeKzrA7XqFVLDQkoY8+=Cm7RB4k0wjaPXw@mail.gmail.com>
Subject: Re: [PATCH 2/2] rebase: add --show-patch
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 27, 2018 at 2:11 AM, Eric Sunshine <sunshine@sunshineco.com> wr=
ote:
> On Fri, Jan 26, 2018 at 4:55 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Du=
y <pclouds@gmail.com> wrote:
>> It is useful to see the full patch while resolving conflicts in a
>> rebase. The only way to do it now is
>>
>>     less .git/rebase-*/patch
>>
>> which could turn out to be a lot longer to type [1] if you are in a
>> linked worktree, or not at top-dir. On top of that, an ordinary user
>> should not need to peek into .git directory. The new option is
>> provided to examine the patch.
>> [...]
>>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.=
com>
>> ---
>> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
>> @@ -840,6 +840,10 @@ To continue rebase after editing, run:
>> +show-patch)
>> +       cmt=3D"$(cat "$state_dir/stopped-sha")"
>> +       exec git format-patch --subject-prefix=3D --stdout "${cmt}^!"
>> +       ;;
>
> What is the behavior if a rebase (or conflicted rebase) is not in
> progress? Stated differently, do we only make it this far if
> $state_dir/stopped_sha exists?

It belongs to the same --continue/--skip/--abort group and won't reach
here unless a rebase is in progress (i.e. $state_dir exists).
--=20
Duy
