Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA9779CD
	for <git@vger.kernel.org>; Mon,  5 Feb 2024 01:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707096925; cv=none; b=al0rXztJC1DZ5E5oznicmASs1qZJeKzjT9p1cVu2fncFdNV416jQmwK5W4q0iX0NirfCTwAcLgyuNsPdxhay1+bIxXrUndYask2bsqDQbYogXQFnjV3c7jnmbo5SUOl4WOj4ZoDp5oOKzWrNZFEMh/TvvLVdGckqhtp8NUaDlCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707096925; c=relaxed/simple;
	bh=NPuKe5ghGFVNheQmWCH7BXY5FQF+arsz2zCF2wr+3cI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HHgUavhOxbCAI2NO7ObYTXDXQOLuzYORMGzcGdQG8nrtQFSgIloxdScv45ABX85z4ZQk+JacdUcBzJDQ9d/35QF5hR+jmXld3DHy2Yvtrxb77lLHvnTLRd8ipyuCeGC/QPd5l5nnQht1zaMHFaoFZW4V7Be9BV7knH+PlPhPogw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b=leHGwJfF; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b="leHGwJfF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1707096921; x=1707701721; i=oswald.buddenhagen@gmx.de;
	bh=NPuKe5ghGFVNheQmWCH7BXY5FQF+arsz2zCF2wr+3cI=;
	h=X-UI-Sender-Class:Resent-From:Resent-Date:Resent-To:Date:From:To:
	 Cc:Subject:References:In-Reply-To;
	b=leHGwJfFM/hc+d/m2g+PTHgSpRKvY+A2vUEs43gt3OZx41US5JFE5NnZdturK5hj
	 cEjJgA3n8vpXNZxYKDkwL4dJ9elDHevEp+KB0k/aAgh53QB9Dl1Q5UgNLNbVZTSBM
	 BjJKn8CtvNj13fT9Swi0Qd/sF8HpinGK8XhcnMLrZF1TEDoWSZVtKjwr30Im78TrO
	 rZ0bCUEmfwcRSvqRVyjjfnkkz+7bhf0UN5mU1hXVQ4rRDjA8cJ5UozH8D+ygkOXB/
	 Rdx+0pTqSH0JaCU8Kjgg8yR3wx0z2KE/WC9xLdDLRMz72AkpCHs5jxxJ5yLzJ512w
	 9VgNgEXNd+MfcK4Jqw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ugly.fritz.box ([89.247.162.159]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MRmjq-1rQmGp0c3O-00TFQf for
 <git@vger.kernel.org>; Mon, 05 Feb 2024 02:35:21 +0100
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
	id 1rWntI-G6c-00
	for <git@vger.kernel.org>; Mon, 05 Feb 2024 02:35:20 +0100
Resent-From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Resent-Date: Mon, 5 Feb 2024 02:35:20 +0100
Resent-Message-ID: <ZcA7WPWm7xAQfKp+@ugly>
Resent-To: git@vger.kernel.org
Date: Sun, 4 Feb 2024 16:12:02 +0100
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Cc: phillip.wood@dunelm.org.uk, Patrick Steinhardt <ps@pks.im>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Hans Meiser <brille1@hotmail.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Migrate away from vger to GitHub or (on-premise) GitLab?
Message-ID: <Zb+pQk9R3AOouFxF@ugly>
References: <AS2P195MB21350F44B079009C05A1EAF1E2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM>
 <AS2P195MB2135D91EE464FF30EE84E77EE2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM>
 <20240201-primitive-aardwark-of-contentment-aaabb9@lemur>
 <DB9P195MB21301E5E271567256303443CE2432@DB9P195MB2130.EURP195.PROD.OUTLOOK.COM>
 <c3b6de0c2ccf71f0dfa5aff06fa63d8f@manjaro.org>
 <DB9P195MB21303B5546A764A18FE78C97E2432@DB9P195MB2130.EURP195.PROD.OUTLOOK.COM>
 <ZbxI4wNTBZ48YcTi@tapette.crustytoothpaste.net>
 <Zbx5Xzb3kyHvkp7C@tanuki>
 <0e3e6102-40eb-4462-b541-0c7452e79f42@gmail.com>
 <20240202115004.GV9696@kitsune.suse.cz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240202115004.GV9696@kitsune.suse.cz>
X-Provags-ID: V03:K1:9JUAMyyNz3zTvIvv4XpGclcMr019Yu081oWQ5Ph4bY/A+keXQAk
 aFyifLPF0ERkrxtG/DwqD6GHGLECHjyOxJBiTbaaqnj8Rfc54DC5C6ism5K4+11VyJDYGtN
 Zbr/1SLa5H+rA+36mSS2gOfmsioDFbxqtw2xTDXSH4ABGNqnGF+l2fslEELq8pEjkP4kt+M
 obMruwNoOQhPcRX34hCqA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:cGIGqCDDfTc=;XC+ISB/QTZHOoHcBw3TiAgMNIIW
 eMny7lmzSbfu+wjwnCV1PMddgAcjth6U3Nz44R+nZa4b53jV7A8jo3Fhy0aYUlXwRO3vosCSk
 rnTd+YwDF1cft+3/QBJdz/dvej8hxWI7nCmGhI1ZIcDJIpv3uUgJyR8BqEbIkajRYa6jPJgkb
 N6jOJtWFzSsexQDRIdKqEUwwoNUPPUPCNcsx/646JfzlpW4LbwDnSImA0q5f8JTPNE8SzjRZQ
 HqxBNOnSFAUCsQRnKpsQ6+sM1pcgY66RhSRFKCGczA7IrHZhrquNUA8VJLvnjb7rm6UVH3hCJ
 x5R+cX3XWmiKqBL3dyVcczb2srfPC4RZDtSGRyGLPG8jS7lwFmQ1FqmBZUANdwr+XRwP7pT1I
 uu1uBHUzeNF0jHcdJd17LaKWoGMF6O1aoezkPVwiQomt+YNKPpdvOBm1+xZYp68jARVeUIAd2
 OVBsYlWwJP340dONQdzwfzhR03RXTanTD0kI8iCzSof4zF1uGJaf6IN240b/nRM/m1zJyYFIf
 uho62RrqMtPJItxlI5T3RwVhc7KhHLciCu/iHKIxpTMyS4ysWiOQR81hAJN7KjcFEvLmHAhik
 lpOVHsX0qFGOR/z/EK3Tdw9RfoA4YkWcVWA0X09kjp/LsdcUuZemE10BpuUtvXwHbh+VYwIj+
 wO8FlfXj/s7IeuewgW7BVhveHAfSjhzdvjrpZjx1nSlayGVb7p9PqweeraOff4ivCQXwWr9eL
 E2T1qaMp1AQ84yj9Jf1TQr/Uf1fw6wY937wZPs6TqGvArVn6l16I0R2CFEqfDNHM/RmW5n2gr
 gk23HoNAfRlcSxNHKY5iMj8Y+K5TIMq4mHIKB3nj1w5nI=

On Fri, Feb 02, 2024 at 12:50:04PM +0100, Michal Such=E1nek wrote:
>Given the open nature of lore it should be feasible to provide
>additional interfaces on top of it that cater to people used to PRs
>on popular forge web UIs without hijacking the whole project and the
>existing tools and interfaces. For some reason people are set on
>replacing it as a whole, and removing the interfaces they personally
>don't use,

>calling them obosolete.
>
because they positively *are*.

when i started, patch-based code reviews were the norm, and i'm still
using them for my small project with almost no external contributions.

but after working with gerrit code review for over a decade, i find it
mind-boggling that people are still voluntarily subjecting themselves to
mail-based reviews for serious high-volume work.

it doesn't matter just how super-proficient you got with your old tools.
there is just no way you'll get anywhere near as efficient as you would
with the new ones, if you just were interested enough to learn them.
migrating the workflows that are worth keeping isn't such a bit deal.

i'll note that i don't consider github-like forges to be adequate tools
for serious work, as they seem to intentionally discourage producing
polished commits.
the gerrit project is unfortunately not interested in building a proper
forge, but luckily there is a bridge to github (hosted version available
at gerrithub.io).
