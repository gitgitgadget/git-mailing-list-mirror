Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599075;
	b=CK0SU7AQFuyTcRtUVerfI2uguTp6ps7E/5Yeu7xQIB+zhejzG46VUThILF78tyESD9Xa
	 eLmUZtQ4eooBJ/E72SC9tFSm6Y8QoBqP8G9YUZXY4a1/QRgDfnAwdTE67CvjLCV82aa2w
	 HhaslV4lLSzQYr5/CstO6WA6+SSZf8QWAlzuLdhj9A9FMQglYtQQNobTGMTEIQJ6duQ2Y
	 cF4whPOrs5oGxVjZtU3yqprpgFispBNzKZ7Y+77JFcMR64Hj+iN+N9HV+l9Cxd/40xpPM
	 U7TCMUDmcnbEQ4641aaTQDx7N36OHHYgHDI1oebZhFe4MbEnvc7PJ9epUSUIIwhspuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599075;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Reply-To:Subject:To:Cc:
	 References:From:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=tWX8SXG1eqc7PIVVnPcx+BUykQ8nE0gAsIbp6rUUokk=;
	b=SnutzlfsErcC9NoFxa6mjUr44JsSp0bxkZ+pCmfYlhV0qEqCEMhLIiuxeGc1408K7eXF
	 AANdpEJ/4kJzUI8P4V0IGiJJ4WggVfQkBKMJMQ24P3Ivuy1jomyioBWeM0SkpDcQVK32p
	 W84LI50J9S/T68AVhF27pb8KIswuVBCD1LSQOSdfURnZJNlFd32Pgng230fJepR6UYPyw
	 bgaXSDQJjdhaZ8fSFQWAs+Al9rxFbCHGDBdLBvOoTV/FE98waA2v/cmYHSNPZjAEV+mGt
	 yHpr5pQRRR5+Ttgm00Oqcb6FRQbgHVeC2x2enRS9T2RWP1N6EtWQVr0fpnQ1C+EaE+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UOvoKSPs;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D4E606A334
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 19:44:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18D4E606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UOvoKSPs
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a35a60499eso9752645e9.0
        for <git@vger.kernel.org>; Fri, 13 Nov 2026 11:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794599073; x=1795203873; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tWX8SXG1eqc7PIVVnPcx+BUykQ8nE0gAsIbp6rUUokk=;
        b=UOvoKSPs1f3WO5MnNWiPFDrDp3PtFIrVZo/r6qMzGAVgu/cr38T9nKd299CNt0vPkV
         pddTQHMCGCO00Yl5hCWVaNhoYjlu7Avx78BiUI6WXamwo7F1+exrY+IqDTON/IKMqr94
         KfHmfmV0PG4qlVJ4D5ahaywEv5SgNKjbGs3KL1M98i1SpwLKdBVKZPnlunexl3zsPX9s
         T1LRNYpcO5B9cqEoHsNLxKlS6IYRAOL2eamR4/azswDnPXZKx27gxHI/R/L4kchtc/Ln
         7q/yju2/QGu+QUH0RIxS+fozMIRzD+DtLWJuyQ3iaXyHlWEeTucd7elxJ9XP1EnwaWYY
         JkjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794599073; x=1795203873;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tWX8SXG1eqc7PIVVnPcx+BUykQ8nE0gAsIbp6rUUokk=;
        b=o6dqLoaqKjixfwDOemGZtF+ixq1Dz3sMJ0nSf8OeoPPKAVgI7i8e17ql8ldvOtiznD
         4UvJerBkJE6DlcHLrW+Esck61ZK/U0cUVnzgzyzes31cr27omMefDo5c73ZHY5n6Od/O
         dSwe8eLh5qgnRyWQgT3HVkhi1LnDsiIg+LIu0a9Gzvwy5UeMamHVsX8uAjGezP2RL1iy
         zfLlONRwX5E5wTAQAcRwz0jEgh9pv5I7E0R8bIVFc8BjtP1XFRCpCWavKcNaCPZa0h6k
         4ALFWi+ch5ZTVlFLx5wky/dbwCmgeg54qNEstOn9htDptP/VeW7Dzj7JUFDpMxs2fuDI
         dxdQ==
