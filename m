Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07473587C9
	for <git@vger.kernel.org>; Thu, 29 Jan 2026 20:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769719298; cv=none; b=Xp/WpjYiFN/ZMEgObWAnZffqBPu7w/UGoEzIw92xWwX6zxxc860F0fdyKxZN0IfSrBaXnmL5ANTMCC1Lhb+q6JmzoV44nI6ux+RBw0C6uXQBJgBPzeGkI1Fvd9YF3rUyZkU8kuPoEHkn5gvVuRpdkipLz0YPOxxz+J228pJOi5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769719298; c=relaxed/simple;
	bh=pHkvGv4PaRWZ9FbL6ArK9hplyr/lku2a/c9qG9BRZk8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=iLUgE2Tmwht3dIZ0VcHPIlhOL+RiXv0HlNtr6BSDSFvq/mryrDS6/E/OlYOxBYZxOibtSui9JjDorZXJD/d8HVZBzWbnRU7Ww4clrXZtZAGfCbK4G+ErgFR6toUviccKbKDlkwc1zVOAKjS6D7IrwUT4N7Hy4agrunqucBCaDo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IGQfW3L3; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IGQfW3L3"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2b70abe3417so3326224eec.0
        for <git@vger.kernel.org>; Thu, 29 Jan 2026 12:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769719297; x=1770324097; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QHOn2h7gYSGCHJ9NBLyTXK07PplZsACC8fVUz1Ec4ys=;
        b=IGQfW3L3gG//XVQqqtGmN3k2XK5o0qqMryx2rg4XXMGVVqvRs4tY93+RfeZQlQfGkM
         fIF7m6rCSB1PQpXC8B1RBJtnFa/snO9oQHUtQWHsm1Ln/jxE+pWQnuAImNYuqscnrHD4
         VyQ7xWTjlDBrK7Q9RSn7t489MbWGzfJfKaMZDfkq95AySEWcWuusvMJ3CCEFZIy+2u/0
         ZJ0Uc9LCi7I3qhbUpAGnMh8t7aR9JHn6bE6GjUC/BNXpa0s3lKK7dXp6bOBPRAoUfNFc
         3+y72BmD06uo5H+GsX/NK6JaTcwUNzJd6AGQRbIlAlUErY9TrcbfKtb8kqZY/6mHMg4n
         JbDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769719297; x=1770324097;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QHOn2h7gYSGCHJ9NBLyTXK07PplZsACC8fVUz1Ec4ys=;
        b=fP3AT+mLRNzn5rz3M2ROyQuMZchhH/QB5xURQU8g+z9hEL/H8kcnjqA1kgA59QHF8L
         bNj8VDcQPOo/pTHqMu8W1PRTx02CiSCHr2yAPtvFW6QgXzW4AfuGBl93m9Ar7SNXEAWF
         1TyHS7Z3F15GI1fwR0+NaRaV0E4FtofX61SReyR3C7lHyv72LC7TFbZx1ETYycoWTFlk
         VhI/7HYc1bEz1KxLlhvTFMf2XMhV2//5lkhUrBwc9XhYvFjRXcv5ulQewwWCP0nFmLm9
         e7RKSG8tZK3wjA1FDHU7Xckhp32GVj8SJRgxfB/0HHiNZs4MAJmrbtPuW4BYtXzASDGV
         rAiA==
X-Forwarded-Encrypted: i=1; AJvYcCWKTfWkeJQ9XFIYwEzCi4FMYn+nrJnZHGtdFq6unYoRUhhGBo9bmsZR5NaNH7d8ZPP/ilc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb5kV+xUKPv1ieKhXpIC0f9D9r6/FhZoMkCq9hD5KZl+TCkE0Y
	z2yxJwioOCNFhSZKAvZs286BXX9ixMutfHz9p1lBfOa9/QMWWTGppK27
X-Gm-Gg: AZuq6aKo8kVF0o815zoS9gHIe3/SgP7PRiWCCehCFKEPN0m1y5Qr9mXsWfnsuZRpAfP
	PhmJ3AUD0QW8v2FKBeQsmC9bviXl1nY7HWZ8VSJ4DF97qHB1THcdgmkRYHNb2bj8Kbq9hw8n7Bw
	ITe2v702v8IJV5/3YWJzlwxeEuHoMjmJCf/sK0EQkl23x7GpwIWZwaTTMmZ5nPNrKGWAXQBR1Y+
	8byNmD3v/cc+r2ebU8XXTZo3BnFKJhyobZJacEriWyPKcq9h/ELpHF7gh6W1Az6VYnb9YDL6cmh
	9rQpQlG8gTlcOvE8CfE4loZv73oeStHk3fu4mDyt/StqKH1oacKzym8eGhowc+dC2zE0R43iwG7
	balQnbgIv8PX1vDEUpsXQdjR/l2iXOJrCBxfxJdEDMTU3WNpXypso4ryYI/lKWVTJKNw/3wMcn9
	f6hrssLD8fDSoXrW7mc/xidyB0e4yPFWtMK+4OoEEE
