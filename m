Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795433991;
	b=VExI4fOKZfOQblHyMAulviE5HtHAY5gnVPPW3F7rJSIwEkfAGBFkpQP4/HIv1JPJ8ZYH
	 vbkjpiCi6eLQiXK0CLIiEuOf/OxCaaN45eU7ldP7UrTJbOweJjebizGzZkXYiCzdc2smg
	 DCctb5jSz8Xp0MLtQvsLWY63bFy9bSk4asO6NvRQA9Jt4u3+J5m/Ay/5dJ6a0qnTZTGiH
	 mnlzvUKaVEA9Qa7tGOTAr2T+YvYunrsYjWuf6WLXhA6qt/d3yp1CWKEsrV7zgKvCsWyo6
	 9HVAH8nWcZwHXGgPfs+lZ6IPOkG0qnYe5JQn13Bt1oWgLFC4ZyaktVdFHnFVocd9wjg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795433991;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=psFn2/GPAVwjtO4Xtdo4NFJM2iXPLp00rrs/phISi0o=;
	b=2Jp5JArIHeMov+xIKR1o1NZjt+zAEp/U3W60iWPe6t2TXzkIeW7G4fuSpd7dCDXAnFL8
	 A4MVSSyMxzJekLAWMrcFzQS6DTQWBkQ2TjEiiPBG96n6Hlrro2R+NZ3F/xOKRiyQzzIlC
	 amzio6bWMhMmklhx9uD66JXLqZ3U4N6HRiorldulUNW/oHU6xmt1eQB7IIoQzzYrkGhw8
	 eUAl32NtoVDhrwX/8eR7ZRmMQyKLRXWFo2h5TKaZrbkn+NQBsZ1BNnbIjJEQownmK2paM
	 4Plk2WSiOvbF78DaVN1jvcolEObwtBIOZKI/hB1A8ypzmH9JsJs00h9PYSozYrjK6lw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DeO6lCCw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A845606A31E
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 11:39:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A845606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DeO6lCCw
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-15ea896ddc8so5321158c88.0
        for <git@vger.kernel.org>; Mon, 23 Nov 2026 03:39:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795433990; cv=none;
        d=google.com; s=arc-20260327;
        b=IDGQQHI6YbW49WG1Pqz3BSp1AZKenPQI6glIqF0WyvSCHS70tpJhr+SGkqieETmudl
         Mzk8GzwkmKlKZ5OBw85J5aef2n4tgkzgPn7psIS/g1uOMH9ND1H6J817aDZTRXq8vVl9
         egIw7PEVyyaZD4NOE0UVR85LYUvDBI+EJpe5/1CTmTTCRQYUcDrbalLOolWwPTXL5RLj
         FTvELDwZ/CeGobWYY5xKfmUilKxLqvGSXtPyMtIYER0UIHpfajd2xtzNl4PSRk44kG2N
         Ml6DZNpnTxZrvw2WYXXAYHjF/nyisxZ3lDfLwfJPWox52Zo43VKKyEvxS2XzkmHKrML1
         9lJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=psFn2/GPAVwjtO4Xtdo4NFJM2iXPLp00rrs/phISi0o=;
        fh=YgaRJzF75Ia0o7riQB7IkokiNn0XQS4TuWBxJ5rQKFw=;
        b=T4NKT074w6jgr/fMY0zXrZBsCQwkK+V3oG2fnwz8d8S+q7gXwJWUG8HkJkkI9AQPPP
         8607z/8qUv9wJ0LqdofdRKm+hGhl7IF5eZpftCtTOV8vNesGssSayETGzKwGbVRSRRcS
         IPdVr0NIums88HnwnLA6ywYI4Mj16AAWx/csYKbKwan1cPkfwuPKicXsSFwAOGXiuD8g
         gmWbGIjP89xhN9Pdz47m/aeUowtZJYSDk02qekeyP+5kybqWbn3Yaje8dpDxBLmHc969
         k/xA51A+H8R5kQ7q3bfsfVKz+B1Am5sUSnroP6VkIHOjWXCUUwW4Vlw2lC6P50Z8oFtk
         XKqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795433990; x=1796038790; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=psFn2/GPAVwjtO4Xtdo4NFJM2iXPLp00rrs/phISi0o=;
        b=DeO6lCCwxgWq0oJr0KqhBp0Mie7HfAPxjofXxq6B8/3aUslpF+Rfn/GKPkttBCyYU2
         gN8LSNlj/xrsG9yT/w0k7e28MxsANCfj4CqGpwLIVV94CgaAOZVKl+4ItKE8E+JfypOp
         A68vMHfDpFCCKyg+AYkPryGqMQ5UHT2ED7/jjeGlh3Uw1UnhHDyXwR6nYHLcoxRHdxnv
         U7tX5LWkyukosQ48ltGhZptuTQwnVnxUG/mZUcB7d/Vx5RFSWlGS+FlGfy2HduEotTg5
         tiaPvM7InvU07MDtw6mS8s7XCbnOuI0gqZ1JiLah0F/N2+RPltxY+VshU6Xzdu9x0fng
         PPzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795433990; x=1796038790;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=psFn2/GPAVwjtO4Xtdo4NFJM2iXPLp00rrs/phISi0o=;
        b=ySQAS+Ua4vKRR/KssZMjf5RE/6S+lH70/Eb2WMsUUcdMirwbZ2XQEBpSh472409blx
         Nnc6gIrWXBwmmWRNVQ6m6WHPBSez6Ikw/IlRHVOKS+K7mE6zHJ6MPmC2ohqyYXAReXTE
         fXCmsExaGB74XBqq06YqNG03PepwRXME+t1Wpq01tWX4dS6r61nhMqJGkUv8PUvlt2CB
         QaBy93fA73BEdb6zIk6getpFMyJa/OANOsMloq4UPSSUNk6wFwkqaUmRLaHGD24Lz9UT
         Yv0DFF9quEF0yy2UyqYoQ83OoboHvtRToBH3zGAivOI5ThYeWYX044kgusrJ9snDCrH6
         l4ig==
