Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A2701FD99
	for <e@80x24.org>; Wed, 17 Aug 2016 15:29:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752408AbcHQP3z (ORCPT <rfc822;e@80x24.org>);
	Wed, 17 Aug 2016 11:29:55 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58276 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750764AbcHQP3z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2016 11:29:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8C4D735A3B;
	Wed, 17 Aug 2016 11:29:53 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zGWWEVCLXoICXn6jquStZvlQ02Q=; b=RDPBgl
	flJVFuXVnl1MDItf2aU8oQZuhHYhjJ3gJQgXHgOYiwu+t4ReiLWoAj5CvlkxcRyO
	ClvZ8CICh2ZsSItCEy6eL02hWjuDHUmNifwufzs5cigOXfurhCeRb+k6Nb5xWLzP
	Dn8nj+CQRdbvWn98jp8d4icDTaCnap06+H3+I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qo+4mv66PgjlIDedZiiPDVu1GIAFWCwQ
	YeWv4FLiD3wHsmU8hzxA23xip7FgM0fOEjbpbLa1q9v6iBjxf5S/fLJ3VxH28FLA
	xWNSLLS95JLqDY0npqxjHjNUQNRjNQ+wpqgLAaEsQk8LsEZtWBQJE9AvVUxWQ+Ag
	VCpEcZNWyOU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8486435A3A;
	Wed, 17 Aug 2016 11:29:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 05ABE35A39;
	Wed, 17 Aug 2016 11:29:52 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	git-for-windows@googlegroups.com, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git for Windows 2.9.3
References: <alpine.DEB.2.20.1608131214070.4924@virtualbox>
	<xmqqshu8u0px.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1608171507530.4924@virtualbox>
Date:	Wed, 17 Aug 2016 08:29:51 -0700
In-Reply-To: <alpine.DEB.2.20.1608171507530.4924@virtualbox> (Johannes
	Schindelin's message of "Wed, 17 Aug 2016 15:54:20 +0200 (CEST)")
Message-ID: <xmqqeg5nbehc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 71991E8C-648F-11E6-9A23-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> And then your "git cat-file" patch can be upstreamed with the option
>> renamed to (or with an additional synonym) "--filters", which would make
>> things consistent.
>
> Right. I would like to ask for a `--smudge` synonym nevertheless, just
> because I already use this. On the other hand, it is early enough to tell
> everybody who knows about this feature to change their invocation (anybody
> who would know about `--smudge` would be in that 1% of users that have
> read the release notes, so most likely would read the next release notes,
> too).

It is OK if it were your private edition, but you end up hurting
your users if you need to redo the feature differently.

That's the price of your using open source and taking a short-cut.
Adding a "--smudge" synonym is spreading the same hurt to outside
your fork.  Let's see if we can avoid doing that.  Perhaps mark that
"--smudge" as experimental-and-subject-to-change and re-announce?

