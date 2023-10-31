Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AD621A16
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 19:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="vb7qFM5w"
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D996F3
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 12:05:28 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-d9ca471cf3aso5619979276.2
        for <git@vger.kernel.org>; Tue, 31 Oct 2023 12:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1698779127; x=1699383927; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xU6gwEVt4pCECWm1uJD45tbjyW+YYnL5VoX9IUTzz74=;
        b=vb7qFM5wVH/v/ortHfz0hU4XeUowvt2GfrngBNRTTciSuiG72O45zO1svvzcBiavJZ
         G5h+wNq5N1yD19VzXqseiNbuCueFVU8x43iuGStuSd58ZuzKuZyn6HXNwgWKyu5pS38C
         nuomrRWOzzR49zUGc6ZvSE3KuBWL7YoRVxWDsLhZhC4l/w/k48VK3U44OwyZMsYnfrdx
         FOj1Y4Ac+p2JbJIlnH4YLApjV/BntjEoJGNYe9QOtsxXX4nNN/zT8HSnsiAKx1ta525K
         FPa3FzMyMmCT5FT8RsnGlZfVqyg5p17ubiKoWyhs9KSJbPgxeTWP5/VMlDHgK7IAq9Ur
         /2uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698779127; x=1699383927;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xU6gwEVt4pCECWm1uJD45tbjyW+YYnL5VoX9IUTzz74=;
        b=mAV80YG40eh2cb0Tu/4MxhdFNeJPWlHBglgk+tQ8CKptMs/Gntzm2scJz4un8tbB3C
         T99aTK+DtMhcu/QHuVqgT1QWwFkOqTh1Swjl9USLyVzCZvcRgKYXWL2isA+IIACCj4pV
         2NMc6c9OzDqcXekPJuG/BTcg4FZ9i/Fg4jMPBha1fFQA0OSo5jZ1NEhCeZchWWd04EAT
         1gB7dtqdoId2VqtblGo5JfgR3vXQ7NJq/dG0YWt6SHszTh0/U9CVs03wkEWT8WmCKKn8
         WEq8vtgfM4v2BXimndzQbu54pQJR1Fv0c5N7fy0nxI3zhVnyK8cDq+TNt6uqzzxfWrG0
         nK3w==
X-Gm-Message-State: AOJu0YzObrl9Gi8QAL3CfluxwXdCFcCKV/+8xgQsZdujabrVPpybsX7U
	KL0+oT3Sh5EFHJEsJddwj1nKqFvL0vhiFkpkDvK5UQ==
X-Google-Smtp-Source: AGHT+IH+Gm8K+n52w8Zxb2N3PodWvLk0xZO131dO3qS8eWwnAith+RiN/SVN4v8zoc8dUR9bv5WHWQ==
X-Received: by 2002:a25:db0d:0:b0:d91:c3fe:6144 with SMTP id g13-20020a25db0d000000b00d91c3fe6144mr14262661ybf.3.1698779127520;
        Tue, 31 Oct 2023 12:05:27 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id h63-20020a25a545000000b00d9c7bf8f32fsm1153165ybi.42.2023.10.31.12.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 12:05:26 -0700 (PDT)
Date: Tue, 31 Oct 2023 15:05:25 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Hongyi Zhao <hongyi.zhao@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Git List <git@vger.kernel.org>
Subject: Re: Method for Calculating Statistics of Developer Contribution to a
 Specified Branch.
Message-ID: <ZUFP9bQe5FL8QYDn@nand.local>
References: <CAGP6POKg4mSFv-Z+dD1aXDFDbxH9Xu1WCdCA5TGfCAM3NUUQLw@mail.gmail.com>
 <ZS2qZtYDvItovjqg@tapette.crustytoothpaste.net>
 <CAGP6PO+SeZPzD21nErX=Vq=+d6oy-kg+diu=irot3enOhpQNMg@mail.gmail.com>
 <ZUAk6dPJyhfb7UBM@nand.local>
 <CAGP6POK2yABRhJHQYfOFZ2h6BSy9XU6aZbnBaA11TJiEnBAa6g@mail.gmail.com>
 <xmqqsf5r2tr3.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqsf5r2tr3.fsf@gitster.g>

On Tue, Oct 31, 2023 at 03:25:36PM +0900, Junio C Hamano wrote:
> Hongyi Zhao <hongyi.zhao@gmail.com> writes:
>
> >> But I think that there is a slightly cleaner way to compute the result
> >> you're after, like so:
> >> ...
> > So, your method and my original one give exactly the same result.
> > Therefore, I can't see what their fundamental difference is.
>
> I think Taylor offered a "slightly cleaner way", and not a
> "different way that computes better result".  So it is not
> surprising, at least to me who is watching from the sideline, that
> you cannot see any fundamental difference.

Indeed.

Thanks,
Taylor
