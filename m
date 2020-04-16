Return-Path: <SRS0=FNL0=6A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C72CC2BA19
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 00:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6228A206A2
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 00:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Tyr/QMvm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405139AbgDPAuM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Apr 2020 20:50:12 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64087 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405058AbgDPAuG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Apr 2020 20:50:06 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C2B744D712;
        Wed, 15 Apr 2020 20:50:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1V3z787PEk++fQJj9t0dxVwtJAQ=; b=Tyr/QM
        vmJQfLWFVg57yanZaPmP4sZhCKOJ9KmWvhP7UQg4KvowaN/31SApTbDGt/WhRSx7
        T/vtIk8quy7wANLFXMMpoxinxOZ7vVjzl70JBzHAAh+1ox6Zl+8KTVpg+ED71rWv
        mXDL/kA9Ndq+aroTK/F1gcrKisbjASKQVp7ck=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GK9wvQt8/ymfjOsWBN/1uYxuUrF5X/ls
        icqP1wAGx7CDveYEf9nud1bTWejMXqvU+Ucrjy+/6p4JDJSk9+QcKGKKNJ5+6oGM
        ai9tkufuWfygch5kArOXlcVqMMu00lA+O0Xh0sTZLoZgOqQY/Uba3E3ojzrJ03Tf
        BETOclGGIT8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6CE704D710;
        Wed, 15 Apr 2020 20:50:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 75C254D70F;
        Wed, 15 Apr 2020 20:50:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Danh Doan <congdanhqx@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v4 00/12] ci: replace our Azure Pipeline by GitHub Actions
References: <pull.743.git.git.1585658913.gitgitgadget@gmail.com>
        <cover.1586309211.git.congdanhqx@gmail.com>
        <xmqqpncgmk5z.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2004101604210.46@tvgsbejvaqbjf.bet>
        <xmqq1rovl54d.fsf@gitster.c.googlers.com>
        <20200410174141.GB27699@danh.dev>
Date:   Wed, 15 Apr 2020 17:49:59 -0700
In-Reply-To: <20200410174141.GB27699@danh.dev> (Danh Doan's message of "Sat,
        11 Apr 2020 00:41:41 +0700")
Message-ID: <xmqqh7xk45l4.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 338196A4-7F7C-11EA-A6F2-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Danh Doan <congdanhqx@gmail.com> writes:

> On 2020-04-10 08:42:10-0700, Junio C Hamano <gitster@pobox.com> wrote:
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>  ...
>> > I would like to point out that there is only one single topic that is
>> > cause for sorrow here, and it is the reftable one.
>> 
>> I first thought so, too, but vsbuild failures like the one in
>> https://github.com/git/git/runs/575116793 do not appear to be
>> caused by that topic (6a8c1d17b8 excludes reftable), so there
>> must be somebody else that is broken.
>
> Excerpt from build log:
>
>> fatal error C1083: Cannot open include file: 'config-list.h'
>
> It's from bugreport topic.
> I've seen this failure in the past (when testing with pu),
> then I saw it disappear.
>
> I thought it was fixed during my testing for v4.

Is the issue something similar to 976aaedc (msvc: add a Makefile
target to pre-generate the Visual Studio solution, 2019-07-29)?

If that is the case, perhaps something like this would help?  I'll
tentatively queue it on top of es/bugreport and merge the result to
'pu' to see what happens.

-- >8 --
Subject: msvc: the bugreport topic depends on a generated config-list.h file

For reasons explained in 976aaedc (msvc: add a Makefile target to
pre-generate the Visual Studio solution, 2019-07-29), some build
artifacts we consider non-source files cannot be generated in the
Visual Studio environment, and we already have some Makefile tweaks
to help Visual Studio to use generated command-list.h header file.

As this topic starts to depend on another such generated header file,
config-list.h, let's do the same to it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 compat/vcbuild/README | 4 ++--
 config.mak.uname      | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/compat/vcbuild/README b/compat/vcbuild/README
index 1b6dabf5a2..42292e7c09 100644
--- a/compat/vcbuild/README
+++ b/compat/vcbuild/README
@@ -92,8 +92,8 @@ The Steps of Build Git with VS2008
    the git operations.
 
 3. Inside Git's directory run the command:
-       make command-list.h
-   to generate the command-list.h file needed to compile git.
+       make command-list.h config-list.h
+   to generate the header file needed to compile git.
 
 4. Then either build Git with the GNU Make Makefile in the Git projects
    root
diff --git a/config.mak.uname b/config.mak.uname
index 0ab8e00938..f880cc2792 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -721,9 +721,9 @@ vcxproj:
 	 echo '</Project>') >git-remote-http/LinkOrCopyRemoteHttp.targets
 	git add -f git/LinkOrCopyBuiltins.targets git-remote-http/LinkOrCopyRemoteHttp.targets
 
-	# Add command-list.h
-	$(MAKE) MSVC=1 SKIP_VCPKG=1 prefix=/mingw64 command-list.h
-	git add -f command-list.h
+	# Add command-list.h and config-list.h
+	$(MAKE) MSVC=1 SKIP_VCPKG=1 prefix=/mingw64 config-list.h command-list.h
+	git add -f config-list.h command-list.h
 
 	# Add scripts
 	rm -f perl/perl.mak
