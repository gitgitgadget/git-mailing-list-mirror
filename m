Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.182.105.248
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795091291;
	b=ucYpYiYp1JG6ZvsgWM0RbxM/4VEsu/Wt0rmVvaJrOpyRAcliLo4+0KY64P/ea9dhDNZo
	 Nxc34cQx5dOOhtTW1IG5i7G/CZ8Kw8au56Kj4oGAC7XSj9WavjHGMckQk/NHqo4fm4/VZ
	 ymiLzooROaBBfDv8eteqpm3R2iXXQ219qI6y24O4vTzYVzkc6oOf1iXlcAGD/sApu6Rmu
	 +ijOnxj7t/peaLLctsdcSYND966DVgEWH7/SvqOtS7zD8O51IF4u5Z5our5xI/J2EGUEG
	 hKOFptqoMja7WBHhF/IJui9k/ZL34hJdc9th7HvYhpw/SNqxp/qEbctHHs9S3ukMixw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795091291;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Subject:Message-ID:
	 Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=9JTWQyq4Oc4zc3Y44CXKeLLnHG3bqNXo08Wd80DZyg0=;
	b=bLVMv9U4NAL/hqdKGQE03ad67xArtGQR3AYlzgPMdL9iH+D2BiXbfSx7Zx4cFwRV8SVq
	 48DDAO4jfJSewPF4yiAH4p8TUIjx7xL8VPpafLTvV17B7XEMf0asDHF9ZHE8pWpg7uwPY
	 T8tqBpBw6tIXf1MSuR0ZuWt+3kBORAuGEtNjzARB9sb89DTUT5FVFbg+gVAQgt+sKI6r5
	 IfWX1wNtKIQ5SjveKLdgFT+JLsrjiNdfxcmOCY2M4xea4Suniao0KVTjU8oIINyKOsUYo
	 2Pl1v/j+2e4+b+jv8CxirMdBwTFbOEE7Uxoe33ssen41rFa23Le0U4IohEsG7g6Ubjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=topo.tw;
	spf=pass smtp.mailfrom=topo.tw;
	dkim=pass header.d=topo.tw header.i=@topo.tw header.a=rsa-sha256 header.s=selector1 header.b=SH6PJcoZ;
	arc=none smtp.remote-ip=202.182.105.248
Received: from mail.topo.tw (unknown [202.182.105.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9541606A338
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 12:28:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9541606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=topo.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=topo.tw
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=topo.tw header.i=@topo.tw header.a=rsa-sha256 header.s=selector1 header.b=SH6PJcoZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=selector1; bh=9JTWQyq4
	Oc4zc3Y44CXKeLLnHG3bqNXo08Wd80DZyg0=; h=in-reply-to:references:
	subject:to:from:date; d=topo.tw; b=SH6PJcoZH/ymCCahmj8T96THO3vfn8faDHW
	fkY0woPjDBUpYGlruSqkrofqU5fVLbtb749sztCbFNxg9xkVmymVhmOXxez9VS9Rsrg2R3
	ZDVExISN4AiyokxkVIewx+I3CkwERzQoXoxbB1AI2UZXBMWa1zTnb5uVU3/MtcbDBFfnm7
	AACoAnDySBQ0hhLB7oKH676PzecjvQx8XhPhu5SE9ekvDk6y7dSw9ky3vHLoE1PQtN902P
	jVL0atPjiKI0gLyc3dB0calhljpUcsm+KcYqZEDFeCy+xPZZJGpMgKRgY1knWmCXFLCHoa
	x5meEAeLTBm71Jz3j+/yYcz28QNumr1fytrqF2L548Cfi415aN1cifAzy0sc5UgMZcIE1G
	GYJE4lk4wlEkypAjZCtDfaKorZqjfsiBHVTVNyRlo9TpiOC6D5jzDJTrvXyaVCOphHo02z
	NvOfq8aT39pZs6oe6GAbhnUJrQ2rYdjwv2gmzVQhiIXFCULmKmOTC0hVmXiOUVlt4p2k2P
	ehbUzu/O87AGKed7gAM027Dj0x3nKXSR1TB0u9A4sSJKe5FXc3HXp+W7kAlM12FAxDHYJT
	pZUB8W+hjmdxB4ufBccpfr/0etbzrbWXq1oTGNpn1M6ZCcOhqKr5rd+Ynms3eQje3ucfqx
	WSbR9F6j2pgW4uU1Y8=
Received: from dell (<unknown> [204.19.202.105])
	by mail.topo.tw (OpenSMTPD) with ESMTPSA id 081e81ff (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 19 Nov 2026 12:28:03 +0000 (UTC)
Date: Thu, 19 Nov 2026 08:27:59 -0400
From: =?utf-8?B?6Kyd5pmJ5Yeh?= Hsieh Chin Fan <kernel@topo.tw>
To: git@vger.kernel.org
Subject: Re: Branch Awareness
Message-ID: <av7rT2dKR1zguMeN@dell>
Mail-Followup-To: git@vger.kernel.org
References: <CAA8YNQAsyUe275DLPRnB4dym5aq9ZyemA39u+HJciKzat5tNQA@mail.gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA8YNQAsyUe275DLPRnB4dym5aq9ZyemA39u+HJciKzat5tNQA@mail.gmail.com>

.gitignore is itself a tracked file. A merge from feature into main
would also merge the branch rules. This makes the rules hard to reason
about.


What Git already provides based on .git/config:

# .git/config
[includeIf "onbranch:feature/**"]
     path = .git/feature.config

# .git/feature.config
[core]
     excludesFile = .git/feature.ignore    # contains: settings.py

$ git switch main        ; git status -s   ->  ?? settings.py
$ git switch feature/x   ; git status -s   ->  (nothing)


On Thu, Nov 19, 2026 at 11:54:02AM +0200, Jordan K wrote:
>I have a situation at my current workplace that led me to consider this feature:
>
>We crudely pass around a `settings.py` file that doesn't match the one
>stored in our `main` branch, as many workplaces do.
>
>Feature request:
>Allow `.gitignore` branch awareness, so that changes/the existence of
>a specific file are ignored in all branches that are not
>`specific-branch-name` or ignore the file in ONLY
>`specific-branch-name`
>
>Sor of like a whitelist/blacklist flag (there should be an option to
>use either).
>
>I think this is an impactful feature, as many git users have
>situations where they need to ignore Django migration files, local
>settings files, compiled binary changes, etc etc but those files _do_
>need to exist and be included on the staging/main branches
>
>Regards
>Jordan Kadish
>

-- 
謝晉凡 Hsieh Chin Fan
site: https://topo.tw/about
timezone: GMT-4
