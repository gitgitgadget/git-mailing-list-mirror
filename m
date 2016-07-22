Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD4E220195
	for <e@80x24.org>; Fri, 22 Jul 2016 15:52:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754556AbcGVPwJ (ORCPT <rfc822;e@80x24.org>);
	Fri, 22 Jul 2016 11:52:09 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51781 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752723AbcGVPwG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2016 11:52:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8DC962BF38;
	Fri, 22 Jul 2016 11:52:04 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Hvcbc2sj/NpqmoyBplqPUNilBqI=; b=CnYIdA
	E6satBMVxk5a4SPH6148BO/Jx4awE6ujjABtfxyYKAQ+8/6rZCDTYJs1bSNErFz1
	zg7Y/tIVv+lbF6K68av7uZZ5vkXym6e6BU1GFC8/1v13mlbshgKeZNVFb8kfkxyK
	TKplLnYcn8toFrlKtWJMGJujk+/IAlJskdLvw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ik3v797nUH48Y6BxtpWpeZSGgzae/nsK
	PWNkrytS2hr0R+zEB6CONtXXcFg/nQkvHAF72a31LWBw0h1YhdKmwqTt4Y+v8LbI
	KCRYLdGSbHMmyE710Fj+6UA96Dl92ENxoYifya1YRE0tD1B0j8M+y57W06qL23Sx
	Nb/5BYIjm8g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 866662BF37;
	Fri, 22 Jul 2016 11:52:04 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 10B572BF35;
	Fri, 22 Jul 2016 11:52:03 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Pranit Bauva <pranit.bauva@gmail.com>
Cc:	Git List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Jul 2016, #06; Tue, 19)
References: <xmqqk2ghdysg.fsf@gitster.mtv.corp.google.com>
	<CAFZEwPM7bBV5PxOqA9Zvrq-4M1F83NVXORRKje_fqG74ofUWLQ@mail.gmail.com>
Date:	Fri, 22 Jul 2016 08:52:01 -0700
In-Reply-To: <CAFZEwPM7bBV5PxOqA9Zvrq-4M1F83NVXORRKje_fqG74ofUWLQ@mail.gmail.com>
	(Pranit Bauva's message of "Wed, 20 Jul 2016 21:28:03 +0530")
Message-ID: <xmqqzip9brha.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3C38E27E-5024-11E6-8D14-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Pranit Bauva <pranit.bauva@gmail.com> writes:

> The current branch contains 30-40 % of the work. I am going to send 3
> more functions check_and_set_terms(), bisect_next_check() and
> bisect_terms() positively by today. After that the work will be around
> 50-60% complete. After that bisect_start() (I have ported this but it
> has a bug right now) then bisect_next(), bisect_replay(),
> bisect_state(), and a few small more.

Thanks for an interim report of the current state within the overall
plan.  IIRC, bisect_next (which gets called from bisect_auto_next)
and the functions it calls comprise the bulk of the logic of the
program, so when you are ready to tackle bisect_next, which would
mean that you have done with all the functions it calls, you would
roughly be halfway there.  Nice.

