From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: How to commit removed file?
Date: Fri, 12 Jan 2007 11:42:54 +0100
Organization: At home
Message-ID: <eo7omq$1ap$1@sea.gmane.org>
References: <20061231102444.GD26552@mellanox.co.il> <20070102201041.GB10451@mellanox.co.il> <Pine.LNX.4.63.0701022211100.22628@wbgn013.biozentrum.uni-wuerzburg.de> <7vfyatt8di.fsf@assigned-by-dhcp.cox.net> <87lkklgc8v.wl%cworth@cworth.org> <7vzm8wapdv.fsf@assigned-by-dhcp.cox.net> <877ivtxbt2.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Fri Jan 12 11:43:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5JsO-0006WR-Ob
	for gcvg-git@gmane.org; Fri, 12 Jan 2007 11:43:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161068AbXALKnJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 12 Jan 2007 05:43:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161072AbXALKnJ
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jan 2007 05:43:09 -0500
Received: from main.gmane.org ([80.91.229.2]:32833 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161068AbXALKnI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jan 2007 05:43:08 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1H5Js7-0004lL-Oe
	for git@vger.kernel.org; Fri, 12 Jan 2007 11:42:55 +0100
Received: from host-81-190-18-73.torun.mm.pl ([81.190.18.73])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 12 Jan 2007 11:42:55 +0100
Received: from jnareb by host-81-190-18-73.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 12 Jan 2007 11:42:55 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-18-73.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36666>

Carl Worth wrote:

> But now that I tried this case with a recent git (2a3a3c247) for whic=
h
> git-rm does working-tree removal without -f, I see that it does
> irretrievably destroy information in this case:
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0$ echo "important stuff" > new-file
> =A0=A0=A0=A0=A0=A0=A0=A0$ git add new-file
> =A0=A0=A0=A0=A0=A0=A0=A0$ git rm new-file
>=20
> This now deletes new-file from the working tree and there's no copy o=
f
> the data inside git. The old git-rm would just return the file to it'=
s
> "untracked" state in this case.
>=20
> I had thought the safety check was going to be that the index state
> matched the HEAD state before git-rm would delete from the working
> tree.

That is certainly bug in new git-rm; it should remove file _only_
if it can be recovered with the same state as it was before git-rm.=20

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
