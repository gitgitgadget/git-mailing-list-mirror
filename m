Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B90061F419
	for <e@80x24.org>; Fri, 15 Dec 2017 15:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932336AbdLOPpN (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Dec 2017 10:45:13 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:1343 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932275AbdLOPpN (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 15 Dec 2017 10:45:13 -0500
X-IronPort-AV: E=Sophos;i="5.45,405,1508796000"; 
   d="scan'208";a="305673477"
Received: from orange.lip.ens-lyon.fr ([140.77.14.54])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/AES128-GCM-SHA256; 15 Dec 2017 16:44:52 +0100
From:   Matthieu Moy <Matthieu.Moy@univ-lyon1.fr>
To:     PAYRE NATHAN p1508475 <nathan.payre@etu.univ-lyon1.fr>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        ALBERTIN TIMOTHEE p1514771 
        <timothee.albertin@etu.univ-lyon1.fr>,
        BENSOUSSAN--BOHM DANIEL p1507430 
        <daniel.bensoussan--bohm@etu.univ-lyon1.fr>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email: extract email-parsing code into a subroutine
In-Reply-To: <3cafddfe825a4fb4a554f02aa3c025a3@BPMBX2013-01.univ-lyon1.fr>
        (PAYRE NATHAN's message of "Fri, 15 Dec 2017 15:33:39 +0000")
References: <285414621.1144481.1513260333115.JavaMail.zimbra@inria.fr>
        <3cafddfe825a4fb4a554f02aa3c025a3@BPMBX2013-01.univ-lyon1.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
Date:   Fri, 15 Dec 2017 16:44:46 +0100
Message-ID: <q7h9lgi4m1w1.fsf@orange.lip.ens-lyon.fr>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PAYRE NATHAN p1508475 <nathan.payre@etu.univ-lyon1.fr> writes:

>>> +sub parse_header_line {
>>> +     my $lines = shift;
>>> +     my $parsed_line = shift;
>>> +     my $pattern = join "|", qw(To Cc Bcc);
>>
>> Nit: you may want to rename it to something more explicit, like
>> $addr_headers_pat.
>
> I find "$addr_headers_pat" too long that's why I've choose rename it
> into "$addr_pat", in addition to that, because the variable is in the
> subroutine "parse_header_line" it does not require to include
> "headers" in the variable name.

I suggested this name because $addr_pat seems to imply that this matches
an address, while it matches the _name of headers_ containing address.
But that's not terribly important, the meaning is clear by the context
anyway.

All my previous remarks have been taken into account. This is now

Reviewed-by: Matthieu Moy <Matthieu.Moy@univ-lyon1.fr>

Thanks,

-- 
Matthieu Moy
https://matthieu-moy.fr/
