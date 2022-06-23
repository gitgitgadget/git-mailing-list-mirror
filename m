Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA00C43334
	for <git@archiver.kernel.org>; Thu, 23 Jun 2022 19:00:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbiFWTAT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jun 2022 15:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbiFWS7v (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jun 2022 14:59:51 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7E310CD16
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 11:05:22 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3205A1B79F5;
        Thu, 23 Jun 2022 14:05:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=BQJByLpME/ODTAIE9X11A6N6EBI4Nz0uZY4upa
        cTHdk=; b=oe43EAECZuHVsHbnCFOFbrvWMPtGfYp5uJiw0m4xCNqV7sA3kXpU8R
        iLXQJkShJl01/3RLks7bU22dXaPklpU1yAF15ghTKTKwfs0nyfSykdjvDg5NUtDJ
        cgfak5Bq/o39No30Qwf2xsxVQuI9+qLvEQpCb7haFi8AuFOPzzqQs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2A8E81B79F4;
        Thu, 23 Jun 2022 14:05:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9272C1B79F1;
        Thu, 23 Jun 2022 14:05:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>, git@vger.kernel.org,
        vdye@github.com
Subject: Re: [PATCH v4 0/7] mv: fix out-of-cone file/directory move logic
In-Reply-To: <4d181d4f-b86c-42f9-eeca-000ec4a06015@github.com> (Derrick
        Stolee's message of "Thu, 23 Jun 2022 11:16:15 -0400")
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
        <20220623114120.12768-1-shaoxuan.yuan02@gmail.com>
        <4d181d4f-b86c-42f9-eeca-000ec4a06015@github.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
Date:   Thu, 23 Jun 2022 11:05:15 -0700
Message-ID: <xmqqzgi3z25g.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 093CD336-F31F-11EC-BFBA-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> On 6/23/2022 7:41 AM, Shaoxuan Yuan wrote:
>> ## Changes since WIP v3 ##
>
> It's good to keep the main cover letter body around, even as the version
> updates are included. Sometimes reviewers come to a topic late and want
> to see the latest version be completely self-contained.

Yup.  Thanks for stressing on it.

> After reading all the patches with fresh eyes, I think the code looks
> very good. I have a nitpick in a commit message and some recommendations
> for additional tests, but otherwise I'm pretty happy with this version.

Thanks for ushering the topic forward.


