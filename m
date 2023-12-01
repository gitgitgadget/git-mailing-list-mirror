Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="kIZJIfib"
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A8295
	for <git@vger.kernel.org>; Fri,  1 Dec 2023 11:58:47 -0800 (PST)
Received: by mail-vs1-xe2b.google.com with SMTP id ada2fe7eead31-4644cef778aso830055137.2
        for <git@vger.kernel.org>; Fri, 01 Dec 2023 11:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1701460726; x=1702065526; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MyXL/VnlfmkhP/KHf6baTYGNVeh6fx6n008dlN/OICY=;
        b=kIZJIfibq3UZVVxRXDEhGZtejW4JHqu3mGPEjh8f4TFVLGz1TzBvVtbHWs0n19/TVr
         pcBiX+5bgFMHbK0fkPDuGv9r0NdYczTjNaoe5+lBfhlpwGZNWe8GhEj9X3n1C0n8XXMa
         DAMViUtYv/C7Q18EIWR3E0+f7+OG3+h2vzX/BwF0SWhIXiArMgwUyvzfhNIyxOqY+Vyb
         mh0TCGLlXHxiVpXXFR6AFYL80iN7qaHsuQzkvKfaoHJFdOIC6mX8kIq70b4Er5i4q9tj
         pkX3z38UC8dpZq777DrRU80JB5/7JWm1jnHfKBAleKquOTDr7+zLdAfSzrVoFl9lo5bp
         n4Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701460726; x=1702065526;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MyXL/VnlfmkhP/KHf6baTYGNVeh6fx6n008dlN/OICY=;
        b=eIU3g+WfYfGBsdAJD7kBrjREBD+IWzjC4jpiXAjXrDUsNXLsAXJYbcRq1rb8vcb499
         QSyCI3Wcy485Lj8r5G4ITVSjxap3RAQ4ad8FNh38WED3wgk1uyqBdm0QsE9aDLhVePQU
         9nuRqwvRY5K7kYHsZfOrBfH0vXljTn6HijDlDFYb+NsrY+7owvWf0nCgou9p3mFvepNX
         kGNaA+yriPgg8yPsVm8Y7fs82FnxlfYbUCeCHkY31vCp1cW8egLKFLwmsPSF6fMIcyRc
         rjGOoeOx3V/ZVb+7xkThAlDgxJ2BVrtjvoBx/CzboI6A0dFhcSpezyqsdxcrcZgZmbeK
         bDwA==
X-Gm-Message-State: AOJu0YwGBApBQCjS//TrZ4ScEPdBw/rv9sbfvfF5Sgt6snkBe5XiLobb
	weg03vulWHml+hcX0uIabDsLiQ==
X-Google-Smtp-Source: AGHT+IFHtx1KZvbs0uyShz69iqZoS2m4zJ7wNauwT3/1bOMGLAbyzJNDXU6YsqK0jcV23pOOgR//7g==
X-Received: by 2002:a05:6102:3a64:b0:464:6320:d14e with SMTP id bf4-20020a0561023a6400b004646320d14emr169501vsb.1.1701460726474;
        Fri, 01 Dec 2023 11:58:46 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id w14-20020a0cc24e000000b0067a983ca601sm860372qvh.87.2023.12.01.11.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 11:58:46 -0800 (PST)
Date: Fri, 1 Dec 2023 14:58:45 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 08/24] pack-objects: implement `--ignore-disjoint` mode
Message-ID: <ZWo69V0sNbQCBEeD@nand.local>
References: <cover.1701198172.git.me@ttaylorr.com>
 <0368f7ab37669163b50b82185725935bde5bc946.1701198172.git.me@ttaylorr.com>
 <ZWhhkdnVZ9w7tDBv@tanuki>
 <ZWjjSOJHw6Q1qQ+y@nand.local>
 <ZWmWojF6BlOTzkcc@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZWmWojF6BlOTzkcc@tanuki>

On Fri, Dec 01, 2023 at 09:17:38AM +0100, Patrick Steinhardt wrote:
> In something like linux.git with almost 10M objects that boils down to
> 23 packfiles, and I'd assume that all of these would be disjoint in the
> best case. So if you gain new packfiles by pushing into the repository
> then I'd think that it's quite likely that the number of non-disjoint
> packfiles is smaller than the number of disjoint ones.

Right, although if you have 10M objects over 23 packs with a geometric
repacking factor of two, the last pack should have just around a single
object in it. In other words, as soon as you receive a push, your
geometric progression will collapse into a single pack.

So having a repository with 10M objects split across 23 packs is a
relatively short-lived state. And in general we should only be in that
state every time a repository doubles (again, assuming a factor of two).

In that sense, I'd expect relatively few packs to be disjoint, and for
each of those packs to have a relatively large number of objects,
accounting for most of the non-recent parts of the repository.

Thanks,
Taylor
