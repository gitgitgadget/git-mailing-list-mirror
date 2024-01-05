Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B68832182
	for <git@vger.kernel.org>; Fri,  5 Jan 2024 17:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="KN+nZNhN"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-680b12e5d42so8401336d6.3
        for <git@vger.kernel.org>; Fri, 05 Jan 2024 09:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1704474669; x=1705079469; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZZb8IAVDJoSsvR9d9YDzZmlicfejd6hBYPnQjTSGAYk=;
        b=KN+nZNhN9LvHir+ENunYTTFu4sjvweMG2v+6CekUlvOGcWbtPsudzp4amq5nFlq9KE
         nXsXlapHiIkX/MVQU2L6DlEXKNa5cXnK/mh8GdqdwoyvZcqTtkLSJ4jSmZiUjOcwQw2H
         TIP/t7djQSOC3/TNw2IQrm8mYkkqo7QC93TPDFi4/U/rusD6QSpAxkFkF0Lxuy9cUpiq
         wT1G9YUw493jzyifJSibBRZmKb2Z2pyJRiYNLqWUBq75EB9cMsc5/MvzxCzThUCW0nuO
         hRyt34UECzg5cJCI4+qLbW/NBQ5oaEH8GRBZ7ZB9rgJ6hMJZToRlI+V22F/0DgQlTGQe
         QSpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704474669; x=1705079469;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZZb8IAVDJoSsvR9d9YDzZmlicfejd6hBYPnQjTSGAYk=;
        b=vWeLB/yPb4sjW0G49Vt7LKV48YgrI5EIKZwxoZgoo0X5U5C+YjDEijCw3j2aw4T0j/
         CA9733G9Z/5eN5dHCTJzLplD+14v1qvM1wn2TSAUiCC52u0KiGxZhrA1uIpYWPN2t9jO
         OTquQ8mgrGLuK2SZSnXPXil5BrPSjzyKHlyr38i/CsSbz5G3TEGmulQ3IZjMOV3j/f0q
         9tXXbRO64jTMc/tZWRZvdGYhRGcH0hKjeYPmierQvhsXQsfQUFigTzgkVgCBuwSoVtpG
         fqEiJtpp/8uLsdMNVpJt+hj1kPoiVAK51NVsASjEzMqJ2Ih5ntUuMktld9/zVqr1l/GY
         hoZA==
X-Gm-Message-State: AOJu0YyB4Urrc9t7x5vJyrcUS22HHlB8YsdAOvJtb3SqRIY8abAxc/KH
	aHEOFRbWWibjhC/7cwJRuVWHuFWlMrRacVnEJb2HCzRE8iH8zw==
X-Google-Smtp-Source: AGHT+IHnC+8Tk+ts+9z18YrduZRHUk8NMdeV3bd7MArOVmz0aFYqCW+oOhIw7V5bsUc80emwaJdiyQ==
X-Received: by 2002:a05:6214:2686:b0:680:a13:3852 with SMTP id gm6-20020a056214268600b006800a133852mr2300713qvb.131.1704474669066;
        Fri, 05 Jan 2024 09:11:09 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id kc28-20020a056214411c00b0067f7f73d632sm741263qvb.138.2024.01.05.09.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 09:11:08 -0800 (PST)
Date: Fri, 5 Jan 2024 12:11:08 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Illia Bobyr <illia.bobyr@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3] rebase: clarify --reschedule-failed-exec default
Message-ID: <ZZg4LO7L2q8GtLHh@nand.local>
References: <20240104080631.3666413-1-illia.bobyr@gmail.com>
 <20240105011424.1443732-2-illia.bobyr@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240105011424.1443732-2-illia.bobyr@gmail.com>

On Thu, Jan 04, 2024 at 05:14:26PM -0800, Illia Bobyr wrote:
> ---
>  Documentation/git-rebase.txt | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)

LGTM.

Thanks,
Taylor
