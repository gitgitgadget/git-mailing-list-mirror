Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4AC345753
	for <git@vger.kernel.org>; Thu, 19 Feb 2026 16:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771516841; cv=pass; b=S5HmvfajekU6ZYxO6jvu7GI9rkO6Om69/wErF3ybJZo3HAtfItKwfgGfYgW8FpkGIVS/i26E/tR0nSfYKGHMsVNGFOTYb4OTQFPibptEEH5yd6khncSETmj/D7aOeXUyu86dASpfmoisThQ9Ie1tWG3lpPOURIRqTUxj53bxIGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771516841; c=relaxed/simple;
	bh=KKy1WG2G6YWcX8i6OjqWt/iCUyvtntSsTDOKRgXeiPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c4hQ1Boyhp0IDIM4augliaocK88vPqMDPUbnOWYzyrHSASc4pa6Bo/kLww2zSaxQ0YKsvOwF+c1HkJfpPIA5TN44nK4S4oqvDI2wu5DMIQVtPru6EVEvYog5C8B/tjgus9YbOVrpRk6sJc2JZDqlWzW38GDLXOLaqjlU77cCklU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SbMNRy32; arc=pass smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SbMNRy32"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-46390d4ac7bso635179b6e.0
        for <git@vger.kernel.org>; Thu, 19 Feb 2026 08:00:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771516839; cv=none;
        d=google.com; s=arc-20240605;
        b=Q+9rqCh3k8MzXLoKSwDCJSd6Z8qYpgfVfuYRHw7NKtXyJTHpicDwJVwjUrd+6Xp131
         UCw17n7IL1vpLTCWsPREV+Ce4cUhrBIhWnIdAzpMVeN5XZbYSze/G1BzxSQEepDkeUW1
         +Udd5hkIfzbzKaxAq5fp/Yl3XygjY+kLOZB5aB+P7ruOCG+Df0JM7hkznzaCikzlhnJU
         qM+7Mylvdy6XgzYzQkOtuwrkIE57a4PZjaMoiMmSaMLJCx4tfIkxWMqZP4cIsTaP8NQj
         EOEo+0LxxjTJtzSgz8U+5NkFKC4zVL03kuZymR4ZhYlYSH1Jvp3ODcfBYGlM5B88nTU7
         mAsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Y3XbjxZB/o8+m7DqOM7Ge3w5BxRc6kavBbXmqFyhXfg=;
        fh=jEOs5fJkdQOPr9N3biEOJbz+II7XvDRJU/sAwlRmGqU=;
        b=Fpe4OvFa5BTBDcX/JDem72/V1spkbcSVHJs2FTPhkiAwRzLlplUin4EBLmRpnrSz+3
         gwBDMA4QC8TgMIIVUig84ZroV09IiJ2SVqreDdXQl7+CupdyeGa98p4Anx6YREPMG4T5
         vehlBu+EbVst0rHYDSOjcsd334ttQlEgZDofu03A+lxL+Bq4tEKUmnddA/lkup3gw8VW
         GvAizWL+qfd3MHijqOvGLN1gA3r96Cu5jWof0jfHClqqunHCr3EHkTVNS+3X7JoI32Bl
         xeenQ+wmMTfccJdQBD+uuoKJHZvDho/kYvbIWGgF0PCtsmkAC6k8EBVh3B8QMQUTgwMb
         YhHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771516839; x=1772121639; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y3XbjxZB/o8+m7DqOM7Ge3w5BxRc6kavBbXmqFyhXfg=;
        b=SbMNRy32lVfykp/XrbC8pWGH6VI+qD2EDRCCWAe5gqvaG0YuhGq+61JA04ej7EOE7d
         ZrYmD83tJnQgzXgUm6U9+U7DeQAyGQDxb2uO9rDpRv0E0tDGxK/0wB/UKQRvJytKrXod
         fvkugZDxjtzgGILW5pDcpX8rVwB2p8RWCDBbqB3NOWqJwYDKNlrMwnKHyo++yyL1610F
         hz0/wI6Ish92sZs2wn+oBrpzMy/lO8dbwOEHQD2K2NOQtx9SvWIgWZ7ek768maD+WxgV
         y+ODIuug9pxy25yyPQ0kTLXUBS+hc8syGnEE1zOZvEs7jrLmKF8n7bC8WKhfqj04lQ4K
         c6UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771516839; x=1772121639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y3XbjxZB/o8+m7DqOM7Ge3w5BxRc6kavBbXmqFyhXfg=;
        b=thEM4cYQCS2s8TPFFbgBSbt4shSSdRlwIMRVMtaHat9sgK0gyPi+BKWJ1qK9XNXeGq
         SUBCEPbWThrdaWoJQAP2QPpKnhlSHdVTtPhxGRSyMYrMQQK3QNQ8IkSpZg9cf6Ym5Sju
         sVFcsIuBVdrnZ9Ng7YFlmsBFsAr9DH/Wqiofdk3stTydxQUcyaXAzjR5jsqeXIe+IHRF
         NnOtUZIvZtaWNli6i/aDTzkzA0HCXA381Z/Dbjqw6h2Qkn+08W3Mj38yS1ZGTeD/aEJV
         JsJj1xiI9CWlaS9/H579UnsREIko/V4S0zFoU8RZatWLhr7DwDZTqp3bGPCclHCq+cvk
         3KMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjcIsbG2k4zfwNlYb8D//10omnLQGqtrXjjLdWZpNwbHvcUhYgfkLsmTx2MAqN4372RwA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaUP7I3SS31peyWom9YdCy/QGmcrNZkqWsHCtR+mFtbygrZn6o
	uvicUqOxT8/tS/NCwMFq9qmoCkB7gRmpJaTR5HhsJUrhCcT2cd8/Oz58bncQRAcru9X96GY35l3
	p75bWjDGBOdEb0JbTQXzzYy6md0ttsoE=
