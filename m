Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E2DC433DF
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 00:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD1752073E
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 00:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Y3zh+fjJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgHEAkf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 20:40:35 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52612 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbgHEAke (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Aug 2020 20:40:34 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 360A6DEF70;
        Tue,  4 Aug 2020 20:40:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=59q3x898nK/E
        09C6GQtxMG/fPNg=; b=Y3zh+fjJhOSTsPz4wV5JzzjX0/cudhL1TtiRYk6J6Ddd
        3nN1tcb4vqL4uo89SN/aXJEseC8WZh3DDJqveVyJyi14zg78YkM8VrmsknfixNSf
        4onC3MVPnER38LAGQoLKoB5l7OazlvVuXUXjL+uiiADFXd7YmH03HoQX1CL6YTw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=ZGZHOF
        LvpJnso0Ln0sF+GC3FaMGKrAvX7oQGLjuie93lhNOYuhdaBzCxqD53KM9J6RtaGH
        8j4aGkNpuDIxSFz48ZEw4tb+iIayu7INffEJLKYxrV46Yr3YbcG/bZSyKlYzQM1Y
        3f2OLb5s4roDj2Mc0IPCczquzx4ZT5eQiCrHs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2F590DEF6E;
        Tue,  4 Aug 2020 20:40:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 79A76DEF6D;
        Tue,  4 Aug 2020 20:40:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?16DXotedINeh15XXnNeV15HXmdemJ9eZ16c=?= 
        <inoamsol@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Why is AuthorDate displayed on git-blame?
References: <CAAWR3A9po-zMVFdQfDs6R5F_rf0UvSyfByLj-vYZiXLb8+j4Ug@mail.gmail.com>
Date:   Tue, 04 Aug 2020 17:40:26 -0700
In-Reply-To: <CAAWR3A9po-zMVFdQfDs6R5F_rf0UvSyfByLj-vYZiXLb8+j4Ug@mail.gmail.com>
        (=?utf-8?B?Iteg16LXnSDXodeV15zXldeR15nXpifXmdenIidz?= message of "Wed, 5
 Aug 2020 03:18:43 +0300")
Message-ID: <xmqq5z9yq611.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 426CFF5C-D6B4-11EA-8FA4-843F439F7C89-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=D7=A0=D7=A2=D7=9D =D7=A1=D7=95=D7=9C=D7=95=D7=91=D7=99=D7=A6'=D7=99=D7=A7=
  <inoamsol@gmail.com> writes:

> A feature branch having commits authored last week, but merged to the
> main branch just today. And to the sake of discussion, let's say that
> the branch has a bug.
>
> When someone encounters the bug on the main branch, he would probably
> want to know when it was introduced - the date when the bug started
> to affect him. However, git-blame only shows him when the bug was
> originally authored, in our case - *last-week*, which is confusing
> since the main branch was working just fine back then.
>
> So I wonder why was AuthorDate the date chosen to be displayed under
> git-blame?

Quite honestly, the left-hand side of "git blame" output is not all
that useful, as the usual workflow is to use "blame" to only to
identify a commit (or a set of commits) and from there, any detailed
information of problematic commits will be inspected with "git show"
or equivalent, so in that sense, "git blame -s" could be the most
useful output format.

It should be trivial to add an option to show the commit date
instead, so in that sense, the answer to the immediate question "why
author date?" is "just because we chose to show it; you are welcome
to send in a patch to add an option to show committer date". =20

However, your question has another ingredient that is much more
interesting.  If you are interested only at the level of changes to
the primary integration branch, showing either author or committer
date of the ultimately responsible individual commit that was
brought in by a merge of a topic branch to the integration branch is
not useful at all for your purpose.  You need to find out which
merge brought the change to the integraiton branch and you do not
care which individual commit on the side branch that was merged.

IOW, what you would want is a "git blame --first-parent".






