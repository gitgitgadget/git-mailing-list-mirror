From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] Hint at "checkout -p" in the "reset --patch <type>" error
 message
Date: Thu, 25 Nov 2010 14:10:38 +0100
Message-ID: <4CEE604E.2030208@drmicha.warpmail.net>
References: <AANLkTimc=Dt9YSu=J=7C-f1hZ9UODU7VHu6oD8dmFX3N@mail.gmail.com>	<AANLkTimP9zr=wQDYeBxtvYCE1mZ1aHXQ_nLOxGFfR9YD@mail.gmail.com>	<AANLkTimQ644C-dEoJTj8bNd9y+YzpMez7D1KLZFNEe7c@mail.gmail.com>	<AANLkTindHnjeXEGbKWiQkWgoUBwqZbdx71sQwNr_gFp0@mail.gmail.com>	<AANLkTi=5w3YpYu0_WbmHud0BUkO2BqYNVezWDMkCaSj2@mail.gmail.com>	<AANLkTimEOULR8_PAs5iPu7z+n4DQPSyDKYg8RghZxosz@mail.gmail.com>	<87mxp086k5.fsf_-_@gmail.com>	<20101123145921.GB3145@sigill.intra.peff.net>	<87ipzo83o9.fsf@gmail.com> <4CEE2472.5020901@drmicha.warpmail.net> <m3mxox4qr3.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-2?Q?=A9t=ECp=E1n_N=ECmec?= <stepnem@gmail.com>,
	Jeff King <peff@peff.net>, Jeenu V <jeenuv@gmail.com>,
	knittl <knittl89@googlemail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 25 14:13:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLbdG-0002oR-F1
	for gcvg-git-2@lo.gmane.org; Thu, 25 Nov 2010 14:13:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751594Ab0KYNMp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Nov 2010 08:12:45 -0500
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:55329 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751430Ab0KYNMo (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Nov 2010 08:12:44 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 0B6458FD;
	Thu, 25 Nov 2010 08:12:44 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Thu, 25 Nov 2010 08:12:44 -0500
X-Sasl-enc: CKBcBcuwCo4ryLrUMz2x9Or3UM0XWUERvlb20zxCL0Qj 1290690763
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 1841A402C68;
	Thu, 25 Nov 2010 08:12:42 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.12) Gecko/20101103 Fedora/1.0-0.33.b2pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.6
In-Reply-To: <m3mxox4qr3.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162131>

Jakub Narebski venit, vidit, dixit 25.11.2010 11:56:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
>> =A9t=ECp=E1n N=ECmec venit, vidit, dixit 23.11.2010 16:23:
>>> Jeff King <peff@peff.net> writes:
>>>> On Tue, Nov 23, 2010 at 03:20:58PM +0100, =A9t=ECp=E1n N=ECmec wro=
te:
>>>>
>>>>> diff --git a/builtin/reset.c b/builtin/reset.c
>>>>> index 0037be4..fc530d2 100644
>>>>> --- a/builtin/reset.c
>>>>> +++ b/builtin/reset.c
>>>>> @@ -309,7 +309,8 @@ int cmd_reset(int argc, const char **argv, co=
nst char *prefix)
>>>>> =20
>>>>>  	if (patch_mode) {
>>>>>  		if (reset_type !=3D NONE)
>>>>> -			die("--patch is incompatible with --{hard,mixed,soft}");
>>>>> +			die("--patch is incompatible with --{hard,mixed,soft}\n"
>>>>> +			    "(use \"git checkout -p\" to selectively discard changes =
in working directory)");
>>>>>  		return interactive_reset(rev, argv + i, prefix);
>>>>>  	}
>=20
> [...]
>>
>> The man page for git-reset points at git-checkout already.
>>
>> Until we have a "verbosity level" config across all commands, I don'=
t
>> favor adding a lot of hints to command error messages.
>=20
> Errrr... but we do have "verbosity level" config in the form of
> advice.* configuration variables.

=2E..which is why I wrote "across all commands".

Introducing one config per advice does not scale at all. (Well, it
scales linearly...)

If we want our commands to give advice we need something like
"verbosity=3Dsilent|quiet|moderate|instructive|chatty" working across a=
ll
commands.

Michael
