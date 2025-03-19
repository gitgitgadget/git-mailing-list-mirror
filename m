Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC571E231D
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 17:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742406640; cv=none; b=lCxe9PxBzn/lmyzmc/UEmkEDpKVpPh0eYzjL/xrHNqZYTU8w2FDI5PCTj6fGJMgsszPQOn0eIAe2D1z7Yd7oDUsqSW4IWDtS7/5dONUsteF6F20t/yn3QMBPT/qELFwR/ZqDbo4BHGciA3jeNX2TdrwCGaAb1bJKm9S7yUZTMwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742406640; c=relaxed/simple;
	bh=siOF+63JTs+lrBkhe5UyK41/zHVgYw7BnooK+bOxX04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jpyk9w0/cfO3vk/ll3ZRL8v89ayX0LTRicnyEIQqkWtRot2eY5hPcMATv23bhw0utxhLv4Is4hoL7bxphd3fUipfyqOWG8qV11N3ie2aMv85Ss1loyWgeYnLcTV5jOCRsYHWOnU8LTJM7oJAO3CV2u+aBEoc4uRDS1MAdqnanHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=I7AcbDnf; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="I7AcbDnf"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c592764e24so98840885a.0
        for <git@vger.kernel.org>; Wed, 19 Mar 2025 10:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1742406637; x=1743011437; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lcmine9A2eotyEFLy+cCeSwNlGcAD70NeU+bvVrIJiM=;
        b=I7AcbDnfrKrnKbVIIRtmVO3gkboolo7KRmCaMUwRVoaSkX9PopaRGRNmjG2gkkshRB
         HWchUsmv3b46FoSobTBC/waNnwMFcivIQkvf5VHVWcxUTBoWYXvsYeqIjTu+2RLVmtvh
         aG4lI+8LKGsz9k7qmUTuofy8q+ltBzb6w6ZQjCW5gg7h0vcAUN88atVABWa8sAusMtvm
         ejWB9rNhLca4sbIsMymgyfhS91qogM36dGsn40vVvxHK7izipYiHEygQ0DLt6nkxSTPn
         YkO6tdmIlSebzawptz9HLQTwqq5O69qnKX+EFyC74nxu+TjsRfHMDQYYAsijN1nc0JeU
         7Mvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742406637; x=1743011437;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lcmine9A2eotyEFLy+cCeSwNlGcAD70NeU+bvVrIJiM=;
        b=X+YYx07vireUU4X6liMfXWGfOOQk0hC0Ctp97Wm7fC+P11ngVTpF/j4tfOkm+nj6wQ
         DnYgooUz1hIiMQbQ0Qadl+C07kxEp2h37QTei5YK4M3TQ8m2dMZdRJ9sEmbFgtoyrgXT
         T42IGeh/Vd58avQpHhHgpn5pFK3/69Rvvt99pztng4Vrx65J3s9vrVhcYUa579A52dmT
         m62jied/BIWky/GsBqVVlFHNGDPluABNqOD+wb1FZEEUWmRek53IKwcnsYNwRonvB2OA
         fHmpSS7XzwBr7TSDFosHM33b2UQRw1m/zWFcD6X/gT1udcbXn72MJebFA18VeDpbp3Np
         1fgg==
X-Forwarded-Encrypted: i=1; AJvYcCUwjMq5c77RkQE/AVYf8TB6bTse0iHYQZ/qwysiJ6Cx7R4SDGUNmWIW6SkemoJaqVf0FhA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc0PjQVdnk5ForpkgBbDc8eMeU55EENZVlvJ/7uMyj7Aoaz+U8
	8nnq5I84/qysGu7XprF0CpPq0D3zH1NARrhozEypZNM/hL6dX20lhvKUAHSriP0=
X-Gm-Gg: ASbGncujxwJhdufEG6U/vYFhIKRooGuShYSQY1r+TV6sFklQgCxvYajjz/+w0awHkM7
	sHEC4zgM6HmnkbZeSZQShogz3nvMWNuepdXwajYmhviop/aMLDprMk/y4j6Bbn3Wy/omJ3V55Je
	kYAAWPgj21JV6X1L/Pq661JoLj1NsCLXk2wydgVbhBsGzLKq+oVROlWLBHTiAsCydan0Pq4YZFS
	SJ0qTiDSreriTY4jH7wCpOpg0s88fRs18uaE7s14hurd4eEqpjH4ym/42R2tbZlw6U77rZ/ZhNy
	UmppWH5+1GVKKVp74mEwRMtkyvMBmnld1oz+H9UkjQQ0vQBW8DeWo3adFsbGzRRw6TgrcCYOzS3
	F7gXFysMBkX06+4duurVz2XQ5AVw=
