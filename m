Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7373F20248
	for <e@80x24.org>; Sat, 30 Mar 2019 18:04:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730686AbfC3SEZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Mar 2019 14:04:25 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58529 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730203AbfC3SEY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Mar 2019 14:04:24 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7080F45ABB;
        Sat, 30 Mar 2019 14:04:22 -0400 (EDT)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; s=sasl; bh=U38Z5HDg14UCt
        7eAo4nYI3vR13E=; b=MkOc2jnTlzlRuFGEDnjEndqMSLVXm5azh690oA5s5s/V4
        Pn2mCyV7OjZ3wV7hnFr+p9DE5wo0vdju38fu2hRq0ClFBJMKqEBpDP2c8qKq3Ab+
        QaYWVxLDhHVJAh71O7SMwX/ocK/1svp9hw4UNbcNkf4WyRrJBsxt1tWcgH0FAc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; q=dns; s=sasl; b=E5fBYRU
        R5xsLmNWnb/k1SHyCQ5ZXBPAtGNE3dTpoC6Y++IEBcDaPh1E8pzhoevXxxgfsnQr
        fqQojWmBUnlkZCg9xIKn6k5fb26B4EhiEl8FOLaCo+DW1HGcdHpCelGAZC73qcw7
        InjjZN8SW7pJK0Bq7fvZiQgRm2fKA3xbICKA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6841B45ABA;
        Sat, 30 Mar 2019 14:04:22 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Received: from pobox.com (unknown [173.67.141.44])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A6D3945AB8;
        Sat, 30 Mar 2019 14:04:18 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Date:   Sat, 30 Mar 2019 14:04:15 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Matt McCutchen <matt@mattmccutchen.net>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 04/11] gc docs: include the "gc.*" section from
 "config" in "gc"
Message-ID: <20190330180415.GC4047@pobox.com>
References: <20190321205054.17109-1-avarab@gmail.com>
 <20190322093242.5508-5-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190322093242.5508-5-avarab@gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Pobox-Relay-ID: 3D43D8A2-5316-11E9-983E-EE24A11ADF13-09356542!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi =C6var,

=C6var Arnfj=F6r=F0 Bjarmason wrote:
> diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
> index 66386439b7..c037a46b09 100644
> --- a/Documentation/git-gc.txt
> +++ b/Documentation/git-gc.txt
> @@ -45,28 +45,12 @@ OPTIONS
>  --auto::
>  	With this option, 'git gc' checks whether any housekeeping is
>  	required; if not, it exits without performing any work.
> -	Some git commands run `git gc --auto` after performing
> -	operations that could create many loose objects. Housekeeping
> -	is required if there are too many loose objects or too many
> -	packs in the repository.
>  +
> -If the number of loose objects exceeds the value of the `gc.auto`
> -configuration variable, then all loose objects are combined into a
> -single pack.  Setting the value of `gc.auto`
> -to 0 disables automatic packing of loose objects.
> +See the `gc.auto' option in the "CONFIGURATION" section below for how
> +this heuristic works.

Did you want this "gc.auto" to use the differing left and
right accent/quote characters (which asciidoc renders as
single-quotes and asciidoctor as double-quotes) or should
the closing "'" instead be "`" to render "gc.auto" as
monospaced text?

I suspect it's the latter, as that matches most of the other
variable names in the docs.

I noticed this while comparing the output from asciidoc and
asciidoctor.  I've got a few similar changes queued up as
minor fixes to lower the diff between asciidoc/tor but I
wanted to check whether you intended this one before I sent
a patch to correct it. :)

Thanks,

--=20
Todd
