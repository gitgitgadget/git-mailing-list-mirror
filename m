Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.61.206.94
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794987452;
	b=Ls4APenLiQEu3Id74dJrFYF9C/8ogVd2kWaBjgnn2/4wpmFT/Y7QiB38jpdi1jA6e7gT
	 rMQJzDdTJVpFeILqX7J37v2DUbwAKFWk//kk1e1rbgElkfxzEcwpj5DqnjuddZ/cTpsIC
	 f+x0qMvFZD/HkaYLHiIXLGDQmLItEQEcLAGMwokzm+NbSudChCBQLpMrTWQU8CgJwC28o
	 iu1mCJ7PkwMbppCx2gIvjmYuKPY1dnyFNxuG9hpLbP2W+oesEbfwEV4jTkJuNu7g0gUzG
	 Ubj9nDoumpg30KIKHy4/+fEiD4evDu0ZGGdkggmuB22sjYJm9UfQkIO8xmLLAvD/tGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794987452;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:
	 References:User-Agent:Date:Message-ID:MIME-Version:Content-Type;
	bh=bMBhddYe0bq2pFzIXQsPfsHpd+yMdvMZlG4yYRrVkFo=;
	b=ofmxsMhkKCThrt2ssG4qwUuYrAVMufhR49Nq8MHX/35sUCG1I3AGvenFYEpukFYpoARK
	 iml8EUP2mirTk42Jx4K2uve1XValzWRgUnmQoeIQYmF9IMV0uFd4jw4oM2tQdC/4GNkCn
	 QFIr+tBHv1hZKtvE7GeEmbiEOLYjkfWXLKzatZvPJyvVxUa3xSjq6TBix1mOv3h6noK/q
	 zyNfEqD2XTIarWOVijF2+YUrils35m8n3yqnea+5Ka4SjUBNPeepJWubBbdkAffNA9ybe
	 yxbLrg/eEGAlyGb7nUCkV8SG6SPz7WCESeixiyf6EEjxwWYiVz+O3BepoKYA1jllAGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gouders.net;
	spf=pass smtp.mailfrom=gouders.net;
	dkim=pass header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=U4RLsMtA;
	arc=none smtp.remote-ip=202.61.206.94
Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF68606A31C
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 07:37:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBF68606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=U4RLsMtA
Received: from localhost ([193.175.198.193])
	(authenticated bits=0)
	by mx10.gouders.net (8.18.2/8.17.1.9) with ESMTPSA id 6AI7bQGc1881039
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 18 Nov 2026 08:37:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gouders.net; s=gnet;
	t=1794987446; bh=bMBhddYe0bq2pFzIXQsPfsHpd+yMdvMZlG4yYRrVkFo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=U4RLsMtA9kDnBWoXvwFUTMYotQXcqK8IenM85OaEYxy/TdhOf6TybtCaTDBQo/76+
	 TLDb3cP84WPCeUb/xlIOhJXcO9vZZ0lwr4gJoSGTY7z+Dk50YKUNoto7snWXDy/3dZ
	 CAXosPbdQCDQgICxQuKqkA6iAwrGcnsw7hlnC9XE=
From: Dirk Gouders <dirk@gouders.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] utf8: add display_mode_esc_sequence_len_counted()
In-Reply-To: <xmqqqzgiapp2.fsf@gitster.g>
References: <xmqqmrr7fllq.fsf@gitster.g> <xmqqqzgjcjes.fsf@gitster.g>
	<ghy0arkv39.fsf@gouders.net> <xmqqbj7ncexk.fsf@gitster.g>
	<ghtslfkte4.fsf@gouders.net> <xmqqqzgiapp2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Wed, 18 Nov 2026 08:37:21 +0100
Message-ID: <gh1p8ilhe6.fsf@gouders.net>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Nov 17 2026, Junio C Hamano wrote:

> Dirk Gouders <dirk@gouders.net> writes:
>
>> Meanwhile, I thought: even if the test would be a good idea, the
>> "\033"-test probably is the one that handles most cases.
>>
>> Maybe I will look closer, but not now.  Correctness is more important
>> and I need to work on v2.
>
> It would be nice if you can take this patch over and make it your
> [PATCH v2 1/2].

OK, I will do so, thank you.

Regards,

Dirk