X-Google-Smtp-Source: AGHT+IEn55NRNCcReP9KcVt4OPxg1eDbYoVTQPieYu50N7/KM0yjNkb1snbaW3bjJBeVbT/yGi+6ig==
X-Received: by 2002:a05:620a:2981:b0:7c5:438b:78 with SMTP id af79cd13be357-7c5b04f238dmr62349185a.6.1742406637590;
        Wed, 19 Mar 2025 10:50:37 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c573c9e081sm885031185a.56.2025.03.19.10.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 10:50:37 -0700 (PDT)
Date: Wed, 19 Mar 2025 13:50:35 -0400
From: Taylor Blau <me@ttaylorr.com>
To: phillip.wood@dunelm.org.uk
Cc: Scott Chacon via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
	Scott Chacon <schacon@gmail.com>
Subject: Re: [PATCH v3 2/2] bundle-uri: add test for bundle-uri clones with
 tags
Message-ID: <Z9sD63+d+EQKSMXM@nand.local>
References: <pull.1897.v2.git.git.1740825238.gitgitgadget@gmail.com>
 <pull.1897.v3.git.git.1742312173.gitgitgadget@gmail.com>
 <d148b14c390f74e86bfa14c05e9e186fdcecbeb8.1742312173.git.gitgitgadget@gmail.com>
 <e4244e04-d2f3-43ab-88cf-58d9804731b8@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e4244e04-d2f3-43ab-88cf-58d9804731b8@gmail.com>

On Wed, Mar 19, 2025 at 10:33:48AM +0000, Phillip Wood wrote:
> Hi Scott
>
> On 18/03/2025 15:36, Scott Chacon via GitGitGadget wrote:
> > From: Scott Chacon <schacon@gmail.com>
> >
> > +test_expect_success 'clone with tags bundle' '
> > +	git clone --bundle-uri="clone-from-tags/ALL.bundle" \
> > +		clone-from-tags clone-tags-path &&
> > +	git -C clone-tags-path for-each-ref --format="%(refname)" >refs &&
> > +	grep "refs/bundles/tags/" refs >actual &&
>
> Thanks for adding this test. Calling "git for-each-ref" followed by "grep"
> follows the pattern of the existing tests but I'm not sure why they don't
> just pass the pattern to "for-each-ref" and avoid the extra process.

Indeed.

> Do we want to just test for tags or are we really interested to see all the
> bundle refs created when cloning? This applies to the previous patch as well
> - we obviously need to change the expected output but I'm not sure changing
> the ref pattern is necessarily a good idea. After all the point of this
> series is to create refs under refs/bundles for all the refs in the bundle.

I think we should be testing that all of the refs we expect to have made
it over actually did so. This diff (applied on top of your series) does
that:

--- 8< ---
diff --git a/t/t5558-clone-bundle-uri.sh b/t/t5558-clone-bundle-uri.sh
index b1276ba295..9b211a626b 100755
--- a/t/t5558-clone-bundle-uri.sh
+++ b/t/t5558-clone-bundle-uri.sh
@@ -128,13 +128,12 @@ test_expect_success 'create bundle with tags' '
 test_expect_success 'clone with tags bundle' '
 	git clone --bundle-uri="clone-from-tags/ALL.bundle" \
 		clone-from-tags clone-tags-path &&
-	git -C clone-tags-path for-each-ref --format="%(refname)" >refs &&
-	grep "refs/bundles/tags/" refs >actual &&
-	cat >expect <<-\EOF &&
-	refs/bundles/tags/A
-	refs/bundles/tags/B
-	refs/bundles/tags/tag-A
-	EOF
+
+	git -C clone-from-tags for-each-ref --format="%(refname:lstrip=1)" \
+		>expect &&
+	git -C clone-tags-path for-each-ref --format="%(refname:lstrip=2)" \
+		refs/bundles >actual &&
+
 	test_cmp expect actual
 '
--- >8 ---

While writing the above, I wasn't quite sure how to follow the test
setup. It looks like it creates the following structure:

    $ git log --oneline --graph
    * d9df450 (HEAD -> base, tag: B) B
    * 0ddfaf1 (tag: tag-A, tag: A) A

, which we could do with just:

    test_commit A &&
    test_commit B

But even then, I don't think we really need to have more than one tag
here to exercise this functionality. So I think it would be fine to
simplify the test to just create a single tag, which a simple
"test_commit A" should do.

Thanks,
Taylor
