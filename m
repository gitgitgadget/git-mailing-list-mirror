Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6C338A734
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 08:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780560672; cv=pass; b=qOWcRCYoB9ZPXremqwTcgTBFiD6UQhoSsNWiAtpvEO5FrdKH4wXxURfk/q3ZJbPGxhLdizoQ33mVdh0/RGRLY9W2xV4Fg/sbS6X7KonGsiDEymAVxg0mYf2pNq6TkbBZaxl6Oy5kiPg9G8VJJTG8Rs/h4rG6NHVFR7n+X8AVUEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780560672; c=relaxed/simple;
	bh=Vj1dy26P/QGgtQ/8b0kKRkncA/0zYSKskVkuf6PbPtU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jkPLnFwUjgSRKCmN6+LyrUTE7hXXA8GtHWoF73yo5VdtuF1dFvaUURl/2V7OFanXjBkPpzEidu+7NNpfEGDxp36e3QJQbdNhjZzbvSNeGjQ+w8USfQFCUplA6EApzjJUh2Un7C654vK8Zab7NUUIzNlinr0Uma4DFs9hBoneK7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IB5DjOQF; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IB5DjOQF"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-137335bc3caso517985c88.0
        for <git@vger.kernel.org>; Thu, 04 Jun 2026 01:11:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780560670; cv=none;
        d=google.com; s=arc-20240605;
        b=lQrGnlCMFeu489uykVDI0K3Q8nhnrGaLCGU0FdJn72LZyLGkrbBRsxI8LvFM//wDzB
         gvZqcSjp0JSB/9BQYUWWhvEBYBHnnMCsJh0dEzoAtywfbIIo10/p7RK+PvlmJYkFfwHS
         hdhGOVl2w971Zx2X8bK5q4xYdCQvyvXMiM0ChOM/U7xrDEvRoc5VoPxnoWqKTwE5DOPQ
         LcVaN/mQ8rb5ZRClPPLP8NAXQelhtHbpMyVU+EO4TG7xEEDzNslk6hwVVcaQxQiWS4Dc
         uToVXM+F5i/bkxbTkvQ3c+KhzvBNQ5QefyrSQl0IWmX5qO8QqRLxkfptqvJ/HFOoaSRb
         r9KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BQkdgw2ijhHEmW5qEg0XGyFDepMBWV7spFf1npyljBI=;
        fh=Y/d59sITq5949WwvU3zYdo8lHPNrZ3W0dZRkIOr+ZHY=;
        b=h/kPTzM02x7Oj69y/ilc+RTwm6g8M2SDtgho9PinHe5+3184YfrXtDzzCZzEzcrz6L
         Gj67aBhsSc4QvZIR+9BFNpCu8PREiJWASJ4baEIp7WpsbTUnjgDin77fEuofcr7CcfNd
         Igi6FBdmSCPI4q/e4Q9ywLaK+e2/jg+5vc7FWUVcjbMV2vnV2XTY9l/NYh0d6GsmoOJf
         GEc/8K9b4o4bGWBh9kXECGlNslEfY3/himsYTPTzOWQA1FLJv11KNi2w6PxMLUpftlz+
         WHvZcM/4s5m4HL2JFc7gOElcNVZIcn8cz4jKzXK1pKEbp+MUIVDNb8F8HxGKLF1KjwRF
         SCAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780560670; x=1781165470; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BQkdgw2ijhHEmW5qEg0XGyFDepMBWV7spFf1npyljBI=;
        b=IB5DjOQFh7gPVCKsMIgudMIyYCh8c735MdtN8TC7ltqlp1OyzfH+yDTYkvovh+Jzc3
         LqMSmAkpGQm7CjN0cdVLjnGSmmUSoNto7btsjbuCtZ8vUSlsIce66PWJRCZGdVYwqFK9
         f3OBjzIVObvUH3Ddu8O2ZXx0/oj531hFnJThJQ5cYorFPP8EhRrCJkKTn7GjMCeTDN4p
         Cj8ZhzpDaZffu7lM4wiCeTaWFlpl3VZq43u5VoQnLXKIUaHHnqZObFWZ+u6YzVuSm9rD
         +ow4cpZWBVLWtbDvP7BaZz7P9lNzIW7joGIwtEDdaPjfLZpr5xfuulelLU3u3Rx+smKf
         HiAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780560670; x=1781165470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BQkdgw2ijhHEmW5qEg0XGyFDepMBWV7spFf1npyljBI=;
        b=spJMMtQvZne4zleScRUFyuAc2viIT6oL/Q6ibFqTsh4+NL/bRFNjirRzT9sxnknPg2
         nV/rGFaAeZ94pxwsWW5OYD+zaBuXqzRNaavwNSukmWGBGvBeoUcb2PwcYeJ4/Bz8eyZ+
         Mh9BxEOSwesEtKXiQluk/l3SEGcNE6nrE++RtXsRgqtMMAsoBHBzeCIiJ6qMt7ERvhC7
         zgjFXXWspR5co8GmXfGNpTXEWVj+07PiavezzbFX0mpZ0PeqmycUnBqeqwx4YSj7e1jm
         P6AsNLGBNEKvGyzUTMgshhaL166WgMtzjiHYnJAEX/LGrQ+4Dg9QOcuoPfHCjVSSlGfA
         rr7g==
