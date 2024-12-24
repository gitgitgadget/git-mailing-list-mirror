Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0089119CC0F
	for <git@vger.kernel.org>; Tue, 24 Dec 2024 08:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735030720; cv=none; b=l3zHM6vej0Mmmye2TTvU9FFJyyLxc8byf63pAxvfRZPgpphIHwsoNQF76JUKaMu3Z4KeIhkFhF/70PwMvS24BUGKzjZNHKJdakRvhLjtlBVeA3xWIe8DbYp2p477gkTejtrW09N9Ju35WX4dYQ910LQ7CuFBrUfFvCjQE0MAfPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735030720; c=relaxed/simple;
	bh=PwQRhvIN02dMo0ayAc2tAoh7xEa+gyGiM4az0Za7GhM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OtdUGi01YuLVYuZloBSJbxrEqTEQqE7ZLn2TnxZkQFfICdp0eEF3Di6L3HwDlOXY6hVdZGHFp6FztzC5WWNTIvTB5RFXADYNcXPn1GTKxg3U22AqgpQYrP4F4XUjKxfTVZTOCWWBsKRykCdfhJlCz9EWzCzteyY1lN5CYUjw8iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E/wlnkd0; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/wlnkd0"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e3978c00a5aso4320122276.1
        for <git@vger.kernel.org>; Tue, 24 Dec 2024 00:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735030718; x=1735635518; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PwQRhvIN02dMo0ayAc2tAoh7xEa+gyGiM4az0Za7GhM=;
        b=E/wlnkd0hoc4c+0a53/RVFVKeesz3VQVbLufXbypUbw6U79+ap3ZgWwo/6PJua98Qb
         ljpcZuagJW6R0+0qsSBbsipPomBjM87i8WX7Gqtu7gwQA/GGjyrwMp08l5HyWs77uw7l
         QxvmH7H42NREFy4Ce15521j0WTdItKTqvd7tM8rYw1s8Fzacxlv6RKMTr7ack5p9tFIq
         WPNUYCefY8yjNJHdPDRbOM/+NBZfWJylsZC93dwShSMpBtcOe93rsNrgzGRjqffmCAne
         G6y4/why15fb62aEpBXyzBPXrgKIKHNUIRH8+24iJ/38gcdr4y24xZJ1ntjvFiqDiHL7
         dgoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735030718; x=1735635518;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PwQRhvIN02dMo0ayAc2tAoh7xEa+gyGiM4az0Za7GhM=;
        b=MbHzOngND5xwdGoeDrJFdp6/6V4KrA1RkvfAXXiBd4mPmDcliUiOT/QD0wr37fy2wu
         ZYBjuuqKW0+UnY3MQiXEkXG3Zdh0e+mrYohWNu+nG8YJdnmRUdL6JWW7m2BcEnkgTjUy
         +UWFq6DSzGbb5VsTjRrg1aQjr71YCPt9K5uDe1kgPJA0kTG7NPefZS0bdnw5js1x4l5P
         DMyc1Olzw/jkfQs3z0BvP+f49yOA8VNo1d2zxO3nvT1wwA7mpoyb+phAPuU42BP7Sk80
         cn1eL/PuyvsH5IqyZCfpmBsbdMBuN/Po4Piqju5Ym6QiVLIzUfrSQgXiaamfYyZN+2zg
         RiNA==
X-Gm-Message-State: AOJu0YwqzvSmFanfofjDbLdEI5+nAL+15faccoyjkCp7vqz+57Rc/jqx
	k+jmLLawqUsQwxXysdhnWQuCjjZGURZn1uMRFzFLY38ochSQci2qxDE7G2WBN3L/WEN145IGx0S
	ZABuqPVR3w2+xWvDr3b3FhfCN2TLT5/bYE5VWow==
X-Gm-Gg: ASbGnct30MchR3fIcGshlk/+1FXkXSUB8d4VEx2ZXy9v6nqb2sRAlfjGw172mZJVVEh
	5G4wxWOFL3nN8QaMmz/8CaVCdJezPUq/1hHWQC80=
X-Google-Smtp-Source: AGHT+IES2yL2SqVHVqk3iGpKifGgvYh+ICs2NA6Sby+HxnwITZX806YsCFJ2avABSFrUzWcoPxkEzRKCH3t9FxhM6Vs=
X-Received: by 2002:a25:ae52:0:b0:e4c:1b6e:593a with SMTP id
 3f1490d57ef6-e538c3d6ed2mr10759141276.33.1735030717850; Tue, 24 Dec 2024
 00:58:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGedMtcSSkmQ2u9yYvKMiWnprWR2VZrbuoT9EX+U6nuxOWiEHw@mail.gmail.com>
In-Reply-To: <CAGedMtcSSkmQ2u9yYvKMiWnprWR2VZrbuoT9EX+U6nuxOWiEHw@mail.gmail.com>
From: Seyi Chamber <kuforiji98@gmail.com>
Date: Tue, 24 Dec 2024 09:58:26 +0100
Message-ID: <CAGedMtd0-m54075w97Z4pQ0wqAjgPRA8+HX5iar0POyuC6-GCA@mail.gmail.com>
Subject: Re: [Outreachy] Blog: Introducing myself as an intern working to
 convert unit test to use clar
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"

Hello everyone, I just published a new Outreachy blog post on the
theme "Everyone Struggles." I would love for you to check it out and
share your thoughts. Find the link here:
https://seyi-kuforiji-902b48.gitlab.io/posts/everyone-struggles
