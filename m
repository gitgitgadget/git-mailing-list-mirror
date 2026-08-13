Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD0935C6BB
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 12:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786623824; cv=pass; b=EcjuwIC6hwoITGAtg0F0zsv4fUC7Hbj5pZvvkSGSwgAlIE1TrWFrL/5wC3J9oRLuxOJqYQwox6wQFdhTL2/4ESG2QU+2oyDaDCBt2/gc0vxDbCR4OaGiil/6r+LJ5AIwVaME1Iu5SKh72CH/hPN4uSaBFDga0/3u6ba9m/sLoZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786623824; c=relaxed/simple;
	bh=ZR6KCrERa2z/IG2KQzf59S+FKTBuoHGcE27qzD2S9Kk=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JR2as05B9KQuX86ugU31F1TsIiLdwLqOmqcWS5VNhugxgdZVXA4z9BFdT+YLJJdCmhE5cDNKteEX9lC30oU0HibDg5iF5jLJqWzjW60ARHIfhxZGMl9zDrsH4fl2NHNSZE2oD/ZQlNHf6HLkoVRMD39oq4O6AvCcsJooPaqVPKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bWSml8L0; arc=pass smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bWSml8L0"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5c3fabe908eso683927e0c.0
        for <git@vger.kernel.org>; Thu, 13 Aug 2026 05:23:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786623821; cv=none;
        d=google.com; s=arc-20260327;
        b=LyOsE+8o0gEmHlwsrcfiPCsnWUUr00rId3ynxvX2JOr+Q7AaXJacEUA8C1rISDCXEb
         8C2XodFPc6Ai2MLDYRC4oHaYvPsKm2ZTI1dVgdUpAArRBt0Ja81pf7BEmOX78Fiyap2w
         dRGaPWpoeHpeKGtYOUxBL6zGsWgg+fJEi0O8tJySWRnn9ur62iVAFTQAFzg20rPaMDw8
         JTKnOy8x6lYBm/89cUESLG88s7fPrnPUjIq33pEHoLvyUg0AnzOeqXDQ25jabXd503v2
         xOJ1e9nYWibWy82cl5fjurMgh4x/+99YG9eURYvrhFkBWZJC+ULQHI4XEX6l1luGRPcV
         BqtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=/JKr8AMALR7jJTA8PpiKZ4JI/GJ5cmVOG0msAYT0UOs=;
        fh=470YvqdvdPIC5vvZdldOIk9ej58PQXX0lKHQBGEgDyE=;
        b=NH7lmtR71omkEc/1kJFS8sPG2Kj+yGGQWKfZ2KB7S7sBLhuWSRIJS07S39nSbFh44w
         S21257BvA0NI9qPBMl15N+Yty6bcTsW4wJSyqMpTCxMiQ4oYcaV88p/JmeC6b0Z07co0
         lvjTcvJcelrWsLRaavoPyi3NXWgL/NFvxrzo2XjRv13S96NS4Nv99m+A3pmSEDC2aVkA
         BruQMO7H9zCLNu8UQtb3MRECjN1vFdGGMeVT9cpe1TaQZUmps5+god0QOY9T9vykq9o4
         vcgE6N8DGlrEP2SwqTI9yl3pD+7Emw+DvV/wCc/G3VlzbPdcNRgU8c+yqduUzJUmonYg
         GeQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786623821; x=1787228621; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/JKr8AMALR7jJTA8PpiKZ4JI/GJ5cmVOG0msAYT0UOs=;
        b=bWSml8L0bqVp+ieSnCgYMkTaVFARej3+YYxNyvFsFSxMJQFFtm12GY6ZbT8vHQvwG6
         ec3r4vWLG88xrcQpByHA6UbcGw7y3J5Fwss/HGmyfFMAxCwrRX4VWNdHttJO9Xpp//Bn
         h9eoAFWofdpmi6U2Zhw5V54bv5UswrmW4VNnXirDVIGf9SFE09jZG02JFuGSAN0UdkI+
         Hu0fL6jy0CI43VbRbUEvrgeFiXeGgo/OVLhvgchU54+HiIhzcAV9pOlDvH7KkuO07O/K
         hoSR2kVYSKK/mjhcyTCroenu1tzBSVPrKIOrHqUxavSxBLNPyMZvttWZWtJnBvs2z/O6
         xKYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786623821; x=1787228621;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/JKr8AMALR7jJTA8PpiKZ4JI/GJ5cmVOG0msAYT0UOs=;
        b=Q0if/YX+ZkDHJbbIx+O68XQKbxFbQeFdHQPMOYx8vhPomt7Q4OevmX4cSn9Fk/ZbsW
         XwwrhVFXnvCeC5KZ+8nAECDoMfq+COT0AGFrXnk3gBE8wiAE9mYnuRxQM9dwUGQdrepL
         O7/w3MXm1B5sCUMYIL0rCFrZ6hvXQvyeJLZzNwvyiepq7w+LLd6hAjhlXrVNOl77PYCy
         NFMFli7KkLkR53YyxkQ0vo5DXHI61EBw5whA1ZjZVNE16wINoWj0RNWMgFOm1TUyZ1n0
         rEf1pozamaLpJm3FzTcHG3+w0hMrhmlW0RyZmyyeVFEIMtJmGEa7EEXLNyXJzQ6Pgnni
         IdbA==
