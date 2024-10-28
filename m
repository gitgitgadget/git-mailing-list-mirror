Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEFC13AD11
	for <git@vger.kernel.org>; Mon, 28 Oct 2024 17:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730135305; cv=none; b=ZshrIRSkoJyeG2AAsL/dZ1+kCkYm0n3oVTOnE0+/FfEAdVZpy3MhnuJq4sPPb2m79DKZva+KW7XiaHKHF4G/Owt3wLTT3Sll18HqnLedzmhdBNtuUVct6Yf59O75W+hmWd4t/lQ+bx+DVi2rPrQkF7xc8tPWUwit2LE0tZsDgUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730135305; c=relaxed/simple;
	bh=PS+s5PRym9fAEnCGzZKthaPy750JvRY2YaSnPP/+8Sg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uLMg3nQLqk0YQPb+COE55l2zP5yDHyr8HGq/1XXSMcgS9UCdCpFJsG5dkLOQdxFODzzIJyTi/97iFcox2QLEYbeWJgPTHhFVveoCdenp3SxpVVXrNHax/pSazs5dOaunbVnJKAqxfA6bldYTNs7ubOPIZyqeQdtijpbEag7IEJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=BzGD0SZ7; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="BzGD0SZ7"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5ebc0dbc65dso2697153eaf.1
        for <git@vger.kernel.org>; Mon, 28 Oct 2024 10:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1730135302; x=1730740102; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YeDYszwbhJlyN4x3ZJuyJYZlgzKxKfR12pJvBivOeXw=;
        b=BzGD0SZ7UszZ/a5PvsCioZWGHrlE7A+LNyMNEEP+cFPEUBUklgE6Kujs+2+KOsgREj
         hNIPDQXFBc2hSyj9mTyz0UbQtMK4Ln5A8NwTwoBgP20cd+IXeokfHIXsMqOm9Mw5J0QM
         ZfEhhTkXlk4IJeS4/WDUD7mx6E85gpvwafESLIauuBG9SNmMZ8r8vnYH461LuWMt5rHk
         kpE1paYtWMBd0mjGlqHeczRXcM/OMrC84XQKfyM3KbOkBNpqF0riFkimml+K1arujVj4
         NM0tj7rhRH9W9EuQ7HT7+OgpXboFRuZecVuls2WdkILx+Hozj43ptK5oT/0hQ3qhv9YA
         t02Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730135302; x=1730740102;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YeDYszwbhJlyN4x3ZJuyJYZlgzKxKfR12pJvBivOeXw=;
        b=wbuEwzXa3uJ7Az/W+UQbKfZBR8gi9EVamvTT1wlsNavsfXxUIJ+l8XPz308suQ2Lhx
         TXQxBBQ3HJWH6p/HM+qK7lq+Nbhc1UaUBRdIymJ+CQPecwuvGIDZEfMwji1U7qDU25hV
         oIOOQZWeX406JJGapQBLXM/CHZvzDa7u+34VqWY52FuEQHcngUfbyCCJm+O9WJMJJojU
         nubpk+NZYvOhnmgEK6uIkfsXpmH0RysVOA6GD7nYp4jFEcsHnxdN+XgpqmAwJzYpAfUu
         tOhxIs1bAjb6GoEKXqx2lUrPRfBW7uzRuyzsKQRwY4E4QB1/kF7S6PoeaycBIUwy6iD/
         X70A==
X-Gm-Message-State: AOJu0YyrRBSp3VHRnVD4Jw5/IJdOspXpvzM3RN29C1Yyyjx/BFRnEHsV
	74xNGcfN5pQJYuUTZqweHViQRqBC4NxqXtKbv5ldtnM7y9rZwxrnOumZ6adJDBKTHuQhUcViaHS
	jRE0=
X-Google-Smtp-Source: AGHT+IF8uxf3rxPYKH767zsWkixgWpcj3z42oZzuOn1YSDJFS8cPc15RsMkXZusDf0pc6eoz+j2kGQ==
X-Received: by 2002:a05:6359:4c8b:b0:1c3:7070:4442 with SMTP id e5c5f4694b2df-1c3f9e87977mr233020655d.12.1730135301947;
        Mon, 28 Oct 2024 10:08:21 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e9c6bdbffesm15124637b3.38.2024.10.28.10.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 10:08:20 -0700 (PDT)
