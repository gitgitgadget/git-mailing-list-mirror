Return-Path: <SRS0=iiTG=ZM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F578C432C0
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 02:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EF2722409
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 02:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TWKmD14w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfKTCvv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Nov 2019 21:51:51 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58571 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727243AbfKTCvv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 21:51:51 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A35A022A35;
        Tue, 19 Nov 2019 21:51:48 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=i0uVqS0KulE+
        kzmlgDrRZGqZpVk=; b=TWKmD14wHzdHwYH9mg7KVyLXfohwkVLGv9FrUjgqyWVJ
        kApY4GmJ/5LhHdAohiwWHdCf6ie9MXmduBLLcFNWhZIkZW0rUsI7UjPcEvrBZc8E
        I1ntKocWSRARKPzwuE6LHmL4/iGoukSV+6cktgSSaqSbbEGvd/q0aoBrOY2viWo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Tbkjq8
        /BHKnBHYcGv4Y+oaweJnF+uJEzVAnaogp9Sh0E3LQ1F/DXTipi/+cdx9JGflTVTo
        3vAPvGnG6CJWk6N73vJxupka6jjUKWC+YH4O3C6hULWgPGJSvBmWRH2cLWdYN6Gf
        olatf+dyD9ybJyFvtzX82QF3NdiZaLrY9YP8U=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9B97A22A34;
        Tue, 19 Nov 2019 21:51:48 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0AB9122A33;
        Tue, 19 Nov 2019 21:51:47 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de,
        Pratyush Yadav <me@yadavpratyush.com>
Subject: Re: [PATCH] doc: mention that 'git submodule update' fetches missing commits
References: <0102016a2274c90f-3dbf792f-5b0a-4da4-ada0-9a163a14e68d-000000@eu-west-1.amazonses.com>
        <0102016b72a55a7d-fb4ecdb7-9f2b-4204-b888-0000f209c3ff-000000@eu-west-1.amazonses.com>
        <xmqqsgs4nn6k.fsf@gitster-ct.c.googlers.com>
        <9B605234-8F49-4FEB-9156-22367E01B08B@gmail.com>
Date:   Wed, 20 Nov 2019 11:51:46 +0900
In-Reply-To: <9B605234-8F49-4FEB-9156-22367E01B08B@gmail.com> (Philippe
        Blain's message of "Mon, 18 Nov 2019 22:55:37 -0500")
Message-ID: <xmqq8sobdzul.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B20381DC-0B40-11EA-A13C-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain <levraiphilippeblain@gmail.com> writes:

> Since 'git pull=E2=80=99 will fetch submodules changes, and is usually
> run first, the commits are usually already there, but I think
> it=E2=80=99s worth mentioning that they will be fetched if they need to=
.
>
> I like thoroughness in software documentation :)=20

Where to draw the line between being thorough and being overly
verbose with trivial things is subjective, so I generally tend to
side with status quo.  But after re-reading the updated text, I do
not think it is so bad, so let's apply it with a bit of tweak.

The lines prefixed with "++" are with my tweak, "- " are your
original changes and " -" are what was in the version before your
patch (I CC'ed Pratyush to show this as an example of what I meant
by using combined diff to express an amended commit):

$ git diff -c HEAD HEAD@{1} HEAD^
diff --combined Documentation/git-submodule.txt
index 16c765cbfa,0ed5c24dc1..4beb569ae5
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@@ -133,8 -133,7 +133,8 @@@ update [--init] [--remote] [-N|--no-fet
  +
  --
  Update the registered submodules to match what the superproject
- expects by cloning missing submodules, fetching missing submodule commi=
ts
- and updating the working tree of
 -expects by cloning missing submodules and updating the working tree of
++expects by cloning missing submodules, fetching missing commits
++in submodules and updating the working tree of
  the submodules. The "updating" can be done in several ways depending
  on command line options and the value of `submodule.<name>.update`
  configuration variable. The command line option takes precedence over
