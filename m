Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CCD8C00
	for <git@vger.kernel.org>; Sat,  4 Nov 2023 07:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KUAlGPlM"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95EEC1BD
	for <git@vger.kernel.org>; Sat,  4 Nov 2023 00:14:31 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 228981C265;
	Sat,  4 Nov 2023 03:14:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=k0dGCiwByiOB
	xlpGNxJ1zUG29nkFVLPSZ1LgGB/7d/o=; b=KUAlGPlMMd3M4iJM0JaYJERYR9sm
	ce5rsMdzvMiCpPWIb4zk4IgbPwLAY10aQXlTLHRZ1EPdIaXIUeyoL7HiCJMVz5UR
	0XDbuYaxrj5rwnv5AtU9XD8t+ah6YTCcHvwLidQAEfWLfUS/rVlnKEjtwQcqlz2d
	YJfC8A4vOUMSU6c=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 1A9EF1C264;
	Sat,  4 Nov 2023 03:14:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.67.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A2D8E1C261;
	Sat,  4 Nov 2023 03:14:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Joanna Wang <jojwang@google.com>,  git@vger.kernel.org
Subject: Re: [PATCH 1/1] attr: enable attr pathspec magic for git-add and
 git-stash
In-Reply-To: <CAPig+cRR0PfWP0_uoevQnctSosb-k9cp3b08-sQNV5OPuQ2tAg@mail.gmail.com>
	(Eric Sunshine's message of "Sat, 4 Nov 2023 02:28:25 -0400")
References: <20231103143508.896745-1-jojwang@google.com>
	<20231103163449.1578841-1-jojwang@google.com>
	<xmqqsf5mgl0r.fsf@gitster.g>
	<CAPig+cRR0PfWP0_uoevQnctSosb-k9cp3b08-sQNV5OPuQ2tAg@mail.gmail.com>
Date: Sat, 04 Nov 2023 16:14:26 +0900
Message-ID: <xmqqfs1mgfcd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 CA63A0B2-7AE1-11EE-AD7C-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Sat, Nov 4, 2023 at 1:12=E2=80=AFAM Junio C Hamano <gitster@pobox.co=
m> wrote:
>> > +                     if ((magic & pathspec_magic[i].bit) && (pathsp=
ec_magic[i].mnemonic !=3D '\0')) {
>>
>> Overly long, with a stylo.
>>
>> Here is what I ended up queuing.
>>
>> +               for (int i =3D 0; i < ARRAY_SIZE(pathspec_magic); i++)=
 {
>> +                       if ((magic & pathspec_magic[i].bit) &&
>> +                           (pathspec_magic[i].mnemonic)) {
>
> Nit: The no-value-added parentheses around
> `pathspec_magic[i].mnemonic` can also be dropped.

Yeah, thanks for spotting.
