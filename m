Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC3CC83000
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 18:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E95172085B
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 18:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ETlGMpME"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728509AbgD1SPV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:15:21 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53352 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727827AbgD1SPU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Apr 2020 14:15:20 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F177AC036C;
        Tue, 28 Apr 2020 14:15:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Y5URMme5PKFn
        vFbqcahAWGnviFk=; b=ETlGMpMERdfw8n76ADAdLu9657eG/pfbxu8lhn8Awu1T
        t8FOdVHsCExnAMpPTTVx2eYePfvAmIJaIDgz+A4Bf6OopFY7KH+mTAV7/rvg20f9
        F51KoSgfa8OndCQerVFgVks43oVJCxcucZhBv+lJBG5CQYHQeAm80Jr8Fe+vXZc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=EUwPeb
        nTyCkzYSvHuKZ38eItssv/fT7KN7+tC9ppevYR3ZOWnWwHwx5bmwZb/HvTcUDTyS
        a9353eYlcgWu8vzBDuzv6Hs9DvMQX9SAEQ7ZHOyhuh0e4hW/OHsDeZofarMv1kAe
        oKYr6wj8x/bSJ7DKwnlOab5O39Dgdd0VD65Gk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E860DC036B;
        Tue, 28 Apr 2020 14:15:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 28039C036A;
        Tue, 28 Apr 2020 14:15:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, dirk@ed4u.de, sunshine@sunshineco.com,
        peff@peff.net, jrnieder@gmail.com
Subject: Re: [PATCH v4 1/4] credential-store: document the file format a bit more
References: <20200428104858.28573-1-carenas@gmail.com>
        <20200428105254.28658-1-carenas@gmail.com>
Date:   Tue, 28 Apr 2020 11:15:15 -0700
In-Reply-To: <20200428105254.28658-1-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Tue, 28 Apr 2020 03:52:51 -0700")
Message-ID: <xmqqlfmf32a4.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3684038C-897C-11EA-B31E-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

> From: Junio C Hamano <gitster@pobox.com>
>
> Reading a malformed credential URL line and silently ignoring it
> does not mean ...

I'd reuse the one I've already queued as 272281ef (credential-store:
document the file format a bit more, 2020-04-27) for this step.

Thanks.

-- >8 --
Subject: [PATCH] credential-store: document the file format a bit more

Reading a malformed credential URL line and silently ignoring it
does not mean that we support empty lines and/or "# commented" lines
forever.  We should document it to avoid confusion.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-credential-store.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/git-credential-store.txt b/Documentation/git-c=
redential-store.txt
index 693dd9d9d7..76b0798856 100644
--- a/Documentation/git-credential-store.txt
+++ b/Documentation/git-credential-store.txt
@@ -94,6 +94,10 @@ stored on its own line as a URL like:
 https://user:pass@example.com
 ------------------------------
=20
+No other kinds of lines (e.g. empty lines or comment lines) are
+allowed in the file, even though some may be silently ignored. Do
+not view or edit the file with editors.
+
 When Git needs authentication for a particular URL context,
 credential-store will consider that context a pattern to match against
 each entry in the credentials file.  If the protocol, hostname, and
--=20
2.26.2-266-ge870325ee8