X-Gm-Message-State: APuU4Z/Yv6Y6a3Sio9sUihzKrXJ68/XWXF2297Ym9i6M5rpc+20qRLLk
	AsSzXTX/70AsdewEcCKkWC84MU7saxBW72UkjuKW74DdjiTW+VV+FqDNYpEj72341KbzRZ2V6M1
	r0GEb/Ay6xsOa+gF+KZJX7we/pNPLhzk=
X-Gm-Gg: AZFdTZfwM5qnYx7WOb0/J5A4FLSKqyJj8NFAMFYqMoqSPE9eF0nUq54ziFm1mKwJVqD
	E/cIibFlLl1Eyzb1B/wyU5AonzRhaAhMRpng6weZpZrT3C6me0dUugLIE9ZyI3CpwLRStz84quM
	GF7UJHh+cPSRujyI1SqW/o4oI4E3krl8cAuyBU8Fj0EX0Y7K2g/3RTH/PWeIlfji7jseDvAF5OI
	KQwT1OmzQ8fZprldt4DHOq8+GhZrzURR2xj+sUd7nzFjza3zUVJEbN5pjsIVNjCVrKwu2zB7PQR
	C5YoBlM6ol4wLX0WtLhfJfB6bSDZMqieXUMptPBhOd51AfYPd/cQKIFXtWi8SFHz4x2+yKR4PVf
	vOiYNeDyukHIATY/azzl08a6rCq5B8c7pTYCjwSX8wCwYaWex81D830dAxXex4cFi4fdm20gd5n
	Lg9Vt+1/0jQtGQbjw0miA1BqMNqvSP3SjaAkJjj/bBxiwNi+AygpbePud9IAejI89LnAGjqL6ni
	Im7fOX/AhN5P03XnMcZdIYqe4dNXZ9t8lV9fDDnyQvraQ==
X-Received: by 2002:a05:7023:a41:b0:1a3:87c8:7efc with SMTP id
 a92af1059eb24-1b5569026dcmr9801502c88.39.1795433989986; Mon, 23 Nov 2026
 03:39:49 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1793352943.git.gitter.spiros@gmail.com> <cover.1793439137.git.gitter.spiros@gmail.com>
 <4961a1824ad75b6cfa81ab89af650cfc440cff81.1793439137.git.gitter.spiros@gmail.com>
