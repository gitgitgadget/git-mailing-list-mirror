Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F7C380
	for <git@vger.kernel.org>; Thu, 22 May 2025 00:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747872526; cv=none; b=AUplR7XT5PV2bH00X6XSRkyMxAPFmhvR+VeMIHJxtTAUP+JY3wCpKoUA7g6yQ/jcdv48aiRqsjYRBNiW+JDmuK8NkaUoLNpjPg3ljAIMUz/4aGYymfKy3ykdU1EFcOJPekLSlcDw/Il0xFmDwP7Wfmo0eKWlXK74CAHDe0GsrKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747872526; c=relaxed/simple;
	bh=WwmnfgAwCO0u+nfO9CnuUz01Urje6dd+82EhQmHISc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kO/GFvM+b0e0hTixLFgtzJ6iTZrM3wu5hnnY0HdIH/x788w0mQOa1qPek693doJmiqboiR6TJlQHGmBKJs8RSVtYLNGysa6oIOY8P0ZhRxlk0F0XRGb7EnNm4dmlQDbdCydoEhtVk/AbZKK8gVhTfKURLOR8DuAXs0gRX+euxRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=wNAMmiPk; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="wNAMmiPk"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-476f4e9cf92so57164581cf.3
        for <git@vger.kernel.org>; Wed, 21 May 2025 17:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1747872523; x=1748477323; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZXAZyZSU2y+ewlM9ZdOTiDwITAWHwT5ChS61co72Pbg=;
        b=wNAMmiPky8JLqDfL1Jh/1u1AR2BOgXbth7jzefT3rih6CKid5yAPeWsWM1eU2hvDAJ
         Su/CnR4boXXn8g7KS4yv7izwFv5N2688pxncYrrxT8alOR94undYqQ+sBQ8t1dLfdQdF
         mlxQAGXC+RoI2aWtPg6OnXaf6OemaTpDrS/jEr3emAyFA96Yz259NqhXRnBIxpoli1Uv
         1wWewy7IK073HsRu4qLdAEgcxOzKrg0ahA5i5qDfwT2EpXMrnQ3mdghXTnVmSYWUnJTF
         wbyYh1mkDJ5EpwHCwhXukteakCR/6SMcrBulwzFa6QlgMz8cba/LyhmsBi4Y0zItE79b
         zupQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747872523; x=1748477323;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZXAZyZSU2y+ewlM9ZdOTiDwITAWHwT5ChS61co72Pbg=;
        b=MsfU7MrSLEOuplRz0HUmxhXy0gCzdudKsnjzBJNHd88nU2DZQs4xQXCPU4f3myme+y
         zS8pDcHvVf0fk1iKH0KSWoKN6HQvMUl483lNHBmec7k4/Clw5p1YyW46K9kT1p3kxOtm
         2VNV1Y8Tm7SQeKSD4H8wsS5Fk/kQllg5azR/hIXJ1mGUOVDXYtkVCKnvjIG610ifMybi
         Qu4ONUAH5z/vjCjBJ67+6sKsKq/fMwwLBs7w/Zet/thO7yavMkHM6pJbC4kGCLOAmz1o
         yQqMwNS+DCilFFonPaLWOSHcm1Tts1KlB1NeZPfeUvmurTyB/E+oCO5T/exIdl2ZyTqq
         TMEQ==
X-Gm-Message-State: AOJu0YxwFVTAKFfPflfykTAxoYp3HctVDoPZ+3Gw10tpPX2N8ICba+ua
	FSs1GWIHISAAJdkmi3LsqMlGzXHcxdQhKKIFs35HLztsJQwAcZCfE+9AMxXsNpxlmVRn1U1H8wY
	R8A1e
X-Gm-Gg: ASbGnctF19s3S06fkmHPIo6OAyt+rD5wcG6FKeQabjJy2bYItkyhmAfOxIeKvjCr/o2
	eFWgNnpdsfYquIzet+0bJ0h2gh8fWFsmshkfakCRQ68V5VsODzu1LCzUB7MQmkiqH5X0c9GmwuC
	ZkqEoy3c0XAbrqBvVgXr0rSls3Fjq+ioYE7Fz18Lvg1LiaqPtXbNbBB+w5blOx0XDHM9b+EKxwq
	f3w2/AR6PIAp+F41FGQkpQpZ75dZqxBgWu6hfY0YK7TMo6LYGSGJbZzCy2GQaDgI9JlhZKmWXON
	yDwjzMs7qfxVWezZt3UYqQNQwZ4/EDXy2YOZlZDA2d9zo4g7D484uWDFOnd3a7raZxjWF/id3ym
	IMhryLkmvJw5Ga/nda3Jh/HA=
X-Google-Smtp-Source: AGHT+IEboPHMqzuCCokzDxt1lqYC66bDqW4mkeHJsDbr57MBYxO3C6V+fJUYRvcxqSatBh9vsxr4PA==
X-Received: by 2002:a05:622a:5591:b0:498:111:93bb with SMTP id d75a77b69052e-4980120dbd7mr304440821cf.37.1747872522747;
        Wed, 21 May 2025 17:08:42 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-494ae526398sm90762481cf.65.2025.05.21.17.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 17:08:42 -0700 (PDT)
