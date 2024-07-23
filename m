Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CE2132124
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 03:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721704014; cv=none; b=CNXBZMQzBpvtmec7k83B/FsHGJ6y4KcCkQYGjYQ3TcNgNFL1FR3gjz2Sbhdp/or/i33v6JQrKDQxLVspdsgTlYheRM4NJOqTr/jQK9Ro/rn4Kdm81VGuzzzRBjXiZCFbIU2gEAY2IZwu+WeAyeUKuaJU/KUE4e00a0yZmCqeve8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721704014; c=relaxed/simple;
	bh=F3VaqGbanMddyHVs06CqdlSaOOTjD5qWPQiGlqygWu4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=GRdlgq7vJrA6qpPgx/6fKOk2EX1oGjRV+ghcK53Y38jx7mxjKm2VF9tycLbiltuygb442ZonCqjUEBmw7kfUYT62W26GW8JgNqmYjBfp5c23L2VlxhOjQZz9nrooL76KxcWNhNUCl4dbUKhnzHSCO8DztBfB0loEkRmFG12RUe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F5+V4B8k; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F5+V4B8k"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2cb5789297eso2492199a91.3
        for <git@vger.kernel.org>; Mon, 22 Jul 2024 20:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721704012; x=1722308812; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uuHbJW/ctmmKAWACldCs7aYXbrPf94qXGeAEh6xWxSs=;
        b=F5+V4B8kfx20F2EpvHgwGs9AdFxB4yOPLCthRQS/jkQww4dP//jLT9fY/oP/ZfXcI2
         itwEtAE594437AL7jDoJJ9Ju87y9NIEfmaJ5IadgAaSgv0ZxDDu4IUiBOhJYrXsJ9K9M
         qFBbpPnBbpaHSgjuri95wug1NeMokhxWz3AkjMoxq8YnJPQL4XF9FJ50ngWkItgFkP7q
         sl/qwBdJO7SxKHQbFJTcyj8tA4VpOC7pD1rb0SXGQnDPdTPxPqByigMvi6j9FxSVkKx6
         O2Nh7aX8XzQvehCzdDkPLHKlgEhmzOrC1x0FFn6EAmxe0jG5iWckBjqtuQ3s5ydprUZ/
         sAfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721704012; x=1722308812;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uuHbJW/ctmmKAWACldCs7aYXbrPf94qXGeAEh6xWxSs=;
        b=sT77mPi4EmInfWmaEVQXfh/51frutLvqFRl+a+lyoEewtOjrL9NtGDzo6DzxfDXWCl
         4UXgCIHC0WLg2gAiMPTKkIWHN88uemg2Iz2rg9rt+nLMtk9wSzXmQKBN23E+RQMzoOn7
         Jveg6HshP/W+lpaXDEBGeRp+9sWa5fFXNLUfecZIb6BEOkr/IHCY1Il2O+T7u/AuB0L0
         hZfFj4sM8nqiF5caTJBfdItjKeDSv+0FDzjYTi+Wo6C/hS0ZbL9x2PSzYvRGIoooSjkN
         3rYCKFswfOzA240Xg8CBUF3RDsooKaCDMzAJ6I14XsVOfHaIHaOr4t7BpaySg+DZqu7X
         dMsA==
X-Forwarded-Encrypted: i=1; AJvYcCWXeROWBJSZoQUvQBvCCJ2oAE0bYXiGbJMzdJnqaYLDgy0HBZePIkZcPlOoSltHFPRgkM8LMciJ39LB2GxnTcexvqfe
X-Gm-Message-State: AOJu0YyjwQoshfezONXkP/6UCs0h6CKHyfuKOKHZzo9bxF9U9RQnRNCo
	zGirlR7474uOHCxVEjdcxPXyLOb6JvARRRLXhyjyQWuu1yr5zHEeJGt2NrQ2lu4rJx7Cm3XCj7N
	UimrB7X2dn+l2io8gyKsoyU+DrntidgbqmDs=
X-Google-Smtp-Source: AGHT+IFSMn76kGedRSeePg/jlli60xeShweKpluvjZKNaw7ux6VxSgQ/fzUksPM2owI+8GUdXWx1pruClCktDlkt8Kg=
X-Received: by 2002:a17:90a:d188:b0:2c9:6187:98ca with SMTP id
 98e67ed59e1d1-2cd27434c50mr4783616a91.22.1721704012246; Mon, 22 Jul 2024
 20:06:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADeMgjBeyWkE3mp+-x57NSsyNLQf3cTta+Xm5uyVOQE-rpT6yg@mail.gmail.com>
 <Zp7Pg7ZOlBZcfJei@tapette.crustytoothpaste.net> <031701dadc8c$db6d3370$92479a50$@nexbridge.com>
 <Zp7z1eY6GcGzrZaJ@tapette.crustytoothpaste.net>
In-Reply-To: <Zp7z1eY6GcGzrZaJ@tapette.crustytoothpaste.net>
From: Thaina Yu <thainayu@gmail.com>
Date: Tue, 23 Jul 2024 10:06:12 +0700
Message-ID: <CADeMgjAqgF9K6fOQS07MB71c0OWGsF3TL-QVNX_tt1TpSMv=xg@mail.gmail.com>
Subject: Re: [feature request] Is it possible to have git tag can be sorted
 and filtered by semver?
To: "brian m. carlson" <sandals@crustytoothpaste.net>, rsbecker@nexbridge.com, 
	Thaina Yu <thainayu@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The sorting output are not very differ from `--sort=v:refname` the key
difference is ability to also filter with the semver range

