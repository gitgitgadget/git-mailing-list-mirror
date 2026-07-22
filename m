Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC143C943F
	for <git@vger.kernel.org>; Wed, 22 Jul 2026 16:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784736788; cv=pass; b=Gfwcr24B9QDrbaEeXIF7DAEgnmMNvke4ak03luqK2xdGkSCgoWzz/RHvMe2+ylGJu7eBb1+8vjDqWs4Ksgx5NytFcvw9++lA3nLTRS8/sLutbJjWwS8YMewQ5BcPKyKzg237k2qhmjWkdMhB4IEqWw4nyFWdgqXCBtuom7FDLlI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784736788; c=relaxed/simple;
	bh=zZNyyV9f4LO4T1DW6yEBLqHlZeUgZ/zBkNG/LedQrXc=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cfmvOJIuQige1SZGka/O70y7Tu676X3Zy9FeUe94rVrbbHG/WwoGu0f+8f09MinIzb0RpGaDvZ8GnOKROYSNwpI3a5GauGr1kcLWo0187pRuRUepHO5Jwj+bCIy8xxYq6dZPjb/161Ar7S91D1fXnmPC6Radz9GUEOSdaqDRcmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gj0QL7Qv; arc=pass smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gj0QL7Qv"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-963f63fe025so2440000241.0
        for <git@vger.kernel.org>; Wed, 22 Jul 2026 09:13:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784736785; cv=none;
        d=google.com; s=arc-20260327;
        b=gjad66lMZL7Gcx+RYvubxqtXYWa+tLmCBftp47yybKkeTymmvzzO78V6tg3bUM8A+d
         ycABbw0gSuVCIgURDwluwWsvuzBLTNy3+rPKVv8/FVUYcCDUa8wNKli3Rj4vWTCLBvw3
         Yl/WIOoMdSDRFI3yBfupVNp+3JTVEDt6QnsfX1dKPdBztg0tjyusPKoFJ0AQ/9Xo1fgR
         3b5yyhKV/OBOU7G8N0YqrPdljeh/B2oosknKKjRJG41CNsGgNzBBhORmirF0bV0VBIE2
         q3BWzxnT38VNBDXnCAClqr/4IDGWdxtzPAghQTWdB3Cp3V+wue3hVe45QIh/T1zQKCFg
         5UMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=4FLsS5dj+afb+CiNdaWWeU4d9334yv6FKa8ax2plLc0=;
        fh=FMleLqD+7TXy1F9P3jD4TeTwaXtqsQrNbp5yvgryTHM=;
        b=Lb064nRPtvSh6SOz0nh3JizROpIeZ043gM+8p4zTyRX2PiF+J81qIYzN/6/8Jut8QW
         Rr5dpK4Y2wBrQexb+zuiRSDer0tXjs3n9qN8P9RgkffFHFN3CxiXNWjSMplICeNKdwHT
         rjhutidu7ELd1FDavfI/YbRXvEJXhqE/MvvYCIXEvhmp4+G1jSSXHlvefgeW9KjIZHZ5
         QcM66Nv775an34/+PTkbedFmBWzFIMCUvqGn0zs3BwFtM1fz56XEvMHDO5D2LZPq1OEP
         uvqg4dyxAIYRwTNMh4x2JLwUBMeQo6AbfjKvx+Zx75rq6AibqqtFfkZCis88lariNXAI
         TWWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784736785; x=1785341585; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4FLsS5dj+afb+CiNdaWWeU4d9334yv6FKa8ax2plLc0=;
        b=Gj0QL7Qv0IXc3C0QTnh2MnX/fQxQAKHUv2ElH0R2tVUiDqVHUU1D1quxs2q3h3gsvT
         U/QZVXDlLRAjYfJjjY/XVAzjTmgorWvh+BSuH7v3w/MOG1qeNJ6cBe00IvKwQ4CX/zEx
         yDMupZ/fQtVE9ty/87SCuf0/ZuN5AoGK55/68mGwTtxC7YOpDMDJ1ezzZVGbPAbE/8Lg
         BlqM1j6/2aRvhCaWmEv24v78B0/GG8Rv4lyajKDIYVyOJ0r6w3madPgFQo/gNSoUkO9+
         mE1n1o5qxaDM/AAbp71qdKtLmxMUhw6T6k8I4ihq4bdushmevKDbDpjjZn/9beLU10Ro
         aaiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784736785; x=1785341585;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4FLsS5dj+afb+CiNdaWWeU4d9334yv6FKa8ax2plLc0=;
        b=fyO9qVN/as4UQjyS/1GfxWckFCEHdGfsYndigVVBLKN68DzkTQY9FBZNZldV2P9TsS
         uaOLnGX0Rzc/7JEbv5eJ7wks2eT/0lnQ9VzFk1wlIigDGXVpLMbQQsxrXc05ZzmLibEF
         F7Yj5DZejYNWm02G2MbZr1AoZiTcqUIizdGCXzcmSiEkiPvaB/w6c/6StPRhDGExbgRZ
         ADth3NsRfswf2hDVsiTR5SwdYeiIOnKzb2ZD6cSHRwrPXiUs13hGKTOO5sUIEDsuZxDy
         3B3KL+WEjMIXfrSRb1mhhKNEfvSJnv5Xti9whrvM6F6EOkrVWX2C+rs3GOwNRjVGea4U
         vfMQ==
