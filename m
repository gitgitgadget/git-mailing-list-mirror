Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D6527EC98
	for <git@vger.kernel.org>; Tue, 20 May 2025 17:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747763895; cv=none; b=tomLbsWoRqFyJp0s0+cGYtyJ3RB1v9KGXBLYGjOMOxgUkk/IgPM9CIuftmw2f3VSIqd/JHMtLCltbeBjO5JzhCKaX/YXC+pLxmICb7DQuNbpoS3p5W53VFBmpWFmG2exGYeSQSJ5ARbhSrnbxavDift7fFOGeNXUbFjsnCvEXAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747763895; c=relaxed/simple;
	bh=nAaFpdwZ6HRhn+YSw+dBtsY4yVTZLzisrioPUQa5faQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eOwZRDSR6PduzjGs8wRY10ktLR/6nXffAd8ranqg8cVO6uoshDAUqjGjmM1wr0HWc+kFum0/TK1RlRgPVEnjYiNxwCnafkrXzMuWvhsikpUu7wR6iZNlLZRvr2f86AQInAha6QRJYVn52v5reUFDPtfdSoUiMevo+JH0OL/B5m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=GqdRiBTa; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="GqdRiBTa"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c546334bdeso524238085a.2
        for <git@vger.kernel.org>; Tue, 20 May 2025 10:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1747763892; x=1748368692; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6yt6PVYWMxX3VuGaYxQCRuq23nqRCXxm5Gbulrr811M=;
        b=GqdRiBTabE3DQlGNA8aB9xokKsxowHEsR6RvdC9F0fyOYoNYN8un/ISnnXwafv19IM
         rexGgxAMwC7n6dVy/OPVDKWneIDCCccDlSbGWsIUN+RVy9dYF2niYjwllpZE95CLOwpg
         aGuGxmvSQZsosGNqMS1paJ/+0YHELg3o/XPRomMJi3D7Z32cnlgqAcUlvKulWu/jbHun
         LhZSMYYSzuTvJlrpIHKiSzwJNS1y1vUy8SO/nOmYsbcp2efWR1Yh8Cwo0UFTf6ncXUyD
         oNVEIyZahW/q47ZffJXb+U2KSeAnRjMD0yHKDNLFTF8LztPZP9vn5niG2m4b/DcgpPbM
         QROw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747763892; x=1748368692;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6yt6PVYWMxX3VuGaYxQCRuq23nqRCXxm5Gbulrr811M=;
        b=SXf+UkUmOC9UVnqOq0ddGhbU2KRdqJItGYgn+4XrG5zod/HDlpxE2qivjp8+d44vIT
         K/lx0MnOkeq/rBJrexChH0QbGrtKYDWa2dbfGhVUuOuG+SKAQ7ytP6j+B0RLrVyChROG
         CPMRuwdLO4NhrdTVJLdQw2Y3xEFckNA90VhmyYcL7dfh3lxKosFlHk/C73C8hf7IVInr
         8NeHdPFCt/xp8D6cnZ2qcZ4uqBJ3wfpWxZ0Wg/jcZdTdJFSkSAyrzL0OiSoYiXQvCIpc
         2cWkA7iyad5fnxbUbCkgPVQ0oNlymu3oxNcq5/9tIJzDYOafgKXyqKAPItCnq/NJOAgM
         kJ+g==
X-Gm-Message-State: AOJu0Yz+edE1zN0+51TbU+jZ2rCJ08BcTGD81orKPSAqGBUYOF/BCvKd
	owqi3i8wfHqfgpYEdr+LHr8ocra3mYr1hDE2ywMD00BHMLE0HtBS4rkhWB7vm3g20K8=
