Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B8D221DB3
	for <git@vger.kernel.org>; Sat,  1 Aug 2026 22:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785622833; cv=none; b=H3GGWVXrazQIRu37ZX5qLi5RFInMgqaF3/ttS/dVGEb+xjykksPjuZZhdYO+mWljkPtGHZ1gVkqDNo8G+6ThwVBXBqEPM5esal7o37ogyvUuzmIhBdnP/MEkrQEE4wfJx+4EpnGl/m+lph6FQGreVMwzOiiQbJcO/MO81IFXPMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785622833; c=relaxed/simple;
	bh=3geYrsrbjeV0s8hCWzMXcL4mAJ5XJNQEMG+A4zqwfN0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=oy7/Jz1+ncbxbvjrE6Lv3p7LaLGNJbzY8Jq3K4aG2tyl6AbRJEeGkHa1ikT9kVcrVkbLgCgvajsd8nbfFANideRkLTI56UXHM+8EvMwWhsiIMGmI74i3vS6Y3QqTBOyX9mHWx5KuNNHkE0urjXhQAvM2f9chGZ6989i6HAX6yS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MbjNVTSN; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MbjNVTSN"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4954a9e8490so9539285e9.1
        for <git@vger.kernel.org>; Sat, 01 Aug 2026 15:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785622830; x=1786227630; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KpiN/DbQ8ItK+lLWEkdUdhZl6h4pC7IGE3YTKxkXcVI=;
        b=MbjNVTSNI/dRSGMpN0Fuem+nsp0Mtvc8a9CjvdrKGFif/8LpAjvHMz8xJsD8n/DAm9
         7w8sy0jhC8Ks9xezm8vBGLix/7MJ1h/c4PgYYvIBpvwV49XbQyxgT9/Zf/Uf1y66U+yy
         ZK5GRkNbCDLJzmxTQrMtMVzn0vkEBZOOf70MXwDQw1jZfLRVf4Y2vOTFLfhxIMZ7z1QZ
         RayQEWXbIZ6Ph3B+KWwBMjuuan8rNwgXRVd7WW6G2Ok3q591o1bJbuC9N2Hh1iPYAFSj
         v6dwMtsLs1PIYQcZR3eieBpZBKHTasAKWJOGYIG2QBl69bTw/7bkxeRfVFmqA/SVJsDj
         f2Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785622830; x=1786227630;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KpiN/DbQ8ItK+lLWEkdUdhZl6h4pC7IGE3YTKxkXcVI=;
        b=mLPv/rbUNO5AwsCH8qFr86KbveGU+ZmxVDU47GQvhKqdirujR7WkCjcjk1RRJ7fcTX
         /yRlK4oSKipYICi3vlHaFR9Jlp7pswFFMQToQA0ig/ai3tm8kYJXMs2ydIdhT6D9JLdP
         jpCKTfESUDhV3bR/2qUa6FOutu8Cc264skBgtJNTDwbWPhY4epyYuA+Q+3IxCLEOAPzT
         x17QJgTzEO5w7VK75ckiXIPmUhi/1Eiyb92mWU1+5gvS5UcLAUTWq/LuxBLwDhNG2/9D
         5gY2UnPmxrNx+71v+tGsks1aDbEoMoSUMiP46drqvYRKkGp42l/j1oVEWPW5KcTfGMnN
         kcqw==
X-Gm-Message-State: AOJu0YwPDlYVVXKE9rk9RrRybei1SSN+s7fegqhum2iPg1jvey1akJoH
	9ocJyJIPYyUjiXO46+8Vj+YRwH203r89ucJIR99tJ0Wy8OMGwiDyUfVy
X-Gm-Gg: AR+sD11dm+4xmvbvUmBcDptbaAt49beqUG/Ki261lS+QalYpcUvRh+20e+BVJP64W7i
	yNQxLcrqbj7JOKqXudZTohD9crj7ecXrhErAJtyTFualqjBxWErVECIiJGSRmImPBj4ykOsxO9f
	bGbsysk2zd1C8UInfBGbyQp1pj9X7A5TvK7Ayt11EudEi1ln7gOEwq7vLOd38oFsHx+Jym9LNOb
	fxdtiH+aPuKPO2JP0zZFJE2OHtZX8BQYmfsD3MlJHDf3plz0zWwBATtNn39NkbQwiLxbD5g9jSM
	s/MYnDsk7xrhKBEMl0KdIe7wq/dunQ3DaXoYCsa/vePW0h8rI6LKhSKWIWbCczJ1CtzDrii0s+g
	ajXS6jUZRO82P4TCSOgchmJMV3xwjuaMA2WsWYDCGBM/knvmAMxQPpBo0WSZ9SH0enhjalrtTG/
	3A9cxhOJjrmHorRguFCUgVKsXClhU4A+b1m6ms9qEmdK7u6bhBdOgmpyEMFmTPUWMBqPduzHJHp
	SoEtrU3Rn8a5FnC9YBTNTTuZgp6zQ8ki3XdVHIS0AyHf1fA/twyTcmZ+jlplc47nVeKby/MxPN8
	P1vVprZor+QWIsZn4Opw/yozwpITbrFO2r0j6wRYzWLOgrmfVFW/ZUw1YuY/2ouXexJt2yqxn9U
	=
