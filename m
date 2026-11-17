Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794927796;
	b=XfGsGfc+DSpo0/niwjitTq0QibPV54MRE1017fEiewKGx0VxilBMrCDGqhmAHYnUDe1G
	 IUIwOQvmSiEt1gIkCqOZnnt7mebcbqPYg3BMC3YVFA50cdgKUHv3kBgQ6NCM17vv+Ov38
	 Kpmcowa8Dcr9HLbH56TNHScHj2jmkJu7cb4r5UPLyeJbtvbjapy9yW2GwKS6N+YAWY5cz
	 XWd6DK9Tv1ZazCJgZnIEXQm91XQQSiUUlBwmZp+VUmd9tEfk2zEni8QfaLpTKzRBP9xN/
	 cOSq4+fKEl4iBGjHQ0XJbrpXp7TF+HyO1gGrkwcfvtV+TaoAbzc2yuyYF22QDxrjyqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794927796;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Reply-To:Subject:To:Cc:
	 References:From:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=k+lkveR7Zm36eh/Ot3kb9tHGq1twjrKFozVaGUG7B/8=;
	b=CURYjTqQMGsbZeGZs7IqBIVk2HyfFxmr4ivSnuWA05ECeGjczVOL/QPcpI7xlzzzD88a
	 yqO18yVA3rBTI6nxSvDT8tFKCBLrN77VTt6hyzBTNljFqpo/8U29e9Ew8gGg/PzioSwg0
	 OCXkjHEzFV3toZtuPghbr6Xotu7v0qCKYW/6nbHiswzW/GX4RuTG91jtklP+Rzl1DHTxp
	 cXp+TX7RYtIiHiafi6hsERtjVF80+Ga6vlzIAVK4VdKhaS0B5MrbLEcFpUus2LjYlwP/6
	 Fr8+wqk+2iGsoB/z6M09HGcnJ+8pw4Hv5jrPlbMcg+TfSiUCFTwoMoeRP8+lCl/yLjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="yq1W/NIB";
	arc=none smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3087F606A33A
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 15:03:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3087F606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yq1W/NIB
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c5075fa7ed0so782805966b.2
        for <git@vger.kernel.org>; Tue, 17 Nov 2026 07:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794927794; x=1795532594; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=k+lkveR7Zm36eh/Ot3kb9tHGq1twjrKFozVaGUG7B/8=;
        b=yq1W/NIBe3VbeLytR5Rsypn75QCUZ8Pg8IfnPJJ4b+E+iNFpP2n5V1A/WunJB6jCUs
         5NGgn5z3Oyz4GqmpfSMkMBRjBABkr4Nfd66x/FOR0TOjRueri05aCRfnsNV+G9BHcCnb
         d5UZtc10J+17yKhSRlPKAL5kxdegb2nfSkZN4vi7BNU9ncyctMC/63eR57GRRQgVPgpD
         FkWFfRufu8xjAEkx4dEEdpqqZZlGSNqMZkbwX8f7GZRKZDKix55CnVsl9gaDDcNTSDM+
         84PDEGlAL52zRfm/u+yWWQ1eH76zJSQuEdK7bldfmnzZOz87Xh90aX6TZBY4ttT57NOi
         cxMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794927794; x=1795532594;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k+lkveR7Zm36eh/Ot3kb9tHGq1twjrKFozVaGUG7B/8=;
        b=sl3kwWt2WKsjCvKHLj/ytFRwQMF+cOgINQtT16JEeZgsNm/BM+tcgNB3QcvpBzHPQ/
         FkQsUDPseNpuGysSZ6qQyppXGZggueE/tmRf/r7/qDh2gSC8GKDUBBWrOZLlddz8tOGh
         wU/CWephrkyo2InO1DnFMZIR5GPPPgXdZASSvQZHiIEjJEswysZQwHfdoYD1nSmO7oN8
         eRw9ILf+5rsESG9wK370pJOGafv7GPOYTAKPTQH5hV65pk2XOWkp+Q+k5zFUInAK2cIe
         OXnVvPGAwgrpI9ZTF4kDPTZjrhgEXkp/MGTy3NhCqh2CtmVpu3Xwkh0WUWD6YVWSZguu
         8mFw==
X-Forwarded-Encrypted: i=1; AL+hErHcTXCiHzcp9VcXuhcXcpkjDkBPL8XhtTb1sBgf7D67jcbfGhIJzZZR61kUO6rShY5cJ90=@vger.kernel.org
X-Gm-Message-State: APuU4Z8+sRw3L60Sgd9dTpnrdgsmquoodabo/W5n3Hf+Li+rYfNF6SKS
	h8CIoSysHllXnv1C7yl/a/TUp1wJW2u36gDRdqcEUjiY5HNFerdevxYi
