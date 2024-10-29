Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9982204035
	for <git@vger.kernel.org>; Tue, 29 Oct 2024 11:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730202524; cv=none; b=Vzhxdw/jUCcdGDuZzL5/YozE5czixWOD5fOjO/kInR+6+Ix4MPh2CkQK3s2vNI1hRsRESl9FzQVl0ihgy24Gu3KCU8ZjJvycbH3jahfOSNtHTNyErswY38clrDq7yZDRH1VXQjKRt28aiv0h6Y0Ic0kJCzJ0QcDJC8Dw8jks/qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730202524; c=relaxed/simple;
	bh=kKlzTgzDMTGma55/QVqLuUqEyACNVYahO//Ynsj9InU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PeM4spFtyeNtbjYPGZ6KAE7ewDugwvqJYZ8ZIUEjh2gPkzpjClpMcxDodJMaa9pEvG51D29KDCIhHaFyGZy71gVnQ2vxIu6qE6kFhGSB3sLhHkniE8pzXLfOUm6eCRAb1yaNxAUzcSQp5etyeac701cv10Nhi45A+9xDIIgm9rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JXBQPLzF; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JXBQPLzF"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-4a742ea907fso1458409137.0
        for <git@vger.kernel.org>; Tue, 29 Oct 2024 04:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730202521; x=1730807321; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=AEQJ5X0ycqOBjso115b1mfjWBv2vV94dpjNbKqHAi5A=;
        b=JXBQPLzFVegsDvlgLbh9dgsYIRwapcGYdIfhuHc3xkpovJ4B93vDSnm3gPlmvcGzcz
         lAjfhsuLQT8bkNzhcuditEUNaR1/U8spT1RdCFJ4ZWdlynN1H8q429tJnUF6YEz2bKYE
         xXkOp88jBNpx99iq6dt89MtmUiifC6gGUqGBfTcLPqAgbWfebLCVeLUnmoHwtP1zMRob
         CCiAhnItkGbelozq1ZhmpJj1KuYk4uQtMwGZeti9BZhemcAAajeuaVJ1GFYM1gIQX3dW
         0hH6Su/vYl/tieBAZqqcZtjEtC1raCXWyTS9wiqXIJA5MtMu86PXbqQN6YIa/BPrvWh7
         YJnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730202521; x=1730807321;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AEQJ5X0ycqOBjso115b1mfjWBv2vV94dpjNbKqHAi5A=;
        b=Zxbu2dKB+y+IaKQtlJVxrrZBd6ZMk6olYI01XbyiJzYpvS4OyEpHGZ8v5VuZuH7A8A
         XeZyIUNVLhM12xK/XQt5wUSFckxb5celU0lSY7pjFFw8B7a9A/RRzcEt53ajKA7Gknur
         0ZICIAuGl6mXpHNAHM/6O+DeMvOXBXCRLyGOD8WLWze9GdX096lyBFS1vauTAopgjwn+
         +v9TPxs0tH5Nr6jzDRwIXNP8sGnqmpOJK3QZ+Kgb9tDveu2NQYYuEVHlzDqvO3H0KdEw
         6/WtEecCLEASeF7/W4ZB14UI/zadGyfY/242qI9s5j+81yTQZYWYWHdt6BRUrwU7CngY
         TMNQ==
X-Gm-Message-State: AOJu0YxsfzGvRqr5p385NP/ab5pJ1fyMYQ+zKFS1BnueRFEtBLAAmxbi
	67E2iPPUzO0SllXFAO+NIHemGOlDwnAd7syUZ2UdHm/jm+6DigUxQTIuzOaMR+ax8Z77kKeYH2t
	FLMOVHOjiYtfiA3mbRxEubDosHiLWdWmK
X-Google-Smtp-Source: AGHT+IFShnHrK2rzY+ajr4OcuKNLgKvt5dIYIpl1ovPmHuptz0e1EhrcLHTuoRcbO83TwlBZ0obYbJoFzqBGpUxx+1Y=
X-Received: by 2002:a05:6102:3711:b0:4a7:4829:8cb0 with SMTP id
 ada2fe7eead31-4a8cfb38e61mr9793933137.3.1730202521531; Tue, 29 Oct 2024
 04:48:41 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 29 Oct 2024 06:48:40 -0500
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <Zx+3FZNzwe6V159m@nand.local>
References: <cover.1730122499.git.karthik.188@gmail.com> <ca033556866cbb6cdff49507eb27ed5ef57cf44f.1730122499.git.karthik.188@gmail.com>
 <Zx+3FZNzwe6V159m@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 29 Oct 2024 06:48:40 -0500
