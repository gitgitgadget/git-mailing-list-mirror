Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46DF7202A0
	for <e@80x24.org>; Fri, 27 Oct 2017 01:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751857AbdJ0BFS (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Oct 2017 21:05:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50876 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751719AbdJ0BFR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Oct 2017 21:05:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CDBFCADC04;
        Thu, 26 Oct 2017 21:05:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8Mbm0YRakZjfEQJc83WQf98BGAI=; b=UHo2HM
        aEuGOgxholThxK+39OdexgyrqGRB5rO1wcYP4IPzvKNFAoZeY75pr6bgpuN63KcU
        tRZiUrlBuwwk9v7lW2cH3z23Pq7vGM0JxWGuCWwrk+M/leDySBP8kvVsYVjvyhtj
        uvp9O+r74cvIf9BG17PUc9yPBUhqsUmPCChBk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kxaFzzBRdU1KH5eEVNoYFOhAX0ZmM16Q
        71ocDgKCoegEhDDxSFTUcr2Q8CX6rxtPuUUY/Q4BH1b3jmUDuGA2cRa2J/huamRh
        bP9hd0VgfwGmPhgEqH286vUi4TKKb9qpRfvSsDDXrwqYr9CxA5BDMkvpJJV//5jP
        3xttO+RhwdM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C4A71ADC03;
        Thu, 26 Oct 2017 21:05:16 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2613DADBFE;
        Thu, 26 Oct 2017 21:05:16 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ross Kabus <rkabus@aerotech.com>
Cc:     git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Torsten =?utf-8?Q?B?= =?utf-8?Q?=C3=B6gershausen?= 
        <tboegi@web.de>, Jeff King <peff@peff.net>
Subject: Re: Consequences of CRLF in index?
References: <D0A67AD8-2D63-4683-9F2A-20B0E8E65D4B@gmail.com>
        <eda48d5e-a52c-9a39-8e55-a6828efdb3ef@kdbg.org>
        <alpine.DEB.2.21.1.1710251415040.6482@virtualbox>
        <5e962f69-f9cb-bd7e-481f-050e6239813f@kdbg.org>
        <30ED36AB-FAB1-4635-94AF-FCEC6F02CE01@gmail.com>
        <7a4396e8-7b97-9ec9-d028-c5ad29042c86@kdbg.org>
        <20171026203046.fu3z5ngnw7hckfrn@aiede.mtv.corp.google.com>
        <f56a02d6-fbf9-188f-d19f-3d48708d9268@kdbg.org>
        <CAEVs+zbq_zcYjyoCPE=W3LuQxAtRz8G+qLXA31jUiw+b4A4kSg@mail.gmail.com>
Date:   Fri, 27 Oct 2017 10:05:15 +0900
In-Reply-To: <CAEVs+zbq_zcYjyoCPE=W3LuQxAtRz8G+qLXA31jUiw+b4A4kSg@mail.gmail.com>
        (Ross Kabus's message of "Thu, 26 Oct 2017 18:27:26 -0400")
Message-ID: <xmqqh8ule6yc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E4B8F886-BAB2-11E7-BE8B-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ross Kabus <rkabus@aerotech.com> writes:

> Is "* -text" in any way different than "-text" (without the * asterisk)? All
> of my .gitattributes files have "-text" (no * asterisk) and I haven't noticed
> any difference but could I be missing something subtle?
>
> ~Ross

A line in the .gitattibute file is of the form

	<pattern>	<attribute definition>...

i.e. a pattern to match paths, with a list of attribute definitions.
The asterisk they are showing in their description is the <pattern>
part, i.e. "apply the '-text' thing to paths that match '*'", which
is equivalent to saying "set text attribute to false for all paths".

