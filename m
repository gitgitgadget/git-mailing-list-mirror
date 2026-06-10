Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D361B3ACEE0
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 08:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781080252; cv=none; b=cKeNufye+3LdU5FE7vtbPrk5xmUW18dEFMjFg9jBD6YscRtTRLsfGXK5unUi9026pVGQ+y2PIiLJcpT/RJH9O9O4PBWv+mcn9S+7IYz0xTTbE33/f1PunlGPdlKZa+M1/i4vf1BccfbFesi1ALmpFGq6azKs79RdlyWxrUQG28w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781080252; c=relaxed/simple;
	bh=gsQxKQBj0HKyZSvuiWy6NWE0oV1tY3enn18+kS6n8bk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XkOksAyU2HWChIs8+XSBiINpZ+CX7FhpHeWRBidXxJmjmc2D5CIFFSAf4Z5uTAA5MMHLwRpeZ90rUfBhKOwRPkOgsHfmb/WguLvSronvPZbxoj3l5PDxIjDhnA2c0oKPeglvg/IcOukwOFG47TD0/ts0YufulDj6wi/Yvgy3usg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=D4RpZAfy; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=YDFcqdtX; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="D4RpZAfy";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="YDFcqdtX"
DKIM-Signature: a=rsa-sha256; b=D4RpZAfyMVy3IgJjMZaBTjGx4/gaAMs6KYY18uD+sio/Axd2GCi4wiW5PyrXg0u/A+LO+EwQLeaQNGcD7ghIA1p3JkXmLIQ3CLsq7kl39jeLGkmtj4/ZFM0jl/WOX4RF484+zQAB4wMMVQqfwurSE/ZTRYg1XO3NKjtXIVfROyopWSqx7DQYQdGnQX/BJkAXRLwxFCkANljcLP6kPFB0axoUa8daPmXsNipJhQAroS2Czt/1ZUg/a3rzWNQcQcVcZsZlY9+sziKA1WgggX9nFMIHkIS+tTFhaseGzgCej4v8od0FBJVQn6CRAOIbUXD/0V8e1u8+3BrEr9IJgyRumA==; s=purelymail2; d=malon.dev; v=1; bh=gsQxKQBj0HKyZSvuiWy6NWE0oV1tY3enn18+kS6n8bk=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=YDFcqdtXaDIr3JmnSCl4V71X49gbrHhLqodfa3oVT/sCQJ5qLSpkhlz2gkGKKqZ20YoWi1zIJhn9pAF2XI+AwtlJaYDV5NtpK9dx6LMoc2YuDc24CmOjwLU4IYT7q5yKlJkWmKQbzpqib0UVHmpCaEgFbwN32CHB6sTE7gd1DqVAZDruKMJ21tDLvopb2gnrmCXLVh3bwgdCGRLSy1q65RHy84iM5B4AsZf37KEg+m+B6eifXzCl+ymPS6hbAX4mJIyZG7TjMbTQ8l5f7tiwm3DDzSOtyKQbAC0PS1vJ2mqwE5fwJPXbcks/sEGKj39B99Ov+nfPJpbjo1Ne4daLhg==; s=purelymail2; d=purelymail.com; v=1; bh=gsQxKQBj0HKyZSvuiWy6NWE0oV1tY3enn18+kS6n8bk=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1533124024;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Wed, 10 Jun 2026 08:30:42 +0000 (UTC)
Message-ID: <e5d7f762-1e3a-4e1b-b54a-e2f757b1d878@malon.dev>
Date: Wed, 10 Jun 2026 16:30:37 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/4] read-cache: move 'ce_mode_from_stat()' to
 'read-cache.c'
Content-Language: en-US
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, christian.couder@gmail.com,
 Ayush Chandekar <ayu.chandekar@gmail.com>,
 Olamide Caleb Bello <belkid98@gmail.com>
References: <20260530160520.77859-1-cat@malon.dev>
 <20260530160520.77859-3-cat@malon.dev> <aiEfkOtlnemkWgXV@pks.im>
From: Tian Yuchen <cat@malon.dev>
In-Reply-To: <aiEfkOtlnemkWgXV@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail

On 6/4/26 14:47, Patrick Steinhardt wrote:
> This is moving goalposts a bit, so please feel free to ignore: should we
> maybe add a small comment what the function does while at it?

Yes indeed, the original commit message looks a bit bare, I=E2=80=99ll add =
to it=20
in the next reroll. Thanks!

Regards, yuchen
