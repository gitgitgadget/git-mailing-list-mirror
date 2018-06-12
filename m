Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97F411F403
	for <e@80x24.org>; Tue, 12 Jun 2018 19:52:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754176AbeFLTw2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Jun 2018 15:52:28 -0400
Received: from mail-wr0-f182.google.com ([209.85.128.182]:35193 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754090AbeFLTw1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jun 2018 15:52:27 -0400
Received: by mail-wr0-f182.google.com with SMTP id l10-v6so231766wrn.2
        for <git@vger.kernel.org>; Tue, 12 Jun 2018 12:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=hq75cCAHKapFCUx1nW6oIJfLKWX8AlVyqy44wdzowrQ=;
        b=qF6QoEqKcVE9SSWbTYpbr/B7SCQOokxUHFSIroOnsZA03aUigzd1+JWDxycoF98uUd
         a1kQnUzlxb5VPz5MghjKHYSnM7/R2eojl63K7j2vHGyY+6OewL/VLr9nLjL5dF5vmvmj
         JLy+g8IZdmL0g6mel+UqaqWIir3aREz6V3iSx7me2p15rxLy3WoUPXmSBn6Dqki3hh/T
         4MfrsFDNYMD011w+zq/NagtVIp0UVw5nQ+BPRrMoCcdx62PSCDUqs+evnYu5mtisf6wr
         VVbaqVe6qW9I/SVfG7ajM0Bc3F9WiGiWavaQYXvqXbYjgelXQk5wNaO++k+ZrLo/AXvn
         JmAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=hq75cCAHKapFCUx1nW6oIJfLKWX8AlVyqy44wdzowrQ=;
        b=X3f25YIOZXs/sZN18m9fMrqweS4WpvvzO8DDnYW1gqA/1XyYmgSp28ZTKLe1Aj0jwg
         Sl+h+gjXpfnLgXfys8BmXs6fTx559unlrAiTCLBM1N6JXBkT9onWXPkGZ2Eiam5J1qKn
         VpMcFKoYjWP0X7bngP3aJLpWaFbFLyhOgWnzxHz81K6dJ55BTdgQqxhkgtXuXL2BnbBK
         vG2lJPo5LE9G0BhUdGqTOEsShuUa5MTBSFcCzf9DzWRVdvGsq7O43yYPjcc7bTzPF9A0
         xWxEfSQJmIxXAHHG6+rE859juyCbgQoB0pkwi255fcE9y8Ruwudv5+E8fjf5GCEG2zYX
         yvJg==
X-Gm-Message-State: APt69E2tx7WEo8I5IPw6pqxqI7YNsoiSyADu1N3HMcdGEb9qwNFb7vin
        1OjbZ8mzADKyEG/IDGnC8Jw=
X-Google-Smtp-Source: ADUXVKJRAQDmkzfDJQKU5zu1rOhv/N3mRVWZuQy/a1r3WPTrliMfN/08gcSWqzkvx+jWbtMc79FsnQ==
X-Received: by 2002:adf:f344:: with SMTP id e4-v6mr1613177wrp.161.1528833146262;
        Tue, 12 Jun 2018 12:52:26 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id b15-v6sm1880651wri.14.2018.06.12.12.52.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 12:52:25 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sam Kuper <sam.kuper@uclmail.net>
Cc:     git@vger.kernel.org
Subject: Re: `git merge --abort` does not run `git rerere clear`
References: <CAD-JurLXh=rOC=bhjTa8jCpeDWkbDhCztSpjLuMEUGm1-QnAiw@mail.gmail.com>
Date:   Tue, 12 Jun 2018 12:52:25 -0700
In-Reply-To: <CAD-JurLXh=rOC=bhjTa8jCpeDWkbDhCztSpjLuMEUGm1-QnAiw@mail.gmail.com>
        (Sam Kuper's message of "Tue, 12 Jun 2018 20:32:28 +0100")
Message-ID: <xmqqr2lb9406.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sam Kuper <sam.kuper@uclmail.net> writes:

> `man git-rerere` says:
>
>> clear
>>
>> Reset the metadata used by rerere if a merge resolution is to be
>> aborted. Calling git am [--skip|--abort] or git rebase
>> [--skip|--abort] will automatically invoke this command.
>
> It makes sense that `git am [--skip|--abort]` and `git rebase
> [--skip|--abort]` would run `git rerere clear`.
>
> However, if they run it, then shouldn't `git merge --abort` run it, too?
>
> If not, then what is the reason why not, and might it be helpful for
> this reason to be mentioned at some appropriate place in the
> documentation?

I do not think there was any reason, other than that those who added
"git merge --abort" weren't as careful as they should have been ;-)

The command is a mere synonym to "git reset --merge"; I am not so
confident that "git reset --merge" should also clear the current
rerere state.  If (and this is a big if) "git reset --merge" should,
probably the right place to do so would be remove_branch_state(),
before the function removes merge_rr file.  Doing so might allow us
to lose calls to rerere_clear() individual codepaths of various
"abort" implementations make, but that would certainly require
careful thinking to avoid unintended regressions.


