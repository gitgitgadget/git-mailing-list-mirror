Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D9CE7D263
	for <git@archiver.kernel.org>; Tue, 26 Sep 2023 08:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbjIZIsS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Sep 2023 04:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjIZIsR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2023 04:48:17 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92F5DD
        for <git@vger.kernel.org>; Tue, 26 Sep 2023 01:48:10 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id E84B623FF7;
        Tue, 26 Sep 2023 04:48:07 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
        id 1ql3jj-Ss7-00; Tue, 26 Sep 2023 10:48:07 +0200
Date:   Tue, 26 Sep 2023 10:48:07 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Git List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v2 3/3] pkt-line: do not chomp newlines for sideband
 messages
Message-ID: <ZRKax7Me5uIHKHoC@ugly>
References: <CANYiYbF+Xmk4rCNLMJe+i_CFafg8=QU5vbXWNUZbOVsDLTe5QQ@mail.gmail.com>
 <20230925154144.15213-3-worldhello.net@gmail.com>
 <xmqqa5t9rkft.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqqa5t9rkft.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>Jiang Xin <worldhello.net@gmail.com> writes:
>
>> +++ b/pkt-line.c
>> @@ -462,8 +462,33 @@ enum packet_read_status packet_read_with_status(int fd, char **src_buffer,
>>  	}
>> +			case 2:
>> +				/* fallthrough */
>> +			case 3:
>
while not entirely unprecedented, it's unnecessary and even 
counter-productive to annotate directly adjacent cases with fallthrough.

regards
