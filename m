Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FAA3859CF;
	Tue, 10 Feb 2026 15:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770738865; cv=none; b=gJEVeWAaOyvH6KZj0mThqYMDzcNYFQda+RjTgMf/xQG6KJWJIsoLS45azJXKunftnGrulkYDE1DF3KEuPn9QCYb9Ueb+1Wvp/we0vrk4vTgnHvYoE+uK4D6p/mL2UO2q1c4d/FnZhEoBy8JvxA53Jxnuj9/qQlZZHVUt4WPqq14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770738865; c=relaxed/simple;
	bh=6kAmUcfLDGkZjA28/PZm9IIn4e0YDH0tVCnss/Bnbiw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=PhIY/edLb0w9OTsryueTd3rRUy7zNjFHcKpXbg0RkcCzij1q28f6nNdHf1G3Nv61axR/9g7jK/HT0dJtbGEjHjjrePY+MWJqDFY2F3pxZELyHAR8tx734SzZ52wCMeb14R39nWroWTcxCk765P8Dxg1R+albvyk0hGPcwCPjiOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=If8VY50X; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uBl2AbQ9; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="If8VY50X";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uBl2AbQ9"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 468C71D0012E;
	Tue, 10 Feb 2026 10:54:23 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Tue, 10 Feb 2026 10:54:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770738863;
	 x=1770825263; bh=xb2p9GuhyCbyLt1bmZiSREEZz+c4GAoQEZDpN2kDumI=; b=
	If8VY50XabWRl6lWvxHTgVsfQMEYewNn05aA6+LA0j2VlzGLlnb01MYobmISpOAV
	0h7iDgAxpsBi1+YFz5Sw8Af/y+rIF6SniLFDniOkgipkYFWseTDBFN2oKGFwYDol
	zCZdvSXcCfYPcWakkiXjpQhSZT7bq5pmRmLktd1FJzicLjePwfojk/uXVvRuZrTx
	9k5hnotSGQHMfZ+3wT5pxKlLD+aCfsBI0r1b+4tzsfMYHoQqw6hIeFVhBVx2FelL
	gwydeFIcEu5zWnDAo9qjcbcxW+b33TG/JGdLVjLnzQVuAbX2z2yR3QB0gibA6CKJ
	XRtksAmwl76rboxaQ1lNiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770738863; x=
	1770825263; bh=xb2p9GuhyCbyLt1bmZiSREEZz+c4GAoQEZDpN2kDumI=; b=u
	Bl2AbQ9BcwP7uwraMHchKL01a57DisY2vH0TSQxPmc8Kd5rORCpqs+p6UygG80XR
	smWBayutTV+0WJtl9Rub8xuwWfnKT25NI6fr+wQZ8dJUwrvihlJpIFxFDR77NJPy
	TEB0ES005y/cb67sdIRO5Fux/XmhQ9HyaqsflB9L/i/FZD6Ko63CvC1dPkmJAzC6
	J1Zcse4ehdaOuUD//NklypiFw2LZGJkNCFqwETX9DJCfOLiXuF7RkfmWrJwnpei5
	U5FpWnGZQOju2I01aTTWyWYmaZSk5cr6ufiTVfOfRLmokKx56KQDyCnzUNId1nwV
	wdV0v4yM0OqoTDP1E7SGA==
X-ME-Sender: <xms:rlSLab-SrnYrnIldiwT38z9XAfnPWnS_LI_sM2VeyfQvsTBgmWy8zN0>
    <xme:rlSLaSjpziU4_xEqan1Sk7shzM4-txY7tJ4cqxfEEo3X3LuI56-VBbnvfPAyVYAqD
    SetjFJTG20JyNepxHMgQ_aPYs5sHuJ4IxCsz_jVNykMUfp0v1X12Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtddttdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvvefkjghfufgtgfesthhqre
    dtredtjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceo
    khhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpeeifeetgedvieeggefhheevtdfgkeeiffdtuefhudejvdejhfef
    leevvddtheegveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhnohhprhgvfhhigi
    drihhtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    khhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsg
    gprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrlhigsehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehnrggsihhjrggtiihlvgifvghlihesnhgrsg
    hijhgrtgiilhgvfigvlhhirdighiiipdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgv
    thdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eplhhinhhugidqmhgrnhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:rlSLaaKEJUrxQls0m-ti4D4tCntvUrU42ikrh0N0ViPD9vwqVGP9Zw>
    <xmx:rlSLabFedwxim-HkXwqMjgIxygQuDzFpbKB2Ys0XTnxX88HexO_v8w>
    <xmx:rlSLaWSfS61TRd9SJnii6UEB2VeAft5O5q_wbmrtrPsG5U-fDad6ig>
    <xmx:rlSLaff2B1q9qXMf0PnM1HCpwbPOOB9xnJrRziE3O_eEj0Zmofpojw>
    <xmx:r1SLac7QtjGaYDkJp1WfkjVQfDF3e8qYXsTBKZkd0yA86DLOJL01B1Tv>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B375F1EA006B; Tue, 10 Feb 2026 10:54:22 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AsV1kM-kUU5c
