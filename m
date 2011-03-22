From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] git-completion: Add git help completion for aliases
Date: Tue, 22 Mar 2011 17:38:58 +0100
Message-ID: <4D88D0A2.7020003@drmicha.warpmail.net>
References: <4D871972.7080008@elegosoft.com> <7vhbawno11.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.1103212302000.1561@bonsai2> <7v4o6vmvzs.fsf@alter.siamese.dyndns.org> <20110322085027.GF14520@neumann> <AANLkTi=zbsNxLSCcWQorZCnRFuDPujqYzW7B0xJx2FHp@mail.gmail.com> <20110322100903.GG14520@neumann> <AANLkTik8BaAJCnCRdDNTdu=nV1Q7cFLiwOuV_4wdXUE6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>,
	Jakob Pfender <jpfender@elegosoft.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, lee.marlow@gmail.com,
	markus.heidelberg@web.de, spearce@spearce.org, bebarino@gmail.com,
	ted@tedpavlic.com, tlikonen@iki.fi, trast@student.ethz.ch
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Tue Mar 22 17:42:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q24fF-0001rU-EV
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 17:42:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755358Ab1CVQmc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Mar 2011 12:42:32 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:38550 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755069Ab1CVQmb (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Mar 2011 12:42:31 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 44FFE20704;
	Tue, 22 Mar 2011 12:42:30 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 22 Mar 2011 12:42:30 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=4AzsNlTAWa3J43ZZN+coryxt8NU=; b=kZYJ+9XQrAQllu3wenq5C/5LGe1ZgkdYRdSV/9NfeI9Ke8MP9/mqz9Kke0ap8tcH3zLoIJ5CncFIdw+60gs4761ZoE1+B02wp9lACUtp90/GgjnrsWwswWALJhTnhuQOXR/TzP/2GQdOps8iTE5f33eMGTtGouu5llSAsLF/LbM=
X-Sasl-enc: HFbKpJSVooigVvPy0MMDcW4lkELTYb+0X3RjInbCdKWZ 1300812149
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 6C3AA446BA8;
	Tue, 22 Mar 2011 12:42:28 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <AANLkTik8BaAJCnCRdDNTdu=nV1Q7cFLiwOuV_4wdXUE6@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169747>

Erik Faye-Lund venit, vidit, dixit 22.03.2011 11:28:
> 2011/3/22 SZEDER G=E1bor <szeder@ira.uka.de>:
>> On Tue, Mar 22, 2011 at 10:16:16AM +0100, Erik Faye-Lund wrote:
>>> 2011/3/22 SZEDER G=E1bor <szeder@ira.uka.de>:
>>>> On Tue, Mar 22, 2011 at 12:53:43AM -0700, Junio C Hamano wrote:
>>>>> This is a constructive tangent but if we are going to run $(__git=
_aliases)
>>>>> every time we run _git_help, perhaps it would want a hack similar=
 to the
>>>>> way the value for $__git_all_commands is generated just once?
>>>>
>>>> I think this is not necessary.  We already run __git_aliases() eve=
ry
>>>> time after 'git <TAB>', and it was not an issue so far.  And indee=
d, I
>>>> just created 50 aliases, and the time required for __git_aliases()
>>>> seems to be negligible:
>>>>
>>>>  $ time __git_aliases
>>>>  <bunch of aliases>
>>>>
>>>>  real    0m0.028s
>>>>  user    0m0.016s
>>>>  sys     0m0.004s
>>>>
>>>
>>> Unfortunately, the situation is not quite so good on Windows:
>>> $ time __git_aliases
>>> <bunch of aliases>
>>>
>>> real    0m0.112s
>>> user    0m0.030s
>>> sys     0m0.015s
>>>
>>> This is with 50 aliases, with 0 aliases I get this:
>>> $ time __git_aliases
>>> test
>>>
>>> real    0m0.063s
>>> user    0m0.015s
>>> sys     0m0.015s
>>
>> I see.  However, on Windows everything git-related tends to be slow,
>> so this is nothing new.
>=20
> That's not the case. Every thing Git-related isn't slow on Windows,
> but there are some things in Git that is.
>=20
>> The question is whether the slowness of a known slow platform would
>> justify the regression on all platforms.
>>
>=20
> Windows isn't slow. Get over this way of thinking, it's just wrong.
> Windows has some different performance characteristics for some
> operations than e.g Linux, but saying that it's slow is just wrong.
> However, _Bash for Windows_ is quite slow, much due to Windows' lack
> of fork(), which means that some very involved emulation needs to be
> performed.
>=20
> But even so, at least 25% of the git user base is on Windows,
> according to the latest Git User Survey. That makes this stuff matter=
=2E

[Disclaimer: No, I don't like Win nor MS, but:]

Exactly, and the attitude which you criticise is a self-fulling prophec=
y
if one follows it. We may break (or make things worse for) Git on
Windows accidentally (because the percentage among developers is low),
but should never do so knowingly. And we may even try and watch out for
things which may be troublesome for Git on Win, and consult with our
brave Git on Win developers.

Michael
