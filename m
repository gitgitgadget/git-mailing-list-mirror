Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793815411;
	b=SPKlntFU1I6/Wpg+EYCD3x094VL/t68dx7eTywMwXMOFAryvsD7LWgQLFQmV+dnB/6oO
	 2kZYuswxB/1pidDUpmLiF3jhsZxyuZ3eqp+jGJNLW2nOOD8KipgduSz7pXnzUacV/TXPG
	 GvofIJR3Qd9j4a0pHMUmwxJXmI+Jhm7t9IFQxd+CYEHohLcQ4K7SfkB/+vRZDThwnhLZR
	 pHbZbk0ERx84S4asbxEsXJgzAbTx/rW1EykY73PXOjindx12edWEBS3TNywSuVhaIjqm0
	 jqsLXhFXOLfRWfTZvlywuOsJjviqr9dwOC05d2XsxtVEx8YBtzh428cOR1TaTpsC0xA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793815411;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Content-Transfer-Encoding:From:Mime-Version:Subject:Date:
	 Message-Id:References:Cc:In-Reply-To:To:X-Mailer;
	bh=YvjThXor/NKDTbGrE23zY0+D0kNFCTMnkq4ZbNvakUc=;
	b=CBoklt8PlULls2Jq1T+HxKTxrj+bwJTGHLlWG3KjnQH71Ty/S8p8CAsGL6EvEtz9/w2X
	 UfspdBUyA3bDucWTd7qG5RY3bP6fpwitc1I9+8Lx9kwXD1devqq8EoRd1O73xwCr04D+M
	 40ZdP2IMtOaDoGUnt7/SxgDEvuWcPFYtKIKqKNrz3br1ipAb1ITKVk0GqI+YHlZ5/JDo3
	 BfTZ+GP6NDlU4ze8wxWt5mJQwKxapct+OcjUm5j77PI0d36H2mQ8eYuHxL+bFewTSlgCr
	 DKMXXpqkTo89Tc9koBTjmS8HNywhvDm/bUfxEiXQlguqEVF/D838dO34igREoTxOOKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="HbZzi7m/";
	arc=none smtp.remote-ip=74.125.224.50
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D7F606A328
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 18:03:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6D7F606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HbZzi7m/
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-6774639a8a4so1098814d50.0
        for <git@vger.kernel.org>; Wed, 04 Nov 2026 10:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793815410; x=1794420210; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YvjThXor/NKDTbGrE23zY0+D0kNFCTMnkq4ZbNvakUc=;
        b=HbZzi7m/goI/zUAFHpvXcFZYmxKaYL0e9TsJ/6oWEC5YNqU6hqW6p7dZ4cDMybZJ9V
         JbMpod+dcd3p96ZTNncwDiOCrVQS15wUoOOoBfbUqxJnxU46dgua4Jf6cnlXsFjVAoh2
         MV1h5lN0NRfHakand84uYWCFmSgjS2TGGJjRdTdcxwS7fSudun5/5DhnxXkX2t6dfZiw
         OOwPbkyw96YGaAvYjZXABL+IjlsmvHtmX9sKFygKmHEzSs2gbgq4h7gmecdnJTbXhgzo
         o4AJlFtC9bK2MIoqjaxjHbGF9oemmk1I4RwiHFGrauB8EWPezKVAni97tJgOsxjn/pnq
         EV0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793815410; x=1794420210;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YvjThXor/NKDTbGrE23zY0+D0kNFCTMnkq4ZbNvakUc=;
        b=a/5llkiENUXR8ajwpasQtcLNXXLsEe6cRhadkbOdu7jsWHe04tgLfc7mINjALMN+Io
         eHdi3hYUgRX1zLw5BjSAtXfNaxiUEkPrEdqkWPOH19mTLgytf99oI/ZSruYRb1ocKh6R
         emM3Hx1e5ovx3Wy59yVPY3W/IH+66fdDrrdneSIyiJCPK42rlwIHXSgk6M2VFEmUtfd3
         zuzFzX0poM3i7J7LIvlbRzKt8gn4mRtpT6DvDub0PKdsJqvn22wKmXFyxUZy23wRQj4z
         p2RPDJQsfPbRUqySpWIaM/H+OEkBWoEl6JHIhAxrrg4a7KFo3xYFUkuq+muVBEDrDTbL
         rfnw==
