Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADD13644DE
	for <git@vger.kernel.org>; Tue, 26 May 2026 02:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779764094; cv=none; b=CP+2e8oehWeUFKfvPAosaRE+bfNiL41/PflUC0tX8ohbr3xZE8QSZdo3NnJHHhaXlQnySopEFjfrEE4CiF4h2GAylXmofWxOTQctusNb9JCFAS/YwMLk+CWFu/JWeoaW5Wi0Likp9YvzE22fm5oPz57U7SwfgRWCUfc1c171Y80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779764094; c=relaxed/simple;
	bh=bfx3Qs2pnXHeW8fkyMz3RwLjQ5LSL6cgX2Aai310ENg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pz9yNN9Ptq6/MB+3hM6l7zYnwCggVcWe43vKR40bUeNXOZSVqaNDuzFyhcf8Z/IbCuIKQAxcusH8XRkl0UcdQKuqvLsJ+GGxwP2HRmOeNsjHhMO2Sfak86r8SUTRnf8bxRCbvOSN/NMlTB7T0tT3r9nwEM6g+mQfEjCb7oUoJPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=beQWUWKT; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="beQWUWKT"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5148cbdea08so84884531cf.2
        for <git@vger.kernel.org>; Mon, 25 May 2026 19:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779764091; x=1780368891; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ArhXb/F3pKjHoCGoerHhhtPtp+2Dl+4QWsgA7Wu+TOw=;
        b=beQWUWKTfo0GnrePCVfj4LcHNyG0epBOAvfVVly0ezHmaEXi2r5drHUGSvbRcJLb4z
         KhDXJ911qIhj4L3wlg8Ko2gFjBvIdZZU4+x1iqSRYPG6sXqxaD32yhSC86iRyRndzDpa
         md2sDavbPl0Rw/H2qeP/Swr/LviP0tnRy1EkLyF6qJNSLJ69wW5G3eaKO93nSm9GVtSu
         jjIbcWp4e0S8NaUb3fVzB7wA3EESsU/wgb4ViXTh0F0sUxYnd0VyW5AcIAE4SGfSVUUc
         xi9XLztfcTcIBSVr33Tzt7PB5h+doHCvigZXhGoPnLzUHVmpAtjmTDBlQBhZFECZYXNt
         U0vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779764091; x=1780368891;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ArhXb/F3pKjHoCGoerHhhtPtp+2Dl+4QWsgA7Wu+TOw=;
        b=RjZ7R4aIznU7TvUGygWKZ4eWrK0Ceo1gNICIDVlE+/7y7pFChpglD7mxTOPk6qQ9Sj
         KtZANPMw2qfetHC+B6JiKSEN6TBHrlS8U4Bz3bGAmpBlm33sUZAIPVok8+40WIaqWJlt
         uu/Fi2Ht5Z6YhofAF6G7+UNeoHHrlr25pqAdLZQOJ/KR9+O7BcPZSafss7kOAjPAU2fS
         2ddEkTwKnaC8ucXD+fY24TV+MjxKLFmChBcrEMNO8OkBspLr5dWwMir2vG6xU2Qyixjl
         BbCDhEoNT2lil19UEDvQcozvYWv41PLjlyytLANzn3yW9y4S7plkxjAotQw8B7lQuMfr
         66tw==
X-Gm-Message-State: AOJu0YxnwtoH2j/rE3HpBb2QYe+DLsI25VZhe/rqQvQ3EHLbLYbRybWR
	l9bWlnqIYf1u63xQrqnCXEzToo43r1+ZIua8dprvHdRnT+vb4rPxlCCF
