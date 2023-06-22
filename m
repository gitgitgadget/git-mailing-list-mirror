Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A389BEB64DA
	for <git@archiver.kernel.org>; Thu, 22 Jun 2023 21:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbjFVVh2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jun 2023 17:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjFVVh0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2023 17:37:26 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60ABC1FED
        for <git@vger.kernel.org>; Thu, 22 Jun 2023 14:37:25 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D3A4430DDF;
        Thu, 22 Jun 2023 17:37:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wq8NpTKQPH2PyxPwLY5lziU33qhNVIxu555nWT
        2iCDM=; b=W+hpcfNg31C8T3Jd8ue4rkjnJo8jQyTnztWpEorooCvtz7ni4MA0M1
        ZqMfSwV2oFz/Pddd+7/VJZIDri/dDObdcXvjt2n/cLr76knBbW0Y6LjeW5a4sCUD
        cbU32JCzz69q3uGujV5QLbwwDgtkdPxz+v3slpCt6tBBMOSvHvAqA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CC57830DDE;
        Thu, 22 Jun 2023 17:37:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.62.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E5B6530DDD;
        Thu, 22 Jun 2023 17:37:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org,
        Elijah Newren <newren@gmail.com>,
        Calvin Wan <calvinwan@google.com>
Subject: Re: [PATCH 2/3] var: add attributes files locations
References: <20230622195059.320593-1-sandals@crustytoothpaste.net>
        <20230622195059.320593-3-sandals@crustytoothpaste.net>
        <ebdf8a20-9ac7-dcf7-8cc6-b63894b7eb45@github.com>
        <ZJS6eARkNOuT+Zd/@tapette.crustytoothpaste.net>
Date:   Thu, 22 Jun 2023 14:37:20 -0700
In-Reply-To: <ZJS6eARkNOuT+Zd/@tapette.crustytoothpaste.net> (brian
        m. carlson's message of "Thu, 22 Jun 2023 21:17:44 +0000")
Message-ID: <xmqq8rcbdvqn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F87EBFD8-1144-11EE-8E50-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2023-06-22 at 20:19:46, Derrick Stolee wrote:
>> One way to solve for this is to use the more modern style
>> when initializing the structs:
>> 
>> static struct git_var git_vars[] = {
>> 	{
>> 		.name = "GIT_COMMITTER_IDENT",
>> 		.read = git_author_info,
>> 		.free = 0,
>> 	},
>> 	...
>> }
>
> Good idea, I've got this in for a v2.

Yeah, this would make it palatable ;-)
