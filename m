Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50A7F1F428
	for <e@80x24.org>; Fri, 22 Dec 2017 19:07:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756065AbdLVTHY (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Dec 2017 14:07:24 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52440 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750864AbdLVTHX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Dec 2017 14:07:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B9D6FBD7A9;
        Fri, 22 Dec 2017 14:07:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Ad3z+TmPQ5i9
        /w5LzyQXtdEtfIw=; b=m1n8v7y04kQ5Snn/ZphMyaO2u8LQutTp2s6zWqN/pxTf
        EVigA1gWyB+llnUGJ4ilVPqX0JKG7NfLmB0gHzhJWhro51QC9BlHOv26crTGGa6G
        IIlfnEvQfshLtbzhVkM/hW4+Vce71h6J7VlxuNDk+cwze31n21y2C2g/sG65+lQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=YxONHI
        pkqpiyKuIE0K6QQm0ARg31byG0s/tDw0aQQcp3xFWHWZFAJfKiwsxZYTL+zngdVr
        yv+quJT9NRIGNFrPfQgKI76uzFdymY8lNeP/QJ1tUIDi//TlINoLQkzQhG3K8XEM
        FoUfCc7ihhux9H9JtELGT6nnt29nb7O1kiiuw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B21DEBD7A8;
        Fri, 22 Dec 2017 14:07:22 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 29B73BD7A7;
        Fri, 22 Dec 2017 14:07:22 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Dan Jacques <dnj@google.com>,
        Alex Riesen <alexander.riesen@cetitec.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Casey <drafnel@gmail.com>, Petr Baudis <pasky@ucw.cz>,
        Gerrit Pape <pape@smarden.org>,
        "martin f . krafft" <madduck@madduck.net>, Eric Wong <e@80x24.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        "Randall S . Becker" <rsbecker@nexbridge.com>,
        Michael J Gruber <git@grubix.eu>,
        Todd Zullinger <tmz@pobox.com>
Subject: Re: [PATCH v6] Makefile: replace perl/Makefile.PL with simple make rules
References: <20171220174147.GG3693@zaya.teonanacatl.net>
        <20171220182419.16865-1-avarab@gmail.com>
Date:   Fri, 22 Dec 2017 11:07:21 -0800
In-Reply-To: <20171220182419.16865-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 20 Dec 2017 18:24:19 +0000")
Message-ID: <xmqqefnmshsm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 56C654CC-E74B-11E7-979F-8EF31968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---

Thanks, but I thought the patch was already in 'next' for a week or
more and it's time to refine incrementally.

Here is the difference as I see between what we already have and
this update, and a proposed summary.

-- >8 --
From: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Subject: perl: avoid *.pmc and fix Error.pm further

The previous round tried to use *.pmc files but it confused RPM
dependency analysis on some distros.  Install them as plain
vanilla *.pm files instead.

Also "local @_" construct did not properly work when goto &sub
is used until recent versions of Perl.  Avoid it (and we do not
need to localize it here anyway).


---
diff --git a/Makefile b/Makefile
index ba6607b7e7..5c73cd208a 100644
--- a/Makefile
+++ b/Makefile
@@ -2274,14 +2274,14 @@ endif
 po/build/locale/%/LC_MESSAGES/git.mo: po/%.po
 	$(QUIET_MSGFMT)mkdir -p $(dir $@) && $(MSGFMT) -o $@ $<
=20
-PMFILES :=3D $(wildcard perl/*.pm perl/*/*.pm perl/*/*/*.pm perl/*/*/*/*=
.pm)
-PMCFILES :=3D $(patsubst perl/%.pm,perl/build/lib/%.pmc,$(PMFILES))
+LIB_PERL :=3D $(wildcard perl/Git.pm perl/Git/*.pm perl/Git/*/*.pm perl/=
Git/*/*/*.pm)
+LIB_PERL_GEN :=3D $(patsubst perl/%.pm,perl/build/lib/%.pm,$(LIB_PERL))
=20
 ifndef NO_PERL
-all:: $(PMCFILES)
+all:: $(LIB_PERL_GEN)
 endif
=20
-perl/build/lib/%.pmc: perl/%.pm
+perl/build/lib/%.pm: perl/%.pm
 	$(QUIET_GEN)mkdir -p $(dir $@) && \
 	sed -e 's|@@LOCALEDIR@@|$(localedir_SQ)|g' < $< > $@
=20
diff --git a/perl/Git/Error.pm b/perl/Git/Error.pm
index 5874672150..09bbc97390 100644
--- a/perl/Git/Error.pm
+++ b/perl/Git/Error.pm
@@ -39,7 +39,7 @@ sub import {
 	require Error;
     };
=20
-    local @_ =3D ($caller, @_);
+    unshift @_, $caller;
     goto &Error::import;
 }
=20