X-Forwarded-Encrypted: i=1; AHgh+RrkUjsGwfXCneN57S3j1InAYSCq1ZbYNMZRAQoH+PBSEGlVmB9zrBRESu9JLwRmCNcI8CU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxew1gTUH1NDJPusV5lhQrwEEg6Qz9OMaKbleL6kIYHugb1mozj
	l4M7MQ2PbJ/1Kcg174FSmd+zLRu+G1ds02vfSqLqg0ZdxevfAkAgh5lIEP4nyJsMU9VFx4x44KA
	MdQRL791BkZ0e7u6g4BPL1H7v8r+TuA4=
X-Gm-Gg: AR+sD12S9FdKcFefMmUARDY7ZdOIK+GT+BstD6kfcos6COIkl5TbqOHpTPAV8cNTcEn
	J5cqdNCnSWG6cmOqRuDIfr+oZc6AXEilhgVsnMwY6UJvldOUfSFx5wmYiIGPgUVwUNYei8mNyHM
	7ZqIurS67+HEuEhdaDv5H5S1Sr8pIYdfafAThTxfNvoHl8KYCv/4NGJBBj0ExCiMaGRNW2Jbofr
	x+OM8BB2U6FMG0n2dMdy3fjvaImfkO66IcKataahGaaUjsjqcyn1hQYIm42t4Lst0vbyzFYnSXi
	r16Fzglr0T/zJ02xrrL+6ULinRmNEnweNasZz64l5EyPVVl+v/U=
X-Received: by 2002:a05:6102:424a:b0:745:9c0f:9353 with SMTP id
 ada2fe7eead31-7475374f68bmr7203671137.27.1784736785162; Wed, 22 Jul 2026
 09:13:05 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 22 Jul 2026 12:13:04 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 22 Jul 2026 12:13:04 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <DK549LIZS8BS.3PL9CQQIR2LAA@gmail.com>
References: <20260717-ps-eric-work-rebase-v19-0-d4faee35764b@gmail.com>
 <20260718-ps-eric-work-rebase-v20-0-0c13962ac532@gmail.com>
 <CAOLa=ZT77L39-jSZxgrvVFwdY6_rapBmKv8gCxr7QpdkCsEzXg@mail.gmail.com> <DK549LIZS8BS.3PL9CQQIR2LAA@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 22 Jul 2026 12:13:04 -0400
