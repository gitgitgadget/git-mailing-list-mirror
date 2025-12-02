Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA9B25F975
	for <git@vger.kernel.org>; Tue,  2 Dec 2025 15:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764689357; cv=none; b=JC+OBDy/sDqcUDFkPTz4QZSzEgb15Vt0KYtTr/rXuL6m9tWGhLypRmeM/uLX3MdbCGeH9oy8F8Vu7LTm6R2hMCldRtLvaLbH13MA/8OKzR95CzI3gnuBXCpfBk+elyYnMGiUVjJAzdbc2TRXCA/zz3KF2UWJFtT1G3kQOkKGILs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764689357; c=relaxed/simple;
	bh=wpoFtY1noj0n+HECxcqGY0mHYiw8e5BuvgNMuxMKC8Y=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k6u13ZkH6qriqo2HCF6WuJMeMHhBKzv2bfD3ON5K+4gISQcU0u1uBZMmVdIVjYy6XkX0AIPUdM67nr6AE5ouASUI7A0CI33ADSV37X3ZrzxiHOlMP/mffUhdUZUDbswEEYrV9XTU0fd6bTWI+DIbKuxUG3e0SseHLtymW8g3VnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OFyQBnuX; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OFyQBnuX"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-55b0d4b560aso4165982e0c.0
        for <git@vger.kernel.org>; Tue, 02 Dec 2025 07:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764689353; x=1765294153; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=SabtBtaE3WVqAc6iwFfzukKrdAGUDo5ENkiLAh2zg8o=;
        b=OFyQBnuXthSEhESJJKnc/5SSUKZFI7W6Ybxfkf1eEL/I+n40g87COKBoHYrvsr2Lag
         g9uPXnaiOgmTso9qpJZlKgG9zL9RAAvrpE1H//Gwm1sFhvAtIlVQ0MO64ke77a9HUClr
         +HHYof7Hgdmk9k0uWPcI3wAXxgj04HC40MvzJOb8euccvDpenhRofdcjiJWz9B+TQ6VU
         9bQBT8HcxKu8Lxk6uzBL6oikmDuvyTI/lQ/8mrTPasfzkMhYeFiO/ZEhKFK0aPSluA5u
         hMw0y+dU1j6o16/rZPXh8BOv/AzVgSZ6eCkUkI/gMUqe48CROzuRnCZLAEhxLZigL0ff
         Q3Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764689353; x=1765294153;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SabtBtaE3WVqAc6iwFfzukKrdAGUDo5ENkiLAh2zg8o=;
        b=ifrXWpByw5hgRZAU3I3NUSE5lgEp6naB/5GAjNDFKDy2Iv5bqbjU1DZD4/AqkAR0OB
         9BfTMBJz8C5IsbhjWkHeDmzRYBUD8lAVSY5v/wMcNHI/Sn/UBxlyw6ipMv1vN9596dPP
         jSL/2tZrfuMbC4NxCwyE9C5Kh3FrvsKvfUkCE/5x/rMrJyawyRM/GNsDFtRTyxe58Mst
         SZ2RaPK6SMHt1fxDWE5K0FH+RLaq4pd+6m9eKxSHt0NzThyHsR+h5OnUzi9VbNr4/DAL
         13kLD2cfc7SpssFe1+77zZIj3ciK6l4c5LXijqVnhTVRX+Mzkk6YRNztoTciZSCL9HgC
         wdrg==
X-Gm-Message-State: AOJu0YwP/6rcxxj+M7dRo1V88eQDkGy1f3m1+x8o4frHMz0yLTpBGslT
	30pJMncg2ud8w5HS6Ln9hZFDJ0Lqufs1r5HZa8qK4AomytLZeIR1S5qsnWA2HOXrfHroyEv56RL
	/d7xXwY3KNzrsZ5Er1sBcJi0dmrnNw/KC0Q==
X-Gm-Gg: ASbGncvss/qOhd0jDTbaFvnIH/x17dcz+sW87cAh6Bx+GL+FC/LWRlVesgYSoW1xJv4
	8tOv6Frzprnb5wTIYRkuIXzjiFuoUzvJocZvOaqrF2ctxc+OKM594R6OKRrjCzilttVThFIiz+A
	YhR17ovbyUt76pwqNDv9/pLtWBlT9LfkFvP+lHzLE2sL0vcoD3VqAhVwMGagReCbx1nNxMGO0d0
	j8GN5Ae5/SrkfB9j2UA4OSpUWXjXSe4GTiCjCXesRM/4n1hxg8JQPttNQfjL1OcJLm4rBjnBhxA
	cbfc/VACysQU2zeTxdGxbVMQc1ZkQg==
