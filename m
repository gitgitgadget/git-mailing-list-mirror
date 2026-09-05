Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAC2348C7C
	for <git@vger.kernel.org>; Sat,  5 Sep 2026 08:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788596808; cv=pass; b=QCOi2oG/BoBsFeWx3yqDpqHexsBsABYu+suC4RU3hcvU/YWP+vdmqd1FOznJXfUMFoOxjgNBovcOms7EszVecy2uU6fsuf5Te8HAwyuF/08ilP+xQyLPBQaLn79F+DY19GiMNqMhr2TnuQnb6JjJ8fs4Dk0FzDjwraFj07rNz0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788596808; c=relaxed/simple;
	bh=c+yR6sSGFFqPhC0n0d0FmQY64jY4s8kTrgFueAULi68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E5K7jOA+PaW7MLXPJplU6t2eh4XAhNmnUfjbicN6GGDwQz6RrWSSReH629ecldE2q4F4ITyiZjTGxvehBSPfYSUac2HnY5SQHMqti4dgQsGTR3r4BMI9FfsIkuUYgf8woWnrWATjhnMDEns/GZ7kEXLS6Cyz6BXMkjvOiRIg2T0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZiPPBfgT; arc=pass smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZiPPBfgT"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-84830c774a0so1602124b3a.1
        for <git@vger.kernel.org>; Sat, 05 Sep 2026 01:26:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788596806; cv=none;
        d=google.com; s=arc-20260327;
        b=Sc6JSAY25V/cbNleY1i//Wgq56M3DH8ZDTKRK2Krp15+YlGXQDLe1WwpHzakPt5Jie
         UzbhURrg6E7i1xBfGthitV3mP/BW8xg4EZ2qG0B6FeV0ltWgc5dL2vmfaBxG7ojkueDO
         8ON+k4nFJfO+goi2MY6D6WkkZRlicMyr2CbUyYXD5vLdouzV0xz7IFsOMqAE6ZkJvKBR
         4qVbwRG4kkWWALXhCSZrXO4627DccxFBJWDBqomJcvbN9gFGn3/hQiqh0nOCjdJAxQe7
         PuX7gduEJ08EqiW+uxIHEBEazyMDf5kGZt/8MU+QaOWMtz2POQt/hHXxOUtaQF/4HU63
         /v5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c+yR6sSGFFqPhC0n0d0FmQY64jY4s8kTrgFueAULi68=;
        fh=0hZOEHH7Fi06O787RjWtj3trnEAT4KH+3GeYzCEcIzc=;
        b=HlhOwMnLjwTVqCeeeX+QMZ37iDIjdkuv+W0NP4eiikAoFv5xwe+bVNKWxz9ljsBosi
         MLQAtireZm24WFFeIJRQLCxue0W9ll4Rk1VZVueXzdj2vjE9Z1w4OhkW2Sww1toRYZTe
         Xj2+s/zRKlpOFBDn+taLdWGrA6oayfhpxVLMAH9LOpbA2lntYptOWUW7GHM0YEFU69yp
         yUrkVzvzBRXGmcBLxKO/TKTU3ldUNydFs+Cbdn9W/IJHYW0U3AO+U32gy18TOHzWa2rq
         jvSJSPYFBf6mSVN1vIUjKqg2y2wbmHNscoeCjE/STCOwnyLqCvcTz+zTZ0Hk2mkxEkjp
         gQ9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788596806; x=1789201606; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=c+yR6sSGFFqPhC0n0d0FmQY64jY4s8kTrgFueAULi68=;
        b=ZiPPBfgTDJnmrTc5lWetzhuVP96qiTVIPT4iLRJdeaVkzOzBMPEy4Ax1PxJMyBo8r6
         L+uPEhUFFBp3RoD5bCzzlcLlZ8PdG0+OWeSdcJu3B9uyQvInXAypawgq/oAZmMhdhVvZ
         7Q7hT6Bd03goavy1gMdr8IlGz9P13SXv7W7DVDQJvnhyWE+elfL1XS0IK2ncp9UxYuEM
         0D+jjHVUoJF+nXpyr2KoGswqAi5dORbCvTAbOxDOiIlel3MjqlAgake8tMkD3RT0Mn1e
         4kD5t3A7X7IK5+hUFZmIRy8bzeV7YM7aMPqcwPyg0xmzXZtL9GSihhvB49QDunUFYOLk
         rf2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788596806; x=1789201606;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c+yR6sSGFFqPhC0n0d0FmQY64jY4s8kTrgFueAULi68=;
        b=TTL4xHqU7jNKBN7gHNIBZcdiKPVSIKwt/3KdwEOkp2F3+RQT3NKlwNjLjbnxhxkspP
         PtkmzYJWI245dpl79Ns2MFvrq8UtGyr83RkU+R1qscR2tNrRR72luBmMaYrY+l6+czed
         jff373NWXu/oIqRB1yji1lAWlHjEjafq/HSH17JJYHfjxu2tKZKaxC8VJ6gNh1aL301B
         XV0n32tytPgibonmWKVIidqWyqkLGwIJzgbFet+rkCkSHJ0eO1+IHNpAFgVBmqfj8aBG
         t1h2AF6Kaaz8XxJQG8CWhVvcC3cJhki+x1Tavyw8s3qC7Hxaxn0CRbKYsG+H0OQmYOae
         vGNw==
