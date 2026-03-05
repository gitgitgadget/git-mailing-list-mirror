Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A9C1EB5CE
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 10:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772707862; cv=pass; b=Qtw7t0ApA1wA8dzN5XJ1eqoEl53V+HWgqZW7cJTbxDkns8dKYJGwUAPbX8TEJ1gedp7qeQSWxrSvZWCb/GjLz7GKpVPeAwQHYD3ayVBR9fdEcDZhrWPjS2LE9EQTc9LeBJaHAeo1TLyhuqDcmb+W3hpmTIXbjTELjc4cafZp1Uk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772707862; c=relaxed/simple;
	bh=nQi6TBRmzx3W0h2dAmzfUXqxIzr58/YaMNarc5UXnK0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=fHgkjU16Uylbcs9OJzOqadfGmqvdQJpLjtZU3Stttppf7QJJv6CknI3jgyTbgkAT9uYQI0qefypsiYNElDDxagNxEZNqctPFj4fYiSwptpTBhR9wgEUZRU7jJeM/1IUV/+mI93BflFkVUGBRYVzaYfoEER7e8SbxcFiFz/9IleE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e1Y92eeL; arc=pass smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1Y92eeL"
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-5ffbcfbcec4so357505137.3
        for <git@vger.kernel.org>; Thu, 05 Mar 2026 02:51:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772707860; cv=none;
        d=google.com; s=arc-20240605;
        b=W7o1KGr7DtZvIOSYv/GR3DKfpypL2T9PDvIl+cXeHGyhrlK/l8CASHSZCyMWbBZjmi
         6W4K/H/6NBNdR1Q216pRpTwarI3ld82cIH+TWxYiIMWO3Bgd4alpYljT70/Io4neWi6r
         lHhx8thnF0BYMT2UiEWYHn0f2tD+Rco8QdEiQo0ykZ+KC/xNMZoLEre5B6zeCUTlaqv9
         6Fvv80KQuH2X6GRrhVosY1ZlHJKqfTGrUc0svO+gOs56uUOWFRr1599wJRw/ypk7cKgj
         xwBb53e9JLIEJXummWVzRJwK2WZ1ld78TqfRKpsv7He1XsSq+LwMejiPI5SkWuouOmuR
         eKFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=XMdN/phtf7ZkxDxrSvmmjKf/gK3scFeu3REJobDsZLY=;
        fh=3F0DqTjVZJX4fD/FR6LBV+E5v5O/RWGlC+T2dh0nIyA=;
        b=ja451HWDSqGPQsR/aRVZKOAkIiByVeXgsJRu/tu+b9ZbkBZlfFoZTe6oQGbQypn0xM
         4JI0ZetFePzy5/5XzSwUhALQEC5Mpo6LtwYqUHK+GT74yOyC1KqkBQwXkbvZINbPTSXl
         aSwQjGA3eHHkcjt8ZGF2wD9aLFSet+zwZVdjdnU9sVwDnKSbP4n1OFE1hmAy6jJ0GAbh
         GqMqsdYaGwbSSD06K/XHpjNUAAlaAGpj1tocRhM/4EeeZMcSV4zfd9ROSUMK9vvsTdR9
         NxbgU827wutqNCtHzJq7ML0ShqpNl1fGPgil9lql1onF86m1dOsCX+WTLUnlQKS5IsLp
         Cv1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772707860; x=1773312660; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XMdN/phtf7ZkxDxrSvmmjKf/gK3scFeu3REJobDsZLY=;
        b=e1Y92eeLArAOOa1nJcs48+1vXibBe35hXjXurEgK2WGXv4OnxNhffXMhNUS2X62c3O
         9ZO+t4fMdto9HctDwXO7tBspoItq9x/63MZLqdOBeUGKn8Jb6t+SqtDIYdoPQAfo83R8
         ds7psoClipbkPjxgFY2ndBBjgLQxpKwx5djKZngRL3vUd1jBr7rMzGcBHcjpby2F5Ehv
         oRm35zEosIQndofx8W4TjvoYOA6NtBgnWoBgisWooVwzNRoXl1cpczlmvxjwVQ8BovFG
         OQbY0hcDqMug+ALXZFAuVeyTCfekd+9SNZcWwKLbcBpEXvi4JRUBBS+rMN3Nh38Zc9Jr
         2J0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772707860; x=1773312660;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XMdN/phtf7ZkxDxrSvmmjKf/gK3scFeu3REJobDsZLY=;
        b=BZpTPuI2V/c/cYCkEh0V3ye1hGSi2/Ojh8KDsk+Ih8J4jRfBTHFCCQT9usTHIM8xEq
         Au+L9+l2hoy/TXKD/HBrP0xv/zpEgwKF68s5QU1BG7g28/uo9DMeyTajpp1qSQof9sjT
         TuS5d6H+2uLqTTKu1Oyk4D7CA5mJHSpYjIUXp5cexywURKYxwTPsr14Da4Yp6nzlhVZA
         slner6cxQSJbZYAB367oCv0rjkpn4lwXMHCXp+iLhcHWFG0Z0PXnct8VHyp7E+2biqQs
         GN/BWtN4QLbulIfAmfrtX8VMrv6U56xxnONHR9+1lkqepJreBRQ/P8ddVqfLD60dDbct
         9NnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXah3gnQ6yNoUHYcrveyW47mCRfSoFsW/KsKPIUn5Tnk85ViHGV84lXBldxskEpDa5xKz0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4PU7G0miIwiWiHRd8aEE2Oi1iNnkZAWFGezYjTBN539zyR5rl
	SV9QuWgkGmlKOhBJcSuL+ISbUXywU9DGFLfFKmnrLEJagA65CRI2i8+QOTUMVEqcrJvtrg5rFbi
	pEs1s8V8mdaLPdn05in+cHiyWjMLVMLoBGKtW
