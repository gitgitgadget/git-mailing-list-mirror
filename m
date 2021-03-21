Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 250CBC433DB
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 18:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBC4261934
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 18:49:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbhCUSsu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Mar 2021 14:48:50 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52799 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbhCUSsk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Mar 2021 14:48:40 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BAD4EA8C53;
        Sun, 21 Mar 2021 14:48:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=7jhy1GM8cB+s
        opwfxcDWEJiVPkI=; b=v/OuUdsRkxhL1uPY6TyRBQ6LMrHBDeXR010RXJM8MwbE
        SKI3QFA1zGeFqlUw3/5lIKjfvJGAV+zXcbUGxHXInIUQX0cz4RbhRW2PmYqzQv8w
        396HB2hvqa7alQ7thgYmSX+ZeXzqzGnuJ69tbbSmjSA4gojWPzCvfX2ejNszB8c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=EvsP/i
        gnr4ib8w8sd6S0BTxWdEBh7L5ckUD/j1B73AXrg+XtDKV2IouSFUlev6Ergr+RR+
        N4Ny4x54TbIqULTGqDIoXWOSNXHVu2uFFa5JgfPLqcm//VMxmbq9kq6x3yg04t4k
        jpytRDahp78qwhfyK5tCgapx00lOr3A1pqRSE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B1CA2A8C52;
        Sun, 21 Mar 2021 14:48:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 417C0A8C51;
        Sun, 21 Mar 2021 14:48:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Georgios Kontaxis via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Georgios Kontaxis <geko1702+commits@99rst.org>
Subject: Re: [PATCH v3] gitweb: redacted e-mail addresses feature.
References: <pull.910.v2.git.1616297564158.gitgitgadget@gmail.com>
        <pull.910.v3.git.1616347731514.gitgitgadget@gmail.com>
        <87r1k8qs73.fsf@evledraar.gmail.com>
Date:   Sun, 21 Mar 2021 11:48:38 -0700
In-Reply-To: <87r1k8qs73.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Sun, 21 Mar 2021 19:26:08 +0100")
Message-ID: <xmqqv99k9wc9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0CF16C34-8A76-11EB-BC87-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> But:
>
>>  sub parse_tag {
>>  	my $tag_id =3D shift;
>>  	my %tag;
>> @@ -3471,6 +3493,10 @@ sub parse_tag {
>>  			if ($tag{'author'} =3D~ m/^([^<]+) <([^>]*)>/) {
>>  				$tag{'author_name'}  =3D $1;
>>  				$tag{'author_email'} =3D $2;
>> +				if (gitweb_check_feature('email_privacy')) {
>> +					$tag{'author_email'} =3D "private";
>> +					$tag{'author'} =3D hide_mailaddr($tag{'author'});
>> +				}
>
> This code seems quite awkward, we've already done the regex match, but
> this code:
>
>> [snip]
>> +sub hide_mailaddr_if_private {
>> +	my $line =3D shift;
>> +	return $line unless (gitweb_check_feature('email_privacy') &&
>> +						$line =3D~ m/^([^<]+) <([^>]*)>/);
>> +	return hide_mailaddr($line)
>> +}
>> +
>> +sub hide_mailaddr {
>> +	my $mailaddr =3D shift;
>> +	$mailaddr =3D~ s/<([^>]*)>/<private>/;
>> +	return $mailaddr;
>> +}
>
> Is going to do it again incrementally, and then just act on a
> search-replacement if we've got the feature enabled.

I think you misread the patch the same way as I did initially.  What
is called in parse_tag is not the "if-private" version---the caller
knows that $tag{'author'} MUST BE an address so unconditionally redact
when the feature is set by bypassing the _if_private variant.

Having said that, I do think

>     sub maybe_hide_email {
>         my ($email, $ref) =3D shift;
>         return $email unless gitweb_check_feature('email_privacy');
>         $$ref =3D "private" if $ref;
>         return hide_email($email);
>     }

this helper is how you would simplify these numerous callers.

>>  	} elsif ($format eq 'patch') {
>> -		local $/ =3D undef;
>> -		print <$fd>;
>> +		while (my $line =3D <$fd>) {
>> +			print hide_mailaddr_if_private($line);
>> +		}
>
> Urm, have you tested this? How does a while loop over a <$fd> make sens=
e
> when $/ is undef, the readline() operator will always return just one
> record, so having a while loop doesn't make sense.
>
> I'm not sure of the input here, but given that if you're expecting to
> replace all e-mail addresses on all lines with this function that's not
> how it'll work, the s/// doesn't have a /g, so it'll stop at the first
> replacement.
>
>>  		close $fd
>>  			or print "Reading git-format-patch failed\n";
>>  	}

All true.  This one is reading from "format-patch --stdout" output,
but for the reasons I mentioned in my review, I do not think it
should touch the 'patch' output at all.

