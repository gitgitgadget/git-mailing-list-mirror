Return-Path: <SRS0=gV3S=CS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E31C2C43461
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 00:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 948882145D
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 00:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HPKDxmeV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbgIIAJl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Sep 2020 20:09:41 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58444 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbgIIAJk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Sep 2020 20:09:40 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1B3CB8CB1E;
        Tue,  8 Sep 2020 20:09:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uVzE+coDRhc9wE2Hr1pMShmsHUI=; b=HPKDxm
        eVdtivjKT8fqDwO/xrmq6WXYJL1s6wasIJ0nJbI/NbFoFgVbHcGke+RYDA4PcFhV
        mxlIjbSMaofbMKdR0O7ISFu37f9WRXsxItiYX6dMHYWeOLTj67doRl7nQfYfEAX8
        8gtCtQsGff1EJ8onygGlNjVLd4g1DYntq08GU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VcsrQxbOnYvgbhPyLA2xSVXYR3D5JNdU
        D6InHuA/dTAzf3/lhNFOwFAYeQp1wqTiqyIeg+qpVgWfzU4VnXudcfOokD3PrH+B
        MpVQgBwJ+TAqEP+u0z+fiIh7RsDf7T0urAuWSu8EvdTmaCmti4rId58u2dBM1CHo
        QY9Y7FRX7jw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 120878CB1D;
        Tue,  8 Sep 2020 20:09:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 81E0C8CB1C;
        Tue,  8 Sep 2020 20:09:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Daniel Villeneuve <dvilleneuve.4142@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: permissions of main folder for git-manpages.tar.gz
References: <cc8487b0-c23f-46c3-b8c3-e3188b7c0d0e@gmail.com>
Date:   Tue, 08 Sep 2020 17:09:35 -0700
In-Reply-To: <cc8487b0-c23f-46c3-b8c3-e3188b7c0d0e@gmail.com> (Daniel
        Villeneuve's message of "Tue, 8 Sep 2020 11:56:47 -0400")
Message-ID: <xmqq7dt3x134.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BF072C3A-F230-11EA-B07B-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Daniel Villeneuve <dvilleneuve.4142@gmail.com> writes:

> I am using
> https://mirrors.edge.kernel.org/pub/software/scm/git/git-manpages-2.28.0.tar.gz
> to get the manpages part of git.
>
> There has been a change in the permissions of the top-level
> folder, from 2.22 (perms 2750) to 2.25 (perms 0700) to 2.28 (perms
> 2700).  However, the permissions of other files/directories allow
> group/others read/execute, as before.
>
> This change broke my latest installations by preventing group
> members to see manpages (I did a chmod to fix that).
>
> Just sharing this observation, in case the change was not
> intentional.

Thanks for letting me know.  

The build procedure of these documentation tarballs pretty much just
snapshots how I personally have these files locally and not
something that was carefully designed to produce files for public
consumption.

I'm contemplating to apply something like the following patch to the
build procedure so that I can externally control the mode bits
recorded in the tarball by setting TAR_C_EXTRA_OPTS to options that
overrides mode bits and stuff (it takes GNU tar unfortunately, but
I suspect I am the only person that runs dist-doc target anyway)

 Makefile | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 86e5411f39..2a8510f6e6 100644
--- a/Makefile
+++ b/Makefile
@@ -3041,6 +3041,7 @@ artifacts-tar:: $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) $(OTHER_PROGRAMS) \
 	$(TAR) czf "$(ARTIFACTS_DIRECTORY)/artifacts.tar.gz" $^ templates/blt/
 .PHONY: artifacts-tar
 
+TAR_C_EXTRA_OPTS =
 htmldocs = git-htmldocs-$(GIT_VERSION)
 manpages = git-manpages-$(GIT_VERSION)
 .PHONY: dist-doc distclean
@@ -3048,7 +3049,7 @@ dist-doc:
 	$(RM) -r .doc-tmp-dir
 	mkdir .doc-tmp-dir
 	$(MAKE) -C Documentation WEBDOC_DEST=../.doc-tmp-dir install-webdoc
-	cd .doc-tmp-dir && $(TAR) cf ../$(htmldocs).tar .
+	cd .doc-tmp-dir && $(TAR) cf ../$(htmldocs).tar $(TAR_C_EXTRA_OPTS) .
 	gzip -n -9 -f $(htmldocs).tar
 	:
 	$(RM) -r .doc-tmp-dir
@@ -3058,7 +3059,7 @@ dist-doc:
 		man5dir=../.doc-tmp-dir/man5 \
 		man7dir=../.doc-tmp-dir/man7 \
 		install
-	cd .doc-tmp-dir && $(TAR) cf ../$(manpages).tar .
+	cd .doc-tmp-dir && $(TAR) cf ../$(manpages).tar $(TAR_C_EXTRA_OPTS) .
 	gzip -n -9 -f $(manpages).tar
 	$(RM) -r .doc-tmp-dir
 

