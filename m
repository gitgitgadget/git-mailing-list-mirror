Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BC071FBB0
	for <e@80x24.org>; Tue, 29 Nov 2016 00:07:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756008AbcK2AHI (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Nov 2016 19:07:08 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63919 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755925AbcK2AHB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2016 19:07:01 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7911155D72;
        Mon, 28 Nov 2016 19:06:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HHHjY8uPdSD2PkoZ5NeNtJFnJ0g=; b=Vo1zs/
        y/ydQD5yCbZ8kfyT819fQN5+tmHXLrrfFQTTB7+kvu5DUiCvKxO290bVPt12IlNL
        vh/QzBWwKHtd1UKRBbQk5WhyuZw2Tq/XgsOYmHI/xQklPqtHao87Wqxl/kSIiXnc
        w1zOCtOSoYJxKz9cYFEuI3X0SVemZLf1dRybU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gGxsSqwYtGHDDit0UxlmAamTmSECCYYM
        adKqOQ7R27007T9pUYFvkUufAlM5VYo+W1HloUEtBrjSyvJS3mypzG6FvCYp8oiy
        I+tAiafLRtDHkQz8Y7il7QUcEojZJtvn6+dvb208HeNZ2GalELd55GoDv7c4J2k7
        f0PN3Cf7ibY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 709C655D71;
        Mon, 28 Nov 2016 19:06:59 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DA6F755D70;
        Mon, 28 Nov 2016 19:06:58 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: Re: What's cooking in git.git (Nov 2016, #05; Wed, 23)
References: <xmqqk2btlr3x.fsf@gitster.mtv.corp.google.com>
        <732c0e78-74b5-befa-e3c5-5ed9f221fa3a@google.com>
Date:   Mon, 28 Nov 2016 16:06:57 -0800
In-Reply-To: <732c0e78-74b5-befa-e3c5-5ed9f221fa3a@google.com> (Jonathan Tan's
        message of "Mon, 28 Nov 2016 16:01:41 -0800")
Message-ID: <xmqqpolfgndq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BF02559C-B5C7-11E6-86D1-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> On 11/23/2016 03:21 PM, Junio C Hamano wrote:
>> * jt/use-trailer-api-in-commands (2016-11-02) 6 commits
>>  - sequencer: use trailer's trailer layout
>>  - trailer: have function to describe trailer layout
>>  - trailer: avoid unnecessary splitting on lines
>>  - commit: make ignore_non_trailer take buf/len
>>  - SQUASH???
>>  - trailer: be stricter in parsing separators
>>
>>  Commands that operate on a log message and add lines to the trailer
>>  blocks, such as "format-patch -s", "cherry-pick (-x|-s)", and
>>  "commit -s", have been taught to use the logic of and share the
>>  code with "git interpret-trailer".
>>
>>  What's the doneness of this topic?
>
> Stefan Beller mentioned [1] that this seemed OK to him from a cursory
> read. Do I need to look for another reviewer (or a more thorough
> review)?

I gave it a cursory review when it was queued, too, so another
cursory read does not help very much ;)  If I recall correctly, I
got an impression that it was reasonably well done.

I haven't had a chance to look at the series again to see if the
SQUASH is just the simple matter of squashing it into the one
previous, which is the main reason why I haven't decided if it is
ready to be in 'next'.

Thanks.

