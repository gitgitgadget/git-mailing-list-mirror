From: Marco <netuse@lavabit.com>
Subject: Swap file trouble with gvimdiff
Date: Thu, 24 Feb 2011 20:34:12 +0100
Message-ID: <20110224203412.29b732b9@glyph>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 24 20:34:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsgxO-0000wt-QU
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 20:34:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756292Ab1BXTea convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Feb 2011 14:34:30 -0500
Received: from lo.gmane.org ([80.91.229.12]:46237 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755498Ab1BXTe3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Feb 2011 14:34:29 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PsgxI-0000sA-7W
	for git@vger.kernel.org; Thu, 24 Feb 2011 20:34:28 +0100
Received: from miun108-177.dynamic.miun.se ([193.10.108.177])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 24 Feb 2011 20:34:28 +0100
Received: from netuse by miun108-177.dynamic.miun.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 24 Feb 2011 20:34:28 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: miun108-177.dynamic.miun.se
X-Newsreader: Claws Mail 3.7.6 (GTK+ 2.22.0; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167853>

Hi,

I use gvimdiff as difftool. The relevant .gitconfig entries look as fol=
lows:

[diff]
	tool =3D gvimdiff
[difftool]
	prompt =3D false

But when one diffs a file alredy opened in another window it clashes be=
cause
gvimdiff recognises the swap file and throws a message.

It would make sense to pass the option =C2=BB-n=C2=AB to gvimdiff to av=
oid creating a
swap file, since it is not needed here.

I haven't found the place where the command line and arguments for the
supported difftools are placed, so I created a new entry in the .gitcon=
fig

[diff]
	tool =3D bettergvimdiff
[difftool "bettergvimdiff"]
	cmd =3D "gvimdiff -f -n \"$LOCAL\" \"$REMOTE\""

I want to know if this is a =C2=BBcorrect=C2=AB solution and =E2=80=94 =
if not =E2=80=94 how you solve
the problem.


Marco
