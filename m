From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: Re: [PATCH] submodule recursion in git-archive
Date: Wed, 27 Nov 2013 01:28:39 +0100
Message-ID: <52953CB7.8020300@web.de>
References: <2E636B58-47EB-4712-93CA-39E8D1BA3DB9@mac.com>	<5294BB97.7010707@web.de> <xmqqmwkqvmck.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nick Townsend <nick.townsend@mac.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Nov 27 01:28:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VlSzs-0006dV-Bh
	for gcvg-git-2@plane.gmane.org; Wed, 27 Nov 2013 01:28:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751069Ab3K0A2p convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Nov 2013 19:28:45 -0500
Received: from mout.web.de ([212.227.17.12]:50382 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750802Ab3K0A2o (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Nov 2013 19:28:44 -0500
Received: from [192.168.178.26] ([79.250.167.3]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0MAMpq-1VwyVU3NzW-00Be2K for <git@vger.kernel.org>;
 Wed, 27 Nov 2013 01:28:43 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.1.1
In-Reply-To: <xmqqmwkqvmck.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:Dao/V7+dtMMgKw/uSTj3UnXvutr0W+CagZaFG+G1nqe02O5oks4
 6nBPFX2l/96Yt5hhFhknhcJ3hkNEjDgNymkKunOsI0Ow9BopBPU3VIjTdItFdz3g5++nE74
 byZyBKqJlqdBZ3a+RtNVijcsh5weBTUt0y4kw7IE9dJA+NPr6zEL2F8tIvci2jOWBWzbAHI
 SncI067ocROy8+iD5Rgtg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238401>

Am 26.11.2013 23:18, schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>=20
>> Thanks for the patches!  Please send only one per message (the secon=
d
>> one as a reply to the first one, or both as replies to a cover lette=
r),
>> though -- that makes commenting on them much easier.
>>
>> Side note: Documentation/SubmittingPatches doesn't mention that (yet=
),
>> AFAICS.
>=20
> OK, how about doing this then?
>=20
>  Documentation/SubmittingPatches | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/SubmittingPatches b/Documentation/Submitti=
ngPatches
> index 7055576..304b3c0 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -140,7 +140,12 @@ comment on the changes you are submitting.  It i=
s important for
>  a developer to be able to "quote" your changes, using standard
>  e-mail tools, so that they may comment on specific portions of
>  your code.  For this reason, all patches should be submitted
> -"inline".  If your log message (including your name on the
> +"inline".  A patch series that consists of N commits is sent as N
> +separate e-mail messages, or a cover letter message (see below) with
> +N separate e-mail messages, each being a response to the cover
> +letter.
> +
> +If your log message (including your name on the
>  Signed-off-by line) is not writable in ASCII, make sure that
>  you send off a message in the correct encoding.

OK, but the repetition of "cover letter" and "e-mail messages"
irritates me slightly for some reason.  What about the following?

-- >8 --
Subject: [PATCH] SubmittingPatches: document how to handle multiple pat=
ches

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 Documentation/SubmittingPatches |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/Submitting=
Patches
index 7055576..e6d46ed 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -139,8 +139,15 @@ People on the Git mailing list need to be able to =
read and
 comment on the changes you are submitting.  It is important for
 a developer to be able to "quote" your changes, using standard
 e-mail tools, so that they may comment on specific portions of
-your code.  For this reason, all patches should be submitted
-"inline".  If your log message (including your name on the
+your code.  For this reason, each patch should be submitted
+"inline" in a separate message.
+
+Multiple related patches should be grouped into their own e-mail
+thread to help readers find all parts of the series.  To that end,
+send them as replies to either an additional "cover letter" message
+(see below), the first patch, or the respective preceding patch.
+
+If your log message (including your name on the
 Signed-off-by line) is not writable in ASCII, make sure that
 you send off a message in the correct encoding.
=20
--=20
1.7.8
