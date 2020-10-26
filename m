Return-Path: <SRS0=PD7l=EB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43619C55178
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 23:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 034E720747
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 23:32:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RNTCQ2gN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406419AbgJZXce (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 19:32:34 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58474 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406403AbgJZXce (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Oct 2020 19:32:34 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E819DE595A;
        Mon, 26 Oct 2020 19:32:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SJp884EqH+PAHYhX3xJEOT6yirU=; b=RNTCQ2
        gNIzM55E3/yrlOw/h++Q3WB5tJiXPdNlvscxKB27YVO0GXqxAImHM53eWCAs3JdF
        HM0JgzAKJ1GXkPM+rYGVfUocpcymYptbVHqtcyY5KFduZF0MuwhiE2M2JR+pUcwq
        B40uIDytbQu5Pp11K61wKbC0L87T2dJcGKPq4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QbwYpYTEhs4pcWxtacbaYuQ/kuIFDLmM
        AYM/OOfnMuNsAx0oeqbbEWdaecNGcuiLKkpfx2KQs2XKzW9jI3s/ScZPGeOu8ToC
        EYoWWjHo+3DKQx4XLWTC34Qza/Rbinz2FCnKzIBRvos8hWkgOK2X524s+aGKo6vb
        yOc5h7vvuBY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E10F3E5957;
        Mon, 26 Oct 2020 19:32:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 30975E5956;
        Mon, 26 Oct 2020 19:32:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Philip Oakley <philipoakley@iee.email>, git@vger.kernel.org,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] documentation symlink restrictions for .git* files
References: <20201005071751.GA2290770@coredump.intra.peff.net>
        <20201005121609.GA2907272@coredump.intra.peff.net>
        <6c0a0036-e217-a334-2a74-dd59a4592c1f@iee.email>
        <20201023081711.GB4012156@coredump.intra.peff.net>
        <8bb54778-507c-2e3f-d35a-5e32edb8bee7@iee.email>
        <20201026225300.GA23128@coredump.intra.peff.net>
Date:   Mon, 26 Oct 2020 16:32:27 -0700
In-Reply-To: <20201026225300.GA23128@coredump.intra.peff.net> (Jeff King's
        message of "Mon, 26 Oct 2020 18:53:00 -0400")
Message-ID: <xmqqo8kod0ms.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 834325CC-17E3-11EB-BCC0-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Definitely a "NOTES" section should go in that spot, but possibly the
> text should be in the "DESCRIPTION" section. I was worried about
> cluttering that early part with a detail that most people wouldn't care
> too much about.
>
> Looks like my patch is in 'next'; do you want to propose a patch moving
> it around on top?

It probably is possible to tweak the introductory text this way
without being unnecessarily loud and keep the NOTES section where it
is.

I personally found that the placement of new text was OK, but this
may be overly compensated by my tendency to discount things that we
have discussed recently, which our mind often consider (only for
relative a short moment) as more important than they are, relative
to other things in the same document.

 Documentation/gitattributes.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git i/Documentation/gitattributes.txt w/Documentation/gitattributes.txt
index 2d0a03715b..fd2de7344a 100644
--- i/Documentation/gitattributes.txt
+++ w/Documentation/gitattributes.txt
@@ -13,8 +13,8 @@ $GIT_DIR/info/attributes, .gitattributes
 DESCRIPTION
 -----------
 
-A `gitattributes` file is a simple text file that gives
-`attributes` to pathnames.
+A `gitattributes` file is a simple text file (it cannot be a
+symbolic link to anything) that gives `attributes` to pathnames.
 
 Each line in `gitattributes` file is of form:
 
