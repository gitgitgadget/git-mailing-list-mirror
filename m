Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D2E1FF7C7
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 02:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771381555; cv=none; b=Yv/yMeFKrdLIBHr/ncC99DpHuo67mlgwoJI1AOzBy9VPm6JL3945JAapRoJy6NSCNWc3PZXAx+VzaedIIodTGLOT4LgT3z12RL3HA3OXg0fbUTPkEcS6JDMBT9za6skx23umLqDd8dKqCYdIoUa3vR5Gs+AMaduTOtFRsQ3jkCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771381555; c=relaxed/simple;
	bh=N7vm6SuIQDMvRg6PvpPK72oVWJR6UMJMcAGN603my4w=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=jyND1wDdbEhP4zWUZvg/HUmRv0G/Qs00cfZdmLM/APWBe9NeOkIRdX1SYhqOu+LoEDqOqofXjnTZbkfOCUyKWw27+7Gc18orlKBI88YZUBMJbv9jTk5QAHkJFV8z383uA7fjpR5lFtvWrL0LPZgndxy70I+8Ado/0IVR4afCc8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howdoi.land; spf=pass smtp.mailfrom=howdoi.land; dkim=pass (2048-bit key) header.d=howdoi.land header.i=@howdoi.land header.b=RRraoHij; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howdoi.land
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=howdoi.land
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=howdoi.land header.i=@howdoi.land header.b="RRraoHij"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <ask+git@howdoi.land>)
	id 1vsXG3-00GTvi-FN; Wed, 18 Feb 2026 03:25:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=howdoi.land
	; s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
	References:Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=ocwx4s67UWzceKdxq3lbV7zlQlgqd0aXME07odzUnLg=; b=RRraoHijIDIR9hneuk/MvjdjoX
	1CkmJa8mJlf8q2O9W9clZnmRh7cGBphUZ2/sD8ZbpkM5DVgSVONiS1ZP8C2Yb08NNif58HuRvOtQf
	cVsuBMsgIGFJeIwY6cx+0+OFAzmCbGSDI2RVAAcpkGS+rJ0QFRPHoGcEDVzVFoQVN/9qr/QMjO4Zi
	vypg8sNZDJhprxfa39gHZMaojpaeqfP9xrj67qNouVFy6qEfgceQSgu2qCNFZrmIiqbYaGFbgNwRe
	XuvFRjPQEiXY8q58UZLoDjWhJzQlNdlGCrc6jqujdtfoyDLqR9a4mhhecpVs8JXSC/p6StZau7Jae
	pEhBVU0A==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <ask+git@howdoi.land>)
	id 1vsXG2-0007JF-Fl; Wed, 18 Feb 2026 03:25:42 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1204229)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vsXFu-006PSV-Fd; Wed, 18 Feb 2026 03:25:34 +0100
Message-ID: <7f30cd09-30ea-4173-9a7c-38f2c46f9ea9@howdoi.land>
Date: Tue, 17 Feb 2026 20:25:31 -0600
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Colin Stagner <ask+git@howdoi.land>
Subject: Re: [PATCH 3/3] contrib/subtree: process out-of-prefix subtrees
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org, Zach FettersMoore <zach.fetters@apollographql.com>,
 Christian Heusel <christian@heusel.eu>, george@mail.dietrich.pub,
 Christian Hesse <list@eworm.de>, Phillip Wood <phillip.wood@dunelm.org.uk>,
 Junio C Hamano <gitster@pobox.com>
References: <20260215201906.889951-1-ask+git@howdoi.land>
 <20260215201906.889951-4-ask+git@howdoi.land>
 <CALnO6CAK1-+MpvjjPFUCeOEbDQn+R8EG7E8bmHo1XYt_ZMQpCg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CALnO6CAK1-+MpvjjPFUCeOEbDQn+R8EG7E8bmHo1XYt_ZMQpCg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/16/26 15:33, D. Ben Knoble wrote:
> On Mon, Feb 16, 2026 at 4:16 PM Colin Stagner <ask+git@howdoi.land> wrote:
>>
>> Reported-by: George <george@mail.dietrich.pub>
>>
>> Reported-by: Christian Heusel <christian@heusel.eu>
>>
>> Signed-off-by: Colin Stagner <ask+git@howdoi.land>
> 
> nit: "git interpret-trailers --parse" doesn't understand
> line-separated trailers

Will fix in v2.

And I think I'll give b4 a shot, while I'm at it.

