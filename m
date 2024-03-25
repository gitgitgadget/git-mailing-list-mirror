Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6596773191
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 22:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711404667; cv=none; b=K7wCZkVYEvVL9X4kesYZR2ueKHiP1BtfT47tYioYRDQ7KLLIF9EAaLDLTT1SJnXx/Sx5ul3l8TfnEnzalcIR/yymg1IiSxiOj4vAuuuTiiYGzuu6y861dN0ndoB0oeQNWmK1FW1HGaqDgE2UB+XNYaavEMsS8O/0BUyvk1YMX50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711404667; c=relaxed/simple;
	bh=ZO6LUo0r4rq08e+nIWPn1yPNud/k+zdFFUExrmBLJLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MKF2XXDwfi6Rf8FbObC4tzjuq+dQlAKZ6KzMs8yd3mUr9bJ7sX8JIr9ustdp6tqmtf9BTOCZyJ4IYbiSbeeOABUN3p+r2YJSRDr3saOUQhfxpWJuWVXZjFCK6/MGDY93Pj/PwgGjjrq8YyWVPIfVcxY8XowOaPe36XCfuY+mtRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=fxEjChlp; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="fxEjChlp"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-789e5021703so300185185a.0
        for <git@vger.kernel.org>; Mon, 25 Mar 2024 15:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1711404665; x=1712009465; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8DBGk/QmB9CpcgrZu3s3R1W4WowebuWIzvsMNl3mzfY=;
        b=fxEjChlplxRkx1BnvmK+ubmx/pF13fnrI4AOvbk9ZA+4+l1ykNlH0fXpnOZ0lp+8jx
         u5aC4LtooGlaRNbQeiJZp7Ku7lYkWAw8MavXif83/3rIl0j0npdc9ed5lhu3dDBnTiel
         By/mRHJl/6mdurkymbboxGTO+iP65djgXc2OPOob0ENGOSFrOJySB37opYrCWodSSAkD
         HbdMhKZdIc5tesejDq4gmwUuLFnUWo7EgYXwpkzvkedeOwDYTurPvcHBj0t4Ac+3c11p
         b+mBPvX3GxzcK9apDF5g1QBS85bSDXe0nVNXUWGkaRGin0J/tWRHLc09ATdvjlBeoOkU
         2H5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711404665; x=1712009465;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8DBGk/QmB9CpcgrZu3s3R1W4WowebuWIzvsMNl3mzfY=;
        b=alWwY2k6rdZA7d0f+r8M9JxG3ulkobeNwBMFCVGVS7Ljbt2oqkf4Bu6LSbcoQEyX6a
         s07qbI47moohlGM+7heWrniV5YzP2e2EVT0yuaY029ubYVQw+dgYGZvZ3lyI5hG5uQYo
         6RnLjK+uqszjx2t3S/KMC465sHQxTydR55iR/F1HouOqufAULlcIfERCveTh4PLgyXIA
         m59CsZmAlWm2UfXWJef8MVE6oOkKJxm1O8cO+A2+9nxtHT7Ty4exyvqOQo1HYaOI0h7F
         Y+5JXQBBWHO99UsXHl/sKLaUCv7oXzXUWTdD8pdpypcahb5izuoJvEckF5byNfoDWEnk
         jFNQ==
X-Gm-Message-State: AOJu0YxGcBIL0/U8slyA288DxqCA0UdYHEXO8cSzdGCZCa3Wc+msqwIv
	7WmN+ySb4utv51In+iTnsmiYiNf6xHMVIzggM+h02ZeysEdqSeM9SKgH+LN7xL+HEuJp3ittW82
	4w8Y=
X-Google-Smtp-Source: AGHT+IH/TcZgK+Sh89t9c9GiIuhyzJOYZ+p1MAJdu2fy2Je8tY8+7Ck3nBzIweOD0PoRKQqAYr5OoQ==
X-Received: by 2002:a37:ef0a:0:b0:789:edcc:8394 with SMTP id j10-20020a37ef0a000000b00789edcc8394mr8063013qkk.24.1711404665265;
        Mon, 25 Mar 2024 15:11:05 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c6-20020ae9e206000000b0078a517d9fd2sm1625143qkc.29.2024.03.25.15.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 15:11:05 -0700 (PDT)
Date: Mon, 25 Mar 2024 18:11:02 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 08/11] midx-write.c: avoid directly managed temporary
 strbuf
Message-ID: <ZgH2dhjECOTr0GMG@nand.local>
References: <cover.1711387439.git.me@ttaylorr.com>
 <8e32755c492d20eec02c81351d249ce34cc6d7b9.1711387439.git.me@ttaylorr.com>
 <xmqqv85ahx14.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqv85ahx14.fsf@gitster.g>

On Mon, Mar 25, 2024 at 01:33:11PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > In midx-write.c::midx_repack(), we construct the command-line arguments
> > for a pack-objects invocation which will combine objects from the packs
> > below our `--batch-size` option.
> >
> > To construct the base name of the output pack, we use a temporary
> > strbuf, and then push the result of that onto the strvec which holds the
> > command-line arguments, after which point we release the strbuf.
> >
> > We could replace this by doing something like:
> >
> >     struct strbuf buf = STRBUF_INIT;
> >     strbuf_addf(&buf, "%s/pack/pack", object_dir);
> >     strvec_push_nodup(&cmd.args, strbuf_detach(&buf));
>
> Hmph, I thought I saw another patch recently that uses
> strvec_pushf() to simplify such a sequence.  Does the technique
> apply here as well?
>
> Ah, yes, exactly.  See <9483038c-9529-4243-9b9a-97254fac29c1@web.de>

Hah. I wrote this patch on Saturday but didn't read the list before
sending it on Monday. Serves me right ;-). Feel free to drop this one,
or I can reroll based on René's patch.

Either is fine, just let me know :-).

Thanks,
Taylor
