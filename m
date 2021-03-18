Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22DFBC433DB
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 20:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F421564F1D
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 20:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232950AbhCRUFs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Mar 2021 16:05:48 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57703 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232940AbhCRUFh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Mar 2021 16:05:37 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2742CB33EC;
        Thu, 18 Mar 2021 16:05:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UVXGaXvQnRDCgNBLt+UCj9nEpro=; b=hYR9v4
        UKQx6se8ONc9q0PwW9ugcF481vPG4EfnGvrbimsiJq1GNfXwB8A+eNQuItiGFeEm
        iAOIPF7XmyD305qHpt1G26bxq1ONAiaUu08XxfLjnhaZeatdMpeXuUMw9MH200do
        Q6ADhF99beoqEhmpQM9BzYy4AsoxEWvu/IfNI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Outw6tc4UGhFMr3qBIPxHqbaJ27Qp/DG
        l8vUumWVnl83DdUZXCBXpJH1yVvxEOOanU7iMUOeMvk31ERPHeaq9e7UtPOpTDye
        rreRkyjR5SkjPEKBNzzvil/M3dPbDc9CuD6qx21R/+36ijXJZLpdJjrkeK7RZ5Qt
        1mzHhjBRdRs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1F920B33EB;
        Thu, 18 Mar 2021 16:05:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 87502B33EA;
        Thu, 18 Mar 2021 16:05:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] INSTALL: note on using Asciidoctor to build doc
References: <20210318112339.38474-1-bagasdotme@gmail.com>
Date:   Thu, 18 Mar 2021 13:05:35 -0700
In-Reply-To: <20210318112339.38474-1-bagasdotme@gmail.com> (Bagas Sanjaya's
        message of "Thu, 18 Mar 2021 18:23:39 +0700")
Message-ID: <xmqqwnu4rzw0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4DD1FC4E-8825-11EB-B13F-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> Note on using Asciidoctor to build documentation suite, with example
> for build documentation in html format.
>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  INSTALL | 6 ++++++
>  1 file changed, 6 insertions(+)

Thanks.  This patch means well, but ...

> diff --git a/INSTALL b/INSTALL
> index 8474ad01bf..3a67f335e0 100644
> --- a/INSTALL
> +++ b/INSTALL
> @@ -239,3 +239,9 @@ Issues of note:
>           http://www.oasis-open.org/docbook/xml/4.5/xsl/current \
>           /usr/share/sgml/docbook/xml-dtd-4.5 \
>       /etc/xml/catalog
> +
> + - Alternatively, if you have Asciidoctor installed (requires Ruby),
> +   you can pass USE_ASCIIDOCTOR=1 to use it to build documentation.
> +   For example, to build documentation in html format:
> +
> +       $ make USE_ASCIIDOCTOR=1 html

Mention of asciidoctor may be a good idea, but this gives an
impression that everything between this new paragraph and the line
that says 

	"All formats require at least asciidoc 8.4.1."

are irrelevant if you choose to use asciidoctor.  Is that really the
case (e.g. is docbook-xsl unneeded with asciidoctor)?

If not, then wouldn't it make the result easier to follow if you did
something along this line instead?


 INSTALL | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git c/INSTALL w/INSTALL
index 9ba33e6a14..d8e75a7c59 100644
--- c/INSTALL
+++ w/INSTALL
@@ -198,7 +198,9 @@ Issues of note:
    Building and installing the pdf file additionally requires
    dblatex.  Version >= 0.2.7 is known to work.
 
-   All formats require at least asciidoc 8.4.1.
+   All formats require at least asciidoc 8.4.1.  Alternatively, you
+   can use AsciiDoctor by passing USE_ASCIIDOCTOR=YesPlease to make.
+   You need at least asciidoctor verison X.Y.Z.
 
    There are also "make quick-install-doc", "make quick-install-man"
    and "make quick-install-html" which install preformatted man pages

