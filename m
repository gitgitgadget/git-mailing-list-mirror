Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67E261F462
	for <e@80x24.org>; Wed,  5 Jun 2019 20:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbfFEUqM (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jun 2019 16:46:12 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58534 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfFEUqM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jun 2019 16:46:12 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3D70B6380A;
        Wed,  5 Jun 2019 16:46:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hOt+FOMAYJMAVBAVu9zrZthHz4A=; b=uaw4cD
        LvLGVrwEJfTcGT3SyfhWFiBgvYa0fMvwBgmkxGTNdUJjKYp/xS9Bex4F+CxsX5GL
        YIJWWXfaHnNUUT+ksskPAGQ0/Y6YbJjl3jc5sjASPJS1vRVJtRU5J55W0uLTcixc
        +i0BemvCSs5cBuOJNMzBSDIKsyzG2xpPpVWG8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BgHjAwttsbazmT+5IPnEgD1RTZLtPtJP
        tg2DhzIcuqt+ThFjOTT4bPkh4Ah9ljVd2ejsF5q2K8tCPTXV3duLPhRIx8plYmcw
        dPiPHg0XkPK4J/VhqmNhVfkJLjFCfyhz3GH9kBiJO8L5iGnfGIE26SQjxmBc4YCG
        SOQMCixjWwU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 26BA163808;
        Wed,  5 Jun 2019 16:46:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4960963803;
        Wed,  5 Jun 2019 16:46:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Mkrtchyan\, Tigran" <tigran.mkrtchyan@desy.de>
Cc:     git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3] tag: add tag.gpgSign config option to force all tags be GPG-signed
References: <139144069.10140489.1559664262817.JavaMail.zimbra@desy.de>
        <20190605155300.26506-1-tigran.mkrtchyan@desy.de>
        <xmqqv9xkroc5.fsf@gitster-ct.c.googlers.com>
        <1933659713.10490718.1559765529240.JavaMail.zimbra@desy.de>
Date:   Wed, 05 Jun 2019 13:46:05 -0700
In-Reply-To: <1933659713.10490718.1559765529240.JavaMail.zimbra@desy.de>
        (Tigran Mkrtchyan's message of "Wed, 5 Jun 2019 22:12:09 +0200
        (CEST)")
Message-ID: <xmqqblzbsquq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F15358F4-87D2-11E9-A2E5-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de> writes:

>> But more importantly, I think we should justify why this "not
>> allowed" makes sense as the design of the feature. A plausible
>> alternative design would simply follow the "last one wins" paradigm,
>> ...
> This is matter of convention.

Oh, if you put it that way, it is quite clear that we should redo
this part, as the rest of Git command line processing all pretty
much follow "last one wins".  I was mostly curious if there was any
strong reason why this combination has to be different.
