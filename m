From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: What's in git.git (stable)
Date: Sun, 04 Feb 2007 23:25:22 +0100
Message-ID: <87bqk9ftm5.fsf@morpheus.local>
References: <7v7iv2soxv.fsf@assigned-by-dhcp.cox.net> <7vps8qtgbm.fsf@assigned-by-dhcp.cox.net> <20070204185144.GB24368@coredump.intra.peff.net> <Pine.LNX.4.64.0702041111010.8424@woody.linux-foundation.org> <20070204205858.GE12943@thunk.org> <eq5jdt$173$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: jnareb@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 04 23:25:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDpnz-0002Md-Ax
	for gcvg-git@gmane.org; Sun, 04 Feb 2007 23:25:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752577AbXBDWZq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 4 Feb 2007 17:25:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752578AbXBDWZq
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Feb 2007 17:25:46 -0500
Received: from main.gmane.org ([80.91.229.2]:57485 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752577AbXBDWZp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Feb 2007 17:25:45 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HDpnk-0005gG-Or
	for git@vger.kernel.org; Sun, 04 Feb 2007 23:25:36 +0100
Received: from c83-253-22-207.bredband.comhem.se ([83.253.22.207])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 04 Feb 2007 23:25:36 +0100
Received: from davidk by c83-253-22-207.bredband.comhem.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 04 Feb 2007 23:25:36 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c83-253-22-207.bredband.comhem.se
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:+XPA/7yLzKNJNERJYFlPR35lcc8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38711>

Jakub Narebski <jnareb@gmail.com> writes:

> Theodore Tso wrote:
>> On Sun, Feb 04, 2007 at 11:12:34AM -0800, Linus Torvalds wrote:
>>> On Sun, 4 Feb 2007, Jeff King wrote:
>>>>=20
>>>> Just a thought, but it might be useful to blame the contents of an
>>>> arbitrary file (but starting the history at a given pathname). Som=
ething
>>>> like "git blame --contents /tmp/foo.c file.c", with contents defau=
lting
>>>> to "file.c". There's much discussion of editor interfaces, and thi=
s
>>>> leaves the possibility of git-blaming the contents of the editor b=
uffer
>>>> (after writing it out to a temp file) without having to save chang=
es to
>>>> the working tree file.
>>>=20
>>> I agree, that probably would make most sense. If we do this at all.=
 On the=20
>>> other hand, I suspect that most editors would probably want to pipe=
 the=20
>>> contents to the program, not write it to a temp-file.
>>=20
>> ... and use it with --incremental, as well.  In emacs you can have t=
he
>> annotation take place as it is being written out relatively easily, =
by
>> arranging to have a callback function get called each time more
>> information is handed back to emacs via a pipe.
>
> So perhaps instead of "git blame --contents /tmp/foo.c file.c" we sho=
uld
> have "cat /tmp/foo.c | git blame --stdin file.c", hmmm? Editor would =
then
> pipe current contents of the buffer to "git blame --stdin --increment=
al
> file.c" (where file.c is the name in tree/in HEAD).

But if we allow the standard convention of using - to mean stdin, the
--contents option would be more flexible, since "--contents -" would
just be a special case.

--=20
David K=C3=A5gedal
