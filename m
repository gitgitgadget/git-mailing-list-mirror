Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AE3B1F667
	for <e@80x24.org>; Tue, 22 Aug 2017 20:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752520AbdHVUGk (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Aug 2017 16:06:40 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51704 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752441AbdHVUGj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2017 16:06:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D340D8DBE2;
        Tue, 22 Aug 2017 16:06:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dF716E3pRsNB3ZwDhehKLlbMK94=; b=GY7sLf
        KrhLbz3NkB2H1lQ/0+yofQZhr0E4KpdO1KZWKVqjSMV4Ck5YaDq/wVj71y0sX6Hx
        tp28128N765JoXtWrQTY9a/Agy5HVCQSRF2ScT0aBqSZD3K7g2BiYVN0iNJqcBs1
        9Zc/3AkzqisjfMP8sIwirGS2LMb52X95Cl1wg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=C05dUH1GF0Gagi/T06mkCTwuYVmfQWBI
        dX9z5vR7lhFIndPqOqmTxiNRWmefa82gyqL+jRNdghDSZDhPmVes0KdQQgNKY4Vd
        aiRYYHP3lIWOGGsDoSHHqfdA+Vyqh5picBl4MEhhpLljvA61dkDKWwlg5HmuITC0
        lYNrpxHytW0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CB7B18DBE1;
        Tue, 22 Aug 2017 16:06:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 22BA18DBDD;
        Tue, 22 Aug 2017 16:06:38 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Job Snijders <job@instituut.net>
Cc:     Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
        Git List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        yashi@atmark-techno.com, Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Add 'raw' blob_plain link in history overview
References: <20170802185901.GA27243@Vurt.local>
        <20170820180332.GC39363@Vurt.local>
        <CAOxFTcxOt878uDYj1Y0QMDNe8mNkfX3ZaZayOH3Njp9RWCJo0Q@mail.gmail.com>
        <20170821104425.geetdgi7q2uqycyt@hanna.meerval.net>
        <CAOxFTcxaxRjdsd0OSQX9E9ncEnO4XFLoa-0puXm2AByv6dZUow@mail.gmail.com>
        <20170821141306.wnlfn5a4hmgnj3yn@hanna.meerval.net>
        <xmqqo9r72yrg.fsf@gitster.mtv.corp.google.com>
        <20170822193520.GJ39363@Vurt.local>
Date:   Tue, 22 Aug 2017 13:06:36 -0700
In-Reply-To: <20170822193520.GJ39363@Vurt.local> (Job Snijders's message of
        "Tue, 22 Aug 2017 21:35:20 +0200")
Message-ID: <xmqqvalf1i5v.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 67E8075E-8775-11E7-A48B-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Job Snijders <job@instituut.net> writes:

> On Tue, Aug 22, 2017 at 12:22:43PM -0700, Junio C Hamano wrote:
>> Job Snijders <job@instituut.net> writes:
>> > Add 'raw' blob_plain link in history overview
>> >
>> > Reviewed-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
>> > Signed-off-by: Job Snijders <job@instituut.net>
>> >
>> > ---
>> 
>> Thanks; I somehow thought that your earlier one not just said what
>> it does (twice---that is not needed) but why this change is useful,
>> but that is lost in the patch description?
>
> We often work with very large plain text files...

You do not have to explain it to _me_ ;-) I wanted you to explain it
to our history, instead of me manually tweaking your proposed log
message in your patch with what you sent over e-mail in a follow up
explanation like this one.

> ...
> immediately click to the 'raw' version, saving time and improving
> workflow.

Most of the above, or at least a condensed version of it, should be
in the proposed log message.  That is all I was saying.

Thanks.
