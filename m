Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A756C04FF3
	for <git@archiver.kernel.org>; Mon, 24 May 2021 18:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D439A613E6
	for <git@archiver.kernel.org>; Mon, 24 May 2021 18:01:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233570AbhEXSD1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 May 2021 14:03:27 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63155 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233676AbhEXSD0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 May 2021 14:03:26 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 116111313D3;
        Mon, 24 May 2021 14:01:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=snyFX2EbR7n3g6u4Np1pCH3fu4zxHIda9sj4+BixISo=; b=SwUf
        Wsi0xd/0BlqVZn1J2KLa8aPG4oXru3GUgKeSGq6K5xEUhzKaU42IqL5IFic6nux3
        B0OHpAdMaCzeLNyeIMwJIHCt1O+PZpXgeb43qbehLMcTWMx9kC0cp6NlJTWxeX4e
        KArCz1uJAOxMZqfHJXzC2L6J4kk/I/9Kc0TlRT4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 099691313D2;
        Mon, 24 May 2021 14:01:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4BFB71313D1;
        Mon, 24 May 2021 14:01:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 00/12] doc: cleanup old cruft and asciidoctor revamp
References: <20210521223701.526547-1-felipe.contreras@gmail.com>
Date:   Tue, 25 May 2021 03:01:53 +0900
Message-ID: <xmqq1r9wj9im.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 20174B0A-BCBA-11EB-8D10-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> This patch series gets rid of old unnecessary workarounds and convoluted solutions.
>
> Additionally it cleanups the asciidoctor-specific code so it ends up much more simpler.
>
> This goes on top of my other cleanup patches [1].
>
> Since v2 there's only one small fix that introduced an extra space after linkgit.

Since v1, I presume?  It seems that the previous round did not
interest anybody (or am I looking at the archive incorrectly???)


In any case, after applying the 5-patch series on 2.32-rc1, an
attempt ot apply these 12 patches seems to fail at the very first
step.

    $ git am -s ./+fc12-doc-build-cleanup-more
    error: removal patch leaves file contents
    error: Documentation/manpage-quote-apos.xsl: patch does not apply
    hint: Use 'git am --show-current-patch=diff' to see the failed patch
    Applying: doc: remove GNU troff workaround
    Patch failed at 0001 doc: remove GNU troff workaround

> [2] https://lore.kernel.org/git/20210521222941.525901-1-felipe.contreras@gmail.com/
>
> Felipe Contreras (12):
>   doc: remove GNU troff workaround
>   doc: use --stringparam in xmlto
>   doc: simplify version passing
>   doc: asciidoc: remove unnecessary attribute
>   doc: asciidoctor: remove unnecessary require
>   doc: asciidoctor: remove cruft
>   doc: asciidoctor: reorganize extensions
>   doc: asciidoctor: use html-prefix only for html
>   doc: asciidoctor: refactor macro registration
>   doc: asciidoctor: improve string handling
>   doc: asciidoctor: split the format from the code
>   doc: asciidoctor: specify name of our group
>
>  Documentation/.gitignore                |  1 -
>  Documentation/Makefile                  | 19 ++-------
>  Documentation/asciidoc.conf             | 20 ---------
>  Documentation/asciidoctor-extensions.rb | 56 ++++++++-----------------
>  Documentation/manpage-base-url.xsl.in   | 10 -----
>  Documentation/manpage-quote-apos.xsl    | 16 -------
>  Makefile                                |  4 --
>  7 files changed, 21 insertions(+), 105 deletions(-)
>  delete mode 100644 Documentation/manpage-base-url.xsl.in
>  delete mode 100644 Documentation/manpage-quote-apos.xsl
>
> Range-diff against v1:
>  1:  371b0ababd =  1:  f9fe40224d doc: remove GNU troff workaround
>  2:  0d55f9dd09 =  2:  eed7d77e1e doc: use --stringparam in xmlto
>  3:  2c2af6bade =  3:  d8bebb37e4 doc: simplify version passing
>  4:  eef11180d2 =  4:  2df412bce6 doc: asciidoc: remove unnecessary attribute
>  5:  573b0995b2 =  5:  3abdeada0c doc: asciidoctor: remove unnecessary require
>  6:  35fceb27ea =  6:  685cd824ea doc: asciidoctor: remove cruft
>  7:  2b4f696ad6 =  7:  7f1fb74a04 doc: asciidoctor: reorganize extensions
>  8:  1860058908 =  8:  bede3d2294 doc: asciidoctor: use html-prefix only for html
>  9:  5fc0a42cec =  9:  2ecd19e4e3 doc: asciidoctor: refactor macro registration
> 10:  c09718f046 ! 10:  6c5e9142c8 doc: asciidoctor: improve string handling
>     @@ Documentation/asciidoctor-extensions.rb: Asciidoctor::Extensions.register do
>      -          "<refentrytitle>#{target}</refentrytitle>" \
>      -          "<manvolnum>#{attrs[1]}</manvolnum>\n" \
>      -        "</citerefentry>"
>     -+        <<~EOF % [target, attrs[1]]
>     ++        <<~EOF.chomp % [target, attrs[1]]
>      +        <citerefentry>
>      +        <refentrytitle>%s</refentrytitle><manvolnum>%s</manvolnum>
>      +        </citerefentry>
> 11:  f4c5c7d593 ! 11:  820bc01e49 doc: asciidoctor: split the format from the code
>     @@ Documentation/asciidoctor-extensions.rb: Asciidoctor::Extensions.register do
>      +      format = %(<a href="#{prefix}%1$s.html">%1$s(%2$s)</a>)
>           elsif doc.basebackend? 'docbook'
>      -      process do |parent, target, attrs|
>     --        <<~EOF % [target, attrs[1]]
>     +-        <<~EOF.chomp % [target, attrs[1]]
>      -        <citerefentry>
>      -        <refentrytitle>%s</refentrytitle><manvolnum>%s</manvolnum>
>      -        </citerefentry>
>      -        EOF
>      -      end
>     -+      format = <<~EOF
>     ++      format = <<~EOF.chomp
>      +      <citerefentry>
>      +      <refentrytitle>%s</refentrytitle><manvolnum>%s</manvolnum>
>      +      </citerefentry>
> 12:  96e981b97f = 12:  69de00c9ee doc: asciidoctor: specify name of our group
