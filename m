Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 622381F404
	for <e@80x24.org>; Thu, 15 Mar 2018 16:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752009AbeCOQTD (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 12:19:03 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:40127 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751976AbeCOQTB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 12:19:01 -0400
Received: by mail-ot0-f196.google.com with SMTP id l12-v6so7431003otj.7
        for <git@vger.kernel.org>; Thu, 15 Mar 2018 09:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=I4Og8Ui7M9pNr0J+/6gM6QHQH+jxGu8V+8tpHDgjbXY=;
        b=lr5layPTxQPpWKc4WcZFfl/v4gKZhc1T74PP9OdzJYHs7ZMZRdCgmtZggJ96ucoORI
         ztaR91Mzg48D/LLLXm0PSuNTKcg32krTR5v0qtjMu5xvEcKAtoF3SrHEPWjBFwZYZ7Qn
         wJOjF8zRthf5RGM64V2Vm1ynLxJvg61+G2woMc4S9gF4a0XXEI4omRND54hXaCI8LNs7
         qRkTE50H1irV/ZqWoHqVa6G48llAo9rECTVD9lO6bqaXhScoCRDEX2wb0DuB4Y80vDRV
         k+qjvi2GbiiN2XYSPccrhvbYuHTq3bTfdwVOJfF9a/xJB48WZfKQFz8OJ+x2980myTDj
         6KZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=I4Og8Ui7M9pNr0J+/6gM6QHQH+jxGu8V+8tpHDgjbXY=;
        b=nbDhYrHXJaTjemGOIhklTvtqlRcwIqP53M1JWFtJuEh890ToppyJ3e9DIlCkYh2reJ
         7wlD6jD8BmNgD5ezZhBHjFwXTOuTh+cE9fXEsFFlCswCp5jzlpfuXCqDnPZe2GmJaLf+
         pxqSru1tmd3MMu5CAjy6L1VObdDfbde73dvLxPvE2THwbSg7or4WQbc8+bQjPhq7Vt/x
         cP2v0GSzWRKnHQrYzwtpUFSz7d9vSq0DyyAJt+9sniqTsrdDh98ag8htC6zhm5A15rlO
         WKko+iE7XERp8bGivPFupNgUkKdFjaEsBzVhFxIcbjDYnagdP/I9Lp0C02QXXxk3btOd
         SW6g==
X-Gm-Message-State: AElRT7HEVNQ9rGiTI0+fawXgLdxQa7rVI3uQo7+Yb9KZe+OzviL0oTUf
        ilz6JZRJDNIMgsVC2boGO/74UL8ySjcG3OmYXnzH1DFH
X-Google-Smtp-Source: AG47ELtdZlX7NxyCIikPyOeBVd5bfgq3sYSZ28tNswel1ziKLATRIKocOx3kqP1XwNZSjM9LSQTvG6txFUoDKCb+CDc=
X-Received: by 10.157.39.138 with SMTP id c10mr6445931otb.132.1521130740351;
 Thu, 15 Mar 2018 09:19:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:34a2:0:0:0:0:0 with HTTP; Thu, 15 Mar 2018 09:18:59
 -0700 (PDT)
In-Reply-To: <xmqq605x72qs.fsf@gitster-ct.c.googlers.com>
References: <20180315130359.6108-1-michele@locati.it> <20180315141220.GB27748@sigill.intra.peff.net>
 <xmqqa7v973b5.fsf@gitster-ct.c.googlers.com> <20180315154815.GA29874@sigill.intra.peff.net>
 <xmqq605x72qs.fsf@gitster-ct.c.googlers.com>
From:   Michele Locati <michele@locati.it>
Date:   Thu, 15 Mar 2018 17:18:59 +0100
X-Google-Sender-Auth: SwWd_WRKYBlaNMjYjBWPtHLx48k
Message-ID: <CAGen01hodC=z_74z+7fSSrx2kvPnSbOQaML9kBb9iO6xCvWHQA@mail.gmail.com>
Subject: Re: [PATCH] filter-branch: return 2 when nothing to rewrite
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Michele Locati <michele@locati.it>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2018-03-15 16:55 GMT+01:00 Junio C Hamano <gitster@pobox.com>:
> Jeff King <peff@peff.net> writes:
>
>> Hrm. I took the goal to mean that we used to exit with a failing "1" in
>> this case, and now we would switch to a more-specific "2". And I think
>> that matches the behavior of the patch:
>>
>> -test $commits -eq 0 && die "Found nothing to rewrite"
>> +test $commits -eq 0 && die_with_status 2 "Found nothing to rewrite"
>>
>> Am I missing something?
>
> No, other than that I wrote my response before sufficiently
> caffeinated ;-)
>
> Thanks, then other than the lack of doc updates, I do not see an
> issue.


Great! So, I'm ready to update the patch, including the doc changes,
which will be
the one suggested by Jeff:


EXIT STATUS
-----------

On success, the exit status is `0`.  If the filter can't find any commits to
rewrite, the exit status is `2`.  On any other error, the exit status may be
any other non-zero value.


And yes, I'm a brand new contributor, so here's my question: how should I
send an updated patch? I can't find anything related to this in
https://github.com/git/git/blob/master/Documentation/SubmittingPatches

PS: nice community!

--
Michele
