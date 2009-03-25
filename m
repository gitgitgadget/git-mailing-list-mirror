From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: reverting initial commit
Date: Wed, 25 Mar 2009 20:45:19 +0100
Message-ID: <gqe1kf$pg1$1@ger.gmane.org>
References: <49CA7428.70400@obry.net> <7v1vsl4fxo.fsf@gitster.siamese.dyndns.org> <8c9a060903251133x33749041oc2a5152097da0ae8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 25 20:47:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmZ4T-0004b3-S7
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 20:47:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753716AbZCYTpd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Mar 2009 15:45:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754858AbZCYTpd
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 15:45:33 -0400
Received: from main.gmane.org ([80.91.229.2]:52644 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752655AbZCYTpc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 15:45:32 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LmZ2X-0006RN-Cz
	for git@vger.kernel.org; Wed, 25 Mar 2009 19:45:29 +0000
Received: from 94.37.23.227 ([94.37.23.227])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 25 Mar 2009 19:45:29 +0000
Received: from giuseppe.bilotta by 94.37.23.227 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 25 Mar 2009 19:45:29 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 94.37.23.227
User-Agent: KNode/0.10.9
X-Face: ::w9}R^l{WGM\{y)C0QF@4^U,',W3Mk^X0HP)=:bKM^Z]A9+6bY6fe3}O*]fH{l<j1/9RTp  `KR0idy]Im#9^%}P5Dga'>AViT_'?&>&ufo2_X5Vs3C^tPO@drZRuu&6iK}x}~9`F\-dNZ>(p|V7`4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114654>

On Wednesday 25 March 2009 19:33, Jacob Helwig wrote:
> On Wed, Mar 25, 2009 at 11:26, Junio C Hamano <gitster@pobox.com> wro=
te:
>>
>> That's not even an revert. =C2=A0Can't you simply amend it away?
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ git rm not-this-file
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ git commit --amend
>=20
> This is obviously the easier way.  (Or a rebase --interactive)

Actually, rebase --interactive cannot be used to amend the first commit=
=2E
This is something that has hit me a couple of times when I realised, af=
ter
the second or third commit, that I needed to fix the first one. I found
the fastest way in this case to be to just format-patch all but the fir=
st
commit, reset --hard to the first commit, amend, and git am what I form=
at-
patched.

I wish there was a way to tell rebase -i to go back to the first commit=
,
inclusive, but the two or three times I've tried hacking at it I never
managed to come to anything useful 8-/

--=20
Giuseppe "Oblomov" Bilotta
