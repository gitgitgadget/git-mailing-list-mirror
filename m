Return-Path: <SRS0=ToNR=6F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 205BAC54FCC
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 19:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8C31206E9
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 19:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="imjkCo4S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgDUTpy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Apr 2020 15:45:54 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51602 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgDUTpx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Apr 2020 15:45:53 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DBB75BA7FC;
        Tue, 21 Apr 2020 15:45:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ImeFD7koLS9gAiAlWVvsS9Wi4uo=; b=imjkCo
        4S6eVkX29wmwAuornMNMQRjtV56O+Tr44pNcgGXsDrJFAm3i/G8j01jFGzjT8Si1
        Y+fAem1qrRJ9R8cmZgiNvQJrCJUVMJfXJC75B8BIwqg8XWjRxOBKVkxTIOlGwWEo
        lnQyvWo4Dj4XpBg91N82JA0DLvakXW7NBGeSE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=F2ZsFiCeYdLTgxpRliNwDEyu4T/s+O8u
        sfx0Mh6NLuTAQ5snROkBtMBTC5/4nmtzoXB4E+cy8eB4Q4ebeUged6/KqpcqSS9N
        hPSKFFk/trofstgeHKZ3+A934cN8Xzr1Kp/JAair0U24at+D5/KliuJT3n4N1uCK
        82FSz/SFH0U=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D273BBA7FB;
        Tue, 21 Apr 2020 15:45:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1FFE0BA7FA;
        Tue, 21 Apr 2020 15:45:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net
Subject: Re: [PATCH v3 1/4] gitfaq: files in .gitignore are tracked
References: <20200421131223.29337-1-shouryashukla.oo@gmail.com>
        <20200421131223.29337-2-shouryashukla.oo@gmail.com>
Date:   Tue, 21 Apr 2020 12:45:47 -0700
In-Reply-To: <20200421131223.29337-2-shouryashukla.oo@gmail.com> (Shourya
        Shukla's message of "Tue, 21 Apr 2020 18:42:20 +0530")
Message-ID: <xmqq7dy8oc5w.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B354438C-8408-11EA-9E74-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shourya Shukla <shouryashukla.oo@gmail.com> writes:

> Add issue in 'Common Issues' section which addresses the problem of
> Git tracking files/paths mentioned in '.gitignore'.

I do not think this much text is warranted in this file.

The first part of Documentation/gitignore.txt *ought* to cover this
material and it does say "specifies intentionally untracked files"
and "already tracked byt Git are not affected".  Read that paragarph
twice, and then jump to the NOTES section it refers two and also
read that twice.  Then let's work on polishing these places if there
is anything unclear.  I think what we have there is clear enough.

And then trim the text we see here down.  The way the question is
phrased may be good as-is (I trust that you researched to make sure
that is how the question is most frequently phrased).  The answer
should be just "see gitignore(5)", or perhaps repeat the first
paragraph of gitignore(5) and then refer to the page, i.e. no more
than

    [[files-in-.gitignore-are-tracked]]
    I asked Git to ignore various files, yet they are still tracked::
            A `gitignore` file specifies intentionally untracked files
            that Git should ignore.  Files already tracked by Git are
            not affected.  See linkgit:gitignore[5] for details.

should be in the FAQ file.