X-Gm-Gg: AZuq6aJ+Vome8LrBkyvHUD8gQTgw/gJnddajJuKQEqBX/ek6+eBPp6pOZAX8DDkH2Gt
	qQJH0mbuX02lOSNSoP7+3FyyQztkop6ysOw3NBr5E/4famUW8NNZ6CinrDie4QDeJbrWUCaO7U1
	jcCg5HBGtawhMgAQFWzovrxgILFzoSS7xvMS6Cr4Vbk9iuQykVwMWGX1IH1c4ydv6rDbUZbgMe3
	GkmrxKaG0xEMjVuwdIAS6phUh8SKbH2Qo/AaarA7Q9UmZYZpR1ykdvCc8Jl+EedAo5ADF1m8ai4
	3WFiK15P4WJjgvaV340F37FZkZz0ums1fXNYxGB2
X-Received: by 2002:a05:6808:3028:b0:463:bbca:4f15 with SMTP id
 5614622812f47-46410b25e64mr2503942b6e.11.1771516839033; Thu, 19 Feb 2026
 08:00:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2048.git.1771406115.gitgitgadget@gmail.com>
 <46c24e0d05a91f830e400914a7e446afab320859.1771406115.git.gitgitgadget@gmail.com>
 <8ac118b7-2d39-4a0c-9a61-d0c7b045b231@app.fastmail.com>
In-Reply-To: <8ac118b7-2d39-4a0c-9a61-d0c7b045b231@app.fastmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 19 Feb 2026 08:00:00 -0800
X-Gm-Features: AaiRm51pbhSwgnkpXhic5iJA1O9Pht-SVRbbM4YSQMYxnuCKxSwHjKvp6YdZK8k
Message-ID: <CABPp-BHiLxeH1Aw0Ag9voQfYghSW5B80R21TZURAX5eP+mj2AQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] merge-ort: prevent the_repository from coming back
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Koji Nakamaru <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 19, 2026 at 1:48=E2=80=AFAM Kristoffer Haugsbakk
<kristofferhaugsbakk@fastmail.com> wrote:
>
> On Wed, Feb 18, 2026, at 10:15, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > There are two things preventing us from removing our usage of
> > USE_THE_REPOSITORY_VARIABLE: one necessary use of the_repository in
> > prefetch_for_content_merges(), and the use of DEFAULT_ABBREV.  We have
> > removed all other uses of the_repository in merge-ort before (multiple
> > times), but without removing that definition, they keep coming back.
> >
> > Define the_repository to make it a compilation error so that they don't
> > come back any more, with a special carve-out for
> > prefetch_for_content_merges().
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >[snip]
> > +#define the_repository DO_NOT_USE_THE_REPOSITORY
> > +
> >[snip]
> > +#define the_repository DO_NOT_USE_the_repository
>
> Here the casing is different?

Oops.  Will fix; thanks for taking a look.
