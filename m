Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42842DCF74
	for <git@vger.kernel.org>; Fri, 17 Apr 2026 17:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776445731; cv=pass; b=qDt/MGPY+GhqBMMZJCA9UZvy42YdUG8ujf2lilkJyPQJ1n7BOmZn8ceaZBHY5kFJ8ALDI09qeI2KskQap1Dt/XDQSsb6QvTn10Bj1qM62yCCTGSd3txqtd4iQvAP6rVT6JwI+5rdYxpeuPwcTfANjZRhsbAbk1KjcgksSdF1lFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776445731; c=relaxed/simple;
	bh=IaxVCUyKBkzKyNxSLeuOqivjnY6QRdaeqPoqmTV+r30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eNg45+HpY87YYhyuRCdiYWf9P3yEd9JuDK+a0t14P+lEUWDZinV//P5FUCkH8g9lZdiByCzxdtR8EpHxYwdbD3OCEMNniH0IcSOQSlzipOCKtwX18A6eZdi1v/p7s9LXqH+ORhxaHF8ml6eElQLLWhl91syaovIwllZi1baAD7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mroZjBZv; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mroZjBZv"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2b2589c26e3so8465475ad.1
        for <git@vger.kernel.org>; Fri, 17 Apr 2026 10:08:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776445728; cv=none;
        d=google.com; s=arc-20240605;
        b=lylgrXSil237yQipeV24H/zzR6mtl+zoob9oXd7pc6xyKo7tXDiBtkj+uXUHlI/GB+
         Eftdt5zrJhiIo6GoIOIOLBCJHW5zgFL6hqiHDlsLcSgSAq36DTc+Pp2EXtKgzseaeRMS
         MdXWdwepln6RnQvvPrZFySSy4hVBCz37TudCgzYep3yeCSWr6RAHy359ofrF0Cx0Ynjc
         udNeVi/1fjS1TSu14hQo6tU9NS2GYGLKN0ALqUc1lfLSoHuIr4hsZhdPSOfbvVKhN6Yc
         DhFwJKW+LJDz++4AK0Ww8l85YJWdqVCWlFb2qqxRZGNEh0IdK0gmn/sBQUWf/aSqArYj
         l+pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=x5S8myOrjS3IXXlHW+EcxO/KzVyfa8ZdRLnPEBmrcqw=;
        fh=4hRD6dug9K2dA8/Qy44rHfFMnlFofhUgf7dxeZXl9E8=;
        b=LOTWOXKhg3cOTfTuYFsBH+j2ZszIa/pQqTZKEIJyUq77fMD40zYMuifVekW8mVZHwF
         3NmvjXXqaoTVme03ia3NQchLmw46d5Ulz5IHysx4xNDeoBoYv9vPiiXToEy/J4FvT0fK
         Ejlobo+W3hR0kMezkpOoQDoVTEEgLWgu4Bgl052l/IALHzL9jTz4n21frfC2witqFmge
         6KuTF5rd9M6hzzLr11n5usmxvdhkQPIDNTKvDIWXheQTo2dPWwr6omPSjAXhzvCHREGs
         JPgIFR5vhmqhwd7gid07VgtarijcTlYRUXzsCncA044ugrC4X7FH6u9dD7lOxY1LA2gq
         R+qw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776445728; x=1777050528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x5S8myOrjS3IXXlHW+EcxO/KzVyfa8ZdRLnPEBmrcqw=;
        b=mroZjBZvHBZciyNMN5Z48vYR4+r7rI5ufk63kAew4Rd3IOlry3pmumTOd/p8hQlQ+Q
         EuDZ9EBIqO4jcAlQrZvg+FZJEkOgXj85lM2RnwDOFm/MlnhKV3vnMYPqgII5o7IGdwRH
         0Fhae+iDxsiwDYcYsmJ+JV+wM2piryyzQtV4oqOmZ9Qfgo6HJufZskeIERRuhRV+vssB
         W2bZg4+SY5oZ8orPkRVTGbB+Jxrb7TGzV+36XXeYTWBY1CiMp1qSXc7QU9EvMg3SpiGH
         1CMkYJBfiupZdiH5LddgS1d35YwZauMZh8wv/4S3hAoxpU1ZlYGSxm3vZIATKpZjVxV2
         VCAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776445728; x=1777050528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x5S8myOrjS3IXXlHW+EcxO/KzVyfa8ZdRLnPEBmrcqw=;
        b=Qd8TCKXILGKtwEhSL+Z+jzUbe0QJJp+OapjUate3uGLfbcRG6eWsqAdDMgjOiolabx
         x5PYRHySlZFeu5uMdHJWfiHzmyW1Q1kq36aPtyuXAQ8Sdrx0j9ymEy9GwUfPh83J1HXW
         F8Sh1BPFSRH/2UmDiPKLsut4jFUGP7aEYz8hqCVRHmsVVFml99BCrSGzZhnfTFY2f/Q/
         EF761rqJFgPcY+S+AK77/ltjQnptWWjpJicLInffjhzeMxQZvq9yXkgRSVzKZWSEesl7
         aXcExljwsFX7t+U6tRszZu7oExnR0HcaqCE9QqT2XScDN8BLF0nTfOjzJBGF/d6FaUzB
         6EYw==
