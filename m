From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git diff: add option for omitting the contents of deletes
Date: Mon, 28 Feb 2011 17:10:06 +0100
Message-ID: <4D6BC8DE.1090402@drmicha.warpmail.net>
References: <AANLkTi=++gcw5CDQnTRbhUGkvWc9Zm+Ct4Zm5oGGYKUh@mail.gmail.com>	<7vk4gm7dz3.fsf@alter.siamese.dyndns.org>	<4D6A6291.8050206@drmicha.warpmail.net>	<7v7hclulz0.fsf@alter.siamese.dyndns.org>	<7v39n9uldp.fsf@alter.siamese.dyndns.org> <AANLkTim-vyWhgmFuewbd5e5iJiTC-EHz7g=efr2Sz-RH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: =?ISO-8859-1?Q?Mart_S=F5mermaa?= <mrts.pydev@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 28 17:13:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pu5j6-0007A3-UF
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 17:13:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752144Ab1B1QNc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Feb 2011 11:13:32 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:49667 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751618Ab1B1QNb (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Feb 2011 11:13:31 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id EEDB520659;
	Mon, 28 Feb 2011 11:13:30 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Mon, 28 Feb 2011 11:13:30 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=vtTnPNRktKDm7AULKnRnV8yojoE=; b=tAIOS9vc6KIL1nPbQSFvxQUHUJpR9v2X3u1I1JpAYYOT2WoBLoVXhBQA3sdorbIFGjszIcsStC9Unk5nSKzAkTvsd7JsoNfdV+sILzkIezy2f9kvL7SsC7Wca/12QjfTRS/TiF8HimLweE+VVEQkKQfk7yKBg3UgmBoCRiF6qs8=
X-Sasl-enc: DK64XXFmUyTi6GD9g4UFjCW7IU8ff2cDR5CgFS1b2jHm 1298909610
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 25F81404EC0;
	Mon, 28 Feb 2011 11:13:30 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <AANLkTim-vyWhgmFuewbd5e5iJiTC-EHz7g=efr2Sz-RH@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168117>

Mart S=F5mermaa venit, vidit, dixit 28.02.2011 11:45:
> Why not just make it reversible then?
>=20
> $ git diff -M
> diff --git a/foo b/bar
> similarity index 100%
> rename from foo
> rename to bar
>=20
> is nonreversible without git already (i.e. does not work with plain
> patch AFAIK).

That "i.e." is a misunderstanding:

I'm sure Junio meant that "git apply -R" should make sense on a path
like that.

You can easily undo (reverse) a rename without knowing the file
contents; undeleting a file is more difficult :)

> Adding
>=20
> $ git diff -D
> diff --git a/foo b/foo
> deleted file mode 100644
> delete foo
>=20
> would be neither less nor more reversible -- it would also only work
> with git apply
> (assuming that apply is amended accordingly).

To reverse it, we would need the sah1 lines, and the repo would need
that blob.

> Cognitive burdens aside, the "delete foo" output is both
> more explicit and shorter anyway. Occam's razor FTW :)!

Yes.

> Junio, I won't push this further, so it's a final call -- if you give=
 -1,
> then let -D fall to the colourless abyss of oblivion :), if +1 or +0,
> I'll see if I can come up with a patch.

You can always submit a patch, and you can never know what happens ;)

> Best regards,
> MS

Uhm, and please don't do that top post thing and the cc culling.
Readding J&J.

[quote snipped]
