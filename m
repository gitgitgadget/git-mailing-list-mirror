Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80E434252B
	for <git@vger.kernel.org>; Sat,  1 Aug 2026 21:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785619702; cv=none; b=E1D+1tmjhxohCzaqpSFHzMgSKjbgkH2WtR75Ge//DB+MDnVQ5gXDa6YgDGGU1SPs6aEUfj0dYR4J6HVeP2F/ww5O0i8N8/SMMB+HoLda90WlkiGdj2UK6OOHAT84VNIhzhcdNYeAm3j8aOQjVrt8WzqyIQwnVZxhi5WsgLQjq6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785619702; c=relaxed/simple;
	bh=RuVw6iteASjziCNxyt9Zwl6Gk5FsvbCaWGLMK+V+gTI=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=XFUxHfVwEsclRL2HrKJ6e41P2HYe9GFB/rt0spit7dHlbE62d9u3icwQMx3qMTyxdBxr31l++bRb39x48B8ZUwBbni+RpkEYnnQ7ltG+0CnnMhrX5embEuzn63P8+wiC6V1b/LMZzaoqDq5l+jSxzcbZkBkTT5Hkkrbb6dxCtcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zdm3gT7G; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zdm3gT7G"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-47fdb6f7d72so214495f8f.0
        for <git@vger.kernel.org>; Sat, 01 Aug 2026 14:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785619699; x=1786224499; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aLxczdmAzh1VMDyL6T//htPLOjqMwgQ/Qp34qnJcgBA=;
        b=Zdm3gT7GFHX6hfbKCBmI4P7XRaBVz0MZDMT3LgZl8I62Hi7GLCXKwizoeCEW0+Tgsu
         MEmJ/OrD1UbphvmZLMMe1/ZA3dEl0Tr2hiKkv/FNf6qd7ZjUqYep+9Kjcf3K94/NkBUF
         4X/4d1T6qyrK7hqGaAuBI7J6BYDokfS6aStVYlE39pQw652uMJafyXFLrdVvSbPXPbB8
         KMsZR3td0n0rnpSvuoN0mSixoGPTO2eGnLukM5NAFYfveXC9J40alHPyU+u4IicnR557
         AAN8lRWXGeiCMRoD36Zgdjs2JQ2eQQNgnjGq1g4kpmmzGDLkbZGG0aoPGVJh1b+BMZch
         xp0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785619699; x=1786224499;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aLxczdmAzh1VMDyL6T//htPLOjqMwgQ/Qp34qnJcgBA=;
        b=siYgpSlgn2IR3d40NdiR4G7ARfKJiYTUz/Mtw7lOwyz9PSG1hpDdBzsKEHjJA9D0ZY
         /sgxoVmodBFFLupVCNZ3n9GS3Yp2AcFgsTcTLv9+JJ+Q7J5QVkCI97ro7VZx+N7ojVUc
         W/YWDlYJpkuimqPQvoVyDxcZgNf+rJVwfe8Xejj9qLmkvYO38i7XeKN78055bwtoAo2Y
         26SZ8HnGWKu19dRUIaai1OC3CK4qoWR85yadLV/2YBxo5xgcg6SPCpG2/bwEYnUwbY5J
         obOxpTwqseoF9SwtVnjBJv+KSrylVg36UkIFF4KWjGcgVgjAjx2iq71mylqSyUou9FrD
         e6nw==
X-Gm-Message-State: AOJu0Yxs6OZLvEbBBuNUgIfjQ4MhpIJ/JoDS8SviTS11S8vlsB4ZYNn6
	wkI1J11nT8o7upD7osofOI9fS4QSomos6tzBqZRdR1rEYCviuWMbu38/KNzRwTXS
X-Gm-Gg: AR+sD11nDfnO4xbwwMVvg0bCs2SNBSAfgVGDF/sTnAXJZF9POQ+UFrhDwgbPAKu9yQ+
	9gQhtNGA1llPQ0tkL5hHE72WdYYzDZaYFExQk4fuFA2mnqHJin2NQtwhwRC/Mn0ebC6wwiRqlKZ
	l7EleOGnVAC3JneeoQei4312k2It96UKIr/eEHhrjz4DI8koC4fwE82doQpmuEd3qHuJvlQviAP
	cdUFRwEBXd3Fh+St7LRyZIvky63FItivorWA6kek+WbSUZrKETol5iyPMmPQTDS0cAFVIeGETTn
	GIQBZH27IJmmRtQjPA5iqq/neaViP7BaEt9hfNXvrQqvO8FCFhClrtOgVcHlBWocOFOHDNTFWEz
	aQSqFb/95FLq7/HxxQ43UvsdIsgvQYO26W9Xp4IWe4iS3hGAifD0f1nNTVtNOXJVSkL6bQafS79
	HJ5upFS80rN0tpnKM+EPkd0Gb+TwOHwFknAyv36aN6eLENFl8fdnEUVmNiWkxJXf86B1/NzKfDF
	aOiIV1jrsX7NfrJEXhoalSYmEV+jeCid4webv1zN1Vu4MDEuEsYMK9W5UIZFlP+KDSl0Sxmxa+L
	6HN5hamFbQYlMyvbaI7NYpSCQBgyyygt26kAlxah1TxbwxMZIsUF6POeXQDzC4mTDgNIx2sUMn4
	pzAgJ8uM/Ug==
