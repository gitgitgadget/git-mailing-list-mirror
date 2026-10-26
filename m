Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793051378;
	b=PyLMoIA+CXJoWZRnIvWwsyHCKfkgVscQ57I2sXSj4qwS2prlGpIGaw1ebRmBQ1xNm57I
	 1wAMTmN6/kywmPGUBD8emFqmGsO52DcjTpllUZESfapXwnGfMJqPnOzsiHpuqCXiuYEmu
	 nsUn1XDHHbzHKVLoiBlh7eueu1O6Gm53dm4pOXcHXhkOUdo29oUkdvM+7kB9lXZ8sI5Ct
	 +kNT4c17+CermbT6VuR4v8cOz04HJnAmTayJc7Zey5IphBbm8HrOp67LTMVS6USgDUldv
	 93r8Elo5R6AyIDoDQt66NRMzyYnqwFcQOg8GDoezJvm7QEwYUQBSNA7ePhkhrjC9vzw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793051378;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=L7xX+TrrCyRXFi8Zpr5ToPix6l0sZcPVbD9Yc3+5+Sg=;
	b=j1NWEbl7nGSr6sP/zRERWQZjxXYUIUQdNGaokI2JThkQLhS0Yz9EDmjhyCPdGfemtYpZ
	 IR3LjogOP88LMCv3WXwxj//6s7fs+ZARBglF51iY6W9O+glyF8oZsG8L8Qq3ZuA6QJujT
	 i9YdAw5950flhSQb3IkGy9WzhxmGOaV7kbTVlaqc8wHLFYpxx7KcS+VYeRImMcSBza2mQ
	 RbPG/PgB6VSqj2+GZCsI9/It56FXdHR46nN5PWEa4JX87lKCHrbys8ViFRd+kBP4WdaFG
	 gC53td5KHDmMSG9vM+ItrZU241HfBq8fjk7INyRc77X51NM4JIOxPeMdNM6bAiwY7ww==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ch+UlOr0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.169
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794AD606A31A
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 21:49:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 794AD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ch+UlOr0
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5e9528732b4so2837481e0c.0
        for <git@vger.kernel.org>; Mon, 26 Oct 2026 14:49:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793051377; cv=none;
        d=google.com; s=arc-20260327;
        b=KubrKVGAU8JdL+7uhYgNhFYvF1Hr0P/IFgII/0ot5tXcAPEaxIqx9l6XqMPpEOhSh2
         Vgv3tjxc9zRiIuuoIPx8dUv9SzscU3YyeIwur+vfXI9Qs0NNi+SrnkQERkowXBoM3LIK
         suPlpROmddSWoqa06BAo0cdBuii9JhYcJ/9RSzVmgXB2F9FVD+gu46AEMkR6993JkPWf
         FIivctLLJCVZayNURCng9l8bbHVv1VJ6Ehw80ZKBunzRBiSh1pGTJ4ibKbklECCC+7ut
         jBbimGzyndLN7OfyrHv8HAeTzPDvTviolWPa5D1KU+3XTQmoyCVEgM+8fGkBs87FQ24h
         NtVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=L7xX+TrrCyRXFi8Zpr5ToPix6l0sZcPVbD9Yc3+5+Sg=;
        fh=L3kqcJJ81BCbtprRDAWJP33THPvB9hDQA3onp92Giz4=;
        b=oMKbjlyevUgi6eunPPMXp5ft/6fyxTlK2sFulnY5jql/BsuvZ+h06Pgg/jPY1TmJYY
         petJEiSzvVB3hhGCyYP6q4/e4C8SHU72pH5b+EyxW8WgT+gncLg7yIrq84LE3HFPYST6
         sfPFUSLe28x2zy539nsUROZYj0WsuSciySGUWvy4yvpeyw97q1n8jCj+CYFQQYMsSk9D
         mbYoJJYV3o5ur4gFmnchPKOhHsAcO69ZNrBtYSkZ78iPe9QCIi7MiF1AeWt0XXFVCH6X
         2lSz4FzdXiuy8SMzG2ZxoWhVeooedqB17Falla+4jW9b9PQO34A2nc5GSV3bp3De4QEl
         jbWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793051377; x=1793656177; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L7xX+TrrCyRXFi8Zpr5ToPix6l0sZcPVbD9Yc3+5+Sg=;
        b=Ch+UlOr0HKnQUQ5M3nADPat7H2nxc+ebvAC6eJDXAydWDtK+ROmsIwfnPpxrTaQn2f
         N98mq05+4GhD9We3vg8hiDWB3XNDMBwP4oHFEUeLJbdDE6OX/rS7vWSbQz9vIP6zhgPV
         fseJsb7o3XcFcH8kGRm/f/FerGBs/iOM0E7xLjd5K7TUn96NxbHnFBkaEJ5FBnRuxYFx
         a1B5N/pttoOi0Hc81avuGmbJu28ODk/DN8fqV2UaJbkjKLKhw2XrvZGMIcJzG/vdXomI
         yGWiQoE8v7MmHtBVDEP5YeItHymRVNNFXHBPD25X4ZuFaaiVOyjKzlJzi+qnkNZH3/DD
         mjwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793051377; x=1793656177;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L7xX+TrrCyRXFi8Zpr5ToPix6l0sZcPVbD9Yc3+5+Sg=;
        b=ITP3CE11Sbv+cA9B1MGt8nqMiYxEIAyyuq9is4caUYkg8pLeHIdSuH+Mobt+rku1Zm
         GC3xeokBQe2gEBq7t6cGqWbGRSc4QzeVH4whCynPABhul61MtAcoLigR107dRg2Qjt/d
         +sCu03B/jf9jqshcrh1jlsZ8HuPvsmRZ8NVoZfoEZkq1KjwzmIilrP4dfPA2OppL0Rjm
         DqGXJ8NF5d0gNdMgfxBqG5yunDwcbpA8k1e0VuoAyXOhXVXVu725KS+tLm1FqRqCoPAf
         K79+zsQHyrcaqrpFR5NYPlcI3RTlDqjBKmw6Wm7uMLrR6PnYF1TKlH6v0wMLRrmgVRqm
         0xqw==
