Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793029483;
	b=xxJrxOOdo2oAxMQySg3AfIMKi50DhEqjAUgOifsVetQk7BGif2CNR2dduEEeycrg2AnW
	 4EZ+3Nmee0GfqfimFHpxO6+3YMxS7XgAlpbT2jIOMW+fI5akMiUrBXlTs/rjbV/0JJYtM
	 ToM5slfFm6SUpS48WxkkfMwBe8QESXv8yTGColkQGiPSpQKoK5q7LldUSUtxI6a9zepjl
	 ksWAot5PWjcvhqzFD31tuPbUEDkMiCyjuiTLQR0aqtIaa2VqCIIdjy45YxUj1aeP9Bmh8
	 0nfb8meCfXhqOqYk0VrmKjjuEZw7Pa5TdgJ/BnRHNWvguO5Wk9G0hDVcqRsOtYPpM1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793029483;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=GpQ81czZDk0br1AVhto2WkP+jqUIUNjB2eT+qPRkCJo=;
	b=Uu+FrOW9tZyBkmVoHDD+4qLOStzcL2hpj0SKGXrKNn5nuuPVSBjIWKr7vS6UWQrJqh3s
	 GcX9YmnwgcmxbWngUxbABKexT4GIztm4nd/e+F1enzr90ia0cNGpjGGBSlMo53ePVJpDJ
	 B0Lnjmims/dNKPnRYSlwdsnmd2GAKVsZjsl2luk/9uHI1qOG/46w2j97IJm+KJ/4AfHZi
	 ZRA14B/mWbfOwBXSyyIkvS0mypnXlGswJvpD7PxT8y7uhxKkyimxHigorTqPR9NoQEUx5
	 OMyGB9nQY2qPjrKE1uRFnyLKU9q5Oassfw+KMoLKBkikkgolHZTKgYL1KB/48nR2Q3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WWe2+Tvx;
	arc=none smtp.remote-ip=209.85.210.54
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40D5606A31B
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 15:44:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D40D5606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WWe2+Tvx
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-823b938464fso2335458a34.2
        for <git@vger.kernel.org>; Mon, 26 Oct 2026 08:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793029482; x=1793634282; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GpQ81czZDk0br1AVhto2WkP+jqUIUNjB2eT+qPRkCJo=;
        b=WWe2+TvxkE/OZ1kiKuNT+CmE9ZH3pWVUVGuJ9sEk1PsQHhK8K3L+aSYyf7Zl2Ypsa+
         6IgfhJAW8zf8aUsUkf0+39EKW02DzlGYV1/Sh5xym6emBoD2iuE4Aep5dHvZk4635Ok7
         1dsUBiF5Ki0dilDAgCaSFeZg3fF83EkSIuia9zaY3345lkdGpcpA23OglRc7PcuySOob
         /9O6plxFA99Y6AS4BzOftrp2qINAxA1t2Bn6a1vKtylAsFhjnQJLK7tg/zXXtl6fOJd1
         3KQTqaY+Y7hmJP/vW4NtjplRDiSxFt4rsilMB94Lzm9HrBTgRBzyU+z73nz84+3a0+6P
         rpdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793029482; x=1793634282;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GpQ81czZDk0br1AVhto2WkP+jqUIUNjB2eT+qPRkCJo=;
        b=D0eth1rpi+M5AVkxdhiBdUh3YJP+0nlPSEL0yh1xD9k/qcHmXtQGTAHqWwApPWBTEd
         Jf/FUG+e4Vi8b60f3/TQwJMN+ku4Zxr/GNwBQMDHdPpLTMl96X8t0ACoPT/59g5bCvuN
         8pPjMbDiY6ksalM3293JeWkj6SPw+iJlcJu3edFxGGxXH4iD1L28wla8bouPG5ju8UIT
         oFKKAKPTFHC9hM+LMYTOD1wTlFkRMXBS6p21B8dyQ628gMvii4eDr0woaG1QeqOBlV1x
         W/MU+d20ybM+9azRexZs2RkBGdJwCccEMrzXHufZVCAZOSVrBiVdpmkuO7n/15iAaCT5
         H3jQ==
X-Gm-Message-State: AFq9FYIA2bgneIPfvG811TiPvkauPWn9M4d3csJpQQwllgRCpLDNoZhY
	Mkk2+GCA4v65C8YUJudxOpUpVg1GcQz7LSaZe4RNlGIdejGBe0YIf4ez
