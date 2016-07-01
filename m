Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C739E2018A
	for <e@80x24.org>; Fri,  1 Jul 2016 21:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752544AbcGAVQi (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 17:16:38 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61383 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752142AbcGAVQh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 17:16:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 661BC2631B;
	Fri,  1 Jul 2016 17:16:36 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UHHyEggCPVWNZZXz7IROM5gDqJE=; b=PVLOaw
	iDE2oFNXdoboGO9a5mDkStKw77XCOlDlB9Oabovlo8swoXg/6oEspi5RkBRnKUan
	YpekiQGiYbphpSP7XlDER7yruUeKH35H8PhxRtg3CK/2t5IZEBlUgh9lIC8d+Xra
	pOxTcyRgFaB9XnoYQ7Tg/hLV9a9L6KsvbA0yc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KM7XdFH571rcZohDEKYNTTAjPpXNbVkb
	+eLyI7TYN51nhOUP1XIyVRg4mSGfwOdWtLCoQ4heWpHp/uvfeJAiskuXUPvFb5y/
	pEFk3SHzBfRZcm19WZJfLir62dNfMKiApbMY6CCEvKYQOsPAmCMO8YE1o1Xa51/B
	xFEMpUBCXaw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5D26F2631A;
	Fri,  1 Jul 2016 17:16:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D7C4726319;
	Fri,  1 Jul 2016 17:16:35 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Philip Oakley <philipoakley@iee.org>
Cc:	GitList <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 4/4] doc: clarify that `^r1` will exclude `r1` itself
References: <20160625164654.5192-1-philipoakley@iee.org>
	<20160630202509.4472-1-philipoakley@iee.org>
	<20160630202509.4472-5-philipoakley@iee.org>
Date:	Fri, 01 Jul 2016 14:16:33 -0700
In-Reply-To: <20160630202509.4472-5-philipoakley@iee.org> (Philip Oakley's
	message of "Thu, 30 Jun 2016 21:25:09 +0100")
Message-ID: <xmqqk2h5vz2m.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 17A7D5A4-3FD1-11E6-ABFF-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Philip Oakley <philipoakley@iee.org> writes:

> Signed-off-by: Philip Oakley <philipoakley@iee.org>
> ---
>  Documentation/revisions.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
> index 131060c..87be9c4 100644
> --- a/Documentation/revisions.txt
> +++ b/Documentation/revisions.txt
> @@ -246,7 +246,7 @@ The '{caret}' (caret) notation
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  To exclude commits reachable from a commit, a prefix '{caret}'
>  notation is used.  E.g. '{caret}r1 r2' means commits reachable
> -from 'r2' but exclude the ones reachable from 'r1'.
> +from 'r2' but exclude 'r1' and those reachable from 'r1'.

Well, if you have to spell that out, you'd want to spell out r2 side
too, no?  That is,

	... means commits 'r2' and those reachable from 'r2', but
	exclude 'r1' and those reachable from 'r1'.

The (sub)document has 16 grep hits of "reach(able)"; a reader who
needs this clarification would need all of them clarified, but
repeating "X and those reachable from X" everywhere is not a good
way to do so.  Perhaps a separate sentence upfront that defines what
"reachable" means is a better solution, no?

Something like the attached patch may be a good starting point, but
this leaves two forward-references of reachable in the part that
describes ways to specify a single object (e.g. find a commit with
this string that is reachable by X) we may need to address, perhaps
by adding "(see below)" or something.


 Documentation/revisions.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index 19314e3..34642b9 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -242,6 +242,10 @@ specifying a single revision with the notation described in the
 previous section means the set of commits reachable from that
 commit, following the commit ancestry chain.
 
+A commit Y is said to be reachable from commit X if Y is X, or if Y
+is reachable from any any of X's parents.  We also say "Y is an
+ancestor of X" in such a case.
+
 To exclude commits reachable from a commit, a prefix '{caret}'
 notation is used.  E.g. '{caret}r1 r2' means commits reachable
 from 'r2' but exclude the ones reachable from 'r1'.


