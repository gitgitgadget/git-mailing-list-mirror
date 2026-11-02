Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793632844;
	b=aDtb21nFhSTh3xJFvz6ooXFYWz8sEA9n5OxUQ9jljyLwTPcvfm/AsoLP87gZHDRrcZX1
	 1VbRDC+uWx8f4TXzXgxGaRrtm77CXin3+AWGsy/9adrb5Rn2p9zzuJUtyM4f3r5k3/kLO
	 Uew/I8D1mfd+hwD4nO6bhOzLuW5a/14DYmP8uErhAr1Hn6fQDGUthgmBQLPMl6A1c9Wx4
	 2ji26ze6AyO8f9Fm1NMNN0KQQWV49nS6bbzcg0Q9BOEVGzfZiJb7zraXGKB92kL9gkjQ5
	 WNZwnJwA8iLFvB0SRBEmOt4MONyFLLP7CeP0MxVGZmLpDYZMOg7JAln1Ei18aYj8bUA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793632844;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=C8rFTCTNpi6+nUU9LkmAstcAYz5O4c7WJ0WijsEJSdA=;
	b=TixxwIl4KyHFviGnh/GDf1NnmP/Z3KFE59Cxhj/OcRlj2CN+Db067byNHler7K4B2ygJ
	 wEjifY7Ahbskt9NU9X7voZC3kKGsQWljCbDAkLXJQdCHb4l/DI2WdRn0eoNtCUfObclPi
	 65SQfgQWHdCqHnX8ssKjTVxqcSVuNE2vMuypEwSBoa7sHrIljDeRDz9WjHbkBM2eKVrRc
	 wTZT9bAlN/MBehp/mfe+qx911EtFpnKUK0jlflDQ+jGx5oWLy+xVXNRvvIl5O1Ide1NQV
	 eii8HCQJ6ie/FBS7GaVQKUx1g3HCQBQveNsP4O/PK9L4yS+izIqa1KXseFDH7VeVW7Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ne4ElWd9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76602607F104
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 15:20:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76602607F104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ne4ElWd9
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1adbf62dd31so3251645c88.0
        for <git@vger.kernel.org>; Mon, 02 Nov 2026 07:20:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793632843; cv=none;
        d=google.com; s=arc-20260327;
        b=sHyFctO0smwOCNsYpuLTIRUVkLilHOpULTXFB/z06a7BVtbPprSKLsfEVjaLH5tTR9
         1Z4IbbB28MDQj8rbiZ8+SBbjstzWidE4h5KT7S0XVCga6SCS3D/jLb6DDXwYILeWVW80
         8chA/4BLVQYWf+YPNoERM6AEjjiIXs/szSDG1R6zs44R06PupfinJ4PHpJn+lsTcKt5/
         F1aZE7BYE7cnfdbEz2DD2DvmzbV7rEz7RahZW4dC5FR0R+a3ZYcksSdR/b1jzpJ2SP7w
         U6xWu2bJ7BkzvSZ4VV54DmcgsChI/kVdDc9N2aFfrWyfvBLTe1vBJlmOtPmFubFZvkkV
         ZgqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C8rFTCTNpi6+nUU9LkmAstcAYz5O4c7WJ0WijsEJSdA=;
        fh=AkwqM3nf6GiSuNMkyvTMJn2XhHysb/LIuV09ali4XeU=;
        b=Pyqt64vwK94inDsYPUdIIDrL2Un/on5W1F+jicYULmziVTfQ17goAzhCj06VraMh9l
         m6nsZzLjBEk8YwFkRWcGXu6qa0In5FD1AWdfMxQJqGOWAIt0gnQ4vQA24j8rdDKYFIUq
         4bUxH0Q6+5bEyC3AeTKepSw+IkXxIldZjoe/vo4BDgwzxw+6l4bzJEnEQdrEnggG2q5u
         HNekrgqHZK6WTrjrpm59MGa3GkyJDhq1lWdd/pzlcfs30wJj8cddNV7adTwUUatKdPzk
         LD4/wn8QxEtQoZv0/Q0ucaiSyxtnIkJDdN/AeVH4dGgIDEOnx0qouQQgzDXc8AT4LYPX
         DQaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793632843; x=1794237643; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C8rFTCTNpi6+nUU9LkmAstcAYz5O4c7WJ0WijsEJSdA=;
        b=Ne4ElWd9OLSgYy1lHod3K1/jRh1GFjf8liQrzwOHyyC4GcM1hUc8yZxjqGphWps3Zg
         LsDcS+0dPOuGpWMrUuN7PyZo7YNoT729sbPlee0QTZgmYijuHuVtca4CjmEKC4PKZahA
         zjoTbDRVMxfJuMaV8ZoSZFT698yaKt8Xpqfw/ElFhjMFqbsbAHRv5aKhlWpGAdvFAlUh
         SbjMOvIUPtY24sDPl99/bcWREwleFFg/3yGX3fzb7O8xejztmmU908g19rZm0RRzsE9q
         YrccJvpchFtUfGLLHn2Oocq3QCYBAu6u0O8Scvhh4FBJ6/zczYMzGJ1lP0EyDbe0TRyg
         Bs5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793632843; x=1794237643;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C8rFTCTNpi6+nUU9LkmAstcAYz5O4c7WJ0WijsEJSdA=;
        b=RtIGjqiaov6QNXbHP/NN9G83yY3JhC7FZTngpbWkTu9ofCE1d0SOBCSUjqUE1Ub5dx
         Y8JyYaMObuvCJeX8iRhFoM54SS6CXJhHz7LCFDtpO2j594V/FcuSgoE/IlA8/jhX4s3X
         stKROnBJ1mSR6bhmuwAO6yCA0Tg9cHzLGV82PpUU2cQE6pVJ859ELytuFukK6bcLXY6i
         QzbRWVCrGsqUQ9Q/c9HEhI5puZ3fEyZJLvxTOG0F+i/MJmiWtKZQNbg/OePrQFUoqftd
         Ih4hmSkzjlwczG5SdW8aok0P8sI2IJ+P1CAVRxmWS9ESAkc4Aqh3B9Droi9Lq2lNOFwo
         MshA==
