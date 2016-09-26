Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 783DF207EC
	for <e@80x24.org>; Mon, 26 Sep 2016 21:34:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966483AbcIZVeX (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 17:34:23 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54280 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S965507AbcIZVeW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 17:34:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B103E427EB;
        Mon, 26 Sep 2016 17:34:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UOy0HkOYCPRJKH3APRLio43Fcyw=; b=o8DVkx
        ICuj8YUkbT1Zs0b5uH0vnD1QXbqsPxyS0xBT6ynS4H7SPc6hqVnmnshT5TRcuR8i
        MgI3xFDsjZEFgjBIDDew+91nK67lM6SyUYwUZMRSyEQHxxIWwxtj1cQ66VCgBA9d
        QOxPKSo4sMBxScP2o53jKuP8v6KJ7OGqsDtnE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ef8Jb074Aa1ulv4qWTXEYZF44/ua7sNO
        4a5pMG2KDY/dCpQDMuqqmwAfkIFtB/39N6NEQTiWAESvC9I+8vDhXcVbYyDd1eML
        2jVLTKZW4Gq4S1pyt1K+qb2O4WwabozLkYpddl3BwC+JfMoKzy69renZoTKt5hDl
        aGXeGh/qXEs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A9538427EA;
        Mon, 26 Sep 2016 17:34:20 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2D4B8427E9;
        Mon, 26 Sep 2016 17:34:20 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Orgad Shaneh <orgads@gmail.com>
Cc:     Pat Thoyts <patthoyts@users.sourceforge.net>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH] git-gui: Do not reset author details on amend
References: <1462458182-4488-1-git-send-email-orgads@gmail.com>
        <xmqqwpn8bes0.fsf@gitster.mtv.corp.google.com>
        <CAGHpTBLdy9R7xvfcFWoMkvGNJjY-wM5=HfWxs8XF_yh-+2Rc3w@mail.gmail.com>
        <CAGHpTBLgwyw_iYK927Yed+XG9ti+tKboz07-FVYWox9WoQkjOg@mail.gmail.com>
        <CAGHpTB+Fnu4x1bV9TSNo8pYdOzJzRsXA9r3CwxVz64mjW_qsGw@mail.gmail.com>
Date:   Mon, 26 Sep 2016 14:34:18 -0700
In-Reply-To: <CAGHpTB+Fnu4x1bV9TSNo8pYdOzJzRsXA9r3CwxVz64mjW_qsGw@mail.gmail.com>
        (Orgad Shaneh's message of "Mon, 26 Sep 2016 23:06:53 +0300")
Message-ID: <xmqqmviupcpx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FBF7A196-8430-11E6-9C62-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Orgad Shaneh <orgads@gmail.com> writes:

> On Sun, Jul 10, 2016 at 7:36 AM, Orgad Shaneh <orgads@gmail.com> wrote:
>
>> On Wed, May 18, 2016 at 9:12 AM, Orgad Shaneh <orgads@gmail.com> wrote:
>>> ping?
>>>
>> It's been over 2 months. Can anyone please review and merge it?
>>
> 4.5 months and counting... :(
>>
>>> On Thu, May 5, 2016 at 8:22 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>>> Pat, we haven't heard from you for a long time.  Are you still
>>>> around and interested in helping us by maintaining git-gui?
>>>>
>>>> Otherwise we may have to start recruiting a volunteer or two to take
>>>> this over.

Sorry about that.  No volunteers materialized yet X-<, and I really
really do not want to apply anything other than trivial patches to
it myself, as I am not a git-gui user.

