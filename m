Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA9361F4DD
	for <e@80x24.org>; Wed,  6 Sep 2017 19:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752719AbdIFTve (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Sep 2017 15:51:34 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63677 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752306AbdIFTve (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Sep 2017 15:51:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A4D56A2FBA;
        Wed,  6 Sep 2017 15:51:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=2XK5T5xMpPzOz50cyzVTqIZs4sU=; b=yXckXezaHFROUG5SPa9T
        ADKUuYzbCRrt30JdvJTghyVa7M3+MkwSbZSSkQwT5/snBsnh/jizXg6SpV0CpoVV
        iFa+pU1Mh0ToNMTuYkLJqRNJbC8arvVDIKsd+JbSkfFCVABmPO/OOzsbvZChhuCz
        mlbGi0BzCKpqDpJRuD2XJv4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=lCnNuaM9/eOBH4RcBEff4EWpRCttlsBoLSJbYN6OL5brGq
        BP6Y1rRqMH/9/pn76S3vjNHrJ4q+cnlxqYDoschJhAjAVIJESNhZuIkxM9yECseN
        gUG5OrbXyFChNaxKzhq13KH9CbhP3xhNF0AZO+T0yfL08Y0S5gv4AmSDgMTlI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9CDA0A2FB9;
        Wed,  6 Sep 2017 15:51:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F2F6EA2FB8;
        Wed,  6 Sep 2017 15:51:32 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 01/39] pack: make packed_git_mru global a value instead of a pointer
References: <20170830064634.GA153983@aiede.mtv.corp.google.com>
        <20170830064827.GB153983@aiede.mtv.corp.google.com>
        <20170830194448.u653vadhgzmkru3y@sigill.intra.peff.net>
Date:   Thu, 07 Sep 2017 04:51:31 +0900
Message-ID: <xmqqfubz61x8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C88D193C-933C-11E7-8B5A-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> As an aside, the mru code could probably be simplified a bit by reusing
> the list implementation from list.h (both were added around the same
> time, and it wasn't worth creating a dependency then, but I think list.h
> is useful and here to stay at this point).
>
> It's definitely not critical to put that into this already-large series,
> though.  Maybe we can use Junio's #leftoverbits tag. :)

I had the same reaction while reading it; perhaps I should read the
responses from trusted reviewers first before reading the patches
myself ;-)

Thanks.