X-Gm-Gg: Acq92OGeNcfTlxrmdtfO8Gk9ZdDQw24PuFl1ulvUs2z8GD/osJLD+eTcp1rv404r8rR
	6HGmArx/a5OOmdQ6tm5v5Aat6miHpqbA9NfGAHDdsHujZMN6zhCy+DCUhyibeJeLSgkoxmml8r9
	tKAnXh2RWF1m9zysGDWFbFhh/vXn5HBwuPtG0Hf5PUQKoGbxJtQmVR7SMPQG4C9ft3OiSbVqt6l
	DcBE111Dspr5hYJCcDomci1mTx9/ycSCPhFcfzl6sVVsdMa2rOMfsahyUDHy5neh7hehz+Vz7pQ
	goXr2H6XzIgPIsIKTy+y2MZ3TYU4//boFYYBplBRywK48oLrvKcNa12inhA0v8yA+0MlvSBYy0R
	41OnOgBNXu4gOfxO2c++ZhLru1Y6AcBFPKSzXVNvJL4LQpDJWxuos7gIRJ7oBI+NyE+D2gJjRx5
	obKr/QBJ1AJK9iNwQ3D1DvmoVOXIy5875GJGDwB4LYdk98yHQLzgrQPRGdMMij8yh2ExcPVa5i1
	Z1tZblzJh1RH46Uuy0IV5AicpwIDXsAr4aLqldSgPKfC+oishQ=
X-Received: by 2002:a05:622a:4115:b0:516:cfb9:2845 with SMTP id d75a77b69052e-516d4636a0fmr225350601cf.46.1779764090705;
        Mon, 25 May 2026 19:54:50 -0700 (PDT)
Received: from ?IPV6:2605:a601:9b88:8300:4178:7958:947f:ef4f? ([2605:a601:9b88:8300:4178:7958:947f:ef4f])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51706a2655dsm6501661cf.12.2026.05.25.19.54.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2026 19:54:50 -0700 (PDT)
Message-ID: <7b8d12c0-21bc-4bc1-9e0e-81fbd4b3a2bd@gmail.com>
Date: Mon, 25 May 2026 22:54:49 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] restore: avoid sparse index expansion
To: Junio C Hamano <gitster@pobox.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
References: <pull.2121.git.1779644412.gitgitgadget@gmail.com>
 <47542cbd42eb13b63d0d852fb2f5bf967952b318.1779644412.git.gitgitgadget@gmail.com>
 <xmqqtsrwh0hx.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqtsrwh0hx.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/24/26 7:05 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:


>> -	if (S_ISDIR(mode))
>> +	if (S_ISDIR(mode)) {
>> +		/*
>> +		 * If this directory exists as a sparse directory entry in
>> +		 * the index, we can handle it at the tree level without
>> +		 * descending into individual files.
>> +		 */
>> +		if (the_repository->index->sparse_index) {
> 
> I wonder if this deep nesting is a sign that the newly added code
> from here to ...
> 
>> +			struct strbuf dirpath = STRBUF_INIT;
>> +
>> +			strbuf_addbuf(&dirpath, base);
>> +			strbuf_addstr(&dirpath, pathname);
>> +			strbuf_addch(&dirpath, '/');
>> +
>> +			pos = index_name_pos_sparse(the_repository->index,
>> +						    dirpath.buf, dirpath.len);
>> +			if (pos >= 0) {
>> +				struct cache_entry *old =
>> +					the_repository->index->cache[pos];
>> +				if (S_ISSPARSEDIR(old->ce_mode)) {
>> +					if (oideq(oid, &old->oid)) {
>> +						strbuf_release(&dirpath);
>> +						return 0;
>> +					}
>> +					if (!overlay_mode) {
>> +						/*
>> +						 * In non-overlay mode (e.g.,
>> +						 * restore --staged), we can
>> +						 * replace the sparse dir OID
>> +						 * directly since files not in
>> +						 * the source tree should be
>> +						 * removed anyway.
>> +						 */
>> +						oidcpy(&old->oid, oid);
>> +						old->ce_flags |= CE_UPDATE;
>> +						strbuf_release(&dirpath);
>> +						return 0;
>> +					}
>> +				}
>> +			}
>> +			strbuf_release(&dirpath);
>> +		}
> 
> ... here may become easier to understand if it is made into a small
> helper function with a descriptive name.

Good idea. I'll try that and send a v2.

Thanks,
-Stolee

