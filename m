Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21E121F462
	for <e@80x24.org>; Fri, 26 Jul 2019 19:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387419AbfGZThV (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jul 2019 15:37:21 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56378 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfGZThU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jul 2019 15:37:20 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CCADE78AC7;
        Fri, 26 Jul 2019 15:37:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uA2lwCUobHWvcC6ZMtPBwCzarDU=; b=UE8quZ
        +ohItE+qJ6Hiagu0eyspm8QMVvJ4k+px7rSmQETjm4rO7mADHrj6EwV286VrORem
        Ue5FlHPb0hSFS3TKqAb+LgCX+a/CcLK8bEiwevM0EMBLAIYvCy4fPG7ToUbMRiLj
        eEk51PNaBUN0aZErIVc4tObMj6cMEb1E8dj7I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=V7gBB7y/z9OrQrCpAzxBQCBQgWFEg/KL
        gEboZveWTVgMLqiSIy2iZxSBI2CSC0sOoWatSAbdsCbRIRHozZtdcFGoqf7Dh23s
        nIM7o/WtShG5QTu/ubI9n5BJZKWjwX8rk4usG3Lbl4RKQlnZ/M1/kxV11r+b1Ywx
        jsqGUbt9UdU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B2AF178AC6;
        Fri, 26 Jul 2019 15:37:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C8F3878AC5;
        Fri, 26 Jul 2019 15:37:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 05/20] merge-recursive: remove useless parameter in merge_trees()
References: <20190725174611.14802-1-newren@gmail.com>
        <20190726155258.28561-1-newren@gmail.com>
        <20190726155258.28561-6-newren@gmail.com>
Date:   Fri, 26 Jul 2019 12:37:13 -0700
In-Reply-To: <20190726155258.28561-6-newren@gmail.com> (Elijah Newren's
        message of "Fri, 26 Jul 2019 08:52:43 -0700")
Message-ID: <xmqq7e84oady.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C5D76EAE-AFDC-11E9-84CB-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> merge_trees() took a results parameter that would only be written when
> opt->call_depth was positive, which is never the case now that
> merge_trees_internal() has been split from merge_trees().  Remove the
> misleading and unused parameter from merge_trees().
>
> While at it, add some comments explaining how the output of
> merge_trees() and merge_recursive() differ.

Makes sense.
