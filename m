Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B1E33C51A
	for <git@vger.kernel.org>; Mon,  2 Feb 2026 08:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770020166; cv=none; b=EjwNoVSwN75E3KC1jL5mHVN6dx+3WrMkIraULrYak5VhcIrcok4gzLwHhPy+bnVaoA6RmCqkcYQEmWAghnBpQvxpt+jo3qnVdU0MOZ0QqkagUp7zG/ftsiKrV49xFwbtO/5Bnkm7aB5gBsp2xpnntGVsPCCrXlOTlbKCqJ49Fw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770020166; c=relaxed/simple;
	bh=kq3D0KHzQt5hFJcOrYiEiaQdUxmKlQ4JZn1u+UJ6ZTs=;
	h=From:Date:To:Cc:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=RGmpg3xoeaf4yhVOyp4tdOeyNSDjKOMuX/e6tJ5FskbsPNbXVbjHf/z6+sR+laZi3Wq1BDwiGfqEQt+Q5ZLZnQ5E0F2XKZTeXqjozgp8diJSquclgcI2zWv5QFwNAtrbuZmY9f1Mv29YCuViOu0g9IzZ7NfMzYHgY4/RGM5oZqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jk68Pnu1; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jk68Pnu1"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47ee2715254so21518055e9.3
        for <git@vger.kernel.org>; Mon, 02 Feb 2026 00:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770020161; x=1770624961; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=kq3D0KHzQt5hFJcOrYiEiaQdUxmKlQ4JZn1u+UJ6ZTs=;
        b=Jk68Pnu1jZyVtQFb33jVGIZWF8/J3MHWMo5takaHxR6CEenSXxoquzd2W1ZZcpHfIo
         QgnSuWga06agk44prwOwNM8fKkuu5AEHRRRk8AhED99uFOaIOetG7XM5j7RNKxbz0zYE
         Qv8F2g7AVNlpaSnprxtLOmYKLVZNR7ogPEZxBeZcz/R/8wjRbwsHedvJ4r1pcVWnlihX
         Btmb7CHr/CJdIOTIHp9FYcMb+6Dz4iNOL7ZiKQ+PmR9kOPN5zAx2ukcUZadJZymw5TLz
         GpW57Cg8hLsa8+AMMQL++JcSlFFuwsTKpPxjXRpbnsaeTngJlnhyqirgwxgHvw7xGtJG
         o2dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770020161; x=1770624961;
        h=in-reply-to:content-disposition:mime-version:message-id:cc:to:date
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kq3D0KHzQt5hFJcOrYiEiaQdUxmKlQ4JZn1u+UJ6ZTs=;
        b=O+DWfTz67eKxxIskxuakjVItHVe3GVQqTolYmEHL3AdCoNWHDCJ6uMGRdYelMqBnDn
         fNpV9qLAKQbdU8xAyNidk7m1HRODnhnsla33tJt9rZKXyGRGrPdhpHUjqN25M5yZm328
         BfRrhja9Ikx0yKuU9kaL+MjL3AnMMbxfY9FbUot3xI28dHy7cACE0m6XmqhRDqtv3jnw
         apThE/hoG+879s6Ecp1gcQlvymI5OYAnMhhcDoao6TSXuDQs38K6WSZkLblhqRzuhLUj
         L3xJS7FG4EFDeta36gZlkvB4n7mFEaxNuRZmkPC1nDF2BYb3ZhZvrW4DNI4ITr38fCk4
         xHHw==
X-Gm-Message-State: AOJu0YykEQFKLXZQMlU1oPF22OAqI7Q3vFvcPPhpYWOW/JceXyhtAt/7
	2/wUe4frZ3IdtNLnMRKXHprVch+GOZCU0A3BaOXtHtrcGZ+LC8QPC9HR
X-Gm-Gg: AZuq6aI9Q9UKAq36mEONxUMHDhTE/p6hxDWDylxdUNUb0TjASW1p5qvjRIIcZjDwDG3
	6GXJYFeWZF3Cu1NtnG3F4eoITPbS18Ob9kobqAu/rZ+nL7DAm+0fYJGVUDf6EPHLxlRzCO4S66u
	qfPBHYWAUoK5AYJ0FbGspMOpiDxB7upj/ZTt95Dd5n8OtzI2kpupPw125WRbyqVivOSjrRMmH4l
	RqMczzmxvH73dv/1LRFdF9nck8ZwmjPhkTlF7RYfIbvuROMWuC6GkoH4eks1ktV0exHxncMk9Zq
	tp3bTX98av+v9C0jhNu1Jy1O6Hj8GIUdSYNldmFVPkzxvC03nMwJA1LI82zDT/in6YcZK2ITk75
	hdFYHKSyUZor1pxM+ay9kFLwUgpLjrLzKuGMA3Ysadb1H4QrB3+KE0HAmnK5xZ/+wf8oYMgKmUg
	OyQ1KT/tsu2gQ5LcrkrnWJUuAgrrFRYKTa+JD6bGAeCiczSO/0zMzxrA==
X-Received: by 2002:a05:600c:8716:b0:47a:80f8:82ab with SMTP id 5b1f17b1804b1-482db48d4c0mr141894185e9.24.1770020160933;
        Mon, 02 Feb 2026 00:16:00 -0800 (PST)
Received: from localhost ([102.88.77.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10ee040sm41803641f8f.11.2026.02.02.00.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 00:16:00 -0800 (PST)
From: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
X-Google-Original-From: Abraham Samuel Adekunle <AbrahamSamuelAdekunle@adekunles-macbook-air.local>
Date: Mon, 2 Feb 2026 09:16:10 +0100
To: valusoutrik@gmail.com
Cc: git@vger.kernel.org, deveshigurgaon@gmail.com
Message-ID: <aYBc5rQeAgOFcrxc@Adekunles-MacBook-Air.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPHqhPkuCLS4nndNe+2Hib_Jipb06t+mSFMiON77RHMDxPY31g@mail.gmail.com>

> Thank you greatly for the direction. I did check the microproject
> page, and the first contribution page. I haven't fully gotten all of
> it , but I am making progress.Right now I am trying to understand the
> first git commit's code by following this :
> https://www.freecodecamp.org/news/boost-programming-skills-read-git-code/
> , ie the initial 10 files. And from the microproject ideas of Gsoc
> 2025 :

Hello Soutrik and welcome to the community.

Please try not to top-post and favour interleaved style.
https://en.wikipedia.org/wiki/Posting_style#Interleaved_style

While I think the link you stated above is a good resource, I think the
My First Contributions page is a good resource to get started, after which
you can find a microproject to work on, push to the mailing list to understand
how to send patches and the review process.
I can see Deveshi Dwivedi has already suggested this to you.

Thanks
Abraham.

