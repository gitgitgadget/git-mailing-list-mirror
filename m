Return-Path: <SRS0=aR3Y=3R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E3EC2D0DB
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 22:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EC9221739
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 22:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mhob2TMA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgA1WLL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jan 2020 17:11:11 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65197 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbgA1WLL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jan 2020 17:11:11 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5CC6790032;
        Tue, 28 Jan 2020 17:11:06 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7Xz624Q+TnxxzwF/9/RIjX3uGeU=; b=mhob2T
        MAqYu01UuIw6qM6J//HaiK6Lpb3M7YzonBlj541S+vOIMXY9J+PoWee+Y72XUjoA
        p8yp4TTEV+AZYyvwTDDZhIYtKK9YPGeupy0Q2M3sWyURVedhwAtbeq8DbdvpvHbK
        lAuaw/i3JPt2p8ms5Ky/0TvT/SiEC4qhwl62E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Xv0i2I4uX01elYInOCuPneTM3pdvtKvq
        xxi1Tnn6ivyo69OV18nTLLljPhQESMKctfcZfnRnQ2BGTBPeLq0jhBGojZZi404v
        CkkJ/RNrGc9o3k/tor1AZrEwP+u/2058GvYdvpMAXegPBa0O/knw9PNAMhC8ThZw
        I67QupsDWLs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 544AE90031;
        Tue, 28 Jan 2020 17:11:06 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 81ECD90030;
        Tue, 28 Jan 2020 17:11:03 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bert Wesarg <bert.wesarg@googlemail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH] doc: clarify "explicitly given" in push.default
References: <1113893dd36a1e8cf72331dd01f36206b44f45ad.1580116685.git.bert.wesarg@googlemail.com>
Date:   Tue, 28 Jan 2020 14:11:01 -0800
In-Reply-To: <1113893dd36a1e8cf72331dd01f36206b44f45ad.1580116685.git.bert.wesarg@googlemail.com>
        (Bert Wesarg's message of "Mon, 27 Jan 2020 10:25:03 +0100")
Message-ID: <xmqqr1zj6xl6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 12D16400-421B-11EA-9143-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bert Wesarg <bert.wesarg@googlemail.com> writes:

> The documentation for push.default mentions that it is used if no
> refspec is "explicitly given". Let's clarify that giving a refspec on
> the command-line _or_ in the config will override it.
>
> Signed-off-by: Jeff King <peff@peff.net>
> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
> ---
>  Documentation/config/push.txt | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> Cc: peff@peff.net
>
> diff --git a/Documentation/config/push.txt b/Documentation/config/push.txt
> index 0a0e000569..d560362c9a 100644
> --- a/Documentation/config/push.txt
> +++ b/Documentation/config/push.txt
> @@ -1,9 +1,11 @@
>  push.default::
>  	Defines the action `git push` should take if no refspec is
> -	explicitly given.  Different values are well-suited for
> -	specific workflows; for instance, in a purely central workflow
> -	(i.e. the fetch source is equal to the push destination),
> -	`upstream` is probably what you want.  Possible values are:
> +	neither explicitly (on the command-line) nor implicitly (via a
> +	`remote.*.push` config option) given.  Different values are
> +	well-suited for specific workflows; for instance, in a purely
> +	central workflow (i.e. the fetch source is equal to the push
> +	destination), `upstream` is probably what you want.  Possible
> +	values are:
>  +
>  --

Hmph, I am not sure the act of deliberately setting remote.*.push
configuration should not count as an explicit request to Git the
user makes.

Immediately follows the above, the description of one of the
possible values read thusly:

    * `nothing` - do not push anything (error out) unless a refspec is
      explicitly given. This is primarily meant for people who want to
      avoid mistakes by always being explicit.

which may need an adjustment to keep the whole coherent.  If we
decide to say that setting configuration does not count as explicit,
then "unless a refspec is explicitly given" should be updated to
match.  There may be other mention of "explicitly" that needs to be
adjusted (I didn't hunt for it, but the above one was adjacent and I
couldn't not see it).

If we have to change anything in the description, I would say that
we can just drop "explicitly".  There are ways to give refspec from
the command line, remote.*.push configuration, in .git/remotes file,
etc.  If it were "if you give refspec from command line, X happens,
but giving a config-sourced refspec does not cause X to happen",
that may be a good reason to invent and use a new phrase "implicitly
given" that is not used in this paragraph.  But push.default kicks
in only when *none* of these ways is used to give *any* refspec, so
there is not much point differenciating between the command line
sourced refspec and config sourced refspec in the context of
discussing this feature, I would think.
