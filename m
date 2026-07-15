Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DFA3BBFC4
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 21:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784149762; cv=pass; b=GFEU/CtPQGyuDt4NqM7m4YOJMLhcJkOLXFIpKI+yNk3QKE3suSvSH+Xx/4CYYQhWT8t8ve0FkofLFVipUusPrEmuWC97QxlKGrLNwaz6T0mTVo8/8lTwaJbMI2S8iDjlZQYNKzTLjGc4nBZ8YGiP3SOeXL9br1nS+Hh2fkkZwyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784149762; c=relaxed/simple;
	bh=/SX98HnJvBr2gG8c8RCN2DMFx0lGrtQjCFG6DAfGZw8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DXaVnKKJSMgCFC9fP7iygOPsB8jIy5SSwQDHwFZGtXVG00N6WxKRn6IRFolTFKDV44bRG/F+eSwTVeMDH3mVlUVoa4tPeFrN3SexxeytGaxMLYk92WIH7PEres1mliSGEBTR7nCxEQg4G1sd4bShStIsEM9yJVuTy9C+P27Sy+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=kDFJNt6q; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="kDFJNt6q"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-667b0ced2d3so7457190d50.2
        for <git@vger.kernel.org>; Wed, 15 Jul 2026 14:09:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784149759; cv=none;
        d=google.com; s=arc-20260327;
        b=MyT0r5WPJCEP7KV6AWsgy8C0g8ALL8y4TeG9vlqxGUkpcY8srpNCo4uM/i1r2Mll6E
         7Gk3IK+8aENvsyziHH0VLd71tvXkrB3ufowDGdXNrAtckRCN8wH79E5M7JGrA70/+T38
         fai8GqL1wd6f8nmxqmlFn8du9HOnEs+UX9DsYsWptku/OmAzZKaEZFxB9c+CI/AeAfaa
         VGkBoxOhlVa77iQIUxF3DOGOif6VcVpQheoFbvIfZz4nRVOz3X72ieyVV4yZwBpxPswi
         rJJj9xgGaG/v/surittRTM0EtQ+HlpXFgkcpVdP61xIzSHaI3SVRzY1aQwFaVB8MJV9H
         /Xwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=T06FDKVv3t6Z1BorxqBSDk2TV7ZcqoFFw9j8yDII9DQ=;
        fh=GStq58TtfUP1C6zPiBC8/X0Jl4Kx06zFzXbwC/grifQ=;
        b=EKzEM1k5mVE6M/13mGsSHIk6YM3NHxQDfIr4VvgA0YZOwOV2fb8jKmfMJ8uN2gzMqV
         eX38a0Eeq2XHHCxqZxeu/U/CfPMJvbrF8brs6P2s0rLMsh4WSXm6URYS3wQ0LBj94zd+
         IsNpjFo+096nOB65C1YTH7cAQy0lkawPdD0baeZ5QKwxWb2vkD+Ycm7Fwv3sSf2SCS8u
         BxXS0WmfVdv7lY8nV1dcDb7JZ6G0K8mD9H+F+3qjIRGr8ZLTz8jZuoeoTHA9AfazGaCM
         YLUUJp/sCkZ89KeGaOC7kVWCJAemwyELNiNjDzeafpkZ790v2mHdSf+1eT+ZUfYl2SSZ
         ap/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1784149759; x=1784754559; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T06FDKVv3t6Z1BorxqBSDk2TV7ZcqoFFw9j8yDII9DQ=;
        b=kDFJNt6qPoSZtTdk2edHjQ0IdWl6mQVc8uzBssl37Y/OwDEyR+6W3b+DGU6fhOGwHY
         7jQih0x9mLI9s5h9hzb9T9mgB2dBzMsltGsM/zoiJV2Ul0tSg8xMc96o9jT2K8QDwp2L
         zd5qhYSuTE86jkANdRoyGD9M/NQtLxQmMtif0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784149759; x=1784754559;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=T06FDKVv3t6Z1BorxqBSDk2TV7ZcqoFFw9j8yDII9DQ=;
        b=qqez4wUPCgW3sH3+aohbhshGe2vsGkg5OvUblz9oY2yDTryTMZvpZ0jmucjVE8anjI
         Pji7s6vWuKJU9IZOJ4xmxxabf/jKHTieTkHegut1UehH+VW1O668yeBHzKlzuegv2Tq+
         qIgpwtKHhkLdN4UEiziNs6GpObFGxwSTIJzKE1osT7DJhgOYGy5GNMngQ7M71yjN4TGq
         +ZI1RUEBS+3QsRcAJaBpbH/GXnmGGv2Hp/UNfKDW2D8+4Sx4TLMuJDi99xWbS5pvJ/V5
         lhbNiiVna0nLpjl8HXb1791rbP+w/Yj2NlxwOJO1pA5ICXAycGd7ifVl6gIVprTepnyx
         W6bg==
