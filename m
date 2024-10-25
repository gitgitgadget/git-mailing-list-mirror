Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64976217F4A
	for <git@vger.kernel.org>; Fri, 25 Oct 2024 21:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729891136; cv=none; b=F7yXkNBYM5h5xdHfD39/vIO0CFLOLvH9HW+o/01die2C0Ylmk4oDdFODi6vdW7xPaCK0NksVIxgEEWEchnQUEfOrPwfGO/JAFAjB5OxSRjJpW5LDGCxz6Z4skmWX+/j+IwULgt+HEAZIbu8bkIEtUw5Bs+a4+yXE++QijQ0hAnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729891136; c=relaxed/simple;
	bh=+30LmkKNNG7d+IgG+NX/ymxrvgvTnJstDs0TiHQ7us8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NJh2Ss6EYhVYgilIm7HCpRiX6eaEaKU2iu05JtfsYAufiGWjkMzePwes7qwvXVuJ3VDiFJcEWMJ2uR3qNPGXv4qqK4cCCrQUM+yWod3NDQvWkIH0tJdWfdrfU2MPYC4+WuI+N9G823ycPUGYgNQM2r5Z+G0/etL01eiQwRMO/PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=lEBq0LFg; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="lEBq0LFg"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e2e444e355fso2654656276.1
        for <git@vger.kernel.org>; Fri, 25 Oct 2024 14:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729891133; x=1730495933; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yIyr8Ouf+CTHizufePvTfe6sVmjuxqIwbw+2UWVDJ1E=;
        b=lEBq0LFgyq0A1N506e1NYp1XFXKD/W7NOGHOzMUus3lVM/fVbyt2hvcFPyAQg5M6uC
         kZyt1mLPbY3VVsdhxw0bBVsxqURYcrQltFUD5fo6Lhea9TwOXZpzPiv3Uo1WrViAcyXH
         Qm3ZWrQ2MnT3Tg2oGmPuREFZA5yPi94vbVjNDGC27kgoTgA4ohWPVQC7HaHNROD14QkW
         K9IYDSWtdeXra/NmswnkAqjK5mlWDwlUvoBe69zKEjLHA/5A8JWhaM9ECa+o41Mwajz4
         xTjFuyDOIYdOlVhrOaqbVf/cv/4XVchetgalU/jhNAxAwUAk4QNJcIIaOE6QEP1vt2aw
         l7VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729891133; x=1730495933;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yIyr8Ouf+CTHizufePvTfe6sVmjuxqIwbw+2UWVDJ1E=;
        b=xS2FgBW7tfZIRtyw112v5aFNy9fy4TY362jBSJYu0nN2h8nbV5GElmhn+UeDwVqHQS
         xq4OwZNzVNeOkIhKpOK2D0HQTcI7vkRjZm4Sh/HTf3thODAJg3lK/Idw4GWEBvf6IaEP
         X71Z8fXiaFj953U1B8fySMU0qHdDqgqqdXIqKkhh82ek/ZnzCr4RAW+AiTadA8uz5ynu
         YofaU9bRlBvA+CwL0KdpMe+ataAgCfYFkghsWF7FF1LMOYTjJYxnUmzMV4MwW2wl8C/2
         9iWOBNnFks9pwkhdKIhPMielMUMFuIUAzyMqHOGoZb1vKO6v3c3b0B8x8sb/Sb/kIAp/
         2czg==
X-Forwarded-Encrypted: i=1; AJvYcCVUuP37ADDhgDvAXnaLNtBhrgq5Z+TBtaBmdsOYGy71rRFWq3jwM4//Ix163QZFmcObd18=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKvULXzhgEiuUGgbykGqGzi/VSRmZ58ZEOoaeJFkF3GK8TD3fm
	pR0nuDsU6FW67CKzZ0K4U261kecsLh7wp3TKApZfMUJdfjj4KANu+o3El2/rOp8=
X-Google-Smtp-Source: AGHT+IGYlhMhxFBfcyRmVIwJd+ODlMQWKa7+ku1NKZ1miFOJy8iZNpkzg3RExJ91w8gF+01Ru2t/Aw==
X-Received: by 2002:a05:6902:1242:b0:e2e:320c:ae65 with SMTP id 3f1490d57ef6-e308726a345mr1075457276.15.1729891133341;
        Fri, 25 Oct 2024 14:18:53 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e3079d72797sm389038276.16.2024.10.25.14.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 14:18:53 -0700 (PDT)
Date: Fri, 25 Oct 2024 17:18:51 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: fox <fox.gbr@townlong-yak.com>, Eric Sunshine <sunshine@sunshineco.com>,
	git@vger.kernel.org
Subject: Re: [PATCH 03/11] dumb-http: store downloaded pack idx as tempfile
Message-ID: <ZxwLOxT17OhLX/Rd@nand.local>
References: <20241025064148.GA2110169@coredump.intra.peff.net>
 <20241025065806.GC2110355@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241025065806.GC2110355@coredump.intra.peff.net>

