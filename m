Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAA7199D8
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 23:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774999275; cv=none; b=Dt8GtcyLIW653Jrp7+qG3/cdegd5lUBzbcnywXVIDtlsRSiOXDzX5f4dEEV1mjODQ3IkvZCq5TwYKxUQ31G248BVrLxWdZ7CsfvJ3TzDgFU+Hpu4ZaH6i59hZ3TNQg+m6UShpHUxBp7znI5V4RIcCMotCzwACZxJ1ZbePPM/otU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774999275; c=relaxed/simple;
	bh=glGNl5w3zC//vs8OQyWjOsDHa18i0WlI9wJf6OULFOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F0Y7OvJqoEyC8X3CehWqufFRlYTB6LGFvE+1MtCsBTsxfHC0M4rZqzb+Sm+KoyB1Wn8F7rkB3U5DJ398LCYJhxuGKIT8Q/evK6OrEMYv95KnSTOAeAjLLQyYGfqRAmUNlIwNjDpmDTNo+XLRAVZGN9Td/cIJEN0x5pr/dKxf8+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VKdZ7QoR; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKdZ7QoR"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7d7653db148so3396596a34.2
        for <git@vger.kernel.org>; Tue, 31 Mar 2026 16:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774999273; x=1775604073; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kEMCUp/mvVvETgMrhV2kO6rJSQ8RDAVTK0UQdPdiKyE=;
        b=VKdZ7QoRzPsmISee/z5cXr3Xn/qFs/bOhY3Iz4hOm8so94yC/c5sun+PiWZ0nfZc/3
         n5GjjRFzBjgLaxfBhZcBfSn1gTBw7VWS8VZbUlhJCSwE5NDFIbJV+wogIAgIO/yaAxIp
         iT1q5shu9iVI7bF0WlmJtdFGtYBxCQ98qo3v2uHl2+5prQSEiKyAqnloNQQNq9zkGcQw
         8SGGbj1sJsjOCXyxQDRQ3DlXELndX74WUT8ABnhhTXSlgPb+p58zyzrNUOq7BAHxIN2r
         x/lNYV2xwnQQttCTV4GWw27lOm8eu6IRsAIRaTuXNPNkoJAymWZVXaGcr+Pa+zGzE3oc
         POow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774999273; x=1775604073;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kEMCUp/mvVvETgMrhV2kO6rJSQ8RDAVTK0UQdPdiKyE=;
        b=lv5H2VfS3rKxr3+ipAjzz/NOiqbJQ/k+t3s6BxPFOTF1WSaxf4UK0Kn5RHluUQXISl
         P4R71zo8m4kRecnxAP4KBaAKgHvRwUXZc7bfayCpP3C6vI00INhtLHL1F34Syxt6oOlt
         bOSRfhddPBN7VsvE0QIGJW96kxIBtSFtWbCoaULXOU1jR6IVElKWpxDkRJUBPv2nAqgM
         WgKkbtAXWzrrI9yPPdbINsIPleTIFrS1wUc62bOKUdkkMTAWWf+Z66ZjBqzkEKOPSOaM
         dNk5xUJkNwKZTD4AoPHM2Co1eyKq68roHofU4PumDXTwqWlNS2y/xY1y/wDJLQZVDe1r
         JVYg==
X-Gm-Message-State: AOJu0Yzuz6E4KSEn/gqCMxDBA20d7BtVmc/cmdJpbEDpCJt8nh47wCaQ
	airynl26RLXp+9mKrVUUAj5vMtXf8qW2qEW2jAzUldjR9oH/cJEsgtEMA/TWHQ==
X-Gm-Gg: ATEYQzyzzKlpeFBfNiaRCBJf8waXzE1kjd0rZMFbFODyxQmd7cCAdOjiJEZ29ZFJtTz
	WVq6vnonMXbP37MfUTfli6rBPeH4gxQWiUYtmWioW1IzQb6rIBH7h9QGGfIuRP3oybD4XsfU3H7
	r9qlUT+Sgj3R22wwrxuzMEyC0TDEBgMe89Yg/D6BU5oIoMWYvdDR4ksw11wFm5yw1U2fGCyfGyW
	jxzvHTA19V640oZMAis0ipfwLUzLU/rKd3726gwKHzNzv13UCUE9HvHi56d3tNHqL6qAFRdHjom
	tHyFs5brO/wwOidrHFIYQo0IuiCDoGNqMWHOWTVYxYtYsrbbaMv9K8aD/vq+TC/DLIv0cGFhbxd
	pKAWJSRZ76UhLqOwLZ/7XcBb3rByIoYvSEUNY2VAJgsn1tZo1GhoPn7kvKr0NskXbrvqSDSBKFj
	fJuG/aSmexDCRDLaZpxKh+HhpIgeg=
X-Received: by 2002:a05:6830:67cc:b0:7d7:d1e1:69b8 with SMTP id 46e09a7af769-7db99354c9fmr1079185a34.16.1774999272649;
        Tue, 31 Mar 2026 16:21:12 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7da0a87de2esm9008863a34.27.2026.03.31.16.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 16:21:12 -0700 (PDT)
Date: Tue, 31 Mar 2026 18:21:11 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 5/6] object-file: generalize packfile writes to use
 odb_write_stream
Message-ID: <acxWV5U-yb2F_0lG@denethor>
References: <20260331033835.2863514-1-jltobler@gmail.com>
 <20260331033835.2863514-6-jltobler@gmail.com>
 <act8YM8tMeUr3cJe@pks.im>
 <acvX8wdg39xTy-Am@denethor>
 <acxRwaUk4XNJiDx9@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acxRwaUk4XNJiDx9@pks.im>

On 26/04/01 12:59AM, Patrick Steinhardt wrote:
> On Tue, Mar 31, 2026 at 09:31:25AM -0500, Justin Tobler wrote:
> > On 26/03/31 09:48AM, Patrick Steinhardt wrote:
> > > On Mon, Mar 30, 2026 at 10:38:34PM -0500, Justin Tobler wrote:
> > > > @@ -1543,6 +1542,40 @@ static void flush_packfile_transaction(struct odb_transaction_files *transaction
> > > >  	odb_reprepare(repo->objects);
> > > >  }
> > > >  
> > > > +struct read_object_fd_data {
> > > > +	int fd;
> > > > +	size_t size;
> > > > +	unsigned char buf[16384];
> > > > +};
> > > 
> > > This interface feels generally useful to me, not just in this subsystem
> > > here. Would it make sense to instead expose it in "odb/transaction.h"
> > > as a new `odb_write_stream_from_fd()` function? No need to expose the
> > > structure itself, I guess.
> > 
> > Hmmm, exposing an `odb_write_stream_from_fd()` function could probably
> > be useful. Would it be better for it to be put in "odb/streaming.h"
> > though? Maybe the its use case would always be related to transactions?
> 
> For now it's certainly always related to writing objects, but you're
> right in that it is not necessarily related to a transaction. After all,
> we also have `odb_write_object_stream()`.
> 
> Putting it into "odb.h" would feel off I think, so maybe
> "odb/streaming.h" is a good alternative.

Ok, I'll put it in "odb/streaming.h" for now. Out of curiousity, is
there any reason `struct odb_write_stream` isn't currently in
"odb/streaming.h" already? I was thinking it may make sense to move that
interface over as well.

Thanks,
-Justin
