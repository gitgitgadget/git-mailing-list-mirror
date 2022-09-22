Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36AB8C6FA82
	for <git@archiver.kernel.org>; Thu, 22 Sep 2022 19:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbiIVTcQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Sep 2022 15:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbiIVTcO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2022 15:32:14 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4CEF108085
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 12:32:13 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 534F51BBC75;
        Thu, 22 Sep 2022 15:32:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IENTTcN43aLHcwANqJujUHCAOdHwErJpcwWHkS
        2J5UE=; b=BgTOQjRhJo1OlEBIFl4bXUoF7HowTzlD34XAyLjW70uHflHTtOWvnd
        FxBLZy5nnxRbT2pwd1EJlX6y+1TWjjpnLa+Qs2GbYYLXwz0GkT8LzVyWjxs45rjr
        a+6vW27jhoIUQbA7aGI0871ZcmxLDkSMI4y7CzxRymD7tyruRYo1A=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4A2891BBC74;
        Thu, 22 Sep 2022 15:32:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6C3741BBC72;
        Thu, 22 Sep 2022 15:32:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Altmanninger <aclopte@gmail.com>
Cc:     Erik Cervin Edin <erik@cervined.in>, git@vger.kernel.org
Subject: Re: [PATCH v2] sequencer: avoid dropping fixup commit that targets
 self via commit-ish
References: <xmqqleqfcoz3.fsf@gitster.g>
        <20220920031140.1220220-1-aclopte@gmail.com>
        <xmqqa66s36pt.fsf@gitster.g> <YyvdwbE6oCeNn035@gmail.com>
Date:   Thu, 22 Sep 2022 12:32:03 -0700
In-Reply-To: <YyvdwbE6oCeNn035@gmail.com> (Johannes Altmanninger's message of
        "Wed, 21 Sep 2022 23:00:01 -0500")
Message-ID: <xmqqpmfnxl1o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3E230F18-3AAD-11ED-B94D-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Altmanninger <aclopte@gmail.com> writes:

>> hint: Waiting for your editor to close the file...
>> Successfully rebased and updated refs/heads/main.
>> --- expect      2022-09-21 18:45:27.617530848 +0000
>> +++ actual      2022-09-21 18:45:27.613530478 +0000
>> @@ -1,2 +1,2 @@
>>  pick HASH hay needle hay # empty
>> -fixup HASH fixup! :/needle # empty
>> +pick HASH fixup! :/needle # empty
>> not ok 11 - auto squash that matches regex
>> 
>> That does not look very good X-<.
>
> Sorry the v2 of this test case is very misleading, should probably drop this
> test entirely.  It's been a long a day so I'll send v3 another day (if needed).

Thanks.
