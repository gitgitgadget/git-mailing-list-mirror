Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3590612C474
	for <git@vger.kernel.org>; Thu, 18 Jul 2024 15:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721316398; cv=none; b=AYb/zQOzuDxtpftwGUFNcaWcajUwgjmNx4pxQbfut9NmJznITbeVxyn6HFEdNccrmn/OB/tZR4zRYirFZClND4XHOXGJEjNz41lj/cUjufL1uWh0FaCBfv80ivaTeRUXSGNfNwy0ttNGeV1iBj0lbPGW2z+DUoAZOD+WTijPLE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721316398; c=relaxed/simple;
	bh=mJZpiR024OMcwQvMFhvS7S91EhEjOf2f15ypyiodCNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sugo/cg7BchrgcNIKGPPLuk+Ix56GBx4xyIZZDZP/Y+INtZUj35bsfCOQZ4vedQiK/3uJmbfxF/qfRC3Qs7+LQYB1nnyEECwPJPoQKx9zpUUGHmLWDvETXCmP87o5mJN0kRwM104URqxGP7CbbFBiBGzoFERQDhH0G/i0I+SHus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LF4y4ED5; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LF4y4ED5"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5d31ef2c73cso507557eaf.3
        for <git@vger.kernel.org>; Thu, 18 Jul 2024 08:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721316396; x=1721921196; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CZxrckYXVKhX8Oh21QtWQ7lIGAR5kUbKoZoYXGxMUco=;
        b=LF4y4ED5gkVb9G3kDT5w9vHebh5/fiFGrT8h8+QaEmFDi3ihdlHn77ExbwGue4VEk0
         I4iaoAG2hQ0zmqkx1BSHH3oMAQTUtaCDjtXRmUr1oj3xKiKcNuvWFeAKFbMasDAdDOiH
         71Cu1SdjVT8Uq9f60mKW6QVvPi2WAcsG8qMpa8OBettEJbsUA0hxmxoiVxsWwtadoYLT
         EwxL3LMzGacP0EK3OponnMYV3LjMkZnt3IoAEZaKY0jePKsvPsW/SRn4o5Ibw01TezZa
         fPaGQLKxpKBwuSkmj8t6sQD87+E9k9bbgWDPoMlc0AcRZTMmLX4IoTNc6sKFLJRIAacS
         Wm7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721316396; x=1721921196;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CZxrckYXVKhX8Oh21QtWQ7lIGAR5kUbKoZoYXGxMUco=;
        b=vV328+OZ9COJXGFAmLMNP7z2VQq/4z27wj725DVvDJxpXepJeh2pSc3YjOCtr12BN6
         d9cHice3KIU/XKe8XRvxV3eDIxcN+3ajp0xmAH0V9YyEr1dDspeIkxL8xpgcY9YTOphP
         kiadTwgq7RQm/ap1joUnJEZw/wsk69AdG4+i/QRPwCj36j8atXDNoNMw46Da92DeUHYo
         valUB/Yj3SF1qKvpoj/8Q49uAn++mCATOEWo4b1A4r4Hyv68Tk0Cc8F5zn7FF/1xmDk7
         h9CSTK35fvWszWXqxPRVOKjYqPRlt7QZb8Z1RUuv9z3x8jSbS7Z/UVdSGeUrmEWXYX1Y
         Q2LA==
X-Forwarded-Encrypted: i=1; AJvYcCUbU/g+BymMVbfx7OruSSMs6auamNFn2fxqb5aNIByG/p4Nm3ypm65Kxvhf+WqIaAidomqfuxKBCI4lXU/Gp+M9y4tF
X-Gm-Message-State: AOJu0Yy/AAJZ4/tZ5Z9mrZADmqOLwYyNkGndFi+eouuFGKhiYujiQWzR
	RX9z5pO82l07HyXF1u+DJ2NvZ3KDU6Cv5MgTlsin21kFsTbZ/8ujBCTggHSY
X-Google-Smtp-Source: AGHT+IGDavQqw4lzHppyc/WPjV+len6RVbtwtMfH4ndxd4wFhT8IXIjCS9t8Rt4a2pQuSHy8QBRFvA==
X-Received: by 2002:a05:6820:260d:b0:5c4:13c0:f03f with SMTP id 006d021491bc7-5d41cade6c3mr5948408eaf.6.1721316396157;
        Thu, 18 Jul 2024 08:26:36 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5d3ca789d19sm602403eaf.11.2024.07.18.08.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 08:26:35 -0700 (PDT)
