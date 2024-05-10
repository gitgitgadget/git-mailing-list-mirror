Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9314D135
	for <git@vger.kernel.org>; Fri, 10 May 2024 19:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715369196; cv=none; b=QoqnXRQislDLdrdKJGnTc6oN2kHx1N1ksSxeNZErS53SNQ5ms2la5MDfKtm+dZKJbvFbrdpap4uODupqDZ6UwxY8aqXZ5dxu9mvXGguFQJuyz5eXfF8VWkgs/CNq4MN+2M2PKF8KBroc+HEO3j9Zlp4A0XfHvdYXJSUrj5k1rqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715369196; c=relaxed/simple;
	bh=6oJOvdMzD7irChUkndAT/T9msm0hd9c9/BsKv5NX0VY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PG+44oOfX9FNzG1M26P0E12MEPOKm7jY08vw3Q7GN2xOy+KBpSaxHEdSZgnJGkqERfQpyRtj2jCkR6b3eKVFRejExYwGwoTv0B+IU69zJF5rIE0jlPs5NHkbiSMA+mfpKmme42FzREQhf5EBm2uctFvM7tBkajIH9WfZhbVFJPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GoUq1xVW; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GoUq1xVW"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6f0277767fbso1160847a34.3
        for <git@vger.kernel.org>; Fri, 10 May 2024 12:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715369194; x=1715973994; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=io8rTxaQ2DgUc9AK7cnciztD+6Z+pJ+OBUg94ndyN90=;
        b=GoUq1xVWnMhHCf+vN41fLug2s9KYnjvrBkb/H1DHr60kOlfJ6V6R1wCGvSrcvLDHC1
         3dPuPoE8ZziiHL+Sl9++i2JKorU+y4lna0y7R+ubv0W5O3Mt3radVeyBG1llKMB04tv3
         HPfOqosPBCkLbyeM66C6CgyzgN94FvwElAGqffgneYx7exLmReOxAnS4i5QZHPO4QP/2
         xDqKOGEfX/pRDINpfKeKN/KCSOfbvVrQJ/P6faURzETcGqqrYRRHJlV1O3AXQ4IUZkf3
         l+SB0aNG2eYjT1z0FMXxjFa5QSvFajZdD+yBdoM17DaOe9dinZYwd4F3Ky97c+XDNLJ7
         oqhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715369194; x=1715973994;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=io8rTxaQ2DgUc9AK7cnciztD+6Z+pJ+OBUg94ndyN90=;
        b=NtqZCylCzuIE09ws3sigJFLRtZL9iorHFnMWywke1StTk6lGfo3pAW4lB6dviZUAZi
         wXOasIBjBedxGo+qFMwY+bMN2Ya0G0kwisEMHLlXaudxqgjjgRvG1N2HmtZrqupzx2vQ
         lzgCsn0tp1fXCKF26ljq35bdxWFPzk6CWb8fWaM/0Y4r9Mxa7PLYUppZ3UEd8fARd2FN
         6SeNydCiUYmy5yN3SAoJy9UZXg1oAiWft+SNaFdo1Wf+wQk4+U8UpK/Fqe3f1OAABhfS
         Xzh6Mib3DSAX36fLBKKGfeiIOtzh8VWM4MArMbCN2Re1xC7dlCQl8fOH4EtiJ1ezJri6
         QR6w==
X-Gm-Message-State: AOJu0YwepFBvZbVHt66gB1gfQQLO7HpNIMujpCFWxRj57CS+/dRrzlnW
	VAkOSDu0LoFuCTj7lLNG3Xs3Qy3AIwcbyqgLv1c0pMr3pxA1pRWBu7DnmA==
X-Google-Smtp-Source: AGHT+IEroTCvwu1gZmTuESOqfRvRncN/44Y5SXWCCg+nxFmhtXhKJYP+WfVrth/hN3ElAOnhqrpHmQ==
X-Received: by 2002:a05:6830:1d8f:b0:6ef:7f93:13ac with SMTP id 46e09a7af769-6f0e929ffdfmr3691841a34.29.1715369194387;
        Fri, 10 May 2024 12:26:34 -0700 (PDT)
Received: from localhost ([136.50.225.32])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6f0e022be44sm792129a34.64.2024.05.10.12.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 12:26:33 -0700 (PDT)
Date: Fri, 10 May 2024 14:25:09 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 08/13] reftable/merged: simplify indices for subiterators
Message-ID: <uecirknp6pdo5amkv6kvfvxryiptqrgblttbu6dhz3vh74obzd@7dwnx3agsllr>
Mail-Followup-To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <cover.1715166175.git.ps@pks.im>
 <f0f42cd56b9e54e9c7d58be41fcc4e226d5c76ff.1715166175.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0f42cd56b9e54e9c7d58be41fcc4e226d5c76ff.1715166175.git.ps@pks.im>

On 24/05/08 01:04PM, Patrick Steinhardt wrote:
> When seeking on a merged table, we perform the seek for each of the
> subiterators. If the subiterator hasa the desired record we add it to

s/hasa/has/

> the priority queue, otherwise we skip it and don't add it to the stack
> of subiterators hosted by the merged table.
> 
> The consequence of this is that the index of the subiterator in the
> merged table does not necessarily correspond to the index of it in the
> merged iterator. Next to being potentially confusing, it also means that
> we won't easily be able to re-seek the merged iterator because we have
> no clear connection between both of the data structures.

Ah, I also found this a bit confusing. I think this is a good change.
> 
> Refactor the code so that the index stays the same in both structures.

Was there any advantage to not adding subiterators to the stack
originally? It looks like it adding them doesn't affect anything.

-Justin