In-Reply-To: <4961a1824ad75b6cfa81ab89af650cfc440cff81.1793439137.git.gitter.spiros@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 23 Nov 2026 12:39:38 +0100
X-Gm-Features: Aa3M54rESV1qHdYwpbAmcV7jE2JbDHg-inPeau4Uindcou0wnunO_RoM-efjXYs
Message-ID: <CAP8UFD1JCP-5iWyxxTXqRWZpOXnRHcKfOPa0YHcP6y8z6o4x_g@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] odb: use size_t for the length of objects to write
To: Elia Pinto <gitter.spiros@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Jeff King <peff@peff.net>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 31, 2026 at 11:16=E2=80=AFAM Elia Pinto <gitter.spiros@gmail.co=
m> wrote:
>
> c6a4629e32 (odb: use size_t for object_info.sizep and the size APIs,
> 2026-06-15) widened the read side of the object database API, and the
> write_object() callback of odb_source already takes a size_t. But
> odb_write_object_ext(), odb_write_object() and odb_source_write_object()
> in front of it, as well as write_loose_object() behind it, still take
> an "unsigned long", which is only 32 bits wide on Windows.
>
> Most callers hand them a size_t from a strbuf or from odb_read_object(),
> which silently gets truncated. The most visible case is index_mem() and
> index_stream_convert_blob(): when "git add" or "git hash-object -w"
> runs a file over 4GiB through a conversion (core.autocrlf, which is on
> by default in Git for Windows, an eol or ident attribute, or a clean
> filter), we write a blob made of the first "size mod 2^32" bytes. The
> index records it with the stat data of the real file, so "git status"
> stays clean and nobody notices until the file is checked out again.
> "git hash-object" without "-w" uses hash_object_file(), which takes a
> size_t, so the two disagree on the object ID of the same file.
>
> Use size_t throughout, including for the size kept by the in-memory
> source.
>
> The existing "hash filtered files over 4GB correctly" test in t1007
> only hashes, so add a variant that writes the object with "git
> hash-object -w" and checks its object ID and that it exists. Like the
> other tests over 4GB, it needs EXPENSIVE and SIZE_T_IS_64BIT. Truncating
> the length to 32 bits in odb_write_object_ext(), as happens on Windows
> without this patch, makes it fail with a different object ID.
>
> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
> ---
>  odb.c                  |  2 +-
>  odb.h                  |  4 ++--
>  odb/source-inmemory.c  |  2 +-
>  odb/source-loose.c     |  2 +-
>  odb/source.h           |  2 +-
>  t/t1007-hash-object.sh | 11 +++++++++++
>  6 files changed, 17 insertions(+), 6 deletions(-)

This patch is very similar to the following patch that I implemented
independently:

https://lore.kernel.org/git/20261117174353.1158905-7-christian.couder@gmail=
.com/

The changes in the *.c files are the same. The commit message is
arguably better here (as it describes the bugs that are fixed better).
And contrary to my patch, this patch adds a test which is good.

[...]

> diff --git a/t/t1007-hash-object.sh b/t/t1007-hash-object.sh
> index 463b38f990..e76557981d 100755
> --- a/t/t1007-hash-object.sh
> +++ b/t/t1007-hash-object.sh
> @@ -297,4 +297,15 @@ test_expect_success EXPENSIVE,SIZE_T_IS_64BIT \
>         test_cmp expect actual
>  '
>
> +test_expect_success EXPENSIVE,SIZE_T_IS_64BIT \
> +               'write filtered files over 4GB correctly' '
> +       { test -f big || test-tool genzeros $((5*1024*1024*1024)) >big; }=
 &&
> +       test_oid large5GB >expect &&
> +       test_config filter.null-filter.clean "cat" &&
> +       echo "big filter=3Dnull-filter" >.gitattributes &&
> +       git hash-object -w -- big >actual &&
> +       test_cmp expect actual &&
> +       git cat-file -e "$(cat actual)"
> +'

It would be nice if all the tests in this test script would clean a
little more after themselves, especially EXPENSIVE tests, so that the
state of the repo doesn't depend on whether GIT_TEST_LONG is set or
not. But the risk here is very low (the ".gitattributes" change only
affects the "big" file), and this is the last test, and other tests
before don't do it. So it could be done in a separate cleanup series.