X-Gm-Message-State: AFq9FYJJbZLEufmfvRShO7AKI1rNEf4iPDn+t8ha5qwND13A63fGezzN
	Zmko2rqP4EPf2+jp6HWQpkbEKzfyvtMy5XJ/5/hwEZyW/h8rmj32zq0SIoZa7khXWiucS1AbscH
	LCGO4RjtGlRqZdDj1mCjXuqbXKYyZLdM=
X-Gm-Gg: AYBFou2IR445wkWzFF8mJk+z6DvYeLl4SYaZ2ALWw4vkhlnUA54ygnsBMAEgtjZILa+
	y/sHqciiF1Yv65eZRi4PNJ/pvT0MKIvL23u01/gpugbuY6vqNA6R7k2h+IS6VjXt4zwkNT/oSm+
	cgtCfvHBc2jGIiFFSGp6j6wUFsoShTbxNHn9ySz6hDm882DTzEuF5ig9n52vzcYpAY7z9qb7wDV
	4HhdDKjrlUZ3+KqO7hMjesCnQMazb4dewhPmuLViIC7ZVgnBFzI15bZJndXBf1hElBX8ltRZkx/
	hzL1r8uSg7EMqRqFNIXHExVkimrqV06PDex+YyyPRwcOul4XGczHhiqN4/FSyCAVKoalglxTvhq
	bzIoBc13uYTJHt4hCPo+unGIJ5+abxIROOG1WhJHO3p8h1yobwzDIk+o2B/LJO9drZudkYMBM26
	NjZ0hW4Wnxudyfjg51E6LkZWWN9KC00nKUuQ+8+wjR9w1YsMgir7K/i8Y20waBW3rRylZVZPwI0
	vE1CqwVytuaOf6jMhuWJEw/
X-Received: by 2002:a05:7022:29c:10b0:14a:8df8:56b1 with SMTP id
 a92af1059eb24-1ac5cb1870cmr15731204c88.22.1793632843436; Mon, 02 Nov 2026
 07:20:43 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260923080928.1534413-1-christian.couder@gmail.com>
 <20261012074413.337183-1-christian.couder@gmail.com> <20261012074413.337183-3-christian.couder@gmail.com>
 <02ba1b9d-b598-454b-897f-cb33ba190b13@gmail.com>
In-Reply-To: <02ba1b9d-b598-454b-897f-cb33ba190b13@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 2 Nov 2026 16:20:31 +0100
X-Gm-Features: AclHuK-48lUoDU0kc17y_z2HA2Wy7T7E4omWTnYcehICSCi5osBD7X_x2P1fDaU
Message-ID: <CAP8UFD2DN=fYVnj+oxUfN0qX4ur3JySngHXs0rv-fEPsMKOb7g@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] parse-options: extract lookup_long_opt() from parse_long_opt()
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
	Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>, 
	"brian m . carlson" <sandals@crustytoothpaste.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Justin Tobler <jltobler@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2026 at 10:09=E2=80=AFPM Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:
>
> On 10/12/26 13:14, Christian Couder wrote:

> > +static enum parse_opt_result parse_long_opt(struct parse_opt_ctx_t *p,
> > +                                         const char *arg,
> > +                                         const struct option *options)
> > +{
> > +     struct parsed_option found;
> > +     struct parsed_option other;
> > +     const char *stuck;
> > +     enum long_opt_lookup result =3D lookup_long_opt(p, arg, options,
> > +                                                   &found, &other, &st=
uck);
> > +
>
> Would it not be better to consume the `enum long_op_lookup` return value
> via a switch rather than having a set of if statements to cover all the
> cases?

Yeah, it might be a bit better with a switch, so the v4 I just sent
uses a switch.

Thanks.
