Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E218FC433DB
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 00:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A158961A06
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 00:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbhCZAqD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Mar 2021 20:46:03 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59107 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbhCZApy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Mar 2021 20:45:54 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C9AD9C8A3C;
        Thu, 25 Mar 2021 20:45:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+saenQoHNdMuyQ6WUhZHsGg8bcM=; b=LrXnrG
        jDjQYQUcNZUgLHpp0uRDIlR1gGbQDy7QXAensLlkxKbvHRHTbTLrcOJhpYTG5JWe
        iSNzRNMwyLD0SJuKZHJ+EteA/YeI82HUYZQm3j5C7Qi5lczZaDGyMHbcPXMGJvQ9
        NrhcEt/fs3DFRZmFdZWzJBxMMtLZnQf6PBOR4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ukV5UUorbADKrpckHXmjPgmyFM+rMq3o
        JZIrOTsA0/Rfoiw00n6j+Zq8/SaKj5iditkxXMvuN24fzTjxDs5+U49xHeScXZbX
        x3sXBH5pVP5ZX/IVyXQaVhDzFaaDEGoz7vCTlyT4+J5XIIlXGM9iauWZ8+iZZMGu
        cY4z3AcRrb0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BD9F7C8A3B;
        Thu, 25 Mar 2021 20:45:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 235CDC8A3A;
        Thu, 25 Mar 2021 20:45:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeffrey Walton <noloader@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: not ok 47 - log.decorate configuration
References: <CAH8yC8mnaEpnw8xCKsyBg0XXsuwhiE10AFXFDBdH2AW0qUP3HQ@mail.gmail.com>
        <CAH8yC8nr-zhT-T2UK6q1cvFRzpi0fvyYuh8iydNscEse75X=gA@mail.gmail.com>
Date:   Thu, 25 Mar 2021 17:45:52 -0700
In-Reply-To: <CAH8yC8nr-zhT-T2UK6q1cvFRzpi0fvyYuh8iydNscEse75X=gA@mail.gmail.com>
        (Jeffrey Walton's message of "Thu, 25 Mar 2021 19:09:19 -0400")
Message-ID: <xmqqy2easpxb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9E2ED37C-8DCC-11EB-B3D4-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeffrey Walton <noloader@gmail.com> writes:

> On Thu, Mar 25, 2021 at 3:57 AM Jeffrey Walton <noloader@gmail.com> wrote:
>> ...
>
> Cancel this. It just tested OK a second time around.

Which may indicate that the test is flakey (e.g. timing dependent,
only reproducing when two commands in the test sequence are executed
across a second boundary, or something like that), which may be
worth fixing.