X-Gm-Gg: AYBFou0WPoKwNcPPAfeu0rJYEFaHOK6s1LDzymptBXq0clUCyJB6Mi6HGXrwlP/NkkS
	nmxvVtYFMaq96c9oxq2kN8T6p/htBveffggz7DcK6yK4EMTz+G6GGDc7zzCPZHpMhKcXlmJI8YS
	FXUoBqtp3Pd8gszx99biyCU//fAB9NuZjLxAuzjczI6O0oudyZRBHNjHN6zUIfXWb3WYZL88pgB
	koy4bzaTAEzh6ciFC72RNOmAdwEscZJ/RTaqOtyu0bJDFIIW7IWeMHfHVJBVtst4sfjar494WON
	UBEJxtjUaAOvQ2fwpIrRwimkKLxY8bdjXkYQ8ND/X9Y+B6HJCVIm93g6k1TyG48deW8hFgB1RAc
	+AQE1psRxQ5TzsDotYDgqw5JxDWAq632KYIPvUIbmTE3qG1wEDXftj3yvZISvogRnkwIW2wWtYW
	cyHqHjdEWbk/NDxD+HGtye0PTEqpaM/Vu4cGlX1/y8gIe62DYS6+dYADeyT1veT4F2LDiWbEotz
	JLXO4jzYU3dmrLx3IT/mMJEbndFB9F2hQ41xlhofOVsQftrwWOJS9+HPL3BY5s+C7P4hP8GkO5K
	pXgPiJMuokzynelQ7AheN9caa4e5NBq6V8D8RUo7uwKDmXeO6O/vIiTvnItrqyhIu/OJ+wOfi5P
	4ECKl/N0=
X-Received: by 2002:a17:907:8e08:b0:c24:6985:d7a1 with SMTP id a640c23a62f3a-c50961104demr1077191366b.7.1794927794119;
        Tue, 17 Nov 2026 07:03:14 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c60f8d615sm28968612f8f.56.2026.11.17.07.03.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2026 07:03:13 -0800 (PST)
Message-ID: <5a1a9f6b-48c8-4daa-9059-bf9459587a17@gmail.com>
Date: Tue, 17 Nov 2026 15:03:11 +0000
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
Subject: Re: [PATCH v14 1/5] fetch: add remote.<name>.fetchRefmap
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, Matt Hunter <m@lfurio.us>,
 Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
 <pull.2412.v14.git.git.1794681496.gitgitgadget@gmail.com>
 <c63699b40228b1d47368778d7397b1ddc6ba2a36.1794681496.git.gitgitgadget@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <c63699b40228b1d47368778d7397b1ddc6ba2a36.1794681496.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harald

On 14/11/2026 18:38, Harald Nordgren via GitGitGadget wrote:
> 
> +test_expect_success 'remote.<name>.fetchRefmap stores an explicit-dst remote.<name>.fetch entry in both places' '
> +	test_when_finished "rm -fr fetch-refmap-upstream downstream" &&
> +	git init -b master fetch-refmap-upstream &&
> +	test_commit -C fetch-refmap-upstream base &&
> +	git init downstream &&
> +	(
> +		cd downstream &&
> +		git remote add cabal ../fetch-refmap-upstream &&
> +		git config --unset-all remote.cabal.fetch &&
> +		git config --add remote.cabal.fetch \
> +			"+refs/heads/master:refs/remotes/custom/master" &&
> +		git config remote.cabal.fetchRefmap "+refs/heads/*:refs/remotes/cabal/*" &&
> +		git fetch cabal &&
> +		check_fetched_refs <<-\EOF
> +		refs/remotes/cabal/HEAD
> +		refs/remotes/cabal/master
> +		refs/remotes/custom/master
> +		EOF
> +	)
> +'

This behavior arguably isn't too bad when "--refmap" is given on the 
command line because the user can simply adjust the refmap argument or 
the commandline refspec if they don't want to ref to be stored in two 
places. The same is true for when the refmap comes from the 
".fetchRefmap" config and the refspec comes form the ".fetch" config. 
Both those cases could probably be filed under "if it hurts don't do 
it". However, I think it becomes confusing if we store the ref in two 
places when the user configures ".fetchRefmap" and then passes "src:dst" 
on the commandline because users are used to a commandline "src:dst" 
overriding the ".fetch" config, not adding to it. It is going to be very 
awkward for users if they cannot override ".fetchRefmap" by passing 
"src:dst" on the commandline. I think we should change the behavior so 
that "--refmap" and the ".fetchRefmap" config are ignored when the user 
includes an explicit destination on the commandline or the in ".fetch" 
config.

Thanks

Phillip

