Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3ECCF20193
	for <e@80x24.org>; Thu, 27 Oct 2016 16:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936563AbcJ0Q75 (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 12:59:57 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62277 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934007AbcJ0Q74 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2016 12:59:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CDA0C495A5;
        Thu, 27 Oct 2016 12:59:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fCjSIsT7rofbOuk4r2o82Hc13cU=; b=DPCNCp
        aggM80yFNfvfGmB8M8WQmLBcCn+EjvWEd15tdC2eRsqwudUulsNH8RBQfEW1rad9
        2BA8n1UORj06dr99pxkzrCxlS636AekAaPEoD1FXf0iwRTv1IDMi3f2xlpdR9mAM
        ZAvq1YHn8ZF9/eia9Hpay3QvnYU1Sfay7CnAQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AzejmlhfKorQ24U3KVl3WrDNfL9QQi+0
        Az1fYXz6IF84BNW3lEVK0q8+4xsvBWCGVj+MHFTzONj56g/+7+weQ2TIM1pF/J42
        6wm3bOMLFEb4hEC1afRVURVQlYDWMmOQv/vY6y3jAs3W9R0Hf9Yf77ebtTRtXB1X
        qeBlQp4URZo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C1C58495A2;
        Thu, 27 Oct 2016 12:59:54 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 32538495A1;
        Thu, 27 Oct 2016 12:59:54 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Matthieu Moy <Matthieu.Moy@imag.fr>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH v15 01/27] bisect--helper: use OPT_CMDMODE instead of OPT_BOOL
References: <01020156b73fe5b4-5dc768ab-b73b-4a21-ab92-018e2a7aa6f7-000000@eu-west-1.amazonses.com>
        <01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com>
Date:   Thu, 27 Oct 2016 09:59:52 -0700
In-Reply-To: <01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com>
        (Pranit Bauva's message of "Fri, 14 Oct 2016 14:14:15 +0000")
Message-ID: <xmqqvawd7mnr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C85373D0-9C66-11E6-B4AF-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Cc'ed those who touched either "git-bisect.sh" or "builtin/bisect-helper.c"
in our relatively recent past.

Does any of you (and others on the list) have time and inclination
to review this series?

Thanks.
