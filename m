Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55D58F44
	for <git@vger.kernel.org>; Mon,  5 Feb 2024 01:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707096936; cv=none; b=luwgv2RU8YM3e5chR/tL/7XsJIFKata1IC9LfEfkIQqtk3jjFwtELqu+aO3pTJfQ+53++aOT5ctR3GvIay6uwii70XUKOixjgLCiYHyaM/bzzlcwpvMV8i1sSmOmZp9IxKIkL0wHhIhS2Oqke5cw4G8tz8GvUNSnNDvkOFmftDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707096936; c=relaxed/simple;
	bh=fYL8sXYg9Xm+FoxTy5MMaQ5UiWQylqZ4eN338RHnzu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jsTo9bl51mEkOZx+CPzWVpDjkqJDBuqOFgzO8LWbkUKtZD/gzGdjI38cXdQ6j1FeNU7CtI2h2Q2HTfeNgUWQHbO+9F61pmJDM9qJ8MJQBCqjSEC41fApU4XqPlSIPMY4JPu4anieJSwUEL+9zM3UlMBF3CUz+mjnb3J9/QnO6G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b=eT96XCv9; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b="eT96XCv9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1707096931; x=1707701731; i=oswald.buddenhagen@gmx.de;
	bh=fYL8sXYg9Xm+FoxTy5MMaQ5UiWQylqZ4eN338RHnzu8=;
	h=X-UI-Sender-Class:Resent-From:Resent-Date:Resent-To:Date:From:To:
	 Cc:Subject:References:In-Reply-To;
	b=eT96XCv9Cu0dc6GirjdO/P7DgSqxamlvBFSATyY2qKWQCqZWypNRKcCbhZCf60mg
	 U7F6n24SyaCU5eIUXZrw7Cik0SKcnfgyTnNQqFPzEVMOM0MQr4aFqcBGPXDkaWMju
	 OYIHakTYzepnvxH82girSVZzw66IZaf4ADJkBKdqW1ZR0WydY1kMeTEp+ErKw/rDE
	 s4t3SURJAopG/wMpi4DgCjBhN+wa7fs6Ss+0Lk6NXyrwZRDlEkGm7c2F0Yu4KaQR/
	 hH3pdGRBmCVrgzJkVHAE5UdTQ0Vq92mhja9ESqVJ+f9YOYf93CtTkx35UTb4Jq4Ow
	 998asnLDaLOlzJHx1A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ugly.fritz.box ([89.247.162.159]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M72oB-1rfIsu2ykR-008ZNk for
 <git@vger.kernel.org>; Mon, 05 Feb 2024 02:35:31 +0100
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
	id 1rWntT-G6u-00
	for <git@vger.kernel.org>; Mon, 05 Feb 2024 02:35:31 +0100
Resent-From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Resent-Date: Mon, 5 Feb 2024 02:35:31 +0100
Resent-Message-ID: <ZcA7Yx+DcngROG1H@ugly>
Resent-To: git@vger.kernel.org
Date: Mon, 5 Feb 2024 02:04:52 +0100
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Cc: phillip.wood@dunelm.org.uk, Patrick Steinhardt <ps@pks.im>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Hans Meiser <brille1@hotmail.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Migrate away from vger to GitHub or (on-premise) GitLab?
Message-ID: <ZcA0NEb+lnjeZUBe@ugly>
References: <20240201-primitive-aardwark-of-contentment-aaabb9@lemur>
 <DB9P195MB21301E5E271567256303443CE2432@DB9P195MB2130.EURP195.PROD.OUTLOOK.COM>
 <c3b6de0c2ccf71f0dfa5aff06fa63d8f@manjaro.org>
 <DB9P195MB21303B5546A764A18FE78C97E2432@DB9P195MB2130.EURP195.PROD.OUTLOOK.COM>
 <ZbxI4wNTBZ48YcTi@tapette.crustytoothpaste.net>
 <Zbx5Xzb3kyHvkp7C@tanuki>
 <0e3e6102-40eb-4462-b541-0c7452e79f42@gmail.com>
 <20240202115004.GV9696@kitsune.suse.cz>
 <Zb+pQk9R3AOouFxF@ugly>
 <20240204154714.GZ9696@kitsune.suse.cz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240204154714.GZ9696@kitsune.suse.cz>
X-Provags-ID: V03:K1:wE0ScW+g6f9tnTT2YAvtRqnDVT/xLqdx87bWDpgGvyBdWdvZFZg
 wbKHoKRyKLDxoAz2zesSG5amdpAmAqnU1FVKT94TZSHopIitNYayRbRwggGjprPrux9qnzd
 x3YhTX0w+jkpAqtJTVAtTKGXVzglpT7MekP1rhiPpJI+vuZwGPgI01EgGqlTtbenbPwGTVn
 Rw5EDmsa/eylqUUYf+p+Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fD3+oxs+uaw=;dO/QYhkvaq05Xr46s97tarjjb20
 IK1IIOTK051qF8f7PQUDxKEospFpzDzoz2bfg+ZORXgqWnRTxHyvKjR1I7nAHkat70VCU6rny
 3jx5bSULdXJh73NMGaTYcUJlsVeK29HhGL1Db8/gLTPiw9BwaxHa9gntr6GTMUduXUYV+KC4R
 0E4b7ZacNqJHhm4s3Hmp6EjMSGtfObJyNi0jK2zDye/TjzLZcrNrC2FrpmevI7y5OoqDl7I0J
 8mFHAiR2+CYjW08zyeiF6u1YaFQIxyROXFCzHc/HJvOTDBPZ0k6Es+9BnA0Ms1Uap3G+v3DuB
 Xr4ZVLGfRwkx0XFTEjAZrgbdrDxixvYQg8muHkBhennxzJk3Rs5yVqzIAdeCf0zDXfhxBSfEe
 APl3l3slzpKtkSxzs7aJpP6JERRnRdfsLXzZcW2nNPpuuJ+se18IRqBncCLB2Aca7W8uNdmjx
 z1j9el6jTmkqTGajTe++T4w3jw87kaVvuQFxK1Ja0nN58p6W1l7vcKN9kKreAI6qb8cPzOYEM
 GTi8xGTtv5+HjXoIEQWB0HxB928kJQyYmxSv2Agh9b8+mk+0HHmOcjIwJ139jvLGnQTrAVxOH
 V7cC26vjf+CvRhzHClJNOMfgXBc2K4L7pLiAecp2vBgHL0giyDGMNe92JyTk7aPNWYUABLBGi
 +jUnOZO9Ojbqt6NiIYNX4ELj+4BUvDRJbDgfVqxG+bu2QPkirrGl700jXyhlp7yIvRjywjdD0
 EBDgJ/ZXigGa/sZvIWWzBqyCG4nBpXoWC2vpxzSCkfEDB9eEx58d6bCMzfxmoSgaIwfiW4YE2
 nd1n73W9i2b0ahwF3Chcvl07y8MMDkHgy9n6MfyEfyjAQ=

On Sun, Feb 04, 2024 at 04:47:14PM +0100, Michal Such=E1nek wrote:
>On Sun, Feb 04, 2024 at 04:12:02PM +0100, Oswald Buddenhagen wrote:
>> but after working with gerrit code review for over a decade, i find
>> it
>> mind-boggling that people are still voluntarily subjecting themselves t=
o
>> mail-based reviews for serious high-volume work.
>
>I have yet to see gerrit in action. Very few projects use it so it's
>difficult to gauge what tradeoffs compared to e-mail based workflow it
>does provide.
>
from my just slightly biased perspective ;-) i can't see any significant
trade-offs except for some set-up cost (that will quickly pay for
itself).

