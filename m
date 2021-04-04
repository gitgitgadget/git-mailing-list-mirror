Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02AEAC433B4
	for <git@archiver.kernel.org>; Sun,  4 Apr 2021 00:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8DDD61278
	for <git@archiver.kernel.org>; Sun,  4 Apr 2021 00:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236621AbhDDAqy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Apr 2021 20:46:54 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55147 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236526AbhDDAqx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Apr 2021 20:46:53 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2B374137296;
        Sat,  3 Apr 2021 20:46:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=zXfsXpT4RsaW6rRHVi1QOe2uX
        EE=; b=AxmdbghlK65tyz7KRD4hl3IYsHmTlaRVA6k40b19yx5c7w9PQG9uSxHR3
        MIEbXnyXV9WuXFiADjWIFSmXpueifWkAJPIUtaVLtcJ3HgItHOtIKj63KwAtQYW3
        OormIezcm/8OyVmkRlspTb8fJSmbLPPdSf6ykIYVvXpHDq5/Mo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=ID020FimLnO+EQU0F6q
        Ezer1IiZn0dUCgjq2J5FuCoUv4S5TESIQrCpjJ5Ci0QbCefhD9iFIdT5/3mP/I+U
        thbi7nPvHbHYJ7W76E5YFDKzUm2gm4OXZjBz8tZARYPuRiOq/pwD97yRpuEQbX7+
        9XEOm71IgWZGcxEcAuklkRFA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 253C1137295;
        Sat,  3 Apr 2021 20:46:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5769C137294;
        Sat,  3 Apr 2021 20:46:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Firmin Martin <firminmartin24@gmail.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH][GSoC] user-manual.txt: fix empty heading of introduction
References: <20210402121303.344914-1-firminmartin24@gmail.com>
        <xmqqwntk2xgy.fsf@gitster.g>
        <7530f132-cd72-bb6f-21f1-1ee23ca5e20f@gmail.com>
Date:   Sat, 03 Apr 2021 17:46:45 -0700
Message-ID: <xmqq5z1227wq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3C369136-94DF-11EB-B6F1-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> On 03/04/21 04.22, Junio C Hamano wrote:
>> I would have expected to see "before and after".  Is it too obvious
>> what the postimage would be?  Otherwise, a better presentation would
>> be to show (an excerpt from) diff between preimage and postimage
>> output.
>> Thanks.
>>=20
> Attached is `diff -u` of generated HTML output, before and after this
> patch. The HTML is generated using Asciidoctor.

Unfortunately, that is more-or-less unreadable gunk.  Even for the
first few places that have differences, the output of diff between
raw HTML is not suited to spot that the first entry in the TOC has
changed classs from preface to chapter or how they are treated
differently.

What I did before sending out the message was to generate HTML for
the before and after versions, render them into text and then run
diff on them.  It showed that most changes are the chapter numbering
and cross reference, of course.  This was still hard to see, but at
least it was possible to eyeball what was going on [*].

While Firmin showed only the "before" version of .xml, a diff
between before-and-after versions of .xml turned out to be far
easier to see how the change propagates down the toolchain than
either of the above two.  It would have been  the best to have that,
instead of just the "before" image, in the explanation.

    --- user-manual.xml	2021-04-03 17:36:14.804344928 -0700
    +++ user-manual.xml	2021-04-03 17:36:44.599025868 -0700
    @@ -7,8 +7,8 @@
     <bookinfo>
         <title>Git User Manual</title>
     </bookinfo>
    -<preface>
    -<title></title>
    +<chapter id=3D"introduction">
    +<title>Introduction</title>
     <simpara>Git is a fast distributed revision control system.</simpara=
>
     <simpara>This manual is designed to be readable by someone with basi=
c UNIX
     command-line skills, but no previous knowledge of Git.</simpara>
    @@ -31,7 +31,7 @@
     without any explanation.</simpara>
     <simpara>Finally, see <xref linkend=3D"todo"/> for ways that you can=
 help make this manual more
     complete.</simpara>
    -</preface>
    +</chapter>
     <chapter id=3D"repositories-and-branches">
     <title>Repositories and Branches</title>
     <section id=3D"how-to-get-a-git-repository">

If an updated version is planned, I'd expect it to come with
something like the above indented patch plus a brief explanation of
side effects (i.e. we lost preface and we have renumbered the
chapters) in its proposed log message.

Thanks.


[Footnote]

* The text-rendered HTML would compare like this (just an excerpt).

--- /var/tmp/before.txt	2021-04-03 17:40:07.777307995 -0700
+++ /var/tmp/after.txt	2021-04-03 17:39:51.423836495 -0700
@@ -4,255 +4,259 @@
=20
    Table of Contents
=20
-   [1]1. Repositories and Branches
+   [1]1. Introduction
=20
-   [2]How to get a Git repository
+   [2]2. Repositories and Branches
=20

...

TOC numbering is of course off by one, as the patch promotes the
preface into the first chapter.

...

-   [114]B. Notes and todo list for this manual
+   [116]Todo list
=20
-   [115]Todo list
+                            Chapter=C2=A01.=C2=A0Introduction
=20
...

And of course, we now have the chapter title.

...

    Git is a fast distributed revision control system.
=20
    This manual is designed to be readable by someone with basic UNIX
    command-line skills, but no previous knowledge of Git.
=20
-   [116]Chapter=C2=A01, Repositories and Branches and [117]Chapter=C2=A0=
2, Exploring
+   [117]Chapter=C2=A02, Repositories and Branches and [118]Chapter=C2=A0=
3, Exploring

...

Cross references are all off-by-one, too.
