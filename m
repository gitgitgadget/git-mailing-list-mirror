Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C8642036B
	for <e@80x24.org>; Wed,  4 Oct 2017 04:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750871AbdJDELn (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Oct 2017 00:11:43 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51840 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750779AbdJDELm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2017 00:11:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DF3D6950A3;
        Wed,  4 Oct 2017 00:11:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+KSGDLQy4WOcloqLO8npwPpKXOs=; b=jG2mVT
        B/rdh8VXWSnnm5lUYgT4FZfrJLs2ZzarEk+T9ekmG9oH+47Hg9nggLzsabtVuRBp
        mNKgOIqAB4usS0HSzbIwS/4uLJJkrKk1Tn+AtDAFVBlkP9RfvsGCTpW1E+LLlRlF
        w+l5sLkHhz7g64lw/DjkDSN1VPk2IWht30pU0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mLw46j7T+S9YNwikn3eYVAgxuWqx9iNm
        S3cCyXhK0T2oupLRNn8C9mtVeEY7rTATvq7A8TENzUssNAQ38cH+8v73nlaemkL7
        GDN58S/LvkN6VZIzVll3Ji9cB1DgFIYgp2KbFt/5TuZEI9fDmdkea6dU+WC+wTik
        uiS8F4ktnKo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D5710950A2;
        Wed,  4 Oct 2017 00:11:41 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 43EB9950A1;
        Wed,  4 Oct 2017 00:11:41 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] branch: change the error messages to be more meaningful
References: <20170730115908.13841-1-kaarticsivaraam91196@gmail.com>
        <20170821133608.5652-1-kaarticsivaraam91196@gmail.com>
        <1506964786.3504.3.camel@gmail.com>
        <xmqqbmlpm67l.fsf@gitster.mtv.corp.google.com>
        <1507058081.7360.5.camel@gmail.com>
Date:   Wed, 04 Oct 2017 13:11:40 +0900
In-Reply-To: <1507058081.7360.5.camel@gmail.com> (Kaartic Sivaraam's message
        of "Wed, 04 Oct 2017 00:44:41 +0530")
Message-ID: <xmqqwp4beemb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 200903A0-A8BA-11E7-B70C-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:

> I interpreted the "not .. too bad" as a "it makes little sense". So,
> pinged the thread.

Thanks.  I think what the patch does (sort of) makes sense.  

It is a bit dissapointing that we do not need to touch tests, as it
indicates that the logic to diagnose extra arguments as an error has
no coverage.
