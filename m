Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAE45381B
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 17:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725558674; cv=none; b=hoD+lUG33xdVMUdt2kp4+MEDGSrlOqClXPBd8C6rMEuD0VRZraVqrNxEyjmnRcb3fyCpd+UtZGNfX1HmpbapoxZFKSa740tHlzblyQ+V9lNdkOp218ozlwGaGvO83E0LlgsV0ghM+2hhqgUCqdlvWDQMnkv48jmX27K5nh1mFwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725558674; c=relaxed/simple;
	bh=wQXeTfLXb8fQZJ6aNIqCRVtozL5tiNUDf8NNEEdavsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GUAqlO/2Sts4EpwsDk0ncWzuFDmP+SXsQo2r7PPOCTpLTkQ1tmYTNxRBnqVwU6z7YE1luDwGEwhBKTerWDGgtS/ZBh30nYMgG8xtDSe+sRhUlI5iASftMLI+fi468ruXUW1SfSPru/K3EPWlXUU0pq61VYiGGoiRlfTAi4UCm0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=pjw+1hLo; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="pjw+1hLo"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e05f25fb96eso1208283276.1
        for <git@vger.kernel.org>; Thu, 05 Sep 2024 10:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1725558672; x=1726163472; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=din/Qtm5sP0cMfcE4GRA42ABDpy5UXvm99F1YJfJdpY=;
        b=pjw+1hLogukjFKu1RPrDFSBFIwD065dEyz/pviM3GS15BsIh7+upYHPi4LvmWxrIIu
         IVGi0+qW02wdh+81aJfjZBEZHpsmD5FjQ0xTZH7HQSqKNfWIlJzk4Lg/3cwxCnyvNaXV
         FBCoXEFr4fshNlSuoyvNc8AupuA1ga8IU0s/e7yRpFrZpZTkkQZ2OgpGW4G/o4Lcq3WY
         NwiNqJkRlQaVP6XhNT3TWnWy/dhh4Y8UaW8Zd7RlLfuaubNcPoXvs9kc55N8Xvz8Yx64
         GUSw+MvANPMnIOSzJ1kafdndRhXL3x61qbymbPJtiTGWe/pT1HdQ+NzGcCifK4YVHHoX
         XcPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725558672; x=1726163472;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=din/Qtm5sP0cMfcE4GRA42ABDpy5UXvm99F1YJfJdpY=;
        b=iLpPU9nW+a9xAb2TFOnSQGQ3Kc6CuPbC5P5iDftVAPuZJ7QUTBuB+BcqV7HMSXSbBc
         EnxrLSBTAWNVWbZFhEsLUrNBl6teizZkTsK97Xc3TBMWNhO+kHhvgVKvYPsuBN/8Vy3Q
         0AGZNoHlTWWJTYKRHWtMD6z+0LZWSA9AIZi2rh+19/Kjx2PfzIyvWhX+iORhCXejGbz5
         xLoDxN98CllGK+/jaTex2fVX9KNVhrtVuWSHbq6BtPSo1aj7H+oKXJcxBJBuBoulmz99
         Jy71bOqKHKIO9+1jT4Z9vAtBE0RldLmEYDBPI4Pyl51OOibVfxecSEjiYntarpP3B2gT
         prLQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9I3ipeUZPSOWnwmShPrQWpQZanCvBAH7eQqvrOB0Da0VnYc+nQn80InWAW1PyKexf4no=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYeiNEdNFQ6oeWfgNw3lFzT9ugW/SBNd8FXwTBBQ539Yz+Dj/B
	GLkjO5s8QQ5MF1IFI9RJ/Qfv3uTzh/XC3fuFgMv8CrHFAobH78NmSj+8B2pYaAc=
X-Google-Smtp-Source: AGHT+IG3hqJEht2MgQ4awUBqBOBG0Kkzi407mC+3k9mj5kDuxh/7/lEjt3RC/803WSdDajUB2eWDvw==
X-Received: by 2002:a05:6902:1895:b0:e0b:bfb6:ee86 with SMTP id 3f1490d57ef6-e1d348a2a3emr33594276.26.1725558672140;
        Thu, 05 Sep 2024 10:51:12 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e1ce191f839sm1760884276.31.2024.09.05.10.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 10:51:11 -0700 (PDT)
Date: Thu, 5 Sep 2024 13:51:10 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 0/4] hash.h: support choosing a separate SHA-1 for
 non-cryptographic uses
Message-ID: <ZtnvjlW3DotdK/lB@nand.local>
References: <cover.1725206584.git.me@ttaylorr.com>
 <ZtXG2cEbxr8pNg7j@tapette.crustytoothpaste.net>
 <Ztdn25zfi8WHO+GS@nand.local>
 <20240905103736.GC2556395@coredump.intra.peff.net>
 <xmqq34me5crn.fsf@gitster.g>
 <ZtnbFXL7W5DvW8UN@nand.local>
 <xmqq34me3uyz.fsf@gitster.g>
 <ZtnkovOqrJNxUtez@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZtnkovOqrJNxUtez@nand.local>

