Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49CF22035F
	for <e@80x24.org>; Fri, 28 Oct 2016 13:03:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759993AbcJ1NDk (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 09:03:40 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52481 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1758284AbcJ1NDj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 09:03:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EC1704495D;
        Fri, 28 Oct 2016 09:03:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hj21Zq0FufnKFDClkxzzAxA31Hc=; b=dTmb2Z
        wOiBoaK9jjZYtAw9GjhLnfC1rL0iWDmgwB1TqVS9tjBGMR5AvuzK6X4QQoTFNC7H
        Xf1pbvgnMZJdIJPXPJVkQWvJXpwdGoMwmDzxvn+n0kD76blpLVqQJ+HRrYa8leHW
        QIARGaYrAUYt01WcFvJjOLDNq2iv67WMwS404=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bDtpP736msW7bYWFTg6kD6s+IFe9vIm7
        8wraDJJ41b7a/LA9WwCD3tG7HnSNYxHpnbwXccuRjpywvWAW3pBlS1ooYyF5PvrJ
        0p5hpAMk9fJTrf64KehgnZ0GfPHZUpLVtj/Ei+0Tir/x1yIa8pik9IyRX1/iej6l
        jQBXWZF4BBY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E37984495C;
        Fri, 28 Oct 2016 09:03:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5DB744495B;
        Fri, 28 Oct 2016 09:03:36 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Henrik Ahlgren <pablo@seestieto.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Fix typo in 2.11.0 RelNotes
References: <1477651639-11529-1-git-send-email-pablo@seestieto.com>
Date:   Fri, 28 Oct 2016 06:03:34 -0700
In-Reply-To: <1477651639-11529-1-git-send-email-pablo@seestieto.com> (Henrik
        Ahlgren's message of "Fri, 28 Oct 2016 13:47:19 +0300")
Message-ID: <xmqqoa2439sp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F00EEF6E-9D0E-11E6-921C-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Henrik Ahlgren <pablo@seestieto.com> writes:

> Signed-off-by: Henrik Ahlgren <pablo@seestieto.com>
> ---
>  Documentation/RelNotes/2.11.0.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/RelNotes/2.11.0.txt b/Documentation/RelNotes/2.11.0.txt
> index 3590620..1d3a07d 100644
> --- a/Documentation/RelNotes/2.11.0.txt
> +++ b/Documentation/RelNotes/2.11.0.txt
> @@ -5,7 +5,7 @@ Backward compatibility notes.
>  
>   * An empty string used as a pathspec element has always meant
>     'everything matches', but it is too easy to write a script that
> -   finds a path to remove in $path and run 'git rm "$paht"', which
> +   finds a path to remove in $path and run 'git rm "$path"', which
>     ends up removing everything.  This release starts warning about the
>     use of an empty string that is used for 'everything matches' and
>     asks users to use a more explicit '.' for that instead.

What you spotted is certainly a typo, but it is a deliberate one
that must not be fixed like this.  "..., but it is too easy to ..."
is illustrating a scenario in which an empty string is accidentally
given to "git rm" as a pathspec by mistake, and the example it uses
is for the user to prepare a path to be removed in variable $path,
and referring to it as its typoed $paht by mistake.  Fixing that typo
in this paragraph defeats the whole point of the example.

But the fact that you spotted the typo (which is good; we want the
deliberate typo in the example to be clearly visible) and thought
that the writer of the paragraph must have meant a non-typoed
version there (which is bad) indicates that the paragraph needs
improvement to save readers from making the same mis-reading as you
did.

If the original text were like the following, would it have been
clear enough that prevented you from sending your patch?

 * An empty string used as a pathspec element has always meant
   'everything matches', but it is too easy to write a script that
   finds a path to remove in $path and run 'git rm "$paht"' by 
   mistake (when the user meant to give "$path"), which ends up
   removing everything.  This release starts warning about the
   use of an empty string that is used for 'everything matches' and
   asks users to use a more explicit '.' for that instead.

Thanks.
