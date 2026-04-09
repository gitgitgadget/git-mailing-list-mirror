Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B97439E176
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 09:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775727606; cv=pass; b=LpVzQEmlO48BsfoqkdjouBJgFj0WY2IJVESaSQMPtnInw3lpJlzXAeXzJ+kBuzIqhWzmNF6mrwSnuLBP+o4pOQR7LPVCuz6UUqfM5xwpSSOuuR4gb7WiP4XsZwnBE53IHTkS6vFK5D7mNxa6KfSTfEbmPR66gmBcAqckUdIc9Rc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775727606; c=relaxed/simple;
	bh=kM82dPlaCfoqVZbw/ry/9xZ4JA4n2imaQzebs9k8kXc=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=owrUu3bsi7dWZXGX++TPBneuAdBMRkgpGtsYahdNjy9EVelcm6N1EwqWt8C+sX3fno3mMcpKSwiNVJuLyrkGklA8e1uQaBeVQQxKohB94fsDvuwCT/DRqlNZXrDJ9Rzt6dJXlHI5A/KNVAk9YYTtAlRN/Du4VmOP+X84i+4J7Hs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Au0d8OL7; arc=pass smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Au0d8OL7"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-953acf7ae20so374570241.0
        for <git@vger.kernel.org>; Thu, 09 Apr 2026 02:40:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775727602; cv=none;
        d=google.com; s=arc-20240605;
        b=kYE1KnVCUI97Z8l4MYH9RzGajCOiPfJ9hF0EyPVlMer41Bc7zT/jjKMvA60aEify7v
         PieB9daciGCjToNbB/y+2TQ7vcjUCE11pldkiI3tqeGcfln0xOypxuYkUFIRBjPA+/6o
         3dCplSStuWxkos9lG1BuRghrmLpKAi4K2bd6UuKsBVo6TAzV2cxjsZn/uOXHSjCULFkf
         aFaUNbRGV0o7mOgl7CHEilnRshE4nEBjvwR1i5RpsD9FBZsvFw9QkeSPGl8jFuLU70L4
         vieGDJTUdzWEaR5kzEFJDF+FZd1Z/XJh9ZNKmono8wfE1yVQB89Uab0n9cFhFP4DVgyy
         cWtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=1zQWV8IA/2pon2HgvW52KmC6/7ZRp448Ti07T/pxbsw=;
        fh=ervua8mI2R0rEBVc6o4a8RxIghhGv+AXqtqG92z6iPs=;
        b=ghH28/tfd+1buzE7rq9B5fGyOyamUGtlV6+7g4IZGoFMM2GzoVYK0xnRUwsqIOPDMi
         0YM6YjIQ/d5cHYPq5J4qwaC26t+JuZ0ws4A6adEc4DM06LxzZWrrJ8/OZKa7O1Yk6/vF
         g/jzuPTAw2p1DezN/UG4CBgaaMHU8mr5ZgIf0E26HcI9S2K+5U6NBsYiJr4mr0CGIU3K
         H94S8QBYIRPo5Yzk0KdqS4MitOaO5KSAOenk0NCmArsOm8Ua2ccm3D6lMkpiyrzqvG6B
         nfZEmxmviBJ3KyxYcBWOov6sWU2olV5q+EwAuXMNV8eTK+HvB3OKtv/Jz5WOwNYEoNF7
         YhvQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775727602; x=1776332402; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1zQWV8IA/2pon2HgvW52KmC6/7ZRp448Ti07T/pxbsw=;
        b=Au0d8OL7ihHtUFv6LhbyAXyzsFUVSlsmt8Ve3Oou7e0SesVwx8YwkM+DPSmj1pdNKd
         17vKeFU4dHVP8PUL43rCi7RzrQ9P1nTzHPfdxBETW+CHBSkeJ9lWEwYyAgXsi/95jEs8
         ZgwV+RdZVXNttXyqgqxkPH0zh1fvqrCKv6QdaY6OV/Nmys9f1e3y26CCJFQy1mSzh/Ev
         y4KpEd0xILcmeyW+Aujv/RvLODijQK5O5FRwMPvyoGeRl7qDuCkvmxPo0Vr+/rx5aBwN
         +T6dYiSPzizHJXkRZUIGBHz/SWEuQbOufosN+giYuEiw6/rJ+Yqus6R2kG6r2NAAMgWb
         +qig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775727602; x=1776332402;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1zQWV8IA/2pon2HgvW52KmC6/7ZRp448Ti07T/pxbsw=;
        b=gPSQ5J73gsEwIikz3U8WasGSmEj3pc4G2hTsifWdfxEW0JCHRY5J4meiZeRHYLDv8Z
         h29yT+loopwfbqP1gMd8zX22roQQkfbYS8p6pVLK3L61t/f6t2od7yY4Vvw4qJxJlIhg
         N0bwQcmSj/nx2vw3Z50DU1vDnc1oj4bHHyNw1N4sx2NaFYX30B91A5boB19T+9HMK7zE
         aG4QIHXtlxXTc4GWJE9Gwgf5j+aXZ2R86Vt8MhR+mOack9iWiamRqZPI08U5/aKxdrRj
         Mn9DK4XqOZrniQ7XTz3YJFLXaUVZiZ3u/lS7W59ooJPgqLoLA7NUnvVa4fqYWlHrccKr
         rppQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNNHN+zOZXb4zGjyTa+sSd6hUYxC4nPncvyhIvhmJbne+ddf7YUO9f91rLLLjn3aU4I38=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmjZXhKo/9xjiIOr+W8aPIZgYor/zH92YQtOe8j4G4QP6aUDpn
	8TNpyXhPXEbyYsxXVjEf+dw7HTC33mkX/JLYtxsz4GueWa+hJGJSAdOIc8vbGbrtZoPqUT0GWLs
	9s7O4WneeD9eyyE7NKWX8vkyScOCm5cY=
