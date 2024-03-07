Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA6513A27D
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 21:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709845769; cv=none; b=ECWAhXCGV1DxNj7jqiAo9i32PTXlx85m6SJLsvSGXi6qoVFp3bAlVb6jFhcxkVyoXzUHyEF0RZIWvHh49ZC/R0ZRufsg7iG28LoHyrKdBT70taDvyWWtS8CciGGcHZHD2aWNvcqmp9LnwlEL5o10hldxOZyk76xM2u73OX08LkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709845769; c=relaxed/simple;
	bh=WM/6XpXGqJhdvjcV9eohw1R+qQXEe19imzCh7LdiQ7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L3JzqOpADNmrPoA/4kosEGA1oS6XiFkdWIOHAUYfAX6wkcawlyhulleZVkzZQ1WKSnwCVzR7oUw1+/9bUxKSUMkjVV24MCeqOx+qapVP6eNYnr6aLSDNxJRHIFO6uHzGRteC/C0imlpCeBFnl3lb1Q3P61i8CnhcorAzpLGnC7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6906a7870f3so990726d6.0
        for <git@vger.kernel.org>; Thu, 07 Mar 2024 13:09:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709845766; x=1710450566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Epu5c3fstoGTOu9EoOmiLLEWX2CPXvjvx0a1U9dJD70=;
        b=shDzZSqIUjlLxKxwvV1LHMwvAUAy+GimU+/M4rVjhhpfSU0W7mte5nE/ruNsuTsW2i
         fPOXqGGG6hnFuf3vmO4GtqHcC3ZJLETy+0Ce1DnJdWSmuUha+ZEKR8ihNg++b6aNSTmX
         nWceLwKC8Z3vfQo3MJ/JXxQwzrIMPoC2gh6qBr036NU3BwpYJ4aRTcXOzxMT4ijj7ySj
         dxd2KTy3VyyJo2zkJYYrMaPqb1fAvZTRhAMVTFqqpTKD1z9j0uoYAbD/vDBnIY9cvy9c
         H+yuD+WX1Og2ISGZ202h1THa/KXmEUGuStKFCqhzXSRw5UTjkehA67bbP7a4Pynuo/a2
         H2XA==
X-Forwarded-Encrypted: i=1; AJvYcCWsDAV7TdaEu0FFxhiNTPvEYLk1iY+9uUTcjOYJJa7TI5o964s8WFvqt7JRzeErmQ8wEI1LTagUgNStRVnR1gJkVnqa
X-Gm-Message-State: AOJu0YwRwrPahShlX+uironOwkRJBh6MQzAJ5SJFLeiiH9da1cDYkOxP
	dmuXQHpIhCGpjKjrt3TCDKhxQPOPuZWSUnAZ8I+vuXi/iHq1fvibyLNXzgpVKJuui+bUn6RNSP7
	Usz4pRtGC7sPZhIHty86SIzcoCMhwA52FQcQ=
X-Google-Smtp-Source: AGHT+IEyJlES9DA/ddnkD5D3mx4+JQPLYqfL3WSF9Z/OR3Am4/tYTj4Mkyo3S6WFfoWZNeeiRSUex0elEYo7LagHDHk=
X-Received: by 2002:a05:6214:716:b0:690:67fe:c38e with SMTP id
 c22-20020a056214071600b0069067fec38emr9075341qvz.16.1709845766599; Thu, 07
 Mar 2024 13:09:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307183743.219951-1-flosch@nutanix.com> <xmqq34t1n91w.fsf@gitster.g>
 <xmqq7cidlqg5.fsf@gitster.g>
In-Reply-To: <xmqq7cidlqg5.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 7 Mar 2024 16:09:15 -0500
Message-ID: <CAPig+cTgusL7OH=5DJY9ef4YuLw5WBKgDFcbSu=QKFjjkforkw@mail.gmail.com>
Subject: Re: [PATCH] wt-status: Don't find scissors line beyond buf len
To: Junio C Hamano <gitster@pobox.com>
Cc: Florian Schmidt <flosch@nutanix.com>, git@vger.kernel.org, 
	Jonathan Davies <jonathan.davies@nutanix.com>, Phillip Wood <phillip.wood@dunelm.org.uk>, 
	Denton Liu <liu.denton@gmail.com>, Linus Arver <linusa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 3:47=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>  * So here is the version I queued.  I have a new paragraph at the
>    end of the log message to talk about use of strstr() and how it
>    is OK in the current codebase.
> [jc: tweaked the commit log message and the implementation a bit]
>
> From: Florian Schmidt <flosch@nutanix.com>
>
> In general, if wt_status_locate_end() is given a piece of the memory
> that lacks NUL at all, strstr() may continue across page boundaries
> and run into an unmapped page.  For our current callers, this is not
> a problem, as all of them except one uses a memory owned by a strbuf
> (which guarantees an implicit NUL-termination after its payload),
> and the one exeption in trailer.c:find_end_of_log_message() uses
> strlen() to compute the length before calling this function.

s/exeption/exception/
