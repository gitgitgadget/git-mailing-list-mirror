Return-Path: <SRS0=mJAO=7L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A2EC433E0
	for <git@archiver.kernel.org>; Fri, 29 May 2020 01:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 761262075F
	for <git@archiver.kernel.org>; Fri, 29 May 2020 01:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HM8aLXo9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438281AbgE2BUg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 21:20:36 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63494 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438235AbgE2BUf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 21:20:35 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BCEC27FFD0;
        Thu, 28 May 2020 21:20:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Ho1vDfmcpMoulL2q0YJUspoIevQ=; b=HM8aLX
        o9LwEcAQjcyU0BIbSbLsWm45q/Wv4c4sK0Cplm/ncBZQkr8TBrjkJYnjRo4vAwzo
        jPPcPQK/B5zGJQAKtLo1JdXU4uMmYn5bNa2yRpEdnePL9c0vajVCjKuy0PM5tyv/
        EIggifYVwfeI4A/S1a7cli3okgJ+wsz5US0LQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BJjLsepWadhj95MUgqDTAV/E9Jh0LSDK
        f5l9s/wgHCpI6Kv268fIDOSo8w+gV8yxZqXoEadq8+cxdqYecZ9FucdDmm11ULjU
        9Hyll0v+XgxarBQEXQdK/PSUsG5iAKs8Z3BetE/128pewg0klz0t+yqwO/chJWn3
        zEBxMeHEOMw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B50997FFCF;
        Thu, 28 May 2020 21:20:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 27F5A7FFCE;
        Thu, 28 May 2020 21:20:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kenneth Lorber <keni@his.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH v2 3/6] doc: Add namespace collision guidelines file
References: <1589681624-36969-1-git-send-email-keni@hers.com>
        <20200525232727.21096-1-keni@his.com>
        <20200525232727.21096-4-keni@his.com>
        <xmqqy2pb3new.fsf@gitster.c.googlers.com>
        <xmqqo8q73lkf.fsf@gitster.c.googlers.com>
Date:   Thu, 28 May 2020 18:20:32 -0700
In-Reply-To: <xmqqo8q73lkf.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 28 May 2020 12:29:20 -0700")
Message-ID: <xmqq7dwv1qqn.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 97A14C02-A14A-11EA-8C6A-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> The names of the subcommands "git" can spawn is a shared resource.
>> ...
>
> Also names of worktrees that are attached to a single repository.
> ...
>
> I (or others) may come up with other things that must be named and
> name collisions must be avoided.  Even though I already said that I
> didn't think the "suggestions to avoid name collisions" given by the
> RFC PATCH are well done, I do think it is worth being aware of the
> problem space, and enumerating what kind of names are shared and
> limited resource is the first step to become so.

Here are a few more.

 - The nickname of a remote, like 'origin'.
 - A custom pretty format alias 'pretty.<name>'.
 - Ref hierarchy name (next to refs/{heads,tags,remotes}).

All of these are defined in the configuration, and unlike
attributes, they are never defined by in-tree tracked files, so we
do not have to worry about "I use this name, and I want to make sure
others do not use the same for different purpose."  

But third-party tools may want to carve out a subnamespace for their
own use, and there needs coordination among them so that they do not
stomp on each other's toes, or collide with names the end-users
would want to use.