X-Forwarded-Encrypted: i=1; AKwUvBy5VP/UOh8bOqKj+ERNVwciHgBjWVCZtQf6p801tLIIYRLcjCKFxXpesAsxVYpRLJ/UEKU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKgXdziDCF1l28NywLwTWdbbtZivFyw0zHAJKcOXDki1QFozLC1
	prNmB1zITwyfz5pmoFKua6p6hR4AYSboj7nnlwUvOypJAMpmyDvnya8t5IO6DWRY4wM8Ueogyum
	9LISPTziPIxegioQFFvXDrz+nX/lSzCo=
X-Gm-Gg: AYBFou1T4Ylue7b7Ai8BtLzH6GxyLwU7UEHG5P2tr4sTbaZLp1DYTHN16kuzNZorPqf
	E08D1pNS6WeqFOfGkB9QbDjrfKfKvLuxuXgM/JlfLwsIl4iLds1OJwN1sy7pwDgCW3JiXroEFyv
	LblaytGPKZ+7RbEOunHYQfbsIBrrtOAnmhwVo6WmGBk75u/1ePIU3Ibdqyj6Z/GQycifKjFrBQU
	xfC8n4LxzLtbGSaBoKKwEvBkujAEDuRno2gT3xuv4a3pXAGh3zpGhhJs6YR+1Q0rDB02u7rGM08
	1tgv5Ut7/FnRW/WKIylBZPrUWB0pKp7MnZwGTbB1s1wUDZbca1HA24sfLnli1YMnab8fH4bSpnI
	InHhhWBb5IYGPkK+yVPyMUHMRMtlk7+QvC32O5LkY6bdvbKMEo6W6z0hEKC8QFGwlklbUlHlkqm
	lWugvI23bYKrB2AF9Pbb3T0mh2bjY=
X-Received: by 2002:a05:6122:488f:b0:5c9:c60e:3a48 with SMTP id
 71dfb90a1353d-5ec233125d7mr3577411e0c.20.1793051377304; Mon, 26 Oct 2026
 14:49:37 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Oct 2026 14:49:36 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Oct 2026 14:49:36 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20261021182528.3055494-5-jltobler@gmail.com>
References: <20261020132900.1208343-1-jltobler@gmail.com> <20261021182528.3055494-1-jltobler@gmail.com>
 <20261021182528.3055494-5-jltobler@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Mon, 26 Oct 2026 14:49:36 -0700
X-Gm-Features: AclHuK9lIqIymsYaLmtP_xDCw8cRw7-ziyRsxKWnK8R95uvAWj_SLeeUX2hfLy4
Message-ID: <CAOLa=ZTDm25XDambq4ohmeURaBuE29EwS6ORhHc6PDVaKyGWRA@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] object-file: write ".keep" lockfiles during
 transaction commit
To: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org
Cc: ps@pks.im, Qin ShiCheng <qeesung@live.com>
Content-Type: multipart/mixed; boundary="00000000000068a6a3065ec54e00"