Date: Mon, 28 Oct 2024 13:08:18 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Caleb White <cdwhite3@pm.me>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	shejialuo <shejialuo@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH 2/2] worktree: add `relativeWorktrees` extension
Message-ID: <Zx/FAoj2jcISsv0X@nand.local>
References: <20241025-wt_relative_options-v1-0-c3005df76bf9@pm.me>
 <20241025-wt_relative_options-v1-2-c3005df76bf9@pm.me>
 <Zx7YxLPItxvFJK62@nand.local>
 <D571HWYAD4MM.28JAS7D0Y6OI3@pm.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <D571HWYAD4MM.28JAS7D0Y6OI3@pm.me>

On Mon, Oct 28, 2024 at 01:14:51AM +0000, Caleb White wrote:
> On Sun Oct 27, 2024 at 7:20 PM CDT, Taylor Blau wrote:
> > On Fri, Oct 25, 2024 at 10:29:47PM +0000, Caleb White wrote:
> >> A new extension, `relativeWorktrees`, is added to indicate that at least
> >> one worktree in the repository has been linked with relative paths. This
> >> extension is automatically set when a worktree is created or repaired
> >> using the `--relative-paths` option, or when the
> >> `worktree.useRelativePaths` config is set to `true`.
> >
> > This approach feels like a very heavy hammer. I wonder if writing
> > worktrees with relative paths by default was too aggressive of a step,
> > and if we should instead make the new behavior opt-in rather than
> > opt-out.
>
> The v4 series of the original round added the cli options and updated
> the relative worktrees to be opt-in. This patch keeps the git default
> behavior of writing worktrees with absolute paths, and users can opt-in
> via the `--relative-paths` cli option or the `worktree.useRelativePaths`
> config.

OK, I think the mistake here is mine. I did not see

  https://lore.kernel.org/git/xmqqfrp4onjd.fsf@gitster.g/

when triaging the list after Junio went offline for vacation. Had I not
lost that email, I would not have merged the earlier round without more
discussion.

That being said, it is still greatly appreciated when contributors can
follow the WC reports when they have patches that are moving through the
various integration branches. That way you can see my "Will merge to
'next'" comment and say "please hold, I am working on a new round that
is substantially different / uncovers some backwards incompatibility /
etc." and we can wait appropriately.

Now we are in the rather unfortunate situation of having merged
something to 'master' that (with the additional information that I
missed earlier) it is not clear that I would have merged in its existing
form at the time.

But that's OK, and we can figure out a path forward here. I am just
trying to say that this highlights the importance of following the WC
reports regularly to catch cases where the maintainer missed some
important piece of information.

> > Saying that new worktrees are written with relative paths, and that
> > creating a worktree with a new version of Git breaks reading the
> > repository on older versions feels very unsatisfying to me.
> >
> >> The `relativeWorktrees` extension ensures older Git versions do not
> >> attempt to automatically prune worktrees with relative paths, as they
> >> would not not recognize the paths as being valid.
> >
> > This is the piece of information that I was missing in the earlier round
> > when I merged that down. I think we need to take a step back and think
> > about how to make this change safely in a way that doesn't break
> > compatibility with older versions of Git.
>
> Adding the extension was the direction suggested by Junio in the
> previous round. Git did not account for the possibility of the linking
> files containing relative paths, so there's really no way to make this
> change without breaking compatibility with older versions of Git. Git
> had to be taught how to handle files that could contain either absolute
> or relative paths.

Yep, that makes sense. My preference here would be to make the new
behavior opt *in*, rather than opt-out, so that:

  - Users who do not experience problems with writing worktrees that
    have absolute paths can continue to do so without any changes.

  - Users who use worktrees *and* do not write relative paths can
    upgrade between successive versions without requiring a new
    repository extension that would break older Git versions.

  - That we only add that extension to the repository's configuration if
    and when the user has opted into the new behavior.

Reading this new series, I *think* that is the behavior that you settled
on, which seems quite reasonable to me. Can you confirm that I'm reading
this all correctly? Assuming so, I think that we are in a reasonable
position[^1] to review this series instead of having to back out the new
behavior.

Thanks for bearing with me here, I am quite embarrassed to have missed
Junio's mail that I mentioned earlier, but I appreciate your patience
while we sort this out together.

Thanks,
Taylor

[^1]: Making sure that it gets in before 2.48, and is not dropped,
  though we still have quite a lot of time on that front.
