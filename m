Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 723D4EE3F3F
	for <git@archiver.kernel.org>; Wed, 13 Sep 2023 00:32:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235236AbjIMAc6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Sep 2023 20:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbjIMAc6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2023 20:32:58 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68A910CC
        for <git@vger.kernel.org>; Tue, 12 Sep 2023 17:32:53 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3422435794;
        Tue, 12 Sep 2023 20:32:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=48uc4CoEbrS9Wm/MhCEC8ju5+rv/j0nHaljk9H
        jLud0=; b=JrqOTAZ9LXtopLuTsn/0FyuVjQmLnYOI76vk4xarvs/0RxL0ofaVSg
        VdYkhRS38JN+Gwi/4VgJasXBwxv5QSRhh50o+Mmv+YB/vH7hn4gdRd9m0TU9nx9I
        28JZ1KdY2VD1+geNJLF8uM0CiLer+xY+DlNup3fXFZaQJiRffaLXI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2B73C35793;
        Tue, 12 Sep 2023 20:32:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C1AFE35790;
        Tue, 12 Sep 2023 20:32:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2] sequencer: remove unreachable exit condition in
 pick_commits()
In-Reply-To: <7ede7c26-9029-4e4b-81a3-f992eff74124@gmail.com> (Phillip Wood's
        message of "Tue, 12 Sep 2023 14:27:34 +0100")
References: <ddf8dc95-6583-4257-b48a-0115f59950ef@gmail.com>
        <20230912105541.272917-1-oswald.buddenhagen@gmx.de>
        <7ede7c26-9029-4e4b-81a3-f992eff74124@gmail.com>
Date:   Tue, 12 Sep 2023 17:32:48 -0700
Message-ID: <xmqqwmwukj4f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1174C938-51CD-11EE-A22F-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 12/09/2023 11:55, Oswald Buddenhagen wrote:
>> This was introduced by 56dc3ab04 ("sequencer (rebase -i): implement the
>> 'edit' command", 2017-01-02), and was pointless from the get-go: all
>> early exits from the loop above are returns, so todo_list->current ==
>> todo_list->nr is an invariant after the loop.
>> Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
>
> Thanks for updating the commit message, I think it is clearer now

Thanks, both.  Queued.