--00000000000068a6a3065ec54e00
Content-Type: text/plain; charset="UTF-8"

Justin Tobler <jltobler@gmail.com> writes:

> The "files" ODB backend writes a ".keep" lockfile into the transaction
> quarantine directory via `odb_transaction_files_write_pack()`. When the
> ODB transaction is committed, the ".keep" lockfile is migrated to the
> primary ODB alongside its packfile. Writing the temporary lockfile in
> this manner has a couple of downsides:
>
>   - Migrating quarantined objects via `tmp_objdir_migrate()` doesn't
>     immediately stop if a ".keep" lockfile already exists for the same
>     packfile in the primary ODB and instead allows all the remaining
>     objects to be migrated. So even though `odb_transaction_commit()`
>     ultimately returns an error here, the objects are needlessly written
>     to the primary ODB anyways.
>
>   - Even more concerning, the ".keep" tempfile atexit(3) handler tries
>     to remove any lockfile of the same name regardless of whether it was
>     created by the same process. If the ".keep" lockfile of the same
>     name for a concurrent process gets deleted prematurely, its packfile
>     becomes at risk of being deleted by concurrent housekeeping.
>
> Stop creating/registering the temporary lockfiles when writing the
> packfile to the transaction and instead do so when committing the
> transaction. This ensures the lockfile is properly acquired prior to
> migrating objects and that only the owning process can delete its own
> lockfiles.
>

So to reiterate, the old method was to ask index-pack to also write the
'.keep' file in the quarantine directory. Post that, all the files in
the directory were moved to the canonical location.

Now, we handle '.keep' file creation directly. Nit: There is a logical
jump from the last-1 sentence to the last sentence. How does moving the
lockfile creation to the commit phase solve these issues?

