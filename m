Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2CBE1F935
	for <e@80x24.org>; Sat, 24 Sep 2016 17:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934316AbcIXRwo (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Sep 2016 13:52:44 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52057 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755304AbcIXRwn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Sep 2016 13:52:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 566A53FFED;
        Sat, 24 Sep 2016 13:52:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=MD2+4LS29DAS
        k/qoHP5Y8uMiIHA=; b=KeKT8ZovyJ9n38NDymDpxNaAanrMhSB2pRVe8x7upI6m
        fqkJXwDkDALol6o9/2JfFsey8wlKOcyWeib1j1qLyYltEPFROhRSeM2ySnyd5fM7
        iTtU8dz+Q/CkTlmOsxbOIuE+xbMdqw6SeEEdnOyYuYrnTCmFp5btxfxNORNRmeU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=uxd21/
        b3VTILNhFlEWh2jXFEyyOLQC61SY8Y/MgQsxCppLpjcKtrQ013qZc/tV5bhg8B7h
        Sej3KySNrhUZjOymGffJiW4bJssmDY3DHL5KSA/J+c1n+5dErT9sBzApfSRY43cv
        uyHYILcSg+FoLAmp21SgO4CSIy9hQsiBaFxtE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4E2363FFEC;
        Sat, 24 Sep 2016 13:52:42 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C49C93FFEA;
        Sat, 24 Sep 2016 13:52:41 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Cc:     Ian Kelling <ian@iankelling.org>, git@vger.kernel.org
Subject: Re: [PATCH v3 2/2] gitweb: use highlight's shebang detection
References: <2a5aead0-d521-85eb-f304-7091683d8b40@gmail.com>
        <20160923090846.3086-1-ian@iankelling.org>
        <20160923090846.3086-2-ian@iankelling.org>
        <2a4c3efb-2145-b699-c980-3079f165a6e1@gmail.com>
        <946807ff-1570-2d81-1026-06529164f8ef@gmail.com>
Date:   Sat, 24 Sep 2016 10:52:39 -0700
In-Reply-To: <946807ff-1570-2d81-1026-06529164f8ef@gmail.com> ("Jakub
        =?utf-8?Q?Nar=C4=99bski=22's?= message of "Sat, 24 Sep 2016 18:21:57
 +0200")
Message-ID: <xmqqh995yyl4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B0B0B00E-827F-11E6-8FF9-C26412518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jakub Nar=C4=99bski <jnareb@gmail.com> writes:

>> Also, "curling" is not the word I would like to see. I would say:
>>=20
>>   Simple benchmark comparing performance of 'blob' view of files witho=
ut
>>   syntax highlighting in gitweb before and after this change indicates
>>   =C2=B11% difference in request time for all file types.  Benchmark w=
as
>>   performed on local instance on Debian, using Apache/2.4.23 web serve=
r
>>   and CGI/PSGI/FCGI/mod_perl.
>>=20
>>       ^^^^^^^^^^^^^^^^^^^^^^--- select one

or state that all of them produced similar results ;-)

>> Or something like that; I'm not sure how detailed this should be.
>> But it is nice to have such benchmark in the commit message.
>
> Sidenote: this way of benchmarking of gitweb falls between two ways of
> doing a benchmark.

All good comments.  Thanks.
