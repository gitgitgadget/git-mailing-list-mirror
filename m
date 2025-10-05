Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8997189F43
	for <git@vger.kernel.org>; Sun,  5 Oct 2025 15:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759679175; cv=none; b=eZanjgQ9BaiBWoTacGMtNYiScXah5enrfGoBZyoDl2BkOiWER+BhRELdQnHzxUVJ+tq7UWeHnqQni7WuMa0tYIA0kP18W+9r5Qlwt4bmKG4urvj+hFHb4Zbsb6NZiGWEKoUQQEcQMgjtTSii6oKLUfJWpuU975b9+8Rm4XBiOzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759679175; c=relaxed/simple;
	bh=ynEPouJSo5chFnamIFEzOVYv9E5iWi+gMhc3rJRoI2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=FgcbIo77mZdVxacrq0dLxpJd4grv2Ism/pws9pm4hF1lbE7L30NV+0/JAm0z2RQQ0I5iJKuByG/nvXG1VJrUNZhps5VAoJIz+tORrw9V3/hxP5VaSpUXPrGP2ERVdnFJAwJI+JnjT4FM66nQFyuCJPsAw8RW5eJOghIT7Pvdxx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=GcCH/USW; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="GcCH/USW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1759679159; x=1760283959; i=l.s.r@web.de;
	bh=M/zfZ2m0yh6x4HRxWYlniJLh0Q1wFx3O1NxKtp4HTgI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=GcCH/USWRZMxBj3d2hewe3Xy14kQ0jEMAi5jnEgqkpS3piGSBSo6ddzyj0h/IAeu
	 62Co6wMnWEzVR1rafgMMu8Q4Kj1i7OxlOBGHuURRa/ZqcXrxvGOMu+hnD+yNWbHD/
	 WNH1SPiyDELedaVLPFo6XXGpX+CLVUD9ljSdtWJjTwx4Cmj81cVoBrqwOykOhGV+p
	 +ObPG+bJxJv5RjpthO8MvhqZ5tuByB5+afK6z5txehDfIqw6cUPtB1rBWRzxsMfaA
	 k6QPfQdHP53gBrR8+SkpQiLF+qEe4eC5CV+6tTVbgmhHD26M60vUASlKC78Hp91mt
	 rhgOebecHORPEGWK+A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.16.132]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N8Vsx-1uASeM1JVh-00rjvx; Sun, 05
 Oct 2025 17:45:59 +0200
Message-ID: <17ef29a7-5214-4729-82eb-92a2af33e465@web.de>
Date: Sun, 5 Oct 2025 17:45:58 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 0/5] add-patch: roll over to next undecided hunk
To: "git@vger.kernel.org" <git@vger.kernel.org>
References: <c72518099a3b465c8761e41210fe3fcb@ukr.de>
Content-Language: en-US
Cc: "Windl, Ulrich" <u.windl@ukr.de>, Junio C Hamano <gitster@pobox.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <c72518099a3b465c8761e41210fe3fcb@ukr.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:a179hVQQgj0vRYNdLHLeN9IWZA2E76Q2u0M18SfpheeR7nJADiP
 FXb3UsguJ5XaPkSDyf0ga2cXsrcOJFqcdt/HHk+BrhlUZYfD7htlSSBLSaGVsEYz0CXxDx9
 Q5tJSdD6R8V1uYyHXh+PraC+pcIeZtMUWZdeWbDgBtTijmOBCfpCIX/J3ESukHXh6aQF6U7
 +1AiZ7PVC/HQIIYO6GGPw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Y513WO0db80=;uOGb5g5yPeXQPzqMs4thfyXSgdC
 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
 xDCMA==

Changes since v1:
- add patches 1 and 5 to address issues that came up in conversation
- split out roll-over of option j
- let options J, k, and K roll over as well
- broader test coverage

  add-patch: improve help for options j, J, k, and K
  add-patch: document that option J rolls over
  add-patch: let options y, n, j, and e roll over to next undecided
  add-patch: let options k and K roll over like j and J
  add-patch: reset "permitted" at loop start

 Documentation/git-add.adoc |  8 ++--
 add-patch.c                | 52 +++++++++++++++++---------
 t/t3701-add-interactive.sh | 76 ++++++++++++++++++++++++++++++--------
 3 files changed, 99 insertions(+), 37 deletions(-)

=2D-=20
2.51.0
