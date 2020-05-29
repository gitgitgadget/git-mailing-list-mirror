Return-Path: <SRS0=mJAO=7L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B82FBC433DF
	for <git@archiver.kernel.org>; Fri, 29 May 2020 19:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62FF6207D4
	for <git@archiver.kernel.org>; Fri, 29 May 2020 19:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fJCX+217"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbgE2T1x (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 May 2020 15:27:53 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51054 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbgE2T1x (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 May 2020 15:27:53 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DD304506EA;
        Fri, 29 May 2020 15:27:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0/oZ1qbox53FwWJrPjk1ryhvhAM=; b=fJCX+2
        17IQQB2L6jDZ2eG07oiIEh+omJTZqmP98eTE3Hm6sD2LV+BZAe0ryEVl035N3mjq
        s1jTybnTWuA5mYgg0D+xGKaq6OC1Dy154kfrWLJjlnPu88NTuhZgiRz0Orpa9m1k
        /LE5zjZT6X3JfmpievpdEYHek6as90DLxgdWM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ySCm3cNT20W1XxLlyNAhyv6xI586jFza
        wVTiUuPC47egjhFyqGQP1fYUBrCUS/Rtpblw4vjm5XVH1WmzGE8E4tRtfqEqRsUr
        f0rpqN1hHcJWsael0PKwaE6RotpNiJIn9mvtoOeK9LMgPU9XKfbohnQPTSnX3y4z
        G6kE/SJkDP0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D5178506E9;
        Fri, 29 May 2020 15:27:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5E0C9506E7;
        Fri, 29 May 2020 15:27:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Sibi Siddharthan via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Subject: Re: [PATCH v3 1/8] Introduce CMake support for configuring Git
References: <pull.614.v2.git.1589302254.gitgitgadget@gmail.com>
        <pull.614.v3.git.1590759624.gitgitgadget@gmail.com>
        <09c972de52b35b14a4c6f44b10c3dfc1732b2c7a.1590759624.git.gitgitgadget@gmail.com>
