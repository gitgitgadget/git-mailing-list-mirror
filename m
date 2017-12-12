Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB7071F406
	for <e@80x24.org>; Tue, 12 Dec 2017 20:51:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752580AbdLLUvl (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Dec 2017 15:51:41 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52685 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752511AbdLLUvi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Dec 2017 15:51:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B59A3C8F4E;
        Tue, 12 Dec 2017 15:51:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jB6IrJRbunj3yHRCeQNIVcdNMgU=; b=ZhekTO
        A25rsAD9njAL6O0lH6QJ/tGuT/4dtKnrbOp/Ua7xVOwAOMfpQwuvQ277x3Czo0lE
        WZvsW3lCL4Qy6wjF/2Old12YSlQvH/67tMLDfIYmnGfCdYXPs3nL7nsKdaFSYht0
        oPcSG5IjXGdKLT3QY2YjoCPi6O3gaaHdspoTA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=leLVwQSCJ7pJv8ixtlCiaHE1ggiDlgmt
        a6/2t67gWOsVd5i0kWNTykmV/OFgsgsHnjsM9gWLMhch7x8rOwoqijuvaXBRJWOO
        auOkGOKQTzJR8mBKwx/8cIKUcg7ZnXpao0nr2RDjO5PS1ydLD5+E+dvDaq0WSWRa
        0QaI5l5pi0I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ABBD6C8F4D;
        Tue, 12 Dec 2017 15:51:37 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 10128C8F4B;
        Tue, 12 Dec 2017 15:51:37 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bo?= =?utf-8?Q?r?= 
        <szeder.dev@gmail.com>, Christian Couder <chriscool@tuxfamily.org>,
        Brandon Williams <bmwill@google.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 3/3] travis: run tests with GIT_TEST_SPLIT_INDEX
References: <20171210212202.28231-4-t.gummerer@gmail.com>
        <20171211210948.6867-1-szeder.dev@gmail.com>
        <20171211214255.GA24597@hank>
        <C5F93DFF-D3DF-4507-8546-941BFA768705@gmail.com>
        <xmqq609b3gi3.fsf@gitster.mtv.corp.google.com>
        <20171212201558.GB24597@hank>
Date:   Tue, 12 Dec 2017 12:51:35 -0800
In-Reply-To: <20171212201558.GB24597@hank> (Thomas Gummerer's message of "Tue,
        12 Dec 2017 20:15:58 +0000")
Message-ID: <xmqqvahbzn3c.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3EDA046E-DF7E-11E7-ACB5-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

>
> The breakages wen the split-index code fails tend to break things in
> much more obvious manners than a wrong message, usually git ends up
> dying if it gets broken.  Both of the bugs that were fixed here would
> have been caught with the change in my patch.
>
> But yeah I can see the argument that it doesn't give us a guarantee
> that it catches all things the test suite could catch.

I think you misunderstood me.  When split index is much easier to
break than poison tests, combining them together would hurt the test
coverage of poison tests.  If you value poison tests much more than
how well split index mode works, that is a worse outcome.

>> I wonder if it makes more sense to update ci/run-tests.sh so that
>> its final step is run twice with different settings, like so?
>
> I kind of wanted to avoid that, because it ends up running the test
> suite twice on travis for every test, which seems a bit overkill.  But
> I don't exactly how worried we are about cycles on travis (I don't
> check it very often personally, so I don't really know).  If we aren't
> worried about cycles what you have below would certainly make sense.

I think 64-bit gcc/clang builds tend to cost us about 10-20 minutes
each, and 32-bit linux builds about 10 minutes or so.  I wonder if
it makes sense to do the "run twice" for only one of 64-bit builds
(perhaps the clang one, as I suspect 32-bit linux one uses gcc) and
the 32-bit linux build, and nowhere else.
