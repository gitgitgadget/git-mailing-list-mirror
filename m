Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B326C78C91
	for <git@vger.kernel.org>; Wed, 19 Jun 2024 14:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718809075; cv=none; b=H64HZdd2RVO0PZGomhiGcuK87cYJknL3jWcu5DzQHN6KaBBHzds9zsVAruSpnYhOK7hJMGSZFAUXvqYpS4nz9adrBu4nZYHYnMbzSRQzJo3FRKjQNqRDxeOKCLIBc9R8uF/kdjEx6jBjljrS9kcK6OYWg+a2XEqMbPUJunW1MrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718809075; c=relaxed/simple;
	bh=mxU4VNRdhGIg1uDk/tr8bAWlRzyXRFJsOcGUw+OP7HY=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=OFeqyIwQ4OOZQe6aH3PeoV1sT4INlx/MSLpNnqbfjU16YYwWoF30qfE79AIbZqbIl4YgGCaG0tnPE9T3teMCkE4/0eAYPYEm5m0o1/02Z9KSnbfgM/q3BkXpWoXJ0dVdPm3Pznio5b1YiP0L7kXEySAjPj6rfMxMb81oRe9ElcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 45JEvhuG3573006
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 14:57:44 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Jeff King'" <peff@peff.net>
Cc: "'Dragan Simic'" <dsimic@manjaro.org>,
        "'Christian Couder'" <christian.couder@gmail.com>,
        <git@vger.kernel.org>, "'Junio C Hamano'" <gitster@pobox.com>,
        "'Patrick Steinhardt'" <ps@pks.im>, "'John Cai'" <johncai86@gmail.com>,
        "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>
References: <20240619125708.3719150-1-christian.couder@gmail.com> <0448495385b009f25a66b0712afb28f1@manjaro.org> <20240619134533.GA943023@coredump.intra.peff.net> <04b714d3e949c30bae0e26231e923fc4@manjaro.org> <CAP8UFD2k9YBoKf_=fj1UKNK+=J-2vMenwt8QyTXXSaf=uX6Otg@mail.gmail.com> <4ba6dececcfb3dcec5c8b7e64657a1ff@manjaro.org> <000001dac256$d804a510$880def30$@nexbridge.com> <20240619145246.GB957055@coredump.intra.peff.net>
In-Reply-To: <20240619145246.GB957055@coredump.intra.peff.net>
Subject: RE: [PATCH 0/3] Advertise OS version
Date: Wed, 19 Jun 2024 10:57:38 -0400
Organization: Nexbridge Inc.
Message-ID: <000701dac259$0a768bb0$1f63a310$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHUvfRzK7z2XC+4Uuecgrzow0tdbQHeqvryAeKNQ2gB48xyzgJwsHEDAZIqZnkBwsPDQQKmZ25zsWqtsIA=
Content-Language: en-ca

On Wednesday, June 19, 2024 10:53 AM, Peff wrote:
>On Wed, Jun 19, 2024 at 10:41:54AM -0400, rsbecker@nexbridge.com wrote:
>
>> >A configuration knob that would allow it to be disabled entirely, or
>> >be enabled with more details to be sent would also be fine with me.
>>
>> While in the code, can I suggest including the OpenSSL version used =
in
>> the build? This came up in at a customer a few weeks ago and they
>> could not answer the question of what git build they were using.
>> Turned out it used the wrong OpenSSL header compared to what they had
>> installed.
>
>At the point you are dealing one-on-one with somebody, I don't think =
protocol-level
>messages like this are the best spot for debugging. But it might make =
sense to teach
>"git version --build-options" to report the openssl version.

Much better idea. Will look into it. Thanks.

