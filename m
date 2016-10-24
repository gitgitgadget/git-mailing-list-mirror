Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F4881FBB0
	for <e@80x24.org>; Mon, 24 Oct 2016 17:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936498AbcJXR6O (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Oct 2016 13:58:14 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57477 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S935242AbcJXR6N (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2016 13:58:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E737348F09;
        Mon, 24 Oct 2016 13:58:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=QbC8gGLl0xWz
        sZ3Km2FYjg6EWAc=; b=aebbnTynd1DJYfIU3ZbUXmXDeHai1cBPABz7mIoMx7qk
        5kkrBBFPKJeJfKXyCGqVdHDoMiOeG4+Cw4H0b6OcGpg5msmDzx1X2CGUL5Z0RZhG
        UrNaAtIfBPTmuSfF7r/cRwUargNdnDxmnucYFrAFJTohi1Fd3YS0i0UnQ7c98+g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=TW8lZ8
        Sh8U1Q7f4nQUhOaFCXnBp8KcyuclsAoDtpJWeWOu15CqfiwVCHWrR7an8m1qf3Wx
        iQI+bWvXpmHnGcMXg9uQSJZe/RLgEqWrKLU7vcyPbSv+5GR0cCSz3QVFgVldEWQF
        o+SPuEMPtwmC3lxwdDz1iY9V+jUptyB+htSRc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DFA3848F08;
        Mon, 24 Oct 2016 13:58:11 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5B54E48F07;
        Mon, 24 Oct 2016 13:58:11 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/4] nd/ita-empty-commit update
References: <20160928114348.1470-1-pclouds@gmail.com>
        <20161024104222.31128-1-pclouds@gmail.com>
Date:   Mon, 24 Oct 2016 10:58:09 -0700
In-Reply-To: <20161024104222.31128-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Mon, 24 Oct 2016 17:42:18 +0700")
Message-ID: <xmqqeg357hou.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6D85494C-9A13-11E6-939C-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> The index_differs_from() also takes a flag to set/clear this new
> flag instead of relying on has_ita_entries like the old 2/3.

I think that probably is a good move.

> The name ita-invisible-in-index is not perfect but I could not think
> of any better. Another name could be diff-cached-ignores-ita, but
> that's just half of what it does. The other half is diff-files-includes=
-ita...

I can't either, and it is one of the reasons why I am reluctant.
Not being able to be named with a short-and-sweet name often is a
sign that the thing to be named is conceptually not well thought
out.

But as we need to give it some name to the flat to ease
experimenting, let's take that name as-is.
