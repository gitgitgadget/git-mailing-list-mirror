Return-Path: <SRS0=w+PN=DX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34904C43457
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 21:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3F7922202
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 21:25:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="E8u9Dpe2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411127AbgJPVZO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Oct 2020 17:25:14 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53492 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411179AbgJPVV5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Oct 2020 17:21:57 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CFDF08229B;
        Fri, 16 Oct 2020 17:21:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qpewZDXViu0UdMvDMmdg+JldkeE=; b=E8u9Dp
        e2TfAnEP8EMru48ZR8468H7X7oFWXY0TqD9PwcMSAIqZOWLKwhV8IbqxaAjLL8gL
        ZUn/Lve3ZCAPe3B869kVB7Fv5SwlDKLd36uiadZLuBCG1KA6l3C39CaTL3cUi7m3
        ZsC/OOid6vgW8KtXrUJcC/xSBSZ3C9t3WcBxE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cDWmlfYei8Q5wkwJPXCKxY2vWtgu0UJm
        JBck+QOP4BwhwQ/F1aj8Sy2ur8FMWPM5I2XGGcWZ6njEakn71dtF4osk6l8LHS4X
        clQJXjyd68NH4dI3xO7SGoL7eLtbP0ZKGzWfkoLtzwBPn1XVDBAkqKEvSn0SmjgS
        fs/7U4F4sA4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C71DB8229A;
        Fri, 16 Oct 2020 17:21:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 48EAE82299;
        Fri, 16 Oct 2020 17:21:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] MyFirstContribution: clarify asciidoc dependency
References: <20201016205232.2546562-1-emilyshaffer@google.com>
        <20201016205232.2546562-2-emilyshaffer@google.com>
Date:   Fri, 16 Oct 2020 14:21:53 -0700
In-Reply-To: <20201016205232.2546562-2-emilyshaffer@google.com> (Emily
        Shaffer's message of "Fri, 16 Oct 2020 13:52:31 -0700")
Message-ID: <xmqqo8l1amtq.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9D2AAC4E-0FF5-11EB-AE1F-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> Per IRC:
>
> [19:52] <lkmandy> With respect to the MyFirstContribution tutorial, I
> will like to suggest this - Under the section "Adding Documentation",
> just before the "make all doc" command, it will be really helpful to
> prompt a user to check if they have the asciidoc package installed, if
> they don't, the command should be provided or they can just be pointed
> to install it
>
> So, let's move the note about the dependency to before the build command
> blockquote.

Suggesting asciidoc alone may not be all that helpful, or unless it
drags xmlto, docbook and friends as its dependencies, and the
details of that depends on distro packaging.

As this is only moving the existing note around in the
documentation, it is not making things any worse, so I am OK to take
the patch as-is, but if somebody (it is fine if it were done by you,
Emily) can double check "apt-get install asciidoc" on a vanilla box
does bring in what we need, that would be quite good.  FWIW, we
write in our top-level INSTALL file that we require asciidox/xmlto
toolchain (the latter is needed if you format for manpage, i.e. if
you do "git subcmd --help").

Thanks