X-Received: by 2002:a05:6000:2087:b0:47d:ea8a:d211 with SMTP id ffacd0b85a97d-47fd9f93ed8mr7218205f8f.29.1785619698820;
        Sat, 01 Aug 2026 14:28:18 -0700 (PDT)
Received: from localhost ([47.58.8.78])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd45895b6sm19006976f8f.26.2026.08.01.14.28.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Aug 2026 14:28:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 01 Aug 2026 23:28:15 +0200
Message-Id: <DKDXCRLFABZK.2DP7XB6NXY9SA@gmail.com>
From: "Pablo Sabater" <pabloosabaterr@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, "Pablo Sabater"
 <pabloosabaterr@gmail.com>
Cc: <git@vger.kernel.org>, <chandrapratap3519@gmail.com>,
 <karthik.188@gmail.com>
Subject: Re: [PATCH GSoC v2 4/6] fetch-object-info: parse type from server
 response
X-Mailer: aerc 0.21.0
References: <20260731-objecttype-support-v2-0-af577461ed57@gmail.com>
 <20260731-objecttype-support-v2-4-af577461ed57@gmail.com>
 <xmqq7bmaa0sw.fsf@gitster.g>
In-Reply-To: <xmqq7bmaa0sw.fsf@gitster.g>

On Sat Aug 1, 2026 at 7:04 AM CEST, Junio C Hamano wrote:
> Pablo Sabater <pabloosabaterr@gmail.com> writes:
>
>> @@ -104,8 +105,13 @@ int fetch_object_info(const enum protocol_version v=
ersion, struct object_info_ar
>>  			for (size_t j =3D 0; j < args->oids->nr; j++)
>>  				object_info_data[j].sizep =3D
>>  					xcalloc(1, sizeof(*object_info_data[j].sizep));
>> +		} else if (!strcmp(reader->line, "type")) {
>> +			type_index =3D (int)i;
>> +			for (size_t j =3D 0; j < args->oids->nr; j++)
>> +				object_info_data[j].typep =3D
>> +					xcalloc(1, sizeof(*object_info_data[j].typep));
>
> Do object_info_data[j].typep and object_info_data[k].typep need to
> be independently freeable?  Separate allocations by calling calloc
> args->oids->nr times would allow that, but if there is no such need,
> nr contiguous allocation of them,
>
> 		enum object_type *types;
>
> 		*types =3D xcalloc(args->oids->nr, sizeof(*types));
> 		for (size_t j =3D 0; j < args->oids->nr; j++)
> 			object_info_data[j].typep =3D &types[j];
>
> would be simpler to manage and easier to get rid of once you are
> done.

Hmmmm, they don't need to be independently freeable but they are freed
by free_object_info_contents() called at the end of
parse_cmd_remote_object_info() at 'builtin/cat-file.c' in a loop:

	for (size_t i =3D 0; i < object_info_oids.nr; i++)
		free_object_info_contents(&remote_object_info[i]);

free_object_info_contents() is:

	void free_object_info_contents(struct object_info *object_info)
	{
		if (!object_info)
			return;
		free(object_info->typep);
		free(object_info->sizep);
		free(object_info->disk_sizep);
		free(object_info->delta_base_oid);
	}

This function was implemented by the series that introduced
remote-object-info (the one that this series is based on) so
parse_cmd_remote_object_info() is the only caller.

Thinking about it, your suggestion can be done easily. To free types it
is enough to do free(remote_object_info[0].typep); (same for sizep).

I'll make it work as a prep patch for size and modify this one to do the
same.
free_object_info_contents() gets dropped in the prep patch because it
would have no callers after it.

>
>>  		} else {
>> -			BUG("only size is supported");
>> +			BUG("unexpected object-info option: %s", reader->line);
>>  		}
>>  	}
>>
>> @@ -151,6 +157,10 @@ int fetch_object_info(const enum protocol_version v=
ersion, struct object_info_ar
>>  			    object_info_values.items[0].string,
>>  			    object_info_values.items[size_index + 1].string);
>>
>> +		if (type_index >=3D 0)
>> +			*object_info_data[i].typep =3D
>> +				type_from_string(object_info_values.items[type_index + 1].string);
>> +
>>  		string_list_clear(&object_info_values, 0);
>>  	}
>>  	check_stateless_delimiter(stateless_rpc, reader, "stateless delimiter =
expected");

Thanks for the review,
Pablo
