Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45C412CD8E
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 17:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708970066; cv=none; b=pmNuhFzjgyEHZdvKDw9ogweldBTu2CsV5xko+v8F0hkvnvLh1+nMw/2WQRFKtNoPcowhqpS5kEQdP8RY8JEiypuwyT2rBNuZid3t06AKmnT7bvsaDLwb06QWh8iafHEp791QUI1CGdTaukuQju/qodKTVCuTgJd6fvPJAbAekL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708970066; c=relaxed/simple;
	bh=8EijTSgE6Z3uh2EiU6/uAWade+hEjUTcVAzRWXRE/is=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ZT8Tr9M4eT4ncHc+Saw1/tWEVtFrzkvAo6Hph262HD4ZWcO3lOx1hkiJHwfS33Jcqyq+N0tk6pF50oPGu6ZwNdSYND1unIn6v3FEAEZnzvSx91Wvy3NEhKg9pjFloY3BOVJfnwD+sp/gePVvcNCFmZPIowFWDFgM9jj0IEghSc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J3s5wkZ2; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3s5wkZ2"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-42e885c8885so3296791cf.2
        for <git@vger.kernel.org>; Mon, 26 Feb 2024 09:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708970063; x=1709574863; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/LTe8Ftt2XDGgIxt9PtqlAItcka3sGcOwND5Gei1Onc=;
        b=J3s5wkZ2wACfv2t6scV5kyDYquhx4QBqLgaS/zk0ZQQXohAAaL6zhgEPKHs9afTVd8
         1Cd0VpuQGk9VV8GM9rFVK3isp+I720/MqLxmupNiD/Y1Ld7QdLu1q9gUywGYvNTNqzEe
         xEzkWZTIfvV+a1rnIgPTjs6H273y1ePYtFaKYSwRxOi7fUmYCq00S51tkYhtDj8qIIV/
         EDPvBW1dIM5VZaCI9NJXs+kOuMeuOyHEkKIV6DecYp8e0YzkUB3T4Khyc5HWACH9Do2v
         WeBcPf0jyIB4PkxcqvIFt1zCLvZahlyKsTNDypGdPlzeazbfuLYnCdoO9MCIA5EwtSS3
         F4bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708970063; x=1709574863;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/LTe8Ftt2XDGgIxt9PtqlAItcka3sGcOwND5Gei1Onc=;
        b=VGvEBvnb6cSVOuZtuV2YIRv4JpkmG1T8oZBdH20TP4TmxOMe/EKtm2X2fRi1NdNWUs
         TNrai772V9AqkGalOe4/OgFG/AF75asfxV2r1iGa6NjX9jXoa7F3aSnKzVFrM/PBja5O
         OlFlm8SzwvFFgSqP8E/8aWgmyEh5anaqdYggHOSpen3LZ3NNFkvjb7WndXlS2GtwshYk
         Hbg/tsGU8x0CksbBAwHaissRc/z0P4E8XHOxCJvB1RIhE1ohrEAYoG/B2KWGuxXZ2MNI
         EDDJpco5fXQuPl5JKklALgOQeAa6nq+UZQx5l1Czn/gck3mM7r22in/QblF1tQiqDNOM
         +J6g==
X-Forwarded-Encrypted: i=1; AJvYcCVhTgxBhiY8YhMpDgH0ogRtOZ2EVD933ui5FyvdiGijhuri92TQ8kCHOHd7PeMYIXO2GP8yxi6a0klzEe7m9TRKZ8r2
X-Gm-Message-State: AOJu0YzDuyCbGjVfIjxMwM1WnBq9FSz7fkzGcrDQzjgCrBM96Xl5pOu9
	wfGuyZ+o5ohDLhxQoqEzPSJUVMByC0E6bMzzj/wYSr/ArNzsCODX
