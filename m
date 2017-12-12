Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C705A1F406
	for <e@80x24.org>; Tue, 12 Dec 2017 22:12:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752637AbdLLWMx (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Dec 2017 17:12:53 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55374 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752320AbdLLWMw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Dec 2017 17:12:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C7BEECA651;
        Tue, 12 Dec 2017 17:12:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=+pfK+LWtpFxnzNPIcs6XdkxN/U0=; b=Bmdy3TE3iYTEGP7hdiZH
        SG3PxNpLYceq/JqiEOdk8dRLuGGdj6oOOTdy5Iq6jhTLvCOxpBdLvRm+3w5E+oji
        w3MZKp3rLYdjT/ZBfX7VWQxanN7vXa0ab2YTsi7fwUrusZ1zFmQr3VHAbYjY9uvJ
        8cQmsO2n1EJVC2omR/hAhZk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=EGorjtD/FSPYpNYqQmy1dDxdDRdGz0lY0dZX1WuLNN4ZoK
        Ua8d2DQ0oOTf6FZX9SOT1zDoVRf23Ei1OSnHUyAHwmmRr1D4UixBbxJcO9sPBX9H
        s40mgc4ou2XT1xhOfoO8f6D2Jq/Gts28VGAaK0+UkhQ9ZseutzMfAUJktOU4M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BE64FCA650;
        Tue, 12 Dec 2017 17:12:51 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3747BCA64F;
        Tue, 12 Dec 2017 17:12:51 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Olga Telezhnaya <olyatelezhnaya@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH Outreachy v2 1/2] format: create pretty.h file
References: <01020160364a23d5-471a2fd0-9fff-4599-86f8-b2f37a4a0a84-000000@eu-west-1.amazonses.com>
        <0102016049efb7b4-b8dc7cff-5ddf-4692-ba1c-3551720ec28d-000000@eu-west-1.amazonses.com>
Date:   Tue, 12 Dec 2017 14:12:50 -0800
Message-ID: <xmqqh8svzjbx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 980A8760-DF89-11E7-99BA-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Olga Telezhnaya <olyatelezhnaya@gmail.com> writes:

>  builtin/notes.c       |  2 +-
>  builtin/reset.c       |  2 +-
>  builtin/show-branch.c |  2 +-
>  commit.h              | 81 +----------------------------------------------
>  pretty.h              | 87 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  revision.h            |  2 +-
>  6 files changed, 92 insertions(+), 84 deletions(-)
>  create mode 100644 pretty.h
>
> diff --git a/builtin/notes.c b/builtin/notes.c
> index 1a2c7d92ad7e7..7c8176164561b 100644
> --- a/builtin/notes.c
> +++ b/builtin/notes.c
> @@ -12,7 +12,7 @@
>  #include "builtin.h"
>  #include "notes.h"
>  #include "blob.h"
> -#include "commit.h"
> +#include "pretty.h"
>  #include "refs.h"
>  #include "exec_cmd.h"
>  #include "run-command.h"
> ...
> diff --git a/commit.h b/commit.h
> index 99a3fea68d3f6..8c68ca1a5a187 100644
> --- a/commit.h
> +++ b/commit.h
> @@ -7,6 +7,7 @@
>  #include "decorate.h"
>  #include "gpg-interface.h"
>  #include "string-list.h"
> +#include "pretty.h"

This is much nicer than what I imagined, which was to just add this
line here, move decls from commit.h to pretty.h, and do nothing
else, which would be the absolute safest thing from the point of
view of other topics in flight.  Separation of "pretty.h" would stay
to be an implementation detail of the "commit.h" file, where
everybody expects to find these decls.

Instead, this patch inspects each and every .c user of "commit.h"
and replaces its '#include' with the new one if it only uses things
declared in "pretty.h", which makes it very clear who have been
depending on what in the patch.  Those that include "commit.h"
because they need both the "what is a commit object" aspect and "how
to pretty print" aspect can keep using their original '#include' to
ease the transition.

Let's see how well this plays with other topics in flight---I had to
apply an evil merge to queue the previous one, if I recall right, as
a user of "commit.h" that did not use pretty-print (hence did not
get "pretty.h" with the previous round of this patch) gained use of
pretty-print function, or something like that.

Will queue.

Thanks.

 
