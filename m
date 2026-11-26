Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795707055;
	b=ALyK75quk0N2Bsr3RmxsswHHQKD/vxR2iF4in8hT6YeEz+NxprtAdngmiX5Zus8dYfIS
	 fHV5XbxDVfW/iB6J4siXA2EFdpxJOm55151nKZGmPhrOgEq0hbiYuSho5LdS0WwkDMuHU
	 17FhzzCUhdEgH77iiHtbrbQwMtpBg79e14wB/Ohyrw0oB1k/MS4SQpYh28/p2r4N4r+wP
	 htz1DCRCOi+Ic6h4gzI/7Mj6ynS2/5VC7y+79QNo7nt1sL3AZr7L03kzrhUiUFJ+uzKlx
	 L2rltha52OYAjdfrNy45ZWYGIJQqNXtsFbB31e9vRg4ytZGdVmkMSTt4D1eXOJsc8Yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795707055;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=hVUVK41AgN/c5MU6ccIJXqXA7B6+WkAgkEC8dHC9VrE=;
	b=z7n5v6mzzjEW5Zx3i15Iu2hZeLrG3DvtC6CFmg/FgpmpraH/uu0fRlDXMA4kiuzLkWS4
	 dGiemP+h2qr4NJW2wwfGqtp8IhEKLQVgiae7YBkCecUX3DpQvH+jkQ7NaRrEhnCfAHpJs
	 1IOQ1cj0k0EvoCTib5iJFLMsRr4NR2JwZ2w1QAXhyJBH+3JslOdbQ0NxC/qUT69WZCjnq
	 N8X7pK4m5LlQ8jQ2ETNnf/wXUJxm4pMJSzXhdAqTHpM1wbAE6CzGJFtjcWhbMSgKhSzML
	 wJSZwwqmZISz9muNmCkFG13YT0uqoN0vGc33eYrrcLFcWmipyhLbatlFhRUpQxe46EA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kpW6EFsI;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69490606A31C
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 15:30:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69490606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kpW6EFsI
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3ae7626d14aso3548376a91.2
        for <git@vger.kernel.org>; Thu, 26 Nov 2026 07:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795707055; x=1796311855; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hVUVK41AgN/c5MU6ccIJXqXA7B6+WkAgkEC8dHC9VrE=;
        b=kpW6EFsIVKsCRkTVyQxzKGLdhKp33oPrXCoqOxNayvvtJFpUejaBKQV5Bl81yxksVB
         neIog9cA85itqJLpHtvUzDzJ0lXRaTPVveM8OadOgE0oijjMFhWOXicJtea1+Csi5nDt
         6bcP+1MqYmMppRBFHjX4aXcQ4ghbvwFYwTFLgbKafVhbKh0mBISmMZMYfDRAyUUQul7u
         AHUB+3nu++3wMhwz6Mhrz3Mtdh5yBkRttuGCj2ibn05/xsLKyFbonD1dvA16gd6sCNno
         q0Atk6SeZ5YL4NGimUVmx2S4oQbe68qUpfJnzgHLmW1lhVylnhhR7aHu2lXnT548Egir
         BSiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795707055; x=1796311855;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hVUVK41AgN/c5MU6ccIJXqXA7B6+WkAgkEC8dHC9VrE=;
        b=IYNPMHXWIu5jyYbx0BdysdF2nm++gKzPCKwT744YmNBngt7E07rGpkqBizv6EPuq15
         lW1jvH3/RseJjD25JNPmQNorIEP3i/h2t6wi1kUjefCQlGbX2BtffdF6ov5q0kFaQ24w
         UW/a+e0a8RIg77kSupUZAbWPP8OkNuNUKPdjSpdPunU6JQZz/BBuxOcc2eIKcRZ6gsXU
         pH2I3I1bIHYcdktvzCJx0DwOK0/1VBLhoOcdNLHDTeNuKhUnjment7Fs8wJga6g/owWJ
         mlFWUrvD/xh6xwBu+eRtiLn2g+FO8iin+/WuLLjgAsDkY7tkHRL6FJu/bS0GWtyyYisH
         FRVw==
X-Forwarded-Encrypted: i=1; AL+hErH5I5c7ghHbyo6I2XJYBiqfWrUSVI/TAf08qLMNHzyHr3LF5Wpudp9xayjAX5t6jaAgFCQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+t9WxQXTnqg7KdyG5NzPwhLdZwIVUpa7gJFc0TP6UfWF92mQvj
	5jb+1rEuv4X30XN5aFz1l2HdXfSdNIpY234u3iAZSNPBfSZ5s/nQBQhN