X-Gm-Features: AUfX_mxuJNlhdAV9skb0C7o-g0kBZbLAFmvnjyxcv5BOFH0P7z9lRS2WUjQV2YE
Message-ID: <CAOLa=ZS8J4t12ab1=3-LRYNuZOwqSHG861iYm97JjF3mGprvJA@mail.gmail.com>
Subject: Re: [PATCH GSoC v20 00/13] cat-file: add remote-object-info to batch-command
To: Pablo Sabater <pabloosabaterr@gmail.com>, git@vger.kernel.org
Cc: chandrapratap3519@gmail.com, chriscool@tuxfamily.org, 
	eric.peijian@gmail.com, gitster@pobox.com, jltobler@gmail.com, peff@peff.net, 
	toon@iotcl.com, szeder.dev@gmail.com
Content-Type: multipart/mixed; boundary="00000000000019085c0657356a7b"

--00000000000019085c0657356a7b
Content-Type: text/plain; charset="UTF-8"

"Pablo Sabater" <pabloosabaterr@gmail.com> writes:

> On Tue Jul 21, 2026 at 10:12 PM CEST, Karthik Nayak wrote:
>> Pablo Sabater <pabloosabaterr@gmail.com> writes:
>>
>> [snip]
>>
>>> Changes in v20:
>>> - Moved the prep patch that fixes hash_algo's type to be before
>>>   write_fetch_command_and_capabilities() being moved to 'connect.c'
>>> - Reverted git-cat-file.adoc documentation comments about CAVEATS
>>> - Fixed style for EXPAND_DATA_INIT
>>> - Added more context for comman line die()
>>>
>>
>> [snip]
>>
>>> Range-diff versus v19:
>>>
>>>  1:  6df5bcb3bc =  1:  31b02f10b5 transport-helper: fix memory leak of helper on disconnect
>>>  2:  141d85a76f =  2:  7d62e0586f cat-file: declare loop counter inside for()
>>>  3:  87457a1fe3 =  3:  082d593fb7 t1006: extract helper functions into new 'lib-cat-file.sh'
>>>  4:  c26d378931 =  4:  8646b9d7cf fetch-pack: drop the static advertise_sid variable
>>>  -:  ---------- >  5:  5531a3c399 fetch-pack: use unsigned int for hash_algo variable
>>>  5:  ee16e17228 !  6:  92b4122642 fetch-pack: move write_fetch_command_and_capabilities() to connect.c
>>>     @@ connect.c: int server_supports(const char *feature)
>>>      +	}
>>>      +
>>>      +	if (server_feature_v2("object-format", &hash_name)) {
>>>     -+		int hash_algo = hash_algo_by_name(hash_name);
>>>     ++		const unsigned int hash_algo = hash_algo_by_name(hash_name);
>>>      +		if (hash_algo_by_ptr(the_hash_algo) != hash_algo)
>>>      +			die(_("mismatched algorithms: client %s; server %s"),
>>>      +			    the_hash_algo->name, hash_name);
>>>     @@ fetch-pack.c: static int add_haves(struct fetch_negotiator *negotiator,
>>>      -	}
>>>      -
>>>      -	if (server_feature_v2("object-format", &hash_name)) {
>>>     --		int hash_algo = hash_algo_by_name(hash_name);
>>>     +-		const unsigned int hash_algo = hash_algo_by_name(hash_name);
>>>      -		if (hash_algo_by_ptr(the_hash_algo) != hash_algo)
>>>      -			die(_("mismatched algorithms: client %s; server %s"),
>>>      -			    the_hash_algo->name, hash_name);
>>>  6:  bb915f57ad <  -:  ---------- connect: use unsigned int for hash_algo_by_name() calls
>>>  7:  b3b06b0cae =  7:  b954a5994a connect: make write_fetch_command_and_capabilities() more generic
>>>  8:  79a87c7011 =  8:  627242a7a1 fetch-pack: move fetch initialization
>>>  9:  37c3f93975 =  9:  0578594733 protocol-caps: check object existence regardless of the attributes requested
>>> 10:  c5062ecaf2 = 10:  816bfa9162 serve: advertise object-info feature
>>> 11:  22d72168bc = 11:  2323f45cb2 transport: add client support for object-info
>>> 12:  2cf3b24a35 ! 12:  a39975766b cat-file: add remote-object-info to batch-command
>>>     @@ Documentation/git-cat-file.adoc: one per line, and print information based on th
>>>       You can specify the information shown for each object by using a custom
>>>       `<format>`. The `<format>` is copied literally to stdout for each
>>>      @@ Documentation/git-cat-file.adoc: newline. The available atoms are:
>>>     - 	reports).
>>>     -
>>>     - `objectsize:disk`::
>>>     --	The size, in bytes, that the object takes up on disk. See the
>>>     --	note about on-disk sizes in the `CAVEATS` section below.
>>>     -+	The size, in bytes, that the object takes up on disk.
>>>     -
>>>       `deltabase`::
>>>       	If the object is stored as a delta on-disk, this expands to the
>>>       	full hex representation of the delta base object name.
>>>      -	Otherwise, expands to the null OID (all zeroes). See `CAVEATS`
>>>     --	below.
>>>     -+	Otherwise, expands to the null OID (all zeroes).
>>>     ++	Otherwise, expands to the null OID (all zeroes). See `CAVEATS` section
>>>     + 	below.
>>>
>>
>> This chagne is still unnecessary, no?
>
> I guess it is unnecessary. I added it because on top, at objectsize:disk
> it says "`CAVEATS` section". So I tried to have it consistently.
>
> Is it worth a reroll?
>

No I don't think a re-roll is necessary. But something to avoid next
time :)

