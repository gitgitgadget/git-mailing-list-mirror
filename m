From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: file rename causes history to disappear
Date: Wed, 06 Sep 2006 20:52:51 +0200
Organization: At home
Message-ID: <edn5dd$c4s$2@sea.gmane.org>
References: <44FEE0BB.2060601@garzik.org> <Pine.LNX.4.64.0609060834520.27779@g5.osdl.org> <44FEED4B.30909@garzik.org> <Pine.LNX.4.64.0609060858050.27779@g5.osdl.org> <edmvfv$lt7$2@sea.gmane.org> <Pine.LNX.4.64.0609061131100.27779@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Wed Sep 06 20:55:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GL2YW-0005yg-3k
	for gcvg-git@gmane.org; Wed, 06 Sep 2006 20:55:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbWIFSzV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 6 Sep 2006 14:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750909AbWIFSzV
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Sep 2006 14:55:21 -0400
Received: from main.gmane.org ([80.91.229.2]:27064 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750778AbWIFSzS (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Sep 2006 14:55:18 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1GL2YA-0005ui-R3
	for git@vger.kernel.org; Wed, 06 Sep 2006 20:55:03 +0200
Received: from host-81-190-21-28.torun.mm.pl ([81.190.21.28])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 06 Sep 2006 20:55:02 +0200
Received: from jnareb by host-81-190-21-28.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 06 Sep 2006 20:55:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-28.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26550>

Linus Torvalds wrote:

>> git-rev-list could then output hash with current set of <filenames>,=
 which
>> were given <filename> at the beginning, i.e.
>> =A0 <hash> -- <filename> [<filename>...]
>=20
> I would argue that "--follow" would be incompatible with having other=
=20
> <paths> listed. But maybe there is some sensible rule for what the=20
> combination means (show the listed paths _and_ the file we're followi=
ng?)=20
> I dunno.

I'm not that sure. The output could be changed to, for example
  <hash> SP <quoted-filename> [SP <quoted-filename> ...]
although I'm not sure if git can detect that two files were joined into=
 one
(or, in reverse that one file was split into several; this doesn't matt=
er
for following history of a file from top)

But --follow=3D<filename> with <pathspec> can be useful, e.g. when <pat=
hspec>=20
is a directory (or, perhaps in the future, glob), which would mean "fol=
low
the contents indicated in starting hash by <filename>, and stop followi=
ng
when it falls out outside given <pathspec>, in our case given directory=
".

As pathspecs doesn't change, there is no need to output them.
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
