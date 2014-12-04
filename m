From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Enhancement Request: "locale" git option
Date: Thu, 04 Dec 2014 17:12:40 +0100
Message-ID: <548087F8.1030103@drmicha.warpmail.net>
References: <54801C39020000A1000182FA@gwsmtp1.uni-regensburg.de> <54801B50.4080500@web.de> <20141204095557.GE27455@peff.net> <CACBZZX4Rin6jj2viTUmdpEqLb9TWnMf+p_vRF8BbLrTWFDcp3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>,
	Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 04 17:12:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwZ1L-0007vJ-Rm
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 17:12:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932584AbaLDQMn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Dec 2014 11:12:43 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:37276 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932466AbaLDQMm (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Dec 2014 11:12:42 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id F13A420DBB
	for <git@vger.kernel.org>; Thu,  4 Dec 2014 11:12:41 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute5.internal (MEProxy); Thu, 04 Dec 2014 11:12:41 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:cc:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=8GIudJGCtw0ENpqXPR4kum
	p99z4=; b=OzEvyqeS4PJOnCTdvyJKSkEdO3Mqd0SGfD8AYqxZm8tRnq9UeG0g5w
	YiyQnKNwJi5F2sPvqDJAw09v6wSFk2g17acz4pPzQVFS+m9vRMFXvJaA7R5uubzS
	PBNaK/7SC9OysCcC375vOu6A3VammyYLlpptZxkZRIPuNI0xzdAmU=
X-Sasl-enc: gHguwbvv5klVbCUQoQ/iM290MGdyQHmf3lrNNOP9t96c 1417709561
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 367C668019E;
	Thu,  4 Dec 2014 11:12:41 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <CACBZZX4Rin6jj2viTUmdpEqLb9TWnMf+p_vRF8BbLrTWFDcp3A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260764>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason schrieb am 04.12.2014 um 16:49:
> On Thu, Dec 4, 2014 at 10:55 AM, Jeff King <peff@peff.net> wrote:
>> On Thu, Dec 04, 2014 at 09:29:04AM +0100, Torsten B=C3=B6gershausen =
wrote:
>>
>>> How about
>>> alias git=3D'LANGUAGE=3Dde_DE.UTF-8 git'
>>> in your ~/.profile ?
>>> (Of course you need to change de to the language you want )
>>
>> Besides being awkward in scripts (which will not respect the alias a=
nd
>> use a different language!), that variable will also be inherited by
>> programs git spawns. So the editor, for example, may end up in the w=
rong
>> language.
>>
>> I think respecting core.locale would make sense (probably the change
>> would go into git_setup_gettext(), but you may have to fight with th=
e
>> setup code over looking at config so early in the process).
>=20
> I think we should just stick to the standard *nix way of doing this:
> Tell people to set their locale in their environment.
>=20
> If someone's having this issue it's also happening for all the
> binutils, and any other command-line and GUI program they use, unless
> they override using the standard way of doing so, by setting the
> relevant LC_* environment variables.
>=20
> If you want Git in English then create an alias to override its local=
e
> to be C, if you want the editor it spawns to be in some other languag=
e
> alias that to something that explicitly sets LC_* for that editor.
>=20
> Maybe I'm being overzealous about this (especially with the "I
> implemented this" blinders on), but let's not have Git set the
> precedent for other *nix programs that they all should come up with
> some custom way to override locales, that's something to be done at
> the OS locale library level, which we use.
>=20
>> However, I think the original question is not one of localizing git,=
 but
>> rather of having it _not_ localized (avoiding the German translation=
s).
>> There is a hack you can do that for that, which is to set
>> GIT_TEXTDOMAINDIR to something nonsensical (like "/"), which will me=
an
>> git cannot find the .po files, and just uses the builtin messages.
>=20
> You can, but the fact that that works is an internal implementation
> detail we shouldn't document or support.
>=20

The main issue at hand is really that we have localised git but not its
man pages. Even if you understand English, the man pages don't help you
at all if you can't connect the technical terms used there to their
localised counterparts in git's messages. (NO_GETTEXT=3Dy is my solutio=
n.)

That is one of the many reasons why I proposed to have a dictionary of
the main technical terms for each language before we even localise git
in that language. In an ideal word, we would provide a simple solution
for looking these terms up both ways. I don't think we're going to have
localised man pages any time soon, are we?

Michael
