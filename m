Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA4CDC6369E
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 02:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BCF022203
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 02:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729412AbgLCCce (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Dec 2020 21:32:34 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60757 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727949AbgLCCcd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Dec 2020 21:32:33 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 24D728D23B;
        Wed,  2 Dec 2020 21:31:50 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=c7GhGRBepvGOm2qiplziOqVqzTI=; b=q3b1Cz
        8+jaQGyGSOD08y5vSzc7JsMBa4XCC3lhTQed8UrWIIIGpJVO+MZ9ayDfLuiXh6uM
        2h4lQwJwX0pb6ibjs6SUiS7YC3e/LU+Yx/ZRI37VUIvx0X+TkuH76HAI3i12vlYE
        Zl8q6GibGLSnltEun43L1BXSnRNu4vRboMQIY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ugkVPGYUmrtZibLzX9gphhVFP3Cz3k8+
        zP9qTZ/wl8hVg1xhFxJSsl9SqEWiF6BSxMXJn3b2xZ3hrgB+cjMRqIKtt8lWO2jk
        rPMFmQ7XNQw++9gnIPVdvZ9FW5wbfMRGkGBWvlv4hiA0w9ryfI+B4eOQlTGnzmjP
        jsZ6ezoCZ1c=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1B13E8D23A;
        Wed,  2 Dec 2020 21:31:50 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 990368D238;
        Wed,  2 Dec 2020 21:31:49 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Arnout Engelen <arnout@bzzt.net>, git@vger.kernel.org,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re* [PATCH] doc: make HTML manual reproducible
References: <20201201095037.20715-1-arnout@bzzt.net>
        <20201201154115.GP748@pobox.com>
        <X8bhdyu/OlscI1ME@camp.crustytoothpaste.net>
        <20201202160755.GX748@pobox.com>
        <X8gnItjchqX4wwmt@camp.crustytoothpaste.net>
        <20201203020059.GY748@pobox.com>
Date:   Wed, 02 Dec 2020 18:31:49 -0800
In-Reply-To: <20201203020059.GY748@pobox.com> (Todd Zullinger's message of
        "Wed, 2 Dec 2020 21:00:59 -0500")
Message-ID: <xmqqim9jipre.fsf_-_@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B2429E22-350F-11EB-9348-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Todd Zullinger <tmz@pobox.com> writes:

> I suppose we'd ideally look for a v2 with --stringparam
> replaced with --param as you noted upthread?

Yes.

> And maybe an updated commit message to note that it requires
> docbook-xsl 1.79.1 to be effective, but older versions
> gracefully ignore the option?

Yes, definitely.

Here is what I'd queue tentatively to potentially reduce one
round-trip (if Arnout is happy with this version, we can just hear
"yes, that's good" without a formal v2).

Thanks.

--- >8 ------ >8 ------ >8 ------ >8 ------ >8 ------ >8 ---
From: Arnout Engelen <arnout@bzzt.net>
Date: Tue, 1 Dec 2020 09:50:37 +0000
Subject: [PATCH v2] doc: make HTML manual reproducible

Versions of docbook-xsl newer than 1.79.1 allows xsltproc to assign
IDs to nodes in the generated HTML consistently, to make the output
resulting from the same source stable and reproducible.

Pass the generate.consistent.ids parameter from the command line to
ask for this feature.  Older versions of the tool simply ignores the
parameter and produces their output the same way as before this
change, so there is no need to check for toolchain version.

Signed-off-by: Arnout Engelen <arnout@bzzt.net>
Helped-by: brian m. carlson <sandals@crustytoothpaste.net>
Helped-by: Todd Zullinger <tmz@pobox.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

Notes (amlog):
    Message-Id: <20201201095037.20715-1-arnout@bzzt.net>

 Documentation/Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 80d1908a44..69dbe4bb0b 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -380,7 +380,10 @@ SubmittingPatches.txt: SubmittingPatches
 	$(QUIET_GEN) cp $< $@
 
 XSLT = docbook.xsl
-XSLTOPTS = --xinclude --stringparam html.stylesheet docbook-xsl.css
+XSLTOPTS =
+XSLTOPTS += --xinclude
+XSLTOPTS += --stringparam html.stylesheet docbook-xsl.css
+XSLTOPTS += --param generate.consistent.ids 1
 
 user-manual.html: user-manual.xml $(XSLT)
 	$(QUIET_XSLTPROC)$(RM) $@+ $@ && \
-- 
2.29.2-589-gfe47622759


