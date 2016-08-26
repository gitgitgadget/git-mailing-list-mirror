Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4B9E1FD99
	for <e@80x24.org>; Fri, 26 Aug 2016 19:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752995AbcHZTpE (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Aug 2016 15:45:04 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54094 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751223AbcHZTpE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2016 15:45:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E968A38880;
        Fri, 26 Aug 2016 15:45:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=a8eGRR3HKeXzR72p5C4OhGXF0XA=; b=Qh8xsC
        AUBrpaBVrygblbXPnNZTeuaBULvhaiAQuOebcdTm1s9YoazrSxOlgnKoVvWpD08N
        IM4duUEmX2lwTD8sP16WBwo2vNwM4FeC2ohg3TNZlpwbKeTUDI37b1Svkj/o2f+N
        7X7Bj7Z6Xfn2TSyuUKQ8NT4xYD55MLmqQ+ssg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ar1fKtmAapm1QlzIyAnoxchoE+WU9GpV
        oXT1oeuwjJUdUT6OyijBU5eG0wkUPQaOlPJ7U11HYwgExPoFpUH7AU4Yn+vfCZWY
        g1glQPe/leXn7XR75SvB8Dgp9gO6VPPS/rmdFbwFH3Ql+KA+R31YVMTGdn42Oucq
        txIOJYt+TKM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E252A3887F;
        Fri, 26 Aug 2016 15:45:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6F8FD3887D;
        Fri, 26 Aug 2016 15:45:02 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Martin-Louis Bright <mlbright@gmail.com>
Subject: Re: [PATCH v6 07/13] pack-protocol: fix maximum pkt-line size
References: <20160825110752.31581-1-larsxschneider@gmail.com>
        <20160825110752.31581-8-larsxschneider@gmail.com>
        <CAGZ79kaJn-yf28+Ls2JyqSs6Jt-Oj2JW-sAXQn-Oe5xaxSyjMQ@mail.gmail.com>
        <6EC60D1B-3A92-4381-A87E-50417CF04A49@gmail.com>
Date:   Fri, 26 Aug 2016 12:44:59 -0700
In-Reply-To: <6EC60D1B-3A92-4381-A87E-50417CF04A49@gmail.com> (Lars
        Schneider's message of "Thu, 25 Aug 2016 21:35:08 +0200")
Message-ID: <xmqqshtrfh6s.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 947D2230-6BC5-11E6-85EC-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

>> And as this is a strict bug fix of Documentation that makes sense
>> outside this series,
>
> Agreed!

Amen.