X-Google-Smtp-Source: AGHT+IEzabwRyHcXFnmam4KNGvbhDKZkgQChXb1iI4m9EmPMUkhQWRs78d9qFkoPBE/pKZ8i4vZbm4Od8AvPh+MC/rw=
X-Received: by 2002:a05:6122:8006:b0:559:6788:7b55 with SMTP id
 71dfb90a1353d-55e4e6d6acemr1266370e0c.3.1764689353443; Tue, 02 Dec 2025
 07:29:13 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 2 Dec 2025 07:29:11 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 2 Dec 2025 07:29:11 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aS2V4TKeS4V_oxAb@pks.im>
References: <20251119-kn-alternate-ref-dir-v1-0-4cf4a94c8bed@gmail.com>
 <xmqq34651ie5.fsf@gitster.g> <aS2V4TKeS4V_oxAb@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 2 Dec 2025 07:29:11 -0800
X-Gm-Features: AWmQ_bn9tpGcXvY9mymN3HO6XrktB7oO75JrkkkoKv4biMinTfOU40PyXexzwW8
Message-ID: <CAOLa=ZQLUjgKkoSExd=zBO8bfXR212M=_rTUaACjZUOR0e6v7A@mail.gmail.com>
Subject: Re: [PATCH 0/2] refs: allow setting the reference directory
To: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000000d41560644f9c28b"

--0000000000000d41560644f9c28b
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Sat, Nov 22, 2025 at 08:29:22PM -0800, Junio C Hamano wrote:
>> Karthik Nayak <karthik.188@gmail.com> writes:
>>
>> > While Git allows users to select different reference backends, unlike
>> > with objects, there is no flexibility in selecting the reference
>> > directory. Currently, the reference format is obtained from the config
>> > of the repository and the reference directory is set to the $GIT_DIR.
>>
>> I actually am not sure if I like the proposed environment variable.
>>
>> The proposal is based on an assumption that any reference backend
>> should be able to move their backing store anywhere, and they should
>> be able to express the location of their backing store as a single
>> string <path>.  For a new backend, "where is your backing store" may
>> not even be a question that does not make much sense (as "somewhere
>> in the cloud that you do not even have to know" is certainly
>> possible), and even for a new backend design that does allow such a
>> question to have a meaningful answer, this "you have to be able to
>> use a random place specified by this environment variable as your
>> backing storage" is an additional requirement that its implementors
>> may not need to satisfy in order to please their user base.
>>
>> For reftable and files backends, these assumptions may be true, but
>> then it is not too cumbersome if these stay to be backend specific,
>> as there are only two backends.
>
> I think it's a reasonable assumption to make that the path _can_ be
> represented as a single string. For now, we don't really require any
> configuration for the backend in the first place. So all you need to do
> is to say:
>
>     [extension]
>     refStorage = reftable
>
> This implicitly identifies the location of the backend, too, as we
> derive it from the commondir/gitdir. As you say that's sufficient for
> the "files" and "reftable" backends, but it may be insufficient for
> other backends.
>
> Suppose that we for example have a Postgres database to store data. It's
> clearly not sufficient to specify "extension.refStorage=postgres", as
> that wouldn't give you enough information to also know how to connect to
> the database.
>
> It's a problem I have been thinking about quite a lot in the context of
> pluggable object databases, as well. Ultimately, the solution I arrived
> at is to extend the extension format itself. For pluggable ODBs this
> would look like this:
>
>     [extension]
>     objectStorage = postgres://127.0.0.1:5432?database=myrepo
>
> This is similar to a normal URI with a schema: everything before the
> "://" identifies the format that is to be used, and everything after is
> then passed as-is to the backend itself. I think this should give us
> enough flexibility for any future formats and it is easy enough to
> configure. The added benefit is that this can also work in contexts like
> the GIT_OBJECT_DIRECTORY and GIT_ALTERNATE_OBJECT_DIRECTORIES
> environment variables, even though their naming is off now.
>
> For the reference storage I think we should be moving into a similar
> direction. Sure, for the current formats that we know its sufficient to
> only specify their directory. But I think we should treat the directory
> as an opaque string and then let the reference backend handle it, same
> as with the proposed format for object databases:
>
>     # A schema-only variable will be treated as if we specified the
>     # common directory.
>     [extension]
>     refStorage = reftable
>
>     # It's also possible to explicitly specify a different location for
>     # the backend.
>     [extension]
>     refStorage = reftable:///foo/bar
>
>     # And same as above, we can also specify non-locations.
>     [extension]
>     refStorage = postgres://127.0.0.1:5432?database=myrepo
>
> As said, the important thing here is that the reference backends get the
> string after the schema as opaque blobs that they can self-interpret.
>

I think you bring in some good points here, I didn't think of
`extension.refStorage` and I think we can extend that like you
mentioned, while staying backwards compatible.

