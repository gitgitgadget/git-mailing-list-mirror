Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E82F81F859
	for <e@80x24.org>; Tue, 16 Aug 2016 20:48:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753298AbcHPUsv (ORCPT <rfc822;e@80x24.org>);
	Tue, 16 Aug 2016 16:48:51 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62535 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753223AbcHPUsu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2016 16:48:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 47F4636853;
	Tue, 16 Aug 2016 16:48:49 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+9iVCs7Ntw5s9NfTyhqh9R6jw+s=; b=Kk1DNj
	yofRRbwBM0KojFyfSh8N1ZssCLV6mWNuoFi4lVZup1+aBW3/KlCaWKtUZFYJoIJL
	4GIIw7KVUNqCqFvqXRcssLG7m2sUyPr/3bzML+P3CvcvFlqJ04Nsfl9HLeNWZzM4
	RkoAf49299AQry4yu3do1MHa5DkIXSgeNPdio=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pGuFZVSFZrgzPcuSIYU50pKD/oFfn6ju
	iqKajWt7o552/kIqAgrgXrBUsYjDdol5TMs8GNBE9b2M4eVAftPNhQfocvZYkXES
	TrLEUSooESLJ9xzPosdj+At/M7qumVkqk+AsDEXhfgebhNAXVqXn1e6wzsDI9R71
	Iua9oUZUVJc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 401D036852;
	Tue, 16 Aug 2016 16:48:49 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B940636850;
	Tue, 16 Aug 2016 16:48:48 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Lars Schneider <larsxschneider@gmail.com>
Cc:	Brian Henderson <henderson.bj@gmail.com>, git@vger.kernel.org,
	peff@peff.net
Subject: Re: [PATCH 1/3] diff-highlight: add some tests.
References: <20160730151149.15980-1-henderson.bj@gmail.com>
	<20160730151149.15980-2-henderson.bj@gmail.com>
	<A2BCF055-D3FD-4EFC-88FF-A3916BCF8FDF@gmail.com>
Date:	Tue, 16 Aug 2016 13:48:46 -0700
In-Reply-To: <A2BCF055-D3FD-4EFC-88FF-A3916BCF8FDF@gmail.com> (Lars
	Schneider's message of "Mon, 15 Aug 2016 18:40:06 +0200")
Message-ID: <xmqqziocbftd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D4F8BC3C-63F2-11E6-8393-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

>> On 30 Jul 2016, at 17:11, Brian Henderson <henderson.bj@gmail.com> wrote:
>> 
>> ---
>> contrib/diff-highlight/Makefile                  |  5 ++
>> contrib/diff-highlight/t/Makefile                | 19 +++++++
>> contrib/diff-highlight/t/t9400-diff-highlight.sh | 63 ++++++++++++++++++++++
>> contrib/diff-highlight/t/test-diff-highlight.sh  | 69 ++++++++++++++++++++++++
>> 4 files changed, 156 insertions(+)
>> create mode 100644 contrib/diff-highlight/Makefile
>> create mode 100644 contrib/diff-highlight/t/Makefile
>> create mode 100644 contrib/diff-highlight/t/t9400-diff-highlight.sh
>> create mode 100644 contrib/diff-highlight/t/test-diff-highlight.sh
>> 
>> diff --git a/contrib/diff-highlight/Makefile b/contrib/diff-highlight/Makefile
>
> Would it make sense to add the contrib tests to the Travis-CI build, too?
> https://travis-ci.org/git/git/branches

The more the merrier ;-)?  I do not think of a downside, especially
if you are adding it as a separate thing that comes after the main
test, or for even better isolation, an entirely separate job.

By the way, how flaky are existing tests?  Are people actively
following breakage reports?
