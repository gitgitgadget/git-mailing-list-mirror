Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39AE11FF6D
	for <e@80x24.org>; Fri, 16 Dec 2016 04:57:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756921AbcLPE5c (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Dec 2016 23:57:32 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53857 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752257AbcLPE5c (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2016 23:57:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 978D759120;
        Thu, 15 Dec 2016 23:56:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=e5MHAKLSt9O8DwEDYifwEQczwXo=; b=V7Qx9d
        acaqocINnEgg0XIBITVi/k6fa6T+H/0eh3flmKp8d4RVY5Hh645hPU7yihwQbDaA
        jPPqwWfdGIenhMCnACJ0Up+ykM+ZToqLKFB/V8snLhg/Ohs/sPluo19cl04UrgVc
        2j33ETrM7Li58dRn7eyf2HSqiDEMxpS6ArZ0A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=h/QJM6QmwN2L1d04VGBfBITcMaQNovUX
        kywCh0TrCXpiFU4ZNNIONEK8/ZjGkXjyfR6hUyytT/Bkbfhub1YkRHAmQiMBwydt
        U3oQQ3qk1EVDRJmnKTgCc/bcKXygc4snYyQVIEJppxptqpDw8OaVTdFi02PL991g
        WsQS39+Zxb4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8F53E5911E;
        Thu, 15 Dec 2016 23:56:46 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0FDC45911D;
        Thu, 15 Dec 2016 23:56:45 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Allow "git shortlog" to group by committer information
References: <CA+55aFzWkE43rSm-TJNKkHq4F3eOiGR0-Bo9V1=a1s=vQ0KPqQ@mail.gmail.com>
        <CA+55aFxSQ2wxU3cA+8uqS-W8mbobF35dVCZow2BcixGOOvGVFQ@mail.gmail.com>
        <xmqqoa0cu3nn.fsf@gitster.mtv.corp.google.com>
        <CA+55aFySBc1Nd_xYZmXF9tdynjW+udsEz+PtkQpkrPjeFVcfDw@mail.gmail.com>
Date:   Thu, 15 Dec 2016 20:56:44 -0800
In-Reply-To: <CA+55aFySBc1Nd_xYZmXF9tdynjW+udsEz+PtkQpkrPjeFVcfDw@mail.gmail.com>
        (Linus Torvalds's message of "Thu, 15 Dec 2016 17:39:53 -0800")
Message-ID: <xmqqy3zgtqsz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0B97E7DC-C34C-11E6-8EF7-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Thu, Dec 15, 2016 at 4:19 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> This fell off the radar partly because of the distractions like
>> "there are other attempts and other ways", and also because the
>> message was not a text-plain that can be reviewed inline.  Let me
>> try to dig it up from the mail archive to see if I can find it.
>
> Sorry, I'll just re-send it without the attachment. I prefer inline
> myself, but I thought you didn't care (and gmail makes it
> unnecessarily hard).

Thanks.  

I do care, but I try to be lenient for inexperienced contriburors,
which you don't qualify ;-) Experienced ones are held to a higher
standard.