>>
>>>       `rest`::
>>>     - 	If this atom is used in the output string, input lines are split
>>>      @@ Documentation/git-cat-file.adoc: newline. The available atoms are:
>>>       	after that first run of whitespace (i.e., the "rest" of the
>>>       	line) are output in place of the `%(rest)` atom.
>>>     @@ builtin/cat-file.c: struct expand_data {
>>>      +	 */
>>>      +	unsigned is_remote:1;
>>>      +};
>>>     ++
>>>      +#define EXPAND_DATA_INIT  { .mode = S_IFINVALID, .type = OBJ_BAD }
>>>      +
>>>      +static const char *remote_object_info_atoms[] = {
>>>     @@ builtin/cat-file.c: static void parse_cmd_mailmap(struct batch_options *opt UNUS
>>>      +	line_to_split = xstrdup(line);
>>>      +	count = split_cmdline(line_to_split, &argv);
>>>      +	if (count < 0)
>>>     -+		die(_("remote-object-info: %s"), split_cmdline_strerror(count));
>>>     ++		die(_("remote-object-info: failed to parse command line: %s"),
>>>     ++		    split_cmdline_strerror(count));
>>>      +	if (count - 1 > MAX_ALLOWED_OBJ_LIMIT)
>>>      +		die(_("remote-object-info supports at most %d objects"),
>>>      +		    MAX_ALLOWED_OBJ_LIMIT);
>>> 13:  ebdfc22fb7 ! 13:  70a11d2aea cat-file: make remote-object-info allow-list adapt to the server
>>>     @@ builtin/cat-file.c: struct expand_data {
>>>       	 */
>>>       	unsigned is_remote:1;
>>>      -};
>>>     +-
>>>      -#define EXPAND_DATA_INIT  { .mode = S_IFINVALID, .type = OBJ_BAD }
>>>
>>>      -static const char *remote_object_info_atoms[] = {
>>>      -	"objectname",
>>>      -	"objectsize",
>>>     ++	/*
>>>     ++	 * List of atoms (i.e. "objectsize") that the server supports. Built
>>>     ++	 * from the server's object-info advertised capabilities.
>>>     ++	 */
>>>      +	struct string_list remote_allowed_atoms;
>>>       };
>>>     -+#define EXPAND_DATA_INIT  { .mode = S_IFINVALID, .type = OBJ_BAD, \
>>>     -+			    .remote_allowed_atoms = STRING_LIST_INIT_NODUP }
>>>
>>>     ++#define EXPAND_DATA_INIT  { .mode = S_IFINVALID, \
>>>     ++			    .type = OBJ_BAD, \
>>>     ++			    .remote_allowed_atoms = STRING_LIST_INIT_NODUP }
>>>     ++
>>
>> I guess this is output of running the style check script (which I did
>> recommend, but I should've mentioned that you should take it with a
>> pinch of salt, it doesn't always provide the best solutions.)
>
> It comes in part from Junio's suggestion [1]. Although I don't think that
> it will receive a lot of new fields, I thought that it would leave the
> macro clean for that.
>

Then wouldn't something like this be better?

     #define EXPAND_DATA_INIT  {  \
             .mode = S_IFINVALID, \
             .type = OBJ_BAD,     \
             .remote_allowed_atoms = STRING_LIST_INIT_NODUP, \
    }