X-Forwarded-Encrypted: i=1; AL+hErHTNMVX1spoeQBbzq81UG1l0kTmLsEin1OJgEeqZr10D3q6to94u4lMhUeHBdtPclJpLf4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9owo5Wk+UQZDQkyigme0/24Gs+SF3TNA94Dk7F80NT3Me1jQyN
	nmfijMmT+BUipkvlmeALVzV26HkmP8dM+QeRs/FxUQWsnhKyEa4838jR
X-Gm-Gg: AYBFou0teIlVKNu+oxpDX5Shzce+5IuUR6iIR+eI+fHlWKoovbF28lqrFZCSEIjYX1l
	qlmntdxfQ9/mG89WxdpkIbtwA0W55lOr0p+QY49A7MKztXBXOUY7osyJX5ZqEV0oEnSDJmxA6Of
	hbVqV1HJiP8ZnoX4xgbqnub4rlHfF24jEBOqDu8ulUUSSqMkntIzjme4lcRzKptP+1o5c+tcs5G
	ok/DdYlVx+xTGriu/WctqssYkj7j0QMr+7VDaGV+bshhHcZhdqZqXbWKegJHY30kJOA5gaUzIZV
	a2uBA0EIBi+sX0dsOSceIzlK/1DH+hsSt2mJ3XipLfRT55kAlRIHWvdhfz7pJDwgoT8/GSB6frz
	2wjf7PDDjYWZ3+waRvmfbVMSBxyxnpzI3MYODublVjgmXzNzkVDgcx3fQ24vlHBdkZzztdiqAb7
	7hmwlUH5ihhHdM3RBVZjENhtuS8y4aWv3tSr/oyEM+IMcMsRWu9ucKxjbUWguG6cHBHxtcdWJIG
	6wxIgTO9y0xxlCyUWMZIRk52v3pVRwJpcWM77FzJ2egKJBk+ldxK+8rHKgr+Up80L4iugICKMLr
	7A4MJVRKCqAxzxBRwEHcKuEOpdKHPGcIOruiVsFwv+4fuQRSeqLo4nKicvAo/+UzHWjC4Fb9h8q
	G8z/93j+Sf6f9D5Ez8Nnw5TN1B7WZ
X-Received: by 2002:a05:600c:3b16:b0:4a2:267:25b3 with SMTP id 5b1f17b1804b1-4bb55ab4493mr80303915e9.35.1794599073335;
        Fri, 13 Nov 2026 11:44:33 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb5667a8aesm57822145e9.1.2026.11.13.11.44.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 11:44:32 -0800 (PST)
Message-ID: <1ebac86a-6674-4c6c-bcff-a71c05b26d3f@gmail.com>
Date: Fri, 13 Nov 2026 19:44:31 +0000
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 00/12] builtin/rerere: convert to use subcommands
To: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
 "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
References: <20261027-pks-rerere-subcommands-v1-0-d836c36ce0c5@pks.im>
 <20261111-pks-rerere-subcommands-v4-0-df0c8bf79e16@pks.im>
 <CAOLa=ZTAYtq0K4YfcSBocf-fxadTiaJp+AV5-_6_pbNMBwYQXA@mail.gmail.com>
 <ava6Q1u65ASVeth5@pks.im> <xmqq33t4eh84.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqq33t4eh84.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/11/2026 18:09, Junio C Hamano wrote:
> 
>      $ git checkout ps/rerere-subcommands
>      $ edit rerere.h
>      $ git log --oneline --first-parent master..
>      $ git commit -a --fixup HEAD~10
>      $ git rebase --autosquash HEAD~11
> 
> By the way, I wonder if we can simplify the last three steps in any
> way?
> 
>   * We can use 'HEAD^{/^rerere: convert flags}' instead of counting.
> 
>   * The last "rebase" does not have to be on HEAD~11; as long as it
>     covers HEAD~10 it is OK, but we cannot use 'master' as I am *not*
>     interested in taking any new development from there, and I do not
>     want to worry about what the command would do on the merges the
>     topic has as synthetic base.

So long as you've set an upstream branch, you can use "--keep-base" and 
omit the upstream commit.

Thanks

Phillip

