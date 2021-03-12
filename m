Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CEFDC433E0
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 23:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6627B64F89
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 23:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235863AbhCLXpm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Mar 2021 18:45:42 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61569 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235859AbhCLXpi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Mar 2021 18:45:38 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AC697AFEA5;
        Fri, 12 Mar 2021 18:45:37 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=9NGQMNdVUqz2
        5SoXtis2xfPQcXM=; b=Oyr9TitbSB94VhWthrewlayHptypv74NkHmzw1vhzwwE
        4T+lnBgiy+VEGopYZ+4EZCoev3YdRLLxdacOTFgruurUX+/PYN0OyaqvsSO+S0es
        fB3ngy4ae0v6dSk8kDxxw6lcRlOROHVOfTk7/GRR4Q6ta+cKPs6sXpiXPgD17gM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=moZ5hp
        UQ2/q8JDnUVOQhN3MpHwMkjEMYkpcpA3JOgX7RB4bw3I6NQG0qV0URgXkU5Miz79
        P4167US28nfjrnM7rsIYjQk/Q+lB5bfelxD809xEZfqPsjUUdCxkPcEsc+CpBbTs
        VZOqgz6/Q4Du6u0UrYKznupUA91zmu+BXc7ZE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A39C2AFEA3;
        Fri, 12 Mar 2021 18:45:37 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2EBC5AFEA2;
        Fri, 12 Mar 2021 18:45:37 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Andreas Schwab <schwab@linux-m68k.org>,
        Fabien Terrani <terranifabien@gmail.com>, git@vger.kernel.org
Subject: Re: remote.<name>.merge missing from the git-config man page?
References: <CAOuwed4HJLTgk48Fre5vGYjYanqD6hu8yZM73CpcAmF1ajiTnA@mail.gmail.com>
        <xmqqlfax7dya.fsf@gitster.c.googlers.com>
        <YEZwY0721KvQNkK+@nand.local> <87pn092yja.fsf@igel.home>
        <YEaI5JIobsbtBQO1@nand.local> <87lfax2xat.fsf@igel.home>
        <YEaM7ruZCvaQQbPI@nand.local> <87h7ll2wiz.fsf@igel.home>
        <YEaRw5x5hnh9RRyM@nand.local> <87a6rd2tp8.fsf@igel.home>
Date:   Fri, 12 Mar 2021 15:45:36 -0800
In-Reply-To: <87a6rd2tp8.fsf@igel.home> (Andreas Schwab's message of "Mon, 08
        Mar 2021 22:58:59 +0100")
Message-ID: <xmqq5z1w542n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0B893E8E-838D-11EB-943A-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andreas Schwab <schwab@linux-m68k.org> writes:

> On M=C3=A4r 08 2021, Taylor Blau wrote:
>
>> On Mon, Mar 08, 2021 at 09:57:56PM +0100, Andreas Schwab wrote:
>>> The configured upstream is the value of branch.<name>.merge, isn't it=
?
>>> That would be the name of a remote, not the name of a branch.
>>
>> Right; the '<name>' in 'branch.<name>.merge' is your local name for a
>> branch, but the value of that configuration is the remote's name.
>
> Sorry, I was misreading branch.<name>.merge as branch.<name>.remote.
> Now it makes all sense to me.

OK, so do we have a version that is good to go?

Thanks.

-- >8 --
From: Taylor Blau <me@ttaylorr.com>
Date: Mon, 8 Mar 2021 13:43:47 -0500
Subject: [PATCH] Documentation/git-push.txt: correct configuration typo

In the EXAMPLES section, git-push(1) says that 'git push origin' pushes
the current branch to the value of the 'remote.origin.merge'
configuration.

This wording (which dates back to b2ed944af7 (push: switch default from
"matching" to "simple", 2013-01-04)) is incorrect. There is no such
configuration as 'remote.<name>.merge'. This likely was originally
intended to read "branch.<name>.merge" instead.

Indeed, when 'push.default' is 'simple' (which is the default value, and
is applicable in this scenario per "without additional configuration"),
setup_push_upstream() dies if the branch's local name does not match
'branch.<name>.merge'.

Correct this long-standing typo to resolve some recent confusion on the
intended behavior of this example.

Reported-by: Adam Sharafeddine <adam.shrfdn@gmail.com>
Reported-by: Fabien Terrani <terranifabien@gmail.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

Notes (amlog):
    Message-Id: <YEZwY0721KvQNkK+@nand.local>

 Documentation/git-push.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index ab103c82cf..a953c7c387 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -600,7 +600,7 @@ EXAMPLES
=20
 `git push origin`::
 	Without additional configuration, pushes the current branch to
-	the configured upstream (`remote.origin.merge` configuration
+	the configured upstream (`branch.<name>.merge` configuration
 	variable) if it has the same name as the current branch, and
 	errors out without pushing otherwise.
 +
--=20
2.31.0-rc2-171-g89112de4ba

