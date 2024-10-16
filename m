Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9A51C2324
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 20:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729112090; cv=none; b=bEQugFhV/Ppg+geNLRI9vM3sHOJLlmGs4uQRo07fmFB9kBeWOKHX2BvnVuK+wyxX1vgnkutmbtxEHfoMgMPUTvAIdxabHCtKTBzAR5ckm3Nda1LdSqzHCTJci5WdRYBoTdTtSvLRehrJYrAGmx4liNrBKYHCY4+X22g1NGkc3oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729112090; c=relaxed/simple;
	bh=41Tzmcc/3rjEPaYJW+juQE8aF5dKCE6xuh9ERIkzTBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ImhjoaYISSZqgt6Oln4OnBYydhkopQCXPYPFjU1ieooYl/HW4wLNzSkU+GhCQzGTjoBqBD/8BS9IrigHiKWkqu9LLEQaQunOjlQjFWV7OKQMr2QYiJil2T0g0zJ6g4EmI/3wVlqxEAH8taJRFFjBHTWdcCdHkusm/ywiO3Ix5cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=lYc/Xo8x; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="lYc/Xo8x"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6e3a97a6010so4459717b3.1
        for <git@vger.kernel.org>; Wed, 16 Oct 2024 13:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729112087; x=1729716887; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bdz5npt3dmDBt7sK0rwFrNfze4MrjOtwf6EHHVNTM94=;
        b=lYc/Xo8xD9FRVFOJAlOnfK0DPDGJxrU7MITlF7mU7IUv8xJMawtFC6lDiv7HzXnJyO
         eAYddWjp10b4QrTw6g7ekgPD/eNZkwFO3ox47QQt7jDB3z/YNxn2yQC0mR0iL8FAIliq
         0bdEBABemCd//Ca5L6GJRYnIV9DxBOFPMcyeLFHY4u42XZpKxMyLcuolyvV2XD659PIE
         L42ZeP9naihjbvZDoaj6O2beYM5/G4tzGKhS9kVPWPMuFAZogjQ+YjaQsWHKBo42QbZz
         EP8DG916SgSmtDHfGL+vtbQekWnS7nOffksAtN03zCEoH/vUWICOhJnSvsuSFDtFFeTQ
         QaiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729112087; x=1729716887;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bdz5npt3dmDBt7sK0rwFrNfze4MrjOtwf6EHHVNTM94=;
        b=L2sR1C/JvtZ5GvVc7Fw5BG8k1z466SuTXBOsVQ037aRlmH3O9f5AFDK7aCwekDi2Am
         L8+jWjrW01oxno7Lu3BU8hSNOCyD3NDbx0q0XVsleMw7FQ4uuhqLRIUDaizuM7yB39Tu
         b9prQ5BeVIPyHLlQZ5jbmby1nJe8ky9IehjqGzbRkCoWfijBw0jxPlEIqbGR+Xf1bKuG
         WHfFjda4Z+V48Jxmz/Bli8DnGoi1IFYbyALhGwSC6na7Z7hYGtEI3HZVtl6LXzwnf5yP
         lsBogP3qVkKu9ctHLWfRWbYYOfE32nz+ui/+Er0wmGyOtqWr9Js6MjSjGjzgvskcYjZ+
         O+ew==
X-Gm-Message-State: AOJu0Yx54goKWhCMkNZ8thIagMxU3vLuImqvtz6AI+iHd0Mp625OCuX1
	4LGw4PB3w9MaGq5SS2slHRhJhAOcwB51LpjRF7/UswmXKbrVCedNo7HT40Yuqj4=
X-Google-Smtp-Source: AGHT+IGXgsggmqnQjUzvKi2NU8LTJ72hZnZ/vzvDiwxN3YHlhejPA30HGBfSCAYn4QCEVTGUMuAWEg==
X-Received: by 2002:a05:690c:f05:b0:6e2:aceb:fb34 with SMTP id 00721157ae682-6e3d407c576mr59069727b3.1.1729112087645;
        Wed, 16 Oct 2024 13:54:47 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e3c5add1a2sm8604177b3.3.2024.10.16.13.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 13:54:47 -0700 (PDT)
Date: Wed, 16 Oct 2024 16:54:45 -0400
From: Taylor Blau <me@ttaylorr.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>,
	phillip.wood@dunelm.org.uk, gitster@pobox.com, bence@ferdinandy.com,
	karthik.188@gmail.com
Subject: Re: [PATCH 0/6] doc: update-ref: amend old material and discuss
 symrefs
Message-ID: <ZxAoFUDmdfZ8rlLs@nand.local>
References: <CAOLa=ZQJy1ZkQqBoWwJJvL0f+NCP=3SAfyeSNuztgApzNH1mGg@mail.gmail.com>
 <cover.1729017728.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1729017728.git.code@khaugsbakk.name>

On Tue, Oct 15, 2024 at 09:03:09PM +0200, kristofferhaugsbakk@fastmail.com wrote:
> Kristoffer Haugsbakk (6):
>   doc: update-ref: drop “flag”
>   doc: update-ref: remove safety paragraphs
>   doc: update-ref: demote symlink to last section
>   doc: update-ref: remove confusing paragraph
>   doc: update-ref: discuss symbolic links
>   doc: mutually link update-ref and symbolic-ref
>
>  Documentation/git-symbolic-ref.txt |  4 +++
>  Documentation/git-update-ref.txt   | 48 +++++++++++++-----------------
>  2 files changed, 25 insertions(+), 27 deletions(-)

Thanks for working on this. These changes generally looked good to me
(although seeing smart-quotes in the commit messages was a little
surprising ;-)).

I'm making a note for the next WC report to expect a new round that
corrects the subject line of the penultimate patch "doc: update-ref:
discuss symbolic links".

As a general note, prefixing commits with "doc: update-ref: " is a
little strange to me. I think I might have instead written:

    Documentation/git-update-ref.txt: remove safety paragraphs

, and so on. I left a couple of other small notes, but I don't think any
of them are urgent to address, though it would be nice.

Thanks for working on this and improving Git's documentation.

Thanks,
Taylor
