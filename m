Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E1C2F531B
	for <git@vger.kernel.org>; Mon,  6 Apr 2026 13:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775481395; cv=none; b=c1QXBdFsJyY6hJnAXXf9vP7jssD5CKvxCeg/p0FhcURJpGFTCKr86hQgDRpPmmNI57ryJhbKfraURg+KcW1L3VuX+V6W5GTygf8q7xp75US6wdDEvZpcVDJkXs61kq6rq/M4N0cSh8V6Dlne2F0goJNDe6vgRdDDJTDEhNRlGVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775481395; c=relaxed/simple;
	bh=KC8LE7kZu2BzVaKoXJqxvhonoFoAsfsxWoJsKrcW/08=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IvurWZ9Lu16Bfx8YpHebBz+JlrTYA2m4+387Pgl7q/ScHNtzDgH/yKFcrPtf8UrWfdRoBmorm9pI3VBjiD6lICXhWw1c+WIELg6cGH6whGSOVDvW9FpvXis5Ler1ZnH0flIb8almZp4+ZTsEFwzmewLOyu6nlFg66hspONhbBRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qXy1vaxX; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qXy1vaxX"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8c6f21c2d81so354597285a.2
        for <git@vger.kernel.org>; Mon, 06 Apr 2026 06:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775481393; x=1776086193; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3f6geWHTcN372U6Dj8TvGgfw5ub0NX0+wWbjdN5buIs=;
        b=qXy1vaxXJAbu8tn+x+ky1lSGbWBl3Fn69FrojztT/Vgg6P8yjRg0YSc0QDhone2IAp
         ntRcGoONaT77IDsxOWTPnCTMPNSSPf+gRWmtgy7laI/Mfv2XBJP+K52tbcYwdvdBGMaj
         9dmPDfXro98VSwafmXWOrAYZ24DUn35e4YchVv3BqqqQK9653Ao1m9hM9XTG9gfVLgNv
         JvXIYEHfOv1cz0yLW4kgFdHUf2BrdH/pUyNmtNmqB+7x4WWghB/rAND7ChtCOJ1NOF3E
         UIwLyxpQpO5Iz4hiqXMG+ka5ryyiWwf83Aqpe0fM7G73eTIAIEjUYiSr8Ttm2Z5AhflM
         2Y7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775481393; x=1776086193;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3f6geWHTcN372U6Dj8TvGgfw5ub0NX0+wWbjdN5buIs=;
        b=W3hsSjpKXCZw5tq7F9XISwVoh0jYjabPzVMSVYGjTFT8XotG6H4aUTYV4UNSXneLTX
         I8U2z1PJ+oWgd8XVHnEMdikgA8c5Lju7sBo9kH4GCrgxYtn9p8sxcgtJUML3MdM2+DRe
         nQGFV48sVhQVlKORJpKM9w8/uj2i5EVAGtq1fWc40WaNXCHuET5mmjHGl7710FuTpUHn
         vTh5wCVZ0vVRhLEZa5f5XDHAF7gdlInMnC+XFidjdWc5o5ldSSLrDrzHgmT1WWeIN56z
         MuriYZpasO3meebhtrATN3OFQG7/1NL+8NtoS70fOnXPJ5/OxeZBq6p5usBtcO9HvvES
         SW+Q==
X-Forwarded-Encrypted: i=1; AJvYcCX4ZyFiiIHAdzC8VtvAtzGKPyvfUF9hIPQIJotvkabh5EA74/iHPIPuDw3MuMc3a4xaIGA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl74X/YgquMG79jgq6q//oynlmy89D8ACjb/MWFkHHy6OZx0Xk
	JlOAA/W87+w20yH3utGL51kprYL71AOQ/1zZSkFmNCIS34WqcfrhWV97/pCW8A==
