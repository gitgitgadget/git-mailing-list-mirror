Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BC571F42D
	for <e@80x24.org>; Mon, 23 Apr 2018 13:46:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755293AbeDWNqy (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 09:46:54 -0400
Received: from mail-wr0-f170.google.com ([209.85.128.170]:35480 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755210AbeDWNqt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 09:46:49 -0400
Received: by mail-wr0-f170.google.com with SMTP id w3-v6so41463448wrg.2
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 06:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=9UrA1nOegUbWyYbibKcv1zVecwDlLo/x2nzLGJYL8+c=;
        b=s2McbP0Cnse7v78f+QmufFkpblmXcVVpY4S+kNRVa8ThsNcqcqHgH5H0sEXZZdBTq+
         qtqzT/tCB/Rha/LQ5tzOvSeaH1qT0F94dJiWZkOgY8sA7za3oALiEolCHgQLSF0YVlbI
         S1RdTSO5fYQYj7a8KO/RUOK5jiuofDc/r1STAWSxs4jar4YJB0Kh8RmxJj8ck+ZdHEkn
         TPk6yy4DNQCs0tsv5DsH6BSpbCbEfTRSiifVnPYJHvGoXh6iaPlbqohT3bP+uFDKetL7
         1RYP5mW/dNAgdSgHHdA/N4L6xrNmf0NEJL+L9AYwaMVkP0GmL1VGJuTZOdqz3uNH+cPt
         PM7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=9UrA1nOegUbWyYbibKcv1zVecwDlLo/x2nzLGJYL8+c=;
        b=HF87dfE6heKa6+bfBfLMvzFuwkPuwJWO5QivhEPw6gvhPGK90r+DM3cUCxwnnaipKr
         73KhQPm/ubqob2ilUgKYe5YAGj+PfJuBfkSQwq4DGhW7XEaIRTqzjSKtr1L6sTPuMU24
         FI4AFaCOW2zX/Zd58H+K5sKdYbVhWfoRKys9nM/FWXPsWvUpY7yQCv3Dpi58se7WNYye
         gwzAB6YaXcyiG0KAJZkJxF5NbrzDs/iVj31BH0ZB784h3cfo8bHNZ+Ijx8Gg0KAWhV4R
         g1T1tHDIGyOJ5Tfs42qdk8/IlvLfAgTUo1ogvxNiUNP+M+L9GRLb8rhESq896d1FUaFO
         ECuQ==
X-Gm-Message-State: ALQs6tA7z4SPK88GboKDZIT4fRig1WELWflU5AgPg/6BOAb9HMG7RSXk
        44Hq7ZjZsnBeBFCFfmAFtxw=
X-Google-Smtp-Source: AIpwx4+vIfws7hTCuy5+HA6s+5GDOSsyU0gnQgRw8vryeUyF2vO0Q4q9chXphv6gVir8XYkvKD9LcA==
X-Received: by 10.28.84.3 with SMTP id i3mr9830405wmb.37.1524491207947;
        Mon, 23 Apr 2018 06:46:47 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id r75sm5311035wmf.34.2018.04.23.06.46.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Apr 2018 06:46:47 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, l.s.r@web.de, martin.agren@gmail.com,
        peff@peff.net
Subject: Re: [PATCH v2 0/6] Teach '--column-number' to 'git-grep(1)'
References: <20180421034530.GB24606@syl.local>
        <cover.1524429778.git.me@ttaylorr.com>
        <xmqqsh7makj5.fsf@gitster-ct.c.googlers.com>
        <20180422233403.GE48072@syl.local>
Date:   Mon, 23 Apr 2018 22:46:46 +0900
In-Reply-To: <20180422233403.GE48072@syl.local> (Taylor Blau's message of
        "Sun, 22 Apr 2018 16:34:03 -0700")
Message-ID: <xmqq7eoy9gs9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

>> It seems that these two used to be "even when it is configured not
>> to show linenumber, with -n it is shown and without -n it is not,
>> when the new --column-number feature forces the command to show the
>> "filename plus colon plus location info plus coon" header.  I'm
>> guessing that the reason why these got changed this round is because
>> the old way was found too defensive (perhaps nobody sets
>> grep.linenumber in .git/config in the tests that come before these)?
> ...
> Do you think that it is worth testing --column-number with and without
> grep.columnnumber as above?

I view the "git -c var.val=foo cmd" as a reasonable way to make sure
that the test is not affected by any stale state in .git/config left
behind by an earlier test that did "git config var.val bar" and then
failed to clean itself up, but I do not think it is all that
intereseting to test the inter-changeability between config and
command line option "-n" while checking its interaction with another
option e.g. "--column".
