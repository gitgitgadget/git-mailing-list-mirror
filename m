Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8389E202A5
	for <e@80x24.org>; Mon,  2 Oct 2017 08:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750890AbdJBIIE (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 04:08:04 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55475 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750763AbdJBIID (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 04:08:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 34E9E965BB;
        Mon,  2 Oct 2017 04:08:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NoInAV105EsnLAFc/NaD5OqKCoU=; b=g9VGgk
        UCZSgzJIGnW9VmL+mC4lm/gg7IKO95WAJugiMVagLDaMRC9Rkxa0DE24voME7se+
        8hgDWIP55Sb6N6nQnAnoj3HHhsEO0Fp9YighIvgGg/6nYz9qOTskQGFpqtEYQRJJ
        v+jVGkAlWsLfGjXn/BCbVTrX8yizcPb7m8sxM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XYM0B1eZz8aDk+BVLJ2olscCLnL58FlW
        do+AYdt5HfUMBgRL0g2oi0VGceG8wt9OpBaa4JtLq6eHnSxHE8nh0VN3TDSiEKpC
        Teg4ENB4weoPhj7S/PPEApyxnBTkBEiyUKtbE89Ezms2mxRWfhYJNGKpwiGqsWWB
        qOeT8kbgHwo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 93D30965BA;
        Mon,  2 Oct 2017 04:08:01 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3540A965B9;
        Mon,  2 Oct 2017 04:08:00 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v6 0/7] Support %(trailers) arguments in for-each-ref(1)
References: <20170930062238.87077-1-me@ttaylorr.com>
        <20170930184151.GB43975@D-10-157-251-166.dhcp4.washington.edu>
        <20171001000647.GA20767@D-10-157-251-166.dhcp4.washington.edu>
        <20171001161725.GA66172@D-10-157-251-166.dhcp4.washington.edu>
        <20171002003116.GA69902@D-10-157-251-166.dhcp4.washington.edu>
        <20171002052326.GA10729@D-10-157-251-166.dhcp4.washington.edu>
Date:   Mon, 02 Oct 2017 17:07:58 +0900
In-Reply-To: <20171002052326.GA10729@D-10-157-251-166.dhcp4.washington.edu>
        (Taylor Blau's message of "Sun, 1 Oct 2017 22:23:26 -0700")
Message-ID: <xmqq7eweotup.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CE843D0A-A748-11E7-B40D-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Attached is the sixth revision of my patch-set "Support %(trailers)
> arguments in for-each-ref(1)".
>
> In includes the following changes since v5:
>
>   * Added an additional patch to change t4205 to harden `unfold()`
>     against multi-line trailer folding.
>
>   * Added a missing parameter call in ref-filter.c to
>     `trailers_atom_parser` through `contents_atom_parser`.
>
> I believe that this version of the series should be ready for queueing.
>
> I am going to address Peff's follow-up for teaching
> `parse_ref_atom_filter` to accept "empty" argument lists as
> `%(refname:)` in a follow-up series later this evening.
>
> Thanks again :-).

Thanks.  t6300 seems to show that %(contents:trailers:unfold) does
not quite work, among other things.

  https://travis-ci.org/git/git/jobs/282126607#L3658

I didn't have a chance to look into it myself.