X-Gm-Gg: AeBDiev/l47EaeG/7Ob6J8gViaicNsAoYf91df4O/KHqXhSsPN7gb64DmaHqb2y7Kzk
	Dd6DRPa9qhabyh0Gaa0HFfYJ+wDvfKoB0c9N/JtAEmLR/hXhUrF5YkbW/VU+C7GUnvL8qOk57UF
	U0AhwUqpnOtOufwRZm4JOc5jxgZG3twosLSeHiE5i1QYWkIdvHA65TmTZxOGaQoZ5Zm+DZHAiSX
	Nk+5DF3RL3qjYzYHdYp5S+yWSapEZzp5mMaulNZkju4FCG2SE6cz4olm6oW6RRywlUWJ7a0UTdI
	eUEi9Tc8P1UY3NuBb0/Q2SpBDDBLDs9PrAIeBJ1UUui4midtcasOtPOlBh8mRxeJ7HaHQYJoHc+
	PPpyaYMejZOqVBtrtAifR9LAH+oNnTvjE05xJv03HnP2h+/xx/vsZ8Kq7NziNl/FTu4d4uZY+cw
	CpQrIoq4zl7tv9RcOs0eOWkf2wUsp+9hFyCF6zpJF7dOr6N7rOLCE7PvjlM+x/Fm9AMFsDFw==
X-Received: by 2002:a05:620a:171f:b0:8c6:ff8f:58af with SMTP id af79cd13be357-8d41e244447mr1757312985a.51.1775481392483;
        Mon, 06 Apr 2026 06:16:32 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d40495cd93sm850416385a.23.2026.04.06.06.16.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2026 06:16:31 -0700 (PDT)
Message-ID: <8db10441-2fce-43ad-bcdc-331d26ec38ed@gmail.com>
Date: Mon, 6 Apr 2026 09:16:30 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GSoC PATCH] backfill: add --[no-]progress option
To: Trieu Huynh <vikingtc4@gmail.com>, git@vger.kernel.org
References: <20260329152443.525493-1-vikingtc4@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20260329152443.525493-1-vikingtc4@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/29/2026 11:24 AM, Trieu Huynh wrote:
> 'git backfill' is silent when downloading missing objects, giving
> no feedback during potentially long-running operations on large
> repositories. By contrast, 'git fetch', 'git gc', and
> 'git index-pack' all support --[no-]progress.

I wouldn't use the word "silent" because the output is actually
quite verbose by default. Each batch has progress output with the
remote. For example, this is the output I get when running 'git
backfill' on a blobless partial clone of the Git repo:

$ git backfill
remote: Enumerating objects: 50083, done.
remote: Counting objects: 100% (865/865), done.
remote: Compressing objects: 100% (177/177), done.
remote: Total 50083 (delta 760), reused 688 (delta 688), pack-reused 49218 (from 1)
Receiving objects: 100% (50083/50083), 37.13 MiB | 27.75 MiB/s, done.
Resolving deltas: 100% (47710/47710), done.
remote: Enumerating objects: 50393, done.
remote: Counting objects: 100% (1559/1559), done.
remote: Compressing objects: 100% (366/366), done.
remote: Total 50393 (delta 1366), reused 1193 (delta 1193), pack-reused 48834 (from 2)
Receiving objects: 100% (50393/50393), 44.56 MiB | 31.56 MiB/s, done.
Resolving deltas: 100% (47261/47261), done.
remote: Enumerating objects: 50000, done.
remote: Counting objects: 100% (2313/2313), done.
remote: Compressing objects: 100% (592/592), done.
remote: Total 50000 (delta 1982), reused 1721 (delta 1721), pack-reused 47687 (from 2)
Receiving objects: 100% (50000/50000), 90.49 MiB | 17.85 MiB/s, done.
Resolving deltas: 100% (45321/45321), done.
remote: Enumerating objects: 2155, done.
remote: Counting objects: 100% (27/27), done.
remote: Compressing objects: 100% (26/26), done.
remote: Total 2155 (delta 6), reused 1 (delta 1), pack-reused 2128 (from 1)
Receiving objects: 100% (2155/2155), 891.74 KiB | 3.75 MiB/s, done.
Resolving deltas: 100% (1717/1717), done.

