Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED572199935
	for <git@vger.kernel.org>; Sun,  3 Aug 2025 15:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754235258; cv=none; b=grYaqAQM6rZrQxVo9VFlW+0nGhWQ+uzLdjh6MVXrK8E4FjajtiGvP5SWv90wtoTp5g8wsXxBlxbCl1QsWzLdam+YQPg060bZmwItuxjd7AuZGVwwwbpY6xHZ7AWkCs33ztjjr4JxNtqZPjwTbD2YYHzC8XF8K1duqsMuTDCKN0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754235258; c=relaxed/simple;
	bh=vwwefKjElG+zrExT+nghs4xyXY/vh5yYQN82uIl2xbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NAR1FX1MP1yKSs8mygQm6G+c574qCDKP8wc4V70MsrAr3W6MPGOLx8O7qTlgi4qdeCweTsM2AFDVYo2uehWgcs81zhBA4tm1cK4nx8VkVd8GvtVl0SyTmceAZoWM1ayKiePqg/STt2l9Uwv16b40pzAs2vnmEdb3hd2F+sHfC2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YX8Go1zk; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YX8Go1zk"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-73e88bc38bbso1343543a34.3
        for <git@vger.kernel.org>; Sun, 03 Aug 2025 08:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754235255; x=1754840055; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=g8aKGetjVaBBSVStnil+2VJ/Cv+3DB1xuNaj7vskp7U=;
        b=YX8Go1zkuolSlxc3eg+1+pnjlzELViIzPU93pkWHMdbuyqZeRa8+d/pQba7U0GvQgo
         s9edADllKCJyNH6eXLWMPXwzmgyqlQt0qORRSRe7+sv0SRycu7KB3BcTcJyuW6DIDHqQ
         EBLyDfeKNjl4te7/PfyH9hYFxyD4h3rj0AqJNjn8RrvcNK9Eqayinv06AjoR+4bVHf86
         iNkvrBfZHLH1/380njUqwM6o1X/WniusPnkqXjqjZoFMKpFt8C5Wtk6uq+cjykYp1o7e
         NsTRN5xiyFspE9GCW3uGv042LzxhVLbyXrtMjCfuFnwF1YVQEUWmto2OAzkP4/2hImkH
         IQXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754235255; x=1754840055;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g8aKGetjVaBBSVStnil+2VJ/Cv+3DB1xuNaj7vskp7U=;
        b=LJq+fPbUtxUS4bJJLO+QIi1HUG6/0oRifAoGdp9DSWdAmXa0P+VMvfKDD+ZEbQH6Lk
         uBLEHBLN81NgQ23f4M/X+1zRm25E7XxqNBeEEs15pj+6Oz1b8d0LEWB6b4BxH1vRk2Gw
         eh/3L+KkBSQQyTAXivQbb53Td2kWmuVHeQWMhXyAra54B7Q7FdQrZ8xbXs+yKeR/DrFc
         pxs2zLz5cnDhwsz+xlRa0eU7dFg7LsiQJxGy894J3dTMeF5J34KfArcABq8nK5MV60dN
         t2aUA2uKiyjcVEgPhpGp7xapnZH8n9LdFGbajmuJUeinnIyWTW3Oc8NMrghhQcxdYdr0
         BlWA==
X-Gm-Message-State: AOJu0Yy1yUJ91NXjIttotKReHHAlC5Zye+c1vmQxavFxmmSoHBz/B0BO
	zGToBh+PocpdWIsurWKktp5BAcH1t7DTvOaLX+Dgm5aSnn7hlTJHqOVsmRx2KQ==