> Reported-by: Qin ShiCheng <qeesung@live.com>
> Signed-off-by: Justin Tobler <jltobler@gmail.com>
> ---
>  object-file.c              | 76 +++++++++++++++++++++-----------------
>  t/t5547-push-quarantine.sh | 30 +++++++++++++--
>  2 files changed, 70 insertions(+), 36 deletions(-)
>
> diff --git a/object-file.c b/object-file.c
> index 74a31760bc..e67c0865a2 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -492,6 +492,7 @@ struct odb_transaction_files {
>  	struct transaction_packfile packfile;
>  	const char *prefix;
>
> +	struct strvec pack_names;
>  	struct tempfile **pack_lockfiles;
>  	size_t pack_lockfiles_nr;
>  	size_t pack_lockfiles_alloc;
> @@ -1257,7 +1258,7 @@ int read_loose_object(struct repository *repo,
>  }
>
>  static int write_pack_lockfile(struct odb_source *source, const char *pack_name,
> -			       const char *keep_msg)
> +			       const char *keep_msg, struct tempfile **out)
>  {
>  	struct strbuf lock_path = STRBUF_INIT;
>  	struct strbuf contents = STRBUF_INIT;
> @@ -1288,6 +1289,7 @@ static int write_pack_lockfile(struct odb_source *source, const char *pack_name,
>  		goto out;
>  	}
>
> +	*out = register_tempfile(lock_path.buf);
>  	ret = 0;
>
>  out:
> @@ -1297,6 +1299,40 @@ static int write_pack_lockfile(struct odb_source *source, const char *pack_name,
>  	return ret;
>  }
>
> +static int write_pack_lockfiles(struct odb_transaction_files *transaction)
> +{
> +	struct strbuf keep_msg = STRBUF_INIT;
> +	char hostname[HOST_NAME_MAX + 1];
> +	int ret = 0;
> +
> +	if (!transaction->pack_names.nr)
> +		return 0;
> +
> +	if (xgethostname(hostname, sizeof(hostname)))
> +		xsnprintf(hostname, sizeof(hostname), "localhost");
> +	strbuf_addf(&keep_msg, "receive-pack %"PRIuMAX" on %s",
> +		    (uintmax_t)getpid(), hostname);
> +
> +	for (size_t i = 0; i < transaction->pack_names.nr; i++) {
> +		struct tempfile *lock;
> +
> +		ret = write_pack_lockfile(transaction->base.source,
> +					  transaction->pack_names.v[i],
> +					  keep_msg.buf, &lock);
> +		if (ret < 0)
> +			break;
> +
> +		ALLOC_GROW(transaction->pack_lockfiles,
> +			   transaction->pack_lockfiles_nr + 1,
> +			   transaction->pack_lockfiles_alloc);
> +		transaction->pack_lockfiles[transaction->pack_lockfiles_nr++] = lock;
> +	}
> +
> +	strbuf_release(&keep_msg);
> +
> +	return ret;
> +}
>

Okay so this function handles the lockfile creation for each of the
packs. Looks good.

[snip]

> @@ -1434,14 +1471,9 @@ static int odb_transaction_files_write_pack(struct odb_transaction *base,
>  			return -1;
>  		}
>  	} else {
> -		char hostname[HOST_NAME_MAX + 1];
> -
>  		strvec_pushl(&child.args, "index-pack", "--stdin", NULL);
>  		push_header_arg(&child.args, &hdr);
>
> -		if (xgethostname(hostname, sizeof(hostname)))
> -			xsnprintf(hostname, sizeof(hostname), "localhost");
> -
>  		if (!opts->quiet && err_fd)
>  			strvec_push(&child.args, "--show-resolving-progress");
>  		if (err_fd)
> @@ -1479,29 +1511,7 @@ static int odb_transaction_files_write_pack(struct odb_transaction *base,
>  			goto out;
>  		}
>
> -		strbuf_addf(&keep_msg, "receive-pack %"PRIuMAX" on %s",
> -			    (uintmax_t)getpid(), hostname);
> -
> -		if (write_pack_lockfile(transaction->quarantine, pack_name.buf,
> -					keep_msg.buf)) {
> -			strbuf_addstr(err_msg, "lockfile write failed");
> -			goto out;
> -		}
> -
> -		ALLOC_GROW(transaction->pack_lockfiles,
> -			   transaction->pack_lockfiles_nr + 1,
> -			   transaction->pack_lockfiles_alloc);
> -
> -		/*
> -		 * The lockfile filepath is expected to be the final location of
> -		 * the ".keep" file after being migrated to the main ODB source.
> -		 * This ensures the lockfile can be found and removed later
> -		 * after the ODB transaction has been committed.
> -		 */
> -		strbuf_addf(&final_path, "%s/pack/pack-%s.keep",
> -			    base->source->path, pack_name.buf);
> -		transaction->pack_lockfiles[transaction->pack_lockfiles_nr++] =
> -			register_tempfile(final_path.buf);
> +		strvec_push(&transaction->pack_names, pack_name.buf);
>
>  		odb_source_prepare(transaction->quarantine,
>  				   ODB_PREPARE_FLUSH_CACHES);
> @@ -1510,9 +1520,7 @@ static int odb_transaction_files_write_pack(struct odb_transaction *base,
>  	ret = 0;
>
>  out:
> -	strbuf_release(&final_path);
>  	strbuf_release(&pack_name);
> -	strbuf_release(&keep_msg);
>
>  	return ret;
>  }
>

So writing the individual pack no longer is concerned about also writing
the keep file. Makes sense.

[snip]

--00000000000068a6a3065ec54e00
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 395839c2143ab769_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1yZnl1c1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mK2ZJQy85UHd0Mkp6ZzRtakdISTVxS2NxY09EMFFRaApVMkdBZTRpZ1ZF
VDJiRTlRREZabVNLL1hMcHl4OWYrVEVHMTBIeTM2cldLQlh5ZGgxdHEzTHNadk5VSFNkQ0FsClp3
bFZlekwvdW00dDlrbERBNFcxSXl1RUo0a2h2bEFmenFqcG44Z0hpOFVJK0x3SVNFUGQwQWt4TVFX
U3ZNV24KdG1PS202R3BmOXI2V2w4alRvZjBaYWRadTVvek1SQlVPbXVDc2xJSU1VWHltMTE5OU1L
dlAwL0ZROEcvUjZGZAoySFl0U2hXbDcxbFN2UjdJZmQ0V1V1VXozd3E4UW4xbVhIb0szVHl4Znp4
anhYMEkxZXRrR1BEYURSUmFCVDZPCngrczJISGdpZ3pjRGh0MmlZMWtpRlR2OHcxenpOV3hoT2VE
bTcveGtJYTNWa0I3VVZBNUhKVXdnRW9OZVZMKzcKSFZ2TlMrQ0JRRUFtYzZEQTQrUXEwbUR2TDZT
THRVRytpczZOMnowOUhBQkJkRldJbERzL3RoU0J0ZWVqYjZRbApNczNrOWR3a2xsalVvZWdZUWU2
WXZIVkZiQWtOZVo1aHJINmNzeWdpTjFRcVFkcG93eE91WW84YlBORWxFSytwCis2bVF2ejM0UlVU
bmp3UnRYUTZEMy9xQnZ0YzRma3lDOTRHUENkbz0KPU8yRVgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000068a6a3065ec54e00--
