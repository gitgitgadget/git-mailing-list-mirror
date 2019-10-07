Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45D5A1F4BD
	for <e@80x24.org>; Mon,  7 Oct 2019 00:59:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfJGA7e (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Oct 2019 20:59:34 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57496 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbfJGA7e (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Oct 2019 20:59:34 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 417DA84FB1;
        Sun,  6 Oct 2019 20:59:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QLMU9qNSt5UIlir0nQ+E2SCRQ3s=; b=iqj5+1
        ArxxfZzjaNohGMlkEGd7Mcb2XFbMX9yWtocxfRbXvAinKElCR4jNWsKsvh6bdEDP
        6GmvoT2DEaHyb53jAXygDHXpnVL3YowwIKWN4wJmgisjLL/k4N+3DICmVoSh/Oco
        jrpM2eKntgTrNpF3a+Bip4WZ6mwknneaIfaJ4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=egKRMSMjRLZE17oFVs4ajc+5Wcb9UvZ5
        scTRTBsJkbQihoTX3KlDwTw+3xfKbAN6GSlhYyd6iDn4+TV0oCkhlKfG/3jaFTr9
        Tl4oHSgwAwIN182vRVCN+9flzYS8TSL7F6mkVrxsRDBfUrbk5sX1W3xsf6Iz53/4
        5qtd4pCfvsU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 39B3484FA5;
        Sun,  6 Oct 2019 20:59:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6BB1484FA0;
        Sun,  6 Oct 2019 20:59:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH v3 00/13] ci: include a Visual Studio build & test in our Azure Pipeline
References: <pull.288.v2.git.gitgitgadget@gmail.com>
        <pull.288.v3.git.gitgitgadget@gmail.com>
        <xmqqimp26808.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1910061157320.46@tvgsbejvaqbjf.bet>
Date:   Mon, 07 Oct 2019 09:59:27 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1910061157320.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Sun, 6 Oct 2019 12:45:26 +0200 (CEST)")
Message-ID: <xmqq5zl15q1c.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B750F612-E89D-11E9-86B7-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> 	Date:   Fri, 04 Oct 2019 08:09:25 -0700 (PDT)
> 	[...]
> 	X-Google-Original-Date: Fri, 04 Oct 2019 15:09:10 GMT
> 	[...]
>
> I am fairly certain that the latter is the actual `Date:` line sent to
> GMail, and GMail just decides that it will not respect it.

If the submitting program said "Fri, 04 Oct 2019 15:09:10 +0000
(GMT)" instead of "Fri, 04 Oct 2019 15:09:10 GMT", that would match
the format the MTA produced itself, I guess.  I am kind-of surprised
if the problem is the use of the obs-zone format (RFC 2822 page 31),
but anything is possible with GMail X-<.

How does send-email write that date header?  Matching that would be
probably the most appropriate, if possible, given that GGG was
written for send-email refugees, I guess ;-)

Here is what its format_2822_time sub does, so +0000 without any
textual zone name, it is.

	return sprintf("%s, %2d %s %d %02d:%02d:%02d %s%02d%02d",
		       qw(Sun Mon Tue Wed Thu Fri Sat)[$localtm[6]],
		       $localtm[3],
		       qw(Jan Feb Mar Apr May Jun
			  Jul Aug Sep Oct Nov Dec)[$localtm[4]],
		       $localtm[5]+1900,
		       $localtm[2],
		       $localtm[1],
		       $localtm[0],
		       ($offset >= 0) ? '+' : '-',
		       abs($offhour),
		       $offmin,
		       );