X-Gm-Message-State: AOJu0YwSQzI2/a25ZoHUndRqxKEznWq/UrauR9zjdc0MujuYWc0J+ghx
	vaF3kJxC8eTYG+ucrwJ0tWL42RG+jx30uEGsFugMywGEb7fl/RppuJupIM5i3khW7E7p52XB1ht
	N81D4BpNEM3VxTzlX258n3S3C+M+LjQOKPuRgEhSQwRrmm9bIFmzQGQ5VEg==
X-Gm-Gg: AfdE7cm9q1Sx2DDnybXbk0ZajmSh5zEG6fsMvR8/AGyCGdbgGLoL/IitWSMwZeLjMgj
	XKYM7sfMorMfZKegL4NmMX1dxwt/tpI8EfeS6IjxB/kM290eWxQmp+JvOqEEi3KRlHShsH0OOpp
	5P5DtQgeL+6kJO/ePLpa+sLda3K84GvshLmVHmhmt45M5hW/Mn06Qdj4QXGGbuOTzFoW5RXtuOc
	j6v5D3InOnQf9VK3nlf10XryId3/7pS8iwVfmV37uNScKgin4H/ob2XlCDvqUbx1iFZXfIFmA==
X-Received: by 2002:a05:690e:4289:10b0:666:3936:98fa with SMTP id
 956f58d0204a3-668132c378amr2695915d50.4.1784149759492; Wed, 15 Jul 2026
 14:09:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <alfWF9cBPESuLBgS@earendel>
In-Reply-To: <alfWF9cBPESuLBgS@earendel>
From: Kristofer Karlsson <krka@spotify.com>
Date: Wed, 15 Jul 2026 23:09:06 +0200
X-Gm-Features: AUfX_mzfsKGMASpKNkDJZZG6bjEsWXQOjtZ7XKqzQaMv6NeFOvp8g9tC0m-80uo
Message-ID: <CAL71e4NjDTHbKR8z7pSrPpzDrX19JOTR04sArm7P=m5ivqkskA@mail.gmail.com>
Subject: Re: Git 2.55.0 breaks revision path filtering with --no-walk
To: Peter Colberg <pcolberg@redhat.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 15 Jul 2026 at 20:48, Peter Colberg <pcolberg@redhat.com> wrote:
>
> Is the behaviour in Git 2.55.0 intentional, i.e., was --no-walk never
> intended to support path filtering, or is this indeed a regression?

Ouch, this definitely seems like a regression and it can be
reproduced with a very simple scenario:

  git init repo && cd repo
  echo a >file-a && git add file-a && git commit -m "add file-a"
  echo b >file-b && git add file-b && git commit -m "add file-b"
  git rev-list --no-walk HEAD -- file-a

This should produce no output since HEAD only touches file-b,
but with 2.55.0 it incorrectly outputs the commit.

I think you correctly identified the problematic change too,
my refactoring indeed has a bug where process_parents() is skipped.

I think I can fix it, and also add test cases for this,
but I am not sure what the immediate appropriate action is --
revert the entire patch or apply a bugfix?
I think I can also try to check if there are other affected
code paths that need additional test cases.

For what it's worth, I suspect the bugfix would look something
like this, but I have not fully verified it yet.

in revision.c:
     case REV_WALK_NO_WALK:
    +        try_to_simplify_commit(revs, commit);
    +        break;
     case REV_WALK_LIMITED:

Thanks for the report, I will try to contribute a fix if possible,
Kristofer
