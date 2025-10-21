Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB67341AC1
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 16:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761062692; cv=none; b=pW8005fhsN6tIB/I8azbWhoB5SYUcXga2ZcMHeoDDLy84rbG7NE96mrAf5PuOYDTKjH7Ixu1zFQVMZ3wKMF9UUYGWp8t7l8Yk5rz9wAiNKQpdrtRVrd6jBtbj03TcK69RdVj+iqdAK+j6tE0vDgazoxeaCRCAzHBSLvkCWfUbHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761062692; c=relaxed/simple;
	bh=9StmrdNLQiQz78H3mHVk4RHz1sUlOEeOMbfPf13O8zw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rwBeyHfW8t6okHtvad+e0DpbB8Mapyel/PZqRauotEy07xRv3wrYZZ4NswZyr0rzjGrwp81EgW6N40an7zvjSsWX2NtEfWHLDr6QF/BVaTAmMSPZFAUPIx47jtrI5GCJVlZQ7/8XAdNvZlmefsIwwa+f/2NSAJS6SEiTptDa4XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kMezhoLW; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kMezhoLW"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7c288d3f249so2121658a34.1
        for <git@vger.kernel.org>; Tue, 21 Oct 2025 09:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761062690; x=1761667490; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JGgFKnPcjF0UxqbNUN3epun2IdUX3yOkLGG8bk1zoG4=;
        b=kMezhoLWOWIodlSaQu7EEQmsN+2TbyH3zZMKQVYo2n/NXvWqlr7h4x5Ruk6lw+cL/F
         T/006BsGz0PeEM+UPFWre5ShOI86SGS5bcCjVR4tQuPBS9U1ho10XbMG5oVhSLTWY6vO
         24d12OjOkqwMyx4pQhX3H57q/rQZ93TnXDw0SBk8iemTNvlunP/04xORhTiIM0GHRxAj
         xT5/Rv5hpzKcVaNFjrUGil0t5DJOEa/8oB/n1gabNaKxscvwn1CwCJ/7mgBBy5PgHrMJ
         dCVzGW+BQXXhu1tGkmzPVVyhg1xEpPNCxVZw2uJVvIM+Ep9XcxFSqmDvwr1Db2beJsBe
         w4uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761062690; x=1761667490;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JGgFKnPcjF0UxqbNUN3epun2IdUX3yOkLGG8bk1zoG4=;
        b=THk6eJ3/LrPZi3lyqN6qgIZwO0rIlnWWyv5XJU/cYV5hxfT+C6la2gZ6Rpurxld1pc
         Kc5/Vi9bvtK4GjVKzqKfl/GD+KCoIB7FpVJ1xiGNA0rqPKt7R62zGUulGprprLPGEBfu
         YJQsb1mO2/Ir4GTTHdhp4/9vbY7FLOZKovn2Du6243XNbkoeAU26YjkzTd4KOpzqUsww
         NGJRo15kTUIwzQ8TQbN6H9oVxOoNRiIlmu2jPW/Zmqj7ZAdFktyqN4EovR0NhXHA0KIT
         BgIxPgvc+dVNhXs8yp0G+tYVTfX4B9fX3z/ZNd10c/WzSrm3G/+jRN6WkFyP3JwQgv2W
         6/qg==
X-Gm-Message-State: AOJu0YxXS8sTfgCKH3jG1pSgcPwIJpvTJlxxb6xQJ6vJLd2uc9sMwGdg
	KpMAqU7iuBEOrdVkyKAoWXPJeLQpPECGJMkZg8QKUlLjvSlS4U0v13Z+
X-Gm-Gg: ASbGncu3XTe+ri7QHE2vv9E974bk4dpCl5w4gOaPMbX+0Lx8MiCbIZ6EpJVtrkHe6t1
	wv3hmDCN1Wx8lIjzp4NAeUhgj7KJyIKfXu3KpD+cwToO1MHubo6K1iD6kIpfeIu4V2BOqdsJxZq
	B7BgAPdUnuSCIySlDgvDv/8TSGy849eST2gvfhGEr2f1reXQBOobKsEO6KApEx/xEoY4IrbeG8Q
	AuimtfJVptXwCavFrZSg/Lg/KRS7Voc7sc5bqloB+gd/uKrOy0at2DrY0C9CRFZ/QLvO6lCuaYx
	xN3R/Ch8X2m1HjWqfOhSA3OEBxhVzKYGATZ71u0qSgrRTtHEgAkLiWj8JZgPTCABLQZEAdB/dHg
	ZpWzsZqCuvLqCbt74vpGsvkrvg6IjJjq/drWAsBofTFPDwF0Ph2n6JHn65ogtU6bTEnDSZt+BnQ
	I8hqz/
X-Google-Smtp-Source: AGHT+IFikr/Hqlf5erMoaUEtmsJcvlIn4ze4zP4kO6IjmsMKENoqCja/CSB0k6Lqpe2GmBXTtakCkg==
X-Received: by 2002:a05:6808:2f05:b0:43f:5ffe:2309 with SMTP id 5614622812f47-443a2ee324bmr8484368b6e.11.1761062690162;
        Tue, 21 Oct 2025 09:04:50 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-443df208daesm2754736b6e.20.2025.10.21.09.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 09:04:49 -0700 (PDT)
Date: Tue, 21 Oct 2025 11:04:46 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, karthik.188@gmail.com, sunshine@sunshineco.com, 
	gitster@pobox.com, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v5 3/6] builtin/repo: introduce structure subcommand
Message-ID: <4csjjw5sin2luhsl2pq5g3ra56r463h6arc2vwfnitwqhhrww7@s6y7hhvgzwui>
References: <20250927145049.723341-1-jltobler@gmail.com>
 <20251015211213.361797-1-jltobler@gmail.com>
 <20251015211213.361797-4-jltobler@gmail.com>
 <aPDPyEVOTSU6NuOH@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPDPyEVOTSU6NuOH@pks.im>

On 25/10/16 12:58PM, Patrick Steinhardt wrote:
> I only noticed this when taking a look at the last patch that introduces
> a progress meter, but I think we should change how we count references.
> The way you do it here means that we have to temporarily store all refs
> in an array, which is completely unnecessary and thus a waste of memory.
> Furthermore, the resulting progress meter will be somewhat useless
> because it only starts counting _after_ we have enumerated all
> references already. The second phase where we basically just classify
> the refs by type is going to be orders of magnitude faster and probably
> not noticeable even with millions of refs.
> 
> Instead, I think we should use e.g. `refs_for_each_ref()` and count them
> in the callback function. This means we don't have to store them
> anymore, and also the progress meter becomes more useful.

One nice thing about `filter_refs()` is that we can easily set it up to
exclude certain sets of references. In the future, I do forsee options
being introduced that restrict what references we use when performing
this operation. We really only need to iterate through the references
once though to count references and append OIDs in preparation for the
path walk. So I agree that storing all the references in an array is
quite wasteful.

In the next version, I'll update to use `refs_for_each_ref()` and set up
a callback that counts references and appends their OIDs in preparation
for the path walk in a single iteration. When we introduce the ability
to restrict references, we could export `do_filter_refs()` via
"ref-filter.h" and be able to reuse the existing filtering machinery.

> The only downside is that we cannot set up the progress meter with an
> upper limit. But I think that is an acceptable tradeoff.

I agree that this is only a minor downside and sounds reasonable.

-Justin
