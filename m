Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B58D20958
	for <e@80x24.org>; Thu, 23 Mar 2017 20:11:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934035AbdCWULT (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 16:11:19 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63661 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932712AbdCWULS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 16:11:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6EA28680C3;
        Thu, 23 Mar 2017 16:10:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9cscHOza3hLHZG3LsPawj4gKZys=; b=ildP68
        uFPM9qlp4BGo9nYNpAhtIddcVLBY/dCr1RSFnGzYk4mm23ZcOzev65j+EAkQq/9B
        Za3aG+ArUOetdTZ9gI3EfBwloeMIYLSwdoSQzYL+IFHktYpyC+4dMn6SNRfYU+bG
        4uOQVZE0mxO+kxFBAeYv1Gn6a65UAxDv1VTkI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kyt48sy37QnHoP2LgGdijIbXZEOwQnsN
        q7LNKIZA80q95utGD+gvvS6026Qd/fD6LN62co6iaThS8SsJ2Saz6xA/mwgO4/1y
        3gsx36r4AFyoakx6qV4tEZI74lcN2UkTRzNGocts1jx9naByACisNsu0FcKm8j+b
        SeO30R7y1lM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 659C5680C2;
        Thu, 23 Mar 2017 16:10:39 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C230E680C0;
        Thu, 23 Mar 2017 16:10:38 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH v1] travis-ci: build and test Git on Windows
References: <20170322065612.18797-1-larsxschneider@gmail.com>
        <xmqqwpbhjej6.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1703231716320.3767@virtualbox>
        <20170323180134.geoyvq7qbm5vujo6@sigill.intra.peff.net>
        <xmqqbmsrdcz4.fsf@gitster.mtv.corp.google.com>
        <20170323191721.7r5vrixtnx3cngdc@sigill.intra.peff.net>
        <FE4A3F88-0B86-4069-B141-2DFB9C4E269E@gmail.com>
        <xmqqzigbbxjq.fsf@gitster.mtv.corp.google.com>
        <81C8DFC7-53DA-4533-8005-F6D8D643FDA2@gmail.com>
Date:   Thu, 23 Mar 2017 13:10:37 -0700
In-Reply-To: <81C8DFC7-53DA-4533-8005-F6D8D643FDA2@gmail.com> (Lars
        Schneider's message of "Thu, 23 Mar 2017 20:36:12 +0100")
Message-ID: <xmqqfui3bvpe.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C883EF30-1004-11E7-9F5B-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

>>> I agree it's not ideal. But I think it is an improvement to check
>>> pu/next/master/maint continuously :-)
>> 
>> I am not sure what you mean.  We are building each and every branch
>> updates already, and I do not see any improvement over what we are
>> doing now.  Care to elaborate?
>
> We are building each and every branch on TravisCI right now - but 
> only on Linux and OSX. With this change we also build it on
> Windows. That should help to spot Windows related issues more
> quickly I think.

We are losing the build for PR for folks who later submit patches as
the price for that.  "building each and every branch" stay constant
and the trade-off is between building four integration branches on
Windows and allowing contributors to easily check their work early.

If your "But I think it is an improvement" was followed by "to check
the four branches on Windows continuously", though, I wouldn't have
had to ask the question, as I tend to agree it is a better trade
off.

Thanks.


