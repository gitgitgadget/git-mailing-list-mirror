Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B35315BE
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 15:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="AMD2w2ls"
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67EB53348C
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 07:58:33 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-66d0ceba445so32917586d6.0
        for <git@vger.kernel.org>; Tue, 07 Nov 2023 07:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1699372712; x=1699977512; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UheyL4Mhe1MWxOQXOaM7h3+lQ/D6+pPWxNSZMOSZX4Q=;
        b=AMD2w2lsadFf7lPrMNqvWxy4KsLNsLGI5IiXgKNa0JM24WZSf6tuxboWDZVhSZt535
         ocUw5bRgRCEKvoQ1Je4JSZkKtAHYr0di0F0fInF1Dmp66Wmiw+YZn/EyDuOUXGoeLX8C
         pCCyqLIR71KiIR9nWes5JVzYhZC6WZYnZV5XBJr65biZEnIdO3UC5PrYS1TFTGUkZLb1
         PMvTWEdnjSkGhzLEnpr5QgLdQinecQ5QFL+DkVKchejE/tH8cCRPBVO+LB+/DIOyvTvS
         h5hdzq2iWhjXwL0CqR8Q9wMYHH8WqRzgPwCLOyr6ezdwGItCJkDJYtHrFEvmGE3WFNPP
         Dipg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699372712; x=1699977512;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UheyL4Mhe1MWxOQXOaM7h3+lQ/D6+pPWxNSZMOSZX4Q=;
        b=RWtLEpO6/hZ89L+maQ4v3GeCWVddJkxYMLqaUKJfnAIRI2buQhaetSUF1hnTWrFIu5
         aQrODAanZXoSl7UF4En0r7rYRmDXWiBJffFrMPgj8OKStruHZjLJ22a4N9bKq5/Mcf02
         Qb1qGO2rwR/vWrhTR+izJnpGWlPfJ0ulRujLxXncLXGSfSJaIqyG2eDzj5XFucI7LdKD
         rHEU3QXN5MdgdLtREA8CAUUbFgFjK3gQKN77NCYrmzfLd2BYUNDvhwuLvyrF2Oejx1oZ
         0qST52or+SzwTVXVbabq0Z1+fM9bq9qMtiPShwMPUD9znPVzUUpdaLfrbhJM02BQA7FP
         Zn5A==
X-Gm-Message-State: AOJu0YyvT3aKJJyBlpYqrJ91pDk5gV7laBzpX4Ivhm3n3j8M+rZVIpQM
	9HhU4awuIbh4TQIT5SK1DiYbt+s4oXZNo2YZlKiDvw==
X-Google-Smtp-Source: AGHT+IESndU9Fl3N6RDV8OFXWkRFos3yaq8ybRCldYByCHtDZUoOamGcoYup6vekkegvL3EnWQLXrg==
X-Received: by 2002:a05:6214:21aa:b0:66d:d6b:f24f with SMTP id t10-20020a05621421aa00b0066d0d6bf24fmr33437480qvc.50.1699372712455;
        Tue, 07 Nov 2023 07:58:32 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z4-20020a0cfc04000000b006709b9f0a72sm11392qvo.22.2023.11.07.07.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 07:58:32 -0800 (PST)
Date: Tue, 7 Nov 2023 10:58:30 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Elijah Newren <newren@gmail.com>,
	"Eric W. Biederman" <ebiederm@gmail.com>, Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v5 0/5] merge-ort: implement support for packing objects
 together
Message-ID: <ZUpepnSCSxL8i96b@nand.local>
References: <cover.1697736516.git.me@ttaylorr.com>
 <cover.1698101088.git.me@ttaylorr.com>
 <xmqqo7go7w63.fsf@gitster.g>
 <0ac32374-7d52-8f0c-8583-110de678291e@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0ac32374-7d52-8f0c-8583-110de678291e@gmx.de>

On Mon, Nov 06, 2023 at 04:46:32PM +0100, Johannes Schindelin wrote:
> Hi,
>
> On Mon, 23 Oct 2023, Junio C Hamano wrote:
>
> > Taylor Blau <me@ttaylorr.com> writes:
> >
> > > But I think that this approach ended up being less heavy-weight than I
> > > had originally imagined, so I think that this version is a worthwhile
> > > improvement over v4.
> >
> > ;-).
> >
> > This version is a good place to stop, a bit short of going full OO.
> > Nicely done.
>
> I wonder whether a more generic approach would be more desirable, an
> approach that would work for `git replay`, too, for example (where
> streaming objects does not work because they need to be made available
> immediately because subsequent `merge_incore_nonrecursive()` might expect
> the created objects to be present)?

The goal of this series is to bound the number of inodes consumed by a
single merge-tree invocation down from arbitrarily many (in the case of
storing each new object loose) to a constant (by storing everything in a
single pack).

I'd think that we would want a similar approach for 'replay', but as
you note we have some additional requirements, too:

  - each replayed commit is computed in a single step, which will result
    in a new pack
  - we must be able to see objects from previous steps

I think one feasible approach here for replay is to combine the two
ideas and have a separate objdir that stores N packs (one for each step
of the replay), but then repacks them down into a single pack before
migrating back to the main object store.

That would ensure that we have some isolation between replay-created
objects and the rest of the repository in the intermediate state. Even
though we'd have as many packs as there are commits, we'd consume far
fewer inodes in the process, since each commit can introduce arbitrarily
many new objects, each requiring at least a single inode (potentially
more with sharding).

We'd have to be mindful of having a large number of packs, but I think
that this should mostly be a non-issue, since we'd only be living with N
packs for the lifetime of the replay command (before repacking them down
to a single pack and migrating them back to the main object store).

Thanks,
Taylor
