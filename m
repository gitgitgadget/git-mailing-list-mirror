Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A87E11F404
	for <e@80x24.org>; Wed, 14 Mar 2018 17:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751353AbeCNRtD (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 13:49:03 -0400
Received: from mail-wr0-f172.google.com ([209.85.128.172]:33776 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751000AbeCNRtC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 13:49:02 -0400
Received: by mail-wr0-f172.google.com with SMTP id z73so1379573wrb.0
        for <git@vger.kernel.org>; Wed, 14 Mar 2018 10:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=PsipZN1xVzYxDh4k49wXM3Sj+1omsbZxXWx0rKD3jvA=;
        b=I/bA6YLuuFwujvp6rkwh0Czr2xHxoPDS0DehSjNnYTva8W5LirP51J16UGjvchUst8
         Kgmpqkwpskfa4UTJw3N7Jro97RP+OtMwWRgIdTDI92c6LyysYrrXAkak6+EY0Q/KQszc
         iuoNdG4LtUnK3Muft8fKhYuqtZ+PkypE8tSzO2+Nk89gDNK644Bm/y8+OPPpqxbzqHPg
         PwoxFw6NqxcxVWMOq5bf4QmLhoxrRjnlEAE+KXihc5ndUGdcfnVJ9SmMfcYfTGXk/SyP
         nDguPaaKyeQ87WmYay3v/yewmV7u+Q0UMhfhyFMwc3ZeP4NTZ6ZrRSi8KlJrTswFCNc9
         5+Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=PsipZN1xVzYxDh4k49wXM3Sj+1omsbZxXWx0rKD3jvA=;
        b=W1VBxpCbUmXt03gvukJBHwZl1JKxC3xAz1sp58aEzJ3meKFvPksSPkUe6ezFlcnQbp
         2TRPfK4hqe6UG1hZ1BhJYCCIeRCEcfKJsn2LrMj/2mNBc9QzA+RuQujFv0HPBRhosBBb
         /35ZF2rc/Oy+u6NVBA5I2Zf+WlRMY+UuMqfzHxMNc/ad/KGiHeX3CFhqwUhv2/Lk5n3l
         az5PbHcbjtggN2c2iQMaBsLdCMfuI58YbAvTvF2C8ksE4Uybw0uUpgGobolB6OrbSNAm
         QsBM545QodupSbVx9OvoZKH7F7X8RfF42pintwXda0/QQzt3Ox6CYEO0gdWxEsfweX4X
         QTDg==
X-Gm-Message-State: AElRT7GvgqjApSe2aW1Tgt3iOTlpz0eSoOxWgHvM/fGEAfpaDPed49fB
        puVI2hRwT3Yd8UV2wLtvFS0=
X-Google-Smtp-Source: AG47ELud+MayIaVMEEfm9FlL1qN6jmPNshUMQyp+JYBqpawJj7lFr+GCI8GyiqD+AvEHLRZgTZSG2A==
X-Received: by 10.223.134.42 with SMTP id 39mr4778785wrv.10.1521049740762;
        Wed, 14 Mar 2018 10:49:00 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 9sm3089901wml.22.2018.03.14.10.49.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Mar 2018 10:49:00 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 1/2] rebase: support --signoff with implicit rebase
References: <20180314111127.14217-1-phillip.wood@talktalk.net>
Date:   Wed, 14 Mar 2018 10:48:59 -0700
In-Reply-To: <20180314111127.14217-1-phillip.wood@talktalk.net> (Phillip
        Wood's message of "Wed, 14 Mar 2018 11:11:26 +0000")
Message-ID: <xmqqh8pizgxg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> This allows one to run 'git rebase --exec "make check" --signoff'
> which is useful when preparing a patch series for publication and is
> more convenient than doing the signoff with another --exec command.
> This change also allows --root without --onto to work with --signoff
> as well (--root with --onto was already supported). Note that the
> failing test is due to a bug in 'rebase --root' when the root commit
> is empty which will be fixed in the next commit.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---

How important is the word "implicit" in the title?  Is it your
intention to actively ignore --signoff when we fall into the
rebase--interactive codepath explicitly?

I offhand do not think of a strong reason why it is a bad idea to
run "git rebase -i --signoff", turn a few "pick" to either "reword"
or "edit", and then expect that the editor to edit log messages for
these commits to add your sign-off when you start editing them.
The "pick"s that are left as-is would also turn into doing an
otherwise no-op "commit --amend -s", I guess.

If you are teaching --signoff to the whole of "rebase--interactive",
then "git rebase --help" needs a bit of update.

    --signoff::
            This flag is passed to 'git am' to sign off all the rebased
            commits (see linkgit:git-am[1]). Incompatible with the
            --interactive option.

