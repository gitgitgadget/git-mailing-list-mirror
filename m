Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0396E1B4F17
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 16:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742400338; cv=none; b=JCsxTt+meqGDWNqqbROBjH6WmOk6P9dsFuoA3GP4KQ2K+BclpEB15zN3lFK1yBFAjt7j8/wJOS3tFvSvyCrTE0710TZZReT+XGobqADaGZbu0iGNfmrOSJGaW8nO54xcEewnIilB9/9b+t8hBBO84mRufdcadD5s0bh9/wxLk+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742400338; c=relaxed/simple;
	bh=Rtb8Kgo5Kub4GRSOYCaIACdss5cOXVgXXkJPEy5E/L8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VdwhpJPNoeVg/tja5Ut0YVnRn8ExckxouuuCCodhO//lToxqeljiZhftoxivRAWfV/N0vgWGXHr7ecvOau0Z/6OEZzMNP76qr82i5RtP5nmlZ34VtstxBf5uwlDjiLj52CAsuH6CLt00naQxtAiKB01iDg4zkA7DHm3qpl1EE5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S2ZJuyZ/; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S2ZJuyZ/"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5fd19b469b0so1679869eaf.3
        for <git@vger.kernel.org>; Wed, 19 Mar 2025 09:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742400336; x=1743005136; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YI0pqOCO+YO6i0g0xspuu1VK+KQBoedYwUlln4CIJy4=;
        b=S2ZJuyZ/6/XneB8YuvcVMBAh8WTqtvnL+CCqd4wTUJQ0u00fOKzkJG3VBENer298Xu
         GFUIvRA26zHbdyqSbh+PBiUH6q1lASUO8LPT5SstTvtQAij0YcOGx4/wT96TeYqrCFIg
         zrH8Y3Al2VDv6ti4qPA3mp8Y/lhIy1Dck2N3QVw9rVut3Zd6/l90WkhYvARPkMzY/M/+
         f7KAzUzItJlLvvYexOMg0qLP0BE5scn9leoRdYF3sbJQTxeRdk5SyjgvNfPAs+S7AfQd
         lf/XBWkYi242YBfxU8t/jOr669GRXHysgD3cTzQ35Ii6tamEd1Qe+MPJfGcuAHoqhDje
         +ktw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742400336; x=1743005136;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YI0pqOCO+YO6i0g0xspuu1VK+KQBoedYwUlln4CIJy4=;
        b=URAovhaN23iDO5yxlmoi5iEOJwiW6feaBA9VHveDlfMx2U0mqda+JXqo+lqYfLopKH
         bi9WPubd3oKmsoY/8xkHD2xzDhBbVI1j5mqXAKV2lMEuTjzRvUKReg9syZO6U7w5bWTJ
         IVvjVTV7p2cRbZ3ppnDe4dds1SZgbUr7ZNxCyhwzA1roQU9w9i+8+yVVLwB2a4HiBtUx
         8SJPt8pJTSuOIgDNe8dCDz2Jw2Y2rN72uxz3qKRhSAxla/RVkUTYDJc+JioElN9xBFak
         oOI31HL0YHsf2gLUC02h52UnWN6WxAXO+SehYvL2fwd7bI8e4JfXXJ6a7QcHcBCEt467
         ORng==
X-Gm-Message-State: AOJu0YyszIoP++dAGCp+L+1BhNM0RRRH2+r87WAKrRO27VqwwU6UBGvb
	a/3haPBDgOnSJN0w0ooTZR5w+H02CGGnkxbxz8AMCs/64sWd2wWG
X-Gm-Gg: ASbGncuWFN+4YK9W9FEziw2yJfIjDSMQfpOUEL8V0ULikTMEhXcpnuOGF7aoPDg8feQ
	BdPR7d8rufmUmQZooG8QLsjx5uyGbbyp+ZiZLKfSccU0vc/ni/4WBrTgwxwXyXVTySGWA6IBsk8
	BxGnI7+cG+F18BO6S7Slq/E5hGRZVHNoAewup86A5oCTXNpPFTGp4j9oXocYWWucVxTBLKDXrzW
	fR0vgiCKgqsYv/qYTB4Rr6L0Dd2mK+oH4ybp0SYG1eYBNy8XkTTtHzgTg3x/OvT8mCvOU3m1YRL
	2R4C5MpQCOOq13p4EGMbr08JeY5wh79Wt1JKAuti8DyUsbHY
X-Google-Smtp-Source: AGHT+IGM+3HOJzeVxoE0frZGkZ4RUkAgHOXSljSTnrmm2HczOgOpwbJW27zaA+Jszdzi8RQqGKQh7A==
X-Received: by 2002:a05:6808:159c:b0:3f9:2fdc:ee93 with SMTP id 5614622812f47-3fead601aedmr2805389b6e.30.1742400335915;
        Wed, 19 Mar 2025 09:05:35 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-3fcd5c00139sm2643837b6e.35.2025.03.19.09.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 09:05:35 -0700 (PDT)
Date: Wed, 19 Mar 2025 11:02:01 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im, peff@peff.net, ben.knoble@gmail.com
Subject: Re: [PATCH v3 4/6] rev-list: support delimiting objects with NUL
 bytes
Message-ID: <3kjvitvmmi776obptqex7eo32qawegh6lzkih37ppkuina5ohg@loulhg5beghp>
References: <20250313001706.3390502-1-jltobler@gmail.com>
 <20250313235747.9583-1-jltobler@gmail.com>
 <20250313235747.9583-5-jltobler@gmail.com>
 <CAP8UFD1JAkTESnEOP621uECvoFGFmQ8SRd372hPLDhNzALAN+A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8UFD1JAkTESnEOP621uECvoFGFmQ8SRd372hPLDhNzALAN+A@mail.gmail.com>

On 25/03/19 01:35PM, Christian Couder wrote:
> On Fri, Mar 14, 2025 at 1:01 AM Justin Tobler <jltobler@gmail.com> wrote:
> 
> > +test_expect_success 'rev-list -z' '
> > +       test_when_finished rm -rf repo &&
> > +
> > +       git init repo &&
> > +       test_commit -C repo 1 &&
> > +       test_commit -C repo 2 &&
> > +
> > +       oid1=$(git -C repo rev-parse HEAD) &&
> > +       oid2=$(git -C repo rev-parse HEAD~) &&
> 
> It seems to me that HEAD is at commit 2 and HEAD~ at commit 1 instead
> of the other way around.

In this case, oid1 and oid2 were ordered based on how they would show up
in ouput, but this is somewhat confusing because its not the order they
were committed in.

I'll change it to be in commit order instead.

Thanks,
-Justin
