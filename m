Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3355E2095B
	for <e@80x24.org>; Sat, 18 Mar 2017 19:41:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751767AbdCRTl0 (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 15:41:26 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52001 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751708AbdCRTlZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2017 15:41:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4A319885C7;
        Sat, 18 Mar 2017 15:41:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MmZ/T9eStXu6bVrTFFSUqbXTve8=; b=ZY9q/1
        yScRwvYvUbPbtN16vv4qbvk46L50RGPylfJiS9n+TjTX4eBSz3XLAcWxVigTydza
        8FWlFf8nOEiMv/E6dtDTgtfwMSRAQDXzoC/5HGIqBq0QCbglxKmQoSxtjaiq1P5I
        XU6ZJ1Om3e/3EYOQ1rHkst+tVOQgm5AtClr6c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QjnFBhCtS4hksvRnjohXYKiVPrFSc6Bf
        W+XV7q9Kh2hevYdc1uBRW0VydnV4tH9UDvVKorbJBeLAJleIFNypOu5z72auHpUQ
        uisSoBRLKco8eg0du48UnYaahOBpRq0Zj70ahKGDznOu3mGEi08IgmuSNQd/jZH9
        IRznEcsDcPY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 421A5885C6;
        Sat, 18 Mar 2017 15:41:24 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AD2D4885C5;
        Sat, 18 Mar 2017 15:41:23 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jean-Noel Avila <jn.avila@free.fr>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 1/2] l10n: Introduce framework for localizing man pages
References: <20170312200248.3610-1-jn.avila@free.fr>
        <20170312200248.3610-1-jn.avila@free.fr>
        <20170318175353.24578-1-jn.avila@free.fr>
Date:   Sat, 18 Mar 2017 12:41:22 -0700
In-Reply-To: <20170318175353.24578-1-jn.avila@free.fr> (Jean-Noel Avila's
        message of "Sat, 18 Mar 2017 18:53:52 +0100")
Message-ID: <xmqqfuia1ifx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DE55CFA4-0C12-11E7-8C8D-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jean-Noel Avila <jn.avila@free.fr> writes:

> Providing git in localized version is a good step for general adoption
> of the tool. But as of now, if one needs to refer to the manual pages,
> they are still confronted to english. The aim is to provide
> documentation to users in their own language.

Please outline how the end result looks like here.  Where are the
localized man pages installed?  Do installers get to choose to build
and install the localization for some but not all languages and if
so how?  etc.

> signed-off-by: Jean-Noel Avila <jn.avila@free.fr>

s/sign/Sign/;

> -man: man1 man5 man7
> +man: man1 man5 man7 man_l10n

Hmmm, at least in the early days of the topic, I'd prefer that "make
doc" and "make install" I need to run dozens of times a day from the
toplevel not to require po4a.

Thanks.
