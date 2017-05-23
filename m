Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A8BA2023D
	for <e@80x24.org>; Tue, 23 May 2017 02:01:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757425AbdEWCB2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 22:01:28 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34769 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754435AbdEWCB1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2017 22:01:27 -0400
Received: by mail-pf0-f194.google.com with SMTP id w69so23831147pfk.1
        for <git@vger.kernel.org>; Mon, 22 May 2017 19:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=TBJI7fVAvYjhUSTh+kMtZKR5Tp8VCAzsObteP1sFyGk=;
        b=d8QGf9nYvvS+Unb8pZpbnbuzhrnjC0zs2LIoB7e2mzfWw1ARqpDuBxtvVjyzpfy+d7
         fr36SHfH4m4P/B3uvbjDXL/gIDLielzrjAcxkPQCTqzJrYwGW/FP+JSstOP31YT5mMyX
         bdyexfozb9UsiQxLYhaUlptsvycmXV+w47rV17wZ9SzWBrsnu/MVS/NwxqXYQFx8+95y
         SKAmRTAH1je61hsxIFRgf1uKN84Bh6wV6gp2BP0M6sLJJtDu4IFq0bOzwdcIimZjen2l
         ALehoLDmUFbx0Dig2xQtAJjfTHeStsmxVyPnR6Z2bDF5LGAmMdkY0OmZROitypcU/QqM
         MAdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=TBJI7fVAvYjhUSTh+kMtZKR5Tp8VCAzsObteP1sFyGk=;
        b=EekMpHBcUN0ApifBUBQkV/QyEdrWMXV5xYjRmjMIU4rz72wquglWnG0LCWxWLgngue
         3XplIRas07n4phRaDwFKWAI8bSzMBHzV7Sh/JRRv4PsglV42zKOjB7gre/66Ke+vx3m5
         oW21wBB+Qsw2+EtPBoWk9efJ6cTZGRCK6sqtelHET7rjF2DlZBwG6CuY+fS/+5Ovdg/X
         lHPg2ELzsoowNXhu0ax19j1iUzay28y/+/NuGXjcvjH6YDfibJfeFUyDrNDFXkwGNQu+
         mVNqOaSv8IpvJuQthEFWb9mcw2/jEVGVNvVkgyAkQaOmUXbi/gAEtm6krVv1O3UL4N1e
         bFsA==
X-Gm-Message-State: AODbwcBxz/d+XGrN5LBh6mpLdPmfl2KUxcF1tlgxHXgx+kUfXXpA8TLa
        meFV79DQ/fY+I0fb7Jg=
X-Received: by 10.98.31.89 with SMTP id f86mr28119119pff.8.1495504876859;
        Mon, 22 May 2017 19:01:16 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b9c2:d2d1:97c0:9dab])
        by smtp.gmail.com with ESMTPSA id n22sm23834970pfa.123.2017.05.22.19.01.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 22 May 2017 19:01:15 -0700 (PDT)
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
Date:   Tue, 23 May 2017 11:01:15 +0900
In-Reply-To: <20170522201212.uuas26n6npdebsxg@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 22 May 2017 16:12:12 -0400")
Message-ID: <xmqq37bwnxg4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I suspect that's more work because we'd need to refactor pretty.c a bit
> to make the right functionality available. But the end result would be
> much more maintainable.

I actually think the entire codeflow of "find positions and length
of threeparts" using find_subpos() and then "copy the length bytes
starting position for C_{SUB,BODY,SIG,LINES,...}" must be rethought,
if the behavior of pretty.c::pretty_print_commit() is to be matched.
With the current code, %(contents:body) and other atoms that are
handled in ref-filter.c::grab_sub_body_contents() keep trailing
whitespaces on their lines with the current code that copies length
bytes starting the position using xmemdupz().  There need to be some
code that loses these trailing whiltespaces in the copied result.

While I do not claim that refactoring and reusing code from pretty.c
is the only viable way forward, it is clear to me that a patch that
updates find_subpos() and changes nothing else falls short X-<.

