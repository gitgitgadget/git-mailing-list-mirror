Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE77C20281
	for <e@80x24.org>; Fri,  3 Nov 2017 01:50:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932657AbdKCBug (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Nov 2017 21:50:36 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51143 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932285AbdKCBuf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 21:50:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EF943BF5C3;
        Thu,  2 Nov 2017 21:50:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nfaFIX6FEVQbqSFXn+P/AZRxIDc=; b=BlY7+N
        OHHSoKUHPCVnlkhsHJVkvg0gUx8DvzZbNYqj+DiiKUS5xNgVswCRXger1U4TN1Ud
        XzdgOpDcDq3FdaypJCN6+BSrd/u6owcst4Xr9Yspk1tEAS/SGo9rivKbOV0ffXvG
        zkt/4fw4hndHGVlHGmYD6k+MN3AZy8tlTvdms=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NVD+06K0PQrOSyQVaBIuMqyL8w9fwPin
        MDsjB0WdpAxw3EDM8E8e3sRcHIK83/LjIJp0cfqv7rvhCdLWpq9wAyhdH5N23/fv
        fGsyUq/VBDWhUUodWzRKNqkuieojJMVFdMzoTP25gTkQk8ev/xJ45HDwUyNmhrZI
        Vfi0ArNyfAM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E5FEEBF5C2;
        Thu,  2 Nov 2017 21:50:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 62C0BBF5C1;
        Thu,  2 Nov 2017 21:50:34 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 3/3] mingw: document the experimental standard handle redirection
References: <cover.1509382976.git.johannes.schindelin@gmx.de>
        <436f0fb010709fe0d90460dc7bc1b3482237b192.1509382976.git.johannes.schindelin@gmx.de>
        <CAPig+cQs+6xCn=OR_Mw8vbEwEJ0c=sqnaEChOxuVw=kV4PQwsw@mail.gmail.com>
        <alpine.DEB.2.21.1.1710311807420.6482@virtualbox>
        <xmqq4lqevbmk.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.21.1.1711011726030.6482@virtualbox>
        <xmqqr2thsby4.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.21.1.1711021819430.6482@virtualbox>
Date:   Fri, 03 Nov 2017 10:50:33 +0900
In-Reply-To: <alpine.DEB.2.21.1.1711021819430.6482@virtualbox> (Johannes
        Schindelin's message of "Thu, 2 Nov 2017 18:20:25 +0100 (CET)")
Message-ID: <xmqqzi84p1ue.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 61C6F95A-C039-11E7-A857-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> If I was correct in assuming that "2>&1" is just as foreign as
>> ">/dev/null", then we should be shunning "2>&1" just like we shun
>> ">/dev/null".  That was all I meant to say.
>
> Did you know that `2>&1` works in Powershell?

No.  And that makes me curious if ">&-" is also there to replace
"off" ;-)

