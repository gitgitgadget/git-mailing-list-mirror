Received: from aib29agh124.zrh1.oracleemaildelivery.com (aib29agh124.zrh1.oracleemaildelivery.com [192.29.178.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46186D51C
	for <git@vger.kernel.org>; Sat, 16 Nov 2024 15:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731769352; cv=none; b=OJbWmvziQbiEZYbnzYIjDnp/B9+78KTaIs8Y6ChrQI6Y2z7fXlaxyFNk7SJduLaR8FybkXCZkSs9wXWjlK2XoLjwuruYngFoWVwEaqYOlMsqxnmN+bv/WQb4MX5DN641M3OVsqm1Mm2iLQEJwwHFVHq7YtpIAkKUkrhvX4TUCCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731769352; c=relaxed/simple;
	bh=rTt3Wsll6FPZllVF6zvEz09IIrINyfK8XuABjxwm/Ro=;
	h=MIME-version:Content-type:Date:Message-id:From:Subject:Cc:To:
	 References:In-reply-to; b=L2LAzdq6MxqyMq6kkwPr893NUX3SR5fj490yWLoy/Sn4UkIQ98tkZ/Y8YxmvXDCzuyofnBb90qIeYoqG37+PjUwrEwyTkZrmVoidB8YZEFMFKP7+o4qTeXmaGhiEKIgATFxMk916XHyt5qh0ftQZADhb6BAM0apXC/tBhqrD1Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=aBXRMS96; arc=none smtp.client-ip=192.29.178.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="aBXRMS96"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=LfN1SSbvZokk7hZLo1FPI4BiTbBWvgkT1vGGUmmRDBg=;
 b=aBXRMS966h6AbwZp4MW8F7jwh4A6OqqPpksphHpFDYhCcNfpLHEQyIoICzXozOeisG87ufb4mWdP
   ztwTgopxYmcPiPZdpaLrgxIrRFTXERt6CEx3/z8gLV3PHr4qmGzWkltMmZmxtUcBHNZjpIGyrRay
   vQuPPTbzGZO+IufGIF5TLgbQklIHJSoAVJVGlNfb3227tfFKJjklCfnRPTfpWrYjAjMGGSoXzP1c
   Qi+au+oSsNUmNUL9RTSdFuDQL5ad1k7ghM/cwCI5loYxUkqoq67xnCxJfD57jasxL7ZULDfTdawa
   QduihcGbw7+a29zVa4XG4gOYn0iVqQskPr5S2g==
Received: by omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241024 64bit (built Oct 24
 2024))
 with ESMTPS id <0SN1002BJTS42B80@omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Sat, 16 Nov 2024 15:02:28 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Sat, 16 Nov 2024 16:01:59 +0100
Message-id: <D5NOZMMISX44.2PTTMY57J5EM6@ferdinandy.com>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
Subject: Re: git remote set-head automatically
Cc: <git@vger.kernel.org>
To: "Jeff King" <peff@peff.net>, "Caleb Cushing" <xenoterracide@gmail.com>
References:
 <CAAHKNRGv19rhnqCkJMpE2FomNQBHvSS36aC=fh0UwO+9-6RRfA@mail.gmail.com>
 <20241116033616.GB1782794@coredump.intra.peff.net>
In-reply-to: <20241116033616.GB1782794@coredump.intra.peff.net>
Reporting-Meta:
 AAGkwcJPYXdE1jjJhGZv5KOvGVg7eB4PFdZ+aI+wB4cG37Lvupufwu/at5jyznJ1
 VGiJ1vJ88PdmQQNOx11XUvuycF5CCywryOpgGhiL22c2BslDLa9dhDsv9gbHnmgt
 T7rU0QpARY8N4ZHdHuuUiVFpFJEUWR+cO56M+p6ZY/35H6jyBEX6TI3Uz1rlbs7/
 UQdDii85FPXYkumOdBwge7TD+U1X3nknjIqTBORr3T4vxSWMB3xRd6J2KU8HU4ZI
 TkYRtp2dWRg0Jm9px+Xe76BPGxE+kcBpjvvfStY+HfPWHNRknn+SpqU1wkrnlHcD
 /jkLPKzScxULKphLaC+YnRoFJ+AZLe3zhr0cy1HZC9ZwKQ7izDIE+qwwtlqqSn4b
 58boc8BjNwC78cc1n6VHNUQ/muuji0W0MUpOxc0wRHQbGXfl9fbH+g0Z6nsONVQX
 SqQQ62UyYUDpReVKuH32T6hKxxQpdj7COpk4enE215dpF1CfW0lND9iE


On Sat Nov 16, 2024 at 04:36, Jeff King <peff@peff.net> wrote:
> On Fri, Nov 15, 2024 at 09:34:28AM -0500, Caleb Cushing wrote:
>
>> Context: recently I've been trying to develop a feature for my Gradle
>> plugin that derives a semantic version from git describe.  In order to
>> achieve my next level of feature I need the HEAD Branch. Now, I can
>> get this branch using git remote show <remote> and parsing the output.
>> I'm a firm believer that it should be possible for me to write code,
>> long term even, without the internet; I did this once with my job when
>> I needed to go home to my parents who were very rural and didn't have
>> internet; I was able to keep working without access. I want that for
>> anyone that uses this tool.
>
> You should use the refs/remotes/<remote>/HEAD symref instead (or its
> alias, just "<remote>"), which is more convenient and doesn't hit the
> network. Which is exactly what...
>
>> Problem: I don't want to have to do a network request every time I do
>> a build, in fact I'd rather almost never have to do a network request.
>> Gradle makes reducing the network request to less than once per build
>> something ... unsupported. jgit doesn't expose support for fetching
>> this information. Then I found out that you could do `git remote
>> set-head <remote> <branch>` which appears to behave exactly how I'd
>> want and expect. It doesn't easily solve my problem though because I
>> want my solution to be generally applicable.
>
> ...set-head will set. So OK, but...
>
>> Ideal Long-Term Solution: git remote set-head happens automatically on
>> lone, and even fetch if it's not set. Explicit setting would override
>> any automatic setting; and it might be a good idea to automatically
>> unset if the HEAD branch disappears from the remote.
>
> We already do the equivalent of set-head on clone. If you do:
>
>   git clone https://github.com/git/git
>   cd git
>   git symbolic-ref refs/remotes/origin/HEAD
>
> you should see it pointing to "refs/remotes/origin/master" (and like you
> can refer to "origin/HEAD" or "origin" from git-log, etc). Are you not
> seeing that?
>
> We don't update it on fetch. That has been discussed, but there are some
> questions about when it should overwrite what's available locally. E.g.
> this thread:
>
>   https://lore.kernel.org/git/D3HBD7C1FR14.74FL1Q1S9UCB@ferdinandy.com/

That part we already have pinned down: fetch will only update remote/HEAD i=
f it
doesn't already exist. So running "init && remote add && fetch" should end =
you
up in the same place as "clone" (although fetch will report if the remote h=
as
changed HEAD compared to what you have for transparency). If you _always_ w=
ant
to have the latest head you'll need to run "fetch && remote set-head --auto
[remote]" every time.

Something like
	git fetch --all && git remote | xargs -i git remote set-head -a {}
covers everything.

>
> There have been some patches in that direction but I have not kept up
> with the current state:
>
>   https://lore.kernel.org/git/20241023153736.257733-2-bence@ferdinandy.co=
m/

There's definitely going to be another round, but I think (hope :)) we're n=
ot
very far off from finishing.

Best,
Bence
