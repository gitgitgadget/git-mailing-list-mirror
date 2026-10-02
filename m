Received: from mail-vs2-f38.google.com (mail-vs2-f38.google.com [74.125.227.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DF528690
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 00:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790900174; cv=pass; b=UdW7Rs80ZbeRhDEc9NIw7l/PaFvRpnj+qdWtxRaiC7d+cpFRS2w8Ye7ASIMhtV7mEwhLlyBQesQEfGeYVA4YuUyV4JNjxh6WqEmpzMVv1rbTaC41xyX4DrhWgHSQbwNRYs/gVqEJdzTyeq8ofPuSm7YY5Qtbhn1lfYNzEDWmFwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790900174; c=relaxed/simple;
	bh=f8fsCNlXgah/Egwe2QI4kNf9YVhjl4nGvw8ABo38a0k=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wg5tCeeBca5r4w4hD4qGHeh5t5j/RbxlRftlVJKo3oRtIgjDNxI5ueV3/+0vAcPz9bLFW6jQuL1PDu0j6InruB6Dt8KzXB/1O2lnNDEsOeNNI50Rld4qN/itRCOQqn8tSPeEAevcOaAsPbA6o58inWB0+uas/B3W8cKbrIXOR/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ASQXV8Qs; arc=pass smtp.client-ip=74.125.227.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ASQXV8Qs"
Received: by mail-vs2-f38.google.com with SMTP id 71dfb90a1353d-5d9004047fcso819478e0c.2
        for <git@vger.kernel.org>; Thu, 01 Oct 2026 17:16:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790900171; cv=none;
        d=google.com; s=arc-20260327;
        b=K/WLxyYeRiSWmqkLa+u1RY6Z2s+pImW3px51l3U0j0FxkHtKJxl3beCTapI3EfBBYb
         QJfEcmi6ghFnHxH+36WVyxLWVAh5eNMwBzGuPPdX8kP7GHTbCKAzqiUjYNI49YtF4+gF
         s3y+UcdUobMEGG5o0KwBzkjSHFZabVISa1++hE9W67JZWBBOXttbDqyonksm+zz8eqXi
         ej7dKRy6WXIdxiKUjyDWGbn1E4J7oq8sps9FqwqyDpwNwjqqDGh22SYGC3AVxjxp+Xn6
         Bcxj/oEjnVS5/RV9g0CKKJS2xiNzoYmVaVpNt+j7JvPhtR2zLyTtHNTzKc64i+O4Mn3f
         f91w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=OA5QlLu2O2KTXWml/o9nR49nhw3L5wQORH6TBmCY1Tw=;
        fh=dbEecSNF2uoqlsSzrD8u3vhIKaeO9fCzfRavZrqtvcQ=;
        b=YXY8LnSUrEn+K2MN/j6zHhWZx7JfPFnvEKeq1lV4bEb+7WQgw+J2YybWTnncr64hPU
         /XI74S5XirAkzwnEMAv2ehg49cMJHlUsLAhigvhnnO0EFJIGywaCxPloRbSB3K2Dird/
         2IDN5TUHp18frAskaOyc9uvESQk1zArGNTNmWZ6OMOkYUtubMTGnEFs9nVRvo4FXXMxa
         2C7auIsRJ4/JlJ7wD8U74kBXJ4OEKvRsuIvfA3MHGOUnJwvblJUgyay6A4RG0piJ6Okv
         DipmrXIE7jAje/IV37WQaD6CDJxrU28NmmVGnTrvr6IIDfN0FAbD58H+48ufaVRhA0gP
         Hduw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790900171; x=1791504971; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OA5QlLu2O2KTXWml/o9nR49nhw3L5wQORH6TBmCY1Tw=;
        b=ASQXV8QsI0tSstHr2oR8+PA6KyJMPbW8dHYYT7uH8msA2yyZuaUEBlRLwgPkBKSD+Y
         Ax1mzNBSfyH75FGBgYc9fFl9kNp+IpAb8UPqas/R96E9n67YNea0IhNDBCtPZ7Nf/Vwv
         8d3/vEnjXqwxclhsCIyjF561y/V8Xa6aYbPgcLL0JhlolDMWgA7jSEcjcoLP4oDLGB7f
         ErbtlZ0Iy9m4VpZwcDJdjdbkrROgwtEKkf9d2EC/98LL4CUCJ9ij8/YN9bcxQXTjQaYO
         R3d1OwOMvan/NkP+4O2dTukZP5KAmnVQScCTykmwq4ZCkCaK9dAahNrTwnTLvvjDbyOL
         VC9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790900171; x=1791504971;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OA5QlLu2O2KTXWml/o9nR49nhw3L5wQORH6TBmCY1Tw=;
        b=fulobiHJgalKzbRcJIAoieEBX/1fMx/DQ4ArmbMz64D6vCJko7tmXZoZ8ZlxBD5SCM
         KtQblD7oMLIjshu6bhEI28BdSBFFunxp0VUToIgHGpK1vMImbaca/doXCcWMLMxO9Ygn
         l7/2Wsw5g1eU8NvXlyAkp4JyyEHlnw5eqiwpkI0uRqk38uXH9t5KAggjR1qBlaIV/0Wj
         ggOw3I7ef34rfyKthAMwhNu4yqVOZB0jN88SjQ77dNgMU/Agp4hmngVK2yDYNHqDEWMw
         7zb6bjgGmZmBjMefTFTKEjf2Uedz5l48uXG2LtG68oIWHpTQd87eiq1gyioi557V8OU5
         wbvg==
X-Forwarded-Encrypted: i=1; AKwUvBwibknGoRDgj4JPT6V4DwLm5oLep9bp6Fkck0TYsvGbSk6jy/veNjnz2/P5I5nl+E5S4fU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ02oUHK73GGgdvsuykaynHSy98xGaMruK4YlvsHcw9uY3OpIx6
	2RW7zVVpgSmH79VskBDf+bIg5/QD4R7Ei+kYI+lfoBDE5xvMf7v9MLyzs6cYCfSvSQSe+Ht4l36
	wlMjwa2OrhjO5QqA6QawUEp8S57mEdMkVCw==
X-Gm-Gg: AYBFou3dMIbBQlcSC7btm19Ma16z07AfYyCTsQF8lbNUxtXfjTp7MneGmv7fwkSTvL6
	OtlKLFYitplrf6TM9sZhuX6ItCw1GgZ4QMhpEY7eIzAcmMPYOurrQ60Tno3Oqzn3nbp57mFTevY
	Xo2LYRmZATVj6BPOls7d/lnxhQMEJ9nF2Ki657r9/yigFv48gZ3KWsQMoDWPYMtghvyxYEIwOc5
	AQZXhyqFmM6bT4pymnYBs+JYWVRFS3SOVntvyF2CSmVfnBU+gkVMZGEWyt1Qa9RfFLFa5xSH7sd
	hjWlIDDlweO7eCd7//CcExQkK8hRd9fKUh+HbW9T+2pyuvSZv1fHKod6mUQWhHyoUypLIegXTRz
	w84O27qbxB03EI5aaF76tBEch6o04SF0We6wG0p7R/iqzLhsiuKnJ8IOk
X-Received: by 2002:a05:6102:3e82:b0:7b2:7aac:8ccf with SMTP id
 ada2fe7eead31-7c0f50a3f17mr364004137.29.1790900170901; Thu, 01 Oct 2026
 17:16:10 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 1 Oct 2026 17:16:09 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 1 Oct 2026 17:16:09 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <87y0ch5fkv.fsf@dev.null.iotcl.com.invalid>
References: <20260930-kn-speedup-packed-refs-v1-1-111cd03d9b0e@gmail.com> <87y0ch5fkv.fsf@dev.null.iotcl.com.invalid>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 1 Oct 2026 17:16:09 -0700
X-Gm-Features: AclHuK8nZVzyd0-64XGM9RszmfW63zYUfDLHaHykUSmyIaarvz1bQfmJ82B84qE
Message-ID: <CAOLa=ZRTtE+FMrVZBwSmZ-aVBXFphnQB414-PASCAAXJJCgNww@mail.gmail.com>
Subject: Re: [PATCH] packed-refs: use `fwrite()` when passing refs verbatim
To: Toon Claes <toon@iotcl.com>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Content-Type: multipart/mixed; boundary="00000000000083e92a065cd07073"

--00000000000083e92a065cd07073
Content-Type: text/plain; charset="UTF-8"

Toon Claes <toon@iotcl.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> The `write_with_updates()` function uses a `struct ref_iterator` to
>> iterate over all refs to write to the temporary packfile. It receives
>
> I would say in general "packfile" is only used for objects, but it seems
> there is one mention of "packfile" in this file, so I'm not sure.
>

You're right, I will change both of those to say 'packed-refs'.

>> the iterator from `packed_ref_iterator_begin()` which takes a snapshot
>> of the 'packed-refs' file.
>>
>> While writing to the new packfile, writes are routed via
>> `write_packed_entry()` which uses `fprintf()`. Even for references which
>> haven't changed, we use the same mechanism. Instead, let's track the
>> position of unchanged references in the snapshot iterator and directly
>> use `fwrite()`.
>
> There are a few sanitizations that get lost by using fwrite():
>
> * oid_to_hex() is no longer called, so if an OID would be written in the
>   old packed-ref as uppercase, it would be copied as such
>
> * next_record() uses isspace(3) to split the oid from the refname. If
>   the record would be separated by a tab instead of a space, that would
>   be copied over.
>
> * next_record() calls check_refname_format(), if it ain't good, oidclr()
>   is called. Before this patch, that means the zero OID will be written
>   for such ref. That changes with this patch, and the original OID is
>   written if refname_is_safe() passes.
>   This won't make a difference in Git though, because upon reading back
>   from the packed-refs, the zero OID is read into memory anyway, so
>   there is no observable difference.
>
> * similar to the item above, when the ref is peelable, and REF_ISBROKEN
>   (around line 985), the `peeled_oid` is not filled in. This means for a
>   refname not matching the format will not contain a peeled OID for that
>   ref.
>   For example, in the source file:
>
>     1937b04ead6e53d949a4e2eb97ed743b42692fde refs/tags/a-bad~tag
>     ^67c1263aae5c1750e9d9211995e6d1bb38314fca
>
>   is converted to:
>
>     0000000000000000000000000000000000000000 refs/tags/a-bad~tag
>
>   After this patch, the ref and it's peeled commit OID is copied
>   verbatim.
>
> I'm not saying any of this is bad. These are just some side-effects of
> your fwrite() approach. And some might be worht mentioning in the commit
> message.
>

While you're right, sanitation is not part of this flow, here we're
simply deleting a reference from the packed-refs file, the fact that
sanitation was even happening was a side-effect.

But I will mention it in the commit message, I think that makes sense.

[snip]

>>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>>  refs/packed-backend.c | 43 ++++++++++++++++++++++++++++++++-----------
>>  1 file changed, 32 insertions(+), 11 deletions(-)
>>
>> diff --git a/refs/packed-backend.c b/refs/packed-backend.c
>> index a73fc6aca7..ef952cdba6 100644
>> --- a/refs/packed-backend.c
>> +++ b/refs/packed-backend.c
>> @@ -879,6 +879,12 @@ struct packed_ref_iterator {
>>  	/* The current position in the snapshot's buffer: */
>>  	const char *pos;
>>
>> +	/*
>> +	 * Start of the current record, set when advancing `pos`. Used to
>> +	 * pass records verbatim to `fwrite()`.
>
> I assume there was a version you've been working on that was calling
> fwrite() directly from ref_transaction_error write_with_updates()? With
> that being wrapped by a helper function, I think it's better to name
> that function here.
>

I'm not sure I follow what you mean here.

>> +	 */
>> +	const char *record_start;
>> +
>>  	/* The end of the part of the buffer that will be iterated over: */
>>  	const char *eof;
>>
>> @@ -933,6 +939,7 @@ static int next_record(struct packed_ref_iterator *iter)
>>  	if (iter->pos == iter->eof)
>>  		return ITER_DONE;
>>
>> +	iter->record_start = iter->pos;
>>  	iter->base.ref.flags = REF_ISPACKED;
>>  	p = iter->pos;
>>
>> @@ -1218,17 +1225,27 @@ static struct ref_iterator *packed_ref_iterator_begin(
>>
>>  /*
>>   * Write an entry to the packed-refs file for the specified refname.
>> - * If peeled is non-NULL, write it as the entry's peeled value. On
>> - * error, return a nonzero value and leave errno set at the value left
>> - * by the failing call to `fprintf()`.
>> + *
>> + * If the raw data is available, skip the formatting and directly write to
>> + * the file using `fwrite()`. e.g. when deleting references and remaining
>> + * refs need to be written verbatim. Otherwise, use `fprintf()`.
>> + *
>> + * If peeled is non-NULL, write it as the entry's peeled value.
>> + *
>> + * On error, return a nonzero value and leave errno set at the value left
>> + * by the failing call to `fwrite()` or `fprintf()`.
>>   */
>> -static int write_packed_entry(FILE *fh, const char *refname,
>> -			      const struct object_id *oid,
>> +static int write_packed_entry(FILE *fh, const char *raw, size_t raw_len,
>> +			      const char *refname, const struct object_id *oid,
>>  			      const struct object_id *peeled)
>
> I'm not convinced it's worth to have both ways of writing in a single
> function.
>
> I rather keep this function as-is and add a function:
>
>     static int write_packed_entry_preformatted(FILE *fh,
>                                                const char *line,
>                                                size_t line_len)
>     {
>     	if (fwrite(raw, raw_len, 1, fh) != 1)
>     			return -1;
>     	return 0;
>     }
>
> Or maybe even:
>
>     static int write_packed_entry_from_iter(FILE *fh,
>                                             struct packed_ref_iterator *packed_iter)
>     {
>     	size_t ret = fwrite(packed_iter->record_start,
>                             packed_iter->pos - packed_iter->record_start,
>                             1, fh);
>         if (ret != 1)
>     			return -1;
>     	return 0;
>     }
>

I did it cause it was small enough, but I don't have strong opinions. So
let's add another function, perhaps:

static int write_packed_entry_raw(FILE *fh, const char *entry, size_t len)
{
	if (fwrite(entry, len, 1, fh) != 1)
		return -1;

	return 0;
}

[snip]

>> +			return -1;
>> +	} else if (fprintf(fh, "%s %s\n", oid_to_hex(oid), refname) < 0 ||
>> +		   (peeled && fprintf(fh, "^%s\n", oid_to_hex(peeled)) < 0)) {
>
> For what's it's worth, I think it's really ugly to do this in a single
> if() statement, but that just could be me.


I agree, but I don't want to change existing code in this patch as that
would simply be a distraction from the purpose.

[snip]

>
> --
> Laters,
> Toon

Thanks for the review.

--00000000000083e92a065cd07073
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: c83fb639411fde82_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xKzk4TVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNUZQQy80d2ZGNjV4WHlxZWp4MTJyN3ZPNGtwZk5VTwpuQkdnVjh2eEpR
QnB6UFhUTC9Yei8yaU5TWjIzK21Fc21CVGdURTNwSWswUzZXSFFraUMvclFrRGhId2pHOHJkCnJ4
S3ZUMHZ0cWZUQjlvZmxNOTh3RW55S05IMmV1blROTmhHYjVad0hEUnpLMGlOOTE0OGZHdVdQODdi
L3dXUVMKYUxnMUxna3ZRVnhadUN6TytBTkZNMVFhbXdYQ1RLeW1Qa1RHMzdnN29GajhTWWZPdXcz
NzRjVFd6ejBJYVdXRwpmSDlyb2RhcmMrUEo2U1IyTnV3cDJSdFMwK3BZcWwzK0JBNURPRTR1eEkx
eWo3MFBXMkJURDZxTjNsUWp5YWFECkJCTlFqdGVtWHIvcGxtTHFWaU5OSzRDc1ZPYVFtVzM3NXd6
eDhpQlJUaXZmZytaeUFaaHZwVjJJZmp5cTVBanQKa0tTSXpSY0duNFMvRERpR252Rk9tY2FZcW85
RzdvM3M1SVdOdnN2ZEQ3Mi9yU2Fkc2RDVksyVlBWWUFrVW9vYgpHZCtWSTY3SUw3T29jeDlzdmlq
L3grSWNFeWxXQzVndStUcjQrQ2FnRGcrRDZiWWliaG9SOGpYdTFPb1J6eGNICk9VTG5rNUZTQjlM
emdFN2kxeUdBN2VrblFRL3YybnVtTThKYTkzbz0KPVJZZlEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000083e92a065cd07073--
