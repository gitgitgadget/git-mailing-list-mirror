Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B85D81F859
	for <e@80x24.org>; Mon, 15 Aug 2016 17:06:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753093AbcHORGT (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 13:06:19 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62928 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752824AbcHORGS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 13:06:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E008733298;
	Mon, 15 Aug 2016 13:06:17 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FpWMlhjtkBO1+I3kp2JQBGY9oKk=; b=HG03OM
	CRIse7K7DFwd0tnM5FJSgur2DHd4ZPUEaH9TGC4KAjtjcYu/K+vpReuZs3b0MUMf
	vtH/MbisrORsamxfCpcrQRBYeKXIF6Ag2y4B5XQp9pjtwaV90cUeCpReHlSabLPV
	p+0SsM3S+skgD7UZHSWNQm+AHUATjQ2nwffdU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OZWR2uSr/PYx+THX0xV1KPdWznta4enr
	N6n7TCbVoBRb4+5QuanIySQHpiULY8QrCav4qEMR9rQc9zPloK9Aro0wsRKM4yjl
	9gpfzuprxvLKAP3JzfGi5uzZR5GMIO5n0R2nHxJi0bMd1S0+xKriNLqvBglzwYuE
	RgpEXvmVUQQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D814B33295;
	Mon, 15 Aug 2016 13:06:17 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 62E9533294;
	Mon, 15 Aug 2016 13:06:17 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Marc Branchaud <marcnarc@xiplink.com>
Cc:	Philip Oakley <philipoakley@iee.org>, GitList <git@vger.kernel.org>
Subject: Re: [PATCH v6 00/12] Update git revisions
References: <20160811215035.4108-1-philipoakley@iee.org>
	<20160812234522.7792-1-philipoakley@iee.org>
	<5338959f-985f-d1b3-7287-eccde559d2c3@xiplink.com>
Date:	Mon, 15 Aug 2016 10:06:15 -0700
In-Reply-To: <5338959f-985f-d1b3-7287-eccde559d2c3@xiplink.com> (Marc
	Branchaud's message of "Mon, 15 Aug 2016 10:30:20 -0400")
Message-ID: <xmqqzioegdx4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9487EBDE-630A-11E6-BF20-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Marc Branchaud <marcnarc@xiplink.com> writes:

> On 2016-08-12 07:45 PM, Philip Oakley wrote:
>> These are the quick fixes to Marc's comments to patches 5,6,11,
>> and a consequential change to 12.
>>
>> Only the changed patches are included.
>
> Looks good to me -- no further comments!
>
> However, I still don't understand why git says 11/12 has "indent with
> spaces" problems.

Probably that is because Documentation/.gitattributes has

	*.txt whitespace

to tell Git to notice all types of potential whitespace errors known
to it.  The checking of indent-with-tab is deliberate here, because
we rely on the fact that asciidoc treats HT as "fill with necessary
spaces to next multiple of 8" even when it renders a fixed-column
drawing.
