Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62A3C203E2
	for <e@80x24.org>; Mon, 25 Jul 2016 16:34:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753301AbcGYQen (ORCPT <rfc822;e@80x24.org>);
	Mon, 25 Jul 2016 12:34:43 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59083 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752611AbcGYQel convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jul 2016 12:34:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 17CC42E971;
	Mon, 25 Jul 2016 12:34:40 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=rZ7uFKwP+6+8
	AM69AfDa7nz7a7E=; b=HsbE71nQmmZu+grTZK66XeKaQMYJ2CRHuELbeoJtNszc
	Bt5lzjepZ3QkR4SAHteGJDfNN/ilRlhq2t58BUMolfqmQ4IW4nNLxbtBAoBbj5gY
	tpBloxRO5wKNiA1a9BAZN1EGIqW+bKfk/CSsabYsIfCl/ryYkqooB7CXOhRtdks=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=lNfm4d
	bNlHsimyq+p0FCm+hlv9QhsuG9VG0Do1XQaRQg6VhPf0I2PBgXiDvW4PqQ4ILVa5
	v97MUrZLmvt0KGBFT/qG4S+VGBd84DXo2mQld8jKickVV2+oBoOPwfknMT9MhpkU
	HOdKcN3tPUZwFSJ3H25Iyi//fJEC29Efh888s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 108B82E970;
	Mon, 25 Jul 2016 12:34:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8656D2E96F;
	Mon, 25 Jul 2016 12:34:39 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Cc:	CLOSE Dave <Dave.Close@us.thalesgroup.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Complex gitweb URL
References: <225e6ff4-178c-cd2a-6a05-b621f0ad4a84@us.thalesgroup.com>
	<5793ADAC.6030009@gmail.com>
Date:	Mon, 25 Jul 2016 09:34:37 -0700
In-Reply-To: <5793ADAC.6030009@gmail.com> ("Jakub =?utf-8?Q?Nar=C4=99bski?=
 =?utf-8?Q?=22's?= message of "Sat,
	23 Jul 2016 19:47:24 +0200")
Message-ID: <xmqqoa5l7k2q.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: AEA5E5EC-5285-11E6-98DE-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jakub Narębski <jnareb@gmail.com> writes:

> Subject: [PATCH] gitweb(1): Document query parameters
>
> The gitweb manpage includes description of gitweb URL structure,
> but it was limited to passing parameters in the path part of URL
> ('path info'), and it didn't include explanation of query parameters.
> ---

I think this weather-balloon patch adds the missing info at the most
natural place in the flow of the document.  An earlier part talks
about a GitWeb URL having <repo>, <action>, <revision>, <path> and
followed by what is called <arguments> after a question mark '?',
but what <arguments> part means and how to formulate it are left
unsaid.

By the way, the title of the section 'Actions, and URLs' needs to
lose the comma, I would think.

>  Documentation/gitweb.txt | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>
> diff --git a/Documentation/gitweb.txt b/Documentation/gitweb.txt
> index 96156e5..301003f 100644
> --- a/Documentation/gitweb.txt
> +++ b/Documentation/gitweb.txt
> @@ -395,6 +395,43 @@ atom::
>  	Generates an RSS (or Atom) feed of changes to repository.
>  
>  
> +Query parameters:
> +~~~~~~~~~~~~~~~~~
> +In some cases gitweb cannot pass a parameter in path part of URL, for
> +example if a filename contains double dots ('..') inside.  All parameters
> +that cannot be passed in that way are put as a query parameter, that is
> +after '?'.

Until this point, the reader hasn't even been told about "filename"
is one of the potential things that can be given to "control the
behaviour of the action", and is left wondering if she has a
filename that does not have double-dots, how it can be passed "in
path part of URL" after reading the first sentence.  Then the second
sentence adds more to the mystery by starting with "All parameters
that cannot be passed" "in that way": what are the possible things
that the users may want to pass?  what exactly is "in that way",
which probably means "encoded as part of the <path>", but it is
unclear how that encoding works (is it just to "concatenate"?).

Or is "filename in the revision" the ONLY thing the above paragraph
talks about, and is the ONLY purpose of the "<path> part" to
represent that "filename in the revision" in the URL?

    .../gitweb.cgi/<repo>/<action>/<revision>:/<path>?<arguments>

The above syntax (taken from the first paragraph of the section)
suggests that <path> cannot be used to hold filename with a colon,
too.  Perhaps "for example if a filename contains double-dots" needs
to become an exhaustive description somewhere, i.e. "(see below for
the exact rules)" added to that sentence?

> +By default gitweb would generate links using query parameters, unless
> +the original URL was using path part, or gitweb was configured to use
> +pathinfo with the 'pathinfo' feature. All gitweb installations recognize
> +URL in either format, so you can use one that is better for you when
> +interacting with gitweb (handcrafting or editing URLs, or creating
> +a program interacting with gitweb installation).
> +
> +Here is the list of some of query parameters, together with their
> +long names (which should help remembering the short name of
> +each parameter):
> +
> +'a' (action)::
> +	The action that will be run.
> +
> +'p' (project)::
> +	The project repository that will be displayed.
> +
> +'h' (hash)::
> +	The object id of displayed object (commit, tag, tree, blob).
> +	In case of files 'hb' (hash_base) and 'f' (filename) might be
> +	used instead.
> +
> +'hp' (hash_parent)::
> +'fp' (file_parent)::
> +'hpb' (hash_parent_base)::
> +      Those parameters define the second object for diff-like actions,
> +      the object gitweb is comparing againts.

There is no mention of "filename" or "path" here, which further
confuses a reader who was told in the first paragraph that these
query-parameters are used when <path> part cannot hold a certain
filename.  Also it is unclear if <revision> corresponds to 'h'ash
in the above.

> +
> +
> +
>  WEBSERVER CONFIGURATION
>  -----------------------
>  This section explains how to configure some common webservers to run gitweb. In
