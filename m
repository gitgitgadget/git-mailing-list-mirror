Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5380F20899
	for <e@80x24.org>; Thu, 17 Aug 2017 22:30:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753342AbdHQWaG (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Aug 2017 18:30:06 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51912 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753271AbdHQWaF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2017 18:30:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 33A26AFB16;
        Thu, 17 Aug 2017 18:29:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4dDVDQA+tjugFP+aSQTOIWwBV0A=; b=g8rBXz
        57pP7mAFOuSrRpwBPw53lSIx6+JZsQMnuEuhncZBVt2NYtctIhOrybjYhd3xMa0d
        SrHlidoDfk41ojK7ZfxWaBAekTOxSvTpjoUA3g+jcwUmHMX1CVGPVi9CTnGMOjx0
        PgDgZzpA2N9KmaDFMSm9+0ZI92rY2yl8jCVzo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QJC4LVTo3qv8DsjECXA7Ov16TDDAlx91
        7bf3S+JBssnqca3TlsE/boEPPCVm+niU4ZiTQPcBFTuW/XkltsPt9GSqZJuqWWNo
        XowbQkLwKdwKAeEKdOiRuMOc4pyma1aGuRve3cKhsWQ79DdqFh7ndVWQ/czyJHa7
        +58by6wQ6lg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2C1E6AFB15;
        Thu, 17 Aug 2017 18:29:57 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7CD87AFB13;
        Thu, 17 Aug 2017 18:29:56 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     tboegi@web.de
Cc:     git@vger.kernel.org, asottile@umich.edu
Subject: Re: [PATCH v3 2/2] File commited with CRLF should roundtrip diff and apply
References: <xmqqa832vymw.fsf@gitster.mtv.corp.google.com>
        <20170817214308.10727-1-tboegi@web.de>
Date:   Thu, 17 Aug 2017 15:29:55 -0700
In-Reply-To: <20170817214308.10727-1-tboegi@web.de> (tboegi@web.de's message
        of "Thu, 17 Aug 2017 23:43:08 +0200")
Message-ID: <xmqqlgmheskc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 98D41516-839B-11E7-999A-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

tboegi@web.de writes:

> Changes since v2:
> - Manually integrated all code changes from Junio
>   (Thanks, I hope that I didn't miss something)

I suspect that "apply -R makes '+' preimage" change is not here.

> - Having examples of "git diff" in the commit message confuses "git apply",
>   so that all examples for git diff have a '*' at the beginnig of the line
>   (V2 used '$' which is typically an example for a shell script)

Just FYI we tend to just indent them further, just like any
displayed material in the proposed log message.

> - The official version to apply the CRLF-rules without having an index is
>   SAFE_CRLF_RENORMALIZE, that is already working today.

Ah, good find.  I forgot about that thing you added some time ago.

