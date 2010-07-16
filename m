From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Find successor of common ancestor
Date: Fri, 16 Jul 2010 14:29:21 +0200
Message-ID: <m2aaprr4ny.fsf@igel.home>
References: <20100716082937.GA22894@nibiru.local>
	<AANLkTintIToGZu3fvK4aE5LFL7MgOnlfwKgsZ79Q0-o1@mail.gmail.com>
	<20100716090613.GB22894@nibiru.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: weigelt@metux.de
X-From: git-owner@vger.kernel.org Fri Jul 16 14:29:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZk34-0006Jy-T2
	for gcvg-git-2@lo.gmane.org; Fri, 16 Jul 2010 14:29:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965361Ab0GPM30 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Jul 2010 08:29:26 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:37928 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965356Ab0GPM3Y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jul 2010 08:29:24 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 00B411C001C6;
	Fri, 16 Jul 2010 14:29:22 +0200 (CEST)
Received: from igel.home (ppp-88-217-114-100.dynamic.mnet-online.de [88.217.114.100])
	by mail.mnet-online.de (Postfix) with ESMTP id 8158D1C001A4;
	Fri, 16 Jul 2010 14:29:22 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 1FFA2CA297; Fri, 16 Jul 2010 14:29:22 +0200 (CEST)
X-Yow: OKAY!!  Turn on the sound ONLY for TRYNEL CARPETING,
 FULLY-EQUIPPED R.V.'S and FLOATATION SYSTEMS!!
In-Reply-To: <20100716090613.GB22894@nibiru.local> (Enrico Weigelt's message
	of "Fri, 16 Jul 2010 11:06:13 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151149>

Enrico Weigelt <weigelt@metux.de> writes:

> * Santi B=C3=A9jar <santi@agolina.net> wrote:
>> On Fri, Jul 16, 2010 at 10:29 AM, Enrico Weigelt <weigelt@metux.de> =
wrote:
>> >
>> > Hi folks,
>> >
>> >
>> > suppose the following situation:
>> >
>> > I've forked some branch A into B, now A and B have evolved
>> > independently for quite some time into A' and B'. Now I'd like
>> > to rebase B' along A' history line step by step - first on A+1,
>> > then A+3, ... until A' (that's what I'd call zip-rebase).
>>=20
>> This is just what "git rebase"  does:
>>=20
>> $ git checkout B'
>> $ git rebase A'
>
> Yes, but I need to find out A+1 for my zip-rebase.

git rev-list [--first-parent] A..A' | tac |
while read rev; do git rebase $rev; done

Andreas.

--=20
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint =3D 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4=
ED5
"And now for something completely different."