X-Google-Smtp-Source: AGHT+IHLlvnG7COZ8SMWt4fJ8J9o93sZeGh8BSAmQpTOLENmdnuquaLBHm8uf1s78UyGVLwNaeoKrg==
X-Received: by 2002:a05:622a:510:b0:42e:8c25:8fbd with SMTP id l16-20020a05622a051000b0042e8c258fbdmr2010081qtx.12.1708970063074;
        Mon, 26 Feb 2024 09:54:23 -0800 (PST)
Received: from ?IPv6:2606:6d00:11:ff90:6db2:683e:23c:87ed? ([2606:6d00:11:ff90:6db2:683e:23c:87ed])
        by smtp.gmail.com with ESMTPSA id m27-20020a05620a215b00b00787702a13c0sm2684983qkm.114.2024.02.26.09.54.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 09:54:22 -0800 (PST)
Subject: Re: [PATCH v5 1/2] revision: ensure MERGE_HEAD is a ref in
 prepare_show_merge
To: =?UTF-8?Q?Jean-No=c3=abl_Avila?= <avila.jn@gmail.com>, git@vger.kernel.org
Cc: Johannes Sixt <j6t@kdbg.org>, Elijah Newren <newren@gmail.com>,
 Michael Lohmann <mial.lohmann@gmail.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>, Patrick Steinhardt <ps@pks.im>,
 Junio C Hamano <gitster@pobox.com>, Michael Lohmann <mi.al.lohmann@gmail.com>
References: <20240225-ml-log-merge-with-cherry-pick-and-other-pseudo-heads-v5-0-af1ef2d9e44d@gmail.com>
 <20240225-ml-log-merge-with-cherry-pick-and-other-pseudo-heads-v5-1-af1ef2d9e44d@gmail.com>
 <c46a0a4f-63dc-404a-8ee2-64a34f474c5f@gmail.com>
From: Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <13c882d4-8f61-1ea5-8949-fdde16bcfc5b@gmail.com>
Date: Mon, 26 Feb 2024 12:54:21 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <c46a0a4f-63dc-404a-8ee2-64a34f474c5f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit

Hi Jean-Noël,

Le 2024-02-26 à 12:22, Jean-Noël Avila a écrit :
> Hello,
> 
> Le 25/02/2024 à 22:56, Philippe Blain a écrit :
>> From: Michael Lohmann <mi.al.lohmann@gmail.com>
>>
>> This is done to
>> (1) ensure MERGE_HEAD is a ref,
>> (2) obtain the oid without any prefixing by refs.c:repo_dwim_ref()
>> (3) error out when MERGE_HEAD is a symref.
>>
>> Helped-by: Junio C Hamano <gitster@pobox.com>
>> Signed-off-by: Michael Lohmann <mi.al.lohmann@gmail.com>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
>> ---
>>  revision.c | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/revision.c b/revision.c
>> index 2424c9bd67..ee26988cc6 100644
>> --- a/revision.c
>> +++ b/revision.c
>> @@ -1973,8 +1973,12 @@ static void prepare_show_merge(struct rev_info *revs)
>>  	if (repo_get_oid(the_repository, "HEAD", &oid))
>>  		die("--merge without HEAD?");
>>  	head = lookup_commit_or_die(&oid, "HEAD");
>> -	if (repo_get_oid(the_repository, "MERGE_HEAD", &oid))
>> +	if (read_ref_full("MERGE_HEAD",
>> +			RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
>> +			&oid, NULL))
>>  		die("--merge without MERGE_HEAD?");
>> +	if (is_null_oid(&oid))
>> +		die(_("MERGE_HEAD is a symbolic ref?"));
> 
> Following the thread about being less passive-aggressive, maybe this
> could be rephrased in an assertive mood.

Yes, Junio suggested the same in <xmqqa5nnj10v.fsf@gitster.g>.

> 
> By the way, this string is translatable, but not the one 2 lines above.
> What is the policy around translation?

My understanding is that new error messages should be translated, but here the patch
is not touching the message "--merge without HEAD?" so I would think
it is OK to avoid changing these lines to mark it for translation.
But, I could make that change in a preparatory patch (and rephrase it 
at the same time). 

Thanks, 
Philippe.
