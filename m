Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 610072022A
	for <e@80x24.org>; Sat,  5 Nov 2016 04:43:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752237AbcKEEm7 (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 Nov 2016 00:42:59 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57815 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751332AbcKEEm6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Nov 2016 00:42:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 697BB4DEAE;
        Sat,  5 Nov 2016 00:42:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=i7UN85Uv4XIaa3nr6zhHRPfQqlw=; b=mzYO4G
        3MqL81e2T0diiQhkUyT250GsHwa+bcw4+eg91QZmlRruhSuoe1x/i1+j7PmpCKos
        7a11250uY3TmSa+5NxQfksYwoeiJcCRUFfDk27f4/4j4w4Eb8QwuI1xIJ2j+ybzB
        R1maA8RZspb85+nHEcREqqLnkoiG0HticFnuI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pujAZ0oTTgtEZN06C7tpT6RsvGMXlHhq
        7aP/6yCwySHaFoZ+ThE2w7hDCwKbtmOBtH1NaiSamrYorq/oDjrhpzBkGIRhYQiO
        AlaP8QRR1qEBUj7ymFhFnLTAxrh40sVeIrrHguz4mfFX7A08t28PngvNmqoAfOIt
        whc9ihCud9A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 60B054DEAB;
        Sat,  5 Nov 2016 00:42:57 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CD3D04DEA9;
        Sat,  5 Nov 2016 00:42:56 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Josh Triplett <josh@joshtriplett.org>, git <git@vger.kernel.org>,
        "Shawn O. Pierce" <spearce@spearce.org>, Jeff King <peff@peff.net>
Subject: Re: Regarding "git log" on "git series" metadata
References: <xmqqa8dfdt6y.fsf@gitster.mtv.corp.google.com>
        <CAP8UFD2+A0MUKazAfSwCvv61TJRPuoOzH5EkqcrBOUi4TcuoDw@mail.gmail.com>
Date:   Fri, 04 Nov 2016 21:42:55 -0700
In-Reply-To: <CAP8UFD2+A0MUKazAfSwCvv61TJRPuoOzH5EkqcrBOUi4TcuoDw@mail.gmail.com>
        (Christian Couder's message of "Fri, 4 Nov 2016 21:47:41 +0100")
Message-ID: <xmqq1syqedv4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 526FB7A2-A312-11E6-96B3-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> Couldn't a RefTree be used to store refs that point to the base
> commit,

I think it is the other way around.  With the new "gitref" thing
that is a pointer to an in-repository commit, RefTree can be
naturally implemented.
