Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B800C482F8
	for <git@vger.kernel.org>; Wed, 20 Dec 2023 19:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RMYWfISw"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 390AE2F3F2;
	Wed, 20 Dec 2023 14:28:56 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Ap/Zav9MHUbJ7CDEShJbqlXiW1LyC6SgjdSXGW
	y5dZI=; b=RMYWfISwCimsbtzAWPF1/SFjLSdNs4mml6DdOlK9lOv9DXSnndrQ1Y
	lOKINvlTv82GFPGWSGEYnNhp9EO122/aK4N9E6eoUrl/cp4cLKoPIkz6dLTSOGdg
	GG8SsQeImnwIOI+l0Yf0rfFY5FEq9BFXosZGy8o3/hwGCd9BSLdko=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 312BF2F3F1;
	Wed, 20 Dec 2023 14:28:56 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CF3A12F3B7;
	Wed, 20 Dec 2023 14:28:52 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Taylor Blau <me@ttaylorr.com>,  Phillip Wood
 <phillip.wood123@gmail.com>,  Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v3 0/4] refs: improve handling of special refs
In-Reply-To: <cover.1702560829.git.ps@pks.im> (Patrick Steinhardt's message of
	"Thu, 14 Dec 2023 14:36:53 +0100")
References: <cover.1701243201.git.ps@pks.im> <cover.1702560829.git.ps@pks.im>
Date: Wed, 20 Dec 2023 11:28:51 -0800
Message-ID: <xmqqil4ssmfg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 02495598-9F6E-11EE-A057-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> Patrick Steinhardt (4):
>   wt-status: read HEAD and ORIG_HEAD via the refdb
>   refs: propagate errno when reading special refs fails
>   refs: complete list of special refs
>   bisect: consistently write BISECT_EXPECTED_REV via the refdb

With the clear understanding that we plan to make those other than
FETCH_HEAD and MERGE_HEAD in the is_special_ref().special_refs[]
eventually not special at all, this round looked quite sensible to
me.

Let's merge it down to 'next'.

Thanks.
