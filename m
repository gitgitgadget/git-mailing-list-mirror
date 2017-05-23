Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 476E72023D
	for <e@80x24.org>; Tue, 23 May 2017 01:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754173AbdEWBuC (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 21:50:02 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36037 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752309AbdEWBuB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2017 21:50:01 -0400
Received: by mail-pf0-f195.google.com with SMTP id n23so23763264pfb.3
        for <git@vger.kernel.org>; Mon, 22 May 2017 18:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=UcU+gm9KL1SNCLkexqn1EmHG/Z+Ie+E6gkmc2ibGdnw=;
        b=sosE2FYxTXzZn+UncAqRXZSk9439dytHF6WtrurNB8d/z1cKhzzQKIhxyzddLqU/FB
         wgchWmU4JCQmmlT3qlKMGhz+otEdkyvXhe/Mv2/Yg/cvr1YK8h8b3zr3W1IGB3SH+xMy
         nQfDA0ZekMXLYH3l2NILu0D6KnboEAC9Tc1AXT47T8J9Aa5z23xrxzkVZ1uyOOZ5oSF5
         Ct0zdwiAUfhbAixmWUY/qlVRGut/aNRRVails/mfwWWITh5WJaXVphZwiXg1R+KQL8Yk
         lzZe+dOxrPTIft/dkrHUpCvWM7Fds3Qg/Y3RC1ihqBW/VEG1LiH0/lIwjVQFVdIqQLXd
         Vx8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=UcU+gm9KL1SNCLkexqn1EmHG/Z+Ie+E6gkmc2ibGdnw=;
        b=Mu+1pa+bS0Qc0ikqpMby3xRNlJbylYxohmrAAOYWJd74ForjJeZQoU2rzH96dqd/Hc
         Tv7LrMIWIMc4Brsvk3giSYQiPmjypITr3g5aLfSq4t7sRKDetPdj11EUN2R21Ql3WcXs
         6TqkIGbSa8ZuE1RdgCUfW4sqQxDaIQazvGhUM3EIJHF/o5EnB+rWDuA16waXceWkTs41
         dAB2ZGXKDT+hwkWnU7avMDDcnwGX3dmK52ON6rKA7UXX0PmbuIeUNd8DQaWSi3D4WexB
         sWEsespKK5bI5r0ltczvrey5QqBxdtFXOKPgU8R2zwT//kGf9D7B+ZEN8C5O6ye1JtCc
         3Ylw==
X-Gm-Message-State: AODbwcBMI8+wb8F1QRJQtbvBYkH8gxXpeRBtIPG5GAKadqoQmLXk7P/8
        wZFBXEsMrqkrGaaQD0Q=
X-Received: by 10.99.117.26 with SMTP id q26mr28884805pgc.21.1495504200540;
        Mon, 22 May 2017 18:50:00 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b9c2:d2d1:97c0:9dab])
        by smtp.gmail.com with ESMTPSA id q27sm33528976pfk.4.2017.05.22.18.49.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 22 May 2017 18:49:58 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     DOAN Tran Cong Danh <congdanhqx@gmail.com>, git@vger.kernel.org,
        animi.vulpis@gmail.com, j6t@kdbg.org,
        Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH] ref-filter: treat CRLF as same as LF in find_subpos
References: <CA+izobvwRCwGEtpCbey=gFbCh9sHBb5xB1i1LpMG0JCUy0O2mQ@mail.gmail.com>
        <20170521134209.25659-1-congdanhqx@gmail.com>
        <xmqqy3tppu13.fsf@gitster.mtv.corp.google.com>
        <20170522201212.uuas26n6npdebsxg@sigill.intra.peff.net>
Date:   Tue, 23 May 2017 10:49:57 +0900
In-Reply-To: <20170522201212.uuas26n6npdebsxg@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 22 May 2017 16:12:12 -0400")
Message-ID: <xmqq7f18nxyy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, May 22, 2017 at 10:19:52AM +0900, Junio C Hamano wrote:
>
>> However.
>> 
>> If you look at how `git branch -v` before that problematic change
>> removed the extra CR, you would notice that pretty_print_commit()
>> was used for that, which eventually called format_subject() with
>> "one\r\n\r\nline3...", got one line "one\r\n" by calling
>> get_one_line(), adjusted the line length from 5 to 3 by calling
>> is_blank_line() which as a side effect trims all whitespaces (not
>> just LF and CR), and emitted "one".  The reason why the next \r\n
>> was not mistaken as a non-empty line is the same---is_blank_line()
>> call onthe next line said that "\r\n" is an all-white space line.
>
> I noticed a similar thing regarding pretty_print_commit(). Which really
> made me wonder whether the right solution is to drop the custom parsing
> code in ref-filter.c and use the bits from pretty.c.
> ...
> I suspect that's more work because we'd need to refactor pretty.c a bit
> to make the right functionality available. But the end result would be
> much more maintainable.

Yes, before I sent my response I debated myself if I should suggest
going that route (I would have done so if I were working with a
contributor who is already familiar with our codebase).  I agree
that it is the right direction to go in the longer term.

> PS I'm also a bit curious how a CRLF got into a commit message in the
>    first place.

I think I read somebody mumbled gitlab somewhere upthread.
