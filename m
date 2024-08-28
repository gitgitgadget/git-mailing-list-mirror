Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851C436130
	for <git@vger.kernel.org>; Wed, 28 Aug 2024 15:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724860411; cv=none; b=cb30BJ9rI+7A3rU1sBRYqiAzTYimXs4YrK/IrhvFCUjOlkvLmUKuc4l3K/PdYqdCUjvG9kX65JWEYLMdLKFF1zHZB/NmCGk8zftcbobBuU5O421Ieu6ltRuiwIavDqNBgoZB8Pz1sb4/U1FbWuq7jJs5u0OX7WhZA1iMVzzOUl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724860411; c=relaxed/simple;
	bh=W2lR7eNiuw7yIS1NViAhDVYn7g7hzxSJUTwsCLNrNkg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=VxFWYW15J+hXTcNG7pE+3bxiw/xlJAUbvGcGBh8FYzWY1M3DqmAwqnDMEiWDVAEefEjNytp6vbag7uWpOierKGwNikmlurPqV/xoHjViFqxzbpmfoGmWFrnB2q9DPMTSgBNIkMOCgxT1jSKCw5Ri+SXbDkH5LehDpqMvvylxeCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=lvU8uH0S; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="lvU8uH0S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1724860403; x=1725465203;
	i=johannes.schindelin@gmx.de;
	bh=Rl0wl9L4qO/O4EUBorF2mF8/hzsdG2qrs9gvYa0yP1E=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=lvU8uH0SYe6yGNTcZPHBQo4jsvCG7Sf0GIR3UUkoD5R/8ovJZGPUm1Tx3OX4xMJJ
	 1BR3/8en2McrQ1bpFbp97XYx0hmyYaEDZmMIwqFe/Kv0u2Bz9BOOnwu4dpOwvroMN
	 JTgNn7gK6BHRvQ5oEXVO4Z7TCJJ6mF/51+ne2OOjy6Hlgv5H3h+hbHcscfJ+UIEQP
	 5YdLg1MD3v9MgSmGL0F9W4q4nH6nZCqhk5fkK+DCeIUTHS/YtbHLWk2bqRyKagvl2
	 lvVwBGFqY0C8FDLgeIWBepvjP42btl19s3Y47yqvFjHhBromSq81cudKA2kc1/xA1
	 HKIgcft1F83iNFYyFg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.215.249]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1My36N-1rstzA1ZM7-00wp3N; Wed, 28
 Aug 2024 17:53:23 +0200
Date: Wed, 28 Aug 2024 17:53:22 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: Marlon Regenhardt <marlon.r@hotmail.de>, 
    "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Wrong error message when cloning from http gitlab (and everything
 still works anyway)
In-Reply-To: <xmqqh6bcva55.fsf@gitster.g>
Message-ID: <1a2fa9e6-fafa-8981-568c-007e4b6c8896@gmx.de>
References: <DB8P194MB08704DAF8B33C67FCCE43EBDE08F2@DB8P194MB0870.EURP194.PROD.OUTLOOK.COM> <DB8P194MB0870877CBCB0576CCCB520C0E08F2@DB8P194MB0870.EURP194.PROD.OUTLOOK.COM> <xmqqh6bcva55.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1822141633-1724860403=:110"
X-Provags-ID: V03:K1:sL/x6H5UTk/psPd83VvG93agcLfUM9ceEL4HroA8CnI1nWgP3WB
 35J3BBvX3x9zinDumGOT1K40SwWU6i0nUCgrNNiEd5uy9kFVgtWu3cMBfWuzxBEzKQMK3cl
 4os25zWbBw56mtV+E0j4Jm9OYpgaiQLvru/6Pwtf91PKq0y3YRK1QccIxyp8jofqVRvxrNW
 2Btvaor/D1OfPJwerRIKQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:go6N68M4Fn4=;aGAmSK707/M5x12LJwLgYKGG8OW
 ZSfbCgNtlirs6gO1cWudAcW8N4MZrJeGg57qHWSgLRloc7N6sBnT2mdSsExa+sscVLOIOhUoQ
 NVhBIzOFsxwC7607/R2bPMY/C+A6NAyGD++o62OeyIXkpNv5WDMM/J+GsF9nSHILDYxt65C2m
 ZxfQq3XJV9vMyombhHY7cFHz0fbQiKMnh2dmShUDfnu3KLzGvrkYweJjIz7P1EjT+W3RnG6Up
 JzRyBNEEwMPzHeYnRcK1sT6yFExiXfVs8wj+AMjIH05T0e+/YogXbx5pA/8K9S5HzD1SQkkfm
 QDiC+Thd5afXvaqVCtvh+2hA5gCCQVeU9aWobj27hE6kZMJhG+5cYdWCMq74v8ol/4kU5uUzC
 CHnkavaGn3rIwHqlZMUjbM6zHZ96YH6Rmc07EfMFn6WXuIMgYMayh8t1RhdTm/IFsYxWhcNH8
 ZwTf0uHXdUDWmbZR2lvi9SwRp+KSHm0yVytw+ZVC1D8CQSfFBkPh31uPIPvAgH2muxZkdZ9Fr
 Mmvd7OqmfUQx5i8dIZvO8sspbu+a2wnRldTY0JOmymvAcrbZhpL6IN8zV6dnd+3/3KG0KQc/E
 D5eS79lPRb3oxY2X7txS4q7IjOkWByOvFIkt+85kJno69wYiXkQ+wu23gO7dPDqIkFU9I8q2t
 +XMOxvNr9i44aMEvm5SV5sSrMWOe8/e1+iQ7V6uWUlBGvBmBmNZpnFVPmP0NRvmEbWXWTc9Hs
 6BtzHRrwZlXKs6LKSunEFDw5oRokVzNVQdPAoy/5Wpf1bZrQefqqiWjlaKgcLxQMHewTqmajW
 cx2Ykq/Sp+o1ECCxZcP8AyeQ==

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1822141633-1724860403=:110
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Junio & Marlon,

On Thu, 22 Aug 2024, Junio C Hamano wrote:

> Marlon Regenhardt <marlon.r@hotmail.de> writes:
>
> > I'm currently setting up my new work PC (now Windows 11) and got a wei=
rd error message when cloning our repository:
> >
> >  - run git clone on an http GitLab instance, in my case I ran `git clo=
ne http://gitlab.company-local-domain.de/group/project=C2=A0LocalRepo-Name=
`
> >    Note:
> >     - http, not https
> >     - GitLab
> >  - Get the following error message:
> >    fatal: Unencrypted HTTP is not supported for GitHub. Ensure the rep=
ository remote URL is using HTTPS.
>
> A funny thing is that
>
>     $ git grep "Unencrypted HTTP is not"
>
> in the entire codebase of Git gives no hits.  If this message is
> coming from some add-on Git-for-Windows ships with, a better place
> to raise this issue would be Git-for-Windows project's tracker page
>
>   https://github.com/git-for-windows/git/issues
>
> than here on this list.  I tried
>
>   https://github.com/search?q=3Dorg%3Agit-for-windows%20%22Unencrypted%2=
0HTTP%22&type=3Dcode
>
> to see if they have that string, which found no hits, so there may
> be some other components, other than Git project ships and
> Git-for-windws project adds, that is in play.

Seems that Marlon found the correct project to fix this:
https://github.com/git-ecosystem/git-credential-manager/pull/1694

Now we only need to find funding for non-security-related work on GCM and
we'll be good.

Ciao,
Johannes

--8323328-1822141633-1724860403=:110--