On Thu, Sep 05, 2024 at 01:04:34PM -0400, Taylor Blau wrote:
> On Thu, Sep 05, 2024 at 09:51:00AM -0700, Junio C Hamano wrote:
> > Taylor Blau <me@ttaylorr.com> writes:
> >
> > > If so, I agree, but would note that this series does not yet switch
> > > index-pack to use the non-collision detecting SHA-1 implementation when
> > > available, so that would not be a prerequisite for merging this series.
> >
> > Hmph, I am confused.  It needs to be corrected in order to address
> > collisions of the tail sum Peff raised, as no longer checked the
> > tail sum with SHA1DC but with "fast" SHA-1.
>
> Peff's mail supposes that we have already modified index-pack to use the
> non-collision detecting SHA-1 implementation. But this series does not
> do that, so I don't think we have an issue to address here.
>
> In a hypothetical future series where we do modify index-pack to use the
> _FAST SHA-1 implementation, then we would need to address the issue that
> Peff raised first as a prerequisite.

I verified that this was the case by applying only the following to my
series:

--- 8< ---
diff --git a/sha1/openssl.h b/sha1/openssl.h
index 1038af47da..f0d5c59c43 100644
--- a/sha1/openssl.h
+++ b/sha1/openssl.h
@@ -32,6 +32,8 @@ static inline void openssl_SHA1_Final(unsigned char *digest,
 {
 	EVP_DigestFinal_ex(ctx->ectx, digest, NULL);
 	EVP_MD_CTX_free(ctx->ectx);
+	memset(digest, 0, 19);
+	digest[19] &= 0x3;
 }

 static inline void openssl_SHA1_Clone(struct openssl_SHA1_CTX *dst,
--- >8 ---

and then creating a victim.git repository (which in my case was born
from git.git) and then repacking to produce the following state:

    $ ls -la victim.git/objects/pack
    total 262704
    drwxr-xr-x 2 ttaylorr ttaylorr      4096 Sep  5 13:45 .
    drwxr-xr-x 4 ttaylorr ttaylorr      4096 Sep  5 13:46 ..
    -r--r--r-- 1 ttaylorr ttaylorr   3306804 Sep  5 13:45 pack-0000000000000000000000000000000000000003.bitmap
    -r--r--r-- 1 ttaylorr ttaylorr  15588224 Sep  5 13:44 pack-0000000000000000000000000000000000000003.idx
    -r--r--r-- 1 ttaylorr ttaylorr 247865480 Sep  5 13:44 pack-0000000000000000000000000000000000000003.pack
    -r--r--r-- 1 ttaylorr ttaylorr   2226788 Sep  5 13:44 pack-0000000000000000000000000000000000000003.rev

Then I set up an "evil" repository like in Peff's recipe and started
repeatedly pushing. fsck is slow here, so the loop is just "while true",
but it doesn't matter that we're not fscking the victim repository since
I'll show in a second that it's not corrupted to begin with.

Running this loop:

  $ while true
    do
      ls -l ../victim.git/objects/pack/
      git.compile commit --allow-empty -m foo
      git.compile push ../victim.git HEAD:foo
    done
  $ ls -l ../victim.git/objects/pack/

, fails very quickly and produces the following:

    [main 727346d] foo
    Enumerating objects: 12, done.
    Counting objects: 100% (12/12), done.
    Delta compression using up to 20 threads
    Compressing objects: 100% (11/11), done.
    Writing objects: 100% (12/12), 779 bytes | 779.00 KiB/s, done.
    Total 12 (delta 10), reused 0 (delta 0), pack-reused 0 (from 0)
    remote: fatal: final sha1 did not match
    error: remote unpack failed: unpack-objects abnormal exit
    To ../victim.git
     ! [remote rejected] HEAD -> foo (unpacker error)
    error: failed to push some refs to '../victim.git'

The victim repository rightly rejects the push, since even though the
evil repository generated a pack with a colliding checksum value, the
victim repository validated it using the collision-detecting /
non-broken SHA-1 implementation and rejected the pack appropriately.

Of course, if index-pack were updated to use the non-collision detecting
implementation of SHA-1 when compiled using one of the _FAST knobs,
*and* we did blindly updated index-pack to use the _fast variants
without doing anything else in Peff's mail, then we would have
corruption.

But I think the point of Peff's mail is to illustrate that this is only
a problem in a world where index-pack uses the _fast SHA-1
implementation, but does not have any additional protections in place.

Thanks,
Taylor
