Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72BBF20133
	for <e@80x24.org>; Sat,  4 Mar 2017 00:18:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752064AbdCDASw (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 19:18:52 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65111 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751742AbdCDASv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 19:18:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1A73D689A9;
        Fri,  3 Mar 2017 19:03:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4X3SKD4uBd5TL8xF0DpfLJ/vRLc=; b=Qk2NqI
        hekwc2b97vwEvCLK+0npJgB5uySehoz6JcJBQkmwrfLjfQuKwgrrQezf03f37gAt
        RBxmlN2zf8iUxHAJd0hR2EzZZYcN8kgvz8teGWG3OAZZLJeope4NA44/K5zhn/QD
        NabTZtlQymTvW9rpUTpxJ5xO2PI/2zp1uvSaU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=I8OeZA4EFuaTOqWyymDh5+UFeZH078fo
        ZDgCWCgOAJ3Ch31ff5b/hJZkRwVBXu+PPluqtAeqs7iz+W/h/ceGgkuOLHdYn097
        FJZs1Da4yA2xjiKdrDAJBEeH9+HVsFKGBw0UnyCwepZkLb8WTgwtgeEuqnp5dcPr
        UCEnbtivujk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 133F4689A7;
        Fri,  3 Mar 2017 19:03:44 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 770D3689A6;
        Fri,  3 Mar 2017 19:03:43 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v1] Travis: also test on 32-bit Linux
References: <c76a133a57514a332828099d342c9763fd946bfa.1488309430.git.johannes.schindelin@gmx.de>
        <20170302105157.59791-1-larsxschneider@gmail.com>
        <alpine.DEB.2.20.1703021210170.3767@virtualbox>
        <CFA1C4B4-0FDA-424D-87A4-EEE1F9BB3712@gmail.com>
        <xmqqinnrd098.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1703030315580.3767@virtualbox>
        <xmqqh93a9p5r.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 03 Mar 2017 16:03:42 -0800
In-Reply-To: <xmqqh93a9p5r.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Fri, 03 Mar 2017 10:43:44 -0800")
Message-ID: <xmqq8tol7vs1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 07C7251E-006E-11E7-AD8F-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I see he did v2 which you Acked in a different thread.  Will replace
> what's been on 'pu' and running with Travis the past few days with
> it.  Let's wait for one or more Travis cycles and then merge it to
> 'next'.

https://travis-ci.org/git/git/jobs/207517043 is an output from 'pu'
with the v2 patch; it seems to have fell into a funny state.  The
output ends like so:

    No output has been received in the last 10m0s, this potentially
    indicates a stalled build or something wrong with the build itself.

I only recently started looking at Travis logs, so I cannot tell if
it is just a usual flake (e.g. some builds a few days ago seems to
have failed due to not being able to check out the tree being
tested, which I do not think is our fault) that we shouldn't worry
about, or if it is a sign of a real problem.

Unrelated to linux-32, the same build has hard failure with Apple
clang in t0021 with the rot13-filter.pl thing, by the way.