As suggested, the glob pattern start to have a problem filtering out
the range of tags numerically and so we need to pipe the output to
another system such as grep. Which is not supported in windows and
become harder to do a tooling system that need to piped to separate
platform specific tools. We also need to convert semver into regex
such that it handle ranges we want properly. So I would like to
request it to be option of the git itself

As for the syntax. I propose the patterns `refs/tags/v{
__semverranges__ }` so that `v` may be prefix or not is up to user,
outside of brace `{}` is just normal glob and only inside will be
matched as semver. The suffix such as `-alpha0` or `-pre1` or `-rc3`
should also be sorted with semver rules and filter out all other
unmatched character (except git tag system suffix such as `^{}`)

On Tue, 23 Jul 2024 at 07:05, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2024-07-22 at 23:14:03, rsbecker@nexbridge.com wrote:
> > On Monday, July 22, 2024 5:31 PM, brian m. carlson wrote:
> > >Assuming we add such a feature, how does sorting by SemVer differ from the
> > >current version sorting?  That is, where is the current version sorting deficient for
> > >SemVer?  Also, what do you want to happen when a tag doesn't meet SemVer
> > >requirements (note that the "v" prefix is not allowed in SemVer, although it's
> > >customary in tags)?
> >
> > Currently, tags would be sorted as follows (simple example):
> > 1.10.0
> > 1.2.0
> > 1.9.1
>
> I agree that this happens without any --sort option.
>
> > With semver, the tags would be:
> > 1.2.0
> > 1.9.1
> > 1.10.0
> >
> > My take is that this, if implemented, would need to be more general, and include prefix and suffix handling, so:
> > v1.2.0
> > v1.9.0
> > v1.10.0
> >
> > should sort as appropriate. We might need something like v({semver}), or a more general regex-like (prefix){0,1}(semver){1}(suffix){0,1}.
>
> However, this is the behaviour I see with --sort=version:refname (or
> v:refname).  For example, the command I provided below running in the
> Git repository sorts v2.9.5 before v2.10.0, which I believe is how this
> was supposed to work.  Of course, I could be totally off base, which is
> why I'm asking for clarification so I can understand better.
>
> I think it's also worth asking what happens for tags that don't match
> that still.  For example, let's assume for the moment that Git used
> SemVer.  I have added tags in my Git repo for when I send a series, like
> so:
>
>   7a9ba024ccdc440095537cf53ce69a5749798165 commit refs/tags/sent/credential-alwaysauth/v1
>   a74efc1699038e898960c2c55185f32aade6a88a commit refs/tags/sent/credential-alwaysauth/v2
>   ac45947b34d003f827d15a8623c0125fb12ec261 commit refs/tags/sent/credential-alwaysauth/v3
>
> Those clearly don't meet SemVer and will need to be sorted _somehow_
> (before or after SemVer tags?), and users will want to know how.
>
> > While at it, having a reverse sort would also be useful. For platforms that have semver-util, this can be trivially scripted. For exotics, no such luck, as semver-util is not especially portable, not for lack of trying.
>
> I think we have this by using the `-` prefix, such as
> `--sort=-version:refname`.  I agree this is very useful, though, since
> it's an O(n) operation to reverse the list, which, as you mention below,
> might be large.  If we add SemVer sorting, we'll definitely want it to
> work nicely with reverse sorting.
>
> > >As for the special range syntax, I think the typical suggestion is to filter the output of
> > >ls-remote or for-each-ref by piping it to a suitable program.  Perl or Ruby are
> > >common choices here, and both could easily parse SemVer tags.  For example:
> > >
> > >  git for-each-ref --sort=v:refname refs/tags/ |
> > >  ruby -ne 'if %r[\trefs/tags/v(\d+)\.(\d+)\.(\d+)$]; ver =
> > >Regexp.last_match[1..3].map(&:to_i); puts $_ if [[2, 6, 3], ver, [2, 15, 2]].sort[1] ==
> > >ver; end'
> > >
> > >Git is intentionally designed to support this kind of shell scripting.
> >
> > I think implementing both wrapped semver and reverse sort in git tag might be useful for large projects, like git and OpenSSL where the number of tags is large. It would make finding time-ordered releases somewhat easier.
>
> My worry is that a special range syntax isn't going to cover all the
> possible needs.  For example, I might know that [v2.5.1, v4.0.0) will
> work (despite the incompatible version at v3, my code isn't affected),
> but it's very difficult to express that via a range, since what I want
> is basically a tuple sort on [2, 5, 1] <= ver < [4, 0, 0].  That's easy
> in Ruby (well, it's not pretty[0], but I did it above), but you can't
> simply specify a range in any one field, because v2.6.0 and v3.0.5 would
> both match the pattern.
>
> This kind of thing is very common with lots of Ruby gems, which, while
> they have a backwards incompatible change, don't change all that much,
> so several major versions might be acceptable.  In that context, it's
> likely that some sort of external filtering might be more general and
> robust and meet people's needs better.
>
> However, I'm open to being convinced otherwise if some compelling syntax
> comes up.  I'm just asking questions here because I'm not super sure
> what the use cases are and I think more information about the proposal
> might help people decide better.
>
> [0] That's because Ruby supports comparisons on Array via <=> (and thus
> sorting), but it doesn't implement < and > themselves (although == is
> implemented).  Therefore, I had to sort the three versions, and if the
> given version was still in the middle afterwards, then it was in range.
>
> Another, less pretty (in my view) option is to call <=> directly and
> compare against -1 or 1.  If there are any Rubyists on the list with
> better ideas, I'm open to hear them.
> --
> brian m. carlson (they/them or he/him)
> Toronto, Ontario, CA
