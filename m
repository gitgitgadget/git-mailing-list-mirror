Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02D14A3F28
	for <git@vger.kernel.org>; Thu, 17 Sep 2026 09:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789637055; cv=none; b=m54n6vse837bFeoZ5Dnbu2WX/xKmBv0BB2yFq9aQzBTrpu4gp1qE1B7OnbPSOlKL8ct6cT2Lti1YTr5iqqdF8oZON+aKMSQE/a7PY8oKD6vTEQb57jtUZmTzTHpQZPqvVVBN+lagtmg4j3ZlKeHnE2VTeBwrPWF+B6ihogcJFNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789637055; c=relaxed/simple;
	bh=YX8YCn8zMQy/50ctjbtonNcTNo9qkpeeZF14VTiD5R4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IrAn9U6TW64vHv5c2nhmp1BOYHPPqR0Ko0ICo8yjoeQPFKEfgh/LbkBPvO5CDfgiVJJsDDH4qjcEYBrT/c2UTiSZmSrIwR9nhibGPqW1Jbpy1hNGyJMpaaq5ZRdZShN8oUDxhqmRbuuiGemCHWQ6Xa0yrkeWMIp4OqtbhrBtV4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nV8tGOC7; arc=none smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nV8tGOC7"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a60590a85cso1318754a12.0
        for <git@vger.kernel.org>; Thu, 17 Sep 2026 02:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789637052; x=1790241852; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dO27hQic0Mmch9oPaLK8wUy2YZ1OCkEEhY+4MLK0Fss=;
        b=nV8tGOC7Pa3O5Y5m/3hnJNjalYBY/0GmrvEEzWbhYf+nmQ1j/9kalpMtnuuC6XaCJ6
         U48XkJZWuGnKMuDjdoE28T4MlKQw3fP4f+Qqm+sSsGSG7vdOuIGpiFidmTV8LGiM09e2
         lFphnBCXhlMPLD+cnbjZrk5fXBEV4NhkcU1PVGy/gW2gUdnQQh/X0UFZrjBIBF0yjVXZ
         7yY0/pZFiqGBZYP1NmigqN47Epo7w7rpVaFZw9Fqfwq1jewJwO6D1Pati0fzNvBxtaiU
         hgUsBlnquuBYG2HPW6FEIIYTdXoP3M8xtGrliyYpKz6E/GLeqSoY/OGzEjqHs0UZNFKr
         W3wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789637052; x=1790241852;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dO27hQic0Mmch9oPaLK8wUy2YZ1OCkEEhY+4MLK0Fss=;
        b=Kmd7KIHytlil/frfRBn0ivKymBpRp88RmWe08pS1ikQ4YUDeA0KLTViM41q4xviQt6
         uQrMhXKMlIHMP/9+/SsKk6ngiEy+vFs/HB/MHPt60Rcoi6f0tfck84lNloJqvz5Yodwq
         KpmkWLnu/yQPzI8O21E5kUOqy8WrIuvIlJjEYrVoL6PMG40E3Kcu8NUbkDDjo4MKENn2
         dzfgTaemigII5eeVS9Jayp1c75NGlgC7tOl5VEWjbGRZr41ySCe4jF6I+o8e4KaanatE
         NyMuMzerTNNkboXvKEjSpOPcBf3pM8bVv74u0/myM7faVsIsHfcPQlS5DVJVgUkI5kle
         m1lw==
X-Forwarded-Encrypted: i=1; AKwUvByHR2i7ig1tAR/vnt2DQ57ouj1lZVTICKI08nOtufzl6gejFJFiBwI6FXEucx4wTLDuokY=@vger.kernel.org
X-Gm-Message-State: AFuF++k4p0GL1uVRNbJwwpkanaOYAEiyif5+0wnxvZl60up/GDma+RL+
	SH0WHIYxW8Kntv9TdeWKTxzSFsYHt6xbzMFfCinYh8sgKTjgxDOlHQg3
