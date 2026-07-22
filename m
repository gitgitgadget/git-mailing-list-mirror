Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D178829D260
	for <git@vger.kernel.org>; Wed, 22 Jul 2026 12:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784725160; cv=none; b=iaDh8UbMzM0BsEpvfZ+n3g3VS8MAWa6+0YA3FTWa++aOb1tB1S3Bje8X5xMfYtLuo7tp5BWaGmdMxbG2pgwmd4u9hFpC9yu37XW04QEAcsiAll2BWOItbvHWP0LH1BK6tWV3S86H37s8lKpdK76xNHNYzq2dHZmSyt+m1iQvic4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784725160; c=relaxed/simple;
	bh=r39mFeqco/s++N5K/f8uM/FNXpeDReUSRf+IOk881kE=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=nzZUIf3TDq07DYMM6CRlD//wqwbEt7LxqcBTJOIzXRKtiOf6sblid8HmA5mwdm/wK1hg04o7CgHyZ7iI/Xz9vUEPCVb8RvAY4DnLSaVmdg7jnk5XNkGvsj88gapPOT3DZ4ksIYg3Qo1ZWOw9ZTk0YiBEcLzM8AILp5YWeyMr20Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ob90gW3D; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ob90gW3D"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-495590dde14so35744705e9.0
        for <git@vger.kernel.org>; Wed, 22 Jul 2026 05:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784725157; x=1785329957; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gedsQx5ywodh1i2I3Ao2h2l4LYmlz5gAuWB7IrBAb7E=;
        b=Ob90gW3DE8zK/vg+MKHlTuwcPGbtqRfRtYy1Abj112mNeNSxsXYOKmspIH0JXCVgcE
         ohXVuNm3ZvmA4mYwuCvkJvIBDKPbqU7l7FaBmXQDaR1vjTc96YeH830fTNlAXQ83Fiq9
         9EzfFeiTr/J4hiJTEfTmO3grGE4PeC9SfprOPyVTHyJZTi/ZH6p2EhX/gM3CzEZqgA8e
         Sf5xF5a2W2YAwxk/t9T1AvJL1+sBJ1LZbLXq1E28XaLD25Y3HO5yYIRzLM22HZUs+iGT
         X9q+tGNtf9uNZ2SPqN7hTdyodO/OYFXFnj8+4g6XunXTeIUbyUo72AjhdyONfTu2lfgi
         1+Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784725157; x=1785329957;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gedsQx5ywodh1i2I3Ao2h2l4LYmlz5gAuWB7IrBAb7E=;
        b=Dv+u8PlzAUZz8fW2uCh5Amcr1LFf1DPjPlkU6J8kbK+ijymh7/bTQq5XzrD1c3c1FJ
         tpfpXDDkEE/n7J5BGBv9yZCwjxdKnHT5ngExCqHGQxWrQ3OCH0oWYHd+eTExETxhV9Up
         XvYRrUnbUVEkahWFm5xH69BS+AUMDdrQja7/NfkLwkrU6EmtwvLuI30zIMXFbMdGPP2x
         Oy6kqaKhM3O5g7W/4zgkFA+xReZzOiF7X9YOs1xbnvnKuOlaZ2q66vDJQkhLr1JSqWrI
         ohMvai39yRxDEoCplRRxNWveaKiI0pUZyiMqMpj0SsZiCrmdNBnfICCe/IK0pBaFB/5Q
         rx/w==
X-Forwarded-Encrypted: i=1; AHgh+RrPuQ4On/yOSuvyByJtLjF0RQXgdCxlYuI7gpQs+PbCtcz7b5hSLEHr/s1pmHK4BAhIGL0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz4p7eaUSL8mmAglJlkE+/oEDIaeSrGJpR+gInNyosGwKxduVD
	8WRMi6OWjFycmei4WQy4qzZoqPo4Y8K3vQ41QrXMApX/p8m5a6h9YRlW
