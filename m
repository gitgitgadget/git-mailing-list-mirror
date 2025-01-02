Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E1A192B82
	for <git@vger.kernel.org>; Thu,  2 Jan 2025 14:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735827933; cv=none; b=JTsPJuQfmZ5VPBFH8SZvpjw6GkWZP+XW7mKzdtI4r/mfbmBTyNu44JWrKDSS1S7FAlJa8vWriwPPUkyDuIVW62LJ5XaMAKICo82HVs5O8Kb2o/jxbe69dJzrEleRHWZoB/tp0glx8pVnPzgWomhB38ivwvZe0/RRh1QOLfD9YVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735827933; c=relaxed/simple;
	bh=3LJwMKv8bTpcKgNeMHHBgGua9+kDIQyHinTb0hgVd2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M48nDWZy3dENJGaeZENCSNc7XP1vpkwibGOLzImdjhR89ecAg1evLlP4ojHCZ2QU0pNhNgWf+ru45Qd/VC+G78lwulxNZ1/cRWxlWk1c1MjVTzNkTpCiCso9exbn9sxpP5pgkxT1jk/oDSzCUxmkMchYo3SyfVY83i8wt/E6BAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OfotWJ+2; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OfotWJ+2"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21634338cfdso223547435ad.2
        for <git@vger.kernel.org>; Thu, 02 Jan 2025 06:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735827931; x=1736432731; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qhBsqKiYzJRX76i2kVq6GmT8LA/pXDnkO2UVSwnUFgM=;
        b=OfotWJ+2oFVAYASygxDr05P8vM3W2EMYYAZC8m22keumm8+HJaqHEguHdWrj+82I+F
         SH9uR7UQ6sbNvaW6ycWn4eT+b6pWTDunC4DIXILTMW4O5X2bcMHyo585e+gd1uBi881e
         O8oEv5y2o+XD5oufSBDa15y7aNmDXbMCtSGtoqjYYJjbrVM8ro6AHB9GuRPJUZglr/x/
         08tNn/M1GgWCU34zNmJFhjc6JsK8nuIypCQCazHJx1gpQm9KAA5bDmanCnqlwCF29aqP
         5Iw0Z391BZz3yTUxb9urT6synUwlMUAMySUVU+P4zE6cN9ID3DPaiizItd37aGGYYnY2
         T3pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735827931; x=1736432731;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qhBsqKiYzJRX76i2kVq6GmT8LA/pXDnkO2UVSwnUFgM=;
        b=j+Q1kMqtqhe7O7rqdypw9LXYMphALUFTdaxP4K2QMtPmChEIrdJdRH05IEiijM2/wH
         9+t2LJsthaszaB13uWMGxiuWzfGKBAvNur4qhKr85aaErVkUElKaZyhrkgXnO7/6FOfp
         Ii4hUg0sZO4ZTDLBO4l+O8Zksz+aTCe9dXU0Mg7Z9DYEbvpPS4sAae2HFAKfuq23XM5Z
         osm2Wl34p7CceDgMyBQZSC/bJtNUwQ97H+2etEwBgw2FjMFuUP6MdYul4WJOEkuK3J5M
         q1muWZBPuCxyfdvqn1mhuBbAll2MQnoEfoGky4UTiT84oyIHc+4HwihV6WPg+R+wl+Y/
         F/RA==
X-Gm-Message-State: AOJu0Yw9cLJ8D8kJ3puxsm8vt52nDvCUAdAIXADTuOJL0ntYCMm2BjUQ
	Agf8xvtJg7a8aHnHoSjNNFJpIovb3YDrV1M5pgY1XcjRyT2NDrLqLVoKVg==
X-Gm-Gg: ASbGnctzsCToeGTtqBEsaEcxAQ5IERgbBPWg/mSQ4unVT1va2yIjI2PFQ9xpVA1Hna5
	Az55a9vaKidR1mS8FS/g2mu6FAYuVYezdyKFfL1eHtMToVaYhFGdEAhv/jTc72wr5R/xG4j7150
	dcUmkwTkgl+Wz7gJevexweUIKY/WKsbfDYdOE+Q/B9KH2ndQQO15ORhZpgSp24a4glZ3IkGF+L5
	eRHZZdLPJ07DCErW1+/mMKO4lrnsHYANK/q+PfWjvU7CtTn5Z8K3ZW8fDz0JNsgHgiC7NsP0JBg
	8U5otfRQNVwliRZihA==
X-Google-Smtp-Source: AGHT+IHosR+dT3IfH4Q/1Js7i14DzqEoiT5A1ly5FunIblQ0swIAANYD5/wfONM0VHz979bUhdh6JQ==
X-Received: by 2002:a17:90b:520e:b0:2ee:c9b6:c266 with SMTP id 98e67ed59e1d1-2f452e22592mr66457123a91.13.1735827931482;
        Thu, 02 Jan 2025 06:25:31 -0800 (PST)
Received: from google.com (56.166.125.34.bc.googleusercontent.com. [34.125.166.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2ed62d9f1sm28239589a91.20.2025.01.02.06.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 06:25:30 -0800 (PST)
Date: Thu, 2 Jan 2025 15:25:29 +0100
From: Jonathan Nieder <jrnieder@gmail.com>
To: Andy Koppe <andy.koppe@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: meson-test syntax error
Message-ID: <Z3ah2YQSx4ZreBpK@google.com>
References: <CAHWeT-boK3x6mup11boEinNDQiAxxf0vwvZkxsGRc_GRvXYA8g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHWeT-boK3x6mup11boEinNDQiAxxf0vwvZkxsGRc_GRvXYA8g@mail.gmail.com>

Hi,

Andy Koppe wrote:

> The new meson-test rule in t/Makefile causes a syntax error when the
> default shell does not support non-standard process substitution:
>
>   make[1]: Entering directory '/src/git/t'
>   rm -f -r 'test-results'
>   /bin/sh: 10: Syntax error: "(" unexpected
>   make[1]: *** [Makefile:119: check-meson] Error 2
>
> Due to this line:
>
>   diff -u <(echo "$$meson_tests") <(echo "$$actual_tests");
>
> This can of course be worked around with 'make test SHELL=/bin/bash',
> but is that expected?

I ran into the same today.  Let's discuss in the review thread
(https://lore.kernel.org/git/20241213-pks-meson-ci-v2-5-634affccc694@pks.im/).

Thanks,
Jonathan