With your patch, I think there would be some extra progress
indicators between these batched fetch requests.

Before moving forward with review of this patch, I think that
it would be valuable to demonstrate the full output with and
without your change.

In addition, I think there would be value in a progress indicator
_instead_ of these verbose outputs from the remote. That would
require a change to how we initialize the fetches in a quiet mode.

(I also understand that this output would probably not be the same
if we have a filesystem protocol for fetching from a local repo,
like we frequently do in the test suite.)

>  static void backfill_context_clear(struct backfill_context *ctx)
> @@ -54,6 +57,7 @@ static void download_batch(struct backfill_context *ctx)
>  	 * avoid possible duplicate downloads of the same objects.
>  	 */
>  	odb_reprepare(ctx->repo->objects);
> +	display_progress(ctx->progress, ++ctx->batches_requested);

This looks correct. My preference is to not use prefix operators
like this on struct members (it reads like you are incrementing
'ctx' and not 'batches_requested', even though it is correct).

However, I'm not sure that we want the progress to indicate the
number of _batches_ but instead should be the number of _objects_.
  
>  static int fill_missing_blobs(const char *path UNUSED,
> @@ -120,12 +124,15 @@ int cmd_backfill(int argc, const char **argv, const char *prefix, struct reposit
>  		.current_batch = OID_ARRAY_INIT,
>  		.min_batch_size = 50000,
>  		.sparse = 0,
> +		.show_progress = -1,
>  	};
>  	struct option options[] = {
>  		OPT_UNSIGNED(0, "min-batch-size", &ctx.min_batch_size,
>  			     N_("Minimum number of objects to request at a time")),
>  		OPT_BOOL(0, "sparse", &ctx.sparse,
>  			 N_("Restrict the missing objects to the current sparse-checkout")),
> +		OPT_BOOL(0, "progress", &ctx.show_progress,
> +			 N_("show progress while downloading missing objects")),
>  		OPT_END(),
>  	};

I hope that this does not cause any issues with the recent changes
to include the rev-list options in git-backfill. Worth checking.

> +test_expect_success 'backfill --progress shows progress' '
> +	git clone --no-checkout --filter=blob:none \
> +		--single-branch --branch=main \
> +		"file://$(pwd)/srv.bare" clone-progress &&
> +	git -C clone-progress backfill --progress 2>err &&
> +	test_grep "Downloading batches" err
> +'
> +
> +test_expect_success 'backfill --no-progress is silent' '
> +	git clone --no-checkout --filter=blob:none \
> +		--single-branch --branch=main \
> +		"file://$(pwd)/srv.bare" clone-no-progress &&
> +	git -C clone-no-progress backfill --no-progress 2>err &&
> +	test_grep ! "Downloading batches" err
> +'
> +
> +test_expect_success 'backfill no flag on non-TTY is silent' '
> +	git clone --no-checkout --filter=blob:none \
> +		--single-branch --branch=main \
> +		"file://$(pwd)/srv.bare" clone-notty &&
> +	git -C clone-notty backfill 2>err &&
> +	test_grep ! "Downloading batches" err
> +'

What you are missing here is that the progress isn't silent when
a TTY is present. There are several tests in the test suite that
use the TTY prerequisite for this kind of behavior, such as this
one from t9211-scalar-clone.sh:

test_expect_success TTY 'progress with tty' '
	enlistment=progress1 &&

	test_config -C to-clone uploadpack.allowfilter true &&
	test_config -C to-clone uploadpack.allowanysha1inwant true &&

	test_terminal env GIT_PROGRESS_DELAY=0 \
		scalar clone "file://$(pwd)/to-clone" "$enlistment" 2>stderr &&
	grep "Enumerating objects" stderr >actual &&
	test_line_count = 2 actual &&
	cleanup_clone $enlistment
'

Thanks,
-Stolee

