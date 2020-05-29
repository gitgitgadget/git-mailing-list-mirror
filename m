Return-Path: <SRS0=mJAO=7L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC552C433DF
	for <git@archiver.kernel.org>; Fri, 29 May 2020 19:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 862BE20810
	for <git@archiver.kernel.org>; Fri, 29 May 2020 19:28:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xeDDPyoK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbgE2T2E (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 May 2020 15:28:04 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55044 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbgE2T2E (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 May 2020 15:28:04 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A870DBDE10;
        Fri, 29 May 2020 15:28:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZBqTQP+95o78i96/wqiCFTqBY1E=; b=xeDDPy
        oKepqCTjMcB0v5OTdC1IIFP/rPlsVuhLy/Xga1psrMV6ightMHfiEo8giZNqMCki
        qiKo3YQ0SDEogQUFj2EyTmDo2neJKAg6KM1gA/NyIu3cKYPSfXy5GnZ7Vneq/dPi
        jH55CuNd6pqB7fqpkUsk76pA0ZzE0daSLklvU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XBLBH2OtfyNX+OredO+aq9nQXHUB+qRo
        BLTtLbjDv5bwEPBkg5W2LrM3/KFNMXjEzyiYI/MhuFGyq1nC7mUHUT7a7rmBCKxV
        LkvvJyprLDdUrfRKrR3nwUvtRMS0jHzc26MbMM9OHS9lRNS40EWfrtzz9a22cx+T
        1cBQiAUC+uE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8F759BDE0F;
        Fri, 29 May 2020 15:28:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B7976BDE0A;
        Fri, 29 May 2020 15:27:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Sibi Siddharthan via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Subject: Re: [PATCH v3 2/8] cmake: generate the shell/perl/python scripts and templates, translations
References: <pull.614.v2.git.1589302254.gitgitgadget@gmail.com>
        <pull.614.v3.git.1590759624.gitgitgadget@gmail.com>
        <f19794fdbc09cc3c57392dc522920f7b01691d88.1590759624.git.gitgitgadget@gmail.com>
Date:   Fri, 29 May 2020 12:27:56 -0700
In-Reply-To: <f19794fdbc09cc3c57392dc522920f7b01691d88.1590759624.git.gitgitgadget@gmail.com>
        (Sibi Siddharthan via GitGitGadget's message of "Fri, 29 May 2020
        13:40:18 +0000")
Message-ID: <xmqqwo4uy20z.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 806EEE52-A1E2-11EA-A18F-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Sibi Siddharthan via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
>
> Implement the placeholder substitution to generate scripted
> Porcelain commands, e.g. git-request-pull out of
> git-request-pull.sh
>
> Generate shell/perl/python scripts and template using CMake instead of
> using sed like the build procedure in the Makefile does.
>
> The text translations are only build if `msgfmt` is found in your path.
>
> NOTE: The scripts and templates are generated during configuration.

OK.

> Changes
> The CMake script parses the Makefile for:
> SCRIPT_SH
> SCRIPT_PERL

Below the three-dash line.

> +#shell scripts
> +parse_makefile_for_scripts(git_sh_scripts "SCRIPT_SH" ".sh")

OK.

> +set(git_shell_scripts
> +	${git_sh_scripts}
> +	git-mergetool--lib git-parse-remote git-rebase--preserve-merges
> +	git-sh-setup git-sh-i18n git-instaweb)

Do we need to have enumeration here, which can drift out of sync
with the reality?  Wouldn't we want to avoid it with something like

 parse_makefile_for_scripts(git_sh_lib "SCRIPT_LIB" "")

too?

> +#perl modules
> +file(GLOB_RECURSE perl_modules "${CMAKE_SOURCE_DIR}/perl/*.pm")
> +
> +foreach(pm ${perl_modules})
> +	string(REPLACE "${CMAKE_SOURCE_DIR}/perl/" "" file_path ${pm})
> +	file(STRINGS ${pm} content NEWLINE_CONSUME)
> +	string(REPLACE "@@LOCALEDIR@@" "${LOCALEDIR}" content "${content}")
> +	string(REPLACE "@@NO_PERL_CPAN_FALLBACKS@@" "" content "${content}")
> +	file(WRITE ${CMAKE_BINARY_DIR}/perl/build/lib/${file_path} ${content})
> +#test-lib.sh requires perl/build/lib to be the build directory of perl modules
> +endforeach()
> +
> +
> +#templates
> +file(MAKE_DIRECTORY ${CMAKE_BINARY_DIR}/templates/blt/branches) #create branches
> +set(hooks_templates
> +	applypatch-msg.sample pre-applypatch.sample pre-push.sample
> +	commit-msg.sample pre-commit.sample pre-rebase.sample
> +	fsmonitor-watchman.sample pre-merge-commit.sample pre-receive.sample
> +	post-update.sample prepare-commit-msg.sample update.sample)

Do we need to have enumeration here, which can drift out of sync
with the reality?  Wouldn't we want to avoid it with file(GLOB) or
something?

> +#templates have @.*@ replacement so use configure_file instead
> +#hooks
> +foreach(tm ${hooks_templates})
> +	configure_file(${CMAKE_SOURCE_DIR}/templates/hooks--${tm} ${CMAKE_BINARY_DIR}/templates/blt/hooks/${tm} @ONLY)
> +endforeach()
> +
> +#info
> +configure_file(${CMAKE_SOURCE_DIR}/templates/info--exclude ${CMAKE_BINARY_DIR}/templates/blt/info/exclude @ONLY)
> +
> +#this
> +configure_file(${CMAKE_SOURCE_DIR}/templates/this--description ${CMAKE_BINARY_DIR}/templates/blt/description @ONLY)

I was hoping that we could drive any build system without having to
have separate rules like the above.  The idea behind all files with
funny double-dash in its name under templates/ directory is:

 - double-dash denotes directory boundary

 - when a template input ends with double-dash, it tells us to
   create a directory

 - leading "this--" denotes "not in a subdirectory but at the top
   level of the generated template directory"

so that each of them knows what the name of the file and directory
hierarchy of the final destination is, and the result of transforming
can be created and deposited at the final place mechanically with a
single rule.

> +#translations
> +if(MSGFMT_EXE)
> +	set(po_files bg  ca  de  el  es  fr  is  it  ko  pt_PT  ru  sv  tr  vi  zh_CN  zh_TW)

Do we need to have enumeration here, which can drift out of sync
with the reality?  Wouldn't globbing for *.po be sufficient?

> +	foreach(po ${po_files})
> +		file(MAKE_DIRECTORY ${CMAKE_BINARY_DIR}/po/build/locale/${po}/LC_MESSAGES)
> +		add_custom_command(OUTPUT ${CMAKE_BINARY_DIR}/po/build/locale/${po}/LC_MESSAGES/git.mo
> +				COMMAND ${MSGFMT_EXE} --check --statistics -o ${CMAKE_BINARY_DIR}/po/build/locale/${po}/LC_MESSAGES/git.mo ${CMAKE_SOURCE_DIR}/po/${po}.po)
> +		list(APPEND po_gen ${CMAKE_BINARY_DIR}/po/build/locale/${po}/LC_MESSAGES/git.mo)
> +	endforeach()
> +	add_custom_target(po-gen ALL DEPENDS ${po_gen})
> +endif()

Thanks.