Date: Wed, 21 May 2025 20:08:41 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Lidong Yan <502024330056@smail.nju.edu.cn>
Subject: Re: [PATCH v2 3/3] pack-bitmap: add loading corrupt bitmap_index test
Message-ID: <aC5rCRJd3GaTNgL5@nand.local>
References: <pull.1962.git.git.1747052530271.gitgitgadget@gmail.com>
 <pull.1962.v2.git.git.1747732991.gitgitgadget@gmail.com>
 <5be22d563af714ebb902506f12b4468a5348896c.1747732991.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5be22d563af714ebb902506f12b4468a5348896c.1747732991.git.gitgitgadget@gmail.com>

On Tue, May 20, 2025 at 09:23:10AM +0000, Lidong Yan via GitGitGadget wrote:
> From: Lidong Yan <502024330056@smail.nju.edu.cn>
>
> This patch add "load corrupt bitmap" test case in t5310-pack-bitmaps.sh.
>
> This test case intentionally corrupt the "xor_offset" field of the first
> entry. To find position of first entry in *.bitmap, we need to skip 4
> ewah_bitmaps before entries. And I add a function `skip_ewah_bitmap()`
> to do this.

I'm going to avoid commenting on the message itself, since I think we
may be able to drop this patch entirely, see below.

> Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
> ---
>  t/t5310-pack-bitmaps.sh | 50 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
>
> diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
> index a62b463eaf09..537a507957bb 100755
> --- a/t/t5310-pack-bitmaps.sh
> +++ b/t/t5310-pack-bitmaps.sh
> @@ -26,6 +26,18 @@ has_any () {
>  	grep -Ff "$1" "$2"
>  }
>
> +skip_ewah_bitmap() {
> +	local bitmap="$1" &&
> +	local offset="$2" &&
> +	local size= &&
> +
> +	offset=$(($offset + 4)) &&
> +	size=0x$(od -An -v -t x1 -j $offset -N 4 $bitmap | tr -d ' \n') &&
> +	size=$(($size * 8)) &&
> +	offset=$(($offset + 4 + $size + 4)) &&
> +	echo $offset
> +}
> +
>  # Since name-hash values are stored in the .bitmap files, add a test
>  # that checks that the name-hash calculations are stable across versions.
>  # Not exhaustive, but these hashing algorithms would be hard to change
> @@ -486,6 +498,44 @@ test_bitmap_cases () {
>  			grep "ignoring extra bitmap" trace2.txt
>  		)
>  	'
> +
> +	# A `.bitmap` file has the following structure:
> +	# | Header | Commits | Trees | Blobs | Tags | Entries... |
> +	#
> +	# - The header is 32 bytes long when using SHA-1.
> +	# - Commits, Trees, Blobs, and Tags are all stored as EWAH bitmaps.
> +	#
> +	# This test intentionally corrupts the `xor_offset` field of the first entry
> +	# to verify robustness against malformed bitmap data.
> +	test_expect_success 'load corrupt bitmap' '

I am not totally following what this case is supposed to be testing.
Let me think aloud for a moment...

> +		rm -fr repo &&
> +		git init repo &&
> +		test_when_finished "rm -fr repo" &&
> +		(
> +			cd repo &&
> +			git config pack.writeBitmapLookupTable '"$writeLookupTable"' &&

First we set up a temporary repository, change into it, and enable
bitmap lookup tables. Makes sense.

> +			test_commit base &&
> +
> +			git repack -adb &&
> +			bitmap="$(ls .git/objects/pack/pack-*.bitmap)" &&
> +			chmod +w "$bitmap" &&

Then we make a commit, and write a bitmap containing the objects from
the commit we just made. Good.

> +			hdr_sz=$((12 + $(test_oid rawsz))) &&
> +			offset=$(skip_ewah_bitmap $bitmap $hdr_sz) &&
> +			offset=$(skip_ewah_bitmap $bitmap $offset) &&
> +			offset=$(skip_ewah_bitmap $bitmap $offset) &&
> +			offset=$(skip_ewah_bitmap $bitmap $offset) &&

Then we read past the header and four type bitmaps. Makes sense.

> +			offset=$((offset + 4)) &&

Now we land at the bitmap for the commit we just wrote.

(As an aside unrelated to this part of the test, this skip_ewah_bitmap()
function seems awfully fragile. I wonder if it would make more sense to
implement this as a test helper that can dump the offsets of EWAH
bitmaps in a *.bitmap file by object ID rather than trying to parse the
file ourselves?

We don't currently store an offset for each stored_bitmap that we
maintain, but doing so would be pretty straightforward (add it as a
field to the structure, and store the value of bitmap_git->map_pos from
immediately before reading the actual bitmap).)

> +			printf '\161' |
> +				dd of=$bitmap count=1 bs=1 conv=notrunc seek=$offset &&

OK. Now we break the XOR offset field of this bitmap by writing garbage
into it.

> +			git rev-list --count HEAD > expect &&
> +			git rev-list --use-bitmap-index --count HEAD > actual &&
> +			test_cmp expect actual

...and then we make sure that we still get the correct result.

Hmmph. I don't think this is quite testing what we want, since this test
passes with or without your first patch. And that makes sense, we have
tests elsewhere in this script that verify we can still fall back to
classic traversal when the bitmap index can't be read. (For some
examples, see: "truncated bitmap fails gracefully (ewah)" and "truncated
bitmap fails gracefully (cache)".)

I think what we're really testing here is the absence of a memory leak,
which we are as of 1fc7ddf35b (test-lib: unconditionally enable leak
checking, 2024-11-20). I wonder whether or not we need this test at all?

Thanks,
Taylor
