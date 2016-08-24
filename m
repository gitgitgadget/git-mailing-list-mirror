Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75F2A1FD99
	for <e@80x24.org>; Wed, 24 Aug 2016 05:39:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751000AbcHXFjB (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 01:39:01 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56036 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750969AbcHXFjA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 01:39:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3D22030736;
        Wed, 24 Aug 2016 01:37:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/v8Xwy4/LchJMNX0uID7H3Ly2os=; b=aY5cor
        IczZlM72A3m/+GdMxVF3Qa7MfPKl5XwPJjORB8wHh3K/Cti5/v+GPy+9pniugKtv
        1fKhj/imQe6zI/1iEVg9AE8m7V1YUAywhx/sFo3cyueYNyjqLe9Tvypy3FaBcbyv
        v7t0P1etJGn6Itq3Cm6OhZV0vly8QT3RKKYqc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EJy8GO8kn9fntlvHoFHz8oovqWab1TaD
        UM6gpJJGuzM7dpsRCpE7fD64baE3cvitOLHsJ0dn35khBeu2LWdbx+S0gqWGI0AO
        t1kCrVsZy2sv5aQiZ0tki3rB0rDEmd7XlixCFtNajd6GDtwj+jGb6/Yhy/yYTwBY
        sF9b1CH3Bhs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 347F530734;
        Wed, 24 Aug 2016 01:37:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9593D30733;
        Wed, 24 Aug 2016 01:37:43 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     git@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>,
        James Hogan <james.hogan@imgtec.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v3] format-patch: show 0/1 and 1/1 for singleton patch with cover letter
References: <20160823224550.32406-1-jacob.e.keller@intel.com>
Date:   Tue, 23 Aug 2016 22:37:41 -0700
In-Reply-To: <20160823224550.32406-1-jacob.e.keller@intel.com> (Jacob Keller's
        message of "Tue, 23 Aug 2016 15:45:50 -0700")
Message-ID: <xmqq1t1eu3q2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E1598E28-69BC-11E6-8D20-FCB17B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.e.keller@intel.com> writes:

> From: Jacob Keller <jacob.keller@gmail.com>
>
> Change the default behavior of git-format-patch to generate numbered
> sequence of 0/1 and 1/1 when generating both a cover-letter and a single
> patch. This standardizes the cover letter to have 0/N which helps
> distinguish the cover letter from the patch itself. Since the behavior
> is easily changed via configuration as well as the use of -n and -N this
> should be acceptable default behavior.
>
> Add tests for the new default behavior.
>
> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> ---
>  builtin/log.c                    |  8 ++++----
>  t/t4021-format-patch-numbered.sh | 17 +++++++++++++++++
>  2 files changed, 21 insertions(+), 4 deletions(-)

Looks good, thanks.  Queued.
