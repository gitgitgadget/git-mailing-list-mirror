Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04CC0202A0
	for <e@80x24.org>; Tue, 31 Oct 2017 07:15:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752879AbdJaHPg (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Oct 2017 03:15:36 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56524 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751989AbdJaHPg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Oct 2017 03:15:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6D4EBAC4AB;
        Tue, 31 Oct 2017 03:15:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=clv2ZZ+3XEEj
        RZqIxo8vihmnLzI=; b=axrD8XJU+aliVYnTVJqsYPfr6hBERqiyM4UqsW23DFud
        2EmsS2/yNrMxiRzAXbGr2/dyOz5pugTUZCRFzx+9fOQjam8n9T2KwuemyIKAB34J
        PiIkovkhrQnwTj+HRwSBPjDkwUXKScPqlAwWw7XS4BvEQocRD12ArdKbB218X04=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=xaheGo
        K3pstWcTZNj1fB9GfY4w+vGnZ2xX975I2I8OZF7UdPw2T9eArLkd3f8t6mO9EoAZ
        xIosws6+gcFLQFt7wfMj14nw0nf9wtnnrtvZxgHitrA+ukT3mw5swCYAZNhk1x3Y
        Ea3EEnDgdttc6eLPF0r7D+Ff9zgfZQkxodHIA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 64833AC4AA;
        Tue, 31 Oct 2017 03:15:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D9A6BAC4A9;
        Tue, 31 Oct 2017 03:15:34 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@dwim.me>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] diff: --indent-heuristic is no longer experimental
References: <20171029151228.607834-1-cmn@dwim.me>
Date:   Tue, 31 Oct 2017 16:15:33 +0900
In-Reply-To: <20171029151228.607834-1-cmn@dwim.me> ("Carlos =?utf-8?Q?Mart?=
 =?utf-8?Q?=C3=ADn?= Nieto"'s
        message of "Sun, 29 Oct 2017 16:12:28 +0100")
Message-ID: <xmqq1sljzt2i.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 49BBC6E0-BE0B-11E7-B5B3-575F0C78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlos Mart=C3=ADn Nieto <cmn@dwim.me> writes:

> This heuristic has been the default since 2.14 so we should not confuse=
 our
> users by saying that it's experimental and off by default.
>
> Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@dwim.me>
> ---
>  Documentation/diff-heuristic-options.txt | 5 -----
>  Documentation/diff-options.txt           | 7 ++++++-
>  2 files changed, 6 insertions(+), 6 deletions(-)
>  delete mode 100644 Documentation/diff-heuristic-options.txt

I suspect that this patch is incomplete.  The build procedure barfs
and dies while making git-annotate.html, claiming that it wants to
find diff-heuristic-options.txt that no longer exists.

I'll have to redo today's integration cycle again without this
patch.  Sigh...