X-Received: by 2002:a05:693c:2b13:b0:2b7:9934:c40b with SMTP id 5a478bee46e88-2b7c8902bbamr426046eec.31.1769719296719;
        Thu, 29 Jan 2026 12:41:36 -0800 (PST)
Received: from smtpclient.apple ([191.181.59.93])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a1adef97sm8257170eec.29.2026.01.29.12.41.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Jan 2026 12:41:36 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: Git project and GSoC 2026
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <CAP8UFD29LtG2dRRB4f6mZAHNGqDmDxUV4ULYw3w3OYg15ZBBYg@mail.gmail.com>
Date: Thu, 29 Jan 2026 17:41:19 -0300
Cc: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
 git <git@vger.kernel.org>,
 karthik nayak <karthik.188@gmail.com>,
 Patrick Steinhardt <ps@pks.im>,
 Taylor Blau <me@ttaylorr.com>,
 Junio C Hamano <gitster@pobox.com>,
 Siddharth Asthana <siddharthasthana31@gmail.com>,
 Justin Tobler <jltobler@gmail.com>,
 Ayush Chandekar <ayu.chandekar@gmail.com>,
 Meet Soni <meetsoni3017@gmail.com>,
 Bello Olamide <belkid98@gmail.com>,
 Usman Akinyemi <usmanakinyemi202@gmail.com>,
 Chandra Pratap <chandrapratap3519@gmail.com>,
 Eric Ju <eric.peijian@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <21D9FA76-F382-483E-817F-C3947C939D16@gmail.com>
References: <CAP8UFD11txMWSfMTvDtcBJuuZA5mKffo6XUyR9LWk2d_N0RRtA@mail.gmail.com>
 <35E56A79-FD65-4CBF-9A35-BCFB9A169BFA@gmail.com>
 <CAP8UFD0kEATc6sU4r2pVq9k2X737Tk+_VXrxXx8K=M6=ciL=vQ@mail.gmail.com>
 <BAD29E01-C358-456F-8E31-058AC0AED0C8@gmail.com>
 <CAP8UFD29LtG2dRRB4f6mZAHNGqDmDxUV4ULYw3w3OYg15ZBBYg@mail.gmail.com>
To: Christian Couder <christian.couder@gmail.com>
X-Mailer: Apple Mail (2.3864.300.41.1.7)


> 6) Improve `git repo info` so it can show more information than now.

=46rom my side, I have these features in my local backlog:

- remove the dependency on `the_repository`
- use the category as key
- add the path-related values (copied from git-rev-parse "Options for
  Files"):
  - git-dir
  - common-dir
  - toplevel
  - superproject-working-tree
- add more values currently obtained through
`git rev-parse --git-path`:
  - grafts file
  - index file
  - objects directory
  - hooks directory
  - git-prefix
  - other paths that are adjusted by update_common_dir()

I already started to add those path-related values [1], but I think
that the major problem is deciding whether we should use relative or
absolute paths.

I also think that we have room for other information that we retrieve
through commands other than git-rev-parse.

> 7) Improve `git repo structure` so it can show more stats than now.

I don't know Justin's future plans for this command, but the idea
was to bring some functionality from git-sizer [2] to Git.

> I would be willing to mentor any of them, but I don't have much
> knowledge on `git repo`, so I think it makes more sense for me to
> avoid 6) and 7).

If you want, I can share with you some information about
git-repo-info.

I really appreciate initiatives like git-repo-structure and
git-history that bring features from other tools that make Git
easier to use. This week, I was talked independently with two
friends about how git-blame can be misleading sometimes since it
only shows the last change in a line. One of them really likes
`git log -S` for "blaming" strings and thinks that it's a too
powerful feature that is hidden inside git-log. The other one
showed me Cregit [3], a tool for blaming based on tokens
instead of lines. A "string blame" or a "token blame" could be
a nice GSoC project (but maybe for future editions).


[1] https://github.com/lucasoshiro/git/compare/master...repo-info-path/
[2] https://github.com/github/git-sizer
[3] https://github.com/cregit/cregit=
