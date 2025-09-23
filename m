Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15308224AF2
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 15:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758641628; cv=none; b=SCs74fKVzlV2DhhKlLUYwBdZZ5gOlZYWHyO4DNf5aYUX6Dd4TK9HLp99AwArRKko8aJFre6ihjoCa5bDBjreN/9ceJzsX7HU3mvvVe/EQmu+TBKgc3LLx1ovmeCfQRzZVg+WCOW0BgbiF7to+DrJelAnATMVpd60NTxuj+4Nq9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758641628; c=relaxed/simple;
	bh=I88kroSqtyqLJReLwrFFyWepxa+mMgzbKtkSY7xQS3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WtmtrgQoSFtaR4b1tC814fLYHPM++I+i0hvMI2d4Ch/Anwp2wNsPhGkU4UIvRcIKEvVwZMn0rIiY3COlXxVRQiQCm+Z7uTmVB8iQyXGwHxMomlmUybke/VLiOwnzWDqoIuP8h0o6a6vbMj6ejG80HZqMd6i9KWCb6T0FHnzuIZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mxPInCjE; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxPInCjE"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7827025e548so1273581a34.2
        for <git@vger.kernel.org>; Tue, 23 Sep 2025 08:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758641626; x=1759246426; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hl5+ZMEUZNxonELD9bTXO8xZExwJzu4mLeIrE6v5XWI=;
        b=mxPInCjE6KyPF7NEJy5LPTI47AuOAbuLbm0fZqmKXIcfsLEhq9XIICiAvsOI/iX8gO
         jhjReDpmabhTcqytyNg9Dlg/tQo54HaMWgAhe+P9av3UZWZA5OuoCJoAGa0PXmhy+T5X
         7vO00cgXM20PxPkx5ZSDCpf7Idws/+f6KczYr/W48bG1mhhM2v7XMa7tMnRNWHAuMgzY
         12Br8XxdcLcoc0FFln2/5CLoRtPdN146/+QOVldFdwKdO8/E7kviBjUbdxIO3FlJIyHS
         RXROv2wau7cFMXmt9kgi6ncD7xaZ/EwjbHsueyhItUld9pT94Hqsky0XEwRseS+Rikye
         Bawg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758641626; x=1759246426;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hl5+ZMEUZNxonELD9bTXO8xZExwJzu4mLeIrE6v5XWI=;
        b=jm0yfGWJD9vjU/Ub0NKRIPl+5nswe04YO75MWnjulRnX/ZrsONIhI0k7iTY3qt3sP0
         YQM8AWSRlDLRqzjhIS1YRlTAKxXtyWaoCz6Q9ae3dD5NBUHPDpNkndYgqzvLuFRDh4mt
         wOqWt8Uw0l89k0mDbzbkwf8XqFoUyOOi7xCg/Qukna6kCzJTKBCmJxVC0kTzZlLE6a6/
         ZEq0wzyjxSjeErMY7fR/MfTZvnANIP3X7GnT5X4gr6kNM+cHJhLibWuxLHbhGH+m4cA1
         rmYlLIGMrqC8TXGvGMQQFRs2biusApzdlWJLgX5xet0i1etmnp0jEC1dERq+Y0nCyP9Q
         fzhA==
X-Gm-Message-State: AOJu0Yz2hnZic90u21gCugcVF68athU1jdXTghC3Mu3DvB+vYTaBXWdi
	1JoS7TCtQza+sxzyxtKp7MI5EWAH8dvvgK1NSHklHs67dTcLhiq5JC02fAbU4w==
X-Gm-Gg: ASbGncsrleB/+qD8XADTQULIKsA9t73VoQf9D5D5zwcYJ94b9y9NKQXJDYpRlkHR04c
	boqlXHe/emiwGZOt2tZ30+ZNfuJqejgminn4oOxNqN9CpZ/huywmJlwQlxJ9vokIXn8Rk/RQ9GV
	U2ATnty+64SrFv+kfvKIC8T0Ylq1QO4LnvF1kFeKgnpS5u+YGKn1onX/ykFYfXDX4aFmOoo84Bv
	zJ1HRJ7e38pUCSf4zOtUW2KfAA9YjQrNLms268VeOFa+VEN1Zi4cHpkGEbTL+wq5YJqWA68zTsf
	kRDTOCLXDsvSAi4D+AZA2XmboISsH5IhK+Rw3NvlgbF+BUMSWaM49jNI8Ly/sooH3+Pt6KnkVho
	jDkSRqrkfTcU7/fq3
X-Google-Smtp-Source: AGHT+IEZ8xQ/K+aOlaIx2LuEQcrXk39DQCgdice46qXMezwpEup6wIaGWbNnQP30/rstXp4CG/oq2g==
X-Received: by 2002:a05:6830:6211:b0:741:3929:31a with SMTP id 46e09a7af769-79149f26b81mr2055520a34.12.1758641625917;
        Tue, 23 Sep 2025 08:33:45 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-7692de28b95sm7225162a34.45.2025.09.23.08.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 08:33:45 -0700 (PDT)
Date: Tue, 23 Sep 2025 10:33:45 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, karthik.188@gmail.com
Subject: Re: [PATCH 4/4] builtin/repo: add nul format for stats
Message-ID: <r2rt5aq64x232gmpj5wzzchut2w2axnkyfzg7wpthwuf2w3j4f@teydueqvon5d>
References: <20250923025700.3046260-1-jltobler@gmail.com>
 <20250923025700.3046260-5-jltobler@gmail.com>
 <aNJ8EUT_QVCqfFo7@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNJ8EUT_QVCqfFo7@pks.im>