X-Gm-Message-State: AOJu0YxpmsKPEJOeH2U85jCtU6iQsOqrWBXsag8xdfUAhj18apvdIUzN
	s6798vc8WsLxX8g5bD/VXBtcg+Ut4Cu5nG6lfL7QRAMA7SIKKNzxwzKE/5zTRQAznX7Ydhhj1wn
	+De+ZQrKhjwrA5oID2EiqAMEmevdOYOU=
X-Gm-Gg: Acq92OFTVdd0Xew1pCs7qs8CZRiM3/ZPIUU8bXYz3Nhtwi5xm3Y0Y7+0SPh2Fd7L2kp
	1kzsLmXvEXpudya+5iumEgIQbdzLcyT3satBnk+w7bnzShtZvHh/4SQq+RQ0I03LptQIVqieboW
	66Uh59vDu178qB5JH0k4Jy89ldG5XQwpiWQ8o2o5MftQo4EEtPfRmBzxcAMgSODEdwkrF1gsK5X
	BUf8YHgNRaimvMmo/sjDOZCewxR5lua6Y65XtIwLjuXcKdGoinU6/wdQH8DRMPw36wBt47QQDR4
	fe68koNSbhz2JMQ2QsZ6RjbV02O0i4qE+cpjwOPv5IvtGYNj/hPIO8+2QYx0aXppgUmZZ6aEzHP
	McV0=
X-Received: by 2002:a05:7022:628f:b0:136:c443:80e5 with SMTP id
 a92af1059eb24-137f6a4b208mr2489104c88.6.1780560670425; Thu, 04 Jun 2026
 01:11:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603111044.39116-1-r.siddharth.shrimali@gmail.com> <20260603111044.39116-2-r.siddharth.shrimali@gmail.com>
In-Reply-To: <20260603111044.39116-2-r.siddharth.shrimali@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Thu, 4 Jun 2026 10:10:58 +0200
X-Gm-Features: AVHnY4K9xMNzqZgeqEqiWw_d5_BInIBQoqSKeopTlT1b_FD3N_TdEXBXwVlD3MM
Message-ID: <CAP8UFD39G1CQXyxPVEmQSrdnHZ9BxPCH=QLmYBEFMcCnL8hjgg@mail.gmail.com>
Subject: Re: [PATCH 1/2] parse-options: introduce die_for_required_opt()
To: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, toon@iotcl.com, jn.avila@free.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 3, 2026 at 1:11=E2=80=AFPM Siddharth Shrimali
<r.siddharth.shrimali@gmail.com> wrote:
>
> Introduce a new helper function die_for_required_opt() to check if a
> given option is present without its required prerequisite option.
>
> This provides a centralized API for handling simple option dependencies
> (i.e., X requires Y), matching the style of the existing mutual-exclusion
> helpers like die_for_incompatible_opt{2,3,4}().
>
> Suggested-by: Christian Couder <christian.couder@gmail.com>

In general it's simpler for GSoC contributors to mention all your
mentors in "Mentored-by: ..." trailers in all your patches during your
GSoC, rather than keeping track of who helped you with each patch.

> Signed-off-by: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
> ---
>  parse-options.c | 7 +++++++
>  parse-options.h | 3 +++
>  2 files changed, 10 insertions(+)

I think it would be nice if the new function could actually be used in
a single *.c file. It would be even nicer if there was an existing
test that already checked that the dependent option needs the required
option. This way we would also already ensure that the new helper is
working properly.