X-Gm-Gg: AZFdTZdxUuGTLsV9JL/K7Efv8HbjfnPGc1vQWK2gUrE1TG/74xyoXaDO4TxK7YZMs2J
	SLCbKh+4QtGqDKNFxjvxiZs3U6b3nOXFqTiQOOjQxzc4+tcuYZOlCbTQm7j+7PkTGoCBpvbniMX
	QL6hmHuXNaBfGCrxH9P+fwOZ6ErBtB0OXpBrh3PeI3rVOF47TAyLWfZx5sQfpm5WycyF8Rvm8Cz
	9K2Asv6E1EZ6u2Wf3pGChgC9Q9SWE7r0jxTRcKVUgGuHZpiM8WpziBA3KSOP0CMCMhK1YqlwI4/
	1G6Jsn1T9C8yShWJCml8DH4oETdfDedgmuC8q23K3eoK0IBr27KrgimzssF76kf0ePV381V978y
	gRwW41jE3NQGqF55TdcYHVoC4BZhhRt3pVjFzGiHSdKElRKhsJvlyWC7MfnWsdolJH1ds7Mul5H
	0V5IpxZj9jdLG8V7SX+Bz4HawoW0frsy08Gnm9DLiNrRB9y4n/NG1PROzbFGi30rilgWuiD6cKx
	2dhup01pyMCQ2bsnITaTcqDMih/JzzHAmGDbDKJE5V7kaeaEz9XWxzWIHACBIvx1EvwlL7+KZuG
	wiYCl7QAF86D9uqKnoDKzErqE9ZrnQycVKpnVrbczhLO
X-Received: by 2002:a17:90b:2f8f:b0:3b3:b0f4:1bf7 with SMTP id 98e67ed59e1d1-3b41c8d460emr21049812a91.23.1795707054557;
        Thu, 26 Nov 2026 07:30:54 -0800 (PST)
Received: from [192.168.25.219] ([115.108.41.154])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41aab4729sm32945077a91.0.2026.11.26.07.30.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 07:30:54 -0800 (PST)
Message-ID: <178121e9-dd6a-4193-9f3b-d81754a6d448@gmail.com>
Date: Thu, 26 Nov 2026 21:00:49 +0530
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/13] odb: implement interoperability functions
To: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
 "brian m . carlson" <sandals@crustytoothpaste.net>,
 Patrick Steinhardt <ps@pks.im>, Elijah Newren <newren@gmail.com>,
 Jeff King <peff@peff.net>, Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20261023072559.3204273-1-christian.couder@gmail.com>
 <20261023072559.3204273-5-christian.couder@gmail.com>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <20261023072559.3204273-5-christian.couder@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I noticed a few issues in this patch which I'm sharing here.

On 10/23/26 12:55, Christian Couder wrote:
 >
> diff --git a/odb.h b/odb.h
> index 0ccc47ee73..70af2c7c78 100644
> --- a/odb.h
> +++ b/odb.h
> @@ -2,6 +2,7 @@
>   #define ODB_H
>   
>   #include "hashmap.h"
> +#include "loose.h"

This looks weird. I suppose this is creating a dependency on the 
specific loose backend just to pull in the value of OBJ_MAP_WRITE. It 
doesn't seem sensible to me.

> [... snip ...]
> +
> +enum odb_write_oid_map_flags {
> +	/*
> +	 * Serialize this data to disk instead of persisting it only in memory.
> +	 */
> +	ODB_WRITE_OID_MAP_WRITE = OBJ_MAP_WRITE,
> +};
> +

Could we turn this into something like:

   ODB_WRITE_OID_MAP_WRITE = (1 << 0).

... and make loose backend derive its value from this one as it needs?

> diff --git a/odb/source-files.c b/odb/source-files.c
> index 455f409db0..4f4f7f1f87 100644
> --- a/odb/source-files.c
> +++ b/odb/source-files.c
> @@ -6,6 +6,7 @@
>   #include "gettext.h"
>   #include "hex.h"
>   #include "lockfile.h"
> +#include "loose.h"

I guess this is not necessary actually. <Can we drop it?

