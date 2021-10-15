Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 474FCC433EF
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 01:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22ECF61090
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 01:28:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbhJOB33 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Oct 2021 21:29:29 -0400
Received: from defaultvalue.org ([45.33.119.55]:55982 "EHLO defaultvalue.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229587AbhJOB32 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Oct 2021 21:29:28 -0400
Received: from trouble.defaultvalue.org (localhost [127.0.0.1])
        (Authenticated sender: rlb@defaultvalue.org)
        by defaultvalue.org (Postfix) with ESMTPSA id E4A1E2043B;
        Thu, 14 Oct 2021 20:27:22 -0500 (CDT)
Received: by trouble.defaultvalue.org (Postfix, from userid 1000)
        id 685AF14E081; Thu, 14 Oct 2021 20:27:22 -0500 (CDT)
From:   Rob Browning <rlb@defaultvalue.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH] signature-format.txt: explain and illustrate multi-line
 headers
In-Reply-To: <xmqq5ytzcyr6.fsf@gitster.g>
References: <20211009163338.2175170-1-rlb@defaultvalue.org>
 <YWRpPw4eTwTmgVvC@coredump.intra.peff.net> <xmqq4k9ncopr.fsf@gitster.g>
 <YWTuAOjqK6fy9ZRT@coredump.intra.peff.net> <xmqqzgre5glb.fsf@gitster.g>
 <xmqqtuhlisqe.fsf_-_@gitster.g> <87zgrcgpez.fsf@trouble.defaultvalue.org>
 <xmqq5ytzcyr6.fsf@gitster.g>
Date:   Thu, 14 Oct 2021 20:27:22 -0500
Message-ID: <87v91zgjr9.fsf@trouble.defaultvalue.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> With so little similarity, there is no reason for us to mimick their
> "folding" rule.

Agreed.  I'd just lazily guessed it might be 822 (was also thinking of
Debian package headers), but certainly shouldn't have glossed over the
missing colon (for example) -- might be worth making sure the rules
described are covered in the technical docs, if they're not already, and
then perhaps refer to them in the section we're adjusting.

> We limit to the SP and not LWP for another reason.  Because the
> exact byte sequence in the object (including the header part of
> "commit" and "tag" objects) determines the name of the object

Ahh, right, of course.

> we would needlessly create many variants of the "same" commit, which
> is not ideal.

Indeed.

Thanks
-- 
Rob Browning
rlb @defaultvalue.org and @debian.org
GPG as of 2011-07-10 E6A9 DA3C C9FD 1FF8 C676 D2C4 C0F0 39E9 ED1B 597A
GPG as of 2002-11-03 14DD 432F AE39 534D B592 F9A0 25C8 D377 8C7E 73A4