X-Gm-Gg: AR+sD13EeYOycv8F1yEG5WkbNviogE+RI9yv7+stwclz9hZpYy/cdOUT66Brz2Lm2FB
	Agb+rEBb1kJA6d6DtYKmhQCKUKJjdrrYg+ZXnZ84xnPZCSye13U5XQI2nMmyYnhf+c49VJp3n+0
	qGXdefWrQ7ylT8kvFzh5v/Yk6wfXGlQpXK9R78V15MJjhQr9eLcCR4kBrzAJNr/rhxW4gTQTU9C
	KNYznPpct18LwK1NhO3EKABBkblroC52BK7rS2SnHBPotiaOU4pvKcC3JSKzSuveDyLZGQxSTAK
	FzQlGcFsENViDpqBdH9gT0WsP/lSxC4HsFJtOvgxib9IVrTzO2t3gggBfnioQ6z5QRxJBJtsMSJ
	j8jhNTeydxPlxQLgzCavoXvyBDRfTKepJbJwcXcg2sdyFBaJkHUpRUf2nuIN8d3c74TzmpnT1US
	iGmpJN/fecZYfd27VpT/7W8dsGJSydwihQZoJ6Gh3cjk7RC8t3aY/l2NtK5ClajxDo8/p98Zqmd
	bMQF8I+5QVGO0gc6Yv061Aql/TsX6wltOgAGv/29gcB//YXCSum8kNpa25ONFihd/wanDj2anAq
	xPfufj2PJgDNvV0DL4EHGkBst424D2A/nQ8zuxt5+4sUG6s0m0PQxi5atN5lbF7E+1s=
X-Received: by 2002:a05:600c:c04c:b0:495:63e4:3a91 with SMTP id 5b1f17b1804b1-49563e43af2mr92980365e9.35.1784725156778;
        Wed, 22 Jul 2026 05:59:16 -0700 (PDT)
Received: from localhost (82.159.183.80.static.user.ono.com. [82.159.183.80])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-495653731b2sm147530455e9.4.2026.07.22.05.59.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2026 05:59:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Jul 2026 14:59:15 +0200
Message-Id: <DK549LIZS8BS.3PL9CQQIR2LAA@gmail.com>
From: "Pablo Sabater" <pabloosabaterr@gmail.com>
To: "Karthik Nayak" <karthik.188@gmail.com>, "Pablo Sabater"
 <pabloosabaterr@gmail.com>, <git@vger.kernel.org>
Cc: <chandrapratap3519@gmail.com>, <chriscool@tuxfamily.org>,
 <eric.peijian@gmail.com>, <gitster@pobox.com>, <jltobler@gmail.com>,
 <peff@peff.net>, <toon@iotcl.com>, <szeder.dev@gmail.com>
Subject: Re: [PATCH GSoC v20 00/13] cat-file: add remote-object-info to
 batch-command
X-Mailer: aerc 0.21.0
References: <20260717-ps-eric-work-rebase-v19-0-d4faee35764b@gmail.com>
 <20260718-ps-eric-work-rebase-v20-0-0c13962ac532@gmail.com>
 <CAOLa=ZT77L39-jSZxgrvVFwdY6_rapBmKv8gCxr7QpdkCsEzXg@mail.gmail.com>
In-Reply-To: <CAOLa=ZT77L39-jSZxgrvVFwdY6_rapBmKv8gCxr7QpdkCsEzXg@mail.gmail.com>

On Tue Jul 21, 2026 at 10:12 PM CEST, Karthik Nayak wrote:
> Pablo Sabater <pabloosabaterr@gmail.com> writes:
>
> [snip]
>
>> Changes in v20:
>> - Moved the prep patch that fixes hash_algo's type to be before
>>   write_fetch_command_and_capabilities() being moved to 'connect.c'
>> - Reverted git-cat-file.adoc documentation comments about CAVEATS
>> - Fixed style for EXPAND_DATA_INIT
>> - Added more context for comman line die()
>>
>
> [snip]
>
>> Range-diff versus v19:
>>
>>  1:  6df5bcb3bc =3D  1:  31b02f10b5 transport-helper: fix memory leak of=
 helper on disconnect