>   #include "object-file.h"
>   #include "odb.h"
>   #include "odb/source.h"
> @@ -1234,6 +1235,41 @@ struct odb_files_dir *odb_source_files_find_dir(struct object_database *odb, con
>   	return dir;
>   }
>   
> +static int odb_source_files_map_oid(struct odb_source *source,
> +				    const struct object_id *src,
> +				    const struct git_hash_algo *to,
> +				    struct object_id *dest,
> +				    enum odb_map_oid_flags flags)
> +{
> +	struct odb_source_files *files = odb_source_files_downcast(source);
> +
> +	for (struct odb_files_dir *dir = files->dirs; dir; dir = dir->next) {
> +		int ret;
> +
> +		ret = odb_source_map_oid(&dir->loose->base, src, to, dest, flags);
> +		if (ret != -1)
> +			return ret;
> +		ret = odb_source_map_oid(&dir->packed->base, src, to, dest, flags);
> +		if (ret != -1)
> +			return ret;
> +		ret = odb_source_map_oid(&dir->loose->base, src, to, dest,
> +					 flags | ODB_MAP_OID_RELOAD);

This reloading the map per directory seems like a change in behaviour 
when we take the next patch into account. Previously, we reloaded after 
looking up every directory once. Is this change intentional?

Also, there's another problem. If the caller passes ODB_MAP_OID_RELOAD 
themsevles, the first loose lookup reloads, and then the third reloads 
again.

> +		if (ret != -1)
> +			return ret;
> +	}
> +
> +	return -1;
> +}
> +
> +static inline int odb_source_files_write_oid_map(struct odb_source *source,
> +						 const struct object_id *oid,
> +						 const struct object_id *compat_oid,
> +						 enum odb_write_oid_map_flags flags)
> +{

Nit: static inline does nothing on a function whose only use is having 
its address stored in a vtable. That applies to the files, loose and 
packed write callbacks. The map callbacks right next to them are plain 
static, so make these match.

> diff --git a/odb/source-packed.c b/odb/source-packed.c
> index 2226fbd313..ee1edfdb2b 100644
> --- a/odb/source-packed.c
> +++ b/odb/source-packed.c
> @@ -863,6 +863,23 @@ static void odb_source_packed_close(struct odb_source *source)
>   	packed->midx = NULL;
>   }
>   
> +static int odb_source_packed_map_oid(struct odb_source *source UNUSED,
> +				     const struct object_id *src UNUSED,
> +				     const struct git_hash_algo *to UNUSED,
> +				     struct object_id *dest UNUSED,
> +				     enum odb_map_oid_flags flags UNUSED)
> +{
> +	return -1;
> +}
> +
> +static inline int odb_source_packed_write_oid_map(struct odb_source *source UNUSED,
> +						  const struct object_id *oid UNUSED,
> +						  const struct object_id *compat_oid UNUSED,
> +						  enum odb_write_oid_map_flags flags UNUSED)
> +{
> +	return -1;

The commit message says packed sources "don't write any information", 
meaning the write is deliberately a no-op. Returning -1 means "error" by 
the contract in odb/source.h. Nothing reaches it today, because the 
files backend only writes to the loose source. Still, it should either 
return 0 or carry a BUG()/comment saying it must not be called.

> diff --git a/odb/source.h b/odb/source.h
> index 1867347dfc..e1f01359ce 100644
> --- a/odb/source.h
> +++ b/odb/source.h
> @@ -300,6 +300,42 @@ struct odb_source {
>   	 */
>   	int (*fsck)(struct odb_source *source,
>   		    struct odb_fsck_options *options);
> +
> +	/*
> +	 * This callback is expected to provide the mapping of an object from
> +	 * the algorithm specified in src to the algorithm specified in to,
> +	 * leaving the result in dest.  flags is a combination of `enum
> +	 * odb_map_oid_flags` values: with ODB_MAP_OID_RELOAD, the source should
> +	 * reload its mapping data before the lookup, as another process may
> +	 * have written new mappings in the meantime.
> +	 *
> +	 * The algo field in src must point to a valid algorithm (specifically,
> +	 * it must not be zero).  to must likewise point to a valid algorithm;
> +	 * it must be non-NULL.
> +	 *

Nit: algo is an index, not a pointer. "must be set to a valid algorithm" 
would be accurate.

> +	 * The callback is expected to return 0 on success, -1 if the object is
> +	 * not found, and a different negative error code on error.
> +	 */
> +	int (*map_oid)(struct odb_source *source, const struct object_id *src,
> +		       const struct git_hash_algo *to, struct object_id *dest,
> +		       enum odb_map_oid_flags flags);
> +
 > [ ... snip ... ]
 >
> +static inline int odb_source_map_oid(struct odb_source *source,
> +				    const struct object_id *src,
> +				    const struct git_hash_algo *to,
> +				    struct object_id *dest,
> +				    int flags)> +
> ... 
> +static inline int odb_source_write_oid_map(struct odb_source *source,
> +					   const struct object_id *oid,
> +					   const struct object_id *compat_oid,
> +					   int flags)

Nit: both new wrappers in odb/source.h take int flags. The callbacks 
they call take the enum, and so does every other wrapper in that file, 
like count_objects and write_object. Use the enum types here too.

-- 
Sivaraam

