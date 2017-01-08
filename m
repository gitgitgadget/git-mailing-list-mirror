Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1534020756
	for <e@80x24.org>; Sun,  8 Jan 2017 03:09:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934130AbdAHDJb (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Jan 2017 22:09:31 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51112 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932382AbdAHDJ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Jan 2017 22:09:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 13B8F5DE44;
        Sat,  7 Jan 2017 22:09:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=M52SuYhB8z6fd+GRgWpmD/JEbiE=; b=GnROF0
        771D7DbZX2T09wf+7p3xx0swMmI+VZTPIOgRE3rv3o5vLg4YGIk26WyddHwh4jXy
        K5+u3nQq0fXARrlEWo+a0+ifQlzpa6BmE7rKy/PZhCng4dze3yt7H3++vlSXRJCt
        8gUKImraHhy1SsJbS2Xm3Zlh6LtHMsR0p4vbo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Rg4jwuAjgEKhqxZEDLcWE8iD+IY7FNwr
        d85vgoGd6lrn9SgRInh0TmohQnEfdugXMs/1GTMF79xt/iZqVzbIfpwbaPkSB36A
        4lQALIXmSTEiZclWlK7IvMAJArPzpeCVYzhMggiuZGngZn8xdyJ0j0BKN9qPT+iP
        iFGjcfw5G8I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0B6495DE43;
        Sat,  7 Jan 2017 22:09:28 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5E5235DE41;
        Sat,  7 Jan 2017 22:09:27 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        jacob.keller@gmail.com, ramsay@ramsayjones.plus.com, tboegi@web.de,
        j6t@kdbg.org, pclouds@gmail.com, larsxschneider@gmail.com
Subject: Re: [PATCH v5 0/5] road to reentrant real_path
References: <20170103190923.11882-1-bmwill@google.com>
        <20170104220124.145808-1-bmwill@google.com>
Date:   Sat, 07 Jan 2017 19:09:26 -0800
In-Reply-To: <20170104220124.145808-1-bmwill@google.com> (Brandon Williams's
        message of "Wed, 4 Jan 2017 14:01:19 -0800")
Message-ID: <xmqqpojy1c49.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DD60FAFA-D54F-11E6-88F3-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> changes in v5:
> * set errno to ELOOP when MAXSYMLINKS is exceded.
> * revert to use MAXSYMLINKS instead of MAXDEPTH.
> * If the OS hasn't defined MAXSYMLINKS, use a fallback value of 32.
>
> Brandon Williams (4):
>   real_path: resolve symlinks by hand
>   real_path: convert real_path_internal to strbuf_realpath
>   real_path: create real_pathdup
>   real_path: have callers use real_pathdup and strbuf_realpath
>
> Johannes Sixt (1):
>   real_path: canonicalize directory separators in root parts
>

How does this relate to the 5-patch real_path: series that has been
on 'next' since last year?
