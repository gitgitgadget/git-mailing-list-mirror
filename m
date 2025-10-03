Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBAB33E1
	for <git@vger.kernel.org>; Fri,  3 Oct 2025 19:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759518336; cv=none; b=O5zOPOgh49hzyxzTerf/V7bZWdzZphJS9X3M+QeVYC8Zw9lSVrxM21pjs2Mm+0+4Y/WbtHIAL5s2EuIvoQHfL/U7V7xS7AAn0iT6ZRU2oqq7htGqwuhG9iPYhftSVsjK3jeZPZtc2BXCK5eDpVuUoX00VU0Bw4nNqr30+TpandE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759518336; c=relaxed/simple;
	bh=yp8ieGdGVZfJWGpMfmFl8r8Swiq0jzw1gAKnnVbz95w=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=nCv9/6mlgpsRw1MiBzCDIaeykSXet4gz1hDlFge7M7bkb1NpR+IaUQ/aG/Bbxnc0LVLcYUfSRgeqCrtavFXtgGv7O+fEw0ut5kHGvZ1c7pWLsGYeNueumkhR8NA4jsIWrGp9Zlcl5Fdab7YX0LlcTmBdgVkjgUKv3y5iLJo8NEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=akEUrm90; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pDMDLpjk; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="akEUrm90";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pDMDLpjk"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id ABDD7EC00CD;
	Fri,  3 Oct 2025 15:05:32 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Fri, 03 Oct 2025 15:05:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1759518332; x=1759604732; bh=ffpHS5XuQ0uFgvVoli+Ye08sYh8+8T7b
	ckovOkqaZFI=; b=akEUrm908LhS55tWWmVXnK5RFxEehpGzDT0CmeZcPOSMx0Yl
	o0eWqaDfnW4CYJ8L5tTo7zsD8HMOAt74UjmycmjWKoho0/+KQ99HmYnlkZS3X2fD
	DaDYAwwwg71TuVA6e36FgxMqO/DNW+YTjUq1yCYCic+fagt89cRV4q80oUgHJnb2
	ZUUoAYUu4iW4S4ldlqT1FUpmsBArlg6oyn+v9O8lc83Esew32Gjuz0LFpnRqyzYT
	iSWv/hRuYymNNlnXUUfVReKNs8n6gZHqcU3PAgfOlXLpbp5NvkKXyKr0mNqmXEFy
	n0dCfq6zjuVjjzNDERIFOMbQsLIrMvZzZFDKxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759518332; x=
	1759604732; bh=ffpHS5XuQ0uFgvVoli+Ye08sYh8+8T7bckovOkqaZFI=; b=p
	DMDLpjkgttobF0L9h8UUzh7kbgQjM798jOQdawtQjitaMo1X4fAKCSc3UvIk8OKE
	onRgBGQXt7SzcQSCZtfoyjilP1NpnBw29YbYdF0LPoAb3pL3ZjdsUHepXrT65SoN
	nEe0oIrnvuSkYym1fcm/TpbP+uX4ZCeOzVbK95JpMOZWJoz+cfC+72DFEqexhsc4
	Z74vaOJl+4A8Kv7un3C5ULPvTw1DJQVK3H1pNNNIsdJ2gY4Tet9A8Bgdz9vNc30S
	bLVMJTSqqkDy1Bz0Cr8Kp3mkSEySdcKkZri4aLJ0f/lnvPCzaX5G7lPwuumSrSl7
	Vpeksmy6AgHD75nseKiMw==
X-ME-Sender: <xms:fB7gaA1V8D2QHCmptLqmVWvuhnmnmnOD9qwoTHC4YVnYnYURRnfh3UQ>
    <xme:fB7gaF64SNX0ZO4oHCbls6ceW5s14BD3yGXMzwzzXnql9UyPBJmXgOikz5F-h5BZD
    J67N9YjKFUVaDRxSi0AI-YDOUgGsLIuhsprBnkfe4zXcDM0aPMa9VY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekleeilecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrghkkhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpeefteeghfegfeevleeguddvkeetheeiveffudej
    lefgudffffejleffffeludekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdpnhgspghr
    tghpthhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegthhhrihhsth
    hirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehjlhhtohgslhgv
    rhesghhmrghilhdrtghomhdprhgtphhtthhopehjohhhnhgtrghikeeisehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgt
    phhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehrhigsrghkrd
    grrdhvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhiugguhhgrrhhthhgrshhthhgr
    nhgrfedusehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhih
    hnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhm
X-ME-Proxy: <xmx:fB7gaIYJ6QUOlE_1Vg2kUp2ooaWqOtNEu0d9bK09WWFdVGbS3GjHRQ>
    <xmx:fB7gaE-v_RD8lJIYexqeHYsA3SRKI4f-W00cTahCJ1GdF4N940aQww>
    <xmx:fB7gaCM144x9U4aQTy4m2s4knwUemIQ13PX_5Cnz4Gw8c05Rscuvcw>
    <xmx:fB7gaJHjvZ9i3IbMB0_VBbYjA5nuSN-DNan9J66lPieZj34JCSKTRA>
    <xmx:fB7gaKf1BNYObl-saPq5BEFvgdwsPzM4A-nkbcTyBvOKFwOcQNs7Nmki>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id EC8631EA006B; Fri,  3 Oct 2025 15:05:31 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AzP7wyaVJMbJ
