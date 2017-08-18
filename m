Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A193E208CD
	for <e@80x24.org>; Fri, 18 Aug 2017 16:53:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752499AbdHRQxq (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Aug 2017 12:53:46 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64213 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752392AbdHRQxp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2017 12:53:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 82517940B8;
        Fri, 18 Aug 2017 12:53:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bFMqCUuB0cWBOHhU6Da7sDDHSGg=; b=JyepLO
        uDJMOk1+R/fFHcg+1vDobBBFjTuIe7OACTUX+B+KzsU6q/vF//jJlU8M5FOdMCkH
        s03i6AfqaKUvSGtjeJOrX8uC9E1UZHDm3HTO9gx9tHPPi3ONBSnt8+ac6JBzc4ZY
        uYmQ/z4Oyhc83aCTIjMPHg3mry445wv6tSpqU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YrN1P82bUHluo6vd5S8RNjFeWGVs2lZm
        cEkde4jGNcHw9b2LoEgt8lXL+SPcuRL/d6Lkq2dLSP7pZdtbevQUkWB7d33imNtg
        usjLJe1zDxVM0cyjqEJ6rmnVgFOcyu75YEitpIYdSrd2dVtOsHQ+uylhKvCMtbAF
        N5XLCxsLPXw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 78ABF940B6;
        Fri, 18 Aug 2017 12:53:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CEB7A940B4;
        Fri, 18 Aug 2017 12:53:43 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael J Gruber <git@grubix.eu>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] Documentation/git-for-each-ref: clarify peeling of tags for --format
References: <35df94bc16d9b1436d2110f5d5c54732e5d9a619.1503067851.git.git@grubix.eu>
        <45e7986107a8e8b2f87891c729be8e13043670f3.1503067851.git.git@grubix.eu>
Date:   Fri, 18 Aug 2017 09:53:42 -0700
In-Reply-To: <45e7986107a8e8b2f87891c729be8e13043670f3.1503067851.git.git@grubix.eu>
        (Michael J. Gruber's message of "Fri, 18 Aug 2017 16:51:23 +0200")
Message-ID: <xmqq378oddgp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CB64F988-8435-11E7-B24C-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael J Gruber <git@grubix.eu> writes:

> `*` in format strings means peeling of tag objects so that object field
> names refer to the object that the tag object points at, instead of the
> tag object itself.
>
> Currently, this is documented using grammar that is clearly inspired by
> classical latin, though missing more than an article in order to be
> classical english.

;-)

Thanks, both patches look good to me.

>
> Try and straighten that explanation out a bit.
>
> Signed-off-by: Michael J Gruber <git@grubix.eu>
> ---
>  Documentation/git-for-each-ref.txt | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
> index dac9138fab..bb370c9c7b 100644
> --- a/Documentation/git-for-each-ref.txt
> +++ b/Documentation/git-for-each-ref.txt
> @@ -41,8 +41,9 @@ OPTIONS
>  	A string that interpolates `%(fieldname)` from a ref being shown
>  	and the object it points at.  If `fieldname`
>  	is prefixed with an asterisk (`*`) and the ref points
> -	at a tag object, the value for the field in the object
> -	tag refers is used.  When unspecified, defaults to
> +	at a tag object, use the value for the field in the object
> +	which the tag object refers to (instead of the field in the tag object).
> +	When unspecified, `<format>` defaults to
>  	`%(objectname) SPC %(objecttype) TAB %(refname)`.
>  	It also interpolates `%%` to `%`, and `%xx` where `xx`
>  	are hex digits interpolates to character with hex code