X-Gm-Message-State: AOJu0YwQjA6XdNGeMeyKQv6fTd/uXKeMc2jsX9wvigFgTUwaG4Dythf8
	aQfPp2y6cAxJitAriPI4S6ltqptSkjbGqp8E9nkRPGKyFtVXK5rsQpZ9p3XtovFdTY0LjqDhZJJ
	20iQmGHbhVaGi56fPDbQDrj6/yKKIu/I=
X-Gm-Gg: AeBDies3T5AZ2lp9K0aVFixP0HBA7r19rL6M0YSsRy0pm312cvtBQPyu/Dh3YzZwG+f
	xYPNuCoeB4lFGDV/F2PgWzvO87mapN6hEEA6KbBwJoFDvswC6eJYyg+OK5VL/BDvJVYEQRwnn5c
	egkstLDKQ02RgRDx31rQH9TRj11bsTYIWBMf21zSt7iN64A+dwl/xNYLm/tsblSgnFDkwcsQvkN
	lwiou1XItn8P4ORrxnVsRMmUNcrFSId+TLrOMfT0KN1Ij2Rb/WnYD7Aje+EAw5hrAHcbTpSy4Cu
	I5EeTsMjpl9YWPU5q7w5UoftGlclsmm3k0tNTjskQVbruTLlQ1aeeOmMAjRvhFBTwffUSWhU0BY
	4fu7kzBYGr2C/mzOE9x+s5kuNz8rrnByXpQRP
X-Received: by 2002:a17:902:b702:b0:2b0:ac1e:9720 with SMTP id
 d9443c01a7336-2b5f9f7d029mr27406865ad.23.1776445727812; Fri, 17 Apr 2026
 10:08:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260416-pks-libgit-in-subdir-v1-0-03afc731df55@pks.im> <20260416-pks-libgit-in-subdir-v1-2-03afc731df55@pks.im>
In-Reply-To: <20260416-pks-libgit-in-subdir-v1-2-03afc731df55@pks.im>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 17 Apr 2026 10:08:33 -0700
X-Gm-Features: AQROBzA20ofxg1V6TH_uKbyEoFLWPNIRl0pOVVYDYB_hWb0-nG2s4kmAGNw02Yg
Message-ID: <CABPp-BHr9R1_7P46v=azQE7FnecW7-WkLjVs48OLXBNZp-M-qQ@mail.gmail.com>
Subject: Re: [PATCH RFC 2/2] Move libgit.a sources into separate "lib/" directory
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 16, 2026 at 6:33=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> The Git project is not exactly the easiest project to get started in:
> it's written in C and POSIX shell, with bits of Perl, Rust and other
> languages sprinkled into it. On top of that, the project has grown
> somewhat organically over time, making the codebase hard to navigate.
>
> These are problems that we're aware of, and there have been and still
> are efforts to clean up some of the technical debt that is natural to
> exist an a project that is more than 20 years old. Furthermore, we
> provide resources to newcomers that help them out like our coding
> guidelines, code of conduct or "MyFirstContribution.adoc".
>
> But there is a rather practical problem: finding your way around in our
> project's tree is not easy. Doing a directory listing in the top-level
> directory will present you with more than 550 files, which makes it
> extremely hard for a newcomer to figure out what files they are even
> supposed to look at. This makes the onboarding experience somewhat
> harder than it really needs to be. This isn't only a problem for
> newcomers though, as I myself struggle to find the files I am looking
> for because of the sheer number of files.
>
> Besides the problem of discoverability it also creates a problem of
> structure. It is not obvious at all which files are part of "libgit.a"
> and which files are only linked into our final executables. So while we
> have this split in our build systems, that split is not evident at all
> in our tree.
>
> Introduce a new "lib/" directory and move all of our sources for
> "libgit.a" into it to fix these issues. It makes the split we have
> evident and reduces the number of files in our top-level tree from 550
> files to ~80 files.
>
> This is still a lot of files, but it's significantly easier to navigate
> already. Furthermore, we can further iterate after this step and think
> about introducing a better structure for remaining files, as well.

I think this change makes sense.  The only thing that made me raise an
eyebrow was the moving of the sha1collisiondetection submodule into
lib/ , but only because I think renames and submodules is bumpy in
general.  Since we rarely update that submodule, that won't really
affect us.
