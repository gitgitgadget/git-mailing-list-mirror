Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58CC71F4F8
	for <e@80x24.org>; Thu, 22 Sep 2016 22:14:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754261AbcIVWOh (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Sep 2016 18:14:37 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62644 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751123AbcIVWOg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2016 18:14:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D672D3F501;
        Thu, 22 Sep 2016 18:14:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jwj7e0mUpMzFlVXImREf9afrBsU=; b=fgZ392
        P8VnbMBkjMWOz9HqfEOVDgxpAHcTB0IRMz9lHokgYkFdreMp36cHSmyHtEE3TJEe
        +2XLzd/+R111Ya8c/SyLWNSZby2fb7+I8UBVRY0z2jLbhYtkXOEmrVOcjsvMYC61
        Fa6xnKC7GbGr1OKjQ/1vmkRgGHqKlVwdFgyR0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=s0YROQteZiIwi0fqRltR3crIIPe9b6jv
        ZPQc0q6WvFpsRFlmKsiDr7boQTVHOa0l7YMMkS8bUE53cI2clL/ucpc7JGVNbiG8
        SRyrKPMoQQ9+g0Ta7eTe6C1Te6+mlf5wc4/FuDhLIBsA5Tiy6tlqEYCGbdSmaOMF
        JEsnj+eoFO8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CEA953F4FF;
        Thu, 22 Sep 2016 18:14:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4FF1F3F4FD;
        Thu, 22 Sep 2016 18:14:34 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Kevin Daudt <me@ikke.info>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2016, #05; Mon, 19)
References: <xmqqd1jzcvs5.fsf@gitster.mtv.corp.google.com>
        <20160921162628.GA27363@ikke.info>
        <xmqq7fa59mti.fsf@gitster.mtv.corp.google.com>
        <20160921174550.GB27363@ikke.info>
        <20160922064931.ganuwswlnom6nzya@sigill.intra.peff.net>
Date:   Thu, 22 Sep 2016 15:14:32 -0700
In-Reply-To: <20160922064931.ganuwswlnom6nzya@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 22 Sep 2016 02:49:31 -0400")
Message-ID: <xmqqa8ez37lj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F1418838-8111-11E6-8BA3-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Sep 21, 2016 at 07:45:50PM +0200, Kevin Daudt wrote:
>
>> On Wed, Sep 21, 2016 at 10:36:57AM -0700, Junio C Hamano wrote:
>> > Kevin Daudt <me@ikke.info> writes:
>> > 
>> > > On Mon, Sep 19, 2016 at 04:30:34PM -0700, Junio C Hamano wrote:
>> > >> 
>> > >> * kd/mailinfo-quoted-string (2016-09-19) 2 commits
>> > >>  - mailinfo: unescape quoted-pair in header fields
>> > >>  - t5100-mailinfo: replace common path prefix with variable
>> > >
>> > > Is this good enough, or do you want me to look into the feedback from
>> > > jeff?
>> > 
>> > If you are talking about the simplified loop that deliberately sets
>> > a rule that is looser than RFC, yes, I'd like to see you at least
>> > consider the pros and cons of his approach, which looked nicer to my
>> > brief reading of it.
>> > 
>> > It is perfectly OK by me (it may not be so if you ask Peff) if you
>> > decide that your version is better after doing so, though.
>> 
>> Alright, I'll look into it.
>
> Thanks. I am OK if we do not use my simplified version, but I think
> there were some issues I noted with your last version.

Yup, even some automated tool noticed a new leak ;-)
