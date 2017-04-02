Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD42320964
	for <e@80x24.org>; Sun,  2 Apr 2017 03:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750805AbdDBDiK (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Apr 2017 23:38:10 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63731 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750792AbdDBDiJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2017 23:38:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5A23A7011C;
        Sat,  1 Apr 2017 23:38:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JwMIdL6ZXCdTXtMNsSSasTGpWTU=; b=P1L/Yc
        SNL9jHC59VofmGQngvbGAuvSO8elXEY+r4mFCJYq0PsdpdKzl8UMsummOcxLUEJj
        VCCJTuLmHVCNDFYFElm4d+1rnh7blihaCMHGnFpK0IMzMmdooBPKkFFKqsdaDEvg
        BBZB0z83xL9vgHMsQo7fjOngtO1C1O80i6Ir4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=C74ECfBrJL36WZ2fkQvGZkOmUHng1CC3
        ez/nuCfcJqmG6P5llPsxidsWmFD9pbv/a3rBrZc0U4u++rfDsH77y0GnnAbPVS9Z
        v8cq+iZGsM3wyw5etEjY2Yi1GaOnut94ZtUoNE7aykZ+a3S3ejdLftabzXzFJMEz
        SYcDzqEo2uo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 526407011B;
        Sat,  1 Apr 2017 23:38:08 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9D94870118;
        Sat,  1 Apr 2017 23:38:07 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        David Turner <novalis@novalis.org>, git@vger.kernel.org
Subject: Re: [PATCH v2 00/20] Separate `ref_cache` into a separate module
References: <cover.1490966385.git.mhagger@alum.mit.edu>
        <xmqq1std1lmb.fsf@gitster.mtv.corp.google.com>
        <9b9a6cc2-a7d4-a7b8-0483-5aefdf926ca7@ramsayjones.plus.com>
Date:   Sat, 01 Apr 2017 20:38:06 -0700
In-Reply-To: <9b9a6cc2-a7d4-a7b8-0483-5aefdf926ca7@ramsayjones.plus.com>
        (Ramsay Jones's message of "Sat, 1 Apr 2017 22:26:59 +0100")
Message-ID: <xmqqh927tr6p.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C96FB5CA-1755-11E7-BAF0-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

>> I am getting the impression that the files-backend thing as well as
>> this topic are ready for 'next'.  Please stop me if I missed something
>> in these topics (especially the other one) that needs updating
>> before that happens.
>
> Hmm, are these branches 'tangled' with nd/prune-in-worktree?
> (I think they were at one point, but maybe not now?).

Michael's mh/separate-ref-cache builds directly on top of
nd/files-backend-git-dir topic.

nd/prune-in-worktree builds directly on top of
nd/worktree-kill-parse-ref, which in turn builds directly on top of
nd/files-backend-git-dir.

In that sense, Michael's series and Duy's later two series are
"tangled" (i.e. shares some common commits that are still not in
'master').  If nd/files-backend-git-dir that is shared among them is
ever rebased, all of them need to be rebased on top of it
consistently.

But if either of nd/prune-in-worktree and nd/worktree-kill-parse-ref
needs to be rerolled, that can be done independently from Michael's
series, as long as nd/files-backend-git-dir is solid and unchanging.