On Fri, Oct 25, 2024 at 02:58:06AM -0400, Jeff King wrote:
> This patch fixes a regression in b1b8dfde69 (finalize_object_file():
> implement collision check, 2024-09-26) where fetching a v1 pack idx file
> over the dumb-http protocol would cause the fetch to fail.

Makes sense, and matches our discussion from elsewhere on the list
sometime last week.

> There are a few options to fix it:
>
>   - we could teach index-pack a command-line option to ignore only pack
>     idx collisions, and use it when the dumb-http code invokes
>     index-pack. This would be an awkward thing to expose users to and
>     would involve a lot of boilerplate to get the option down to the
>     collision code.
>
>   - we could delete the remote .idx file right before running
>     index-pack. It should be redundant at that point (since we've just
>     downloaded the matching pack). But it feels risky to delete
>     something from our own .git/objects based on what the other side has
>     said. I'm not entirely positive that a malicious server couldn't lie
>     about which pack-$hash.idx it has and get us to delete something
>     precious.
>
>   - we can stop co-mingling the downloaded idx files in our local
>     objects directory. This is a slightly bigger change but I think
>     fixes the root of the problem more directly.
>
> This patch implements the third option. The big design questions are:
> where do we store the downloaded files, and how do we manage their
> lifetimes?

Yep, the third option is definitely the most sensible here.

> I think the right solution here is probably some more complex cache
> management system: download the remote .idx files to their own storage
> directory, mark them as "seen" when we get their matching pack (to avoid
> re-downloading even if we repack), and then delete them when the
> server's objects/info/refs no longer mentions them.
>
> But since the dumb http protocol is so ancient and so inferior to the
> smart http protocol, I don't think it's worth spending a lot of time
> creating such a system. For this patch I'm just downloading the idx
> files to .git/objects/tmp_pack_*, and marking them as tempfiles to be
> deleted when we exit (and due to the name, any we miss due to a crash,
> etc, should eventually be removed by "git gc" runs based on timestamps).
>
> That is slightly worse for one case: [...]

OK. I think the more robust version of the solution you identified here
makes sense and is probably the right thing to do if we wanted to spend
more time and effort on fixing this part of the dumb HTTP protocol.

But I'm willing to believe that there are so few users of the protocol
at this point that it's almost certainly not worth the effort. So I'm
supportive of the stopping point that you chose here.

> diff --git a/http.c b/http.c
> index d59e59f66b..9642cad2e3 100644
> --- a/http.c
> +++ b/http.c
> @@ -19,6 +19,7 @@
>  #include "string-list.h"
>  #include "object-file.h"
>  #include "object-store-ll.h"
> +#include "tempfile.h"
>
>  static struct trace_key trace_curl = TRACE_KEY_INIT(CURL);
>  static int trace_curl_data = 1;
> @@ -2388,8 +2389,24 @@ static char *fetch_pack_index(unsigned char *hash, const char *base_url)
>  	strbuf_addf(&buf, "objects/pack/pack-%s.idx", hash_to_hex(hash));
>  	url = strbuf_detach(&buf, NULL);
>
> -	strbuf_addf(&buf, "%s.temp", sha1_pack_index_name(hash));
> -	tmp = strbuf_detach(&buf, NULL);
> +	/*
> +	 * Don't put this into packs/, since it's just temporary and we don't
> +	 * want to confuse it with our local .idx files.  We'll generate our
> +	 * own index if we choose to download the matching packfile.

I actually think putting it in $GIT_DIR/objects/pack is fine and perhaps
preferable, since that's where we put existing in-progress temporary
files. We'll ignore anything that doesn't end with "*.idx", so I think
it would be fine.

I don't feel strongly about it. It just feels a little weird to stick
these temporary files in one place, and stick other (similar) temporary
flies in another.

> diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
> index 3968b82260..706540ab74 100755
> --- a/t/t5550-http-fetch-dumb.sh
> +++ b/t/t5550-http-fetch-dumb.sh
> @@ -335,7 +335,7 @@ test_expect_success 'fetch can handle previously-fetched .idx files' '
>  	count_fetches 1 pack one.trace &&
>  	GIT_TRACE_CURL=$PWD/two.trace git --git-dir=clone_packed_branches.git \
>  		fetch "$HTTPD_URL"/dumb/repo_packed_branches.git branch2:branch2 &&
> -	count_fetches 0 idx two.trace &&
> +	count_fetches 1 idx two.trace &&
>  	count_fetches 1 pack two.trace
>  '
>
> @@ -521,4 +521,14 @@ test_expect_success 'fetching via http alternates works' '
>  	git -c http.followredirects=true clone "$HTTPD_URL/dumb/alt-child.git"
>  '
>
> +test_expect_success 'dumb http can fetch index v1' '
> +	server=$HTTPD_DOCUMENT_ROOT_PATH/idx-v1.git &&
> +	git init --bare "$server" &&
> +	git -C "$server" --work-tree=. commit --allow-empty -m foo &&
> +	git -C "$server" -c pack.indexVersion=1 gc &&
> +
> +	git clone "$HTTPD_URL/dumb/idx-v1.git" &&
> +	git -C idx-v1 fsck
> +'

Very nicely done.

Thanks,
Taylor