X-Gm-Message-State: AFuF++kAysFB3ouf+u2GHUnSY+WhSmaUatROFSUrlm7ohp8v+ScRIX2o
	5DtXGh3clzYL+zwHhVQf38pXqPIh3t6JmpJ6SzKLaZ5rFfJ2EhK+fjFzMsQu1PZq7n5dLDvLkSj
	dgT9rlagFDp/7RRP1pB73UdIeCH6LFzcJ5IF7ArY=
X-Gm-Gg: AYBFou2WRuSVIlSyBd31kwlcvi49ioesv0jR5FXqYqc+j+PScggOakntNwui7w3mE0q
	/1HvL20CyJ3fWBkgsGHdfSb6em39sj9uMkrd5epu8Yju5wySNQcopTQCUon7G+dunZ+l3U2K1RR
	Dh0aX3UMft6ibKoRKjA0f9ZcA2/s9bJ9JRDm6wz+mrfudOidUgP9Jt6hFBo6XQlUHLWiC3YCOtn
	Q76sXEEVNryQsxTw0o4ltEOPb77/EaFy9etmL8m9dus9pX6CzWn5L2OsdsOW3grXHQhSbBOv4rp
	Rj3/od4kft0GIDa2NUw9pe4Kmq8l7Q6CuJD9GSvvdfepEkhQ0pNJoAkotYAFY5IulL0n1M2b47L
	BYWpbHPBOCvP5hPnLa2FfZ8hn8COTiUbaC1zWm4zuYqPoE4TwzYWuJSToqqlMub/7Sf+KPE+nYI
	XI+3D/vtg1/MlI+GUUn7qnnrYdnEjPf4y5T/tq4wEXCG0Gms9Iqm/u6gpmtLJYinM5OpfWLw==
X-Received: by 2002:a05:6a20:bea6:b0:3bf:7e2a:e874 with SMTP id
 adf61e73a8af0-3da39b5c429mr17527450637.1.1788596806471; Sat, 05 Sep 2026
 01:26:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP8UFD367UD=AomNVHEBnhY-2DQmqTNRcBX6NW7YZywWgOmxTQ@mail.gmail.com>
In-Reply-To: <CAP8UFD367UD=AomNVHEBnhY-2DQmqTNRcBX6NW7YZywWgOmxTQ@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Sat, 5 Sep 2026 10:26:34 +0200
X-Gm-Features: AcwNN1WnFas0BOujnwEnjae-GIKo1crHbimmIXQrWggqoUXiupy6VtTs6AwGOJs
Message-ID: <CAP8UFD0oYnoXgQ84wHbGg3+QhX78Ucn_CXXYOe8uFpReb7X1Ng@mail.gmail.com>
Subject: Re: Participating in Outreachy's December 2026 cohort
To: git <git@vger.kernel.org>
Cc: Git at SFC <git@sfconservancy.org>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	Pablo <pabloosabaterr@gmail.com>, Usman Akinyemi <usmanakinyemi202@gmail.com>, 
	Tian Yuchen <cat@malon.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 12:55=E2=80=AFPM Christian Couder
<christian.couder@gmail.com> wrote:

> Open Source communities have until September 11, 2026, at 4 pm UTC to
> sign up to participate as mentoring organizations in Outreachy's
> December 2026 cohort (see
> https://www.outreachy.org/blog/2026-02-06/may-2026-call-for-mentoring-org=
anizations/).
> And (co)mentors have until that same time to submit project
> descriptions.

Thank you Usman, Kaartic and Pablo for volunteering to co-mentor!

As no one objected to Git participating in Outreachy, I will submit a
Community Application for Git very soon.

We will still have to sign up as mentors and find and submit projects
for interns to work on soon. We have until September 11, 2026, at 4 pm
UTC, which is less than one week from now.

I have been thinking about the following projects:

1. Continue removing global state (and perhaps start libifying some
parts of the code base).

I think Tian Yuchen said there is not much work left related to
"environment.{c,h}". So maybe we need to adjust the project compared
to its previous description or maybe make it about actually libifying
some parts of the code base.

2. Improve how command arguments and options are scanned and parsed.

There are still a number of places in the code base where command
arguments are scanned or parsed using ad hoc hand-rolled code instead
of an existing API like the parse-options API or the early-scan API I
recently proposed in
https://lore.kernel.org/git/20260902161047.476753-1-christian.couder@gmail.=
com/.
Those pieces of ad hoc parsing or scanning code are often buggy and
difficult to maintain. I think porting them to an API while improving
that API if necessary can be an interesting project and bring a lot of
long term benefits to the project. As the parse-options API is already
quite feature-full, there are likely some areas where porting the
parsing code to it should be relatively easy which is newcomer
friendly.

Let me know your opinion about these and if you have other project ideas.

> Last year the Git community mentored a single intern. For a long time
> GitHub or GitLab used to sponsor Outreachy interns working on Git, but
> last year both declined to do it, so the intern was sponsored by the
> Git project itself.

I will start poking people at GitLab about this, but it would be nice
if we could get some kind of help with this regarding other companies
too.

Thanks,
Christian.
