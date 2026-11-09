Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794200962;
	b=h3sz+OzdPG/oQP+ippHjxSr70Xr59dtFqXOvL5z1FpO5YmJTcMqf7+K7Q7Gtk0xNDGBV
	 PEnF3aNq27/4Wh8Wrb22AETtFcdzketHAMN23XqO7RuV7JYEM1GaubF60eXQsBMIlZcmK
	 36HAsFjhviztUwtRpH3lHm01II4QG6CQugP0MrywABFpxy5lISgRMdaoO8ZXGehJbjunz
	 t3rqbq7FV0Roqx0fI7PwVh/pmrcXEalZIu+8rPxuwXMRbVoPTl9oIRRsSLyjzW2FzPrc2
	 xFdHEK2CLdGCFHnmtXOR3GuZ4al8+iLVzNB+J+Eyf16zDjhxOjN+bhsrb4+NJ82Tzig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794200962;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Message-ID:
	 Subject:User-Agent:To:Cc:In-Reply-To:References:
	 Content-Transfer-Encoding:Date;
	bh=MyvCl+qUMeEiHGBkN7ntgzTNmvKDfuXnnddxnBghUsI=;
	b=BSDoGXRMUfLGVkxf0Lx3Qoa7y4/xRVn7/KuUBlRKleq/AmxIfhtWuy9tEJAVHs+tltfy
	 jFqSNlCgfTfnJFWMdJLF+4XnyhdJ0vYGEa5eDPenxnNM62/DZvNtP85mWVmn/5407BmJB
	 m0KbJuWbpL6XzXrgWdiMTAOsqe50ATh3h1khGn4OVgcQUaB5iVyjqiMIGYD9YUN4Ma792
	 B4b6W8w6Im52AUdPCtaOjVZp4G8g0vAsZ8cm15Z8EDfYFoHosbjbreNYbjZ3rjmiO2i2a
	 7jT921wrXceHjnpUv3K2rudS2m1ry/ExKkzcoYRU4txYwnj7yP/Joch0O1//9wqv7Gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WJYUt6Px;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A31606A31C
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 05:09:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2A31606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WJYUt6Px
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-36f8cdd30beso1160355eec.1
        for <git@vger.kernel.org>; Sun, 08 Nov 2026 21:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794200961; x=1794805761; darn=vger.kernel.org;
        h=date:content-transfer-encoding:references:in-reply-to:cc:to
         :user-agent:subject:message-id:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MyvCl+qUMeEiHGBkN7ntgzTNmvKDfuXnnddxnBghUsI=;
        b=WJYUt6PxmQZPAlTdNK56eNF4rk6epnem4DlotQ0alL7NbdcaUkoqH/cyIS/S2Cuot9
         kpoosz6eFYDE2ftcYQimNRogWkUjGeHnsy8y7j7u0MgfjvB1Ac2U/QgUVs/SvwSfwnRX
         N+BDIOSF4C6uOr4tTj1SbSqaz+1n1GBhgazJ9tmW+Ai9KoYix9HW7ZGshZpMoAjZrX74
         37Rcd+NFJwmBLdt9HKJjRYWa8/1kRkPj2MS2/WiYV866ofyIJK1JK/edJfrJ0kcPsL+Q
         KIzK2zzAyOMBp1Hr4SSbe9iiBUAomXL7OaHNuCqamrUrhhvCBv3DzSckCZM2a9Szpi5Y
         TNuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794200961; x=1794805761;
        h=date:content-transfer-encoding:references:in-reply-to:cc:to
         :user-agent:subject:message-id:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MyvCl+qUMeEiHGBkN7ntgzTNmvKDfuXnnddxnBghUsI=;
        b=ZmLjPTS0BTU1BPfW+gt2hHm/HnxjNKPjtaf+M2mwhv27klZhUFBS5Vrny/4farJ+Jy
         neZvM/VBAd+n+DqZDrH2Ir1eLiElPoPbAG9g8VGprSRKei6lXVTQt0oPi6INMgIKr5lP
         ARX8vsaxyMEY7fjZOByXpu9pkxkKh8ulwQg1EQH+3DGjrC4l62CXi0DYeDwSiSW2UHIK
         QGPzfoKsYAHEqfWY7eqWqjSHqRCat0afhoWgqZgBwdyIMHFEUQ16Uu7fCiTVem7x9dfr
         mqRpPljpaE/jtSNMMBPXneFgR+7VS2HxkPu/3HOkXBgrsVoMB3PTN9vPwRCHK8rTvUY9
         ei9g==