>>  2:  141d85a76f =3D  2:  7d62e0586f cat-file: declare loop counter insid=
e for()
>>  3:  87457a1fe3 =3D  3:  082d593fb7 t1006: extract helper functions into=
 new 'lib-cat-file.sh'
>>  4:  c26d378931 =3D  4:  8646b9d7cf fetch-pack: drop the static advertis=
e_sid variable
>>  -:  ---------- >  5:  5531a3c399 fetch-pack: use unsigned int for hash_=
algo variable
>>  5:  ee16e17228 !  6:  92b4122642 fetch-pack: move write_fetch_command_a=
nd_capabilities() to connect.c
>>     @@ connect.c: int server_supports(const char *feature)
>>      +	}
>>      +
>>      +	if (server_feature_v2("object-format", &hash_name)) {
>>     -+		int hash_algo =3D hash_algo_by_name(hash_name);
>>     ++		const unsigned int hash_algo =3D hash_algo_by_name(hash_name);
>>      +		if (hash_algo_by_ptr(the_hash_algo) !=3D hash_algo)
>>      +			die(_("mismatched algorithms: client %s; server %s"),
>>      +			    the_hash_algo->name, hash_name);
>>     @@ fetch-pack.c: static int add_haves(struct fetch_negotiator *negot=
iator,
>>      -	}
>>      -
>>      -	if (server_feature_v2("object-format", &hash_name)) {
>>     --		int hash_algo =3D hash_algo_by_name(hash_name);
>>     +-		const unsigned int hash_algo =3D hash_algo_by_name(hash_name);
>>      -		if (hash_algo_by_ptr(the_hash_algo) !=3D hash_algo)
>>      -			die(_("mismatched algorithms: client %s; server %s"),
>>      -			    the_hash_algo->name, hash_name);
>>  6:  bb915f57ad <  -:  ---------- connect: use unsigned int for hash_alg=
o_by_name() calls
>>  7:  b3b06b0cae =3D  7:  b954a5994a connect: make write_fetch_command_an=
d_capabilities() more generic
>>  8:  79a87c7011 =3D  8:  627242a7a1 fetch-pack: move fetch initializatio=
n
>>  9:  37c3f93975 =3D  9:  0578594733 protocol-caps: check object existenc=
e regardless of the attributes requested
>> 10:  c5062ecaf2 =3D 10:  816bfa9162 serve: advertise object-info feature
>> 11:  22d72168bc =3D 11:  2323f45cb2 transport: add client support for ob=
ject-info
>> 12:  2cf3b24a35 ! 12:  a39975766b cat-file: add remote-object-info to ba=
tch-command
>>     @@ Documentation/git-cat-file.adoc: one per line, and print informat=
ion based on th
>>       You can specify the information shown for each object by using a c=
ustom
>>       `<format>`. The `<format>` is copied literally to stdout for each
>>      @@ Documentation/git-cat-file.adoc: newline. The available atoms ar=
e:
>>     - 	reports).
>>     -
>>     - `objectsize:disk`::
>>     --	The size, in bytes, that the object takes up on disk. See the
>>     --	note about on-disk sizes in the `CAVEATS` section below.
>>     -+	The size, in bytes, that the object takes up on disk.
>>     -
>>       `deltabase`::
>>       	If the object is stored as a delta on-disk, this expands to the
>>       	full hex representation of the delta base object name.
>>      -	Otherwise, expands to the null OID (all zeroes). See `CAVEATS`
>>     --	below.
>>     -+	Otherwise, expands to the null OID (all zeroes).
>>     ++	Otherwise, expands to the null OID (all zeroes). See `CAVEATS` se=
ction
>>     + 	below.
>>
>
> This chagne is still unnecessary, no?

I guess it is unnecessary. I added it because on top, at objectsize:disk
it says "`CAVEATS` section". So I tried to have it consistently.

Is it worth a reroll?

>
>>       `rest`::
>>     - 	If this atom is used in the output string, input lines are split
>>      @@ Documentation/git-cat-file.adoc: newline. The available atoms ar=
e:
>>       	after that first run of whitespace (i.e., the "rest" of the
>>       	line) are output in place of the `%(rest)` atom.
>>     @@ builtin/cat-file.c: struct expand_data {
>>      +	 */
>>      +	unsigned is_remote:1;
>>      +};
>>     ++
>>      +#define EXPAND_DATA_INIT  { .mode =3D S_IFINVALID, .type =3D OBJ_B=
AD }
>>      +
>>      +static const char *remote_object_info_atoms[] =3D {
>>     @@ builtin/cat-file.c: static void parse_cmd_mailmap(struct batch_op=
tions *opt UNUS
>>      +	line_to_split =3D xstrdup(line);
>>      +	count =3D split_cmdline(line_to_split, &argv);
>>      +	if (count < 0)
>>     -+		die(_("remote-object-info: %s"), split_cmdline_strerror(count));
>>     ++		die(_("remote-object-info: failed to parse command line: %s"),
>>     ++		    split_cmdline_strerror(count));
>>      +	if (count - 1 > MAX_ALLOWED_OBJ_LIMIT)
>>      +		die(_("remote-object-info supports at most %d objects"),
>>      +		    MAX_ALLOWED_OBJ_LIMIT);
>> 13:  ebdfc22fb7 ! 13:  70a11d2aea cat-file: make remote-object-info allo=
w-list adapt to the server
>>     @@ builtin/cat-file.c: struct expand_data {
>>       	 */
>>       	unsigned is_remote:1;
>>      -};
>>     +-
>>      -#define EXPAND_DATA_INIT  { .mode =3D S_IFINVALID, .type =3D OBJ_B=
AD }
>>
>>      -static const char *remote_object_info_atoms[] =3D {
>>      -	"objectname",
>>      -	"objectsize",
>>     ++	/*
>>     ++	 * List of atoms (i.e. "objectsize") that the server supports. Bu=
ilt
>>     ++	 * from the server's object-info advertised capabilities.
>>     ++	 */
>>      +	struct string_list remote_allowed_atoms;
>>       };
>>     -+#define EXPAND_DATA_INIT  { .mode =3D S_IFINVALID, .type =3D OBJ_B=
AD, \
>>     -+			    .remote_allowed_atoms =3D STRING_LIST_INIT_NODUP }
>>
>>     ++#define EXPAND_DATA_INIT  { .mode =3D S_IFINVALID, \
>>     ++			    .type =3D OBJ_BAD, \
>>     ++			    .remote_allowed_atoms =3D STRING_LIST_INIT_NODUP }
>>     ++
>
> I guess this is output of running the style check script (which I did
> recommend, but I should've mentioned that you should take it with a
> pinch of salt, it doesn't always provide the best solutions.)

It comes in part from Junio's suggestion [1]. Although I don't think that
it will receive a lot of new fields, I thought that it would leave the
macro clean for that.

>
>>       static int is_atom(const char *atom, const char *s, int slen)
>>       {
>>     + 	int alen =3D strlen(atom);
>>      @@ builtin/cat-file.c: static int expand_atom(struct strbuf *sb, co=
nst char *atom, int len,
>>       		       struct expand_data *data)
>>       {
>>     @@ builtin/cat-file.c: static int expand_atom(struct strbuf *sb, con=
st char *atom,
>>      -			if (is_atom(remote_object_info_atoms[i], atom, len))
>>      +		size_t i;
>>      +		for (i =3D 0; i < data->remote_allowed_atoms.nr; i++)
>>     -+			if (is_atom(data->remote_allowed_atoms.items[i].string, atom, l=
en))
>>     ++			if (is_atom(data->remote_allowed_atoms.items[i].string,
>>     ++				    atom, len))
>>       				break;
>>      -
>>      -		/*
>>
>> ---
>> base-commit: 44de1520f08d1dfebc3ab2d9f644208eaa5ac925
>
> I reviewed v18 last, but the diff here looks good to me. Thanks!

[1]: https://lore.kernel.org/git/xmqqcxwonnkx.fsf@gitster.g/

Thanks,
Pablo
