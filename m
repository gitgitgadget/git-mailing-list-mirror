Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 814C31FAE2
	for <e@80x24.org>; Tue,  9 Jan 2018 18:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935084AbeAIS7v (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 13:59:51 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57644 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932310AbeAIS7u (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jan 2018 13:59:50 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D965FBE4A9;
        Tue,  9 Jan 2018 13:59:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2wxigUWpIhVd5db79LF8NoTkl5U=; b=aECSQ/
        gE0rgUwHBJIIJXA/Zbf4JEW1095mlRua+tX1nw9yyMqjOo+PYGRC2AvghUQveDSI
        VTmYuuLTssnHS9ChFktzD5y69YEzxCrGBnJ/QagqXDcWxyxgx4fNakWellI5GTnP
        9CEc+moUjuyT5/orSJuKblnDgvopZfRQXRxao=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qS4e+IbXkRlBuZJyrXeQ3hp8W58ZPWKE
        liCAeSa5nwNy/Lw2JWpjlN9U1IALH+MkAka7Thahg0a0gquMWB1V3u3esNLZANdZ
        uS9Hrp4Rh0dqRRaWA786grXUyNMTUP6FcTYwWWDQbsrc1L40LZgDJdFWvwin5K7g
        Qor0ByLYOm8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D1CB3BE4A8;
        Tue,  9 Jan 2018 13:59:49 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4A654BE4A4;
        Tue,  9 Jan 2018 13:59:49 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Taylor Blau <ttaylorr@github.com>
Subject: Re: What's cooking in git.git (Dec 2017, #03; Wed, 13)
References: <xmqqzi6mutcc.fsf@gitster.mtv.corp.google.com>
        <ABE531C2-3173-441D-8710-B9B75C97B4F5@gmail.com>
Date:   Tue, 09 Jan 2018 10:59:48 -0800
In-Reply-To: <ABE531C2-3173-441D-8710-B9B75C97B4F5@gmail.com> (Lars
        Schneider's message of "Tue, 9 Jan 2018 13:59:43 +0100")
Message-ID: <xmqqmv1m6eor.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 443E51BA-F56F-11E7-A879-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

>> On 14 Dec 2017, at 00:00, Junio C Hamano <gitster@pobox.com> wrote:
>> 
>> Here are the topics that have been cooking.  Commits prefixed with
>> '-' are only in 'pu' (proposed updates) while commits prefixed with
>> '+' are in 'next'.  The ones marked with '.' do not appear in any of
>> the integration branches, but I am still holding onto them.
>> 
>> You can find the changes described here in the integration branches
>> of the repositories listed at
>> 
>>    http://git-blame.blogspot.com/p/git-public-repositories.html
>> ...
>> 
>> * jk/progress-delay-fix (2017-12-04) 2 commits
>>  (merged to 'next' on 2017-12-05 at 8e62c2b18b)
>> + progress: drop delay-threshold code
>> + progress: set default delay threshold to 100%, not 0%
>> 
>> A regression in the progress eye-candy was fixed.
>
> Hi Junio,
>
> this fixes a bug that affects the Git LFS community (not only
> eye-candy). Would it be possible to get this into Git 2.15.2?

The topic is in 'master' and is a candidate to eventually hit the
'maint' track.  I do not know if 2.15.2 is warranted, though, as we
are getting closer to 2.16 and supposed to be concentrating more on
regression fixes.

Thanks.
