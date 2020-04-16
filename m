Return-Path: <SRS0=FNL0=6A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A2AEC2BA2B
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 05:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED24620771
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 05:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FB14Hm7E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405529AbgDPFDr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Apr 2020 01:03:47 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58859 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404971AbgDPFDn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Apr 2020 01:03:43 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 79AD7D67C2;
        Thu, 16 Apr 2020 01:03:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DWE7lbtO76v7bMOEevYc1Bnivec=; b=FB14Hm
        7E/bC2hoZTefPE0b0mMlmReNcYZ16ZwtERjHP2vc4F+PxPLKSDEHHrri4VAP6hXG
        cccSA95mQrnOzVAhoQyItxI+bMhTnvfJAdkbKjkp8Jd6aKVnlbzahijIbfzG1o0D
        E12hPXAcMMBweFL8Ht3azO4szqicJ5UeWL6VE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wwxiyJbHAHEdTTqFOIgo2tP2eWTzEcsw
        mVpA8LZBG++n3DtTxfM2R9a5E9th4LzmiA/I9DSnKSzy2hGzCtNPg4Z6qYwW5g89
        +elRrYSQKMvYXav01/2F+jqWPMy5toFN7e9kbOjRHOMZMtCc5u/ZQNlgAyQfxsp5
        izkYHuYh0gY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7215CD67C1;
        Thu, 16 Apr 2020 01:03:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B9748D67C0;
        Thu, 16 Apr 2020 01:03:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emma Brooks <me@pluvano.com>
Cc:     git@vger.kernel.org, Eric Wong <e@80x24.org>
Subject: Re: [PATCH] Documentation: explain "mboxrd" pretty format
References: <20200416041658.85100-1-me@pluvano.com>
Date:   Wed, 15 Apr 2020 22:03:36 -0700
In-Reply-To: <20200416041658.85100-1-me@pluvano.com> (Emma Brooks's message of
        "Thu, 16 Apr 2020 04:16:59 +0000")
Message-ID: <xmqqlfmw2f9z.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A1B55DEA-7F9F-11EA-A1C1-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emma Brooks <me@pluvano.com> writes:

> The "mboxrd" pretty format was introduced in 9f23e04061 (pretty: support
> "mboxrd" output format, 2016-06-05) but wasn't mentioned in the
> documentation.
>
> Signed-off-by: Emma Brooks <me@pluvano.com>
> ---
>  Documentation/pretty-formats.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
> index a4b6f49186..547a552463 100644
> --- a/Documentation/pretty-formats.txt
> +++ b/Documentation/pretty-formats.txt
> @@ -83,6 +83,12 @@ placeholders, its output is not affected by other options like
>  
>  	  <full commit message>
>  
> +* 'mboxrd'
> ++
> +Like 'email', but lines in the commit message starting with "From "
> +(preceded by zero or more ">") are quoted with ">" so they aren't
> +confused as starting a new commit.

I am torn between rephrasing "starting a new commit" with "starting
a new e-mail message", and keeping it as-is.  Technically, the latter
is more correct---the >From quoting is a technique to avoid starting
a line with "From " in a reversible way, as pieces of e-mails in a
single mailbox file needs to be split at the boundary.  But in the
context of format-patch, perhaps saying each "record" in the output
file is a "commit" (not a piece of e-mail message) would probably be
an acceptable white lie.

Thanks.


>  * 'raw'
>  +
>  The 'raw' format shows the entire commit exactly as
