Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794959306;
	b=J6zLY/bMhuK9BRMR2vv4jEPwN/sJydK+3lgQKCiMstbAQaGZlQ0PKN0VrxxKYIOQBnCV
	 kiRJzUf2h7z8m0vYUrmvpbilUEcx00pFRvKyovq+UUKMOSkX3wfTkIaZ0oFBv5iUHhqZ6
	 A3Zj1dB/Ygd0HgmtQX/gxGpBHnAlOGvZ5rMG0mPZyYbqcI9itqhfiBE0jEyWQDTFfCIOI
	 IlAp5jbtW77yjFc1KhkWNZotfhjHxfhLp7RpwBgo9qI1KOEhgVz4SwNuKPrSbfFKt//AC
	 a4Oi2VQVjZZrCttS3eQrfkT4zJWD314nkpxJOrEQcEkceBFOBxT9qet/SNoExipVz3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794959306;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=V03QOYyqCP+y3BShxjvxSdk4fLiu8aRN2MblyZK3KIQ=;
	b=OoGZZnDc6H1/JZ7LAkpmBnLHaJH+ybL5fULThseyEFMrFYhvcZfT92oMloT/BqHRsDsX
	 SKU5oKx2rGhgdFEvRQ7iznaxspeBRdY5z+KEzmuUAW98UWrfya7XT01sDyax6kxDrBZ67
	 aqBVxdFrYhl1toxTYnMJZ8KO+JLgPBzn6skFush1KurIFGfUPnSlAhpU6yavmK+/QZypG
	 5gZO34V0Zmkcqy3aXjFoPAwfaDCuF3XyW1EHpfJ9Toh9H6fcdmtS4yfFMN2PmUEOSt3Ux
	 fUYH6HA6UCi6roWQHhj7I96fUje8yvAPeTGd8QaJBj0roHy71/xZ6BkGSsnaItn5qVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OIVZkcKK;
	arc=none smtp.remote-ip=209.85.210.46
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C354C606A32A
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 23:48:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C354C606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OIVZkcKK
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-8629ef8613aso152500a34.3
        for <git@vger.kernel.org>; Tue, 17 Nov 2026 15:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794959305; x=1795564105; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=V03QOYyqCP+y3BShxjvxSdk4fLiu8aRN2MblyZK3KIQ=;
        b=OIVZkcKKRR4xlaAZnJlp3LIaXqdyk9iwlSJHRRcv+PEXZpxb5aPo9yucTQGq/Txiqn
         3dgHtCN8SdC6dZgtvWeWpsei4WVGIV97GBT9u1i2PaadUvSQSrhtP+EapS9/qNuso6uU
         rpSkOBTgwvWy6+hlnskbKgbulI3VrP+bFjT/UCKmV8ObzAHOqKXPtfpqN946w3re9gUY
         thi2Kp9vppfO11ITSAo5rSmWK6TBtVzOdTrW4mt9E82GdJrBIeulBj7bzjRtxTse1AM8
         r8YLwMjsHTMrGoFTsgXuz0D6V81I90j9rXmcCnW2o50cGa6q5Xq2C4Kpa60Zx4d0rJBf
         qhyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794959305; x=1795564105;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V03QOYyqCP+y3BShxjvxSdk4fLiu8aRN2MblyZK3KIQ=;
        b=yE4iew70KmzieJKW1PURuMLNZP0S8VIFkD85xffT9d+t3NxHycVShdbXR5g6fQvqkw
         uJMo/F2E5VegtIVMu1lySjMSSEIPnDfaajM/FRza4WOW3wfDWsGYrP3osSJyzU5hAN7j
         CBI7JZJC4UHhxFKtU/3MfeWL5n2mdJEy7AUODtX7Gw6bqZH3oNge6Tb3ngF6RIeomutl
         PFP3c/41dsbIdaxdxycgmwFjb0vpzLuhxm/P37aynO4J5FQ9ZsXDhvRGaoYburzuHsvI
         481ClSpECBOrphYhD2ElV4hLCt7NQHXM74KH60jpBM22IQUjm9ve6qUAXzpOslqhz3za
         iGjQ==
X-Gm-Message-State: APuU4Z/SjQNvNDLiZD0ueooPlVObLOOaa2LHPwTotBgy9lQxwcgmpsrv
	TiR4rdyEubEWMMcz6ced8JYOJBb5Hnswwbx1Z2X6T3lXUj56Iy2Ha6gwz9r/Sg==
