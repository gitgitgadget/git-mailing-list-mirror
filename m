Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA1AF1F462
	for <e@80x24.org>; Mon, 10 Jun 2019 17:31:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388135AbfFJRbj (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jun 2019 13:31:39 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50741 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387456AbfFJRbi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jun 2019 13:31:38 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BBF3A16216F;
        Mon, 10 Jun 2019 13:31:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uowyQL/fwyROvm7SHlHW/cOlkhk=; b=uuudOZ
        Dw1k+a5NTfaAsbSC+6oxVs9s0dA/W7bBBdpdLUErBa9H3zugDqLQfVmLBAIiBoqh
        7dfPtXaaI8wNUQ/NNKmfqO6OR0S/yw/lA8KsfDgA8rSRRbV917dkzUQLbHHkokUy
        G5wpHHGjJiDGNkw9/L52UFo4u6mlhmI8ShI8A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=u6OdeExDdAWDHEaxJXI6OV5iPPq6MmEV
        HDG3zrzkHNt+WxoOqEzRsxe+Wh4SLadD5xn5h1CwstPt/EjtzhyOzNJLC3Qbom1f
        xgnn+mhLnk9iqnyilSL+hjnFmBl9ajLwhcWs69LblqUW5ldr8t+cuho1CJTKH6b6
        /seOzSg1P8g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B321D16216E;
        Mon, 10 Jun 2019 13:31:36 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 161D316216D;
        Mon, 10 Jun 2019 13:31:36 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, jrnieder@gmail.com,
        avarab@gmail.com, dstolee@microsoft.com
Subject: Re: [PATCH v6 00/11] Create 'expire' and 'repack' verbs for git-multi-pack-index
References: <20190424151428.170316-1-dstolee@microsoft.com>
        <20190514184754.3196-1-dstolee@microsoft.com>
        <5fadd5ee-0993-ad94-2cda-f8dfe3795336@gmail.com>
Date:   Mon, 10 Jun 2019 10:31:35 -0700
In-Reply-To: <5fadd5ee-0993-ad94-2cda-f8dfe3795336@gmail.com> (Derrick
        Stolee's message of "Mon, 10 Jun 2019 10:15:44 -0400")
Message-ID: <xmqqy329mjns.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 98CF1E62-8BA5-11E9-A59B-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 5/14/2019 2:47 PM, Derrick Stolee wrote:
>> Updates in V6:
>> 
>> I rebased onto ds/midx-too-many-packs. Thanks, Junio for taking that
>> change first. There were several subtle things that needed to change to
>> put this change on top:
>> ...
> However, this series was dropped from the cooking emails, and never
> included this v6. Now that the release is complete, could this be
> reconsidered?

"reconsider" is a bit strong word, as (at least as far as I recall)
it was never "rejected" as an unwanted topic, but was merely
postponed to give way to other topics in flight.  Thanks for keeping
an eye on it and finding the right moment to raising it again.

I could go back to the list archive and dig it up, but because it
has been a while since it was posted, it may not be a bad idea to
send it for a review, after making sure it cleanly applies to
'master', to make it one of the early topics to go 'next' during
this cycle, I would think.

Thanks.
