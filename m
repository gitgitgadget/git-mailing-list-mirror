Return-Path: <SRS0=Ny9l=7D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83AA4C433DF
	for <git@archiver.kernel.org>; Thu, 21 May 2020 22:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FFAC206F6
	for <git@archiver.kernel.org>; Thu, 21 May 2020 22:29:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NCLFJQzF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730525AbgEUW3X (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 May 2020 18:29:23 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63913 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730041AbgEUW3X (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 May 2020 18:29:23 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CE8EA52E51;
        Thu, 21 May 2020 18:29:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gQLM4wbSLWXZFo5xrJZ/c9FQ6uA=; b=NCLFJQ
        zFg8EuJXAfOhZAvg14cwsVexojQg0Wo40ZzX2yyarvi5rbbieTuZelWVLRFIkbLK
        wPrZf92zTWlCCnHG17FtmyTZA2b3Wep64KmHRZiamcRzuwupJLKFyCkSFKbEtRwF
        auGatYMmWk3TQjbl95+mlf8ZKh8TPEJxW7bpU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aAgKNvhKHklHBht1PBqwOMcH5aI1Y51O
        jeyO+7plYl5/O+Iea6w725ttDWmSdzF+HkSZlWBmZcupW9Yx/FGZ3Ppt5Xi9bFeC
        Hx2gW3/5vuRQe5tcrYpbPscqjtz7vr03kFGxrDcUBXfnBqKhyk/C05s8z2APyYgp
        mZGaTMPcrIY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C64CB52E50;
        Thu, 21 May 2020 18:29:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4F9B052E4F;
        Thu, 21 May 2020 18:29:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: How do Git on Linux users launch/read the user-manual?
References: <8142f64b-9b5e-3637-21a2-3671dd65a42e@iee.email>
        <xmqqtv0athz5.fsf@gitster.c.googlers.com>
        <6dd15666-1e3e-e9b2-d98b-396d58f241cd@iee.email>
        <xmqqpnaytb31.fsf@gitster.c.googlers.com>
        <ecac8516-e536-80e8-fc72-098406592fd5@iee.email>
        <xmqqzha1q6co.fsf@gitster.c.googlers.com>
Date:   Thu, 21 May 2020 15:29:19 -0700
In-Reply-To: <xmqqzha1q6co.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 21 May 2020 15:19:03 -0700")
Message-ID: <xmqqv9korkg0.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 83A645D8-9BB2-11EA-80C3-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Or are you saying that nobody on Linux uses the html format?  I
> should stop keeping the git-htmldocs.git repository up to date,
> if that is the case, but I suspect it is not.
> ...
> Or are you volunteering to update the mark-up (if necessary) so that
> user-manual would become part of "man" ("man git-user-manual",
> perhaps) suite?  That would be an excellent suggestion.

Having said that, I am not sure the way the material covered by the
user-manual is presented in is a good match for the manpage format
in the first place.  Don't modern manpage viewers, or generic pagers
that can display textual contents (which may happen to be the "man 1
git" output), or even a terminal enumrator that may happen to be
showing the output of such a pager, notice a URL and allow users to
activate on it (i.e. visit the HTML document the URL points at, by
opening the URL in an already-running browser, or in a new instance
of a browser)?  So perhaps a better solution for those who live in a
text terminal and view our documentation via "git help -m git" or
even "man git" would be to write a full URL to reach a version of
user manual available to the user, perhaps with file:/// URL "as
text" in the man output?  Then you do not have to reformat the user
manual in the manpage format or anything silly like that.

Hmm?
