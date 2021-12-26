Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 778EEC433F5
	for <git@archiver.kernel.org>; Sun, 26 Dec 2021 00:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233140AbhLZAbO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Dec 2021 19:31:14 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51626 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbhLZAbO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Dec 2021 19:31:14 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CA56216BE0A;
        Sat, 25 Dec 2021 19:31:13 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=hAJGhmOYXKVC
        wYEKi+3WcnxsYeyNNdcUzYA4Z5FPlWg=; b=Fcy/f4o+uiC7T5ay73caxVv6ine7
        RRg9sUfVV2mf6ClHdakhLV7wOvWEjQI8wTzPwd2FXYn/QUQhOWo1EiRg4D9evXvr
        N3wGe9SIPXrWaBfyZ675+QzqzJKa7e+Lx+nOHMqzQHrTajKn3q39JeJAAZ7KEQh+
        mWE62NsL/zCDY0I=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C299E16BE08;
        Sat, 25 Dec 2021 19:31:13 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2DBC316BE07;
        Sat, 25 Dec 2021 19:31:10 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        John Cai <johncai86@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH v5 07/10] cat-file: fix remaining usage bugs
References: <cover-v4-00.10-00000000000-20211208T123151Z-avarab@gmail.com>
        <cover-v5-00.10-00000000000-20211222T041050Z-avarab@gmail.com>
        <patch-v5-07.10-e6ea403efe0-20211222T041050Z-avarab@gmail.com>
Date:   Sat, 25 Dec 2021 16:31:08 -0800
In-Reply-To: <patch-v5-07.10-e6ea403efe0-20211222T041050Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 22 Dec
 2021 05:13:00
        +0100")
Message-ID: <xmqqr1a04377.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1F7EF58A-65E3-11EC-BC03-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> With the migration of --batch-all-objects to OPT_CMDMODE() in the
> preceding commit one bug with combining it and other OPT_CMDMODE()
> options was solved, but we were still left with e.g. --buffer silently
> being discarded when not in batch mode.
> ...

I've read the patches again myself, as I didn't see much comments to
the recent rounds of the series on the list.  Here are a few fix-ups
to style violations that made my reading hiccup while doing so,
introduced by this step.

----- >8 --------- >8 --------- >8 --------- >8 --------- >8 -----
Subject: [PATCH] fixup! cat-file: fix remaining usage bugs

Style fix to have SP on both sides of

    shell_function () {
	... body of the function ...

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t1006-cat-file.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 123801cfe2..aa859271d6 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -34,7 +34,7 @@ do
 	'
 done
=20
-test_missing_usage() {
+test_missing_usage () {
 	test_expect_code 129 "$@" 2>err &&
 	grep -E "^fatal:.*required" err
 }
@@ -66,7 +66,7 @@ do
 	done
 done
=20
-test_too_many_arguments() {
+test_too_many_arguments () {
 	test_expect_code 129 "$@" 2>err &&
 	grep -E "^fatal: too many arguments$" err
 }
--=20
2.34.1-568-g69e9fd72b5



