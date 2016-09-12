Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7844B207DF
	for <e@80x24.org>; Mon, 12 Sep 2016 20:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754666AbcILUYd (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 16:24:33 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64284 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752603AbcILUYc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 16:24:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2F65C3CE00;
        Mon, 12 Sep 2016 16:24:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nJgDq2uFHyTcz9VlUOmKFysQhho=; b=HPNc2A
        UfGLscQjKNM17lQZDJtUec3q4dxT7/Wg7VzHX2RmEbwtgnK34w+tMUW1UKbsytT6
        pePr38Dy0QXY8vtAR9nW7Nulj7EAfFtMqGVHPqnvwoVa++2F4KFPS3hS9Jbn/Tcw
        F8jNQcP9CROyLTNgv0wKfaDIxjgrBocs88Zbc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fj+6PnQsIRsodyR+c9S1S6QbHniyQjMd
        5P0HxgJUK9pAU01XCD3Bs8qAlw2smWHaoFzTZJFi2mVQ4dKdK2O+WuhOSqVYacle
        IyZvnWoTmVv52Py3uJ1bSLVrZmiYt2GeemxUxnkp+SLboY0cr1F4lijEqLHkyFmQ
        lGtac7MRS0k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 26E533CDFF;
        Mon, 12 Sep 2016 16:24:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 90BEB3CDFE;
        Mon, 12 Sep 2016 16:24:30 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Felt <aixtools@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: build issues on AIX - aka non-GNU environment, no gnu grep, no gcc
References: <CANvxniXkbAKgjm+NZ0cyyCToEYp23Kd8s4yxSqUOsAUAHJSA7g@mail.gmail.com>
Date:   Mon, 12 Sep 2016 13:24:28 -0700
In-Reply-To: <CANvxniXkbAKgjm+NZ0cyyCToEYp23Kd8s4yxSqUOsAUAHJSA7g@mail.gmail.com>
        (Michael Felt's message of "Mon, 12 Sep 2016 21:28:21 +0200")
Message-ID: <xmqqy42wzx1f.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E8FE316E-7926-11E6-A995-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Felt <aixtools@gmail.com> writes:

> I had a couple of issues when packaging git for AIX
> a) option -Wall by default - works fine with gcc I am sure, but not so
> well when gcc is not your compiler

That is expected.  As you said, it is merely "by default" and there
are mechanisms like config.mak provided for people to override them.

> b) needs a special (GNU) grep argument (-a from memory). This I
> resolved by downloading and packaging GNU grep. However, I hope this
> has not introduced a new dependency.

Read the Makefile and find SANE_TEXT_GREP, perhaps?

Thanks for helping to spread Git to minority platforms.