X-Forwarded-Encrypted: i=1; AHgh+Rp4ZGN5fWLu6fIUS7wiFygbCL/R30flfNiZJOpEgFBtpUzdTxCmdRlE9SX1UKnAxzKLkE4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx53eGpi1Gc7Hw3p7HaNugSVa4KPwMGgQKbzBtVlyiiFhwn4w+G
	ue+t/+dqSopNSzXwzKALeFaII7WfVBgnFoXpfHIx59dy8c4Fg+1ujK4vArxuIKsjB4l5Sz7fq+P
	9Y0hsXDuowPwbzC+G1hel6SOpR+fA0sU=
X-Gm-Gg: AR+sD12q86W/4Y90WR7mlUTkbkQ4Olga4kqbxykfgiQ6zD5W0lJwJI82vmyyzrvYGjh
	qsSOSgsMA6wUdJpDidc2g81oFy8jLJgEmTFA6U46Th/KhrfpkV2gUDqJbM9h6rYs//ZeAQpuJVM
	u5dPZBABtDRZLpt6LFX7xm2r+1W62TrCtk+he/XbHuB0z9o+Gny6no3j4kqKE5xb9ywL8GZJeIc
	I0RdQ250zsZrK1wClLwqpqiVhxYicGfk+rM+eHyPjmsMP7EL6/+ueFcKhmVvPXaH64xn08rSUzl
	+3cz02+6m1rDUWreB8lcKOgqpmuDFcqhAnCD5fPcE2DH6HGWfPWAGSENxNMBPJb7viRNOXQ9VBY
	xvwaBfAaQkUux4v15QHM1Q71JodrSEql/e9U=
X-Received: by 2002:a05:6102:94f:b0:74c:9177:35bc with SMTP id
 ada2fe7eead31-76db527e3d4mr1261342137.2.1786623821253; Thu, 13 Aug 2026
 05:23:41 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 13 Aug 2026 05:23:39 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 13 Aug 2026 05:23:39 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260812-pks-odb-eagerly-prepare-alternates-v2-1-522b9a5bc1ea@pks.im>
References: <20260812-pks-odb-eagerly-prepare-alternates-v2-0-522b9a5bc1ea@pks.im>
 <20260812-pks-odb-eagerly-prepare-alternates-v2-1-522b9a5bc1ea@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 13 Aug 2026 05:23:39 -0700
X-Gm-Features: AUfX_mxNmzBAL0adIy6vL14rKYHSR26fFqL35Viooe36qxbIOg3uRdUHbEMpGug
Message-ID: <CAOLa=ZTsumAT6U8+pJQmNjYL6Rt=JkvTJ0V7KQ7MvLYkThTFYA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] odb: decouple source path comparisons from `the_repository`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Content-Type: multipart/mixed; boundary="00000000000036b2910658ecc66f"

