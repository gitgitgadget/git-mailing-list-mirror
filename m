Return-Path: <SRS0=/LSK=5B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F79C0044D
	for <git@archiver.kernel.org>; Mon, 16 Mar 2020 15:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87DCF2051A
	for <git@archiver.kernel.org>; Mon, 16 Mar 2020 15:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="EIru1rPh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731896AbgCPPsU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Mar 2020 11:48:20 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61081 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731685AbgCPPsU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Mar 2020 11:48:20 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 43862A9C2C;
        Mon, 16 Mar 2020 11:48:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KjhPY2sp5cTrOS/zKFbb0TcwO6I=; b=EIru1r
        PhfEMszK614NY1/BUOz4HtXhoAsMXm14Trv7wi/B0NLDqqqab6ZR0ju+/RyTsfcV
        IYiG39wn+Er21/vHcsNb9xNZwjevLtxWnLQt3pWuvYxUEvCQcbIyryatKObQCErM
        EztMw4Aj6OtZRfkDYEiGMqcSEvzZop0LSoFOs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XAffctjGun8D4LszkAHHfMdsv4Kkz1Je
        +k2H4zpYSfLKYbhvlGs9b7syhLjpYQlCbMXSxHug4OcAi8PT+QhbNnAT+kJ2CrgW
        BrQsEWOpHLtMb3RDlT6NmTwVAvpoKXm52R4lcuQakpHrN4aDpQ23FD9a9FodBUrS
        VbC5dw9VO1Y=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3BE10A9C2A;
        Mon, 16 Mar 2020 11:48:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 73FA3A9C16;
        Mon, 16 Mar 2020 11:48:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Pratyush Yadav <me@yadavpratyush.com>,
        Git List <git@vger.kernel.org>,
        Jonathan Gilbert <JonathanG@iqmetrix.com>
Subject: Re: [PATCH v1 0/2] git-gui: reduce Tcl version requirement from 8.6 to 8.5
References: <20200314224159.14174-1-me@yadavpratyush.com>
        <CAPig+cRXD_bjUL6=daEAx7VnAy_nw9bao6rLK9xwTCYJSk48Qw@mail.gmail.com>
Date:   Mon, 16 Mar 2020 08:48:15 -0700
In-Reply-To: <CAPig+cRXD_bjUL6=daEAx7VnAy_nw9bao6rLK9xwTCYJSk48Qw@mail.gmail.com>
        (Eric Sunshine's message of "Sun, 15 Mar 2020 14:54:07 -0400")
Message-ID: <xmqqwo7k8fnk.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8DCEF670-679D-11EA-A7CC-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Sat, Mar 14, 2020 at 9:47 PM Pratyush Yadav <me@yadavpratyush.com> wrote:
>> Some MacOS distributions ship with Tcl 8.5. This means we can't use
>> TclOO. So, use our homegrown class.tcl instead.
>
> It should be mentioned that this patch series fixes a regression in
> Git v2.25 in which git-gui could not even be launched on Mac OS. The
> problem was reported here[1] a couple months ago.
>
> I performed some rudimentary testing of this patch series on Mac OS,
> and it appears to be working as expected; it certainly fixes the
> problem of git-gui not launching on Mac OS. (I did notice a
> misbehavior related to the original patch which caused git-gui to be
> unusable on Mac OS in v2.25, but I suspect that misbehavior is not
> related to or caused by this patch series, thus shouldn't prevent its
> acceptance.)

I was actually hesitant to see this kind of change for the first
time this late in the cycle (the code may work with old Tcl/Tk but
do we know it does with newer ones?)  

I'll pull git-gui updates when Pratyush tells me to, which would
happen before the final (scheduled on 22nd).  I'll trust git-gui
maintainer's decision to include these changes in it, or to cook
longer to wait for the 2.27 cycle.  Comments like yours that help
Pratyush make the right judgment is greatly appreciated.

Thanks.  
