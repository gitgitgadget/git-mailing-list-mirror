Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A097610FB
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 19:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="McONPq+J"
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D6B137
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 12:37:59 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c9de3f66e5so330195ad.3
        for <git@vger.kernel.org>; Wed, 25 Oct 2023 12:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698262679; x=1698867479; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xz7ZXsYKgjQzhT5aI3NM1AX8UdEWmkB+zsbimNGpMV4=;
        b=McONPq+JxU80mmF534DspxLSIFziJcZGZ6Tqc7JWGjUU4hbz/1Vxv8IgcelRLx6Gra
         U0OmXC3F/gR/lN8bJlT0LygJ4p23v07lRr0u8oGECAzQtR5Xz5/Wr4AaS1ZFaZQBXURp
         /O88iPaiEuiJOfj4Xk+UZ4ZidBVJ81lBcIdVioklrcqJSWCSuH+2holE59JGUKUUS2F8
         r4T0g0frOUgrIm5B4Nn6ZuoBSLkQdwPIFayweRqzww3DH4DDTkSnJxUXgkgctm0/AHeT
         LRDPvHz6XKDcUlooJUHtUXx6cRfvA+Bv+/rNK5avszAfXjD0r6H2XRShYc0CgI5bG96P
         xnxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698262679; x=1698867479;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xz7ZXsYKgjQzhT5aI3NM1AX8UdEWmkB+zsbimNGpMV4=;
        b=dIbzE6/tMWlDeakiNzCYYmXJlF1vG14FPADS3vIJsAoQQy+CSMuJ+O1bJdtKrDZF/K
         HSO63HxmyBzSHgEpfVowv51rpZTa0Krb0S7XMLTdPggs6H3MpDH3JuwOrWS5e03MJGRM
         Vk6E8AVoJnSzwacSL7rVwuONV+97v62gowoKdTBoAgkgL9QN3DawAqQbCbKz8nF8+jnS
         /UU4u9rGcSI8ZhX64eElS+7TtFy0aL9GE908YpDATw8PgD8NN/TEUkBuiiZOHLVF6CO7
         PdjDgTMazs71mu/7Nk4PZKuoagrn9KUvudyITa/ZnaZ7eCbD4Aw7JN/i2SYyJQy6ymZx
         NZ2g==
X-Gm-Message-State: AOJu0Yx59UfjkkOSvmXe9Ry5rEkBm82EHxVMVFz3aCRdKLSRtMNQew85
	swWj7l6ndD7qm943F8PpX6jd7Q==
X-Google-Smtp-Source: AGHT+IGChhzcuMGhwu2NCV8x5ie7PVqphTcVQQ+Bzn49nf6ls8RHJw3XtTs31qom1NjqMYo8piT3TA==
X-Received: by 2002:a17:903:84f:b0:1c9:d25c:17c6 with SMTP id ks15-20020a170903084f00b001c9d25c17c6mr13103890plb.1.1698262678665;
        Wed, 25 Oct 2023 12:37:58 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:6c87:a9c3:39a2:c663])
        by smtp.gmail.com with ESMTPSA id jh1-20020a170903328100b001c55e13bf2asm9565724plb.283.2023.10.25.12.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 12:37:57 -0700 (PDT)
Date: Wed, 25 Oct 2023 12:37:51 -0700
From: Josh Steadmon <steadmon@google.com>
To: Jonathan Tan <jonathantanmy@google.com>
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, calvinwan@google.com, glencbz@gmail.com
Subject: Re: [PATCH v3 0/5] config-parse: create config parsing library
Message-ID: <ZTluW0Ha2W4NYaJd@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
	Jonathan Tan <jonathantanmy@google.com>,
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, calvinwan@google.com, glencbz@gmail.com
References: <ZTbK3QTJYXxYj/M6@nand.local>
 <20231024225005.1191555-1-jonathantanmy@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024225005.1191555-1-jonathantanmy@google.com>

On 2023.10.24 15:50, Jonathan Tan wrote:
> Taylor Blau <me@ttaylorr.com> writes:
> > But I am not sure that I agree that this series is moving us in the
> > right direction necessarily. Or at least I am not convinced that
> > shipping the intermediate state is worth doing before we have callers
> > that could drop '#include "config.h"' for just the parser.
> > 
> > This feels like churn that does not yield a tangible pay-off, at least
> > in the sense that the refactoring and code movement delivers us
> > something that we can substantively use today.
> > 
> > I dunno.
> > 
> > Thanks,
> > Taylor
> 
> Thanks for calling this out. We do want our changes to be good for both
> the libification and the non-libification cases as much as possible. As
> it is, I do agree that since we won't have callers that can use the new
> parser header (I think the likeliest cause of having such a caller is
> if we have a "interpret-config" command, like "interpret-trailers"), we
> probably shouldn't merge this (at least, the last 2 patches).
> 
> I think patches 1-3 are still usable (they make some internals of config
> parsing less confusing) but I'm also OK if we hold off on them until
> we find a compelling use case that motivates refactoring on the config
> parser.

Thanks everyone for the revived discussion here. I think I agree, this
series is not going in the right direction. Additionally, our internal
use case for this change has evaporated, so let's just drop the series.
We can pick it up again later if interest returns.
