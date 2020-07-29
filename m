Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F9CC433DF
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 20:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D17A206D4
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 20:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JwBBWB1o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgG2Ukm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 16:40:42 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62627 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgG2Ukm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jul 2020 16:40:42 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0444A80A37;
        Wed, 29 Jul 2020 16:40:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=P4GxlODFwnfmPz/Y4yclmkTjECY=; b=JwBBWB
        1ogTfvYy1Djcnfff2rlfUbAT8GrzJDdnRCCRkPTsP84NzOxXwkg6N1TAhYqS1xzR
        j1nbZIqo2B5Pa1OZAzxCIOaz2xU/j4dXQFiFqmWuyzOK9Q5tBlVKjpzhGTVHMY/U
        AhJPRhLaguiCyF3ZOHEgFzHtoMXyA1CSmhM6A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SB7YDBM7XWqhtiagjqUZ2F2AqzOs7BLO
        BLT5wt3mFpK1dsv8rIviF1jx5YtlXGnHykNZYeEypnc4EpJtS6yjgDssuqqGqAzw
        4a2f3dgjdL8MBtr1K1x4VWb96zb9yf7T2GLicg0zWhh2H1Y9vhQRK/sBmdMm9UBS
        r5DXNOFXowo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EE3E380A36;
        Wed, 29 Jul 2020 16:40:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6D64680A35;
        Wed, 29 Jul 2020 16:40:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List Mailing <git@vger.kernel.org>
Subject: Re: Avoiding 'master' nomenclature
References: <CAHk-=wgutLH=mPdJkLU_E6gO4q0FcG+=EEQJVVQeb+OxG9CfgQ@mail.gmail.com>
        <xmqqime69jfc.fsf@gitster.c.googlers.com>
        <CAHk-=wisOOrfEvab9S417MnPSY8dVkbDOKa6ccdi1Bg3X1PMaw@mail.gmail.com>
Date:   Wed, 29 Jul 2020 13:40:38 -0700
In-Reply-To: <CAHk-=wisOOrfEvab9S417MnPSY8dVkbDOKa6ccdi1Bg3X1PMaw@mail.gmail.com>
        (Linus Torvalds's message of "Wed, 29 Jul 2020 13:23:33 -0700")
Message-ID: <xmqqa6zi9hrt.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C367C32C-D1DB-11EA-80CC-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Even if you don't want to treat "master" specially, there's two actual
> reasons to do so:
>
>  (a) the technical one: it's the old default one in a lot of existing
> repositories, so if there is no defaultBranchName, it effectively
> _was_ that
>
>  (b) the non-technical one: if the aim is to get rid of "master"
> terminology, THAT IS EXACTLY what the code did before it was removed.
>
> So really. Both from a technical _and_ a terminology angle, that
> commit was just wrong.

Your "if the aim is" is curious---the change is not particularly
aimed for that.  As far as I understand it, it was also to retire
the "one single thing is special among others" mentality (which by
the way I find somewhat offending).

The original did two things wrong, i.e. treated one thing specially,
and designated 'master' which has been declared a dirty word as that
special thing.  Killing these two wrongs with one stone does not
feel so stupid.
