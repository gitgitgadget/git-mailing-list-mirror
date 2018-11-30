Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8ED21211B3
	for <e@80x24.org>; Fri, 30 Nov 2018 01:40:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbeK3Ms1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Nov 2018 07:48:27 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52343 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbeK3Ms0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Nov 2018 07:48:26 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1EC44110EC5;
        Thu, 29 Nov 2018 20:40:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=X7xyIQU9/X/YH1hQcaIkCQNRhQI=; b=bW2jFR
        cT1820oWeWicV5mSFKn1pLV8EblhQDbcWPt19fP1eliRQ3vylzrWI5WFOqAhqul2
        SCOYJvV/ICqU1hJ9UMb+TXhmAgbZT845qqXF3qBLxMwVviN9mplCuZWSSfYuMlLf
        7SSXCUbwp07wSiDygFrkXZeY9HoTGvsRP9opQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VMLlXU87ofgqz63N21CLDB9GftjnTa1K
        fwfya4Al8i7PPViH3PngMmtprwzw25+g2FaWtQcu04v19ZhSg7qliZCQCtq+miJ/
        30gXVWl6k7QXoOeV2kz6y0AIdp7BGnPeWJ50e7KIBJQZS2neV+vCyIscAn8HEv5z
        Y4hWgf/8wgI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 182A3110EC4;
        Thu, 29 Nov 2018 20:40:52 -0500 (EST)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8A7C2110EC3;
        Thu, 29 Nov 2018 20:40:51 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/1] rebase --stat: fix when rebasing to an unrelated history
References: <pull.88.git.gitgitgadget@gmail.com>
        <680385e4bd5c34a5fcf9651a776c52db61557652.1543317195.git.gitgitgadget@gmail.com>
        <xmqqlg5cph1n.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1811291318090.41@tvgsbejvaqbjf.bet>
Date:   Fri, 30 Nov 2018 10:40:50 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1811291318090.41@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Thu, 29 Nov 2018 13:51:38 +0100 (STD)")
Message-ID: <xmqqo9a7mjfh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F84F4E40-F440-11E8-8AED-BFB3E64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> But I guess that I should not be so lazy and really use two different
> messages here:
>
> 	Changes from <merge-base> to <onto>
>
> and if there is no merge base,
>
> 	Changes in <onto>

Ah, that's excellent.

Thanks.