X-Gm-Gg: AeBDietqdAOUL8KvCPcFXsfRYw7PsaeBE9+oJShBlPrr5/2Yk1az5AbYfJW9IkZWLNi
	3q5IZkR4DXFaMXREZassax1elxGyxusO7C2MwzxMhUgp6iZe+cbHDpisKZ2SNjvPzlMUO8sarr5
	/wkttbt7lcST49xQQgUSo31x1+rW0geesejUBzl6z53+836Qgu2jXR6yN5J9vWTFLxS3PvxGkdW
	ihImJ5CJZpVzobKig5uYnl2K8axl+fH4Axo2m/RQAx1i/40lmEWUv5rhaMskHpzoXL+v/uvA0+a
	dLvkZn7pIIkrYDz2u+sTQ9M+4xEihsnWt3zmTv5NEgdyQgPOdEg=
X-Received: by 2002:a05:6102:e10:b0:5ff:11dc:2ed7 with SMTP id
 ada2fe7eead31-608706c31cfmr909918137.16.1775727602151; Thu, 09 Apr 2026
 02:40:02 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 9 Apr 2026 05:40:01 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 9 Apr 2026 05:40:01 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260409-b4-pks-odb-source-inmemory-v2-4-f02b4f1c0f13@pks.im>
References: <20260409-b4-pks-odb-source-inmemory-v2-0-f02b4f1c0f13@pks.im> <20260409-b4-pks-odb-source-inmemory-v2-4-f02b4f1c0f13@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 9 Apr 2026 05:40:01 -0400
X-Gm-Features: AQROBzBLFOBjjDiXmAmhzfPIyuePa49bLaaJ3yROSgAD0r_WG2nRwyzgHfgGGcE
Message-ID: <CAOLa=ZRwv_NYqtNyvhi=5auLhVx+FDbt+RP6Kj_ZqjF=VsefyA@mail.gmail.com>
Subject: Re: [PATCH v2 04/17] odb/source-inmemory: implement
 `read_object_info()` callback
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000f1d330064f03cce8"

--000000000000f1d330064f03cce8
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

[snip]

> diff --git a/odb/source-inmemory.c b/odb/source-inmemory.c
> index ccbb622eae..12c80f9b34 100644
> --- a/odb/source-inmemory.c
> +++ b/odb/source-inmemory.c
> @@ -1,5 +1,57 @@
>  #include "git-compat-util.h"
> +#include "odb.h"
>  #include "odb/source-inmemory.h"
> +#include "repository.h"
> +
> +static const struct cached_object *find_cached_object(struct odb_source_inmemory *source,
> +						      const struct object_id *oid)
> +{
> +	static const struct cached_object empty_tree = {
> +		.type = OBJ_TREE,
> +		.buf = "",
> +	};
> +	const struct cached_object_entry *co = source->objects;
> +
> +	for (size_t i = 0; i < source->objects_nr; i++, co++)
> +		if (oideq(&co->oid, oid))
> +			return &co->value;
> +
> +	if (oid->algo && oideq(oid, hash_algos[oid->algo].empty_tree))
> +		return &empty_tree;
> +

Silly questiong, would it make more sense to check for empty_tree before
iterating over all objects?

The rest looks good

[snip]

--000000000000f1d330064f03cce8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 5cbf57c6f466c478_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1uWGMrOFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMU1FQy85aTV4MEYzeHl3TVI3cDFDR2E2Vk96OXkrdApzZGdveDdrUDVz
WmpJMFVOeld4L0dzNVBPNWtXVTNYaWVzZGVJT2dMRUFmQnk5MEpTcTZVOWdRQ0N3WWxkNEJNCnk1
eGordnRtV0llaEMxVmYvSCs1UTE5bUY0WnY0SXFSNWhsYlJDL0pidUpSVmxLWU5IMEpYVy9xdGZx
bzhqOTQKazczNHBXWW5HRGlGdXMrd3R3Y3piR2IzVlFoRkJaN3pCNGg2bHpsZWpYS3YvZXdvY2VI
blJXeW92NTlhU05OMApSek9iK09JZWhzdlZoYWdEcjNZUEM1SEllTWFDYkc3dTgxcUE4QWV0Ukl1
SWFuZkdQUGtBT2VNVnRLblRjL0c3CnNkTlVoQmtPelJDM3V2YTFLbk9UL2tUdmllVzV5Uzhnaldo
YUdXR1BTQk4xZUltV09HMVRrOE1QYzFIMzVrQmkKeUhKMjVIb1JGUDdLS0haT3NibEV5alB0YUlr
NVRaNWk1NXNkZFNCR2MrRkxWQ1hnZmV6SjhGMkxTUTUyRWpWVQpyQm5WNVM5aVpCejk4WURTeDFq
YXRqanRUdWlGZWlPalZWcEE5RXRGUVhiMnI5OGFnTlFtd3A5V0YyaXRyUHEzCko3UkI2Q2hLejhS
R0RjN3FpUVB3NmRweDdPKzNla1NhdkE2OE1WRT0KPWl6VTkKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000f1d330064f03cce8--
