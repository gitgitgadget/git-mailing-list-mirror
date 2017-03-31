Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57E611FAFB
	for <e@80x24.org>; Fri, 31 Mar 2017 16:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933214AbdCaQBV (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 12:01:21 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63846 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933149AbdCaQBU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2017 12:01:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 949527A7F6;
        Fri, 31 Mar 2017 12:01:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Rw8oIeOp2ne3dNKg+0EkkWMXTWE=; b=akHd+l
        /sMbjybpMkXpiAb7OB7B5hYhWH96Mh0f/bCLrML7S+KFYSqGDsdeEHIAhiLpkznz
        W9SwPgrPjfA5MQbGtO02XZgAN6k+bjL2An60a49XnzhQxv5NC/Xx1TJcA1kYGNij
        LQmMwdCO/patqjMlFOB62oXnCXXYZkyoGr2c8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=a2Exc703UwLnFu6L5vE9URLVDzzrHUkg
        wUN33uXKKYcsHlzzX52Iau+nEdaSfAh1bEFevnyN0lpMfYtUBdCu+oybIbh9weUa
        F/XpGu1u8maJihbG/0GxiZau1gHdQTHUxwK8ups/N3ilbGX4kcRJa8fW+4Z5sPQ8
        IoB80WoJ9is=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8CA347A7F5;
        Fri, 31 Mar 2017 12:01:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E66AD7A7F4;
        Fri, 31 Mar 2017 12:01:17 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        David Turner <novalis@novalis.org>, git@vger.kernel.org
Subject: Re: [PATCH v2 00/20] Separate `ref_cache` into a separate module
References: <cover.1490966385.git.mhagger@alum.mit.edu>
Date:   Fri, 31 Mar 2017 09:01:16 -0700
In-Reply-To: <cover.1490966385.git.mhagger@alum.mit.edu> (Michael Haggerty's
        message of "Fri, 31 Mar 2017 16:10:58 +0200")
Message-ID: <xmqq1std1lmb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 467EFB42-162B-11E7-8DBA-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> This version literally only contains a few commit message changes and
> one minor comment changes relative to v1. The code is identical. I
> wasn't sure whether it is even worth sending this patch series to the
> ML again; Junio, if you'd prefer I just send a link to a published
> branch in such cases, please let me know.

The review on the list is not about letting me pick it up, but is
about giving reviewing contributors a chance to comment.  I think
for a series this important ;-) it is good that you are giving it
multiple exposures so that people who were offline the last time can
have a chance to look at it, even if the update is minimum.

> This patch series is also available from my GitHub fork [2] as branch
> "separate-ref-cache". These patches depend on Duy's
> nd/files-backend-git-dir branch.

I am getting the impression that the files-backend thing as well as
this topic are ready for 'next'.  Please stop me if I missed something
in these topics (especially the other one) that needs updating
before that happens.

Thanks.
