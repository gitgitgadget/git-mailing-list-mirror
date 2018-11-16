Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D758C1F87F
	for <e@80x24.org>; Fri, 16 Nov 2018 04:07:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbeKPORm (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Nov 2018 09:17:42 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63000 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727142AbeKPORm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Nov 2018 09:17:42 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6B0A5129B62;
        Thu, 15 Nov 2018 23:06:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2pcNAHU8ki9oVbeZ5eJXSS+Z9PA=; b=dhYAnK
        gg/XghGuP8s6dRvk7n+qRi7Sdo6NKOL9hevXgGPlqSKpBaiick53t6DC7UyAYtLz
        qq+urcspCNNEPDNJLyzwjQiJsol5oto08v7aT0sZGfn3xTkQHyYHTJ4eiBHhv6hP
        dbowoqXRvtZWLgTrJhJn19aViT96JD2TPJPsg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jeU+mSuoWiDZ7xVd0VkNQ0iuRZNkGlgx
        W8eSmeekJxiWTa/Hr7R6XQwpybWM9eSNCCd641yTSytv37MIX1YBWN1KLx+2Qz9O
        tUtS88BzqCAhspEDyL/kdqp7q3AePzCEyxjAW42OEvKsIL2+ZYNUSstqkis8AnTr
        CvhHmBAuEfs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 645F3129B61;
        Thu, 15 Nov 2018 23:06:54 -0500 (EST)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D0BB9129B60;
        Thu, 15 Nov 2018 23:06:53 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     yanke131415@gmail.com
Cc:     git@vger.kernel.org, yanke <jiu4majia2@163.com>
Subject: Re: [[PATCH v2] ] INSTALL: add macOS gettext and sdk header explanation to INSTALL
References: <20181115120445.46277-1-yanke131415@gmail.com>
Date:   Fri, 16 Nov 2018 13:06:52 +0900
In-Reply-To: <20181115120445.46277-1-yanke131415@gmail.com> (yanke's message
        of "Thu, 15 Nov 2018 20:04:45 +0800")
Message-ID: <xmqqftw1ll7n.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0D414C46-E955-11E8-BABB-BFB3E64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

yanke131415@gmail.com writes:

> Subject: Re: [[PATCH v2] ] INSTALL: add macOS gettext and sdk header explanation to INSTALL

The above should look more like

	Subject: [PATCH v2] INSTALL: add macOS ...


> From: out0fmemory <jiu4majia2@163.com>

This line is to give information that records who the patch was
writtten by, and later Signed-off-by: line certifies that the person
(which typically is, and in this case also is, the person who wrote
it) has the right to contribute it to the project under the
project's licensing terms.  We want to see the name and address on
these two lines to match.

> * add macOS gettext explanation to get the i18n locale translation take effect in macOS, as the most polular way of gettext
>   install in macOS, the gettext is not linked by default, this commit give a tip on this thing.
>

Please wrap overlong lines to ~70 cols.

Also I am not quite sure what it wants to say.  Perhaps you meant
to say something like this?

	Explain how to make the gettext library usable on macOS, as
	with the most popular way to install it, it won't be linked
	to /usr/local.

I think the part that I had most trouble understanding was your use
of the verb "link"; it was unclear (and I am guessing) that you
meant there are missing links on the filesystem to make stuff from
gettext package available to programs that want to build with it,
and instead your original text (aside from grammatical issues)
sounded as if you were reporting lack of linker flags when building
binary or something.

> * add macOS Command Line Tool sdk header explanation to get correct build in macOS 10.14+, as the CLT not install
>   the header by default, we need install it by self, this commit give a way to install the loss headers.

Similarly, is

	Explain how to install the Command Line Tool SDK headers
	manually on macOS 10.14+ in order to correctly build Git, as
	they are not installed by default.

what you meant?

> Signed-off-by: yanke <jiu4majia2@163.com>


> ---
>  INSTALL | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/INSTALL b/INSTALL
> index c39006e8e7..ed4bd29f8f 100644
> --- a/INSTALL
> +++ b/INSTALL
> @@ -165,6 +165,13 @@ Issues of note:
>  	  use English. Under autoconf the configure script will do this
>  	  automatically if it can't find libintl on the system.
>  
> +    In macOS, can install gettext with brew as "brew install gettext"
> +    and "brew link --force gettext", the gettext is keg-only so brew not link
> +    it to /usr/local by default, so link operation is necessary, or you can
> +    follow the brew tips after install gettext.

Sorry, but I cannot quite understand this overlong and grammatically
unparsable single sentence.  There is no subject for verb phrase
"can install" at the beginning of the sentence where I already got
stuck X-<.

My best guess of what you wanted to say is

	On macOS, `gettext` can be installed with `brew install
	gettext`, but because the `gettext` package is keg-only and
	is not made available in `/usr/local` by default.  `brew
	link --force gettext` must be run after `brew install
	gettext` to correct this to use i18n features of Git.

but now the sentence structure is quite different and I no longer
know if that is what you meant to say.  And it does not help that I
am not a Mac user.

> If not link gettext correctly,
> +    the git after build will not have correct locale translations, english is the
> +    default language.
> +

If my rephrasing above is correct, then these three lines become
unnecessary, I think.

> +  - In macOs 10.14, the Command Line Tool not contains sdk headers as before, so
> +    need install Command Line Tool 10.14 and install the headers with command

	On macOS 10.14, the Command Line Tool no longer contains the
	SDK headers; you need to also install them with the command:

> +    "sudo installer -pkg /Library/Developer/CommandLineTools/Packages/macOS_SDK_headers_for_macOS_10.14.pkg -target".

> +    If not install the sdk headers correctly, git build will get errors blew, factly is
> +    is because of this problem.

I can guess this wants to say "without sdk headers your attempt to
build Git will blow up in your face", but not quite.

	Unless you install the SDK headers, building git will fail
	with error messages like the following:

Perhaps.

> +    ld: archive has no table of contents file 'xdiff/lib.a' for architecture x86_64
> +    clang: error: linker command failed with exit code 1 (use -v to see invocation)
> +    make: *** [Makefile:2369: git-fast-import] Error 1
> +    ld: archive has no table of contents file 'xdiff/lib.a' for architecture x86_64
> +    clang: error: linker command failed with exit code 1 (use -v to see invocation)
> +    make: *** [Makefile:2046: git] Error 1
> +
>   - To build and install documentation suite, you need to have
>     the asciidoc/xmlto toolchain.  Because not many people are
>     inclined to install the tools, the default build target