in fact, my gerrit workflow is still "e-mail based", in that everything
is driven by the notification mails, only that i "branch out" to the
browser whenever something interesting happens.

for the CLI hardliners there are gertty and emacs egerrit, but i see no
point in using either despite being a heavy CLI and TUI user. given how
"much" attention these tools get despite there being literally tens of
thousands of regular gerrit users, i'm inclined to think that there is
indeed very little demand.

gerrit also has an incoming email gateway, but i'm not sure how advanced
it is - at some point it required well-formed html replies as input.

if one really wants to, one can install a webhook or event stream
watcher that posts all activity to a mailing list (and i don't mean
_the_ list, because it would be just noise on top of everyone's
individual notifications).

>> migrating the workflows that are worth keeping isn't such a bit deal.
>
>Have you migrated them to gerrit already, and t[a]ught all the git
>contributors how to use them from gerrit?
>
that challenge is sort of meaningless, because the only workflow within
the git project that i'm aware of that would affect "all the git
contributors" is the interaction with gerrit itself. which has a very
steep, but also extremely short learning curve. and there are tools to
meke it more pleasant - https://wiki.qt.io/Git-gpush-scripts (yep,
shameless self-promotion here).

i'm not aware of any pre-integration build bots, so nothing to do on
that front except for some mirroring adjustments (gerrit insists on
being its own authoritative git server).