On 25/09/23 12:53PM, Patrick Steinhardt wrote:
> On Mon, Sep 22, 2025 at 09:57:00PM -0500, Justin Tobler wrote:
> > diff --git a/builtin/repo.c b/builtin/repo.c
> > index 4c16a68e4e..37034e6347 100644
> > --- a/builtin/repo.c
> > +++ b/builtin/repo.c
> > @@ -291,27 +291,31 @@ static void stats_table_print(struct stats_table *table)
> >  	strbuf_release(&buf);
> >  }
> >  
> > -static void stats_print(struct stats *stats)
> > +static void stats_print(struct stats *stats, int nul_delim)
> 
> Instead of passing a boolean-style option, can't we pass the expected
> delimiter directly? Makes the callsite a bit more obvious.

Ya, we could do that here instead. Something I just noticed is that the
NUL format in `git repo info` also replaces the '=' delimiter with a
newline. I'm not sure if it would be best to match the same behavior
here?

If so, we would have to either pass both delimiters as arguments to the
function, or just keep the boolean toggle for the mode.

> >  {
> >  	struct strbuf buf = STRBUF_INIT;
> > -
> > -	strbuf_addf(&buf, "references.branches.count=%" PRIuMAX "\n",
> > -		    (uintmax_t)stats->refs.branches);
> > -	strbuf_addf(&buf, "references.tags.count=%" PRIuMAX "\n",
> > -		    (uintmax_t)stats->refs.tags);
> > -	strbuf_addf(&buf, "references.remotes.count=%" PRIuMAX "\n",
> > -		    (uintmax_t)stats->refs.remotes);
> > -	strbuf_addf(&buf, "references.others.count=%" PRIuMAX "\n",
> > -		    (uintmax_t)stats->refs.others);
> > -
> > -	strbuf_addf(&buf, "objects.commits.count=%" PRIuMAX "\n",
> > -		    (uintmax_t)stats->objects.commits);
> > -	strbuf_addf(&buf, "objects.trees.count=%" PRIuMAX "\n",
> > -		    (uintmax_t)stats->objects.trees);
> > -	strbuf_addf(&buf, "objects.blobs.count=%" PRIuMAX "\n",
> > -		    (uintmax_t)stats->objects.blobs);
> > -	strbuf_addf(&buf, "objects.tags.count=%" PRIuMAX "\n",
> > -		    (uintmax_t)stats->objects.tags);
> > +	char delim = '\n';
> > +
> > +	if (nul_delim)
> > +		delim = '\0';
> > +
> > +	strbuf_addf(&buf, "references.branches.count=%" PRIuMAX "%c",
> > +		    (uintmax_t)stats->refs.branches, delim);
> > +	strbuf_addf(&buf, "references.tags.count=%" PRIuMAX "%c",
> > +		    (uintmax_t)stats->refs.tags, delim);
> > +	strbuf_addf(&buf, "references.remotes.count=%" PRIuMAX "%c",
> > +		    (uintmax_t)stats->refs.remotes, delim);
> > +	strbuf_addf(&buf, "references.others.count=%" PRIuMAX "%c",
> > +		    (uintmax_t)stats->refs.others, delim);
> > +
> > +	strbuf_addf(&buf, "objects.commits.count=%" PRIuMAX "%c",
> > +		    (uintmax_t)stats->objects.commits, delim);
> > +	strbuf_addf(&buf, "objects.trees.count=%" PRIuMAX "%c",
> > +		    (uintmax_t)stats->objects.trees, delim);
> > +	strbuf_addf(&buf, "objects.blobs.count=%" PRIuMAX "%c",
> > +		    (uintmax_t)stats->objects.blobs, delim);
> > +	strbuf_addf(&buf, "objects.tags.count=%" PRIuMAX "%c",
> > +		    (uintmax_t)stats->objects.tags, delim);
> >  
> >  	fwrite(buf.buf, sizeof(char), buf.len, stdout);
> >  	strbuf_release(&buf);
> 
> It's a bit unfortunate we have to rewrite most of the function. I'd
> either have the `delim` parameter right from the start or just squash
> these two patches together.

I'll just squash these two patches together.

> > diff --git a/t/t1901-repo-stats.sh b/t/t1901-repo-stats.sh
> > index 5bc6d9d5c4..061b2fbbc1 100755
> > --- a/t/t1901-repo-stats.sh
> > +++ b/t/t1901-repo-stats.sh
> > @@ -127,4 +127,31 @@ test_expect_success 'repository stats with keyvalue format' '
> >  	)
> >  '
> >  
> > +test_expect_success 'repository stats with nul format' '
> > +	test_when_finished "rm -rf repo" &&
> > +	git init repo &&
> > +	(
> > +		cd repo &&
> > +		test_commit_bulk 42 &&
> > +		git tag -a foo -m bar &&
> > +		git repo stats --format=nul >out 2>err &&
> > +
> > +		cat >expect <<-EOF &&
> > +		references.branches.count=1
> > +		references.tags.count=1
> > +		references.remotes.count=0
> > +		references.others.count=0
> > +		objects.commits.count=42
> > +		objects.trees.count=42
> > +		objects.blobs.count=42
> > +		objects.tags.count=1
> > +		EOF
> > +
> > +		tr "\n" "\0" <expect >expect_null &&
> > +
> > +		test_cmp expect_null out &&
> > +		test_line_count = 0 err
> > +	)
> > +'
> 
> We already have a test for the keyvalue format that looks mostly the
> same, so we may just as well test both formats in a single test.

Good suggestion. Will update.

-Justin
