From: =?UTF-8?B?IlBldGVyIFZhbGRlbWFyIE3DuHJjaCAoTGlzdHMpIg==?= 
	<4ux6as402@sneakemail.com>
Subject: Re: How to fix (and find) many git-* --check errors?
Date: Sat, 09 Aug 2008 09:28:59 +0200
Message-ID: <489D473B.3090406@sneakemail.com>
References: <489C40BC.8000008@sneakemail.com> <7viqubcnop.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 09 09:30:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRitv-0004Hy-I1
	for gcvg-git-2@gmane.org; Sat, 09 Aug 2008 09:30:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752850AbYHIH3E convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 Aug 2008 03:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753215AbYHIH3E
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Aug 2008 03:29:04 -0400
Received: from morch.com ([193.58.255.207]:50044 "EHLO morch.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752819AbYHIH3D (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Aug 2008 03:29:03 -0400
Received: from [192.168.1.214] (ANice-157-1-71-161.w90-36.abo.wanadoo.fr [90.36.206.161])
	by morch.com (Postfix) with ESMTP id 11F9D290D
	for <git@vger.kernel.org>; Sat,  9 Aug 2008 09:31:34 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080724)
In-Reply-To: <7viqubcnop.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91747>

Junio C Hamano gitster-at-pobox.com |Lists| wrote:
> Starting from a clean checkout, you could do something like this:
>=20
> 	$ git reset --hard
>         $ rm .git/index
>         $ git diff --binary -R HEAD >P.diff
>         $ git apply --whitespace=3Dfix --cached <P.diff
> 	$ git commit -m "Fixed all whitespace gotchas"
>=20
> P.diff contains essentially everything, and you are recreating everyt=
hing
> from that patch.

Thanks for taking the time to answer my many mails and questions. It=20
really is helpful to me.

Rambling on:

Scary with the "rm .git/index"! It bascially creates an empty index it=20
seems... That was news to me. As a newbie I try not to meddle too much=20
in .git/ ...

I tried the above on git.git, and it gave:
warning: 485 lines applied after fixing whitespace errors.

I would suggest finishing the above with:
$ git checkout HEAD
otherwise, the working dir is stuck at the old unfixed state.

But like I posted earlier, I have another solution that works on=20
selected files. With git, there is always more than one way to do=20
things, it seems...

Peter
--=20
Peter Valdemar M=C3=B8rch
http://www.morch.com
