Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBB2466B44
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 17:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782752513; cv=none; b=e51kFKzlai+4wSGlo8ZLf3Tu+t0MIZ5YLKcGvw0GhZKOD/couK9hJMqGm1hCDre2/ua8IDCsHUBgEwGGrFjs/nhF7doL3EouA0lDTWRYf73GN6qAUlCMq/5+b5o/IJq72LoKBly+IOJsHoAV/e3ybaT3aOqtlD4QVAso3Y6QWkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782752513; c=relaxed/simple;
	bh=ML1+q5Vnw8F8lLkgKxyRiOxbd3q6PDaEB9JN86N9w08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QFmQmO/BaI+EpEx49fA9hwgLPcbTkipvTLwaqpNyebXOjEYcYlsK2c7gDs+aMX0/h/fdVvv9DMkkFAQ7xWZWYpx3gxHYYB+3UUBnWv7fVaBEQc6C4/MV3mWapdfvS2abFT5iWpVtjLqRemPv2xXVH798a770aF2eThSLTlRfjgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IqY2giYs; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IqY2giYs"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7e9483cd614so3423423a34.1
        for <git@vger.kernel.org>; Mon, 29 Jun 2026 10:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782752510; x=1783357310; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ML1+q5Vnw8F8lLkgKxyRiOxbd3q6PDaEB9JN86N9w08=;
        b=IqY2giYs0MzZg4ipY4JteSpHYmyblQBisXujDF0KgsnY919YRqheKEtrTiYJVZWNQz
         jw1H6UhKHTduXPwFdThY3DWWGxFbPtxnLR6/HH1PvbAldQYc0jdUO8CJ+3OJAdMra63y
         umn2zXGUPDH1JPzapnsLz0UutS5PzIYzLufDo7Kbb6B+A1k96WeihdbBST1hrizeZdPE
         RmL6Kn+w8muZm7LEblZhMVvdwuLN7gtzPZPdpBsdKtXsq1lJ5nRBeWYa0EtMqCp9kCPK
         Ga9mSumUXsmp4t0QlHAV6u9ZnJ6k26nwCjcaES8aQjSf4VV9e6+5HB5GlvhKymO006z1
         /MNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782752510; x=1783357310;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ML1+q5Vnw8F8lLkgKxyRiOxbd3q6PDaEB9JN86N9w08=;
        b=PdZ3Xw6/k+BJJ+iEE3jLhgd+Url3pHICvHf2BdqrPy6bZ23LiT87WUWn03l2H45t2n
         opeatFBXrLYqEdraoS8iQqH0Oc3BjHU4/caERC884ifhPDZ1hhoil75FEFUA2bMtIU31
         DGiv99FCtbSsjNFxOxTCJJWujFYN3n1W8d+zuokxwSEkFEGpFA0d0iwhLLYBm2gzRheb
         IPmI326ZUm4g4udjevnfuI3ntPfRpv6I1MgNOyHK1Y/+v5bB5B37XX6TLh6LQ7iX7FHu
         FPn4os9RCB0WMxEUfFq5U3j52CW/iemQC9YCg0WepvdCd9hwV9b+Y+7uVDH74S++o6Ah
         v+Ew==
X-Gm-Message-State: AOJu0Ywp9bTn0TlfusnKNFCe4ti1bLJD6UljK2YdOhEoJr3IU+buNNXX
	S1IYu1qXbHHaz+/G0hJdSk9w+ldobGasRQhSOtvpDXISEcNpYfB8BvAgz5uFdQ==
X-Gm-Gg: AfdE7cnpPojxzMXrLXip28q5rEqtOqQFxE6mUtvsyCuFzM1FmSJrcDIlt0sSctjlEdw
	45SASYFZLCnhgFvtABd+4igvpcWn6IDC/P/iDa3b3Bgb30qmrKy+p2+NaOfMJki3/YlIzKCYsnB
	UYPVM2jaUTYdK3ZjlmOvqiLO2SS2O6w7zhcSrp7eWa/ttNR10F8d23w5QUCDl7cOBfobtdNJ2F7
	YdGfCFxSF+mrFi68GCQvALIsvTy956SYtrtxdbaY+Zlvolt/xyuzA7FUvYwpKfrYDT2Kn0uFt18
	DIiEBp8h5cPuiM0GMrL7290isgOzp01Z/NWZfeX316YmbT96ka632DlOB3bz36gWqRxoSKfQMPH
	ZbSW0vnWYXaWct4y1NcE0Qa6vJfMKkOyIKlTDGm5oe31DU29a8/3y3VtAivkrXgTO1oMGIN7ygR
	9ait5UDQ==
X-Received: by 2002:a05:6830:10d0:b0:7db:a297:9e62 with SMTP id 46e09a7af769-7e9ecaf8256mr109386a34.8.1782752510032;
        Mon, 29 Jun 2026 10:01:50 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e9ebfdaa63sm243527a34.10.2026.06.29.10.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 10:01:49 -0700 (PDT)
Date: Mon, 29 Jun 2026 12:01:47 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/6] packfile: thread odb_source_packed through
 packed_object_info()
Message-ID: <akKge0zmT3WSfdyz@denethor>
References: <20260624-b4-pks-odb-drop-whence-v1-0-8d1877b790ac@pks.im>
 <20260624-b4-pks-odb-drop-whence-v1-1-8d1877b790ac@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624-b4-pks-odb-drop-whence-v1-1-8d1877b790ac@pks.im>

On 26/06/24 02:19PM, Patrick Steinhardt wrote:
> Add an optional `struct odb_source_packed *source` parameter to
> `packed_object_info()` and `packed_object_info_with_index_pos()`. This
> parameter is unused at this point in time, but it will be used in a
> follow-up commit so that we can record the source of a specific object.

Ok so `packed_object_info()` is responsible for populating `struct
object_info` from the provided packfile and object offset. By
additionally providing the object source, the ultimate goal is to store
the this information in `struct object_info` or some equivalent
structure.

At first, I wondered if it would make more sense for `struct packed_git`
to record the `struct odb_source_packed` it comes from, but maybe that
wouldn't be the best layer to handle this bookkeeping?

> Note that callers in "odb/source-packed.c" pass the already-available
> source, but all other callers pass `NULL` instead. This is fine though,
> as we only care about populating this info when called via the packed
> store.

Hmmm, is this because knowing the ODB source the object comes from is
only useful for callers from in "odb/source-packed.c"? Maybe this will
become a bit more clear to me in subsequent patches.

The patch itself is just wiring up `struct odb_source_packed` to the
above mentioned functions, but doesn't do anything yet with them. This
step looks trivially correct though.

-Justin