X-Gm-Gg: ASbGncsE8HD+fv36sMseGNson6O98hUJKZMSgW1W10w4wtAZYsbh24tRurjPvV7C8dP
	uhPK8gKul71eQjgDO5UNmQ9UDwGfmK2HsIYJiaxUq1goLnYYAfVUt22QeIP4rF/b6teOj0Y1hDO
	v+ng+3CgjYzbyw44JRy6+cyBvJ3eLJGNiW51GcDX7gJNuGN0ePQtgSJ4oKoN+TeKjc+qSZcQWX4
	tmYlV5S6a+QD7GfwZEVoRmYiNtM7ZrnjFY7vhlahyWDLYGx5xtBDPlyJJU54bdG3ZdWWN9C8hLg
	eyJAt/RnM5IwrMv+WhWRNOClw86p3oz01yK6qLwQ9ZvmUbqHnPiw5rEzy8lS+ZKfWEqMDiswaw2
	1r6PItO0qWdcTEIHzPA0t9X5rfQ==
X-Google-Smtp-Source: AGHT+IEHSDT79FWu/xXev5lVZZFQQfsSM21nXuGwe4Fq89j3R+JFAgW4mrcXa4GZZvoNYpb47q1XXw==
X-Received: by 2002:a05:6830:3109:b0:73a:9f43:6395 with SMTP id 46e09a7af769-7419d235973mr3424773a34.19.1754235254765;
        Sun, 03 Aug 2025 08:34:14 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-74186dac9dcsm1806308a34.42.2025.08.03.08.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Aug 2025 08:34:14 -0700 (PDT)
Date: Sun, 3 Aug 2025 10:34:13 -0500
From: Justin Tobler <jltobler@gmail.com>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: git@vger.kernel.org, toon@iotcl.com
Subject: Re: [PATCH] archive: flush deflate stream until Z_STREAM_END
Message-ID: <t4rkigpst2h42r7iouwli7lj74lydz6nmehojzajt6impibpui@kvgu7pfkuf6k>
References: <20250802220803.95137-1-jltobler@gmail.com>
 <5817e9ed-5b5c-4539-85ea-07c601c0ac7e@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5817e9ed-5b5c-4539-85ea-07c601c0ac7e@web.de>

On 25/08/03 11:52AM, René Scharfe wrote:
> On 8/3/25 12:08 AM, Justin Tobler wrote:
> > I've tested the patch against this specific file, and it fixes the
> > issue, but I'm uncertain how to reproduce and test this issue more
> > generically. I'm open to suggestions if anyone has some ideas :)
> 
> Not sure how to fill up zlib's pending buffer most efficiently.
> Reducing the size of the output buffer would make the bug easier to
> trigger, though.

Ya, I was able to trigger this issue more frequently by making the
output buffer smaller than the input buffer. I was really hoping though
to find a way to reproduce this without code changes so we could add a
test. Not sure if that is really feasible though in this case.

> > diff --git a/archive-zip.c b/archive-zip.c
> > index df8866d5bae..29e7c9f5e3f 100644
> > --- a/archive-zip.c
> > +++ b/archive-zip.c
> > @@ -492,14 +492,22 @@ static int write_zip_entry(struct archiver_args *args,
> >  
> >  		zstream.next_in = buf;
> >  		zstream.avail_in = 0;
> > -		result = git_deflate(&zstream, Z_FINISH);
> > -		if (result != Z_STREAM_END)
> > -			die("deflate error (%d)", result);
> > +
> > +		do {
> > +			result = git_deflate(&zstream, Z_FINISH);
> > +			if (result != Z_OK && result != Z_STREAM_END)
> > +				die("deflate error (%d)", result);
> > +
> > +			out_len = zstream.next_out - compressed;
> > +			if (out_len > 0) {
> > +				write_or_die(1, compressed, out_len);
> > +				compressed_size += out_len;
> > +				zstream.next_out = compressed;
> > +				zstream.avail_out = sizeof(compressed);
> > +			}
> > +		} while (result != Z_STREAM_END);
> >  
> >  		git_deflate_end(&zstream);
> > -		out_len = zstream.next_out - compressed;
> > -		write_or_die(1, compressed, out_len);
> > -		compressed_size += out_len;
> 
> Looks good.  Could probably rolled into the first loop, but that just
> would make this fix more complicated.

I was also considering rolling this into the first loop, but ultimately
went with the minimal patch to fix the issue. I don't mind rerolling if
we prefer it the other way though. :)

Thanks for the review!

-Justin
