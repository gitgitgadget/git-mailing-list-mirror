Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98519C4727E
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 18:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F4392086A
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 18:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kbnFNTqf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbgIYSXD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 14:23:03 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56882 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727495AbgIYSXD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 14:23:03 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3D33DF32D3;
        Fri, 25 Sep 2020 14:23:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AYg2J9/0hQt/hP65DQKa5BYmEas=; b=kbnFNT
        qf7MS0ZCTg/9tGdwpLKhnBmYBCNYRaAj72yL2XrJNQO/yyDLUN3x1KkA1llHzLFU
        gu7fRXZg0ffpvH7r3P4uha37eL4SfKmZjWZmB/s6y2jq3xo1KE3Zeo11NpCrZAV3
        1BavwpjSvbOhaYKo3OCDi3QCbbc54i3s5rIS8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mwBaBxpcLyBCGRLU2P4bJHhZBiptFA5W
        NQNXjKkTGxDbhbKXg23LhEqL0JFySZQ2ehpB6oi3gIdDroiXYPb06nffs3ud4scL
        1dQApPAcOLpEN8WxJjRKmNeH0ewMJZPAoFRqDT07X1M9lk+6+/LF+AQBvr2t0dRH
        071DTTu3JA0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 34F1DF32D1;
        Fri, 25 Sep 2020 14:23:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 67600F3268;
        Fri, 25 Sep 2020 14:22:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7Ru?= =?utf-8?B?Zw==?= Danh 
        <congdanhqx@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 09/10] cmake (Windows): recommend using Visual Studio's
 built-in CMake support
References: <pull.738.git.1601044118.gitgitgadget@gmail.com>
        <f07e4216669bcda728668d8c5cc99081bfca9f49.1601044119.git.gitgitgadget@gmail.com>
Date:   Fri, 25 Sep 2020 11:22:56 -0700
In-Reply-To: <f07e4216669bcda728668d8c5cc99081bfca9f49.1601044119.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Fri, 25 Sep 2020
        14:28:37 +0000")
Message-ID: <xmqqd029lnr3.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2369308C-FF5C-11EA-9EA8-843F439F7C89-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> It is a lot more convenient to use than having to specify the
> configuration in CMake manually (does not matter whether using the
> command-line or CMake's GUI).
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  contrib/buildsystems/CMakeLists.txt | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
> index 1eaeb8b8e0..442b4e69ad 100644
> --- a/contrib/buildsystems/CMakeLists.txt
> +++ b/contrib/buildsystems/CMakeLists.txt
> @@ -4,7 +4,17 @@
>  
>  #[[
>  
> -Instructions to run CMake:
> +Instructions how to use this in Visual Studio:
> +
> +Open the worktree as a folder. Visual Studio 2019 and later will detect
> +the CMake configuration automatically and set everything up for you,
> +ready to build. You can then run the tests in `t/` via a regular Git Bash.
> +
> +Note: Visual Studio also has the option of opening the CMake configuration
> +directly; Using this option, Visual Studio will not find the source code,
> +though, therefore the `File>Open>Folder...` option is preferred.
> +
> +Instructions to run CMake manually:
>  
>  cmake `relative-path-to-CMakeLists.txt` -DCMAKE_BUILD_TYPE=Release
>  Eg.

Having the primary case upfront is a good idea.  As we discussed,
our source tree structure (especially the .gitignore we ship) only
supports an separate-dir build in contrib/buildsystems/out, so we
should update the "manually" part of the instruction to guide users
to use the same location.  Perhaps something along the line of the
attached.

Also, after the post-context of the attached patch, there are
mentions of Visual Studio.  Please double check if they need
adjustment, or more preferrably the above paragraph the patch in
question added is all that is needed by Visual Studio users, in
which case perhaps it would be a good idea to remove all mention of
Visual Studio there to avoid sending confusing choices to the
readers.

Thanks.

 contrib/buildsystems/CMakeLists.txt | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 442b4e69ad..0c748949f9 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -16,15 +16,13 @@ though, therefore the `File>Open>Folder...` option is preferred.
 
 Instructions to run CMake manually:
 
-cmake `relative-path-to-CMakeLists.txt` -DCMAKE_BUILD_TYPE=Release
-Eg.
-From the root of git source tree
-	`cmake contrib/buildsystems/ `
-This will build the git binaries at the root
-
-For out of source builds, say build in 'git/git-build/'
-	`mkdir git-build;cd git-build; cmake ../contrib/buildsystems/`
-This will build the git binaries in git-build directory
+    mkdir -p contrib/buildsystems/out
+    cd contrib/buildsystems/out
+    cmake ../ -DCMAKE_BUILD_TYPE=Release
+
+This will build the git binaries in contrib/buildsystems/out
+directory (our top-level .gitignore file knows to ignore contents of
+this directory).
 
 Possible build configurations(-DCMAKE_BUILD_TYPE) with corresponding
 compiler flags
