Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24BDB1F859
	for <e@80x24.org>; Tue, 16 Aug 2016 18:03:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751729AbcHPSDZ (ORCPT <rfc822;e@80x24.org>);
	Tue, 16 Aug 2016 14:03:25 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63355 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750803AbcHPSDY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2016 14:03:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6728B341C6;
	Tue, 16 Aug 2016 14:03:23 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3FYA7Ue/CwEFYGJZGDg/ba7cDqs=; b=Fuhc+B
	yVRTRYpIxT/CX0BIDOg5/pAbY5VciTJ2yamMNs0jPynZPhYLt+dkaUnMDpSBxCU/
	2KwDbAzlB2saLYsReRDXdplN3IRgXzbQgdAksLCB9wqqU41QpqAesECL7Un9vHNs
	5aoH15Hjb46DpSVP3Chq1/YIFRjxlC9EIUSSk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qH6rfqJ/Y1jBBivd8H7Hk1zaPSWmVmJX
	bqlpWfbukP543t7qAjatsyTDzioRar8UBJtBB99MLOGrmgQBiRWSDbThudO3BQhL
	UOn0Px9U3um5OmOTk+vcM1n1qZ6+UbjqGtaxrWoZ2LE+v8wIeWKtqpWuSLP98MkO
	0o1CytF2YE8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5E3E8341C5;
	Tue, 16 Aug 2016 14:03:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D78F0341C4;
	Tue, 16 Aug 2016 14:03:22 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jacob Keller <jacob.e.keller@intel.com>
Cc:	git@vger.kernel.org, Stefan Beller <stefanbeller@gmail.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v6 1/3] diff.c: remove output_prefix_length field
References: <20160815230702.30817-1-jacob.e.keller@intel.com>
	<20160815230702.30817-2-jacob.e.keller@intel.com>
Date:	Tue, 16 Aug 2016 11:03:20 -0700
In-Reply-To: <20160815230702.30817-2-jacob.e.keller@intel.com> (Jacob Keller's
	message of "Mon, 15 Aug 2016 16:07:00 -0700")
Message-ID: <xmqqpop8d21j.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B8B08AA8-63DB-11E6-8975-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jacob Keller <jacob.e.keller@intel.com> writes:

> From: Junio C Hamano <gitster@pobox.com>

Thanks.  I had quite a many typoes in this one.

> "diff/log --stat" has a logic that determines the display columns
> available for the diffstat part of the output and apportions it for
> pathnames and diffstat graph automatically.
>
> 5e71a84a (Add output_prefix_length to diff_options, 2012-04-16)
> added the output_prefix_length field to diff_options structure to
> allow this logic subtract the display columns used for display the

s/^.*$/allow this logic to subtract the display columns used for the/

> history graph part from the total "terminal width"; this matters
> when the "git log --graph -p" option is in use.
>
> The field be set to the number of display columns needed to show the

s/field be/field must be/

> output from the output_prefix() callback.  Any new output_prefix()
> callback must also update the field accordingly, which is error

"output from the output_prefix() callback, which is error"

> prone.

No need to resend; I had it with the above fix in 'pu' for a few
days already ;-)
