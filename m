Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C140364B9
	for <git@vger.kernel.org>; Tue,  9 Jan 2024 10:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EowxOcIo"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40e4d64a431so7001815e9.0
        for <git@vger.kernel.org>; Tue, 09 Jan 2024 02:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704797064; x=1705401864; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xxkOqW4bfZ+ndN6BN2UgrAIR8xUd0sbf8m0xrm5/XGM=;
        b=EowxOcIo5bqIRR+28N8+XiUnz/m/rE/GfDphOkQ/QGdQ2SzQ9QyzbTE7LNxeT0sbOJ
         1j2TF15oPqWr9Ek6LW5IJzfkKJj4XwiPj/3anL5KqkjFg2cQug9BSzhuNG3siXc8c/go
         O4JcR1lb2+cy73Ti6xFoHLkrXUXJEhpMfF9N/8vSWlEDH/69e+L+c8Z+NMltX0T3qKhX
         /DhnmJFwZ+KF7wY4Hji2p/P+HS0Xve8DxF21wev9KbJ/ZRv+h3y0jp2/XTe7JuTdsidf
         au6NydIEKqC5PmVz0w/A0DWNep7xuFgs1jr/1o2yVkc7tulJ4/lm5Y4wSTZU1GpvZ/xk
         C32w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704797064; x=1705401864;
        h=content-transfer-encoding:in-reply-to:cc:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xxkOqW4bfZ+ndN6BN2UgrAIR8xUd0sbf8m0xrm5/XGM=;
        b=jscTJ/w61vY7zW843v/0OtmiJ8V3Xz4VRjgItGXdNSGuJUjXFYnev7xnViBiyUK8WE
         YBHH8xEoSHjK1XTGa3EIsMdTlFaWigFENEiPRw4zPWujph1rJJb62XngEdtKV9mPd/F3
         3oqH+r9PUoNSckX+cvGQzhi+I4ukWJm53oVtl41wl0J3glu+4sGvaPeQm9ObZ3pORKWl
         m70FyH6Plx0Oqw8OkJugVgE/ihewLYk7p7FP6t+/eaYquIMZiKhbtvb6nY18JRU6eV8T
         8AsXlmPkXpWg8KlaC67ubF/wGtVwhQsCTELHMk4sIlUxWSgXPL31jF2p8YhjIbywI6tx
         chow==
X-Gm-Message-State: AOJu0YzEEEnNzB0iOZQeHzSO/uzfF3cTuK49bZKeMUpwJ/E/g7kOawCP
	4OF40G6yH4F0H3FvHKrgsVNHYVvR8b8=
X-Google-Smtp-Source: AGHT+IFGcaIcRYodumxdUv7YwHRQ7wZweN17Amd1HCuQKRqEgAPIVh7O6CRqIOrIjtKhHGdxCDGDHQ==
X-Received: by 2002:a05:600c:4fd1:b0:40e:3b47:eb71 with SMTP id o17-20020a05600c4fd100b0040e3b47eb71mr2812843wmq.73.1704797063715;
        Tue, 09 Jan 2024 02:44:23 -0800 (PST)
Received: from [192.168.1.212] ([84.64.64.237])
        by smtp.gmail.com with ESMTPSA id b22-20020a05600c4e1600b0040e4561e231sm3056183wmq.17.2024.01.09.02.44.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 02:44:23 -0800 (PST)
Message-ID: <2113e178-149b-49aa-9d78-ff1c480f754c@gmail.com>
Date: Tue, 9 Jan 2024 10:44:23 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/2] t7501: Add test for amending commit to add signoff.
Content-Language: en-US
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>, git@vger.kernel.org
References: <20240109060417.1144647-2-shyamthakkar001@gmail.com>
 <20240109060417.1144647-4-shyamthakkar001@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Cc: Christian Couder <christian.couder@gmail.com>
In-Reply-To: <20240109060417.1144647-4-shyamthakkar001@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ghanshyam

On 09/01/2024 06:04, Ghanshyam Thakkar wrote:
> This commit adds test for amending the latest commit to add
> Signed-off-by trailer at the end of commit message.

If we're not already testing this then it seems like a useful addition, 
thanks for working on it. It would also be helpful to check that "git 
commit --amend --signoff" does not add a Signed-off-by: trailer if it 
already exists.

> +test_expect_success 'amend commit to add signoff' '
> +
> +	test_when_finished "rm -rf testdir" &&
> +	git init testdir &&

As Christian said about the other patch in this series I don't think we 
need a new repository here. In our test files we use the same repository 
for the whole file unless there is a compelling reason not to.

> +	echo content >testdir/file &&
> +	git -C testdir add file &&
> +	git -C testdir commit -m "file" &&

I think these three lines can be replaced by

	test_commit --no-tag file file content

> +	git -C testdir commit --amend --signoff &&

> +	git -C testdir log -1 --pretty=format:%B >actual &&
> +	(
> +		echo file &&
> +		echo &&
> +		git -C testdir var GIT_COMMITTER_IDENT >ident &&
> +		sed -e "s/>.*/>/" -e "s/^/Signed-off-by: /" ident
> +	) >expected &&
> +	test_cmp expected actual

This section of the test can be improved by using test_commit_message

	test_commit_message HEAD <<-EOF
	file
	
	Signed-off-by: $GIT_COMMITER_NAME <$GIT_COMMITTER_EMAIL>
	EOF

Best Wishes

Phillip
