Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3C1D1F461
	for <e@80x24.org>; Mon, 26 Aug 2019 16:39:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732610AbfHZQjq (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 12:39:46 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58521 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729338AbfHZQjq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 12:39:46 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 58290731C3;
        Mon, 26 Aug 2019 12:39:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wfz7YIbr2mm0EDC1P15qUmCjaSc=; b=dkQmaf
        c/Us/V5aXo1dSWa7THD/vUD6wcP7exCgkfOJk6K+Jxlc6hWeWewUANEjioAszBXJ
        tLkBwsasmy8BSeBKS+QPez90SaBMZB2F16PCfFS3kwUtXccq47fikeUjuTw9FpZ9
        Sei55MWn+hh2Ydx9jyhqrq3fWRBH1ghmpiqGg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lZr/wSjYG8gcLg34dfc9GTb4T70QD//t
        5P5Eb5dxwHhhfyz/WkGdoP03RByO4/5JQ8LT9MO4b4vh7zRlQKdyz3TNLzdcti4o
        xJIEjVY3lM4OYwvaGXkrA214Ay1/j2vuVZqWKlYDhkogOE9GqIl20NB0HxCuddKe
        A9gwaVilg0o=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 50C97731C2;
        Mon, 26 Aug 2019 12:39:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 256E7731C1;
        Mon, 26 Aug 2019 12:39:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Git Gadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        "Philip.McGraw" <Philip.McGraw@bentley.com>
Subject: Re: [PATCH 1/1] git-p4: auto-delete named temporary file
References: <pull.303.git.gitgitgadget@gmail.com>
        <CANg4QoGSVQWG3QXzoiA8oDsjXaXGoZ+WMNLSPpu75eJWdrWxLQ@mail.gmail.com>
Date:   Mon, 26 Aug 2019 09:39:37 -0700
In-Reply-To: <CANg4QoGSVQWG3QXzoiA8oDsjXaXGoZ+WMNLSPpu75eJWdrWxLQ@mail.gmail.com>
        (Git Gadget's message of "Mon, 26 Aug 2019 15:51:06 +0200")
Message-ID: <xmqqo90bj2ye.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 195F9460-C820-11E9-A64F-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Funny that the patch is line-wrapped, which I do not recall ever
seeing in GGG-generated e-mails.  Dscho, do you know if anything
funny is going on?

Git Gadget <gitgitgadget@gmail.com> writes:

> From: "Philip.McGraw" <Philip.McGraw@bentley.com>
> ...
> diff --git a/git-p4.py b/git-p4.py
> index c71a6832e2..33bdb14fd1 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -1160,13 +1160,11 @@ def exceedsLargeFileThreshold(self, relPath, contents):
>              if contentsSize <=
> gitConfigInt('git-p4.largeFileCompressedThreshold'):
>                  return False
>              contentTempFile = self.generateTempFile(contents)
> -            compressedContentFile =
> tempfile.NamedTemporaryFile(prefix='git-p4-large-file', delete=False)
> -            zf = zipfile.ZipFile(compressedContentFile.name, mode='w')
> -            zf.write(contentTempFile, compress_type=zipfile.ZIP_DEFLATED)
> ...
