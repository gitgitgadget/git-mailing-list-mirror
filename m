Return-Path: <SRS0=mJAO=7L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A885C433E0
	for <git@archiver.kernel.org>; Fri, 29 May 2020 23:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0982C207BC
	for <git@archiver.kernel.org>; Fri, 29 May 2020 23:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ydbmdTSg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbgE2Xcv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 May 2020 19:32:51 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55756 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728293AbgE2Xcu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 May 2020 19:32:50 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0A0B352AF5;
        Fri, 29 May 2020 19:32:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QJNNkP/oLVxYnh6LTlGllwmRY7Q=; b=ydbmdT
        SgUt8h8J300xA/sT2anmMu5qxh4hAGtoWkFHxesB4XrC3G/e61mYQ8YMWYf5FySS
        N3xPj+wMSRICRVsruRsKSf3r0t/l1oDFSf1UVtlSS6r0Iq32L5qJ6YObFb6q7euA
        FrheabuKR8n0bMPfoo0T2Li0NGwR+B9R7XLxU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YH7arxAUWtTIYTD6vnvG5/R0vP+7//Yi
        bwEQshYM//qggvJyOPs0IB8GhUaNVK0pOFkGARwV5sVIr8+AdiTFFXnhjRs9SB3a
        6tZLgbaVfd07+6ZxLtMmERPjLlfZ+3rEXED0DEKo/CGGUqUvFRaSySYZNfdZh4Yf
        l0DV+WAJyDw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 01E5E52AF4;
        Fri, 29 May 2020 19:32:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6F4DD52AF3;
        Fri, 29 May 2020 19:32:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 4/8] Documentation: order protocol v2 sections
References: <cover.1590789428.git.jonathantanmy@google.com>
        <7a2e9c3c5994fc155eb6a40f039cf2298957fa6c.1590789428.git.jonathantanmy@google.com>
Date:   Fri, 29 May 2020 16:32:45 -0700
In-Reply-To: <7a2e9c3c5994fc155eb6a40f039cf2298957fa6c.1590789428.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Fri, 29 May 2020 15:30:16 -0700")
Message-ID: <xmqqa71qxqoy.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B395F376-A204-11EA-8AAA-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> The current C Git implementation expects Git servers to follow a
> specific order of sections when transmitting protocol v2 responses, but
> this is not explicit in the documentation. Make the order explicit.

Thanks.  Are we breaking other people's implementation, or is this
the order all reimplementations of Git currently follow, so this is
purely an preemptive safety measure?

> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  Documentation/technical/protocol-v2.txt | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
>
> diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
> index 3996d70891..ef7514a3ee 100644
> --- a/Documentation/technical/protocol-v2.txt
> +++ b/Documentation/technical/protocol-v2.txt
> @@ -327,11 +327,11 @@ included in the client's request:
>  
>  The response of `fetch` is broken into a number of sections separated by
>  delimiter packets (0001), with each section beginning with its section
> -header.
> +header. Most sections are sent only when the packfile is sent.
>  
> -    output = *section
> -    section = (acknowledgments | shallow-info | wanted-refs | packfile)
> -	      (flush-pkt | delim-pkt)
> +    output = acknowledgements flush-pkt |
> +	     [acknowledgments delim-pkt] [shallow-info delim-pkt]
> +	     [wanted-refs delim-pkt] packfile flush-pkt
>  
>      acknowledgments = PKT-LINE("acknowledgments" LF)
>  		      (nak | *ack)
> @@ -353,9 +353,10 @@ header.
>  	       *PKT-LINE(%x01-03 *%x00-ff)
>  
>      acknowledgments section
> -	* If the client determines that it is finished with negotiations
> -	  by sending a "done" line, the acknowledgments sections MUST be
> -	  omitted from the server's response.
> +	* If the client determines that it is finished with negotiations by
> +	  sending a "done" line (thus requiring the server to send a packfile),
> +	  the acknowledgments sections MUST be omitted from the server's
> +	  response.
>  
>  	* Always begins with the section header "acknowledgments"
>  
> @@ -406,9 +407,6 @@ header.
>  	  which the client has not indicated was shallow as a part of
>  	  its request.
>  
> -	* This section is only included if a packfile section is also
> -	  included in the response.
> -
>      wanted-refs section
>  	* This section is only included if the client has requested a
>  	  ref using a 'want-ref' line and if a packfile section is also