Date: Fri, 03 Oct 2025 21:05:11 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Siddharth Asthana" <siddharthasthana31@gmail.com>, git@vger.kernel.org
Cc: "Junio C Hamano" <gitster@pobox.com>,
 "Christian Couder" <christian.couder@gmail.com>,
 "Patrick Steinhardt" <ps@pks.im>, "Elijah Newren" <newren@gmail.com>,
 "Andrei Rybak" <rybak.a.v@gmail.com>,
 "Karthik Nayak" <karthik.188@gmail.com>,
 "Justin Tobler" <jltobler@gmail.com>, "Toon Claes" <toon@iotcl.com>,
 "John Cai" <johncai86@gmail.com>,
 "Johannes Schindelin" <johannes.schindelin@gmx.de>
Message-Id: <6d19a0c4-f000-43f5-b2e1-f84f341063a9@app.fastmail.com>
In-Reply-To: <61107972-5755-49b9-a126-9442418ddff0@gmail.com>
References: <20250908043620.57848-1-siddharthasthana31@gmail.com>
 <20250926230838.35870-1-siddharthasthana31@gmail.com>
 <f0abdc27-6850-4b9d-b4eb-a1c92f731142@app.fastmail.com>
 <61107972-5755-49b9-a126-9442418ddff0@gmail.com>
Subject: Re: [PATCH v2 0/1] replay: make atomic ref updates the default behavior
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Good evening Siddharth

On Fri, Oct 3, 2025, at 01:36, Siddharth Asthana wrote:
> On 02/10/25 22:44, Kristoffer Haugsbakk wrote:
>>> [snip]
>> On the topic of changing experimental commands: I really like the
>> git-for-each-ref(1) (git-FER) output format design.  It just outputs =
refs and
>> related data.  It=E2=80=99s not a command for =E2=80=9Cbulk delete re=
fs=E2=80=9D or =E2=80=9Ccheck for
>> merge conflicts between these refs and upstream (git-merge-tree(1)=E2=
=80=9D=E2=80=94it
>> just supports all of that through `--format` and its atoms.
>>
>> And for this command it seems to, at the core, output a mapping from =
old
>> to new commits.
>>
>> Now, I=E2=80=99ve thought that a =E2=80=9Cclient-side=E2=80=9D[1] in-=
memory rebase-like command
>> would need to support outputting data for the `post-rewrite` hook.  A=
nd
>> is that not straightforward if you can use `--format` with `from` and
>> `to` atoms?  (I ask because I have never called hooks with git-hook(1=
).)
>>
>> I just think that (naively maybe) a `--format` command like git-FER w=
ith
>> all the quoting modes might be a good fit for this command.  Then you
>> can compose all the steps you need yourself:
>>
>> 1. Call the exact git-update-ref(1) `--batch`/`--stdin` or whatever m=
ode
>>     you need
>> 2. Write a message to each reflog if you want
>> 3. Call the `post-rewrite` hook
>>
>> =E2=80=A0 1: c.f. server-side which I get the impression only wants t=
o do cheap
>>       rebases
>
>
> Hi Kristoffer,
>
> That's an interesting perspective on using --format for composability,
> similar to git-for-each-ref's design.
>
> The constraint right now is that git replay's output needs to work
> directly with update-ref --stdin, which has a specific format. Adding
> --format would let users customize the output, but then they'd need to
> transform it to the update-ref format anyway for the most common case,
> which seems like extra work.

git-FER has a default format and could still use that (either the
current one or your proposal).

git-replay(1) could also concievably support ready-made formats, similar
to =E2=80=9Cpretty=E2=80=9D formats that git-log(1) & co.

> Your point about post-rewrite hook support is well-taken though. As th=
is
> command evolves toward client-side interactive rebase (which was Elija=
h's
> original design goal), we will definitely need hook integration. At th=
at
> point, a --format approach with atoms like %(old) and %(new) could make
> sense for letting users extract the commit mapping in whatever form th=
ey
> need for hooks or other tooling.
>
> For this iteration I am focusing on the simpler atomic update case, but
> I will
> keep the --format idea in mind for future work.
>
> [replying to this part
>
> Do you see a specific use case right now where --format would help, or
> is this more about future-proofing the design for when we add
> client-side features?

I have been using git-rebase(1) for a while with a post-rewrite script.
This is used for interactive rebases but also just keeping up with
upstream, i.e. a regular rebase.  Then I was idly thinking that
git-replay(1) would be faster for the plain rebase case=E2=80=94but it d=
oesn=E2=80=99t
support that hook directly.  Okay, but I can get around that: I can
parse the output, yank the commit OIDs, and run git-rev-list(1) on both
of them to get the mapping I want.  But it would be really nice to just
declare the correct post-rewrite format and be done, without having to
parse anything. :)

Beyond that though I=E2=80=99ve been thinking about more hypothetical =E2=
=80=9Cclient-
side=E2=80=9D concerns.  I mentioned writing to the reflog.  I imagine t=
hat
server programs that just want to be able to efficiently =E2=80=9Crebase=
=E2=80=9D
branches to the upstream don=E2=80=99t need that.  But client-side progr=
ams
might want to write to the reflog because they want to mark what the
update is for; you could have many kinds of client-side =E2=80=9Cupdate =
ref=E2=80=9D
programs and want to leave breadcrumbs about what was done.  There is
more experimentation.  Whereas I imagine that a forge has maybe a small
set of =E2=80=9Cupdate branch=E2=80=9D commands.  I don=E2=80=99t know, =
maybe I=E2=80=99m rambling at
this point.

> Thanks for the thoughtful feedback!

Thanks for the consideration and reply!
