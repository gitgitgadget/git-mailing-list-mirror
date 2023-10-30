Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD661CFA6
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 21:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="fsl2Q78z"
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7FE10A
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 14:55:40 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-7789aed0e46so355596285a.0
        for <git@vger.kernel.org>; Mon, 30 Oct 2023 14:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1698702939; x=1699307739; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bz+IvQSMoCqG1j0UW66eKspY5rhFN85V3KRo7kuEzP8=;
        b=fsl2Q78z0HqK8NSez7wcn3ClcoveilAGJmnXGUdlUeHkUvlAhMV8ximfRH1Jmf3g9A
         7bYw6dJGUGiw7pdAQKJ9HMF5mPvgoZts3UE4IxULxcIB9aUo6ubrYsJSFZFXt6dvsn8v
         A8O6IkIlwh1cY8gz9Gx2hVqAOhX1FH0cqa8UUfo0dDp7wp5uyqcgN2bTDF8hJDwhS5yP
         PMPVdsIe0wIHuM+tL/AFsEKYMplLpLtgLTrpN2i360Bz37OpK7ZojaxJoxfAi/7UX6Cs
         lEOL8sFK78aqoGI7+O2jdC/JtQDbAG7bW7vns/cmAWYqt+RaL+L4/8oheJ2vEDyWhfQH
         y23w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698702939; x=1699307739;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bz+IvQSMoCqG1j0UW66eKspY5rhFN85V3KRo7kuEzP8=;
        b=jkQh58ftx4EcEfuas8RBVrrITnsUGqbhjSJfub7WW/3NEaQhIkMBBRY1RFLX83U/bX
         R0xrVo+8o3t/DHyJX8cu6tKh9Ci21IcDb54CoFEZWaOupmKeS0IgGCNUU7vbf4phx/uR
         q/JG9ghQdTfBrVdbQytAKguRHidta0LQTQnZCMAo1EDrHV519p/rndl9heQfnzZwNfVH
         /nfIO88Mi7GYoT0INJobXeTYBGpBvaMqkS2mVHwxZyO3OoEbkrghE2jRsN1A1wh1rYuf
         Cx/Af0IcGaxvyFa3ePzBk9KwMA9+a/DpxQu/UV+wxnt8fZk2rw6K89WH1y8nW0z6o0JZ
         DZVA==
X-Gm-Message-State: AOJu0YyLD3Z9nwx7goYcjD0Nb8Xelkdmj7kwx3KHW58nHVNa5RxgZ+cC
	jbgDPucOoGcde+A8jxKqMP2CWzZKF0xkuwdckaYACQ==
X-Google-Smtp-Source: AGHT+IEKIwtflfxLT6fj8ZrzU0g+0aZfQuU5gDDnYKkKrRei1i7MSU4gMq2LiHjwAdbdEX8r8MSWCg==
X-Received: by 2002:a05:620a:1244:b0:76e:ef17:d37e with SMTP id a4-20020a05620a124400b0076eef17d37emr10054651qkl.71.1698702939227;
        Mon, 30 Oct 2023 14:55:39 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id o8-20020a05620a228800b0076f0744ff50sm3667051qkh.136.2023.10.30.14.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 14:55:38 -0700 (PDT)
Date: Mon, 30 Oct 2023 17:55:37 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] Documentation/gitformat-pack.txt: fix incorrect MIDX
 documentation
Message-ID: <ZUAmWWh1WHujiN05@nand.local>
References: <cover.1697144959.git.me@ttaylorr.com>
 <af2742e05dff48c4ba0a9f36d58bcbfc052dca40.1697144959.git.me@ttaylorr.com>
 <xmqq5y3b4id2.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq5y3b4id2.fsf@gitster.g>

On Thu, Oct 12, 2023 at 02:54:17PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > diff --git a/Documentation/gitformat-pack.txt b/Documentation/gitformat-pack.txt
> > index d7153962d4..54000c9412 100644
> > --- a/Documentation/gitformat-pack.txt
> > +++ b/Documentation/gitformat-pack.txt
> > @@ -392,8 +392,9 @@ CHUNK DATA:
> >  	Packfile Names (ID: {'P', 'N', 'A', 'M'})
> >  	    Stores the packfile names as concatenated, NUL-terminated strings.
>
> Not a problem this series (neither this or the previous step)
> introduces, but I had to read the implementation of
> write_midx_pack_names() to find out what "concatenated
> NUL-terminated string" really means.  The code has a list of
> strings, writes each of them as a NUL-terminated string in sequence,
> and to align the beginning of the next chunk, NULs are added to make
> the whole thing multiple of MIDX_CHUNK_ALIGNMENT bytes.
>
> A naive reader code might implement a loop like so:
>
> 	while (ptr[0] != '\0') {
> 		endp = strlen(ptr);
> 		... ptr[0..endp] is one pathname ...
> 		ptr = endp + 1;
> 	}
>
> expecting that the terminating NUL of the last entry would be
> followed by a NUL, but that is buggy.  The sum of the pathname
> strings (with one NUL after each) may happen to be multiple of
> MIDX_CHUNK_ALIGNMENT bytes, in which case no extra padding NUL bytes
> will be there.  So the reader also needs to pay attention to the
> chunk size to notice when to stop reading.  It feels somewhat
> suboptimal.

I agree.

> >  	    Packfiles must be listed in lexicographic order for fast lookups by
> > -	    name. This is the only chunk not guaranteed to be a multiple of four
> > -	    bytes in length, so should be the last chunk for alignment reasons.
> > +	    name. Individual entries in this chunk are not guarenteed to be
> > +	    aligned. The chunk is externally padded with zeros to align
> > +	    remaining chunks.
>
> I am not sure what "externally padded" means.

How about something like this, instead?

--- 8< ---
diff --git a/Documentation/gitformat-pack.txt b/Documentation/gitformat-pack.txt
index 0bc80f0d46..229490f82f 100644
--- a/Documentation/gitformat-pack.txt
+++ b/Documentation/gitformat-pack.txt
@@ -392,9 +392,10 @@ CHUNK DATA:
 	Packfile Names (ID: {'P', 'N', 'A', 'M'})
 	    Stores the packfile names as concatenated, NUL-terminated strings.
 	    Packfiles must be listed in lexicographic order for fast lookups by
-	    name. Individual entries in this chunk are not guarenteed to be
-	    aligned. The chunk is externally padded with zeros to align
-	    remaining chunks.
+	    name. Individual entries in this chunk are not guaranteed to be
+	    aligned, since the packfile names can be of arbitrary length. The
+	    chunk itself is padded at the end with NUL bytes in order to align
+	    the remaining chunks.

 	OID Fanout (ID: {'O', 'I', 'D', 'F'})
 	    The ith entry, F[i], stores the number of OIDs with first
--- >8 ---

Thanks,
Taylor
