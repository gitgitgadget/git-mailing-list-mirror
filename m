From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [StGit RFC] Make "stg branch -l" faster by getting all git config information in one call
Date: Thu, 13 Dec 2007 17:39:49 +0100
Message-ID: <878x3yr1ka.fsf@lysator.liu.se>
References: <20071213133653.13925.89254.stgit@krank>
	<b0943d9e0712130604r6daf05d5n7afbadfe23831839@mail.gmail.com>
	<20071213160432.GA30693@diana.vm.bytemark.co.uk>
	<b0943d9e0712130810p35b33e6aj7756b1af1922992b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Karl =?utf-8?Q?Hasselstr=C3=B6m?= <kha@treskal.com>,
	Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 13 17:41:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2r7l-0000iv-OH
	for gcvg-git-2@gmane.org; Thu, 13 Dec 2007 17:41:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754332AbXLMQlA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Dec 2007 11:41:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754212AbXLMQlA
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 11:41:00 -0500
Received: from mail.lysator.liu.se ([130.236.254.3]:45476 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754133AbXLMQlA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Dec 2007 11:41:00 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 82D6E200A1F8;
	Thu, 13 Dec 2007 17:40:58 +0100 (CET)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 10138-01-66; Thu, 13 Dec 2007 17:40:57 +0100 (CET)
Received: from krank (c83-253-242-75.bredband.comhem.se [83.253.242.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 527C2200A299;
	Thu, 13 Dec 2007 17:39:55 +0100 (CET)
Received: by krank (Postfix, from userid 1000)
	id 111447B4077; Thu, 13 Dec 2007 17:39:50 +0100 (CET)
In-Reply-To: <b0943d9e0712130810p35b33e6aj7756b1af1922992b@mail.gmail.com> (Catalin Marinas's message of "Thu\, 13 Dec 2007 16\:10\:10 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68175>

"Catalin Marinas" <catalin.marinas@gmail.com> writes:

> On 13/12/2007, Karl Hasselstr=C3=B6m <kha@treskal.com> wrote:
>> On 2007-12-13 14:04:26 +0000, Catalin Marinas wrote:
>>
>> > On 13/12/2007, David K=C3=A5gedal <davidk@lysator.liu.se> wrote:
>> >
>> > > Maybe someone can help me find a quicker replacement for the
>> > > get_protected call?
>> >
>> > We can have the standard --list command which ignores the protecte=
d
>> > flag
>>
>> Exactly what is the p flag useful for anyway?
>
> It was added so that you don't rebase the stack by mistake. Yann
> suggested to have a specific policy for this and make the protected
> flag freeze the stack completely.

I'd be much more interested in a flag that prevents me from running
"git rebase" on a stg-controlled branch by mistake...

--=20
David K=C3=A5gedal