X-Gm-Gg: AYBFou3jJv985DKngPpc15+wA80goJG9y9JAGm24yPKGZo3uNmDZkE3MpNo0hYiqtK/
	Dd2gFpxlya016/AI9c76ZRc6QO20K981Gdi61LU6eH2UTkHtqM0V1qiDiBOz0MRzGnha+pCHE8D
	vHLXlSNb5i3w4kxm6ABGJniVxgywAxLVpkHeZc91YZnQDcBdkGfCr3TauHu/yRTzKz15FCHQC0Z
	O+Ie2GB7JbjjcK/ytmbmVUnpqSif5yyxkPW35vh4ieYDsfe4Hq8JP74BfyC78hnL9sQeF5lVvNx
	7TPrkyS8owJFEqCLwHMZuuBCf1k5OitnEm3hFZsMzIzX60+ZK5Sc5Awc6873g8MvXjmhH93y5VD
	nKrf6hbINEJplJhHClWpvlEz45x2WRXlEOahYlXvy5K2FXbRyQyD/2DtTg2inTOIM9e/Gl2HEjy
	xG/4HXzeiXfTiQFqhQ3xg99ke5KV1gVhGKfnhFtz8EYhSUyg3woc8n9e7aFRfouJkHZc28pqBkP
	QJ9nK7DqotoRaFoc6HXiNoZRE7Vt1Dy6YY8v1GHq/wK+Dkj9V7dE/PBB8sfGGhxhevmL9phEpQF
	YKhI
X-Received: by 2002:a05:6830:640e:b0:81b:ac5b:ea17 with SMTP id 46e09a7af769-850fedbbf50mr5936753a34.16.1793029480648;
        Mon, 26 Oct 2026 08:44:40 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-850fa99ccfbsm8240887a34.5.2026.10.26.08.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 08:44:40 -0700 (PDT)
Date: Mon, 26 Oct 2026 10:44:35 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im
Subject: Re: [PATCH v4 1/4] pack-write: make index-pack output comment hash
 agnostic
Message-ID: <at9v9p64l72xFEi8@denethor>
References: <20261020132900.1208343-1-jltobler@gmail.com>
 <20261021182528.3055494-1-jltobler@gmail.com>
 <20261021182528.3055494-2-jltobler@gmail.com>
 <CAOLa=ZTnEJDPB6_fdFQFcM=zV21HEZ4gzzhWqB=A_euSzUut_w@mail.gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZTnEJDPB6_fdFQFcM=zV21HEZ4gzzhWqB=A_euSzUut_w@mail.gmail.com>

On 26/10/26 08:01AM, Karthik Nayak wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
> >  	/*
> > -	 * The first thing we expect from index-pack's output
> > -	 * is "pack\t%40s\n" or "keep\t%40s\n" (46 bytes) where
> > -	 * %40s is the newly created pack SHA1 name.  In the "keep"
> > -	 * case, we need it to remove the corresponding .keep file
> > -	 * later on.  If we don't get that then tough luck with it.
> > +	 * The first thing we expect from index-pack's output is
> > +	 * "pack\t<name>\n" or "keep\t<name>\n", where <name> is the hexadecimal
> > +	 * name of the packfile it has just written. The line is therefore five
> > +	 * bytes of prefix, `hexsz` bytes of name, and a trailing newline. A
> > +	 * "keep" prefix tells us that index-pack has also created the
> > +	 * corresponding ".keep" file.
> > +	 *
> > +	 * In the "keep" case, we need it to remove the corresponding ".keep"
> > +	 * file later on. If we don't get that then tough luck with it.
> 
> We start off saying we expect either '"pack\t<name>\n" or
> "keep\t<name>\n"'. But the last line makes it seem like the latter is
> always expected? Is that the case, or should this comment be moved to
> the caller in 'fetch-pack.c'?

Even though all callers of this function specify the `--keep` option to
the git-index-pack(1) generating the output, it is expected that the
output may be either "pack" or "keep". When git-index-pack(1) tries to
create a lockfile, but one already exists, it simply ignores the error
and returns a "pack" output line. The last line is from the original
comment and indicates that when we do identify that a ".keep" file was
created, it is something the caller must handle later on.

The intent of this patch was just to update the comment to be hash
agnostic. The next patch splits out the `read_index_pack_report()`
function from `index_pack_lockfile()` and the last comment line is
removed accordingly. So I'm inclined to leave this patch as-is.

-Justin
