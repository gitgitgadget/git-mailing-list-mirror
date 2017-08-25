Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E838208DB
	for <e@80x24.org>; Fri, 25 Aug 2017 17:14:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756288AbdHYROQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Aug 2017 13:14:16 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65317 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755630AbdHYROP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Aug 2017 13:14:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2056C9F346;
        Fri, 25 Aug 2017 13:14:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FM8CxxJM+0h/IufGwYqfXXNiYXE=; b=EGh+Ew
        TrFp1xgtz0q4kl589iW8MmJkHKLp+1Ncggzv0uLct5ORDF02ift1S2s7grxrwcak
        qHq7joX1fqEervSzBfCFA7U8Q90VUZpGpPFE0gjjguQPJEQ+rHMpfNB+0rkI4qP8
        xkQvILbkaK3haMFAgJyS44KzI5aj3B1iQ0o30=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nTIKu7jjdz0IjgZ3u0DW/YxhsEhu5jXx
        bUIp2+MPM/oDOksc/GIhx7wxHKI40oznbPj3HuolQ57Bl+7C6mu5woBZ7a1QgNxf
        Xn5ZgAt3CzSL680/FkInD1QTxuNdanaV4MtmVXDArQxIOnwhQagdoAFv848NtUA+
        OsyFlydbY50=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 184E29F345;
        Fri, 25 Aug 2017 13:14:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 775D59F344;
        Fri, 25 Aug 2017 13:14:14 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [RFC 0/7] transitioning to protocol v2
References: <20170824225328.8174-1-bmwill@google.com>
        <xmqq7exsv3yu.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kZ3NDsAQ4zVrUN8Ab3=f5RT63G16a_gCPm3Poe47BCMvg@mail.gmail.com>
Date:   Fri, 25 Aug 2017 10:14:13 -0700
In-Reply-To: <CAGZ79kZ3NDsAQ4zVrUN8Ab3=f5RT63G16a_gCPm3Poe47BCMvg@mail.gmail.com>
        (Stefan Beller's message of "Fri, 25 Aug 2017 10:07:08 -0700")
Message-ID: <xmqqbmn3tvru.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D1CE384C-89B8-11E7-82DD-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> For now I would suggest we put a protocol v2 in place that is
> the current protocol + a version number coming through the
> poked hole at the beginning; the goal and review of this series
> ought to focus on getting the version handshake right...

Oh, we are in absolute agreement on that.  It would be nice if we
can have new tests to demonostrate three combinations working well
(i.e. use 'installed git' whose path is given externally on one end
of the connection, while the just-built binary sits on the other
end, in addition to making sure just-built binary successfully talks
with itself).

