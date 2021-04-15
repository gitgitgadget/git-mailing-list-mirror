Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 700BFC433ED
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 19:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DF9461152
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 19:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234662AbhDOTmT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Apr 2021 15:42:19 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51909 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234226AbhDOTmT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Apr 2021 15:42:19 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A143DC0754;
        Thu, 15 Apr 2021 15:41:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9hva/vpR0N3dA0uIG8TLydYuC6E=; b=Ybj99Z
        LClQ2cA26qLQzLLPLqIVAsDznXxSPcNTbwSowPz0rNE+RndOzq/BKvviKP83hI7m
        BY+i40w0NQBc85F10e0vBn97W5+zaHl74ae3XYaayMgfGK3DYDI9emdvnMnC+tIS
        9bDJpoHKHhSHn4c/8JkhRBedU1Ad99tk2v9QA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=g5mDYmu0ht3SvPyyYnmFe/4ERPEhLW2T
        X+XvbI9BTEmW6CMIb/V65QC+R94BF8V3K4a/N9V0T1bC4pwMIBEndatwNf+HicGt
        kcit6wMc/i/grcOtAcldGLRHE5zcKpFc+ZpSKhOjfWB2kW/yvcHvkeSAmea6kD8+
        E9yjFmVC/xY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 98C4CC0753;
        Thu, 15 Apr 2021 15:41:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 285DEC0752;
        Thu, 15 Apr 2021 15:41:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ed Maste <emaste@freebsd.org>
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Albert Cui <albertqcui@gmail.com>,
        Albert Cui via GitGitGadget <gitgitgadget@gmail.com>,
        git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH v2] hooks: propose project configured hooks
References: <pull.908.git.1616105016055.gitgitgadget@gmail.com>
        <pull.908.v2.git.1616723016659.gitgitgadget@gmail.com>
        <ec031dc8-e100-725b-5f27-d3007c55be87@gmail.com>
        <CAMbkP-S-9cccMpU4HG0Wurqap-WkTmD2zk50nKd9kJ_oWO__qw@mail.gmail.com>
        <YGzrfaSC4xd75j2U@camp.crustytoothpaste.net>
        <87tuoijzsy.fsf@evledraar.gmail.com>
        <9af3770f-204b-253b-d7f2-c9d5e7cf2fdb@gmail.com>
        <CAPyFy2A25EApYOivqhD_-sUNpep9c98DXHh0tXLd7T17qQLFLg@mail.gmail.com>
Date:   Thu, 15 Apr 2021 12:41:54 -0700
In-Reply-To: <CAPyFy2A25EApYOivqhD_-sUNpep9c98DXHh0tXLd7T17qQLFLg@mail.gmail.com>
        (Ed Maste's message of "Thu, 15 Apr 2021 12:52:48 -0400")
Message-ID: <xmqq7dl3qqrh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A22C275C-9E22-11EB-B5B9-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ed Maste <emaste@freebsd.org> writes:

> On Thu, 18 Mar 2021 at 21:29, brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
>> > +* Works across Windows/Linux/macOS
>>
>> Git supports other platforms as well.
>
> In particular, FreeBSD is an example of a platform that is not in the
> above list, but included in Git's CI. Is there an explicit list of
> supported platforms (and perhaps a notion of support tiers)?

It is not like there is a Git company who employs developers to
support certain platforms.  This is the mailing list for the open
source development community for Git, and Developers come and leave
over time [*].

The best you can get out of here is: if you find portability issues
when you tried to make it work on your favorite platform, you can
raise it here and (1) somebody with more Git experience on the same
platform may solve it for you, (2) somebody with similar Git
experience as you do (or less) on the same platform may solve it
with you, or (3) somebody without acess to the platform may offer to
help you solve it.  

You cannot reasonably expect more than that from us on this list.

However, major platforms have their own (often binary) packaging
system that offer Git packaged for their users.  Debian/Ubuntu ship
their own .deb, Git-for-Windows binary installer is made available
promptly after we release a new version, macOS folks have Apple Git
and homebrew or macPorts or whatever (but do not quote me on this; I
am not an Apple user).  What they do is not under our control, and
you need to ask them what their support policies, EOL timelines, and
such.  Some of these packagers lurk around here and may respond, but
that is you getting lucky ;-)


[Footnote]

* You can peek into config.mak.uname to see the list of platforms
  that have had a working Git some time in the past.  Hopefully most
  of them are still up-to-date and working, but we wouldn't even
  know if a minority platform, for which an entry for it was added
  to the file in the past by some developer who needed a working Git
  on it, no longer works with the latest version of Git with recent
  toolchains after the original developer lost interest.