Note the difference:
1. The first line no longer has the '.mode' field, this would ensure
that removal of the field is a diff which only contains the field and
not movement of other fields to the top line.
2. Similar for the last time.
3. We also add a comma for the last field, this allows addition of new
fields without modifying previous lines by adding a missing comma.

I don't think this too warrants a re-roll, but this is something to
definitely fix incase you do re-roll for other reasons :)

>>
>>>       static int is_atom(const char *atom, const char *s, int slen)
>>>       {
>>>     + 	int alen = strlen(atom);
>>>      @@ builtin/cat-file.c: static int expand_atom(struct strbuf *sb, const char *atom, int len,
>>>       		       struct expand_data *data)
>>>       {
>>>     @@ builtin/cat-file.c: static int expand_atom(struct strbuf *sb, const char *atom,
>>>      -			if (is_atom(remote_object_info_atoms[i], atom, len))
>>>      +		size_t i;
>>>      +		for (i = 0; i < data->remote_allowed_atoms.nr; i++)
>>>     -+			if (is_atom(data->remote_allowed_atoms.items[i].string, atom, len))
>>>     ++			if (is_atom(data->remote_allowed_atoms.items[i].string,
>>>     ++				    atom, len))
>>>       				break;
>>>      -
>>>      -		/*
>>>
>>> ---
>>> base-commit: 44de1520f08d1dfebc3ab2d9f644208eaa5ac925
>>
>> I reviewed v18 last, but the diff here looks good to me. Thanks!
>
> [1]: https://lore.kernel.org/git/xmqqcxwonnkx.fsf@gitster.g/
>
> Thanks,
> Pablo

--00000000000019085c0657356a7b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 6ba6eedf81c4774c_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1wZzdBNFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meUtNQy85NjVRNWZ4NjgzVCs1VmZIQ3I2K1dBeE5YNwp4dGxnYWx5RExm
N1VJcm5yYldqcjRYVjQwY1VJa0FYMUlFZjc0azlrTVhqZUtuSk0xTzE2T0U1bTllSzVYOFF6Clg0
b3RLK3dTWFpGS05QN3ZHWXBZMFRKUzVVOEVFRSsrNnQwWWZNdXpNR3VvdW9nSzFPZkpDVVM5Tjl3
TG42Q2cKODkvWSt5dERqaDlQS1RwdGVTR3dnVmx1Tm50emJzU2ZSZlZFc2t6LzdmdzlWZTZ6cVU2
bzBPa2o1WG0zMDg1YQpHd0M3Nkc1bTYzQ2tacVNmZ1NZcUJKZk1CVlM5NlB4cjl2SVlOankrZENP
Z280L1h4RE8ySGZlRC9QQXRZR3BUCi81cC9jR0o0dG4xam9ORTVEdHZTcFVlanFGQXhYNTM1TXpF
RHN5RjUwVDBhRXFFcHpLNDM5VmFPRS9qT2hDSVQKcVRwQ2dIWmJOVS90aXVFVUVqVjlmeVJqVzZl
R1pWYy8yNlZvTnNSMWFlQmZHOXdYbWRLcGo2ZHRCUTZ6VnNmdApVL1lic0xEcU1UQU5COVc2MFNI
MzRCMmFLT1BWMnRLTytKSGZPNHErOEZ5MC9hcUlxOFpGb3NHVUIrSldYV3ZGCklNVlNuSW16STd0
S0RLS3hSWGdidm1uN04rbFB3OGJCOGZON25Scz0KPTJUQ2wKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000019085c0657356a7b--