Date: Thu, 18 Jul 2024 10:26:00 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Chandra Pratap <chandrapratap3519@gmail.com>, git@vger.kernel.org, 
	karthik188@gmail.com, chriscool@tuxfamily.org
Subject: Re: [PATCH v4 2/5] t: move reftable/tree_test.c to the unit testing
 framework
Message-ID: <zjaj4aqjp6aa2vevgmhrrxegaum4nvv26kq3olru5z26bqd33l@4mgzgenvib4q>
References: <20240612130217.8877-1-chandrapratap3519@gmail.com>
 <20240716075641.4264-1-chandrapratap3519@gmail.com>
 <20240716075641.4264-3-chandrapratap3519@gmail.com>
 <CAOLa=ZQxDXDDWXQrt9kpykuMr6nxSA8uf2U2nu0ChTf3yuH8sQ@mail.gmail.com>
 <CA+J6zkQLXsDdSa5xjizr82bPUCng0-XZJRNQ1CAV7ttDbE03xA@mail.gmail.com>
 <irlg4rgsbfedphbxemj6pns35aceuwqrth6gyj6hi56fmr25n6@yvp4od2ydc26>
 <CA+J6zkRWzq_XNf-E7Nx4_D7rOOjN4Bwi4g3zgzV6YCiVoCe8rA@mail.gmail.com>
 <CAOLa=ZRGV1-3cDxgJd9zENTCEPqz04AFwWmkQnYwj5Cbg=EmfA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZRGV1-3cDxgJd9zENTCEPqz04AFwWmkQnYwj5Cbg=EmfA@mail.gmail.com>

On 24/07/18 01:10AM, Karthik Nayak wrote:
> Chandra Pratap <chandrapratap3519@gmail.com> writes:
> 
> > On Thu, 18 Jul 2024 at 03:45, Justin Tobler <jltobler@gmail.com> wrote:
> >>
> >> On 24/07/17 08:00PM, Chandra Pratap wrote:
>
> >> The `i = (i * 7) % 11;` is used to deterministically generate numbers
> >> 1-10 in a psuedo-random fashion. These numbers are used as memory
> >> offsets to be inserted into the tree. I suspect the psuedo-randomness is
> >> useful keys should be ordered when inserted into the tree and that is
> >> later validated as part of the in-order traversal that is performed.
> >
> > That's right, the randomness of the insertion order is helpful in validating
> > that the tree-functions 'tree_search()' and 'infix_walk()' work according
> > to their defined behaviour.
> >
> >> While rather compact, I find the test setup here to rather difficult to
> >> parse. It might be a good idea to either provide comments explaining
> >> this test setup or consider refactoring it. Honestly, I'd personally
> >> perfer the tree setup be done more explicitly as I think it would make
> >> understanding the test much easier.
> >
> > This probably ties in with the comments by Patrick on the previous iteration
> > of this patch, that using 'tree_search()' to insert tree nodes leads to
> > confusion. Solving that would require efforts outside the scope of this
> > patch series though, so I'm more inclined towards providing comments
> > and other ways of simplifying this subroutine.
> 
> Agreed that refactoring `tree_search()` probably is out of scope here.
> But rewriting the test is definitely something we can do.
> 
> Perhaps:
> 
> static void t_tree(void)
> {
> 	struct tree_node *root = NULL;
> 	int values[11] = {7, 5, 2, 3, 10, 4, 6, 9, 8, 1};
> 	struct tree_node *nodes[11] = { 0 };
> 	size_t i = 1;
> 	struct curry c = { 0 };
> 
>     // Insert values to the tree by passing '1' as the last argument.
>     for (i = 1; i < ARRAY_SIZE(values); i++) {
> 		nodes[i] = tree_search(&values[i], &root, &t_compare, 1);
>     }
> 	
> 	for (i = 1; i < ARRAY_SIZE(nodes); i++) {
> 		check_pointer_eq(values[i], nodes[i]->key);
> 		check_pointer_eq(nodes[i], tree_search(values + i, &root, &t_compare, 0));
> 	}
> 
> 	infix_walk(root, check_increasing, &c);
> 	tree_free(root);
> }
> 
> Wouldn't this have the same effect while making it much easier to read?

Personally, I quite like this approach. It's more up front with what its
doing and ultimately accoplishes the same thing.
