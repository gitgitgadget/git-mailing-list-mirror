Received: from aib29agh126.zrh1.oracleemaildelivery.com (aib29agh126.zrh1.oracleemaildelivery.com [192.29.178.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCBC482EF
	for <git@vger.kernel.org>; Thu, 24 Oct 2024 18:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.126
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729795758; cv=none; b=igSyy3rihpASu5Ira1E4k+9HqkY7pBdPVhROxs5wGNYiFfU7G6gw2yslsSPhdxHmu+Y6TD86Mi0NVo8YelrlP0TqKqTijIXoyrm+zNmXmjvaqfH7S/6vcYiXcKIzm3nP1NGDkL3kTLE3zX1IU+qS6IVHwVPRq6/TP46QuSHB/i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729795758; c=relaxed/simple;
	bh=MyEQkMZZQCErVwnsSmFEDUXh1I4hrCdP3GI39yjUIQ0=;
	h=MIME-version:Content-type:Date:Message-id:Subject:Cc:To:From:
	 References:In-reply-to; b=f5qF4XQHT2dKK1xly6pKTMg5eheEfbvbaRQ1biVGJ2v/csvMrIQK3JWioycBfGhgucHd3wa2Ls+AYKHQOZ9XYYUaGYdf1DTXQlUvC8M9Dx0M9MlN5FzuN/6eNrGS2sALgSp39zCj+BzeGh9kVjU3niSyR7vg4skJGb+AMpdKccs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=i7rWXb17; arc=none smtp.client-ip=192.29.178.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="i7rWXb17"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=bA99qbJJfJPtKhvG4D0JaNg90hcQWL78TY5hk1AABHQ=;
 b=i7rWXb17DoUtBaZx2j5/tIPNznuGy+dUk5k/hBbu8HGeNMVJ1KulI3bOEZjm4A63C3MeDdP/iF7z
   mKX0+bAstdgE11FnZf1VN7Glfc49NceJS5/5S+RBR91XzGAM56SvfYi+MbpmSd9X85uiPr9duT3b
   9HfttVascGvk+Tw/+Gk5/REXN/mG8frwpb3cKwLg58Spvha7rLF8HONgBrRBlq6yBOnYhtqZcj/P
   lzFPja6Gn8+jw/i/h6Jm4TqIFO0tsUnL9URB9OBc/uu370HS/K6RZhuEYfgew562xSepbrRPBT5b
   LR1U0HXqp9VTH3tuz5Ne+ns7fLEkZlpMDi6ffA==
Received: by omta-ad1-fd3-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240911 64bit (built Sep 11
 2024))
 with ESMTPS id <0SLV006JYIXV2Y20@omta-ad1-fd3-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Thu, 24 Oct 2024 18:49:07 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Thu, 24 Oct 2024 20:48:29 +0200
Message-id: <D549EIKDKGDS.2AETZLT4RTB44@ferdinandy.com>
Subject: Re: [RFC PATCH] object-name: add @{upstreamhead} shorthand
Cc: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
 <git@vger.kernel.org>
To: "Jeff King" <peff@peff.net>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
References: <20241020202507.2596990-1-bence@ferdinandy.com>
 <1c056d39-950c-4965-89d6-85f0c2c1bccd@app.fastmail.com>
 <D50YLOBHJTLS.367TMAOLKL019@ferdinandy.com>
 <20241021191441.GD1219228@coredump.intra.peff.net>
 <D51R90BTHJMY.1C1XY5P4CHTWG@ferdinandy.com>
 <20241023215618.GA821188@coredump.intra.peff.net>
In-reply-to: <20241023215618.GA821188@coredump.intra.peff.net>
Reporting-Meta:
 AAHlBniUPu9TTy2hzEpug1Y5+Bq2bzJV2BGJUuPc9Gbwh/mYMqXhuISWnTumpsGD
 erQVjNSP6kBTTy8ndG73u1JYO3QbayZJLP/B4uN7ONQddHV4xsjdCv8jxzEIyKXN
 MsMfvLPUWDv9BC0lNRAvCj0Y+F79Cd9PgGTwyt0REEFGejGafAedz6gM0oZBxlp2
 AYvIlHbA0TFNPzbPHoOzMbZFlABV8vEH2N0Bwghf5hXlTLlT6YiAmEEYNfa//JXY
 jMN7TigY5ZsGaVNLuhlqv0UWFZb+KdzUgQ4aMdGZaHlo9gThCEhR31GDfBI7YGjp
 MzS/8Spaogv8Uxeo+D2jkaYV9spTbb+aumXBV/10VmOkCYGvJNAQCYLw40KLcITT
 6SrVFI9sAFxQwklPRDJYgO5M5YTybdMcvcZDv3Zn+A5AlF4rKWLdT15YPhdLROW2
 EvgjmVo2o+gQ7hyiZLw8u2CdZf6Cofro1HvF+Au8EpSqXIyQXMgwxAM=


On Wed Oct 23, 2024 at 23:56, Jeff King <peff@peff.net> wrote:
> On Mon, Oct 21, 2024 at 10:09:38PM +0200, Bence Ferdinandy wrote:
>
>> > And possibly we could make it easier to just grab the remote name with=
 a
>> > single command.
>>=20
>> As I was running this patch through my head yesterday I sort of distille=
d my
>> argument in favour to "writing remote agnostic scripts are unnecessarily
>> complicated", but I do agree, that if there were a git command that coul=
d
>> return the remote for a branch without any extra scripting hacks would e=
asily
>> get you the same result, and may even be useful elsewhere.
>>=20
>> I'm not sure where this would be the best. Maybe:=20
>> 	git branch --show-current-remote
>> ?
>
> I've been giving some thought to this.
>
> You could argue it's about querying remotes, so "git remote". Although
> we don't really want to know anything about the remote except its name,
> so it's a little weird.
>
> Or as you note, we're querying info about a branch. So "git branch"
> makes sense.  But "--show-current-remote" feels kind of narrow there.
> Shouldn't we be able to ask about the configured remote for any branch?
>
> In which case it is really just a single "git config" lookup away:
>
>   git config branch.$branch.remote
>
> You have to look up the current branch, of course. You can do that with
> symbolic-ref like:
>
>   git config "branch.$(git symbolic-ref --short HEAD).remote"
>
> You might get an error from symbolic-ref if we're on a detached HEAD, of
> course.  You can either ignore that (in which case the lookup of
> "branch..remote" would show nothing), or a script can actually
> distinguish the two cases ("not on a branch" versus "there is no
> configured remote").
>
> There's also another wrinkle we hadn't discussed: we have the concept of
> both an upstream remote for fetching and a push remote. And this would
> naturally extend there (you'd ask for .pushremote instead).
>
> And finally, there's yet another way to access this information. ;) The
> for-each-ref formatter (which is also used for "branch --format") knows
> how to show remote names (and much more). So:
>
>   git branch --list --format=3D'%(upstream:remotename)' $branch
>
> also gets you what you want. I don't think there's a good way to ask
> that command to show just the branch pointed to by HEAD, though. We
> recently added --include-root-refs to for-each-ref, but that's not quite
> what you want (you want just HEAD, and you really want to dereference it
> to show details of the branch it points to).
>
> So I think rather than "branch --show-current-remote", we'd want
> some option to make "branch --list" show only the currently checked out
> branch, and then you could apply --format to it to get whatever
> information you wanted. Something like:
>
>   git branch --list --is-head --format=3D'%(upstream:remotename)'

Thanks for running through this in such detail! This would be more widely
useful for sure.=20

I'd probably call the flag something like "--current", "--current-only" rat=
her
than "--is-head" though. "--is-head" sounds as if it would filter --list bu=
t
not necessarily end up with a single entry.

Anyway, thanks for the idea, I'll probably pick this up sooner or later.

Best,
Bence


--=20
bence.ferdinandy.com