X-Received: by 2002:a05:600c:3150:b0:495:3c6f:7c18 with SMTP id 5b1f17b1804b1-4980eb8c4c9mr62050375e9.3.1785622829500;
        Sat, 01 Aug 2026 15:20:29 -0700 (PDT)
Received: from localhost ([47.58.8.78])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-498081a1006sm122213415e9.7.2026.08.01.15.20.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Aug 2026 15:20:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 02 Aug 2026 00:20:28 +0200
Message-Id: <DKDYGQRTSF2W.25OU81K306HJN@gmail.com>
Cc: <git@vger.kernel.org>, <chandrapratap3519@gmail.com>,
 <karthik.188@gmail.com>, <peff@peff.net>
Subject: Re: [PATCH GSoC v2 4/6] fetch-object-info: parse type from server
 response
From: "Pablo Sabater" <pabloosabaterr@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, "Pablo Sabater"
 <pabloosabaterr@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260731-objecttype-support-v2-0-af577461ed57@gmail.com>
 <20260731-objecttype-support-v2-4-af577461ed57@gmail.com>
 <xmqq7bmaa0sw.fsf@gitster.g> <xmqqzez67yg1.fsf@gitster.g>
In-Reply-To: <xmqqzez67yg1.fsf@gitster.g>

On Sat Aug 1, 2026 at 3:38 PM CEST, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>>> +		} else if (!strcmp(reader->line, "type")) {
>>> +			type_index =3D (int)i;
>>> +			for (size_t j =3D 0; j < args->oids->nr; j++)
>>> +				object_info_data[j].typep =3D
>>> +					xcalloc(1, sizeof(*object_info_data[j].typep));
>>
>> Do object_info_data[j].typep and object_info_data[k].typep need to
>> be independently freeable?  Separate allocations by calling calloc
>> args->oids->nr times would allow that, but if there is no such need,
>> nr contiguous allocation of them,
>
> Stepping back a bit, the design of "odb.h:struct object_info" look
> rather curious.
>
> Why does the struct store scalar values like "enum object_type" and
> "size_t" as a pointer to elsewhere, and does not store the values
> right there in the structure itself?  By forcing the caller to
> allocate an "enum object_type" for each of these object_info[]
> elements, the design requires 8-byte for a pointer to the heap and
> malloc overhead, probably ~16 bytes or more, in addition to store a
> single "enum object_type" that can be stored in a single byte.
>
> We are probably using this pointer indirection to say "ah, typep is
> NULL so the caller did not ask for this information and the object
> layer does not have to provide one", plus "typep is NULL so the
> engine did not give this information for the object".  But we can do
> so with two bitfields "unsigned typep_asked:1, typep_valid:1;"
> instead of paying ~24-byte or more heap allocation overhead.
>
> Again, this is not something we can change in the middle of this
> topic, but since I noticed it and found iffy, I'll leave a note here
> to stir the pot anyway.
>
> Stepping back a bit, the design of odb.h:struct object_info looks
> rather curious.
>
> Why does the struct store scalar values like enum object_type and
> size_t as pointers to elsewhere, rather than storing the values
> right there in the structure itself?  By forcing the caller to
> allocate an enum object_type for each of these object_info[]
> elements, the design requires an 8-byte pointer to the heap and
> malloc overhead, probably ~16 bytes or more, to store a single
> enum object_type that could fit in a single byte.
>
> We are probably using this pointer indirection to say "ah, '.typep'
> is NULL so the caller did not ask for this information and the
> object layer does not have to provide it", plus "'.typep' is NULL
> so the engine did not give this information for the object".  But we
> can do so with two bitfields
>
>     unsigned type_asked:1,
>              type_valid:1;
>
> instead of paying ~24 bytes or more of heap allocation overhead.
>
> Again, this is not something we can change in the middle of this
> topic, but since I noticed it and found it iffy, I'll leave a note
> here to stir the pot anyway.  It could be something we may want to
> clean-up much later after all the dust settles from this year's
> GSoC.  I dunno.

[CC'ing peff]

Hi!

I haven't stopped to think about that but it does look strange.

This is related to what had to be done to fix a bug at "contents"
commands a few days ago [1].

In that patch it had to save the previous state of typep and then
restore it, because other commands like "info" and this series one
"remote-object-info" use this pointer for the "is this asked?" question.

If we take a look at expand_atom():

	...
	} else if (is_atom("objecttype", atom, len)) {
		if (data->mark_query) {
			data->info.typep =3D &data->type;
		} else {
			const char *t =3D type_name(data->type);
			strbuf_addstr(sb, t ? t : "");
		}
	...

expand_atom() has two responsibilities, it is called at the start to map
which atoms are asked (when data->mark_query), and a second to expand
those atoms.

For example, typep being non-NULL does this effect on these commands:

info: makes a type lookup, and fills type.

remote-object-info: typep is directly used to know whether a client has
                    asked for %(objecttype).

For both commands what we pay is extra work because at the end the data
shown is the one expanded from the format.

It's out of scope for this series but I wanted to add what I know.

[1]: https://lore.kernel.org/git/20260728150031.GA41931@coredump.intra.peff=
.net/

Thanks,
Pablo
