Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A38491F404
	for <e@80x24.org>; Wed, 20 Dec 2017 20:03:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756389AbdLTUDu (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Dec 2017 15:03:50 -0500
Received: from mail-qt0-f180.google.com ([209.85.216.180]:38381 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755534AbdLTUDt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Dec 2017 15:03:49 -0500
Received: by mail-qt0-f180.google.com with SMTP id d4so29797273qtj.5
        for <git@vger.kernel.org>; Wed, 20 Dec 2017 12:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=eZKGoiCrhmedpKqY2UmZwSsAgMlQMr/5WyFLXcuBgdA=;
        b=fIie6xd2BRF2lQuAYeI6i2zE46gfN196J9ee912IhWk4FMog+Xx1IGwufA3ROPhE7D
         7HRy/MWc/Uhm2r5G40ADy4RWljIS8mnWVNtFLNmghCpMSilRveSXbqWIFFbVkbNQomQV
         8L9kNi1aK1Q5F9a80rwH16Xx3EQbO3EVrqzqxxkrEWTiCOe5NMIQSAI7z8mu2vcAsULr
         Y3IJNunuBgD6lJhWz2emasDe84S//bHdaPZCELBozlOH7/eZ6wcCzQRs+rqXrXw7tku6
         UMRdhO7cKVRJzCVuXriF1kCZ1xPOhR+O2VD57zQ08mPLJHSlOHiwYgnRGZZLxAdTXnZW
         m+Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=eZKGoiCrhmedpKqY2UmZwSsAgMlQMr/5WyFLXcuBgdA=;
        b=tr6sk5VbbnLbTnfUdqa+BrDmqHcZ5QOM31eT7pohjsFmpsT+SYoOwYjhVanzmW3d8b
         CqiDVN27Hylu/eB/L7gDsTpueWG8p4xkuGOzvut8Gc312u+LfdSP7z4nsFMXxwWxKTxY
         ulpcfrkRkkdEIc1eQTPPNyrqGsAUfLjIejrjJ2HZQ0+hTzIV/g/DgSaP5v88SOmWobkx
         6KcghI28/JXgqxfx0rzH33nUW4cyl2oIt+pY/jotc2G2vBOZUJaR6zDze/dD6h/mrjgJ
         t5+6MqijLSpvJ+LAV3jcnMunoSANALJEIet9/Arj//D+dxVdLYEcWoPxn2QgHtNS1g00
         yyVg==
X-Gm-Message-State: AKGB3mJOkiTrma9FmLbV04Dfsi2Q9caan59oIZ/GbHWYwKestYAzsNTr
        5UQWN5lpxIjeBild3lhMIhOap1Fz5aGmxmQCSwE=
X-Google-Smtp-Source: ACJfBouT36oxnWfrhgcQX5y43I3abqN1IKxLnfwCweyExp7zeyh6PtF6A7cZ3m+i4RU0sS4lEeVxpT9ufEslKaQfNhM=
X-Received: by 10.200.6.76 with SMTP id e12mr11328553qth.217.1513800228797;
 Wed, 20 Dec 2017 12:03:48 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.198.2 with HTTP; Wed, 20 Dec 2017 12:03:48 -0800 (PST)
In-Reply-To: <20171220193845.11754-2-avarab@gmail.com>
References: <20171220193845.11754-1-avarab@gmail.com> <20171220193845.11754-2-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 20 Dec 2017 15:03:48 -0500
X-Google-Sender-Auth: ZhQ__KKpDgOfZxNUe-hfsa_GLms
Message-ID: <CAPig+cSeRZR7J9WSozTETVu=Y9N2wMRpoCgUkLXyzAaBOmTNZw@mail.gmail.com>
Subject: Re: [PATCH 2/2] commit: add support for --fixup <commit> -m"<extra message>"
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Pat Notz <patnotz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 20, 2017 at 2:38 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> Add support for supplying the -m option with --fixup. Doing so has
> errored out ever since --fixup was introduced. Before this, the only
> way to amend the fixup message while committing was to use --edit and
> amend it in the editor.

I can't tell, based upon this description, if '-m<msg> --edit' is a
valid combination and, if so, does it correctly open the editor after
appending <msg>?

> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
> diff --git a/t/t7500-commit.sh b/t/t7500-commit.sh
> @@ -272,6 +272,14 @@ test_expect_success 'commit --fixup provides correct=
 one-line commit message' '
>         commit_msg_is "fixup! target message subject line"
>  '
>
> +test_expect_success 'commit --fixup -m"something" -m"extra"' '
> +       commit_for_rebase_autosquash_setup &&
> +       git commit --fixup HEAD~1 -m"something" -m"extra" &&
> +       commit_msg_is "fixup! target message subject linesomething
> +
> +extra"
> +'

Hmm, so the first -m appended to the "fixup!" line, but the second -m
appended after a blank line? That doesn't seem very intuitive.

Also, doesn't the text following "fixup!" need to exactly match the
summary line of the commit message in order for "git rebase -i
--autosquash" to work? Am I overlooking something obvious?