>> So I dunno.  In addition, if this is designed to help migration
>> (which is the impression I am getting from the cover letter
>> description), don't you need a way to specify more than one (i.e.,
>> source to migrate from and destination to migrate to)?  With a
>> single GIT_REF_URI, it would not be obvious what it refers to,
>> whether it is an additional place to write to, to read from, or
>> something completely unrelated.  For example ...
>
> I think we cannot easily retrofit handling of multiple refdbs into Git
> at this point in time anymore. The way to drive this would be that we
> have two processes:
>
>   - One `git refs list` process in the repository that uses the old
>     format.
>
>   - One `git update-ref --stdin` process in the repository that uses the
>     new format specified via GIT_REF_URI.
>
> This allows us to do an online migration of data into a separate ref
> store.
>

That's exactly the mechanism I was talking about, thanks for explaining.

>> > This patch series adds a new ENV variable 'GIT_REF_URI' which takes the
>> > reference backend and path in a URI form:
>> >
>> >     <reference_backend>://<path>
>> >
>> > For e.g. 'reftable:///foo' or 'files://$GIT_DIR/ref_migration.0xBsa0'.
>> >
>> > One use case for this is migration between different backends. On the
>> > server side, migrating from the files backend to the newly introduced
>> > reftable backend can be achieved by running 'git refs migrate'. However,
>> > for large repositories with millions of references, this migration can
>> > take from seconds to minutes.
>> >
>> > We could make the migration non-blocking by running the migration in the
>> > background and capturing and replaying updates to both backends. This
>> > would require Git to support writing references to different reference
>> > backends and paths.
>>
>> ... I am reading that the above is saying that the system will write
>> to whatever reference backend specified in the extension.refStorage,
>> plus also where GIT_REF_URI points at, but if that is the way how
>> the mechanism works, the variable should be named more specific to
>> what it does, no?  It is not just a random "REF URI"; it is an
>> additional ref backend that the updates are dumped to.  Maybe there
>> would be a different use case where you may want to read from two
>> reference backends, and you'd need to specify the secondary one with
>> an environment variable, but if the system behaves one specific way
>> for GIT_REF_URI (say, all updates are also copied to this additional
>> ref backend at the specified ref backing store), a different
>> environment variable name needs to be chosen to serve such a
>> different use case, no?
>
> Truth be told, I'm not realy a huge fan of the name, either. But as
> said, I don't think we can easily "overlay" multiple refdbs, as it would
> lead to various different questions due to our hierarchical layout of
> references.
>
> That being said, I personally would prefer `GIT_REFERENCE_BACKEND` as
> variable name that accepts exactly the same kind of strings as the
> `extension.refStorage` values I have proposed above.
>

Fair enough. Once both the env variable and `extension.refStorage` take
in the same input, it does make sense to rename the env variable to
`GIT_REFERENCE_BACKEND`.

> Thanks!
>
> Patrick

Thanks for your input. I'll make the necessary changes for v4 :)

--0000000000000d41560644f9c28b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 6dd1649844c84e14_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1rdkJjVVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMzlwQy8wZW1sNU5tYzYxOXVvK0lObWpnZmVkdlFUNgorVDRIemZhTjlO
MlpyaFNxdHYvK2pXRE9Idk5wcjRGTVJqMWxNZ2oySU55Q2ZBdHF4SGl0Q2NXR1VVY3BEbWZQCjVN
T0IzNW9SYlhjWGw5dXFtSEgxOEhUZEZJbW5XbU5DbXBZRGowekJCaWgzdVNzZTlFekVaTlBPaGh4
bHFFYW0KU1ZNcndpOHNjSWY2bHl1bVYyQmExNEhEbjNqb1JTOEJkS3BMeEV2M0dGMExqcHZMK1Nn
R0VDdklLZGpzazY2aQpwNlNIWmxhRmpTK29BdnVoNDhkN0dOZmZiNFVFelRGWEVycVVRdUpEQnFE
dHhuK1BHMFc2d085UVlveGFaRHRKCk5vN0hSNnl1K2xMeFZQeVluOGVZVkdYTGtWVlFUWHZIQmhj
RW1tVys0MHFQWnFndlhXSWVDdzU1QjlUUVd3T1QKMlE2Ky9Xb3ZhVXdBWElDblRwREFpOUlRRkxk
bTlYTGFlcmwrSmlCWno2Q3A2WUxlWUhJTU83RXU0V0xPcllPZQozekl4TjBPZTlKalhVd3kzWFBz
UXc0RWF6UW5zUUNMTU9oODlKSVdrWUtERlkyMVdmTTNhdFE1U1p5QldCMFVkCjN4cEMxWWFVRU14
VEVUV0NwbE9DM0wwTWdWeENvU2dqZnpKQzczND0KPWE2ckwKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000000d41560644f9c28b--
