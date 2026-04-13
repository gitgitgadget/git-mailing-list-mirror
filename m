Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373D83E274A
	for <git@vger.kernel.org>; Mon, 13 Apr 2026 18:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776103652; cv=none; b=G/kSLU8RLTo6zNjzVIqGAf0TTLC4V/JX3XLeuynT0ONNNeqytg3TLtr7bKDUhgWLVoNs3Axe4+uBsLJZcRRDorYgdzdnTuc8LTaHOXIesy90jiM6dgz6QeHsOjAM6a/r9aBlrGiExAmDegsGOvYFgVDcjUSBLFNuaSQh2FqVuFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776103652; c=relaxed/simple;
	bh=HMHzc1l7F54cU6VtKXEwec/CpmQ4LlqQ3F5eYUvkHuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jslr92ytLN2xCPZEG63UCQtBScEDWkYrRMcm7k1ida/UGzJxp9pm8KHCoOPiigfNRQrPiR7WU3Y0858UxI3XSxvgh+yZLPH6ypJ7cGIR8R9LsPHzhosluhh75AgM5WzhjPTj87dTpmy3R/l7ST22je/0r8vtg011/L2QPHV22Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=uOeQE1KY; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=hw5sYdNC; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="uOeQE1KY";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="hw5sYdNC"
DKIM-Signature: a=rsa-sha256; b=uOeQE1KY9OekH4IFmRp+xNRHZiuY89+5jotehLKcoG4kCLxvd4oPDWtrbeX8GHO7+La/GDpxcUiFTh3DDJG+1/93QHuKiIPXT2OAz/l5UFC2GUndAhmUGLstRDL5DVP4FmphlOXSfO6PdFOqTUF/chihkb5zLmfsfX1npThLleZBSewGLBgCK5xQwGds6AtX6HZAg9NdxCx4IyMVwMit+m0HnH08T1bdNmw33AfLbXtM4944JkZMOX8gdZ2OhvxSHvrxdncVyJXO+BWVKWbnlcsbLfjpjiAz85innq08XDYW37LdHGE8F2Nf91eb7H9Y7gcD4Z5cFHtxqPhTRjvZlw==; s=purelymail3; d=malon.dev; v=1; bh=HMHzc1l7F54cU6VtKXEwec/CpmQ4LlqQ3F5eYUvkHuI=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=hw5sYdNCKfIHoFGXEjkRtrXgcZyjtIsBvcOX59CvRuBdYiHC4RSeEsR2fV+rI3HmjVC1cewIQ6B2trJiuxLE1/GBRzvnm/97iiTWyd4WCHylrI/6Bw3/9rCHBk6xqZ+ObToLu+x92pYVwKP1+qWrjAGmxAnacqxXNw/UL4nzZhQMSOmH9tDfF0xMmfZxH63f98wZIHqBXzsoQC3hB/nSm+3YmQGKpd4yb9rWTL4mxEVHGg4X7W08Wo+vUtqR/dQ7pgrlMCLiymHMEZh3BpB4U6rQVL7S7PSIAwyaUJF+t/U9dP9QbvqTqdgOws7WRLBQRrvuQX+mrNua91poqQtjIg==; s=purelymail3; d=purelymail.com; v=1; bh=HMHzc1l7F54cU6VtKXEwec/CpmQ4LlqQ3F5eYUvkHuI=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1249727085;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 13 Apr 2026 18:07:20 +0000 (UTC)
Message-ID: <31c50eb0-0fc0-46fb-a277-b5fbb28d1d9a@malon.dev>
Date: Tue, 14 Apr 2026 02:07:16 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] New command: git-recall -- a developer standup/activity
 tool
To: AMMAAAR BAKSHI <the.ammaar.ic@gmail.com>, git@vger.kernel.org
References: <CACqkj0pxih1BSa8z9+Yw-g55G1rNcvvQao+SLwQ7B-eQodcvgg@mail.gmail.com>
Content-Language: en-US
From: Tian Yuchen <cat@malon.dev>
In-Reply-To: <CACqkj0pxih1BSa8z9+Yw-g55G1rNcvvQao+SLwQ7B-eQodcvgg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail

