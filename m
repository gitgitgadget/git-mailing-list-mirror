Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B0720B326
	for <git@vger.kernel.org>; Wed, 21 Aug 2024 10:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724234818; cv=none; b=sDx2Ru7d9NxjgByOHfo+uYTCiHGbnNqmXSNit16aAUoUNOyWulQC2Ow/LHxrymACkmczA8toWVxUSaH5/CsDjA/ZJHfXok3VW5WRhse6urcQmkuZlBgUIi02HwDyjch/9d1SwbXeLovlSVWuq93+S+JpoexwJLEkKHkA2d6Qzxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724234818; c=relaxed/simple;
	bh=SmVKwgGxunnr+4n3JdQqS+bxbE3lXYY3x16s/S1Rbbg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pl5u7XF0IXXCc5oNs2QJ97uPR2YdZKq7RDm0a5as+k/5Fd6nHETTpaxlotkUD2EHF4m1J/MWiEmDi2zlN4Wi2Lck+zN50RkWKnfOdCDbwDFpe8DsVhTHrt9Gz4OXrLXUpTrey1/s9o1w+t23Bxp68F4f9vZkZe0w3uUb6+pNAHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CTLoUUSS; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CTLoUUSS"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a7d26c2297eso743876666b.2
        for <git@vger.kernel.org>; Wed, 21 Aug 2024 03:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724234816; x=1724839616; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SmVKwgGxunnr+4n3JdQqS+bxbE3lXYY3x16s/S1Rbbg=;
        b=CTLoUUSSm6KrI5F4zav6MbwPLNLiCdmbAHrviCnrppZpWUiabn39ugpHJ1GMBi9VIN
         nzFZk8eEA3yah2Sdjcnu62ofjsxnLtHFNsfHJVFdoqSoWgtugpUn3vFmfRxJSPGlAGjl
         3wtUf+/YiTR/vKPMmsnIevqYoB4ocjcwUbsc/ZFj9AduTDntySSidX7nHyJgiLBHyA3y
         JyJ7oUHRgD90/4WkETFfWoroEpED3vTJTBpvF9i/4atfLRJD6XODDdQIcKqB4PQBCiBt
         lKjrV1M9o8ZTPxbukvi1CiLI2M8YcDW9dN35nD3uutCqXqAYBjkQ8L3Eijbtg96LGfhY
         9tOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724234816; x=1724839616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SmVKwgGxunnr+4n3JdQqS+bxbE3lXYY3x16s/S1Rbbg=;
        b=VuLp8KyNX/tB8Rb3WoGUMjlVxQDecNzLnPQXE+n7wEVu5HHqCkGWlhQb5UEYwpJyU9
         G7/HWvHpWXng4gczHccpisp63dPMXFhhLzC0msGLEOoGGnuYx3QGX+5bWp+vZOPMBivO
         6BqESk1AsfpgtdLdRKlfRFdPEwVRrp+nWAVgwqzNGDkMdVYt0iCgbNTxYBZqJyGEQcVK
         NkBArxZxVgB6s6vKWRDxTKl4h2hNm+ZO5Bpy0WoXbrhWgQLJfQw+BK2XqGES41iHWURH
         8QhXwQ5wy6+STGRz9rDsC3pFJ4osXjpPJQNBjkXM/RMQ+2ECnuY9/vR6VMNXMHsj9B4t
         oMYQ==
X-Gm-Message-State: AOJu0YyziVt4f1ovSXvorLRUPXMxDEQO0ztxod7H/HRNNyOIeWpVbrCx
	rLO46iabtzHW78Mf6KN+SSffg3NJiWMCitUrpPKTTiHAUbdnp5XROjppHBAe3r6to7K5KXIG3QH
	Zj1xl7oPPUfLRFMKLLj8NPgwljA1fFw==
X-Google-Smtp-Source: AGHT+IHPHONRYaWqKcRfNdNjLnu+YWEXCnOu6oTbvqvMq1WQB01TGrtEMYuQwLiPHhKo4dJIAWlDZVoC22xOZCRpNE4=
X-Received: by 2002:a17:907:9712:b0:a77:c84b:5a60 with SMTP id
 a640c23a62f3a-a866f287301mr124845666b.26.1724234815172; Wed, 21 Aug 2024
 03:06:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814142057.94671-1-shyamthakkar001@gmail.com> <20240820152008.21354-2-shyamthakkar001@gmail.com>
In-Reply-To: <20240820152008.21354-2-shyamthakkar001@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 21 Aug 2024 12:06:43 +0200
Message-ID: <CAP8UFD1WJqKUe-SA=w0oGQNgpLdaQNkc5Uh0rZtmCvDD1oQk7A@mail.gmail.com>
Subject: Re: [GSoC][PATCH v4] t: migrate t0110-urlmatch-normalization to the
 new framework
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Karthik Nayak <karthik.188@gmail.com>, Patrick Steinhardt <ps@pks.im>, 
	Christian Couder <chriscool@tuxfamily.org>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 5:20=E2=80=AFPM Ghanshyam Thakkar
<shyamthakkar001@gmail.com> wrote:
>
> helper/test-urlmatch-normalization along with
> t0110-urlmatch-normalization test the `url_normalize()` function from
> 'urlmatch.h'. Migrate them to the unit testing framework for better
> performance. And also add different test_msg()s for better debugging.

This version addresses all the suggestions (nits actually) to improve
the previous version, so it seems to me that it is good to go.

Thanks.
