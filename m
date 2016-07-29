Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D966F1F955
	for <e@80x24.org>; Fri, 29 Jul 2016 16:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753237AbcG2Q4P (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 12:56:15 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50249 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752339AbcG2Q4J (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2016 12:56:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E5AD232120;
	Fri, 29 Jul 2016 12:56:07 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iFj7weTmgzcaYubC3btsD3pajkk=; b=emhyb7
	/p5Ai43hTxbsApBjaE6dvqLhPGe1LzQb5aA25U+Q0BB4SKWn7W1kINLqjmpCOxtV
	s8eieloj0X6r3S5KJPeL5MDvlFc/dC59KMO4PoA+8eHFMf3tZOL2HbtSlbhMaMap
	DXQaIR95DfhWheWDChWG2b56+q7Sc284sry7M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AwKsRKAOHuCyGMabVNRJ8qqpav5yI0ax
	2q7qiN8l+v/de3D0Zb5qPUGxRc68zRa6gyxTtprUJnWt26LTr7vGWnGWoqlrUD8A
	EVxPm6xMggUUOtxsUK+xrFuYc4ltUQIoZUB5jfSxN/iePDnsLjuqGr5IH7Z3k/nW
	BHiYoN99sMc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DD1633211F;
	Fri, 29 Jul 2016 12:56:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5C0C63211E;
	Fri, 29 Jul 2016 12:56:07 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Josh Triplett <josh@joshtriplett.org>
Cc:	git@vger.kernel.org
Subject: Re: [RFC] git-format-patch: default to --from to avoid spoofed mails?
References: <20160728211149.GA371@x>
	<xmqq8twlqwan.fsf@gitster.mtv.corp.google.com>
	<20160729000507.GA3149@x>
Date:	Fri, 29 Jul 2016 09:56:05 -0700
In-Reply-To: <20160729000507.GA3149@x> (Josh Triplett's message of "Thu, 28
	Jul 2016 17:05:07 -0700")
Message-ID: <xmqqfuqspemy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 57E79518-55AD-11E6-8729-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Josh Triplett <josh@joshtriplett.org> writes:

> So, it seems exceedingly unlikely to me that this would result in
> unnecessary in-body "From:" headers.

Yup, Peff elsewhere on the thread gave the same conclusion, and
after reading the codepaths involved again, I agree.
