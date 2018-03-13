Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7E721FAE3
	for <e@80x24.org>; Tue, 13 Mar 2018 16:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933682AbeCMQcO (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Mar 2018 12:32:14 -0400
Received: from mail-wr0-f177.google.com ([209.85.128.177]:42693 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933657AbeCMQcM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Mar 2018 12:32:12 -0400
Received: by mail-wr0-f177.google.com with SMTP id s18so577473wrg.9
        for <git@vger.kernel.org>; Tue, 13 Mar 2018 09:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=O2VToWs+PQ/by6vxuFHmM58xjnMDHIjnh1Etzc7uzYo=;
        b=KneKJeJO6I+verbi60sspMWFNc7nq1y7VYyY52VXt+dLn15e5TzWPWJZg/c6IlHztb
         qNNqXV9HE3AxMcBeYoXjp3VDIMTeKyo52YPbKHEL2RVRddjl3YsIzTUc9ICPei0n+i9R
         9bKSjLS5mGvfsNSIR2emcW8pCJvC2Pmcbpi0esC57iuRTrqt8B67cArRSGUFO+dF+M8P
         zNuVECjLOQIHCss/npDWUyMVHzYCPHZicK2oHz0LEboiH09XdWR40SLipkiAJwSqa6qv
         +inJwlUh+4ejTyJOhimG5wW7Kpm3p8wxPFU6JlEys3jZzADfAxMm9h9ujxXpW4jqZjPK
         WJ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=O2VToWs+PQ/by6vxuFHmM58xjnMDHIjnh1Etzc7uzYo=;
        b=IizeTKxadTML/7wb+IiMYmjhNevf+qKkURtcGpwv1C5O+4XqhlN2XNSKY08QjMzXuc
         xELV9l1KOlU2aaOmoe9jAhN5ho3436qplaz1PD8uKNN+QzoZ2xaDI1I/joZmnf2TUfQo
         uPYxl2F/cCafdhdRWAq0WBMBs1820Khzg0pLcV19EvmcFc1FD/5cdVvyKYXM5Pl/sR7z
         2xp8TrKQ8KT/sIEzxLvW/f/zuHITgrJX9mYTzqJMAv8gllGyIgsYG/Y0uLlWmLPGFAGP
         kuOPb9JXIzuRAQLyXfFEhojvA3OsZ5odFEBY7rxrClYPKZVvJRENgD5gGS1ra6t7Q6Nl
         DLdw==
X-Gm-Message-State: AElRT7G1j/7PoQCGFxu/YXbachEXLFdqsObqB8pp8sTATAcWi3r7Q8i/
        8y8cWeshqUWcyLh50GXSNnw=
X-Google-Smtp-Source: AG47ELtpHFi8FnFB/hCI2rv/vjf9GoOBhWqNRboyDM5r/O9wLs08j9pUMTDLmMlxHYDAYmg7shfIMQ==
X-Received: by 10.28.241.15 with SMTP id p15mr1287038wmh.42.1520958729738;
        Tue, 13 Mar 2018 09:32:09 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id e53sm778011wrg.34.2018.03.13.09.32.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Mar 2018 09:32:09 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Gustavo Leite <gustavoleite.ti@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 2/3] add -p: allow line selection to be inverted
References: <20180219113619.26566-1-phillip.wood@talktalk.net>
        <20180306101750.18794-1-phillip.wood@talktalk.net>
        <20180306101750.18794-3-phillip.wood@talktalk.net>
        <xmqq371d3rjz.fsf@gitster-ct.c.googlers.com>
        <6476d776-dbf7-09cf-1c65-e413798b9987@talktalk.net>
        <xmqq371axxm5.fsf@gitster-ct.c.googlers.com>
        <ea4f645f-5cf2-ef84-24cf-fb585f96039d@talktalk.net>
Date:   Tue, 13 Mar 2018 09:32:08 -0700
In-Reply-To: <ea4f645f-5cf2-ef84-24cf-fb585f96039d@talktalk.net> (Phillip
        Wood's message of "Tue, 13 Mar 2018 12:06:11 +0000")
Message-ID: <xmqqsh942ayf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

> On 08/03/18 17:53, Junio C Hamano wrote:
>> Phillip Wood <phillip.wood@talktalk.net> writes:
>> 
>>> and use a leading '-' for inversion. I'm tempted to keep supporting 'n-'
>>> to mean everything from 'n' to the last line though.
>> 
>> Thanks for double checking.  It would be a better endgame to follow
>> up with an update to existing "range selection" code to also support
>> "n-", if you go that route.
>> 
> I'm afraid I'm not sure exactly what you're suggesting. At the moment
> the range selection code is in the first patch and supports incomplete
> ranges. Are you suggesting that support for incomplete ranges should be
> in a separate patch or have I misunderstood?

My observation of the situation behind my reasoning is:

 - There is an existing UI that uses "-X" to mean "exclude what
   matches X" and that was the reason why you decided to follow suit
   instead of using "^X" for inversion of X.

 - Such an existing UI would not have used "-X" to mean "the first
   possible choice thru X".  You will lose that from your new thing
   and you accepted that.

 - It is likely (I did not check, though) that the existing UI would
   not have used "Y-" to mean "starting from Y all the possible
   choices thru to the end", but that is merely for symmetry with
   the lack (inability to use) of "-X".  There is no fundamental
   reason why "Y-" cannot mean that, and you are tempted to allow do
   so in your new thing for the same reason.

So if we are going to have "N-" to mean "everything from N to the
last line", then the same "Starting at N to the end of the all the
possible choices" should be allowed in the existing UI (i.e. the one
that forced you to give up "^X" for the sake of consistency) for the
same consistency reasons, no?

For that, if you want to keep the "n-" you did in your first patch,
the most logical thing is to have a preparatory enhancement to teach
"N-" to list_and_choose(), and then build your series on top.  Or
you can do without such a change to list_and_choose() in your series,
in which case, you drop "n-" support and then at the very end after
the series settles, add "n-" support to the new code in this series
and to list_and_choose() at the same time in a follow-up patch.


