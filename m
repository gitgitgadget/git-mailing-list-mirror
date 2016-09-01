Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E870C20193
	for <e@80x24.org>; Thu,  1 Sep 2016 20:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754333AbcIAUyz (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 16:54:55 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60200 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752974AbcIAUyv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 16:54:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3522F3B200;
        Thu,  1 Sep 2016 15:19:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dCPAJaCEo9uXt+Ep+j8YbGsvvTQ=; b=d5MkUT
        1Biz3nO7up283Jwh9YhknPmSAoG62JRKjxc95STjSCsbFnhPV3V7uMdIbccndO88
        hElfRUXUCmr79JTIitjMp93e45vj5j1tigrih9BKV07vit6PSQBbdsSeFQDI/+qq
        7j3QmE1Uc1qz0HtMlRa72ygtIG6bKSBI3e9Zw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lTPYABtY+BSiHM0hKLtfKjt60ZH+bYnK
        g0lKrDA9iZd4gaHLr6/L3bfzv4L5IlpQvPIAyC0M3gePv2y1RAgUnW/Dzsl3uP9+
        6mx+zY3xGGy1VolSIlshVY33WzWEngZXxb/8RXJF3oxBXWe/Wu0DOeBy0bIn1hvk
        XhlZWA5WNxI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2CBCD3B1FE;
        Thu,  1 Sep 2016 15:19:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A61C33B1FD;
        Thu,  1 Sep 2016 15:19:46 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Uma Srinivasan <usrinivasan@twitter.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: git submodules implementation question
References: <CAN5XQftQH8B+hWVh4JQgZwAp+rkbz51P5NZDc_+Tfm0EB1zkew@mail.gmail.com>
        <xmqqlgzf9wch.fsf@gitster.mtv.corp.google.com>
        <CAN5XQft6S+LG0mBgRFPrMZiOxHSfRhjLmQdeMdBeHKoWQSRUEA@mail.gmail.com>
        <CAPc5daVhY6WdHkXGLYea48uOw0-rTzLLZ=7mNo=VPebZ9AG4jQ@mail.gmail.com>
        <CAN5XQfty6Fshzf6kN7eXhFekU9+=VPwbzEPN1a92yVB=9nm0Vg@mail.gmail.com>
        <CAN5XQfsg_sJbyjfdc=-e85jiCQNUqagwgh6TVOXN+NskZ7KkVw@mail.gmail.com>
        <xmqqbn0b6ua8.fsf@gitster.mtv.corp.google.com>
        <CA+P7+xosGg955msq-gyKz_HyCZf7fPFQJdKZ3P8U3+poBBfuWA@mail.gmail.com>
        <CAN5XQfsv+BEYDWR6Xjs4mCtYDVR12a2UzB1-_H4A_xfjUUOe2g@mail.gmail.com>
        <CA+P7+xohfRsoV9VXgUrRaXPb9HvCc5gs4-KSWp38X_d_6EfkTA@mail.gmail.com>
        <CA+P7+xpGnsKzBPLVgPNSmZ7K00vY7-eJp7kSHWMRHM+cOsL_XQ@mail.gmail.com>
        <CAN5XQftCC+TUm2Jx4q3V9oFbXndtFx3H+daoB3TD3eWUs6s54A@mail.gmail.com>
        <xmqqzinu3zyw.fsf@gitster.mtv.corp.google.com>
        <CAN5XQfuoq6MV4e98RzUCG02KvZO6VZAbs1oxAzpdg5zswqpHGw@mail.gmail.com>
        <xmqq7faw3n5w.fsf@gitster.mtv.corp.google.com>
        <xmqqk2ewxnui.fsf@gitster.mtv.corp.google.com>
        <CAN5XQftt3qVoU9gB2oyimY328VK0W6xq5FSCQYvcB9dEgkxVWA@mail.gmail.com>
        <xmqqmvjrwjwm.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kZnhNVBy6Oqt=x8m0jZj_tGNkMPPBBr+aL6DToOYtv9vQ@mail.gmail.com>
Date:   Thu, 01 Sep 2016 12:19:44 -0700
In-Reply-To: <CAGZ79kZnhNVBy6Oqt=x8m0jZj_tGNkMPPBBr+aL6DToOYtv9vQ@mail.gmail.com>
        (Stefan Beller's message of "Thu, 1 Sep 2016 11:37:30 -0700")
Message-ID: <xmqqa8frwhpr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0B74DE66-7079-11E6-B7CE-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> The final version needs to be accompanied with tests to show the
>> effect of this change for callers.  A test would set up a top-level
>> and submodule, deliberately break submodule/.git/ repository and
>> show what breaks and how without this change.
>
> Tests are really good at providing this context as well, or to communicate
> the actual underlying problem, which is not quite clear to me.
> That is why I refrained from jumping into the discussion as I think the
> first few emails were dropped from the mailing list and I am missing context.

I do not know where you started reading, but the gist of it is that
submodule.c spawns subprocess to run in the submodule's context by
assuming that chdir'ing into the <path> of the submodule and running
it (i.e. cp.dir set to <path> to drive start_command(&cp)) is
sufficient.  When <path>/.git (either it is a directory itself or it
points at a directory in .git/module/<name> in the superproject) is
a corrupt repository, running "git -C <path> command" would try to
auto-detect the repository, because it thinks <path>/.git is not a
repository and it thinks it is not at the top-level of the working
tree, and instead finds the repository of the top-level, which is
almost never what we want.

