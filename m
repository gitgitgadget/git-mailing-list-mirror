Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C092157495
	for <git@vger.kernel.org>; Tue,  2 Jul 2024 12:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719922512; cv=none; b=sdnnwj8i5ReFCnXW+pNStrVnTlaBDkXnee8piQ5o/pzv9viwCKd6wMZBOnMwZgToftFtfROw4FK66ZULoFmoZx+dp5pYvaDtDJ9T8SYrn/ikjwBlmcnBRHQOkQZyzAjNW5NgBNFdybY9Ic9E5OPht77BGONlWgFiuCHbuJaVPf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719922512; c=relaxed/simple;
	bh=EsLj9jqOh9dhI/BDXBk+KXj8/WpaH7nZ5kpuRur+LsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n0fV1Ah328bwpjryx0Vi7KVz7kIJvIethxzdtLgPvTLL7YuCMZD0cpM1TfeJOv41qo2kik7cGzRkvkok3tQz39dOMJPCJ2vbhG9L6QXv7UvKAcVoUIgjPsuFJiN2eMEZGeSmUzm5rRbS+XfWAlvGuie5clLfZB4MzihvcEgGwb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AbdGi0wP; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AbdGi0wP"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-25c9ef2701fso1967647fac.1
        for <git@vger.kernel.org>; Tue, 02 Jul 2024 05:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719922510; x=1720527310; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6fYDCx18C5BVNJZlGHmwPPAd5UE8zgOzz9rSVtagF90=;
        b=AbdGi0wPK8ZG+5Agg9TTOLc20XN+eWrr4aWZ+ycBz3YFRDt49awiOtx+VgL9cMFjLY
         VIfM7Bmn2Ew3LUNFPoBxDORjo8hn6ep11dLzrrNub4M+/5u97TgmZgiAFfvQKztfISd5
         9pw0tOTOvFQwdMjRh0OY3EQtJt14cXNC9iZsjydmaffhJ27AVpgzVfBD2AnWpQZ8Awm2
         9A1AirXmCd8yd1JlcOuq2xLKepsxocmFDWUpESgwdRXEIzGc6ISnsv1DJFSoAESYHUeg
         r59gJ48neG9lijAiA1Zyt+8SDVo5Ra9FbwZ1J/s0MjgTQn5fsKNtjiVQ7B4y5pYDt+pl
         7+jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719922510; x=1720527310;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6fYDCx18C5BVNJZlGHmwPPAd5UE8zgOzz9rSVtagF90=;
        b=GArnTfQdpD1ux32o7rNeY3tA+WE6Z0Kjsm7OcLYWvys0EWhV4uMAE1yS7AVZzzQnyB
         zvyUZEqPXPMScsvE3L+SYXnIEX/t+RuMaU3rj7cW43m3PLti6I9xTrDFZalCdQzlXHD0
         ecThBA35VOgzd5rqQ5mnykR0oc10Iep/E2dgwUbX5sI/n1C/5V4grrLrlyuGM95fGZ0G
         kzzDFJfOij7YDZM/X2DTdKcrGJMbUOu+NjxGO4AiiuCSF1lEKEbU0VBd4MSY7hbyhr1p
         qoE328QFmhLu5MJXLQTyX5E1jyVnHv4MCLawuVLFbdO1ka9fqBuc1bMY+EfqM7MLsgPr
         pAQg==
X-Gm-Message-State: AOJu0Yw978YX7rll19MW+xJ1rwqDJDC/66Pzf4uqBxvzRavhB8lR0a0X
	oagoqzV9oHRanOybYBNgQrhFYA66I4RSfDQYo13lQVRG6zQncHxH
X-Google-Smtp-Source: AGHT+IHlfdbKv2lDUJJEvDzOSLjNNfV15sXC8vZmFtCEBDG5NKwFGDFIi31vpEVQnRx59KzfpWqESA==
X-Received: by 2002:a05:6870:8a0b:b0:254:96ec:bc44 with SMTP id 586e51a60fabf-25db3579836mr5080568fac.28.1719922509735;
        Tue, 02 Jul 2024 05:15:09 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70801e63250sm8349625b3a.29.2024.07.02.05.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 05:15:09 -0700 (PDT)
Date: Tue, 2 Jul 2024 20:15:08 +0800
From: shejialuo <shejialuo@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [GSoC][PATCH v6 00/11] ref consistency check infra setup
Message-ID: <ZoPvTKU4A73PXqf6@ArchLinux>
References: <Zn2Ah3WDhtOmzrzn@ArchLinux>
 <ZoLHtmOKTfxMSxvw@ArchLinux>
 <CAOLa=ZSFTcMn+CsEcE1G5hnW37rw81zcUaXBywVY7xbBN7mhkA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZSFTcMn+CsEcE1G5hnW37rw81zcUaXBywVY7xbBN7mhkA@mail.gmail.com>

On Tue, Jul 02, 2024 at 10:33:36AM +0000, Karthik Nayak wrote:
> Hello,
> 
> shejialuo <shejialuo@gmail.com> writes:
> 
> > Hi All:
> >
> > This version follows the Junio's advice. Instead of creating the
> > following data structure:
> >
> > 	struct fsck_options {
> > 		enum fsck_type {
> > 			FSCK_OBJECTS,
> > 			FSCK_REFS,
> > 			...
> > 		} t;
> > 		union {
> > 			struct fsck_objects_options objects;
> > 			struct fsck_refs_options refs;
> > 		} u;
> > 	};
> >
> > I simply use the combination idea where "fsck_options" will incorporate
> > "fsck_objects_options" and "fsck_refs_options". Karthik has told me that
> > I should balance the job I should does and the extensibility for future.
> > So I use the most clear way to do this. Also Junio has said:
> >
> 
> If I understood Junio's comments correctly, he was drawing out the point
> about if we even need the separation of options for refs. Since the only
> option we're adding is a verbose:
> 
>     struct fsck_refs_options {
>     	unsigned verbose:1;
>     };
> 
> wouldn't it be better if we simply amended `fsck_options` as so:
> 
>     diff --git a/fsck.h b/fsck.h
>     index 6085a384f6..ea97f48acc 100644
>     --- a/fsck.h
>     +++ b/fsck.h
>     @@ -135,6 +135,7 @@ struct fsck_options {
>      	fsck_walk_func walk;
>      	fsck_error error_func;
>      	unsigned strict:1;
>     +	unsigned verbose_refs:1;
>      	enum fsck_msg_type *msg_type;
>      	struct oidset skiplist;
>      	struct oidset gitmodules_found;
> 
> Your approach seems to take a different path though, where we create a
> new route of creating two new structs, one for refs and another for
> objects and adding both to fsck_objects. If we're doing this, wouldn't
> it be better to use the enum+union idea, like Junio mentioned? That way
> we would have clarity around which type it represents.
> 

I agree. Let's give up breaking the structs. I will send a new version
immediately.

Thanks.

> [snip]


