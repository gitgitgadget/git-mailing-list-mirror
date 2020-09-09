Return-Path: <SRS0=gV3S=CS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59263C433E2
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 19:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06F2D215A4
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 19:07:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CDWyD4lX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgIITHY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Sep 2020 15:07:24 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64631 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbgIITHV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Sep 2020 15:07:21 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8BA3CF0135;
        Wed,  9 Sep 2020 15:07:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=C1W+mhSR2y/p
        BmtqZCwg8Gy/JOI=; b=CDWyD4lXSc4LCXtM3t8B0QPFMQU5mEl/WYIsGXQQzrqe
        ByJaSre6yDsJjHwKRA7cyOZPRnjt7Y1lzX0L+5A8FmTZFARurKaNgeYucavMOY/L
        QC3dKOs9ktHLwulvd97F3fX4JBzKwOzVlc5c6Tt0YlhzR8dxcodNDfeGo894qSU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Kw3sSK
        aosbUO0V+MYuGigQpb63+QicMuxmxxa0+jA+11qfgGd/meGcuCYgI0ZMfz12930B
        /Nv/JGu/anB9nXC8eUvqx6+u3wyGBy/W++j9qaiSrTRYQ4SKzCClmbv5n6ucEAMc
        ySUvZcHaGw80AaL0+eSvslioYzMINPw85PO8I=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 83DC8F0134;
        Wed,  9 Sep 2020 15:07:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 60242F0133;
        Wed,  9 Sep 2020 15:07:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     Daniel Villeneuve <dvilleneuve.4142@gmail.com>, git@vger.kernel.org
Subject: Re: permissions of main folder for git-manpages.tar.gz
References: <cc8487b0-c23f-46c3-b8c3-e3188b7c0d0e@gmail.com>
        <xmqq7dt3x134.fsf@gitster.c.googlers.com>
        <20200909032838.GA59978@Carlos-MBP>
Date:   Wed, 09 Sep 2020 12:07:12 -0700
In-Reply-To: <20200909032838.GA59978@Carlos-MBP> ("Carlo Marcelo Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Tue, 8 Sep 2020 20:28:38 -0700")
Message-ID: <xmqqimcmvkf3.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: ABE213B4-F2CF-11EA-BF9D-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com> writes:

> On Tue, Sep 08, 2020 at 05:09:35PM -0700, Junio C Hamano wrote:
>>=20
>> I'm contemplating to apply something like the following patch to the
>> build procedure so that I can externally control the mode bits
>> recorded in the tarball by setting TAR_C_EXTRA_OPTS to options that
>> overrides mode bits and stuff (it takes GNU tar unfortunately, but
>> I suspect I am the only person that runs dist-doc target anyway)
>
> also useful (albeit not for the same reason) with BSD tar for adding
> things like "--check-links", either way don't forget the signed-off
> while adding:
>
>   Tested-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>

I just realized that we should do the same for the soure release
tarball, not just preformatted documentation tarballs that are not
really sources.

The use of the 'c' mode with 'tar' is an implementation detail of
doing a 'distribution'; TAR_C_EXTRA_OPTS in the draft version was
renamed to TAR_DIST_EXTRA_OPTS to make it more clear that this is
for use with $(TAR) for dist targets.

Thanks.

-- >8 --
From: Junio C Hamano <gitster@pobox.com>
Date: Wed, 9 Sep 2020 11:53:04 -0700
Subject: [PATCH] Makefile: allow extra tweaking of distribution tarball

The maintainer's dist rules are used to produce distribution
tarballs.  They use "$(TAR) cf" and "$(TAR) rf" to produce archives
out of a freshly created local installation area, which means that
the built product can be affected by maintainer's umask and other
local environment.

Implementations of "tar" have ways (implementation specific,
unfortunately) to force permission bits and other stuff to allow the
user to hide these effects coming from the local environment.  Teach
our Makefile to allow the maintainer to tweak the invocation of the
$(TAR) commands by setting TAR_DIST_EXTRA_OPTS.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 86e5411f39..62e8bfcf6e 100644
--- a/Makefile
+++ b/Makefile
@@ -2992,6 +2992,9 @@ quick-install-html:
=20
 ### Maintainer's dist rules
=20
+# Allow tweaking to hide local environment effects, like perm bits.
+# With GNU tar, "--mode=3Du+rwX,og+rX,og-w" would be a good idea, for ex=
ample.
+TAR_DIST_EXTRA_OPTS =3D
 GIT_TARNAME =3D git-$(GIT_VERSION)
 dist: git-archive$(X) configure
 	./git-archive --format=3Dtar \
@@ -3000,7 +3003,7 @@ dist: git-archive$(X) configure
 	@cp configure $(GIT_TARNAME)
 	@echo $(GIT_VERSION) > $(GIT_TARNAME)/version
 	@$(MAKE) -C git-gui TARDIR=3D../$(GIT_TARNAME)/git-gui dist-version
-	$(TAR) rf $(GIT_TARNAME).tar \
+	$(TAR) rf $(GIT_TARNAME).tar $(TAR_DIST_EXTRA_OPTS) \
 		$(GIT_TARNAME)/configure \
 		$(GIT_TARNAME)/version \
 		$(GIT_TARNAME)/git-gui/version
@@ -3014,7 +3017,7 @@ ifdef DC_SHA1_SUBMODULE
 		$(GIT_TARNAME)/sha1collisiondetection/lib/
 	@cp sha1collisiondetection/lib/ubc_check.[ch] \
 		$(GIT_TARNAME)/sha1collisiondetection/lib/
-	$(TAR) rf $(GIT_TARNAME).tar \
+	$(TAR) rf $(GIT_TARNAME).tar $(TAR_DIST_EXTRA_OPTS) \
 		$(GIT_TARNAME)/sha1collisiondetection/LICENSE.txt \
 		$(GIT_TARNAME)/sha1collisiondetection/lib/sha1.[ch] \
 		$(GIT_TARNAME)/sha1collisiondetection/lib/ubc_check.[ch]
@@ -3048,7 +3051,7 @@ dist-doc:
 	$(RM) -r .doc-tmp-dir
 	mkdir .doc-tmp-dir
 	$(MAKE) -C Documentation WEBDOC_DEST=3D../.doc-tmp-dir install-webdoc
-	cd .doc-tmp-dir && $(TAR) cf ../$(htmldocs).tar .
+	cd .doc-tmp-dir && $(TAR) cf ../$(htmldocs).tar $(TAR_DIST_EXTRA_OPTS) =
.
 	gzip -n -9 -f $(htmldocs).tar
 	:
 	$(RM) -r .doc-tmp-dir
@@ -3058,7 +3061,7 @@ dist-doc:
 		man5dir=3D../.doc-tmp-dir/man5 \
 		man7dir=3D../.doc-tmp-dir/man7 \
 		install
-	cd .doc-tmp-dir && $(TAR) cf ../$(manpages).tar .
+	cd .doc-tmp-dir && $(TAR) cf ../$(manpages).tar $(TAR_DIST_EXTRA_OPTS) =
.
 	gzip -n -9 -f $(manpages).tar
 	$(RM) -r .doc-tmp-dir
=20
--=20
2.28.0-558-g7a0184fd7b

