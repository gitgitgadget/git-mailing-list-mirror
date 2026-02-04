Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514813D7D6F
	for <git@vger.kernel.org>; Wed,  4 Feb 2026 10:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770201108; cv=pass; b=fNRORjmjOAk492n66wgg6FT1l4Je4UKjHpppILgt3bYdyVGBs9kNg6q2ocoOmC3U0ed4gOzWeg0AUA5AsEdo3o2Xy0g5LEneptF3PLhSEFi1yEZLRlqgfSr8tneU/BRJKrODAsSRTH+9gE28sVjN4E/Cp1LDD8SprO15JzMkZek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770201108; c=relaxed/simple;
	bh=weqK9iMsiF15Er0xth0th3T05pizGv8Bd8ZmyEJSqXs=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XQCH+B4+bEVwBGlQ4dL4pxUn0wHRzGj/un6mfDWnpRz0VV/V1x4iqEHb65mUMDQsghO8D44B8MpnGLKmWsljZovxK9KxUMYhi2+0CuO4k/T7kNBMDvRW1zmjfrydTSv6etHdO3f3I8EKlydUhlhbtgvbKNoGC6/WQJCHBpED2dA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eVEp5gki; arc=pass smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVEp5gki"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-56641200d6eso5226134e0c.0
        for <git@vger.kernel.org>; Wed, 04 Feb 2026 02:31:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770201107; cv=none;
        d=google.com; s=arc-20240605;
        b=HKh6oB7AjrnQAz5TYbYe5A1w3GZXriNBx9pZFFHK2/hKjhfGrzQpNYiFy3TL+55n35
         W/S+bOAFe131cte8Lj45FTLEPFwr65eoBtZzOMxHenHCtTaixw6RJ+1TvtJkAyRaplsD
         ajTFMcMyRtG6w0bmfMTwIpED2vUTAeX+Lg/RyKxIbZfH39cfv2e6ImSuuUcEA6o29Xy/
         Xztx1VTsh49QrUDF3vastoJIBVbOJmnizxnvuj+XdyrLEgKt5FfYL25Tgy+9Xb0Ewglk
         aqn7x8aufHxyD4EZHqo6lpze6DH7ac9Zcngkt7N9x5hAWeIinPqoMaiYcbY9F2WP3WXE
         XA9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=rAvEb4vVyFSgrMfMgmCmbq9V3BdGhd2mBKnUMaE9rEw=;
        fh=74V7ilTh1wG4KVC2+zIS280UUyp6rIZ3996eOq1lNt8=;
        b=FJ3jSH9AjnsbOa1OWhS+cUDnYgaaw/GCJerpY9L4yirZdYsM97DHGudPdwB5eOWRPH
         PMUI6Rk7Ze86YhMBK5W2hE0OE5ra4+jhdVZbNECMHKFaQmjO/TMoJ3ASzKBw2Mvd7lQX
         7pcgnboSi7kcTIxJxlc/JTBdo9YQ94Tnl/NHLN3hc7QMVvTHdxQy6Ly17xXGhT5chGRj
         wPtPg9AOsx5jWMk4TeoOLGH07QyWJRXpcisvvW165WVjHef2F6D2rC9kLNRSehEBC3g2
         qdMeIKw3BjfhhT2hFpHEjK9AUy1qpCw5+nc8UbqO9C6MoOodki4wRfZeSru303w+IY6S
         H6KQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770201107; x=1770805907; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=rAvEb4vVyFSgrMfMgmCmbq9V3BdGhd2mBKnUMaE9rEw=;
        b=eVEp5gkiJsjm67Jvnj4VyCPof3+bdYXUODSY/CwT9coHRWNtdHdiF+BtdNZrzlUW0n
         XYax970eRtFy8Ox91w6YmECqGWqTV6F1tV/GWEkHFiQ32OHPKby/TNviMUXI5cop1xh/
         yHXqNrGFNU7w/9S+zMKJyTIWxmaLt5wH7Tc0NjEW1chWCBLKFaFsuthH06yZuiuDhzib
         sKrwIXUm/HHdlzscUUyYmXOQrlgnwNrWSPsm/UlaFE/Fy78rdNpUm/Byp16H0k4QOZ5m
         Q1ibR7xUYgT7RaDmE2T6hHn/famuRC5SHi4bXFaQgE5KEeTYag8VcT/8lPUTnvQPgFk/
         hMaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770201107; x=1770805907;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rAvEb4vVyFSgrMfMgmCmbq9V3BdGhd2mBKnUMaE9rEw=;
        b=CWJUX8oBW1VNhPWuBUrwlDGCxEmqRV0vF7uNKDOoR2pInHnzxDuCni+oZBCjDgH/Dq
         46/vDtkq/ssHdYU8xIlHs290+0SwYRwZKP37rGSCziMm9oaxHjHHT5DPjhsFPBf2lot2
         KVdo2WYZdORa3R/f6XWmJvhWc9NR+Mp5eJrJdMiUIuhrULnjE2VDR4qfeaGEplxkWUjx
         CUcJZH1n0m5jJnOqZbj7IyNZ1zrrSqwdAafT6f1J/qbiLOR+f+4uX29k+EKegu46n6ee
         9KwOfU5innIHBr8TixQCX7h0MCRsTO61bEkKdJR+eCwcCc0cNsJklMqjAUe1/QVKatxd
         zpMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXeFtq+/upNWLqdyvV/+5YehQIlkwAo0YR4Wm1TrHtGPbaSDXtKilsEz0sXVbRjYmQ9iog=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3MVhQgncyclcLkA85+Ur5jgeGjjYlylRskzwUHvsqQosqs0MH
	LG9X2hvXWZ0gysOlt7ZxzYxZyksOcSOzaa1kMVKGO5RvIlTgvJ22NA9i+EXn/UpcPxP3KBM/aH6
	4v+jicIbN5syzVb6BRG5HRDKQqqEAmJw7VmPX