Date:   Fri, 29 May 2020 12:27:49 -0700
In-Reply-To: <09c972de52b35b14a4c6f44b10c3dfc1732b2c7a.1590759624.git.gitgitgadget@gmail.com>
        (Sibi Siddharthan via GitGitGadget's message of "Fri, 29 May 2020
        13:40:17 +0000")
Message-ID: <xmqqy2pay216.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7C0B376C-A1E2-11EA-B5B3-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Sibi Siddharthan via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
>
> At the moment, the recommended way to configure Git's builds is to
> ...
> Note: this patch asks for the minimum version v3.14 of CMake (which is
> not all that old as of time of writing) because that is the first
> version to offer a platform-independent way to generate hardlinks as
> part of the build. This is needed to generate all those hardlinks for
> the built-in commands of Git.

All of the above reads reasonable.

> Changes
> The CMake script parses the Makefile for:
> LIB_OBJS
> BUILTIN_OBJS
> XDIFF_OBJS
> VCSSVN_OBJS
> TEST_BUILTINS_OBJS
>
> By doing this we avoid duplication of text between the Makefile and
> the CMake script.
>
> The CMake script has been relocated to contrib/buildsystems.
>
> The CMake script uses GIT-VERSION-GEN to determine the version of Git
> being built.

Everything after the "Changes" line does not belong to the commit
log, as it is no use for those who read "git log" output and
encounter the "first" attempt to add CMake support there.  There is
no need to tell them that you did things differently from this
version in the past, as they simply do not know what you did in the
previous iterations, nor particularly care about them.

These *do* help reviewers who saw previous iterations, and the space
after the three-dash line below is the right/recommended place for
them.

The above applies to other patches in this series.

> Signed-off-by: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
> ---
>  contrib/buildsystems/CMakeLists.txt | 575 ++++++++++++++++++++++++++++
>  1 file changed, 575 insertions(+)
>  create mode 100644 contrib/buildsystems/CMakeLists.txt
>
> diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
> new file mode 100644
> index 00000000000..8e2b27f44a6
> --- /dev/null
> +++ b/contrib/buildsystems/CMakeLists.txt
> @@ -0,0 +1,575 @@
> +#
> +#	Copyright (c) 2020 Sibi Siddharthan
> +#
> +
> +#[[
> +
> +Instructions to run CMake:
> +
> +cmake `relative-path-to-CMakeLists.txt` -DCMAKE_BUILD_TYPE=Release

The readers can infer from `relative-path-to-CMakeLists` that they
can run this command from anywhere, e.g.

	$ cd $HOME
	$ tar xf /var/tmp/git-2.7.0.tar
	$ cd /tmp
	$ cmake $HOME/git/contrib/buildsystems/CMakeLists.txt

but when given the freedom/flexibility to use it from "anywhere",
they are faced by an extra choice to make.  It may be helpful to
readers to elaborate a bit more to help them decide where in the
directory hierarchy they would want to run this command.  In the
above example sequence, I chose /tmp, but if I used /var/tmp as the
starting place instead, what becomes different?  The answer might
be "resulting 'git' binary is stored in the directory you run the
'cmake' command in", and by spelling it out, it helps readers to
make an informed decision.

> +Possible build configurations(-DCMAKE_BUILD_TYPE) with corresponding
> +compiler flags
> +Debug : -g
> +Release: -O3
> +RelWithDebInfo : -O2 -g
> +MinSizeRel : -Os
> +empty(default) :
> +
> +NOTE: -DCMAKE_BUILD_TYPE is optional. For multi-config generators like Visual Studio
> +this option is ignored

Quite helpful.

> +This process generates a Makefile(Linux) , Visual Studio solution(Windows) by default.
> +Run `make` to build Git on Linux.
> +Open git.sln on Windows and build Git.
> +
> +NOTE: By default CMake uses Makefile as the build tool on Linux and Visual Studio in Windows,

The above makes it sound as if Linux and VS are the only two systems
we care about, but is it really Linux, or UNIX-flavoured systems in
general?  In other words, are we excluding friends on BSD and macOS
with the above?

The above is not a complaint about "exclusion", but is a complaint
about unclarity.

> +to use another tool say `ninja` add this to the command line when configuring.
> +`-G Ninja`
> +
> +]]
> +cmake_minimum_required(VERSION 3.14)
> ...
> +check_c_source_compiles("

The "source" given to check_c_source_{compiles,runs} may be allowed
to be anything, but I'd prefer to see it follow some consistent
style, preferrably our CodingGuidelines (except for git specific
bits like "do not include standard system file but instead just use
git-compat-util.h", which of course should not apply).  This is a
comment not only about the two instances below I use as examples,
but all C-source snippets in this patch.

> +#include <alloca.h>
> +int
> +main ()
> +{

	int main(void)
	{

is how we start this function.

> +char *p = (char *) alloca (2 * sizeof (int));

And the decl of function local variable here would be indented by a
HT like the remainder of the function.  No SP between function name
and the parentheses around its arguments.  NP SP after sizeof,
either.

> +	if (p) return 0;
> +	return 0;
> +}"
> +HAVE_ALLOCA_H)
> ...
> +check_c_source_runs("
> +#include<stdio.h>
> +#include<stdarg.h>
> +#include<string.h>
> +#include<stdlib.h>
> +int test_vsnprintf(char *str, size_t maxsize, const char *format, ...)
> +{
> +	int ret;
> +	va_list ap;
> +
> +	va_start(ap, format);
> +	ret = vsnprintf(str, maxsize, format, ap);
> +	va_end(ap);
> +	return ret;
> +}
> +
> +int
> +main ()
> +{

Likewise.

> +	char buf[6];
> +	if (test_vsnprintf(buf, 3, \"%s\", \"12345\") != 5
> +		|| strcmp(buf, \"12\")) return 1;
> +	if (snprintf(buf, 3, \"%s\", \"12345\") != 5
> +		|| strcmp(buf, \"12\")) return 1;
> +
> +	return 0;
> +}"

Thanks.
