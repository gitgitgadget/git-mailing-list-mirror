From: David Kastrup <dak@gnu.org>
Subject: Re: call external editor from git-gui?
Date: Wed, 15 Aug 2007 20:38:33 +0200
Message-ID: <86ir7g4p92.fsf@lola.quinscape.zz>
References: <20070810153008.GA31759@diana.vm.bytemark.co.uk>
	<20070814045511.GF27913@spearce.org>
	<20070814070000.GA12052@diana.vm.bytemark.co.uk>
	<20070815182228.GA3419@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 15 20:39:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILNmC-0006dD-A2
	for gcvg-git@gmane.org; Wed, 15 Aug 2007 20:39:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754005AbXHOSix convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 15 Aug 2007 14:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757358AbXHOSix
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Aug 2007 14:38:53 -0400
Received: from main.gmane.org ([80.91.229.2]:40643 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760873AbXHOSiw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2007 14:38:52 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1ILNlQ-0000Zu-Kr
	for git@vger.kernel.org; Wed, 15 Aug 2007 20:38:40 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 15 Aug 2007 20:38:40 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 15 Aug 2007 20:38:40 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:G/80eN8XTHUPJxTe5EtcnxpjUBs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55936>

Jan Hudec <bulb@ucw.cz> writes:

> On Tue, Aug 14, 2007 at 09:00:00 +0200, Karl Hasselstr=F6m wrote:
>> On 2007-08-14 00:55:11 -0400, Shawn O. Pearce wrote:
>> > Spawning the user's preferred editor would be a nice way to get so=
me
>> > of that.
>>=20
>> Mmm. I wouldn't call it a _nice_ way: popping up an external program
>> just to get the right text editing behavior. More like the _only_ wa=
y,
>> if the user is picky enough.
>
> It might actually have a rather serious twist. Often the editor for
> git-commit would use the terminal git-commit runs on. But for git-gui=
 you may
> not have any terminal (running git-gui from context menu of some file
> manager) and even if you do, the user does not expect it to be used. =
So the
> user may -- and quite often will -- want different editors for runnin=
g from
> git-gui and git-commit.

The usual convention (though _very_ hard to find anywhere explicitly,
so it might more often than not be ignored) is that $VISUAL points to
an editor that requires a tty to work on, while $EDITOR might get
along without one.

So one uses VISUAL in preference of EDITOR on ttys/proper terminals,
but only EDITOR when without one.  A call from git-gui would probably
fall in the second category.  A call from tig, in contrast, in the
first category.

The GIT_EDITOR variable has no way of expressing this difference,
though.  And I doubt that many people remember this.  I googled around
but failed to come up with a useful reference (of course, both
variable names being common words does not exactly help).

--=20
David Kastrup