X-Forwarded-Encrypted: i=1; AKwUvBz62ns8WlmfNTud0xPxys4nKt34QDsz8WrpEb2Rq27/osLtbXsulevVBa1FwDTDKYsN/d4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+txJjQrVVH6ARL+gguSVNmAmpf8gEp4uRx3JfqE9zeLRNqXEl+
	gvDii3m1htsYk1+X+zqkQ32ZSoHMZP98JRNr+9s1VEqSKZQcSZn+2fv3QKRFdg==
X-Gm-Gg: AYBFou1tO2vYdwS+db6Us2C163kEpaWjuQWi8r6zXEmJrsTbm7o3vcN2T4ceO/J9Ch6
	NyDOJ9Ks9vWMatvV6XOCj+huiwpowFfDh0hzLVDNHem+8DJXo1CK1Zj4aH4Pr9FMxkdZFOJ0Eva
	ULtd/tFibLS9F1ovmD9ByFPCdaI34F+ivKmXtf/DT8hBE5NsfNYndTfvQcHUSbdLrFnHp9DhSej
	GoB4xUoHypptCAjEFjnZD53NcC4RVKaFUNNquGVi+XPC7BW40LAcN3pIOZOZ/ossap9nBTSbOKV
	tfIA5U7QxfAhyUQMQVEmXo2sSJWjjZ+0JwV92/1/xaWVdDCXKJnJCiDAvmlmT3is+SbKQG4hAHS
	HzAftuTiU7BMqyrHGJLsY4yO6yjIWhbpEicWrrtL8XlyhpQU3SGNdBee+/Q/O7lAjZy7qyaSbfE
	kUK+8jUSsIZv5R8pBjO913q0Uqppj6kK7xN1hcdj9AW3ENMo2c0hDqpqeNcbfDnPNR7996hLvu3
	4/jCl9ZCd7FI/BTL+jdlmSaU+lPiJUjfc/d1Xm9nzlYR/wgKzirA0hZl4IcXn/lF3/KSpD4qMDB
	mu6Cvl5OxMircVY0h7suOO2knoe//BbTy9ycJJXJsfwj/S+CdjLZqLw51hK8z4fvZZdUa2neYny
	7+FluVpUqbBvjyewZERskvcUHVmkKg5QeBRBtVs6MOBBD4u7t/Q6Vmqok/3kPP7HRdFQ9IFeSpv
	rRxw==
X-Received: by 2002:a05:690e:16df:b0:679:5a5a:727 with SMTP id 956f58d0204a3-67ba504058dmr7098105d50.95.1793815409948;
        Wed, 04 Nov 2026 10:03:29 -0800 (PST)
Received: from smtpclient.apple ([2605:a601:9d46:600:c5d0:c9f2:df6f:9145])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67bee273e69sm1953077d50.14.2026.11.04.10.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:03:29 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (1.0)
Subject: Re: Is anybody using .cirrus.yml?
Date: Wed, 4 Nov 2026 13:03:18 -0500
Message-Id: <185E9620-34CE-4FAC-935B-7C9C68D3563D@gmail.com>
References: <auskIPBRorDxDj6N@pks.im>
Cc: Tuomas Ahola <taahol@utu.fi>, Carlo Arenas <carenas@gmail.com>,
 git@vger.kernel.org, Ed Maste <emaste@freebsd.org>
In-Reply-To: <auskIPBRorDxDj6N@pks.im>
To: Patrick Steinhardt <ps@pks.im>
X-Mailer: iPhone Mail (23D8133)


> Le 4 nov. 2026 =C3=A0 07:28, Patrick Steinhardt <ps@pks.im> a =C3=A9crit :=

>=20
> =EF=BB=BFOn Wed, Nov 04, 2026 at 11:57:52AM +0200, Tuomas Ahola wrote:
>>=20
>> Since b5a9d7afcd (CI: add FreeBSD CI support via Cirrus-CI,
>> 2019-12-20), .cirrus.yml has powered Git's VM-based FreeBSD CI.
>>=20
>> However, with the shutdown of Cirrus CI on 2026-06-01, there
>> don't seem to be any drop-in solutions available to support our
>> usecase---while there exist tools in general to run Cirrus pipelines
>=20
> The three dashes are a bit funny, but okay.

It=E2=80=99s a typewriter convention for an em-dash, which is difficult
to distinguish from a hyphen or en-dash in fixed-width fonts.=
