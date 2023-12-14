Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fS5FfQGg"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877EE11B
	for <git@vger.kernel.org>; Thu, 14 Dec 2023 08:41:19 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 03CEF1CAEE;
	Thu, 14 Dec 2023 11:41:19 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=8Kjlg2k44pQTQA1ZXspqQiGAYqnooP3wxBBgvD
	aXNmg=; b=fS5FfQGgMQXglF7j6gXo7525ObywQchJFcOFSS32Dl8U5+vB7U0VWw
	dRnFhDoomPzytgnYkXrMyjRiYSySkbiiDEberK611tsjxccqfc8/bx5pKh4691Ws
	nzoXfBONKvEKSNQQT9yjRveg7VsBtt9PkwIB0b3ZSLpiZVg+2S5x8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id EE66B1CAED;
	Thu, 14 Dec 2023 11:41:18 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8548A1CAEC;
	Thu, 14 Dec 2023 11:41:15 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,  git@vger.kernel.org,
  Taylor Blau <me@ttaylorr.com>,  Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 1/4] wt-status: read HEAD and ORIG_HEAD via the refdb
In-Reply-To: <ZXrFOtKNLxyT8Csj@tanuki> (Patrick Steinhardt's message of "Thu,
	14 Dec 2023 10:04:58 +0100")
References: <cover.1701243201.git.ps@pks.im> <cover.1702365291.git.ps@pks.im>
	<1db3eb3945432964aabe1c559db4c3ac251e83fd.1702365291.git.ps@pks.im>
	<xmqqle9zqidj.fsf@gitster.g>
	<ac84b1b9-2381-406a-b459-6728bf9f8704@ramsayjones.plus.com>
	<xmqq34w7os53.fsf@gitster.g> <ZXlfeWtDgr1GQFCL@tanuki>
	<xmqqmsuennfu.fsf@gitster.g> <ZXrFOtKNLxyT8Csj@tanuki>
Date: Thu, 14 Dec 2023 08:41:14 -0800
Message-ID: <xmqqy1dwohxx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 99305C0A-9A9F-11EE-A5E3-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>> OK, I somehow got a (wrong) impression that you are very close to
>> the finish line.
>
> You mean with the reftable backend?

It would be a major achievement if we just stop bypassing refs API
to read/write ORIG_HEAD and friends, even if we are still using only
the files backend.  And I meant that I got an impression that you
are very close to that, regardless of the readiness of the reftable
support.