gitgitgadget would just become obsolete, to be replaced by the github
integration plugin.

my main concern is with the maintainer workflow:

the way gerrit is usually used, the contributor determines the target
branch, and the changes are merged directly to it after they are
approved. unclean merges must also be eliminated during review. that
works just fine, but it doesn't match the refs and merge commit messages
junio produces. and while aggregating pending changes into `seen` would
be still perfectly possible (each change including its dependencies is
just a ref), it would be somewhat awkward due to the naming and location
of the change refs.

to reproduce the existing merge workflow more faithfully,
- junio would have to monitor incoming changes, manually create an empty
   branches for each topic, and change the target branch of all changes
   in each topic
- the gerrit-side integration would then happen into that branch
- junio would then proceed with manually merging the branch and
   direct-pushing (that is, not creating a review for it) the merge into
   next or maint
this is reallly just the current workflow, and can be equally automated,
just with slightly different tooling. only it's ... weird for gerrit,
artificially creating a bottleneck. the gerrit integration workflow is
naturally decentralized.

personally, i would just switch to the usual gerrit workflow, and at
least for `seen` use a merge-free workflow -- with gpick (gpush
complement, see link above) it's absolutely trivial to track all
interesting branches stacked onto each other.

>Somobody has to do it.
>
yes. and if nobody does, then everybody keeps paying the cost of not
doing it. that might incentivize Somebody (TM) with the resources and a
vested interest.

>Also can you migrate away from gerrit once it becomes defunct or new,
>better alternative emerges?
>
>Recently it seems that forges offer a 'download your project data'
>option, probably as a result of GDPR. What use is such data blob though?
>
current gerrit keeps the meta data in (yet more) awkwardly named refs
containing plain-text files, so that's no issue. one could render it
into a read-only view, or convert it.

>An e-mail archive is that: an archive. It's a medium that you can read
>with a wealth of software today, and 100 years from now. An achivable
>data format.
>
with a mailing list archiving the event stream, we'd have that.

>Compare that with the 'download your data' blob from a forge. Can it be
>uploaded even to a diffferent instance of the same forge to restore your
>project elsewhere? Interpreted by any tool othar than the correct
>vintage of that same forge? Deos even more than one instance of the
>forge exist?
>
a review meta-data standard is being discussed from time to time, but it
hasn't gone anywhere yet.

but looking at it from a practical perspective, with a list-based
archive the situation wouldn't be any worse than it is right now if
gerrit was to suddenly disappear.

during my tenure at the qt project i established a commit policy (and
deployed tooling to help enforce it) that presumes that gerrit could be
replaced at any time, so commit messages are not supposed to refer to
other commits by gerrit change ids or review urls. (in principle, this
works even for pending and abandoned changes, as each patchset (revision
of a change) keeps its commit and therefore sha1 forever.)
of course that's not practical for regular mailing list posts, but one
can't have everything ...

>And even if you do convert to gerrit it's unlikely to satisfy the "Why
>are you not using github or gitlab" crowd. It's not one of the big,
>popular forges they are familiar with, the UX is significantly
>different.
>
i can confirm that in the qt project this is indeed absolutely the case,
and the last related thread isn't even cold yet.
but why should the people with standards care? lowering the barrier to
entry is all dandy, but not when it causes significant detriment to the
workflow of those who do most work.
note that the original request in this thread was for "structured
discussion", and gerrit would absolutely provide that, among other
things.
