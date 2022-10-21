Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE0EFC38A2D
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 18:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiJUS4h (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 14:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiJUS4b (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 14:56:31 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA9A2764C1
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 11:56:29 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9828F1B290E;
        Fri, 21 Oct 2022 14:56:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7w90xcO2gJL6IpYp4fBIocH+mbfBoXb5xBRF8e
        3fft0=; b=TW+U9Bkji7I7kXHSoq4T6Rv9tojEQukv98JNjxpzY/CEIbrKHfG/bf
        uC0BTSbIPuD0zJe+JRrGmmsdFT6R9US4cL4LEzzUxaTpXtpi8ap/cDsoyz34FicT
        1l+J7UAA4ZlndSc1cZc/SJ+tsbDVA1mjs+cQKZJMEkjUSevXU+gk8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8F84F1B290D;
        Fri, 21 Oct 2022 14:56:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A62461B290C;
        Fri, 21 Oct 2022 14:56:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Siddharth Asthana <siddharthasthana31@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        johncai86@gmail.com
Subject: Re: [PATCH] doc/cat-file: allow --use-mailmap for --batch options
References: <20220923193543.58635-1-siddharthasthana31@gmail.com>
        <20221021103442.202759-1-siddharthasthana31@gmail.com>
Date:   Fri, 21 Oct 2022 11:56:23 -0700
In-Reply-To: <20221021103442.202759-1-siddharthasthana31@gmail.com> (Siddharth
        Asthana's message of "Fri, 21 Oct 2022 16:04:41 +0530")
Message-ID: <xmqqk04tj99k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0F86B3EA-5172-11ED-92D7-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Siddharth Asthana <siddharthasthana31@gmail.com> writes:

> Changes in v3:
> - Fixed formatting

This seems to format well, both with AsciiDoc and Asciidoctor.

> -	on stdin.  May not be combined with any other options or arguments
> -	except `--textconv` or `--filters`, in which case the input lines
> -	also need to specify the path, separated by whitespace.  See the
> -	section `BATCH OUTPUT` below for details.
> +	on stdin. May not be combined with any other options or arguments

Unnecessary change here, but I'll let it pass this time.

> +	except --textconv, --filters, or --use-mailmap.
> +	+
> +	* When used with `--textconv` or `--filters`, the input lines
> +	  must specify the path, separated by whitespace. See the section
> +	  `BATCH OUTPUT` below for details.

OK.

> +	+
> +	* When used with `--use-mailmap`, the info command shows the size
> +	  the object if the identities recorded in it were replaced
> +	  by the mailmap mechanism.

Did you mean "the object as if the identities ... were replaced"?

All three comments equally apply to the other two hunks for
--batch-check and --batch-command.

Thanks.