X-Gm-Gg: AZuq6aJWvDwhbfDdDegFDgI0/94ZtpHlYxPGrZb3BZ377qfA3ljp9AHY2RFhavpYmlM
	dvfNysmm0jSFw/nd0acZpKH9c1Ft44q18W59+P5Q2NiBnbl46RJLMeL8I4ic73ywIYvmSQgcmuD
	b2AF40aLPYstUg0YnMMEfZugJYh1CWcdxIHl2an2QXZpaG3tdWOSdp/L8bazqh8e//wlwyXHRej
	T6UDOMxB/3cMYdVz6hiKjnEXR/AaBHosfM4pkKFpvA1V8lLtoXy/tRsgGEVYc8fauAymL5Aoaak
	csGUYe9N1l24Yelk48V/wdGjdZKVPg==
X-Received: by 2002:a05:6102:3e81:b0:5f5:4f68:9f7e with SMTP id
 ada2fe7eead31-5f93947de57mr734352137.8.1770201107214; Wed, 04 Feb 2026
 02:31:47 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 4 Feb 2026 02:31:45 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 4 Feb 2026 02:31:45 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260203001002.2500198-4-jltobler@gmail.com>
References: <20260128234519.2721179-1-jltobler@gmail.com> <20260203001002.2500198-1-jltobler@gmail.com>
 <20260203001002.2500198-4-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 4 Feb 2026 02:31:45 -0800
X-Gm-Features: AZwV_QhRSSJMUnIH_ezi6SOzX4Ep7jtlmcueme263tlvD3Weu3Gtte8DopVwi7c
Message-ID: <CAOLa=ZRb1eVSD42Obr_m+3KUy0Bh=0XmOZt8ofrbzy4Mp8xfwQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] odb: prepare `struct odb_transaction` to become generic
To: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org
Cc: ps@pks.im, gitster@pobox.com
Content-Type: multipart/mixed; boundary="0000000000002d4c4d0649fd10dd"

--0000000000002d4c4d0649fd10dd
Content-Type: text/plain; charset="UTF-8"

Justin Tobler <jltobler@gmail.com> writes:

[snip]

> +
> +/*
> + * A transaction may be started for an object database prior to writing new
> + * objects via odb_transaction_begin(). These objects are not committed until
> + * odb_transaction_commit() is invoked. Only a single transaction may be pending
> + * at a time.
> + *
> + * Each ODB source is expected to implement its own transaction handling.
> + */
>  struct odb_transaction;

Nit: Wouldn't it be nicer to just the below `struct odb_transaction`
here and drop this line?

> +typedef void (*odb_transaction_commit_fn)(struct odb_transaction *transaction);
> +struct odb_transaction {
> +	/* The ODB source the transaction is opened against. */
> +	struct odb_source *source;
> +
> +	/* The ODB source specific callback invoked to commit a transaction. */
> +	odb_transaction_commit_fn commit;
> +};
>
>  /*
>   * The object database encapsulates access to objects in a repository. It
> --
> 2.52.0.373.g68cb7f9e92

Just a question in general, is the idea to eventually also add support
for {prepare, rollback} within odb transactions?

--0000000000002d4c4d0649fd10dd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 39bbbdaf107dc54e_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tRElBOFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mN3ZZQy80clg3Vk8ydlc4bXp5UEVRSnVsNzhMT3h0OQpYYkZTYzcxazYw
ZUpaVk9LNkwwVHp4MktaVkkvWTZaQTMvbUN5eFpXdm5qREc1WmVTVGtkYkxmUG9SL1VKMkRqCnRI
Zk9neTZUdjlibjUzbjU3OVNPRC9KQTNhU3JrdFZ6NXhuTWZKZXVpa3U1dUt1TTR1dDVxY2Vvdmdz
c3AxN0EKb3pkR0UvWFA3ZUZYOFJLK1IwbmFFRE9ZTFh2eFV6czVkSWw1b3YxaWVkSVBWZFFNVExO
YSsyRHZnUlh1aW5BYgpGKzk1NFVsVzE4aXd1THFRNzlranBTMi8ycVNJZjZoYzdCbEVRT3JlOEdX
UGlsL1BvY0s2ZDNMRkF2STErdldQCjFlSmc4Sk5nZG93dllBOTVvclZIcXhzWGJTbzJpelIweW45
bVBkcFd2T29waVpwTDhFQUExc1AxYlhCR1Q5Y08KRUNLVDNjZWh4NGhYMkpuN2VkM1dDL24wMmpk
c1BUdXp3K0VRcDFleVlxNXlUemYyaTdyL1gyREdselRUUFUzeApNQTZoS2R6dkt5R21mM1hGTU5Z
aVBER1FTN0pDUUJiUW1neWRENXp2RTBveFkra3RyWms2WEQ5RXZhMTdnK1JKCnZBaTMwbVlKOEdu
THBKVUFDMks4bEhESUV3VFIzNHM1SGs1bGorQT0KPTVqb2kKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000002d4c4d0649fd10dd--