X-Gm-Gg: AYBFou1c9kePMNhqeNgl8hd+kBi4T6VIQcM3yu2+z0U2n1/xOB6V4xFEyc4blsSl8MH
	QS6fU1YLP+Ih6iQjgyGZndFTHT7W9OMTpTz3M3WLbAmvI2e2EqXGMNoTUm4EHwFkHISp6br/2Tf
	HaNQZYHP5bWeWfmU0+fcXi1NYexuMg84tMnYTonUDGWAOpRKpiuu1oSkR1fo8C4CVsXc62dH59n
	1L3RuGsNXG0kQdbqSuv3z+dFb85Yip1ghLB2vbUeJ0agY0E+98ub7vwR9cMUsBt8lpP/z6OCDEv
	Otxxb1KwNv0wFcaAb9+6pYd2lHQCfIonuCalEAa3E6H+rcLmyxAsWtYwHclDzmWsqvOFvglSwMR
	hmkZdgAtEHj4HZ/w5lsquk+dYHKilXf632Wg0hsmEgjJ6vxV0DveOSRakoU59NSSXGZ/KJj+EDf
	ybPAuhXLrjJavc1NosrAW3BP4AbsEb+FgAxHunJPj2inQMEyEyof9YUM2z5CClsHiaYFJNYbK2v
	Mo9mIwJlVKromn+5cdlU8Eu2x7nk6GmD5GaxZ6xuRAUaCBPE8N2+w==
X-Received: by 2002:a05:6402:354d:b0:6a9:a5e7:f8be with SMTP id 4fb4d7f45d1cf-6aa2223ad1bmr4263823a12.5.1789637051289;
        Thu, 17 Sep 2026 02:24:11 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aa1d228de9sm3474648a12.6.2026.09.17.02.24.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 02:24:10 -0700 (PDT)
Message-ID: <fd4c2cc3-d457-49b0-bf3c-96063e40700d@gmail.com>
Date: Thu, 17 Sep 2026 10:24:07 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [BUG] stash.index=true leaves a redundant stash entry after an
 autostash fast-forward
To: Ben Knoble <ben.knoble@gmail.com>, phillip.wood@dunelm.org.uk
Cc: Eli Barzilay <eli@barzilay.org>, git <git@vger.kernel.org>
References: <56991232-5d16-41d1-9c7d-ca7ebdd9fce7@gmail.com>
 <0BCA251B-9536-46E3-A6C5-7F917366F92D@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <0BCA251B-9536-46E3-A6C5-7F917366F92D@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Ben

On 16/09/2026 15:30, Ben Knoble wrote:
>> Le 16 sept. 2026 à 09:35, Phillip Wood <phillip.wood123@gmail.com> a écrit :
>> Taking a step back, this code applies the stashed index changes
>> into the current index, writes the result to a tree and then resets
>> the index to HEAD. We could avoid touching the index at all if we
>> used merge_incore_nonrecursive() to cherry pick the index changes
>> instead. That way we'd get a proper three-way merge and avoid
>> spawning subprocesses for "git diff-tree", "git apply --cached",
>> and "git reset". We're already using merge_ort_nonrecursive() to
>> merge the working tree changes in that function so we have nearly
>> everything we need already set up to merge the index changes as
>> well. Essentially, when merging the index, we just need to call
>> merge_incore_nonrecursive() instead of merge_ort_nonrecursive()
>> and use info->i_tree instead of info->w_tree.

> 
> Wow, I wish I’d had this info this morning! I spent a couple hours
 > trying to understand this flow and still don’t have it in my head :)
 > Thanks for the pointers.
It is a bit confusing the way it updates the index, then resets it only 
to update it again at the end. I don't think we can avoid that though if 
we want to error out when there are conflicts merging the index.

> I may try to summarize my own notes (= questions about the existing
 > code) and send those out later today, though, since I’d love to make
 > my understanding line up with yours!
I'm happy to try and answer any questions, on or off the list - it would 
be really nice if we can merge the index changes and avoid a bunch a 
subprocesses.

Thanks

Phillip

