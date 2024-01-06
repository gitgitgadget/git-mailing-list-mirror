Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688501FAA
	for <git@vger.kernel.org>; Sat,  6 Jan 2024 04:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=initialcommit.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=initialcommit.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=initialcommit-io.20230601.gappssmtp.com header.i=@initialcommit-io.20230601.gappssmtp.com header.b="j8ZuDkUq"
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7b7fdde8b56so16918639f.1
        for <git@vger.kernel.org>; Fri, 05 Jan 2024 20:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=initialcommit-io.20230601.gappssmtp.com; s=20230601; t=1704516275; x=1705121075; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JVj37UM/CNMCZwuntSHdpvfY4ZRpU0XcsBN7RCpK7Fc=;
        b=j8ZuDkUqI1Pzwx/h7Ltsx0YCvxUsi/Ou3UwoRizRPnteuk8CxNohhZLkrYUGhdGNbe
         ZxmYzEj/9ddPGX48vtnhhCXFM8FYXmluxiXYrI5s2K+dsC9b9d7k3AKraXhW+0R1d6WS
         qF6wjO/p7L9Bqw3q4dI/0PnFLI7SMiBCzUnjHrKghdGak+oiQSnyuW4k7ITtACEN59bm
         FRzTOQmSOv/z9bdIkAVnO9kEU8LB/bgR83n8FmgullvH2fiCMRcukSs0av3NtpdkcykK
         55oKhIPRRj17X8+mXjUpKID2NLqahOOTe/lrlGgXaS8pxd8/rqMUfBV/JMMpHoIvhT/a
         6Rtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704516275; x=1705121075;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JVj37UM/CNMCZwuntSHdpvfY4ZRpU0XcsBN7RCpK7Fc=;
        b=qx9kqhI5ID5x4LiKUteorCtsngRSLRyasfj6uT7RBnqNstuiDoZm56LZximO6xdNtY
         M2RBk14InOVV8tftVJAnsfXE63+QiUn39ws85t4wRsYSnW/dujCCeYfHkgAhwK17vhL3
         SqeYaf/tSgkl8u3zF+0lJXFSCiqOaFdz+j7s9tvZ0hKVqhqZ8P2ddJNGEJwFmvkvubwH
         EJSu9D4EduUT2siNOjbVY5SAW0KbdHJFIFn0gXPoD5j4qNJ+838YLCCmqtbKzWsqCT3I
         8ebwwlQomBNjHuSpFcvMThfcQzFIYhZ6hjpYMVh56+sDdS6NNPOHUpgSZu/okSyUQQ5t
         uGMQ==
X-Gm-Message-State: AOJu0YwtRGuF7TNDKlxyWEUC90ZRG3kmnAV3VwZpmvYQE/O5dtKVMAbF
	2qNMbEIx+Vi6JqmfHkZpLIJibElMIvgIuTqi7PRaRLO6lygIoQ==
X-Google-Smtp-Source: AGHT+IHFq/0hletQnjcfbIQiFRtD0oSi3bvQloMZK+LJ6/tkJDf9rNO4821cyLlAIo5rz1vOu8WXAA==
X-Received: by 2002:a05:6e02:b25:b0:35d:5b00:e9be with SMTP id e5-20020a056e020b2500b0035d5b00e9bemr798499ilu.8.1704516275219;
        Fri, 05 Jan 2024 20:44:35 -0800 (PST)
Received: from initialcommit.io (ip68-8-188-127.sd.sd.cox.net. [68.8.188.127])
        by smtp.gmail.com with ESMTPSA id mv2-20020a17090b198200b0028c361b5c7csm2149135pjb.23.2024.01.05.20.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 20:44:34 -0800 (PST)
Date: Fri, 5 Jan 2024 20:44:31 -0800
From: Jacob Stopak <jacob@initialcommit.io>
To: Dragan Simic <dsimic@manjaro.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, git@vger.kernel.org
Subject: Re: [RFC PATCH 0/5] Introduce -t, --table for status/add commands
Message-ID: <ZZjar4li8R7Uo0c3.jacob@initialcommit.io>
References: <bc55e29274da0d8059a8cd4383aa1b22@manjaro.org>
 <ZTatzlzCkPOW3Rn7.jacob@initialcommit.io>
 <ZTa4iqe0lqn/Yg5L@ugly>
 <ZTbJiIkIyXwWK8JP.jacob@initialcommit.io>
 <ZTbVY7Nf+DTYqHky@ugly>
 <ZTb/HeILRHnZjaz6.jacob@initialcommit.io>
 <62164acf4a787042dbb6e5abe212559b@manjaro.org>
 <xmqqil6w6al3.fsf@gitster.g>
 <8d45763bb4fa4c7d1e1f69dfaf93e647@manjaro.org>
 <778c4540924ad076269ac72097cf3789@manjaro.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <778c4540924ad076269ac72097cf3789@manjaro.org>

On Fri, Jan 05, 2024 at 08:14:34PM +0100, Dragan Simic wrote:
> 
> Just a brief update...  Some of the associated patches are already ready to
> go, and some more are still pending to be implemented.  It took me a while,
> which I apologize for, and now I've also unfortunately contracted some
> really bad flu.  I'll be back to the patches as soon as the flu decides to
> go away.

Hey! No worries - thanks for letting me know. I have been thinking about this
and am looking forward to getting back to it.

Hope you recover quickly. Please include me when those patches are ready. Then 
I will try to align my previous patches with them and also I have a bunch of
restructuring/refactoring to do based on the previous feedback from Junio.

Oh and happy new year.