X-Gm-Gg: AYBFou3bBxbXuRGi6prQmumUOFWMeBK0oYsFatkPzUZw6fq4qvByp4SYp4O2fB4lapk
	FnPIfZ3KR6PammwmuNWMnvgkZEfSaZHxWRg7Tqmmz+epLqFGEDwv4SURrUBy2f9KTEiH2SDGsCV
	SzCE/AjsMhXuOimTkyzk2z+PhpjF6WwvSxZv9UsIFjjjP8Bb03+5Xs04mNMo2BBqIBzNpGcje6R
	bzGwzFPvisLKUjASpw/q4vq3z4SfBUAcxd4EMxEhoIevIBVX2Uw7cXkEsf1oQzhQMVMgoMJ9Y7p
	pnrmYh4BciU08862DUbpeBkpwvTbKTP8z89y4mUvStcFN5gZJdd40rxha0WJpLynrPMfi1ouOk/
	sFr0gMnvStnUS4nsQ3ymAprlL/i/AGTdrydHRJSRFHnuJrYSUpP004X19k4GE4Ap3JkBzhv4lvr
	Ih6LBnq7vbgWznjUEVheV+VNjg1pfeunePYvNI2WEVgTVZinReZXM5klByfHuOZKiNA9Hv0YCbw
	/7jwLP4jEdBXRv9OV5/EJ7cQZEkE63aY6BUkpD8vU67sP7Aawxw5pkrzspVktxLBvHxdxc3sQfz
	Upm7oOqNVj/qha8kA223mxKbD2oBNTrYzktahKm1kDdwBU0GkOiNYq9cRkNv8rHqH846R/Ma2vw
	=
X-Received: by 2002:a05:6830:2b10:b0:81e:abb6:749f with SMTP id 46e09a7af769-862f08fa087mr933767a34.8.1794959304699;
        Tue, 17 Nov 2026 15:48:24 -0800 (PST)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-862f021aae9sm723557a34.18.2026.11.17.15.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 15:48:23 -0800 (PST)
Date: Tue, 17 Nov 2026 17:48:23 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/4] object-file: create ODB transaction temporary
 directory eagerly
Message-ID: <avznZz5351gjqPVQ@denethor>
References: <20261110002251.2007617-1-jltobler@gmail.com>
 <20261110002251.2007617-5-jltobler@gmail.com>
 <avRqiH9eIpJUGKMo@pks.im>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avRqiH9eIpJUGKMo@pks.im>

On 26/11/11 02:15PM, Patrick Steinhardt wrote:
> On Mon, Nov 09, 2026 at 06:22:51PM -0600, Justin Tobler wrote:
> > +	prefix = flags & ODB_TRANSACTION_RECEIVE ? "incoming" : "transaction";
> 
> Makes me wonder whether it's important to keep the "incoming" prefix
> here or whether there is an argument to be made that it should simply be
> called "transaction", as well.
> 
> That may be out of scope for this series though.

Ya, this is something I would also like to change, but I decided to
leave it for a future series. :)

[snip]
> > diff --git a/t/t0004-unwritable.sh b/t/t0004-unwritable.sh
> > index 3bdafbae0f..7292672a66 100755
> > --- a/t/t0004-unwritable.sh
> > +++ b/t/t0004-unwritable.sh
> > @@ -24,8 +24,8 @@ test_expect_success POSIXPERM,SANITY 'write-tree should notice unwritable reposi
> >  test_lazy_prereq WRITE_TREE_OUT 'test -e "$TRASH_DIRECTORY"/out.write-tree'
> >  test_expect_success WRITE_TREE_OUT 'write-tree output on unwritable repository' '
> >  	cat >expect <<-\EOF &&
> > -	error: insufficient permission for adding an object to repository database .git/objects
> > -	fatal: git-write-tree: error building trees
> > +	error: unable to create temporary object directory in .git/objects: Permission denied
> > +	fatal: failed to start ODB transaction
> 
> Not a new issue, but this second error message is awful. An average user
> won't have any idea what an "ODB" even is. s/ODB/object/ would make a
> lot more sense.

I agree. I'll add another small patch in the next version that changes
this.

-Justin