--00000000000036b2910658ecc66f
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> When registering alternates we deduplicate object database sources by
> their path so that the same source won't be added twice. Ever since
> cf2dc1c238 (speed up alt_odb_usable() with many alternates, 2021-07-07)
> this duplicate check is backed by a map keyed by the source's path,
> using `fspathhash()` and `fspatheq()` as hash and equality functions,
> respectively.
>
> These functions are problematic in this context for two reasons:
>
>   - They implicitly depend on `the_repository` instead of the
>     repository that owns the object database.
>
>   - They derive case-sensitivity from `repo_ignore_case()`, which
>     returns a default value in case the repository's configuration has
>     not been parsed yet. Object database sources may be registered
>     before that is the case, so the answer may flip depending on when a
>     source gets registered.
>
> Fix this by making the comparison self-contained in the object
> database. Instead of using `fspathhash()` and `fspatheq()` we resolve
> "core.ignoreCase" manually and then use the correct comparison function
> based on the result. This requires us to migrate to a `struct hashmap`,
> as the khash interface does not give us the ability to change these
> functions.
>
> Note that we can unconditionally use `strihash()` to compute entry
> hashes regardless of case sensitivity: a hash function only needs to
> guarantee that equal keys have equal hashes, and a case-insensitive
> hash satisfies this requirement for both case-sensitive and
> case-insensitive equality.
>
> Overall it's quite debatable whether all of this complexity really is
> worth it, or whether we should just linearly search through all sources
> to find duplicates. But the mentioned commit cares about cases with
> thousands of alternates, and a linear search would of course regress
> performance quite a bit. This doesn't really feel like a reasonable case
> to care about though, but I don't feel comfortable regressing it anyway.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  odb.c        | 63 ++++++++++++++++++++++++++++++++++++++++--------------------
>  odb.h        | 15 ++++++++++++++-
>  odb/source.h |  7 +++++++
>  3 files changed, 63 insertions(+), 22 deletions(-)
>
> diff --git a/odb.c b/odb.c
> index bd02d8ad54..51da386f22 100644
> --- a/odb.c
> +++ b/odb.c
> @@ -2,11 +2,10 @@
>  #include "abspath.h"
>  #include "commit-graph.h"
>  #include "config.h"
> -#include "dir.h"
>  #include "environment.h"
>  #include "gettext.h"
> +#include "hashmap.h"
>  #include "hex.h"
> -#include "khash.h"
>  #include "lockfile.h"
>  #include "loose.h"
>  #include "midx.h"
> @@ -29,8 +28,32 @@
>  #include "trace2.h"
>  #include "write-or-die.h"
>
> -KHASH_INIT(odb_path_map, const char * /* key: odb_path */,
> -	struct odb_source *, 1, fspathhash, fspatheq)
> +static int odb_source_paths_cmp(struct object_database *o,
> +				const char *a, const char *b)
> +{
> +	if (o->source_paths_icase < 0) {
> +		int icase = 0;
> +		repo_config_get_bool(o->repo, "core.ignorecase", &icase);
> +		o->source_paths_icase = icase;
> +	}
> +

Nit: couldn't this be simplified to

if (o->source_paths_icase < 0)
   repo_config_get_bool(o->repo, "core.ignorecase", &o->source_paths_icase);

> +	return o->source_paths_icase ? strcasecmp(a, b) : strcmp(a, b);
> +}
> +
> +static int odb_source_by_path_cmp(const void *cb_data,
> +				  const struct hashmap_entry *entry,
> +				  const struct hashmap_entry *entry_or_key,
> +				  const void *keydata)
> +{
> +	struct object_database *o = (struct object_database *)cb_data;
> +	const struct odb_source *source = container_of(entry, const struct odb_source, by_path_entry);
> +	const char *path = keydata;
> +
> +	if (!path)
> +		path = container_of(entry_or_key, const struct odb_source, by_path_entry)->path;
> +
> +	return odb_source_paths_cmp(o, source->path, path);
> +}
>
>  int odb_mkstemp(struct object_database *odb,
>  		struct strbuf *temp_filename, const char *pattern)
> @@ -58,8 +81,8 @@ int odb_mkstemp(struct object_database *odb,
>   */
>  static bool odb_is_source_usable(struct object_database *o, const char *path)
>  {
> -	int r;
>  	struct strbuf normalized_objdir = STRBUF_INIT;
> +	struct hashmap_entry key;
>  	bool usable = false;
>
>  	strbuf_realpath(&normalized_objdir, o->sources->path, 1);
> @@ -76,20 +99,18 @@ static bool odb_is_source_usable(struct object_database *o, const char *path)
>  	 * Prevent the common mistake of listing the same
>  	 * thing twice, or object directory itself.
>  	 */
> -	if (!o->source_by_path) {
> -		khiter_t p;
> -
> -		o->source_by_path = kh_init_odb_path_map();
> +	if (!hashmap_get_size(&o->source_by_path)) {
>  		assert(!o->sources->next);
> -		p = kh_put_odb_path_map(o->source_by_path, o->sources->path, &r);
> -		assert(r == 1); /* never used */
> -		kh_value(o->source_by_path, p) = o->sources;
> +		hashmap_entry_init(&o->sources->by_path_entry,
> +				   strihash(o->sources->path));
> +		hashmap_add(&o->source_by_path, &o->sources->by_path_entry);
>  	}
>
> -	if (fspatheq(path, normalized_objdir.buf))
> +	if (!odb_source_paths_cmp(o, path, normalized_objdir.buf))
>  		goto out;
>
> -	if (kh_get_odb_path_map(o->source_by_path, path) < kh_end(o->source_by_path))
> +	hashmap_entry_init(&key, strihash(path));
> +	if (hashmap_get(&o->source_by_path, &key, path))
>  		goto out;
>
>  	usable = true;
> @@ -172,8 +193,6 @@ static struct odb_source *odb_add_alternate_recursively(struct object_database *
>  {
>  	struct odb_source *alternate = NULL;
>  	struct strvec sources = STRVEC_INIT;
> -	khiter_t pos;
> -	int ret;
>
>  	if (!odb_is_source_usable(odb, source))
>  		goto error;
> @@ -184,10 +203,11 @@ static struct odb_source *odb_add_alternate_recursively(struct object_database *
>  	*odb->sources_tail = alternate;
>  	odb->sources_tail = &(alternate->next);
>
> -	pos = kh_put_odb_path_map(odb->source_by_path, alternate->path, &ret);
> -	if (!ret)
> +	hashmap_entry_init(&alternate->by_path_entry, strihash(alternate->path));
> +	if (hashmap_get(&odb->source_by_path, &alternate->by_path_entry,
> +			alternate->path))
>  		BUG("source must not yet exist");
> -	kh_value(odb->source_by_path, pos) = alternate;
> +	hashmap_add(&odb->source_by_path, &alternate->by_path_entry);
>
>  	/* recursively add alternates */
>  	odb_source_read_alternates(alternate, &sources);
> @@ -1056,6 +1076,8 @@ struct object_database *odb_new(struct repository *repo,
>  	o->repo = repo;
>  	pthread_mutex_init(&o->replace_mutex, NULL);
>  	string_list_init_dup(&o->submodule_source_paths);
> +	hashmap_init(&o->source_by_path, odb_source_by_path_cmp, o, 0);
> +	o->source_paths_icase = -1;
>
>  	if (flags & ODB_NEW_HONOR_ENV) {
>  		primary_source = xstrdup_or_null(getenv(DB_ENVIRONMENT));
> @@ -1094,8 +1116,7 @@ static void odb_free_sources(struct object_database *o)
>  	odb_source_free(o->inmemory_objects);
>  	o->inmemory_objects = NULL;
>
> -	kh_destroy_odb_path_map(o->source_by_path);
> -	o->source_by_path = NULL;
> +	hashmap_clear(&o->source_by_path);
>  }
>
>  void odb_free(struct object_database *o)
> diff --git a/odb.h b/odb.h
> index 8eb4e85d64..71af7450a9 100644
> --- a/odb.h
> +++ b/odb.h
> @@ -1,6 +1,7 @@
>  #ifndef ODB_H
>  #define ODB_H
>
> +#include "hashmap.h"
>  #include "object.h"
>  #include "oidset.h"
>  #include "oidmap.h"
> @@ -54,7 +55,19 @@ struct object_database {
>  	 */
>  	struct odb_source *sources;
>  	struct odb_source **sources_tail;
> -	struct kh_odb_path_map *source_by_path;
> +
> +	/*
> +	 * Map of object database sources, keyed by their respective paths.
> +	 * This map is used to detect the case where the same source is
> +	 * registered multiple times.
> +	 */
> +	struct hashmap source_by_path;
> +
> +	/*
> +	 * Whether source paths shall be compared case-insensitively, as
> +	 * determined by "core.ignoreCase".
> +	 */
> +	int source_paths_icase;
>
>  	int loaded_alternates;
>
> diff --git a/odb/source.h b/odb/source.h
> index 4bc037b8d6..82cda8ad75 100644
> --- a/odb/source.h
> +++ b/odb/source.h
> @@ -1,6 +1,7 @@
>  #ifndef ODB_SOURCE_H
>  #define ODB_SOURCE_H
>
> +#include "hashmap.h"
>  #include "object.h"
>  #include "odb.h"
>  #include "odb/transaction.h"
> @@ -50,6 +51,12 @@ struct strvec;
>  struct odb_source {
>  	struct odb_source *next;
>
> +	/*
> +	 * Entry in the object database's map of sources, keyed by this
> +	 * source's path.
> +	 */
> +	struct hashmap_entry by_path_entry;
> +
>  	/* Object database that owns this object source. */
>  	struct object_database *odb;
>
>
> --
> 2.55.0.679.g6767b8d81c.dirty

Apart from the nit, this patch looks good.

--00000000000036b2910658ecc66f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 13519d6cab70f5a8_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1wOXQwa1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOVhEQy80cTJTVTl3bnlzRTJpZ0h0VVVpTWErdnlNTwp2VU5NcTVoOUth
amdzeFo3Qll2TWpxa0Y4dExzb2p1RmJUdHFqRWRLRWRkbVRUTERVYmJ6ZTZpTEp6VEUrTHI2CkhV
V1pZUW5hc21vZklOS05CRFVpa2ZlR0hrZndBbWY1eXZEeWdJcU9xdTh0Q3FhSHdIVUF6ZTN1eFFi
bGxGUUgKenlmOUpCMlhXQWNuZFgyWUYreDhndjNacDF6R1gyaW9mOCtscHRIdFVpdHFwUE9HRyti
S2xRbDdBVkVvVmRBZQpxb3JBMnlnMnI5WS8xbXVLeHlRK3N2dkFuWnlrZ01vekJxYnNTemdJQjNC
alprbk9RTG5pdnlCaVJnWnNWaWJsCmxQSlZRWm1oUVZCRmZxc2YwVGs5Q1Y4eXBLNE5tOUVkeCta
Q3NlK1p6MnZaSE5yelJhVGhTbHVVWlZtazA3OXkKU2k5N1JjTHpuWjF5dGRoVXVHcUxPMFlPS2dZ
RHlQNW9qU3dRazJtZEJ2c2dESHlUTzlkbnQwRVErOGoyRFRwMQpKamRwT3B2VEM2NEtDNDVPeE5s
U0FFMFYveDdpMTB5UWJjV3Nub1NabkZST2NWNzFBWTZ4NzNTMEd2R0pzWExhClhGSEZnam82K2ph
Qlc2VFFYRHA3cHpYc1BNVXBqV2MzaWkyY3Q1Yz0KPVBKc0MKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000036b2910658ecc66f--
