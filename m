Return-Path: <SRS0=wY2r=4U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D7A3C3F2C6
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 21:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CC2520870
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 21:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HtvlJNvu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbgCCVyk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Mar 2020 16:54:40 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53254 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbgCCVyk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Mar 2020 16:54:40 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BD660559D1;
        Tue,  3 Mar 2020 16:54:37 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tAgPxSALsfJ2w/GFHvyeQOa05GI=; b=HtvlJN
        vuQrJXdBkd60SddLHeKrhuB+1PhHE3lrj9ChHcOOjVLha9sQND6nMJ9Is4uJPyEu
        jDsYrE6DaSy6RCdFn/yLo5OEs25anxmPrXNWbaYwgeJyM5RBL7agikYtFmNi+uXH
        dG+PSVeFv2kH347yxWc+WjvcW3lM3VCBRbgmI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=q5BtWP8U7VxZckgQVbJrtDC3r8u/xRkR
        omd9bF5jDNSBG69YfJuE7IMwgeL53Ntz7cWCdWsYoMLl2iSLEA4oKv9J6NugNLyQ
        HnuexlBpfe8FLRgGOHCokI780bJz9oMMAlyJZc5d886oLdi8Fu0g0v/hXM5Ez9ym
        jcJ2lS/QIl4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B3F80559D0;
        Tue,  3 Mar 2020 16:54:37 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 21F12559CF;
        Tue,  3 Mar 2020 16:54:37 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Damien Robert <damien.olivier.robert@gmail.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Damien Robert <damien.olivier.robert+git@gmail.com>
Subject: Re: [PATCH v2 2/5] doc: document --recurse-submodules for reset and restore
References: <20200228103558.1684937-1-damien.olivier.robert+git@gmail.com>
        <20200303170740.1879432-1-damien.olivier.robert+git@gmail.com>
        <20200303170740.1879432-3-damien.olivier.robert+git@gmail.com>
Date:   Tue, 03 Mar 2020 13:54:36 -0800
In-Reply-To: <20200303170740.1879432-3-damien.olivier.robert+git@gmail.com>
        (Damien Robert's message of "Tue, 3 Mar 2020 18:07:37 +0100")
Message-ID: <xmqqwo816r4z.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 93578DCC-5D99-11EA-AE0C-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Damien Robert <damien.olivier.robert@gmail.com> writes:

> +
> +--[no-]recurse-submodules::
> +	When the working tree is updated, using --recurse-submodules will
> +...
>  
> +--recurse-submodules::
> +--no-recurse-submodules::
> +	If `<pathspec>` names a submodule and the restore location includes
> +...

Hmph, this inconsistency across files is a bit unfortunate.  

I think (please somebody correct me from sideways) we have been
moving towards using the "--[no-]option-name", so we would want to
clean up the latter (together with the "--[no-]overlay" entry in the
same file, with which the above tries to be consistent) sometime
later when the dust settles, iow, not as a part of this series.

> +	is given, in which case it's working tree will be restored to the
> +	commit recorded in the superproject, and it's local modifications
> +	overwritten. If nothing (or `--no-recurse-submodules`) is used,
> +	the work trees of submodules will not be updated. Just like
> +	linkgit:git-checkout[1], this will detach `HEAD` of the submodule.
> +
>  --overlay::
>  --no-overlay::
>  	In overlay mode, the command never removes files when