X-Gm-Gg: ATEYQzzjbMR0CBuj7hNAxwL0SLobr1rZwcnPEw34LHvc6LiW+e++EpUQLP4oVxeDz+0
	YTEcZ3OQQ2dQlWktPBOlnQpWZRd0XJ3e3PGzEw5czuTb8naF0Fn51P8J5FuYiDo2IEhBThTIsYh
	WiEiu3XQjMnn0xkAXJEa0vD5aOy411hzy7ZjWDBw92EcyiowJp2PdDig9RBd/nuEl9cf5nS9gPm
	EdiWKGphIQJtqYO3aEmFi1uoF4HnU4IARVyV7wMFuGEirkeDIEPCc1Tbfy7xne04ScNsH+KVYwh
	HNDyu1O8FsRaRlWO2/myBeJKim6H5+BgvjeXks/awlVgqxu5NMo=
X-Received: by 2002:a05:6102:508b:b0:5fe:43e:63d3 with SMTP id
 ada2fe7eead31-5ffab2a0332mr1921121137.41.1772707860075; Thu, 05 Mar 2026
 02:51:00 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 5 Mar 2026 02:50:57 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 5 Mar 2026 02:50:57 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260223-b4-pks-odb-source-pluggable-v1-5-253bac1db598@pks.im>
References: <20260223-b4-pks-odb-source-pluggable-v1-0-253bac1db598@pks.im> <20260223-b4-pks-odb-source-pluggable-v1-5-253bac1db598@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 5 Mar 2026 02:50:57 -0800
X-Gm-Features: AaiRm50ja__RDTLidss_6-CgfazIcKnn4q_-9yAaswVwP9JZyWerc7DZ-y4ZH50
Message-ID: <CAOLa=ZR3cQjgdzF9_hRHSW6iO3p0qzduBBvO4-yTnc-1P-oFpg@mail.gmail.com>
Subject: Re: [PATCH 05/17] odb/source: introduce source type for robustness
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000004a72b5064c44b6a3"

--0000000000004a72b5064c44b6a3
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> When a caller holds a `struct odb_source`, they have no way of telling
> what type the source is. This doesn't really cause any problems in the
> current status quo as we only have a single type anyway, "files". But
> going forward we expect to add more types, and if so it will become
> necessary to tell the sources apart.
>
> Introduce a new enum to cover this use case and assert that the given
> source actually matches the target source when performing the downcast.
>

