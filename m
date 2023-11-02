Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CFB171B5
	for <git@vger.kernel.org>; Thu,  2 Nov 2023 16:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xY0wjHWX"
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0F7123
	for <git@vger.kernel.org>; Thu,  2 Nov 2023 09:28:46 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8D8431B7B9C;
	Thu,  2 Nov 2023 12:28:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ZkA15TffKyJz
	jTXDUKoB6bGb8kG4pLZyEyZWAzu6dEU=; b=xY0wjHWXq4OWPrn/6DUlfuFb/iSA
	TTcs+ht7AaP0icuZV0voXIFytmBKRTIR/yQ3hrtUBv5mcSehatIx9ud8uKt0bk6E
	iA5mPtkDEXAVx8BhDWlu4239nvX2JHrjRZU14CFGQU+ZlcYmo0CdIFqT6Wo1iKM4
	eHriWMIQ8Eh+n58=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 84E041B7B9B;
	Thu,  2 Nov 2023 12:28:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.67.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E70691B7B9A;
	Thu,  2 Nov 2023 12:28:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  git@vger.kernel.org,
  Elijah Newren <newren@gmail.com>,  Phillip Wood
 <phillip.wood123@gmail.com>,  Eric Sunshine <sunshine@sunshineco.com>,
  Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 1/2] git-merge-file doc: drop "-file" from argument
 placeholders
In-Reply-To: <CAN0heSrv7MPcEwkq4uEtv9uBbqm4FLKQLE3gdsEbqKkxPXOj5A@mail.gmail.com>
	("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Thu, 2 Nov 2023 09:53:36
 +0100")
References: <20231024195655.2413191-1-sandals@crustytoothpaste.net>
	<20231101192419.794162-1-sandals@crustytoothpaste.net>
	<20231101192419.794162-2-sandals@crustytoothpaste.net>
	<xmqq8r7howsq.fsf@gitster.g>
	<CAN0heSrv7MPcEwkq4uEtv9uBbqm4FLKQLE3gdsEbqKkxPXOj5A@mail.gmail.com>
Date: Fri, 03 Nov 2023 01:28:35 +0900
Message-ID: <xmqqpm0sm85o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 DFADD2E4-799C-11EE-9FCC-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Martin =C3=85gren <martin.agren@gmail.com> writes:

> Maybe you having a similar reaction a second time makes this smell a bi=
t
> more?

Not at all.  I am perfectly OK with --object-*, not --blob-*, as the
end-user facing option name.  I however strongly prefer to see our
log messages record the thought behind the design accurately in
order to help future developers when they wonder what our intention
was back when the commit was created.

In this case, I want to see that we tell our future selves "even
though we named the option 'object', we plan to support blobs and
nothing else, at least for now".

Thanks.