Hi Amar,

On 4/13/26 07:43, AMMAAAR BAKSHI wrote:
> Hi,
>=20
> I'd like to propose a new command: `git recall`.
>=20
> ## Motivation
>=20
> Developers often need a quick way to review what they (or their team)
> committed recently -- for standups, weekly summaries, or general
> self-review.=20

Standups, weekly summaries or general self-review...? These feel more=20
like workflow conveniences =E2=80=94 is a built-in command really the right=
=20
place for them?


> Currently this requires constructing a `git log` invocation
> with --author, --since, --oneline, and formatting flags, which is
> non-obvious for casual users.

Adding a line like 'standup =3D log --since=3Dyesterday --author=3D...' in=
=20
'.gitconfig' is another nice way of achieving this ;-)

>=20
> ## Proposal
>=20
> `git recall` would be a porcelain command that shows a formatted
> summary of recent commits, grouped by date:
>=20
>    git recall              # last 1 week (default)
>    git recall --day        # last 1 day
>    git recall --week -2    # last 2 weeks
>    git recall --month      # last 1 month
>    git recall --year       # last 1 year
>=20
> Example output:
>=20
>    --------------------------------------------------
>      git recall  --  Last Week  (since 2026-04-06)
>    --------------------------------------------------
>      2026-04-11
>      448e66e  Add login page  @ 19:41  Alice
>      2026-04-10
>      91bc3fa  Fix null pointer  @ 14:22  Bob
>    --------------------------------------------------
>      Total commits: 2
>    --------------------------------------------------
>=20
> ## Implementation
>=20
> I have a working standalone implementation in pure C with no
> dependencies, available at:
>=20
>    https://github.com/AMMAAR-IC/git-recall
>=20

Good to hear that;

> It currently runs as an external binary (git-recall). I am interested
> in contributing this as a built-in Git subcommand if the community
> finds the idea worthwhile.
>=20
> I am aware that similar output can be produced via:
>=20
>    git log --oneline --since=3D1.week.ago --author=3D$(git config user.na=
me)
>=20
> However, git recall aims to provide a more discoverable, human-friendly
> interface for this common workflow, similar to how `git switch` and
> `git restore` were introduced to simplify `git checkout`.

I suppose the 'checkout' command was split up and simplified because its=20
meaning isn=E2=80=99t particularly intuitive for ordinary users, is it? 'gi=
t=20
log', on the other hand, is, in my view, a very clear and=20
straightforward read-only command.

You said this is a more discoverable and human-fridenly interface. If=20
that=E2=80=99s the case, I think we should compare the merits of this metho=
d=20
with defining aliases directly in .gitconfig.

>=20
> ## Questions for the community
>=20
> 1. Is this functionality considered within scope for a built-in command?

I don=E2=80=99t think it should be a built-in command.

> 2. Would `git recall` be an appropriate name, or would something like
>     `git activity` or `git standup` be preferred?

To be honest, the name 'recall' is a bit odd.

According to dictionary.cambridge.org, 'recall' has at least two=20
meanings. I think this is your intention:

"...to bring the memory of a past event into your mind, and often to=20
give a description of what you remember..."

However,

"...to order the return of a person who belongs to an organization or of=20
products made by a company..."

is another valid meaning. We say "recall an email" "recall defective=20
products". This suggests that the word carries a connotation of=20
amendment/revocation. However, based on your description, this is a=20
*read-only* operation, right?

If a "casual user" sees this command name, might he think: "This is a=20
logging command, but why is it called 'recall'? Will it alter my commit=20
history? Could there be other side effects?" This is something we need=20
to think about.

> 3. Are there existing plans or discussions around a similar feature?
>=20
> I am happy to write a proper patch series if the idea is well-received.
>=20
> Thank you for your time.
>=20
> Ammaar Bakshi
> https://github.com/AMMAAR-IC/git-recall

Thanks, Yuchen