So this is what I was talking about in a previous commit, nice to see.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  odb/source-files.c |  2 +-
>  odb/source-files.h |  2 ++
>  odb/source.c       |  2 ++
>  odb/source.h       | 16 ++++++++++++++++
>  4 files changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/odb/source-files.c b/odb/source-files.c
> index df0ea9ee62..7496e1d9f8 100644
> --- a/odb/source-files.c
> +++ b/odb/source-files.c
> @@ -36,7 +36,7 @@ struct odb_source_files *odb_source_files_new(struct object_database *odb,
>  	struct odb_source_files *files;
>
>  	CALLOC_ARRAY(files, 1);
> -	odb_source_init(&files->base, odb, path, local);
> +	odb_source_init(&files->base, odb, ODB_SOURCE_FILES, path, local);
>  	files->loose = odb_source_loose_new(&files->base);
>  	files->packed = packfile_store_new(&files->base);
>
> diff --git a/odb/source-files.h b/odb/source-files.h
> index 58753d40de..803fa995fb 100644
> --- a/odb/source-files.h
> +++ b/odb/source-files.h
> @@ -30,6 +30,8 @@ void odb_source_files_free(struct odb_source_files *files);
>   */
>  static inline struct odb_source_files *odb_source_files_downcast(struct odb_source *source)
>  {
> +	if (source->type != ODB_SOURCE_FILES)
> +		BUG("trying to downcast source of type '%d' to files", source->type);
>  	return container_of(source, struct odb_source_files, base);
>  }
>
> diff --git a/odb/source.c b/odb/source.c
> index d8b2176a94..c7dcc528f6 100644
> --- a/odb/source.c
> +++ b/odb/source.c
> @@ -13,10 +13,12 @@ struct odb_source *odb_source_new(struct object_database *odb,
>
>  void odb_source_init(struct odb_source *source,
>  		     struct object_database *odb,
> +		     enum odb_source_type type,
>  		     const char *path,
>  		     bool local)
>  {
>  	source->odb = odb;
> +	source->type = type;
>  	source->local = local;
>  	source->path = xstrdup(path);
>  }
> diff --git a/odb/source.h b/odb/source.h
> index e6698b73a3..a1f2f8fdb1 100644
> --- a/odb/source.h
> +++ b/odb/source.h
> @@ -1,6 +1,18 @@
>  #ifndef ODB_SOURCE_H
>  #define ODB_SOURCE_H
>
> +enum odb_source_type {
> +	/*
> +	 * The "unknown" type, which should never be in use. This is type

Nit: s/is//

> +	 * mostly exists to catch cases where the type field remains zeroed
> +	 * out.
> +	 */
> +	ODB_SOURCE_UNKNOWN,
> +
> +	/* The "files" backend that uses loose objects and packfiles. */
> +	ODB_SOURCE_FILES,
> +};
> +
>  /*
>   * The source is the part of the object database that stores the actual
>   * objects. It thus encapsulates the logic to read and write the specific
> @@ -19,6 +31,9 @@ struct odb_source {
>  	/* Object database that owns this object source. */
>  	struct object_database *odb;
>
> +	/* The type used by this source. */
> +	enum odb_source_type type;
> +
>  	/*
>  	 * Figure out whether this is the local source of the owning
>  	 * repository, which would typically be its ".git/objects" directory.
> @@ -58,6 +73,7 @@ struct odb_source *odb_source_new(struct object_database *odb,
>   */
>  void odb_source_init(struct odb_source *source,
>  		     struct object_database *odb,
> +		     enum odb_source_type type,
>  		     const char *path,
>  		     bool local);
>
>
> --
> 2.53.0.536.g309c995771.dirty

--0000000000004a72b5064c44b6a3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: ba6fc5626caa0e60_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tcFlBOFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNXluQy8wY0k3RytOR1VMcS9CbGVQdDF4RUVGNHI1VApTdCtVR1hlTEhN
WTB2T0tLQnZTZU9JdXBMY1ZJT3UyRW9vOHRLdFVGN2R0ZWFZbVFiZ2tsZjVPYS8vSlJlUjlyCkZ2
MG43K1RZVG9uL0t6d2dRd1dPcWYyQXBhQWNaaEphaXpFdFBmNktQR2UvWlhiNVBDRFhCbjBBelpj
MVRUemQKcTR0SS9xMVlXQlZqMnpvWHZxNjVONjNXM213U2ZKMGtjVFNEdVpaQnVXV1AzUE51ZldM
ZldkVllKdFh2c3c5OQoyamc0cWtYWG44YUlZN1hxNnk3RkkxOGE4aVdvc0liN3dGNjhaLytBUG9z
MityQVB5OGU3RUgyTXJ0M1EvcW1wCnc4MlI5WFRFY3pva2R2R3JFVXNMOCt6SjlUUGNpMUV3ZXpw
R1I1ajhJNldWeVA0TkYvbzEva0NidStXT2c4SU0KV2xveEQyUmgyb3h5OWxqci9aeUx0dVgyWm5J
STJKUkhsSnoxYXJFQURxcnNWOTVoSmdPZnFBRW1HdHlqWHQ5TgpxWUdLUmpXMVJJVE5TbzRjaXF5
WW8wZm1WRXIwVFU1c25YNDFnN2FMVWdsR21uc0NLc2xEQWJBS0ZkWDZ6Ymk4CkFQVG1XZ09oa0NB
TldNa3ltUWlpNll1OGhpMStyYWEyY0NGR1BLWT0KPU5sRHMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000004a72b5064c44b6a3--
