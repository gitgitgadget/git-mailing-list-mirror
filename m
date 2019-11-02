Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7DFD1F454
	for <e@80x24.org>; Sat,  2 Nov 2019 04:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbfKBExc (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Nov 2019 00:53:32 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50819 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbfKBExb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Nov 2019 00:53:31 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9AAF92F119;
        Sat,  2 Nov 2019 00:53:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9f2isN6kbGJqD/7QKvBVtEuHomQ=; b=k2O4Qi
        0M5akEuTEKN+tN6Q2EL0XXvxo70Jf8onXyMrGdHdFUbJIhYROFnxIdp8TrPlPzAk
        eAXgck+bjq5dGUJbpprUHfrc12dyebuB98mWPJ5zSPsGECL3Rcf/MLmB4LDXMAo0
        P3OS7uaxnOFFX+iMS19D8n3F29G9I4OLgcgQY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=S6/p56uLhwG8v1c3af0zN6sQepIZ3DUM
        lpLBS304+YiJxKD+zDe2JUTutLf5kjKmHi2FIjQyRsIwfFsA2lLh7c03gEJOWCib
        SCEgyRz/Ug5G3PVLU4lFDdqPRPlYK24uoiOSctDUPYR0hAjrACvuCoWg+4Tn9Wms
        B1LkOuQYOD4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 911D02F118;
        Sat,  2 Nov 2019 00:53:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F31192F117;
        Sat,  2 Nov 2019 00:53:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     phillip.wood@dunelm.org.uk, Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: git branch --edit-description a custom file
References: <20191030183950.GA21277@generichostname>
        <20191030202835.GB29013@sigill.intra.peff.net>
        <20191030224328.GB44961@generichostname>
        <20191031061832.GA20830@sigill.intra.peff.net>
        <nycvar.QRO.7.76.6.1910311119080.46@tvgsbejvaqbjf.bet>
        <20191031181920.GB70819@generichostname>
        <4ef79cfb-b970-2b2b-131d-3f47e6b0e308@gmail.com>
        <20191031200739.GA19313@sigill.intra.peff.net>
Date:   Sat, 02 Nov 2019 13:53:28 +0900
In-Reply-To: <20191031200739.GA19313@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 31 Oct 2019 16:07:39 -0400")
Message-ID: <xmqqk18i516f.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B6489E0C-FD2C-11E9-8B66-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> There was some work by Johan Herland around the v1.8 time-frame, but it
> stalled:
>
>   https://public-inbox.org/git/AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com/
>
> And here's some later discussion:
>
>   https://public-inbox.org/git/CA+P7+xpj+8DZ=K0pna299Mu3nsQ4+JV_JUK=WFzzAFnJN+Bkbg@mail.gmail.com/
>
> So in short, I agree very much with the direction you're discussing, but
> I think there's some fundamental work that needs done first.

Yes, I think this comes up from time to time in different guise.  I
thik the latest iteration is in the thread:

https://public-inbox.org/git/CA+P7+xpdYMA8L-_Y+W5q7_zbj9RNcH1erY=dVbDG-EDOiHhTwA@mail.gmail.com/
