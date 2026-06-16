Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3700428A3FA
	for <git@vger.kernel.org>; Tue, 16 Jun 2026 21:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781643673; cv=none; b=o+NRgtiOjZ+Ffcch3ssOWUEHZvojvd9JJg5SVofaNkkwP+4Lpfn9gNLR5+tTlYP5i6P7KRru3vrlACQaE1TzwP/xhlmnf/sqGkZbsmE2iPmoXg/kHLwVb26n7otJOqOj671gdpukIqsYvXx8zBhcYOWp/nB5oWCD7ADd3eT7+5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781643673; c=relaxed/simple;
	bh=i9GsHdSY1L6/ckiaI2qYvj4mP1CGaK8OB/rkT7xlLok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j/q6+qs4sPgwC+D9YzVw6atZIHVn8VqKYYtvSKjItQ0+l0pmGljhjiDJBnaovxxhd0E9YQSo4IEAcqz4O0ggODNkrVTxn931I6iANaTELl5IHzWm1M3pMf6zBHKcrrVVMftMy6gOeykWEPBc+qO0vtDJqvwOP07de0OUBu6TqBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cGHrqwyk; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cGHrqwyk"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7e6e41cf7aeso2712002a34.0
        for <git@vger.kernel.org>; Tue, 16 Jun 2026 14:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781643671; x=1782248471; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uNP/tej8LSRpYyvX9fu301HfxoonXmT0Dma9IMw03HM=;
        b=cGHrqwykZ2XtUVbPBhEAZ2jEYfyge9F2Iz8KMhibaKQKIrem9Jnw3hc/5e8EMs88TF
         kMDQpMBhr9587roRVIS2rNtFjKaewoey4xdJlUap0VJuDhNalO+39UMabysNVpuxmSkj
         rqdehDjYxPxlePoHnsC0G5yqhIYG40uwS4VB3cm42stTb4Mcps3LR9AwTURAeRoToH74
         /jmvPfZoSGPZKGSSIHjSPL+DRDY/J3VEEOqaZaep6iKYmYpB1pTq1Y7MCZLffAJ4w+kC
         SOLjz/2yKw54VvmHt8sVUw7sXHXskzEOYGTwwZiYQT25JBkunazVlFUUbkNEIkWw33It
         d+lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781643671; x=1782248471;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uNP/tej8LSRpYyvX9fu301HfxoonXmT0Dma9IMw03HM=;
        b=qWPlIZvrKMdLuwRAMLMLZ24t0sxxtUT5aPXxY9/bElh9gvvAgrqeNjy5kPYpsHa384
         XLq1cc7cI4l8KYl4eXXkfPa7oZ0kqbX3q/0pdg5aOU0Zvubu0lDEBhCWyAvMXfZmOcS6
         sSj9k3Hmlg4zFFcCnQWNIbV0am/zw1AyxNerpQUjytnPBkc3/EsgaW6iyTZa4Dcba3J5
         WNPRWDG1YQcrYfFzhLVqXrS65sdwV2azheQgBEiB5ZNXCUn+NEjKzXv0NDS65UYH56rT
         WmIUHtNnj9m1BOoCfVClOMrO1ud5JmkGCPJYqCQj7b3C8N1tcVtaUtjYNQAb+GrT3NNV
         QfHA==
X-Gm-Message-State: AOJu0YyhwG2+75q4lOKB+I0Ux5nZAxcLcPeyY38Ld+/NujcwUqszlGpo
	2AEF567vN3n3e21SfVsMTJ5t+JVe6VUKl0HAa3lheVKVHzzA2yQlji+qfJ+5lQ==
X-Gm-Gg: Acq92OGVHIJBeXb9IIjmUw5boOlXbrR/iKfYkOIb7ocNFn1VDdw4IHkzPtIVm2LnDnc
	8AMZBynR4AXjFCJqeV424hEylCtmUzOKnk1Aryd+yo+i+GkDX/iCk1rxELA7NVmrJh6rNy0lpgL
	+ilnYe/s4mD59GcFwlCQq54iDetO7oBl/tTISPjYlHUlpGOKs+PkW+OX98TQWse+gmsPRDoZGpV
	gGmT/USZsq6pIShCP12bNnW1mMqnAPDh54knRsOHC8jmdXzmqgXZkDm1Vkb/+vI5ydewAiYJ9Ik
	hb8AGpw/A/WXOEXmEhDjAlgtsj0P2K4snP7Gxy9dopLKvnIpclWy36duSZwoB8uc6Vwy5psnWQo
	xAa1AYao7uTNTqInnoIUK0balCM0uftEDX6RRXARQc5D8hrrBNAHvmoSDiIthdUvIyEpv5lI2kW
	vrBkHQOShwnToGNgFY
X-Received: by 2002:a05:6830:6aa1:b0:7dc:dbe4:3f21 with SMTP id 46e09a7af769-7e90c63c6b1mr655808a34.1.1781643670939;
        Tue, 16 Jun 2026 14:01:10 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e79f5bb344sm8011227a34.7.2026.06.16.14.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 14:01:10 -0700 (PDT)
Date: Tue, 16 Jun 2026 16:01:07 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 01/17] packfile: rename `struct packfile_store` to
 `odb_source_packed`
Message-ID: <ajG3jqV4QHUMw-EN@denethor>
References: <20260609-pks-odb-source-packed-v2-0-839089132c8b@pks.im>
 <20260609-pks-odb-source-packed-v2-1-839089132c8b@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609-pks-odb-source-packed-v2-1-839089132c8b@pks.im>

On 26/06/09 10:50AM, Patrick Steinhardt wrote:
> Not too long ago, we have introduced the packfile store in b7983adb51
> (packfile: introduce a new `struct packfile_store`, 2025-09-23). This
> struct is responsible for managing all of our access to packfiles and is
> used as one of the two sources of objects for the "files" source.
> 
> Back when I introduced this structure I didn't have the clear vision yet
> that it will eventually also turn into a proper object database source,
> and how exactly that infrastructure will look like. Now though it's
> becoming increasingly clear that it does make sense to treat it just the
> same as any of our other ODB sources.

We already have `struct odb_source_loose` which is used in `struct
odb_source_files` which is a proper ODB source. Since it seems accessing
packed objects is moving in the same direction, the renaming here makes
sense to me.

> The consequence is that the naming is now a bit out-of-date: it's just
> another source and will be turned into a proper `struct odb_source` over
> the next couple of commits, but it's not named accordingly.
> 
> Rename the structure to `odb_source_packed` to align it with this goal
> and to bring it in line with the other sources we already have.

The rest of this patch is just trivial renames and looks good to me.

-Justin
