Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 196B91F731
	for <e@80x24.org>; Wed, 31 Jul 2019 06:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbfGaGEx (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 02:04:53 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55268 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725209AbfGaGEx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 02:04:53 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 283F01698F3;
        Wed, 31 Jul 2019 02:04:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; s=sasl; bh=M251tRUh3bit7
        +uakh2MAKCN870=; b=PolCPENh0qWm4rS0uyvUT83836GjjC18mFHQ9kcnVqP27
        WNjEODMzaGZ8p9+fdBeou4cY0cw421jwI+XsXBqwAVls0uJMw7QQDeUmDna+mKtM
        SY3LFD2m9DKGWXqzJPW8VC29D4v4s2fteed7M8epQvUO+qbcC8Vu6In5/Vh/Xc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; q=dns; s=sasl; b=sJHtFgX
        Ss3nnnDy7WZ9pCFGs7wk8IMhBCfCKxrZS5/cteGv4HNCBYpCOMCP9U7mDGTe4iF8
        9RInO9YWwGKnJXfMu3cnx0v7n9ef4fYER+hSlWQXBeyZBj+hp3dn0yhcoswWz8d7
        m9uZmfbvnYODQMkDLvHazi2yLasyid6HBzbo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1F30E1698F2;
        Wed, 31 Jul 2019 02:04:52 -0400 (EDT)
Received: from pobox.com (unknown [173.67.141.44])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 992BE1698F1;
        Wed, 31 Jul 2019 02:04:51 -0400 (EDT)
Date:   Wed, 31 Jul 2019 02:04:49 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        'Junio C Hamano' <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        git@vger.kernel.org, git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git v2.23.0-rc0 - Initial test failures on NonStop
Message-ID: <20190731060449.GE4545@pobox.com>
References: <049a01d546f9$70be7a30$523b6e90$@nexbridge.com>
 <20190730194938.GZ4545@pobox.com>
 <20190730200203.GA4882@sigill.intra.peff.net>
 <20190730205624.GR20404@szeder.dev>
 <20190731005933.GA9610@sigill.intra.peff.net>
 <20190731012336.GA13880@sigill.intra.peff.net>
 <20190731015917.GB4545@pobox.com>
 <20190731032735.GA14684@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190731032735.GA14684@sigill.intra.peff.net>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Pobox-Relay-ID: 1C2201D2-B359-11E9-8FF8-72EEE64BB12D-09356542!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Tue, Jul 30, 2019 at 09:59:17PM -0400, Todd Zullinger wrote:
>> At the risk of showing my complete lack of knowledge about
>> these tests, I was wondering if the order mattered for the
>> other tests in t0011 and t0016.
[...]
>> You've got a more comprehensive patch and a proper commit
>> message, so this is really just a matter of curiosity.
>=20
> I think the order does matter for those ones. E.g., the ones that run
> "get" want to make sure they're seeing the values in the same order in
> which they were requested.

Ahh, thanks for clarifying that (and saving me from sending
the version I had which would have incorrectly sorted all
the test_{hashmap,oidmap} output. :)

FWIW, I applied your patch for sorting hashmap iterations
(<20190731012336.GA13880@sigill.intra.peff.net>=B9) and ran it
through the Fedora build system.  All architectures passed,
as expected.

=B9 https://public-inbox.org/git/20190731012336.GA13880@sigill.intra.peff=
.net/

--=20
Todd
