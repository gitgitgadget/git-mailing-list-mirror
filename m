Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C38091F600
	for <e@80x24.org>; Thu, 20 Jul 2017 18:19:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935408AbdGTSTd (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jul 2017 14:19:33 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52332 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933267AbdGTSTc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2017 14:19:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 600958B336;
        Thu, 20 Jul 2017 14:19:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LhGswb8dzz/D3kPzjQM/xwh67WU=; b=amH0G5
        Dik2fiGbs77cZfK7N7Enn0Iwa5/YjKsGspKAJiIxmXNeEtHytSj7pYzhu8Iy+ULo
        OtFcDn8dFKI6fWT712W/VLOTZc6sh/PSc+2lnN9mN4r1zIw1VrDqtdaufin+Z/hF
        FHAShFniai+7KamVGaQAqFJCowIwG1quWqU3Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZMLA+zUdEMQ39TD79DrC+7+LjBJ4J8eB
        ooVHfqX5TExhe/W3ECFm7rgy0a9gZ73NNVSeV20AwYqelHDH74H5Sm/g34PH5sXo
        DDU58t3jZu7WKIyFP6pVmqSOPqmPA5HfQC1j+P1hjdF2qzwnUT+lDXWorAfBzmXC
        2uYghNX68Ck=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 57BCB8B334;
        Thu, 20 Jul 2017 14:19:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BA7858B332;
        Thu, 20 Jul 2017 14:19:30 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
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
Date:   Thu, 20 Jul 2017 11:19:29 -0700
In-Reply-To: <xmqq8tjkm3ly.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 19 Jul 2017 16:03:21 -0700")
Message-ID: <xmqqo9sfkm32.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F9373986-6D77-11E7-9658-EFB41968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> But there may be hope. Since the character sequence "PRItime" is highly
>> unlikely to occur in Git's source code in any context other than the
>> format to print/parse timestamp_t, it should be possible to automate a the
>> string replacement
>>
>> 	git ls-files -z \*.[ch] |
>> 	xargs -0r sed -i 's/PRItime/PRIuMAX/g'
>>
>> (assuming, of course, that you use GNU sed, not BSD sed, for which the
>> `-i` needs to read `-i ''` instead) as part of the update?
>
> I somehow missed this bit.
>
> Given that this needs to be done only once every release by only one
> person (i.e. the l10n coordinator who updates *.pot file), as long
> as the procedure is automated as much as possible to ease the pain
> for the l10n coordinator and clearly described in the "Maintaining
> the po/git.pot file" section of po/README, something along that line
> does sound like a very tempting approach.  If it works well, it is
> certainly much easier for normal developers than the other possible
> alternatives I mentioned in my previous response.

So, I was offline for most of the day yesterday and with this issue
blocking the release candidate, didn't manage to tag -rc1.

The use of "make pot" from the top-level is already described in
po/README, so the only thing that we need is something like this
change.  I'll follow up this message with a sample output from the
updated process to ask others to sanity check the result (they are
tiny) in a separate message.

Thanks.


 Makefile | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Makefile b/Makefile
index ba4359ef8d..7069a12f75 100644
--- a/Makefile
+++ b/Makefile
@@ -2216,12 +2216,22 @@ LOCALIZED_SH += t/t0200/test.sh
 LOCALIZED_PERL += t/t0200/test.perl
 endif
 
+## Note that this is only meant to run by the localization coordinator
+## under a very controlled condition, i.e. (1) it is to be run in a
+## Git repository (not a tarball extract), (2) any local modifications
+## will be lost.
 po/git.pot: $(GENERATED_H) FORCE
+	@for s in $(LOCALIZED_C) $(LOCALIZED_SH) $(LOCALIZED_PERL); \
+	do \
+		sed -e 's|PRItime|PRIuMAX|g' <"$$s" >"$$s+" && \
+		cat "$$s+" >"$$s" && rm "$$s+"; \
+	done
 	$(QUIET_XGETTEXT)$(XGETTEXT) -o$@+ $(XGETTEXT_FLAGS_C) $(LOCALIZED_C)
 	$(QUIET_XGETTEXT)$(XGETTEXT) -o$@+ --join-existing $(XGETTEXT_FLAGS_SH) \
 		$(LOCALIZED_SH)
 	$(QUIET_XGETTEXT)$(XGETTEXT) -o$@+ --join-existing $(XGETTEXT_FLAGS_PERL) \
 		$(LOCALIZED_PERL)
+	@git reset --hard
 	mv $@+ $@
 
 .PHONY: pot
