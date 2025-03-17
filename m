Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EDF202F60
	for <git@vger.kernel.org>; Mon, 17 Mar 2025 22:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742250791; cv=none; b=ShNZ00y76U6C3tnSoa8G3WmTMQjKA+Jx8s9elFVCqfVzgG9pBUaXKYqtBcYAiGwuRX+n3/5CKdG7JlJCWedh+7K2eJ7aK8tEoIfh0bBHc4nAc1YI9p5WRvv+EczA9I5B4/MyMbNrEqmeGAAdFHkEH3rKz5Kb1vtYpzkDddADJbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742250791; c=relaxed/simple;
	bh=CazTCtF8YkP5QCzhRWTrZz3uL7J42vkEOekNxxxJqOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VTJn9UQ/3sMjaj24C2Xw9EN0zqS/GuOLCiyVVN1hyRi0f6qnA2dBWAl7YZc3BqbIciVFSBE7ZNCshidSOTUtOmQKAkFcv6pQFbocvIPKPx8DXZhXHR/fO83H+fbdeXTHe7fLJocmdF6o62POUMjckACgcBVhBqTmu4dI2tTLLdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=qAi4rLL8; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="qAi4rLL8"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c3c4ff7d31so632626885a.1
        for <git@vger.kernel.org>; Mon, 17 Mar 2025 15:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1742250788; x=1742855588; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CazTCtF8YkP5QCzhRWTrZz3uL7J42vkEOekNxxxJqOM=;
        b=qAi4rLL8Qu2XlCDbkCRKlsMgKJACw9XVsrZgLf8hrjC7hdyi2II3cLWBl7uCad73FW
         0o8lyaSahCDjb4DMQFIakuFdoSeKWuTTpL6q+q9xU0QQaK6gbZFTTlQV4dQOzQY2xFJP
         PwcK96D23KD+r+jaXEdMmLVeHAal/CV7JoTnctj7FiXRbzu/kwrCjiBa5XTC5ancmwcI
         9X4t0ez/C8eBLavOL/YjTux9FlVc8YoSCxbUY50GNNTtTLULG6/FYFAy7wjY1Nvx++6f
         pgBYassSHjzC0hXNACyZcev7LNnLhwsu4+oS4miUK+iFkRqlh6UVF4WtxGmlxggdxtCw
         kvhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742250788; x=1742855588;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CazTCtF8YkP5QCzhRWTrZz3uL7J42vkEOekNxxxJqOM=;
        b=XSpd31C2vxWPCAlDW5jEUdbixuqmmIEr1wHQbmUgpGUNS7o8oinh46NulK4o9cLyIn
         ZcHJ4N6IQti1gvIsv3Qwp3CbK30l6sklIzf/sQe7eWCxk067CJ3+JzdYwqWSvPpEhAdd
         6SJylxR5YKu+RmDQWMHM4x3l9OWLpaG2KTvOlpU0WabdgrkBUFM+IOhKUFTEVt5FGwc3
         N4hd3FVQfOzNwotSWY7oJr6MDzL70ENFlPN/nELiokEPUbIfrhr0A0KPK7daK8KvjdUn
         ZtKVNCYE1NgaQ7tg/9Qi5SZO8WPNd/xw4MnzEDCK7fkyMwAMeiztCiMZw0hOjuV8ZC19
         fREw==
X-Gm-Message-State: AOJu0YzqWfJ7DiZq38SPwRFjQEEtt7qkRxGZJNCdPQeWfpkqRBxQHbLv
	A6bMnXdITWCmGCoTNJGtNRWRd9bQSU6B3Q4hprTeJ3cWxW+Bl0npOo8eRXz52Vg1BOpRKnbrPqU
	hd7c=
X-Gm-Gg: ASbGncuhMsxfyP35dSM8uWeWJq+HxJtvCFuRSveAjSloqhj4Ie8A6fHCI7pOByCpfAT
	XhhvAj6yzMoxUzLjk2fp0wY7R6BzYxIoukNwcRExs9fI8h9XOjZP5H/4GgHGU1H8doO4CaNdXzG
	v7CG7od9o/t4cfEWrgomo+7MmaGjiZmVFCPEKdB2j4UKLFOq9bVIjuQRpAfdnwPL5adVF5Su8Dl
	i0e7wKf0QPCybo5vAcEZ9+rmEpvZmIPwVc9541Sz6RRzek4ylgRn3dk1jWx+fFeGV/KwkpkoC+Q
	nB66HheNJBVk8WhmbVxVKzBHaV/TGYJqLy344iIqpmesf8hVSZbS6UezEuOiLpANYwyRa2MVQn8
	9OT+wyJsnhh8rU5qN
X-Google-Smtp-Source: AGHT+IE41GyhDjqEzF27UCZfegxOfVZPGr58JiBNhzKLBbaAhyX2GkVhn5x85hUH4kMImHY4NWDqRw==
X-Received: by 2002:a05:620a:472c:b0:7c5:5296:55b4 with SMTP id af79cd13be357-7c57c79b7b4mr1704788785a.11.1742250788282;
        Mon, 17 Mar 2025 15:33:08 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c573d6fc7asm642591585a.70.2025.03.17.15.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 15:33:08 -0700 (PDT)
Date: Mon, 17 Mar 2025 18:33:06 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 3/3] treewide: replace assert() with BUG_IF_NOT() in
 special cases
Message-ID: <Z9ijIkCU+Tmt9H8i@nand.local>
References: <pull.1881.git.1741911652.gitgitgadget@gmail.com>
 <pull.1881.v2.git.1742107322.gitgitgadget@gmail.com>
 <20c763f295105bda9a701b9bf5b9aa47af5bf1e1.1742107322.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20c763f295105bda9a701b9bf5b9aa47af5bf1e1.1742107322.git.gitgitgadget@gmail.com>

On Sun, Mar 16, 2025 at 06:42:02AM +0000, Elijah Newren via GitGitGadget wrote:
> When the compiler/linker cannot verify that an assert() invocation is
> free of side effects for us (e.g. because the assertion includes some
> kind of function call), replace the use of assert() with BUG_IF_NOT().

Nice. I guess since this is split out into its own patch, we wouldn't be
able to cleanly run CI on the previous commit, but I think that's fine,
since we don't treat CI as being nearly as precious as being able to
'make' anywhere in history.

You didn't realign any multi-line assert() statements, but I actually
think that's preferable in this case to demonstrate that the patch does
not change the behavior of these assertions.

Thanks,
Taylor
