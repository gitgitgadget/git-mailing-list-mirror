Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012BF645
	for <git@vger.kernel.org>; Mon, 28 Oct 2024 00:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730073674; cv=none; b=SenS4aA9WRjVd+NnEbZWKDuo2r3ot6iWpc6uUTZ3lR6HpKVZ5wUvsXWfbL1FsmCuDLudEOJOUkOUng1jMW4Ae1PCyd9G6a9jFYbB9KfmLQ/IRBZmtJvv5eCsaN0sw9/y4a0pfUtufwPqhHFJaIiuq1z4ODBqPdGrVUChhCfm2tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730073674; c=relaxed/simple;
	bh=LI8kftWjcj6dtoajEYN9axVPl3Oo1w5b7dInZ9TJroI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P4CG5A5GHmGC7j9wmZqAjIocYF5xyD6mGUxza/Pj8F16Utm9JGXHr+Tjv4qVJVzn9e+5kV65Yo69dViKfO9gPWoEWf+VvaN5bTKGfuXoHt+wJnN8pZAnjsdW5G3wBKZdTHaG6IYqR9xJyoDkZkxfUUA8Z9MdwpWMWFwitkGaLiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=uU+ZgAns; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="uU+ZgAns"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e2e340218daso3756173276.0
        for <git@vger.kernel.org>; Sun, 27 Oct 2024 17:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1730073672; x=1730678472; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LI8kftWjcj6dtoajEYN9axVPl3Oo1w5b7dInZ9TJroI=;
        b=uU+ZgAnsg0spBaswvk1yXArDM3tPEFr2BoiYci+xHUZZ4S++mOeUcDo48nQvXRB503
         9oXuAHkeAkl7CDSxWUXzKkcK0+LQbRerSial+fB1pNIgM/nMMgwk8eqxvUYNrVlsNbII
         CyqUM10VY+qHEhbpS7/fyP8Hje9p8uOIHMyu/RRENDZifqmJTVHt3kyNfeoup0snXTmE
         040QqoIWF4AN5rjx2SPXEQtF2MPUB+jgAFzKp+A+KmTwreiR7S1GKeZZue+mB7DhWi3h
         +6GhctT3bm2h1dL8fMj9pE3cXqjwcTOan5MbB/3755cOETiRrSfXyHDbQiVD70dIdA+D
         yAbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730073672; x=1730678472;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LI8kftWjcj6dtoajEYN9axVPl3Oo1w5b7dInZ9TJroI=;
        b=HG7uMrHq9gwqAbDjA30X2GUXyF5vX5hR5UevlP5ZrgU9fI+q+ZANwTpxl9KNu7rPS2
         ZBUiF5xVh2shnZH0YJ57CvnheigGpPeLNEC7H0e6F67x7x+La8Sst4aUe87Y5LK3Cqkk
         WzQ5GqvR3ggMnMLV5wQHo8PUcLITCRQVYXq/JSe/HIQDGaLHJSuXl5DPavbRjgGVYw9o
         uul5+JvZ7Z+3r52Ckoyc1w2lPdtfSxVRDkXUok5kPzOf05dz9tE9/D/0FMBrLrwcrSus
         TIB4OfP5jgckL6znu2XCcbEy0BB7DddbFtyMNBXcoCi9BJ12yi3y4SslQ/+No9Xsobto
         7eVA==
X-Gm-Message-State: AOJu0Yzaxr20fSX5xYf18Q0ZzlR83rzuyqq6GqubIgMiAff3/ZJYjQ4g
	p6yxQjyyKfr0xfgV1In/9P+thQw1nI7/bzC2tfeaQu3/2N7pfJAd/sesMr/wlko=
X-Google-Smtp-Source: AGHT+IGWifDoiUIKHv2F8PSzIVwOBphZ+Vs9JtuWsDO8U8N8tn/f9HgW9x+2QP+Jm7rn/k6F1kzxgQ==
X-Received: by 2002:a05:6902:2b0b:b0:e29:24c:1d82 with SMTP id 3f1490d57ef6-e3087bfc89emr6114632276.38.1730073671950;
        Sun, 27 Oct 2024 17:01:11 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e307a03bf62sm1103775276.53.2024.10.27.17.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 17:01:11 -0700 (PDT)
Date: Sun, 27 Oct 2024 20:01:09 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Peijian Ju <eric.peijian@gmail.com>
Cc: git@vger.kernel.org, calvinwan@google.com, jonathantanmy@google.com,
	chriscool@tuxfamily.org, karthik.188@gmail.com, toon@iotcl.com,
	jltobler@gmail.com
Subject: Re: [PATCH v4 0/6] cat-file: add remote-object-info to batch-command
Message-ID: <Zx7URU2twSW1G6VN@nand.local>
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20241024205359.16376-1-eric.peijian@gmail.com>
 <ZxwGAhWYm0tASMI3@nand.local>
 <CAN2LT1CTi+7GWsDOYKDF+PEg6H3BFTfCVSwPvK5u5KnHi_AbZA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAN2LT1CTi+7GWsDOYKDF+PEg6H3BFTfCVSwPvK5u5KnHi_AbZA@mail.gmail.com>

On Sat, Oct 26, 2024 at 11:54:03PM -0400, Peijian Ju wrote:
> I probably rebase on the wrong master tip. I am working on a new v5 now.
> Would you like to resend v4 or can we skip v4 and use v5?

Let's skip resending this round since I found a suitable base for it.
Once you send v5, I can apply it onto any base that you specify as
appropriate.

Thanks,
Taylor
