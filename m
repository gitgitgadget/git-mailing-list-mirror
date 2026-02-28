Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B086430BA7
	for <git@vger.kernel.org>; Sat, 28 Feb 2026 23:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772321803; cv=none; b=aM6R4iHNekmY0d54jpPi6hDpYbIp9eQjpr+h2JWYpEBu0wVpksSuoEXa5ySlqC81o+/FZJ2Ebb5+6h36to7L+isLZlu6/FB+bXlNl/OpxX8Pq2hYB/7uAfz2KL8ndpma5aE8PzHoQNEGyLXVXwTtupN2wQG0NSR4DzCwsulRulg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772321803; c=relaxed/simple;
	bh=0184pjLPta6Y1Jwpgc7NyKGtvl+D4fVBAQxxeWCX4ek=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=naruUqY0y2BIFLX8yP2Q+tCkIiBMlkyPN2UCcPI859mFZY390SjJ1SljdpESo4GzNKrYuJVGVMjLCYTjE2HH6AVrz+PA5sUXdQwX+FdTh/FLdNekxnRsEFm9QmvXu0yZPWtFT4JgNpT2qKiicpPNHaEXkEgAucbGwYtLd4odlQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q2sBO3si; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q2sBO3si"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-56a86f0a23bso2806915e0c.0
        for <git@vger.kernel.org>; Sat, 28 Feb 2026 15:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772321801; x=1772926601; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Z6JfFc3st2g0EnXkwHr00A2v2rIUPuTpKOhAlKrW8o=;
        b=Q2sBO3siX7zxXylFhoWm5JIUy4yKog1fhjEK4AgJNm6XV5FMOa9O4Okn/naTQjK9fE
         b/8Q8rJ38++cuv6/+/m/Mrn6BH3MAe5sLIsUQByYtAxgLZFfVE54vQtwb7+GrqFEAGzF
         +GEWLY0dZzwyIb7UL5qYe96rM58YwWBXEKpUcNEsFdYYgm6anrs2melaC4aMBzrtnxmH
         HZvdmc7Qa3txPDOJ1jnDWY+m6WKTXjrBGgB3wpCitQbhalZdVDYAfW6uScjiFlhe5U6A
         4Ybe8/wxlwaW0gixdyiIyrMk9tzMXYWd7URL8tcI1pOeispVRZv6m4Ldzy9DCN0DCzZx
         SJEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772321801; x=1772926601;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7Z6JfFc3st2g0EnXkwHr00A2v2rIUPuTpKOhAlKrW8o=;
        b=nDIt0qz+ONu6zMQWvK39hgkES+W+DYdfub2dSwNyvUp6tBdtDKXPdj1smy7YK7+/vv
         GhoMAv85XVRqGvRTRDxmd9G+biCF9noLChItIDsVKQ7yUgrDVDXxFG6XeNwnpb7FWW99
         I8qj/ZraG12qn77vyQsMhJdk0tLx+GO3V54Xc/aQ3uKypScZaV1GcF6QdfSxMqlHw1Lw
         9xSnQiL/3d+f3ZS07NWp4Hetuj5RajUN6tw8DA9occX/CDDHQ4M8dbo/eX90S+zQ9qSw
         8OiiV9zVrHNThiEQjRzFCZk0BmE2NGo7Jqao+nJjf20sVcIjGNcHyt3uB5KuMY0rW6XA
         M/8Q==
X-Gm-Message-State: AOJu0Yw6TUUPlOpIwrvHMEIEZpWfQomzhdH8XdvjjTqI0QwH9FM6CVYb
	RWvWroZlEqHuluEiOK0xfJpADY3yeVom6DDYb7xMWKC2+qEyloQFeUqI
X-Gm-Gg: ATEYQzwXCoYRMmZfqdd6sZzg8MLRbAmxoj6gHqzIJTjyd4fhd5Yqj565amDH/m70mZp
	vW4riIfepmcv2UhBhODj+cF5yWOm2LGjCNneZhVMKGpEGPGtX+5iVuSWQBDKHJlxocnC6nCJ4hi
	fPQEWwAeKIXiTISQrZzvdmYRZe2XAwXFliTEl1sCyUh6WU/wC1EBiIvCYkTbnYVS5jhcwtd1DtE
	n6toLRw41idPF9L5cHi45RQdGM1y1EmxLxJCr3s76USmTAjTtRWz6CPWF2aQ9wYJ7obL0jmi2dI
	/X+AROetJA7j8yskXHdovkgoIiCRyvg5WWjAMroyZb3gSeiqdmhWvIi1kBFxME++TZe/TVI7OG7
	xfGhX7nVHslpEx6DavfX3O4muoTH85y7p0ECTLSU2tTNGFyFJ4Hop6ltrBRY8mye/2pxrADPn0w
	Lf1WpY9eLBkzlA09xuTHaILnBpU9n9PElOnBkfsGwFmWAr0lq2jMOIVsAEn6Io
X-Received: by 2002:a05:6122:401c:b0:55f:c4a6:c584 with SMTP id 71dfb90a1353d-56aa09bb1fdmr3957662e0c.1.1772321801038;
        Sat, 28 Feb 2026 15:36:41 -0800 (PST)
Received: from smtpclient.apple ([2804:14c:c4:89c7:617e:ea24:9d26:4bc7])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56a9204b91esm10860697e0c.11.2026.02.28.15.36.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Feb 2026 15:36:40 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH v2 2/5] builtin/repo: collect largest inflated objects
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <20260223174120.2356504-3-jltobler@gmail.com>
Date: Sat, 28 Feb 2026 20:36:26 -0300
Cc: git@vger.kernel.org,
 ps@pks.im,
 gitster@pobox.com,
 kristofferhaugsbakk@fastmail.com,
 eslam.reda.div@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <C99EBCF9-7980-495A-94C5-576AC6D140F3@gmail.com>
References: <20260203221758.1164434-1-jltobler@gmail.com>
 <20260223174120.2356504-1-jltobler@gmail.com>
 <20260223174120.2356504-3-jltobler@gmail.com>
To: Justin Tobler <jltobler@gmail.com>
X-Mailer: Apple Mail (2.3864.400.21)


> struct repo_structure {
> @@ -371,6 +385,21 @@ static void stats_table_setup_structure(struct =
stats_table *table,
>      "    * %s", _("Blobs"));
> stats_table_size_addf(table, objects->disk_sizes.tags,
>      "    * %s", _("Tags"));
> +
> + stats_table_addf(table, "");
> + stats_table_addf(table, "* %s", _("Largest objects"));
> + stats_table_addf(table, "  * %s", _("Commits"));
> + stats_table_size_addf(table, objects->largest.commit_size.value,
> +      "    * %s", _("Maximum size"));

I don't know if it's the best place to comment this, but it would be
nice if we could find the commit that introduced the largest change,
in terms of size or number of lines.

This would be useful for people who are asking "what's the largest
commmit?" thinking about the introduced changes (like what we see in
GitLab's interface) instead of the size of the commit object, which
generally is proportional to the message size + the number of
parents.=
