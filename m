Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB40E1F731
	for <e@80x24.org>; Fri,  2 Aug 2019 16:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733030AbfHBQmq (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Aug 2019 12:42:46 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63461 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729353AbfHBQmq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Aug 2019 12:42:46 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 708D616D02A;
        Fri,  2 Aug 2019 12:42:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jQHGihFQmW8Rgzq5zAtLEQ05lqw=; b=G/rTyR
        mOuyZJShlQCDNmHA/ZAmZf0RZt9FIGqtnwmm2BsQChQI/QGgRHn9fjtRD+tU/sWe
        sgJcFoiLm8hd4Rykn3HSPM5+C6GN8/LtYjwlFRJOSTnpXfsFlUc0RxxXVpaOIJXP
        Q3hEudMr0JukijyV853QZxpOGW53E9OXWT9Sc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uJu7srJN5KQD/zyjcoYpjb8sgR5OHFjt
        K+MBu4Io3wJd6sk1KOR/2cf8qv3yLItFn+2cVwvlK/AOEzQZKel1vxApMjqysjuE
        a3Lm+ecsZL2VH2XbDziWgYIrj5ghyl2O8c8GK3KVwGwmspCKeyTk8kOavPByEHZ5
        I+OiBiKdB7w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6894A16D029;
        Fri,  2 Aug 2019 12:42:41 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AA6CC16D028;
        Fri,  2 Aug 2019 12:42:40 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: js/visual-studio, was Re: What's cooking in git.git (Aug 2019, #01; Thu, 1)
References: <xmqqv9vgmz2f.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1908021405450.46@tvgsbejvaqbjf.bet>
Date:   Fri, 02 Aug 2019 09:42:39 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1908021405450.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Fri, 2 Aug 2019 14:06:35 +0200 (CEST)")
Message-ID: <xmqqk1bvlds0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8B12195A-B544-11E9-B6B9-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Thu, 1 Aug 2019, Junio C Hamano wrote:
>
>> * js/visual-studio (2019-07-29) 23 commits
>>  - git: avoid calling aliased builtins via their dashed form
>>  - bin-wrappers: append `.exe` to target paths if necessary
>>  - .gitignore: ignore Visual Studio's temporary/generated files
>>  - .gitignore: touch up the entries regarding Visual Studio
>>  - vcxproj: also link-or-copy builtins
>>  - msvc: add a Makefile target to pre-generate the Visual Studio solution
>>  - contrib/buildsystems: add a backend for modern Visual Studio versions
>>  - contrib/buildsystems: handle options starting with a slash
>>  - contrib/buildsystems: also handle -lexpat
>>  - contrib/buildsystems: handle libiconv, too
>>  - contrib/buildsystems: handle the curl library option
>>  - contrib/buildsystems: error out on unknown option
>>  - contrib/buildsystems: optionally capture the dry-run in a file
>>  - contrib/buildsystems: redirect errors of the dry run into a log file
>>  - contrib/buildsystems: ignore gettext stuff
>>  - contrib/buildsystems: handle quoted spaces in filenames
>>  - contrib/buildsystems: fix misleading error message
>>  - contrib/buildsystems: ignore irrelevant files in Generators/
>>  - contrib/buildsystems: ignore invalidcontinue.obj
>>  - Vcproj.pm: urlencode '<' and '>' when generating VC projects
>>  - Vcproj.pm: do not configure VCWebServiceProxyGeneratorTool
>>  - Vcproj.pm: list git.exe first to be startup project
>>  - Vcproj.pm: auto-generate GUIDs
>>
>>  Support building Git with Visual Studio
>>
>>  The bits about .git/branches/* have been dropped from the series.
>>  We may want to drop the support for it, but until that happens, the
>>  tests should rely on the existence of the support to pass.
>
> As of v2, the tests rely on that existence again.

Yup.  I think they are now in good shape to be among the first to
graduate post release.  Building the warning facility necessary to
start dropping the $GIT_DIR/branches/ support would be too late for
this cycle, but now this topic is independent from that, so it may
even be worth considering to have it in the upcoming release.


