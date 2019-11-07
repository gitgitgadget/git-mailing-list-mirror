Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FA0A1F454
	for <e@80x24.org>; Thu,  7 Nov 2019 05:21:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbfKGFVc (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 00:21:32 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59679 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfKGFVc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 00:21:32 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3AFD28CB5B;
        Thu,  7 Nov 2019 00:21:30 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4lTiTfgcJMNUvPDGdYcxprd7KGo=; b=VCTGwc
        YjX0EZ4Vb2pBiOEJuWpCGavK9ihOtfvd7YMaI32gA0J3cyFDlyD87vZB0P4sC66L
        UfINwixVVpeJ5rcbnyf4rhqm6Dy5RgQLIKRnbnG2PAmAqRL0b1GO+2DNqLvnsinu
        N/tzsv3O7a7YgaKmDzsw29mBjTTrtdRnr7s7o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=oZLH3rAc39YtBwx/QSCfqc6gkTyt6Zw6
        Y0ZydOD58izAT7nXNyqjYByWZg8jJ5BTo6yEoE3Dak+UGYblsZrvnCXMM8QAytDI
        PbbvrcmhMk/0Nn38CXRAyL4YYVyuZOGsYTtrFmKFfdfbC8K2YUJD1yXPEHReJPoF
        YCY1eNDhfHo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1F0038CB5A;
        Thu,  7 Nov 2019 00:21:30 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4F7E88CB59;
        Thu,  7 Nov 2019 00:21:27 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "erik chen via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 0/1] fetch: add trace2 instrumentation
References: <pull.451.v2.git.1573066300.gitgitgadget@gmail.com>
        <pull.451.v3.git.1573069152.gitgitgadget@gmail.com>
Date:   Thu, 07 Nov 2019 14:21:25 +0900
In-Reply-To: <pull.451.v3.git.1573069152.gitgitgadget@gmail.com> (erik chen
        via GitGitGadget's message of "Wed, 06 Nov 2019 19:39:11 +0000")
Message-ID: <xmqqd0e4s1m2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 72B5FC66-011E-11EA-95D1-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"erik chen via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Add trace2 regions to fetch-pack.c to better track time spent in the various
> phases of a fetch:
>
> * matching common remote and local refs
> * marking local refs as complete (part of the matching process)
>
> Both of these stages can be slow for repositories with many refs.
>
> Signed-off-by: Erik Chen erikchen@chromium.org [erikchen@chromium.org]

If the above is verbatim copy of what you wrote in 1/1, that is very
much unappreciated X-<.  A cover letter for a topic serves primarily
just one purpose:

   It is a good place to present a birds-eye-view of a multi-patch
   topic; a high level description of the problem (e.g. how the
   issue manifests to the end users), an explanation of division of
   the problem into subproblems you made (if applicable), and
   interesting highlights of the solution would all be good things
   to have in there.

And as a topic goes through iterations, it gives you a good place to
summarize what changed since the previously reviewed iterations.  It
could be just a single liner "addressed all the review comments for
the previous iteration".  A well-written multi-patch topic also uses
the same after-three-dash technique used for a single-patch topic
(see below) to summarize what changed since the corresponding patch
in the series in the previous iteration (or just says "no changes
since the previous round"---that helps the reviewers a lot).
   
For a single-patch topic, there is no place for "here is an overall
birds-eyes-view picture because the changes described in the
proposed log message of individual patches are so big and complex".
A single-patch topic has one patch, that solves one problem and only
that problem well, so it should not need such a summary.  

When you want to summarize the changes since the previous iteration,
you would write it between the three-dash-line (which appears after
your sign-off) and the diffstat.

Thanks.
