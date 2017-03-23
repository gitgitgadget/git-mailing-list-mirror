Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9C1E20958
	for <e@80x24.org>; Thu, 23 Mar 2017 17:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754167AbdCWRQp (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 13:16:45 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58259 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752070AbdCWRQo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 13:16:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F0DBE8AD40;
        Thu, 23 Mar 2017 13:16:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=3dDvAgNmfuhk
        Uu8qmp77ybFjeEs=; b=p/HrOQRi5993f46WfpA+2yscJLht2o2fLgmFaDsrc1D4
        ksgeKEja6A/SqMYG+2oXBxD8YaKSqNCuioeqpsUGvlQoiikGDQAIfQTgQETu4R2g
        tyU9C+g+ONo8gFC+aqy5lJ2TjFhwXjQmquD9IKCbawA0HyvGZ2r+mTlR1IhWw7U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=PFHZ4k
        KiRtbD8xqqC6JUMbfRQV1V29aHpxi2MKC6NV6OSj1+vpceCOg7ExLenE1Y65v8op
        U6Twp9cD2SoWI8NwI9gVxMPqP5510EZwYlMKgo3QWhB5B5Y69O84vS99fpiOJdAn
        feWovZuwadvSdfN9D/8ealx95pf0+JPcpbkCU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E76848AD3F;
        Thu, 23 Mar 2017 13:16:42 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4ADE68AD3E;
        Thu, 23 Mar 2017 13:16:42 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Lars Hjemli <hjemli@gmail.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v3 11/16] tag: change misleading --list <pattern> documentation
References: <20170323130529.11361-1-avarab@gmail.com>
        <20170323130529.11361-12-avarab@gmail.com>
Date:   Thu, 23 Mar 2017 10:16:41 -0700
In-Reply-To: <20170323130529.11361-12-avarab@gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 23 Mar 2017 13:05:24 +0000")
Message-ID: <xmqqpoh7eww6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7BECBBB0-0FEC-11E7-A830-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> --l <pattern>::
> ---list <pattern>::
> -	List tags with names that match the given pattern (or all if no
> -	pattern is given).  Running "git tag" without arguments also
> -	lists all tags. The pattern is a shell wildcard (i.e., matched
> -	using fnmatch(3)).  Multiple patterns may be given; if any of
> -	them matches, the tag is shown.
> +-l::
> +--list::
> +	Activate the list mode. `git tag <tagname>` would try to
> +	create a tag, use `git tag --list <pattern>...` to list
> +	matching branches, (or all if no pattern is given).
> ++
> +Running "git tag" without arguments also lists all tags. The pattern
> +is a shell wildcard (i.e., matched using fnmatch(3)). Multiple
> +patterns may be given; if any of them matches, the tag is shown.

Reads much easier, especially with two separate paragraphs.  The
first one may want to match what I suggested for the "branch"
update, though.

Thanks.
