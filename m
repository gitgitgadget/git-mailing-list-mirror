Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49AC1373
	for <git@vger.kernel.org>; Sun, 20 Oct 2024 00:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729384644; cv=none; b=KUJ1Ho8cVbqLmGXAO/PMLRmDISdpcPnWZfPdoQvwc2B2gWOFSi4qGLDv3KKM0Lg34+5W3TPNsU6Ul4B40tfH7+ACXLWwLXz8V70II8HH0kn/vsNcmyDpTw1ZatFIvynyY8HcEckDLTdtQ7ew/Nf8ktlyTur15nCM5H7K/kWwjVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729384644; c=relaxed/simple;
	bh=jG504OaeJ5PVcroc87rvEqw5xqF6vCIoqVRlVb7LgEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vBIdG1ewJ3agU9xNuLgpvVt4rT6GxIxzTAF2VjnGr5HcjDiCLas/+9KkWMITMY2T/yXmUQexV1YtRQAKDn4/rH1+fMenGxmh+2Zg3smlMwrrobM9/4Bux2B0Z+08awyGbP6/PmqJq4hDDIXs2V8oH7/6I9s1c6LgJ+EJFREP0ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6cbe53e370eso3891956d6.2
        for <git@vger.kernel.org>; Sat, 19 Oct 2024 17:37:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729384640; x=1729989440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jG504OaeJ5PVcroc87rvEqw5xqF6vCIoqVRlVb7LgEY=;
        b=f1rXUYBkmxKzXlnrL5m/KVH77mh561AYw2tQxvIWp7R68FgnkzVVauTSV3Ogk6JE/o
         0JF+KI6ivkSsL/oNmLVpmOoX1WCG7MtkcYXr149FVlzKNdCm7n4jLBBD2FmMKTYt8k/f
         tXKGZCjskm686nSeFGTmnHAncV4z0WsqhRVhwAAue8l7n27FQtUx7qOvFxNZ6MwqpT9A
         PSHImUGOlBxjA7t8CN8EMw/DjL3q4fMuOM0J2HQOTjjXefgR/FSJUPMH0PJFmW/VZdrm
         gSzLkubdZPAbrDX3HMlksAPXItAIRhgDKpRKKxVHGwh7Dajl8NZX+j5B7Ui4IprbR8Yx
         k7WQ==
X-Gm-Message-State: AOJu0YyluXZTCR7brOWYfEHUXgowsBKaXQegFH/FBYUbX2sVzlf6p+c+
	pP7Y3RSIk8hB3cdh+N9/4F/MQZtIQc+dOTIgKqe9OnQsSTBtueewy80x5x5l3QZ5pe1RLEc0O1f
	CUM2EZtq/JlQKsPUWzORbIvObjnI=
X-Google-Smtp-Source: AGHT+IGDXJE3LncTvY/P+MoJuRIUMBGAudfzP29djarAQYVwRcygdT52Uj17X3J4k2QYgoQi+19giJV49cFX/dj+L0k=
X-Received: by 2002:a05:6214:29e2:b0:6cb:e6c8:2ad0 with SMTP id
 6a1803df08f44-6cde1537854mr49691226d6.5.1729384640529; Sat, 19 Oct 2024
 17:37:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <BA07EFA0-0793-420D-BED9-ACD7CEBE0112@townlong-yak.com>
In-Reply-To: <BA07EFA0-0793-420D-BED9-ACD7CEBE0112@townlong-yak.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sat, 19 Oct 2024 20:37:08 -0400
Message-ID: <CAPig+cRPAs85koyaQxN5eaV60-qyGka7HrDMuoMoWjT0CpS6SQ@mail.gmail.com>
Subject: Re: Bug report: v2.47.0 cannot fetch version 1 pack indexes
To: fox <fox.gbr@townlong-yak.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Taylor Blau <ttaylorr@github.com>, 
	Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 19, 2024 at 7:31=E2=80=AFPM fox <fox.gbr@townlong-yak.com> wrot=
e:
> What did you do before the bug happened? (Steps to reproduce your issue)
> 1. Run git clone https://www.townlong-yak.com/test.git
> Cloning into 'test'...
> error: files '/Users/me/test/.git/objects/pack/tmp_idx_WT81vv' and '/User=
s/me/test/.git/objects/pack/pack-427331d91391b00844273eeb3879cb479ce2c995.i=
dx' differ in contents
> fatal: unable to rename temporary '*.idx' file to '/Users/me/test/.git/ob=
jects/pack/pack-427331d91391b00844273eeb3879cb479ce2c995.idx'
> error: Unable to find 6261a9d9f7704c02a5421ff733919ab18793aa7d under http=
s://www.townlong-yak.com/test.git
> Cannot obtain needed object 6261a9d9f7704c02a5421ff733919ab18793aa7d
> error: fetch failed.

I can reproduce this problem.

> Running git-bisect identifies b1b8dfde6929ec9463eca0a858c4adb9786d7c93 as=
 the first bad commit,
> suggesting that the .idx file downloaded from the remote is now expected =
to be byte-for-byte
> identical with a locally-generated version; due to format differences, th=
ey are not.

Cc:'ing the authors of that commit.
