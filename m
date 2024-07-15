Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA79482EF
	for <git@vger.kernel.org>; Mon, 15 Jul 2024 18:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721067794; cv=none; b=q42gtkJi7tWOdRrlcX7JVHlCnbuyoxxYXHpjZKeWR3Zgi6pBp3K9JEmdya2ZS/2ZaLbsTT3ycoV+LbUMdUOIb9gJIwdPtnY6jdPdWcva7E0FTviYn2Ijf/B7/FU+5l9agNCx3tnKc5OBhWrds5mV5s6SIYgaXXoaf8kHHzV1fos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721067794; c=relaxed/simple;
	bh=CoMlD+5MpvpOFg1GUZ1asCVFHSxn68sfaFCKQu3/6io=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oX0e3K7s+b8UpRB9CEpUira6UpAm0VsK3FFIHmkQsDLxrSBgP4zRiencUyd6SofexDbYYUx4suKaLKwnEc8eS9hLofLgS3J9iU60CwB0sjdRMUX2xFUleR5SW/c9ogWcod/804Ya6RrUkhO12b0XhWSetqTlBpylJXC0k21lnoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BIWsty39; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BIWsty39"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-703775e4d5dso2371955a34.0
        for <git@vger.kernel.org>; Mon, 15 Jul 2024 11:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721067792; x=1721672592; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aBmv4P3W7Lu0VCiG7EkcwoRr4WCiRtn1QFh0Qg0yCx8=;
        b=BIWsty39AGNlM5EAB5Mwwlzel/xOD8A13lpUxelx0t5R7owF0/i8Y7gLWM8hbgOQy9
         J8yeAoFZgvT1Rn0OSVJkh+W+RjNPhXYnIlpcfcjiyO87jNxVhkuFF6Q1yaSDuR0PzBJs
         Qg6M+yjBGH90p0DAk8F3cMMs0g5wU04y9Xnfl3fcSmUgo/67P6D7PS9Z5vzyI17nWKz2
         eEBwplIZLArNn9jwY51zKQNBrk1ehdZYdI3BUUpmciugNcJy/v2wwrzv0K7HwlACy3Yf
         RIhYZ/KTwfXpjid+L4bCGP8T9Y7FXrnm3YPwaKFF0iYnJ61KCwYYuCXL09/HuWJXz0e7
         pj+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721067792; x=1721672592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aBmv4P3W7Lu0VCiG7EkcwoRr4WCiRtn1QFh0Qg0yCx8=;
        b=M0zuGqrFqmXaSmT0O+CHN/JqbvbM12oBH2mInoanZ7jZgAqVuu3OnPKaRI6KB3whA8
         WrWb1qYURLnxJno9aOzAOH5zi1ivKxUgNlbVJVmmRUL3pl5tD8E3u+ESqENo1mQUBqPK
         hdXt5X8zXZrcJyUnmL2UPoEgAokI0XVJuvw3m15tJSeubfWDzfcL3PmBtVruJe8Ct6tY
         Wgch9BwtyiHdghZsa/TRnERrx9cn9d+maUPO1QcvUcveF045ovodDJx3UiwbSp25BGEr
         3IFk0pIKlu0hZgrRMtvo8x0qGTF2wlyKNrTR1HbQnYKsEtCoSkANsmRvZ2CzxLGdU7j3
         vYOQ==
X-Gm-Message-State: AOJu0YyarlsJFW4EjPIrYr8ABW7/lJVxxDL+3dGbsFspH130jzyD+Obt
	WNX3ZKohYM+1kNwkS4lvuo4FQefB7e9pJ5cF6gCnyF0jV05X/gdjPU980w==
X-Google-Smtp-Source: AGHT+IE+64p6v8y6EUoxU0XP55GGBQ7YAHizCcJ40Ro5vJSmrlijoVhff9HWz5VGEU9gNl3WDiK5TQ==
X-Received: by 2002:a05:6830:f8d:b0:704:46da:5fa0 with SMTP id 46e09a7af769-708d833da11mr445343a34.10.1721067792143;
        Mon, 15 Jul 2024 11:23:12 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-708c0d2fcc2sm1044574a34.77.2024.07.15.11.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 11:23:11 -0700 (PDT)
Date: Mon, 15 Jul 2024 13:22:36 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] doc: clarify post-receive hook behavior
Message-ID: <dzdoaldgm5sk25ll57okroqcnhqurtoqmo7d5xsjnrjpgveqzx@63w4uav6jtd6>
References: <20240712224748.56843-1-jltobler@gmail.com>
 <20240714194626.29512-2-jltobler@gmail.com>
 <xmqqfrsa7j4p.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqfrsa7j4p.fsf@gitster.g>

On 24/07/15 08:46AM, Junio C Hamano wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
> > +See the link:git-receive-pack.html#_post_receive_hook[post-receive hook]
> > +section in linkgit:git-receive-pack[1] for additional details.
> 
> Use of link:*.html to point to the HTML version of the manual page
> is questionable.  Do we have any example that uses such a link
> already?  What would this line do to those who read the manual page,
> not HTML, iow, "git receive-pack --help -m"?

The manual page for git(1) makes use of link:*.html to point to HTML
documentation.

  - Documentation/git.txt
  - https://git-scm.com/docs/git

In the manual page it appears to specify a path to HTML file in the
NOTES section. I'm not sure this is a good thing though because the file
cannot be expected to exist at the path.

> The latter link using linkgit: is bog standard and perfectly fine.

I think it makes the most sense to drop the link:*html used here and
just rely on the linkgit: reference. I'll adjust this in v3. Thanks for
the feedback.

-Justin