X-Gm-Gg: ASbGncsAb0TG4PqlQtgpw0+2e/BToDuPMUBS536fJW4DSA2DaC3gGJVeQ8/TC3+pSZ6
	6K4FVNBm0ca08Q83dzOAymEgACPpY5XFspYjqihHvEjtacFmoNSYgFFlG+qxieYF0W1NB8yDChE
	b6X0g2nkyKTTG4xlHepfq09ln8wqDMDr/e8NmRbOexwT/n5l/v+WvDiq95+e5eCTqAR6+zhptT1
	xuJKq7kLlYl11VpL0pSYb4eidTfvgmP40fb7knPvQFF7MoUSNd4SH7zzoepim197iYCYSjDawe8
	hwzFcyUj2EYLRB0+BfYL40bFl31Qtt9VoTT0PUgoDcEWLeWqZGQiHFcIFdycfD1j0jrrfUNqESq
	GRbNO31Jx0zx7/ved6Wgn3qk=
X-Google-Smtp-Source: AGHT+IEdWpMJ4r8J2LkcNhyOYYFwgmhxmsHpebvIf2cKy1rDQdQZqVD5rGHwvkBmGlofKPFoNgVPng==
X-Received: by 2002:a05:620a:319d:b0:7c5:5cc4:ca5c with SMTP id af79cd13be357-7cd47f3d1a6mr2093319785a.14.1747763891927;
        Tue, 20 May 2025 10:58:11 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7cd467bc7c4sm768340485a.23.2025.05.20.10.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 10:58:11 -0700 (PDT)
Date: Tue, 20 May 2025 13:58:10 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH 3/4] midx: avoid negative array index
Message-ID: <aCzCsv61ET4u7JOK@nand.local>
References: <cover.1747753388.git.phillip.wood@dunelm.org.uk>
 <688b0273604179b5bebe3748445158e09a7bf1a0.1747753388.git.phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <688b0273604179b5bebe3748445158e09a7bf1a0.1747753388.git.phillip.wood@dunelm.org.uk>

On Tue, May 20, 2025 at 04:04:26PM +0100, Phillip Wood wrote:
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> nth_midxed_pack_int_id() returns the index of the pack file in the multi
> pack index's list of packfiles that the specified object. The index is
> returned as a uint32_t. Storing this in an int will make the index
> negative if the most significant bit is set. Fix this by using uint32_t
> as the rest of the code does. This is unlikely to be a practical problem
> as it requires the multipack index to reference 2^31 packfiles.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  midx-write.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/midx-write.c b/midx-write.c
> index 2ee381e8fcd..38a458d7322 100644
> --- a/midx-write.c
> +++ b/midx-write.c
> @@ -1566,7 +1566,7 @@ int expire_midx_packs(struct repository *r, const char *object_dir, unsigned fla
>  					  _("Counting referenced objects"),
>  					  m->num_objects);
>  	for (i = 0; i < m->num_objects; i++) {
> -		int pack_int_id = nth_midxed_pack_int_id(m, i);
> +		uint32_t pack_int_id = nth_midxed_pack_int_id(m, i);
>  		count[pack_int_id]++;
>  		display_progress(progress, i + 1);
>  	}
> @@ -1697,7 +1697,7 @@ static void fill_included_packs_batch(struct repository *r,
>
>  	total_size = 0;
>  	for (i = 0; total_size < batch_size && i < m->num_packs; i++) {
> -		int pack_int_id = pack_info[i].pack_int_id;
> +		uint32_t pack_int_id = pack_info[i].pack_int_id;
>  		struct packed_git *p = m->packs[pack_int_id];
>  		uint64_t expected_size;
>
> --
> 2.49.0.897.gfad3eb7d210
>

Thanks for catching these. I was going to comment on it as something I
noticed while reading the first patch, but I'm glad that you addressed
it here.

It looks like these two declarations date back to:

 - 19575c7c8e (multi-pack-index: implement 'expire' subcommand, 2019-06-10)
 - ce1e4a105b (midx: implement midx_repack(), 2019-06-10)

(both of which were merged via 4308d81d45 (Merge branch
'ds/midx-expire-repack', 2019-07-19)). But I think these have always had
the wrong type, since the pack_int_id field comes from commit fe1ed56f5e
(midx: sort and deduplicate objects from packfiles, 2018-07-12), where
it was first introduced as a uint32_t.

I actually think these all should size_t's since they're indexing into
an array, but that can be dealt with outside of this series, since this
is an obvious improvement.

Thanks,
Taylor