X-Gm-Message-State: APuU4Z9+QSIfcNCihSkQ4upf2n5SElFfrbwZOGdpa1lWx8fFTykrPjLx
	qbxC2PIMiL9SjMoABjg+Te+5Y+F2c/9f2+hjvyR545SaPlVcyVnBaV9I
X-Gm-Gg: AYBFou1acE+pX6jt5gyDG8OJGmAXB+oUo7FLzD0lkpYergVJKxFo+lK+wu7afzwJb8p
	1RT06lHni5pmC7w6Uh7gp2Mgnei3ug415fzTHl5UpOfsVhCXM8RzkPviMXlHTopiXKUk9rFswkc
	cORHqWrrpDRy3xFSY3FoPySYMhl168epybZrtPtcHQLWqwJbM+j5E9SRbYMqzZE/MLrcxr4Etbf
	5pDyXRmMrB3PyR9VfMOdRrZ5F6LUz5/r/OnmZp1+ovj7JYh2iORtQ07qd/Jrd5r9ULI28Snrhrf
	Ds8H74PKSwpIbW8DUPyfiUwVVTlHT5qHIYG79V8Stw8kbsfcCUOnIRJi8oLCrK4gSFPD2dR/obr
	WF+25sl7IsEBTjtOHSQSsibOyx6/QL8oihy4FazLFMZ+OJJPbGJrlGbst0EZTvmvQi0+q64Isjm
	AXCQvjggA3AjrUwNz97jBWX2PuzZ88Q5AItJI5wq2HbZSbKhwbWVOpBKvD5zuP0cXvLlqozzrdk
	Bgp/p+ZGtvjCXOCA6Nyeq4QQrvtG4u0hMORdvq6WRYPmplZD702RC8x1bJTXycS/CKIHlO9CN0E
	B+3OEuq33sjVQNo9ILcV/MLg3eQFhH7IlyfdIELgwcChgi8QB13uz5xDqcmqVIeWYVFvUe6IgWT
	96uJ9mCMdqYegfloB+dxF0oLWkw==
X-Received: by 2002:a05:693c:4144:10b0:36f:65b6:d137 with SMTP id 5a478bee46e88-3725e33a3bdmr5974632eec.24.1794200961115;
        Sun, 08 Nov 2026 21:09:21 -0800 (PST)
Received: from [127.0.0.1] (ip68-107-67-45.sd.sd.cox.net. [68.107.67.45])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-372665db733sm9108218eec.23.2026.11.08.21.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 21:09:20 -0800 (PST)
From: jasmeet.bhatia.us@gmail.com
Message-ID: <jerc-18e648444c4a0fd6-bf304-0@gmail.com>
Subject: Re: [PATCH] stash: reuse prepared state when creating stash
User-Agent: jerc/0.5.0
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, deveshigurgaon@gmail.com, gitster@pobox.com, ps@pks.im, leonmichalak6@gmail.com
In-Reply-To: <845be1de-8d12-41c9-996d-038886bde4cf@gmail.com>
References: <20261031200107.285168-1-jasmeet.bhatia.us@gmail.com>
 <845be1de-8d12-41c9-996d-038886bde4cf@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 05:09:19 +0000
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list

Hi Phillip,

On Mon Nov 2, 2026 at 6:14 AM -08:00, Phillip Wood wrote:

> I've got some patches in "seen" [1] that take a slightly different=20
> approach and keep the call to check_changes() in do_create_stash() and=20
> remove it from create_stash() and do_push_stash() instead. That series=20
> also removes a number of unnecessary calls to preload_index(). If you=20
> have time to post a review that would be really helpful.

Thanks for the opportunity to contribute! I'll take a look in the coming da=
ys and let you know any thoughts I have.

Thanks,

Jazz
