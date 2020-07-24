Return-Path: <SRS0=kKTt=BD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_C,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D58C433E0
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 00:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 366762065F
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 00:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GKbI1BcA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbgGXAmp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jul 2020 20:42:45 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65158 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727783AbgGXAmp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jul 2020 20:42:45 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 59BB56E056;
        Thu, 23 Jul 2020 20:42:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=70s5P+ZtnBEkP5+w/CitYQ5VD7I=; b=GKbI1BcAAnaKCSuvyr2E
        yGYxz0KpoohhzXgOqH5OTDcomSSWMBAdWpJb0RxuU7qUhWngxkyrjFRAtpZQLsqy
        116Re02FoygvyuZgNRhT+Ji/137Ved25zSQuhlvOMQXNGIlyWT9c5S7kJTNQIu79
        ZwboiC9RFlccMC0fkE/qJcY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=xvjz8aZ2p1jTPo8lM6a64ISk3V660bsGVkT9NOgZk6aCut
        kq+GKAwTuRBHYNjXuzgUAtrZZ1W1UpQbhYxpoVCgHDBhehG+nKyXq+TVZW3KI9fp
        fST5w/nevyR7Y+e8OnUAUejFzmIQljfi6igZd3uYbKQw3rN2YVZmgDJAbz9R4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 51B266E055;
        Thu, 23 Jul 2020 20:42:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DB7D46E054;
        Thu, 23 Jul 2020 20:42:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Drew DeVault" <sir@cmpwn.com>
Cc:     "Jeff King" <peff@peff.net>, <git@vger.kernel.org>
Subject: Re: [PATCH v2] git-send-email: die if sendmail.* config is set
References: <C4BMWIIK892D.25HUQKV9F98T6@homura>
Date:   Thu, 23 Jul 2020 17:42:43 -0700
Message-ID: <xmqq365hoi9o.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 962CDF58-CD46-11EA-A356-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Drew DeVault" <sir@cmpwn.com> writes:

> On Mon Jul 20, 2020 at 9:33 AM EDT, Jeff King wrote:
>> This basically claims the "sendmail.*" namespace for send-email. Not
>> strictly, but if we're going to warn about anything set in it, it
>> effectively shuts out other uses.
>
> The revised patch (v3 now) is less strict and offers an escape hatch via
> sendmail.forbidSendmailVariables. I'd prefer that over making sendmail.*
> just werk.

We are not in a hurry until the next cycle starts, but please send
the updated version out to the list before everybody forgets.

Thanks.
