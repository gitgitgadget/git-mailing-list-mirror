Return-Path: <SRS0=nsHh=4C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 241FFC352A3
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 01:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C05FB2073A
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 01:41:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FUVIMhof"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbgBNBlW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Feb 2020 20:41:22 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51242 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728017AbgBNBlW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Feb 2020 20:41:22 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 47F22568DB;
        Thu, 13 Feb 2020 20:41:22 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=woMs1JgRRmPgcltFgEq9QmzEDlA=; b=FUVIMh
        ofCRkDf9qSK7KqpRrXJ55VhfEDx+IKMTC1FZTGJjF8kDcW0VUmvIdOX7tZtIiijd
        8TQwBWdq/VpTL13xEGUHaCKqSOI32ioA6iyVgpKlbHs+sqIhw5W9bsDp9j+MYIEG
        okALqeC7mkPtcvaP7Zdw84jlxrbQD4wJGhqm0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Tz723TQYH4EL6AJmnOh6KoLNL8DOi+vP
        b9xP9a8MdB/L4izmiaifnnb3cNLJZH5D3jHVNZOsa4JHyihmGwbc45hO6XBaRIly
        zihCEhzKsNJY80R3iBMRAY5SwJVq5nw/Gtv0uBnogPpSyyZTl3ip+OgsSZiIFC9s
        htVyJ1YXeak=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 406C2568DA;
        Thu, 13 Feb 2020 20:41:22 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 82EFD568D9;
        Thu, 13 Feb 2020 20:41:20 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Robear Selwans <rwagih.rw@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC][GSOC] Microproject Suggestion
References: <CALH1-Xr_pK02j6_51EnZN=ZrSz6dijt9tn0ANJ21331GzAmBdQ@mail.gmail.com>
Date:   Thu, 13 Feb 2020 17:41:18 -0800
In-Reply-To: <CALH1-Xr_pK02j6_51EnZN=ZrSz6dijt9tn0ANJ21331GzAmBdQ@mail.gmail.com>
        (Robear Selwans's message of "Fri, 14 Feb 2020 02:52:00 +0200")
Message-ID: <xmqqy2t6osht.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 19BF7542-4ECB-11EA-8129-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Robear Selwans <rwagih.rw@gmail.com> writes:

> Hi, so it came to my attention that GSOC applicants will need to
> submit a microproject to be considered. I was thinking about ...
> So does that sound like a good idea?

Not really.

The purpose of a GSoC microproject is not about producing useful end
user product.  It is to learn the end-to-end flow, starting from the
initial submission, interacting with the reviewers to polish the
patch, to reach the final version.  For that purpose, we'd prefer a
bite-sized project (and that is why it is called "micro")---my
personal gut-feeling yardstick is that anything that takes more than
30 minutes to finish by an experienced Git developer to come up with
a perfect model answer is too big.

As a real patch for you to get your toes into Git development,
outside the scope of GSoC, I think it would be a good sized first
patch.  It is a bit too big for a microproject, and it is a bit too
small for a main GSoC project.

For the feature itself, I'd just do

    $ git reset --soft HEAD~$n ;# rewind
    $ git commit --amend

to open an editor, and then to the editor to edit the log message,
I'd tell it to insert "git log ..@{1}" to the edit buffer to help me
formulate the log message for the consolidated change, so I do not
personally see me using it, even if it were available.

Thanks.