Message-ID: <CAOLa=ZS0A6sWciy3r8BbZcgVyzU2cdaG7S7JX4XwOQZbWcGwmQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] packfile: use `repository` from `packed_git` directly
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000afa88606259c2abc"

--000000000000afa88606259c2abc
Content-Type: text/plain; charset="UTF-8"

Taylor Blau <me@ttaylorr.com> writes:

> On Mon, Oct 28, 2024 at 02:43:40PM +0100, Karthik Nayak wrote:
>> In the previous commit, we introduced the `repository` structure inside
>> `packed_git`. This provides an alternative route instead of using the
>> global `the_repository` variable. Let's modify `packfile.c` now to use
>> this field wherever possible instead of relying on the global state.
>> There are still a few instances of `the_repository` usage in the file,
>> where there is no struct `packed_git` locally available, which will be
>> fixed in the following commits.
>>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>>  packfile.c | 50 +++++++++++++++++++++++++++-----------------------
>>  1 file changed, 27 insertions(+), 23 deletions(-)
>
> Very nice, and indeed much less disruptive than the RFC version of these
> patches. All of the first few transformations look correct to me.
>
>> @@ -751,9 +752,13 @@ struct packed_git *add_packed_git(struct repository *repo, const char *path,
>>  	p->pack_size = st.st_size;
>>  	p->pack_local = local;
>>  	p->mtime = st.st_mtime;
>> -	if (path_len < the_hash_algo->hexsz ||
>> -	    get_hash_hex(path + path_len - the_hash_algo->hexsz, p->hash))
>> -		hashclr(p->hash, the_repository->hash_algo);
>> +	if (path_len < repo->hash_algo->hexsz ||
>> +	    get_oid_hex_algop(path + path_len - repo->hash_algo->hexsz, &oid,
>> +			      repo->hash_algo))
>> +		hashclr(p->hash, repo->hash_algo);
>> +	else
>> +		memcpy(p->hash, oid.hash, repo->hash_algo->rawsz);
>
> This should be:
>
>     hashcpy(p->hash, oid.hash, repo->hash_algo);
>
> instead of a bare memcpy().
>

Indeed, didn't know of the function, will change.

> Everything else is looking good.
>
> Thanks,
> Taylor

--000000000000afa88606259c2abc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 32dc604c0678ddcd_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jZ3k1VVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNWdlQy93SkZSaDdNMjJ4eS9yRTZEVWE4QjhlQUNuWgpLRndobDhxdmFH
UjJuSjFRWXR1ZjVuaE1mUjdBSUhqQWlwcnRROHI4Tjh6Nk5SZDAwcDdhMTNDWDlmNzBDUlkyCllp
Nm52aTBiYnAyVVFqeEUrSkFEd2dpZEh2T2E5bjFUL3lVQndEQ2t6aGt0UVQ0Q21GSGhndDB0dGds
YmcxRCsKNU4ybXdjWW1iVE1vbTVKSnBMSElPZWZLWE9UWFpiendaWlZsb05UMWZjZ1NjSWpSTlJ3
WFBMQUdicUp5cmxaNwpmbjc4dTRUbnBZbWFsdHFZR2x4THdwYlhYYTNaSEwxbjFjMkhTT1NNUFpZ
bHZieHV2K1AzWW5naUZxWFdjcEpTClJRekhBVUM0Y2ZlT3RCZE5tZlZaNncxd2ZFQ20yRjAwL3lO
ZEh3a1dXejZrd3JaTW1XZkthOUpFQ2ZkcU94ZTkKcldLeGtkdHo2SGtzanZrdHowaElERklGaW04
OHE2SzlyNkhNaVFSNllRQnhCWjZWc0lyN2Ixck90RlNuNFFPNgpuYjNBdTcyclAxTW5RckFmcTNs
U2c1YjBqczU5dENTSEtKaXhvakJnZDJPTEl2L1FIUGdMVGh0WnByNkdjSUx6CnpMdFhQUmdJSm5L
M3BxcC9OTjVLaURBa2ZuVUozVkx5TGdxNzgrZz0KPW1odFoKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000afa88606259c2abc--
