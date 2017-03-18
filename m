Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D4412095B
	for <e@80x24.org>; Sat, 18 Mar 2017 23:18:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751317AbdCRXSx (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 19:18:53 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56484 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751298AbdCRXSx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2017 19:18:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D235185C81;
        Sat, 18 Mar 2017 19:03:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=824irtALuYDDQX6bXG9HOckgScg=; b=dzlMmy
        ZpYfodvIEKjmjo4MjX77nQyDsjHJ2MnStT+2XyiFqFek+HWeDH3EPUtU84FifjeV
        s5sotpl6slH3nE4RJDigdVqPgJ3ykPEfZX0RgL4Iu9+2nexURSahSW6sDJmOyCkk
        Vq5in5TUM7G5hDzOxuD1goNyhfka1J2ZO776g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=I3KN5BEbGTRurG2Znq/n1pRrpphc1zdQ
        HYlw+5plD585A+q9wYxMij5um1jPBRmlGcFVCdDl2kmhGIr588Kux3KjkoWDF51i
        GNsgiPoaMf76MikxCX6yfcdB7JHlxlE17Eigi6JJBYvdGaSjGzJ5rX9l6C4OaeW2
        Jyd8NsiO4FM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C914185C80;
        Sat, 18 Mar 2017 19:03:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4A48285C7D;
        Sat, 18 Mar 2017 19:03:51 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jean-Noel Avila <jn.avila@free.fr>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 1/2] l10n: Introduce framework for localizing man pages
References: <20170312200248.3610-1-jn.avila@free.fr>
        <20170312200248.3610-1-jn.avila@free.fr>
        <20170318175353.24578-1-jn.avila@free.fr>
        <xmqqfuia1ifx.fsf@gitster.mtv.corp.google.com>
Date:   Sat, 18 Mar 2017 16:03:50 -0700
In-Reply-To: <xmqqfuia1ifx.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Sat, 18 Mar 2017 12:41:22 -0700")
Message-ID: <xmqq37ea192h.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 26DDD8AE-0C2F-11E7-96E6-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jean-Noel Avila <jn.avila@free.fr> writes:
>
>> Providing git in localized version is a good step for general adoption
>> of the tool. But as of now, if one needs to refer to the manual pages,
>> they are still confronted to english. The aim is to provide
>> documentation to users in their own language.
>
> Please outline how the end result looks like here.  Where are the
> localized man pages installed?  Do installers get to choose to build
> and install the localization for some but not all languages and if
> so how?  etc.
>
>> signed-off-by: Jean-Noel Avila <jn.avila@free.fr>
>
> s/sign/Sign/;
>
>> -man: man1 man5 man7
>> +man: man1 man5 man7 man_l10n
>
> Hmmm, at least in the early days of the topic, I'd prefer that "make
> doc" and "make install" I need to run dozens of times a day from the
> toplevel not to require po4a.
>
> Thanks.

Travis seems to have failed.  Perhaps something like this is needed,
at least?

 .travis.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.travis.yml b/.travis.yml
index 591cc57b80..719e5cdb00 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -20,6 +20,7 @@ addons:
     - language-pack-is
     - git-svn
     - apache2
+    - po4a
 
 env:
   global:
