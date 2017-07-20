Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FEAB20898
	for <e@80x24.org>; Thu, 20 Jul 2017 18:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934835AbdGTS5F (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jul 2017 14:57:05 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52107 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934546AbdGTS5E (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2017 14:57:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4C0048BBBD;
        Thu, 20 Jul 2017 14:57:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7FlUiVzV9XceYOtsOtaheks01Tg=; b=Dd7Vc0
        jMK0ygIRivNeix//pIKeDi8+0om1P+dRko7wVellw+pI/0M7VJ5jOa/06MYRthnJ
        mo+4HyCoiDtNIaY5tuz5Vf0Za5ZsS2O4cg5IIWy55amkL0aWvggeSVISdbspr2CF
        WGD68tj3Gm329Sq1OWxF70d753objNJ9pOc1I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=W2PTmUJtPS8fLCtx7Otfy4Z6sIGhVNYa
        zsfxF4W/IHVG2s98zggox+5jQI5bNoVT+kaNlU/HSDjKmx2nvYEsLfPjzzEqH+qm
        EJXDJWUSp2Cj1/XzK3a2izSJVlxDavF6n7vU4Gn4xxDmDS5Sy3L5jrsXYqDY5odE
        7F9yEiKk8bo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 430178BBBC;
        Thu, 20 Jul 2017 14:57:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 986F18BBBA;
        Thu, 20 Jul 2017 14:57:02 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List <git@vger.kernel.org>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH] PRItime: wrap PRItime for better l10n compatibility
References: <249ac6f8-af3c-4b20-5bf0-87a82866cc7a@free.fr>
        <3ccfa2fb49d471f807d77d9a280e4b7cfe56faea.1500304209.git.worldhello.net@gmail.com>
        <xmqq7ez7htvj.fsf@gitster.mtv.corp.google.com>
        <CANYiYbEcMrriaor9OT4c2qtfh9Ja5NJ9KBSxa3XhPAuoN0t42A@mail.gmail.com>
        <xmqq60epfy27.fsf@gitster.mtv.corp.google.com>
        <CANYiYbFROuyXso2ZKuJWDp4cSwpBu=bNAbC-yZtEyDwkbUcAhQ@mail.gmail.com>
        <alpine.DEB.2.21.1.1707191456010.4193@virtualbox>
        <xmqq8tjkm3ly.fsf@gitster.mtv.corp.google.com>
        <xmqqo9sfkm32.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 20 Jul 2017 11:57:01 -0700
In-Reply-To: <xmqqo9sfkm32.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Thu, 20 Jul 2017 11:19:29 -0700")
Message-ID: <xmqqfudrkkci.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 376E0A54-6D7D-11E7-A55B-EFB41968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> The use of "make pot" from the top-level is already described in
> po/README, so the only thing that we need is something like this
> change.  I'll follow up this message with a sample output from the
> updated process to ask others to sanity check the result (they are
> tiny) in a separate message.

So I am inclined to apply this directly on 'master' before tagging
the first release candidate that includes timestamp_t; I'll wait for
the earth to rotate once for comments, though.

Thanks.

-- >8 --
Subject: [PATCH] Makefile: help gettext tools to cope with our custom PRItime format

We started using our own timestamp_t type and PRItime format
specifier to go along with it, so that we can later change the
underlying type and output format more easily, but this does not
play well with gettext tools.

Because gettext tools need to keep the *.po file portable across
platforms, they have to special-case the format specifiers like
PRIuMAX that are known types in inttypes.h, instead of letting CPP
handle strings like

    "%" PRIuMAX " seconds ago"

as an ordinary string concatenation.  They fundamentally cannot do
the same for our own custom type/format.

Given that po/git.pot needs to be generated only once every release
and by only one person, i.e. the l10n coordinator, let's update the
Makefile rule to generate po/git.pot so that gettext tools are run
on a munged set of sources in which all mentions of PRItime are
replaced with PRIuMAX, which is what we happen to use right now.

This way, developers do not have to care that PRItime does not play
well with gettext, and translators do not have to care that we use
our own PRItime.

The credit for the idea to munge the source files goes to Dscho.
Possible bugs are mine.

Helped-by: Jiang Xin <worldhello.net@gmail.com>
Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Makefile b/Makefile
index ba4359ef8d..527502835f 100644
--- a/Makefile
+++ b/Makefile
@@ -2216,12 +2216,32 @@ LOCALIZED_SH += t/t0200/test.sh
 LOCALIZED_PERL += t/t0200/test.perl
 endif
 
+## Note that this is meant to be run only by the localization coordinator
+## under a very controlled condition, i.e. (1) it is to be run in a
+## Git repository (not a tarball extract), (2) any local modifications
+## will be lost.
+## Gettext tools cannot work with our own custom PRItime type, so
+## we replace PRItime with PRIuMAX.  Weneed to update this if we
+## switch to a signed type with PRIdMAX.
+
 po/git.pot: $(GENERATED_H) FORCE
+	# All modifications will be reverted at the end, so we do not
+	# want to have any local changes
+	git diff --quiet HEAD && git diff --quiet --cached
+
+	@for s in $(LOCALIZED_C) $(LOCALIZED_SH) $(LOCALIZED_PERL); \
+	do \
+		sed -e 's|PRItime|PRIuMAX|g' <"$$s" >"$$s+" && \
+		cat "$$s+" >"$$s" && rm "$$s+"; \
+	done
+
 	$(QUIET_XGETTEXT)$(XGETTEXT) -o$@+ $(XGETTEXT_FLAGS_C) $(LOCALIZED_C)
 	$(QUIET_XGETTEXT)$(XGETTEXT) -o$@+ --join-existing $(XGETTEXT_FLAGS_SH) \
 		$(LOCALIZED_SH)
 	$(QUIET_XGETTEXT)$(XGETTEXT) -o$@+ --join-existing $(XGETTEXT_FLAGS_PERL) \
 		$(LOCALIZED_PERL)
+
+	git reset --hard
 	mv $@+ $@
 
 .PHONY: pot
-- 
2.14.0-rc0-194-g965e058453

