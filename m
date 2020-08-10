Return-Path: <SRS0=S9iH=BU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 110AEC433DF
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 15:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3E572078E
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 15:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BCtQcUsZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbgHJPp5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Aug 2020 11:45:57 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63587 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgHJPp4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Aug 2020 11:45:56 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B2D10853CE;
        Mon, 10 Aug 2020 11:45:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Uxey+D7Rwwhk8sAbrzMblqgqHxY=; b=BCtQcU
        sZMP4letoMFXy8REc5DbtN2nEtYPElJuR7N6O4Px5sCZ2QWNiAUnfWHDHj4P3s7+
        kl1gVOS/2XajqQ/Z+/mXM8E6KuF7cYAVyUTU32kUUolrg/t62H7MrUZw/Kib6YfL
        rEmbjWb8cnm9b8OPMigKgCutIqV70TKVeeyvk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Wl710Kcc9sr/A6JEEjVFgUCo0K9RMk6K
        RC7Z56egFXnXkt2V6p9rhC1NpsNNEvyMFtIyS0dTTJYlSTB26AOwNtGQ9K/fK58c
        HOZ4owOgl5FzGQaTEI+8GVuZ4OncoAxgAKgcSAcgGD92vCcQRabzTwEtY1k+UPl0
        tt3qZtrj/Y0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AAE26853CD;
        Mon, 10 Aug 2020 11:45:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1E9F0853CA;
        Mon, 10 Aug 2020 11:45:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Git List Mailing <git@vger.kernel.org>
Subject: Re: Avoiding 'master' nomenclature
References: <CAHk-=wgutLH=mPdJkLU_E6gO4q0FcG+=EEQJVVQeb+OxG9CfgQ@mail.gmail.com>
        <xmqqime69jfc.fsf@gitster.c.googlers.com>
        <CAHk-=wisOOrfEvab9S417MnPSY8dVkbDOKa6ccdi1Bg3X1PMaw@mail.gmail.com>
        <CAHk-=wi2dsROeg=mij5C8O=UBVZGEpOUp=Bn-arQ7i+Wscynnw@mail.gmail.com>
        <20200729205846.GA2992025@coredump.intra.peff.net>
        <xmqqv9i6814y.fsf@gitster.c.googlers.com>
        <xmqqlfj27x7q.fsf@gitster.c.googlers.com>
        <xmqq5za596uo.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2008101349570.50@tvgsbejvaqbjf.bet>
Date:   Mon, 10 Aug 2020 08:45:53 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2008101349570.50@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Mon, 10 Aug 2020 13:53:58 +0200 (CEST)")
Message-ID: <xmqqo8nicxn2.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 93176A26-DB20-11EA-A380-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Looks good to me, and apart from the config key (for which I also don't
> have a better suggestion), this looks pretty much how I would have done it
> (but refrained from doing because I really wanted the patch series to be
> part of v2.28.0).

Yes, my fault.  What you originally had was "we no longer special
case 'master', we special case init.default instead", and after I
responded with "why special case anything?  everybody is equal ;-)"
we ended up marking merges to 'master' as such in the latest
release.

The patch you are responding to is much more in line with the way in
which we dealt with the special casing of 'master' in the
fast-export anonymization in the latest release, and I am reasonably
happy with it.  Until we need to worry about the "do we need to keep
track of which branch is the 'primary' one in this repository
automatically?" issue sometime later, that is.

> TBH I expected some discussion along the line "Shouldn't this be an
> opt-in, with the initial default saying 'every branch except `master`'?",
> but that seems not to have taken place.

I do not quite get it.  Without any explicit configuration, every
branch except 'master' is shown, just like we've done for the past
15 years.  You can opt into hiding other names instead of 'master',
hiding nothing, or hiding everything.

Thanks.
