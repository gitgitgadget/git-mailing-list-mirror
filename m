Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44218337692
	for <git@vger.kernel.org>; Mon, 15 Dec 2025 16:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765817335; cv=none; b=kFx0bvU8k/HlPvTDJP90uuyITXFmC9kGONTKu/Xjc/0oAWd3x+VAs5aw7Q1j9Jy8//rm/GgSVg51uhOXo8mn5vrxYkz/a51H2g4U6FKEYQi2Q9YlFZWZS20SURpIojk8OYbGTWJknFrSOE06qpofm6fFb7mGZ7vBezYBV6NcaXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765817335; c=relaxed/simple;
	bh=IK7GQmMDURtGMmeETMu1rE4iskx16WB6qfqCk/XxZMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uwq2ml+47cHVzDVFLl2TFP56ElXLVbyHo4Cy1vQalCJApo+TEoPyMEK0VGpQJ76qqU5KjaF0LK5dkAg1/2yb5a0zbTib0yre7Q6ixMzBvTer4yG+j7+qjhThcKlR5bPxq9Y08gS1QcWVtUP0+aPRSsYtkfr9kAK/xGNMnZ+mda4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bawq+xFh; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bawq+xFh"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7c52fa75cd3so3308181a34.3
        for <git@vger.kernel.org>; Mon, 15 Dec 2025 08:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765817333; x=1766422133; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fts5Sl+aRSQrm3Kq6f2xPV5qD38/IV0QiSJzrl4MbLQ=;
        b=bawq+xFhrDjKGQM4n7JTrY957f6gYFuAOh46m9CUXpNTkpRKoIr0PQpKc/bOURSvQa
         cqJ9GQ+TNmUwr4XDXcFPXAQ7ryeGBIi5o6bpLxyn8s+ScCmkeP15ovklSePetZrEzjRJ
         A1YjPeJHUvMJQEqbta4TlNPV7agJUESx/wCjZ4Hk684a13sTq9gET70ymZfwb1DHAqg0
         eM3XlKftxPsw1TZ0rsWmIqRa2YU7Lv1AnyER1+9qVLkXRuyR7l1cvVvpmxgusje7BHa1
         5xhXYc6sTn3zZFXKiAxWTDzhjjLsNUSc/zKCb45c31xIDOpns2a9AKpxvqspVs4c6xGE
         5uGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765817333; x=1766422133;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fts5Sl+aRSQrm3Kq6f2xPV5qD38/IV0QiSJzrl4MbLQ=;
        b=pcZsz3Fcuj+wG1eA0gl1PLGTePRpoC7+yYUui9ZtLn0Awn4iaJyl19LECeHe0CwwaH
         wW+VuyiO1XIMQkiaQoa0MDNi0MDhmildVBp6D4OEDCqrCNSHiNX6gHiGW13O8sGaSabb
         M31C5ren5kynXL/DRAP71oW6vo1aZP4r9AIigo6g7B4tphgF0HezXdcgujmhOiBDWdPe
         89KuKnA3UCzsfGKg41gmh42vUqEOX19jAbzP3M14NCC7SBmw1IeN5ZWydkPPgbLRQbqg
         qxdMpeDZr9MsQlU8K8cOMVFh4F8ZZ8hBWjMI0os0EDJbZv6e9wPSKPZ1+OoxGwJjh0uk
         RBcA==
X-Gm-Message-State: AOJu0YwDWQFAxPtJ/5fQi3ZvQlK0Ipp+t80Ma9IuH1dxZo+2UctQvoOO
	nTc7q2du4iQYw/wWGKOP0V4f7p0ECgOQH9PROdNSganHZxW2ZvLGLJzP
X-Gm-Gg: AY/fxX4x0SV7JuEoMz0p8jxxvQRTwIdhsVz2SbgOXOWdgrZd9/WVFE/eTLYcbMA+eNP
	O1giZQ8hsSByQrGcW2OLSVvgtyKNaqmJhXNSgWQ69KgScxw3iGVGq4M2oZwnBinQ04EbLndqRMD
	sDKVvjNovhGDzXI7KkxNIgP/ZVXvPDlvXZZDwKooWVVhCM5lH/o3fwTzDzuCpW6pEAdgDEuVR9K
	y29mw2sDZQ2PQad6Vbol4SBePHfzQ3Gkm9LTukiBkVNdn+U2fJd+w29+vY1bOAFwN8BaYXt4itN
	f+PYj6ZY67rC9/CCOEHrMr+xQbmIxEDDcouM10SWlfM0WUSA3+K6MBLM17ei6UHmGWgSGLL7UDy
	r4YbjmKCkfLDsCx1sWlURDXymUmFpqvHbW1ed0/UhQItYNTIXwtPLw3PadOtYcnVyoufZ829urX
	gZGod1
X-Google-Smtp-Source: AGHT+IHO76vZgObvTlz+soYYA/mrWABpRy+JjGldMHCwl+ALjGFxioG2x0soWJKHhbWDJ5XAN0REVQ==
X-Received: by 2002:a05:6830:25c:b0:7c5:3013:e50c with SMTP id 46e09a7af769-7cae83a0454mr4645749a34.33.1765817333353;
        Mon, 15 Dec 2025 08:48:53 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cadb1ff5desm9766992a34.12.2025.12.15.08.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 08:48:52 -0800 (PST)
Date: Mon, 15 Dec 2025 10:48:52 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2 4/7] builtin/repo: add inflated object info to
 keyvalue structure output
Message-ID: <vleglpqcjwzse63actqknbwdykvanzszosbflems33ntt3swoa@f7e3zsfatkoe>
References: <20251209225820.2861276-1-jltobler@gmail.com>
 <20251212223644.3090879-1-jltobler@gmail.com>
 <20251212223644.3090879-5-jltobler@gmail.com>
 <aT-doNe94GYmodQl@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aT-doNe94GYmodQl@pks.im>

On 25/12/15 06:33AM, Patrick Steinhardt wrote:
> On Fri, Dec 12, 2025 at 04:36:41PM -0600, Justin Tobler wrote:
> > diff --git a/builtin/repo.c b/builtin/repo.c
> > index d3dfe416d0..3a2d15cec4 100644
> > --- a/builtin/repo.c
> > +++ b/builtin/repo.c
> > @@ -500,20 +513,38 @@ static int count_objects(const char *path UNUSED, struct oid_array *oids,
> >  {
> >  	struct count_objects_data *data = cb_data;
> >  	struct object_stats *stats = data->stats;
> > +	size_t inflated_total = 0;
> >  	size_t object_count;
> >  
> > +	for (size_t i = 0; i < oids->nr; i++) {
> > +		struct object_info oi = OBJECT_INFO_INIT;
> > +		unsigned long inflated;
> > +
> > +		oi.sizep = &inflated;
> > +
> > +		if (odb_read_object_info_extended(data->odb, &oids->oid[i], &oi,
> > +						  OBJECT_INFO_FOR_PREFETCH) < 0)
> 
> Using `OBJECT_INFO_FOR_PREFETCH` feels a bit weird to me, as we're not
> in a context where we want to do a prefetch. And if we ever were to
> extend that flag to have more semantics that are relevant to prefetches,
> only, then this code here might become broken.
> 
> Using `SKIP_FETCH_OBJECT | INFO_QUICK` does make sense though, so I'd
> suggest to expand the flag here.

Good points. I'll update in the next version.

-Justin