Date: Tue, 10 Feb 2026 16:54:02 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Alejandro Colomar" <alx@kernel.org>, git@vger.kernel.org,
 =?UTF-8?Q?=D0=BD=D0=B0=D0=B1?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: linux-man@vger.kernel.org, "Jeff King" <peff@peff.net>
Message-Id: <55bd6ad3-cd19-4839-a808-eceae802d3c8@app.fastmail.com>
In-Reply-To: <aYtAknObJpjszCaj@devuan>
References: 
 <jpyv367v4jdxfxebxw6wh7rgqdfeswzp44dzsycfjt5k2pxe4j@tarta.nabijaczleweli.xyz>
 <se6hm5gnd7cyjsby5q6pctkrws5ecp5gpnfjuy3zh2shd2abyj@tarta.nabijaczleweli.xyz>
 <aYpg1XelZBzpw4ZL@devuan>
 <rqshygydxwpfs2mi5cwxl3wvztgctj3nvu3y5bpo5s32owucna@tarta.nabijaczleweli.xyz>
 <aYtAknObJpjszCaj@devuan>
Subject: Re: [PATCH v2] futex_waitv.2: new page
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 10, 2026, at 15:30, Alejandro Colomar wrote:
> Hi!
>
> On 2026-02-10T15:17:55+0100, =D0=BD=D0=B0=D0=B1 wrote:
>> Hi!
>>
>> On Mon, Feb 09, 2026 at 11:35:53PM +0100, Alejandro Colomar wrote:
>> > On 2026-02-07T23:00:49+0100, =D0=BD=D0=B0=D0=B1 wrote:
>> > > Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczl=
eweli.xyz>
>> >
>> > For some reason, the patch doesn't want to apply.  I don't see anyt=
hing
>> > obviously wrong, so it may be an issue in my side?
>> >
>> > 	Applying: futex_waitv.2: new page
>> > 	error: affected file 'man2/futex_waitv.2' is beyond a symbolic link
>> > 	error: man7/futex.7: does not exist in index
>> > 	Patch failed at 0001 futex_waitv.2: new page
>> > 	hint: Use 'git am --show-current-patch=3Ddiff' to see the failed p=
atch
>> > 	hint: When you have resolved this problem, run "git am --continue".
>> > 	hint: If you prefer to skip this patch, run "git am --skip" instea=
d.
>> > 	hint: To restore the original branch and stop patching, run "git a=
m --abort".
>> > 	hint: Disable this message with "git config set advice.mergeConfli=
ct false"
>> > 	Press any key to continue...
>>
>> Hm, I did recently set
>>   $ git config diff.noprefix
>>   true
>> I didn't expect this to affect format-patch diffs
>> (since it doesn't affect diffs shown by git add -p),
>> or, if it did, I expected the designated consumer of format-patch
>> diffs (am) to understand this. perhaps not;
>> maybe -p0 to git am?
>>
>> A quick search yields
>>   https://lore.kernel.org/git/xmqqy1o5op1i.fsf@gitster.g/t/#eaa0323ec=
4eed441b37caf96e1b136529b298dbac
>> where you're in the thread and the maintainer says "queued" for a pat=
ch
>> that would ignore noprefix for format-patch for this reason precisely.
>> But clearly not, since my patches were with noprefix=3Dtrue and came =
out -p0.
>
> Oh, that bites again!
>
> Junio, do you still have this queued?
> <https://lore.kernel.org/git/xmqqy1o5op1i.fsf@gitster.g/t/#m6f42ff4f0c=
b2d6dd1d68f12a533d04c822b68a80>

See 15108de2 (Merge branch 'jk/format-patch-ignore-noprefix',
2023-03-21).

An aside but `format.noprefix` is not a boolean like `diff.noprefix`.
It will be enabled with any value.

Is it standard to indicate this with the existing =E2=80=9CIf set,=E2=80=
=9D, perhaps? Or
should it say =E2=80=9Cenabled with any value=E2=80=9D?

(+Cc Peff)

    format.noprefix::
            If set, do not show any source or destination prefix in patc=
hes.
            This is equivalent to the `diff.noprefix` option used by `git
            diff` (but which is not respected by `format-patch`). Note t=
hat
            by setting this, the receiver of any patches you generate wi=
ll
            have to apply them using the `-p0` option.
