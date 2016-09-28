Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC5F11F4F8
	for <e@80x24.org>; Wed, 28 Sep 2016 18:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932221AbcI1S7S (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Sep 2016 14:59:18 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61138 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751451AbcI1S7R (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2016 14:59:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B069842B84;
        Wed, 28 Sep 2016 14:59:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BWnZOaWsGSUFaEn4WyXiJ78vpyE=; b=wQtj5h
        jC2tGbbWsFGmOAhgcBB+4K1z1tL1b4dgUiYvdALHpOwZPVRMnKqdSMFCulsbZIAN
        i8bCJfWdBb55c5BBLi6ukLGHPP51FXH0W+4oBN81GjMV6vDvVMSYGvSymLwgfEqj
        8bHDqDRkxs8yiTeIsMd+jH9JEQ35WGIkVmYbo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=K4EKO574YDSMtOcopNBayHE76MtO/tHT
        oPcktaBBh8PbMW+MRSGpqSZzZ/b2/X//ypvyCYReiUZoZI9ursinmXa9BDe6khXE
        zhiCfmUcXnyF9PdmFraQkm5rEY6zASwLt2woTdt0sig/AhWHafiWtRjk6LQ8SU+/
        +2vI1FvJWdQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A721B42B81;
        Wed, 28 Sep 2016 14:59:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 41C1242B80;
        Wed, 28 Sep 2016 14:59:15 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/4 v4] ls-files: pass through safe options for --recurse-submodules
References: <1474676014-134568-1-git-send-email-bmwill@google.com>
        <1474930003-83750-1-git-send-email-bmwill@google.com>
        <1474930003-83750-4-git-send-email-bmwill@google.com>
        <xmqqh991nq34.fsf@gitster.mtv.corp.google.com>
        <xmqqwphxm7av.fsf@gitster.mtv.corp.google.com>
        <20160928172417.GA61176@google.com>
Date:   Wed, 28 Sep 2016 11:59:13 -0700
In-Reply-To: <20160928172417.GA61176@google.com> (Brandon Williams's message
        of "Wed, 28 Sep 2016 10:24:17 -0700")
Message-ID: <xmqq4m4zkfzy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A6A18CEC-85AD-11E6-B803-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

>> I actually think it would make more sense to add
>> 
>>     lf_to_nul () {
>>             perl -pe 'y/\012/\000/'
>>     }
>> 
>> to t/test-lib-functions.sh somewhere near q_to_nul if we were to go
>> this route.
>
> Turns out this function already exists in test-lib-functions.sh

;-)
