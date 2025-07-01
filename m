Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15C5274B58
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 13:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751375889; cv=none; b=OWFssuKS0QQ2tw6G+omMwx9e9IC670TpL1/oHBA8uJkKeylteh7P/Zlwp3awswpNsUO5KVOoHwb8+igq1i+1mYNNsIHLEcWXhXTEOgEYTs3EvjDAHBeZSXt0FzYS+4IULerHdQnCmARhuuBVnLbGhoPudGsSQA834CUCGY8o0As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751375889; c=relaxed/simple;
	bh=IIgXNpW04MffeXqrg7GWIAqt7KU4aOtHjbqs9MvMH0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=usB+sPDWwnIfX9CFhpEDXylnuF+1s2gJZ7Sjxo/zxudNCQGynZah3YQd+orJPOCqKhIExeLRohiNihg0UwmvVMZmQ3sN/P7DC5iTMl/9ZoHcePzedediA+s94/rWSdadVVwbF8QEvI+rR/1PgUdn1rheNCYcAK1K2nxFdTy8Nf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EcBRQAWf; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EcBRQAWf"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4538bc1cffdso31500675e9.0
        for <git@vger.kernel.org>; Tue, 01 Jul 2025 06:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751375886; x=1751980686; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=82Y3MBFFObsJOrpsfRclEIscs3OasxpicIW5NtWM7RE=;
        b=EcBRQAWf0UNxeuOUHHDANsyO/P2ThsB4UX6fnOCd6wDeEzJdXEZAF63g2dKInYE5RK
         IGe6oyJcOGjqLdnqwuZqm1w2gbms42fa1I7HNiR37EIQl5gE5oGdBtoap6a+od5OKP3O
         ItbUxlwu4qjtKEjUvY/0udPs0J/iJj2yFKBfdtLU3CADOC10TGSc9bkDNnxrrMlDFEt3
         5Ex3dQxv8AIyb6FnKXwNrlFRNn7wInTAik/JKKWEbP6UT3MmNqMYZcC6iFl0Qx2Avo09
         9LEy2Mr9wSLtTWqKJwXFoBt2d/cXj/2IEI4BRz8j2B762U621gYlpbK4lEEWHpQ9KJwv
         0RJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751375886; x=1751980686;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=82Y3MBFFObsJOrpsfRclEIscs3OasxpicIW5NtWM7RE=;
        b=G5Tixbd1z3bUtlI6mfw1iZ1okSEADVUEoIzdkr99tj61V70sNlVP+rZxefKSUkxH9a
         Yu3EIxQwnjlFiw6f0DKmH83SiUG6y45MHEg2R+k9LpPdpNiwnug6DpbElDWATiCRfHA/
         rpxwzdeh+AxcbQVRBPKIthZ+708CdK0EoT0o9G5s9YL9Unukl1VyTY80ZrozqC7iBOTD
         djQ4h+P+lY3CsfJZPldgGhX9peY2KOkuoBQGPTP9+IoH86uQ3s9drtl1du6qcYuj12tM
         bY7HkJEULi3cvcGrGO5KTmPJGV4VImn6gZIcaNG0GDNNLGCN/3jABGetw0hGztteyOmH
         9S3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWs+47rIjzjYU4/EY0Qdy9VMoebZf421dJ1iT1vRA4Eqs8IcF4Nnjv7RSqY/ok4KXO49Nk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzje2dmoWdRGCUMV2CXbLZY13u0NkEc81TSOR2bED+4+18luNgP
	poC3CYazcO9ywDYosoFD/FAbyo3MbjGl+k90KEWLUe8e9L/2mhIaolTC
X-Gm-Gg: ASbGnctxQA2fkb6AlwrDpwHlL+G8zIjhFdniosNaGw/qHwZxsSRR5kFC90dNvzduJG8
	IjdD0x8TZoCz1Xsj3HONgbpAFBT6a9YrbSK88XIpfxWBkUzLK9zIDKgT3TLiiEOllBAcrckGtJi
	94dGlr0fCHZzXB94tn9OkFhqbLSOEU1A8Gbl/xFoArnVv9USS88Zh0T5jsr4EolRzmsEqhuPvT5
	a37BNHtKBaLyXLFJUgMyVyAnYV7rYPgUPLSoemtBvJDzeODs7BJC23GtmLU1lWaX0r9GzAfzF1l
	ToJJcfmmwX8HUyo17u190wex2/50BuBzNdIX/4584leUppFFwVLmBbsqUJE/KlGJvQzP4z7v3B+
	VWdscFPlnJyBn0QsyTGdmAwPMHxFPU8L9YCUVSvgaE5/Dg7qe
X-Google-Smtp-Source: AGHT+IF1d5P/porg/AV5mPQVS1mQIHTrbycJvwSEBtcOr1Mx8ng1PwEMcjNta2z2sFhK5F2/HwSxog==
X-Received: by 2002:a05:600c:1caa:b0:453:6150:de41 with SMTP id 5b1f17b1804b1-453936a4bcbmr175138775e9.17.1751375885788;
        Tue, 01 Jul 2025 06:18:05 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538a3fdfa6sm169382615e9.22.2025.07.01.06.18.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 06:18:05 -0700 (PDT)
Message-ID: <17b7f51c-0c3d-4d63-a501-47ce829f7345@gmail.com>
Date: Tue, 1 Jul 2025 14:18:04 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [GSOC PATCH v5 3/3] environment: remove the global variable
 'sparse_expect_files_outside_of_patterns'
To: Ayush Chandekar <ayu.chandekar@gmail.com>
Cc: christian.couder@gmail.com, git@vger.kernel.org,
 shyamthakkar001@gmail.com, gitster@pobox.com, ps@pks.im, ben.knoble@gmail.com
References: <cover.1751309770.git.ayu.chandekar@gmail.com>
 <45c84a6615aa15f19b34b7f3d73a6e418c178427.1751309770.git.ayu.chandekar@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <45c84a6615aa15f19b34b7f3d73a6e418c178427.1751309770.git.ayu.chandekar@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ayush

On 30/06/2025 20:27, Ayush Chandekar wrote:
> 
>   void clear_skip_worktree_from_present_files(struct index_state *istate)
>   {
> +	int sparse_expect_files_outside_of_patterns = 0;
> +	repo_config_get_bool(istate->repo, "sparse.expectfilesoutsideofpatterns",
> +		&sparse_expect_files_outside_of_patterns);

This changes the user facing behavior if 
sparse.expectfilesoutsideofpatterns is not a valid boolean value. 
Currently git will error out when it first starts because that config 
value is parsed by git_default_config() which is called by almost all 
git commands. This means that if someone sets an invalid value they get 
timely feedback that the value is invalid and git dies before doing 
anything. Now, if the value is invalid, git will only die if this 
function is called and it is likely to die in the middle of a command.

Thanks

Phillip

