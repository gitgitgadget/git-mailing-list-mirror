From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Cogito and --exclude vs --exclude-per-directory
Date: Wed, 16 Nov 2005 10:36:30 +0100
Message-ID: <20051116093630.GA2783@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Wed Nov 16 10:38:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcJis-0005mg-UV
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 10:36:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030259AbVKPJgf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 16 Nov 2005 04:36:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030260AbVKPJgf
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Nov 2005 04:36:35 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:43794 "EHLO
	diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP
	id S1030259AbVKPJge (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Nov 2005 04:36:34 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1EcJiQ-0001AC-00; Wed, 16 Nov 2005 09:36:30 +0000
To: git@vger.kernel.org
Content-Disposition: inline
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12016>

[Note: this experiment was done with git 0.99.9g and Cogito 0.15.1, so =
]

It seems that --exclude patterns always take precedence over
--exclude-per-directory patterns. For example:

  $ ls -a
  ./  ../  .bar  bar.txt  .foo  foo.txt  .git/  .gitignore

  $ cat .gitignore
  !.bar

  $ git-ls-files -o --exclude=3D'.*' --exclude=3D'!.bar'
  .bar
  bar.txt
  foo.txt

  $ git-ls-files -o --exclude=3D'.*' --exclude-per-directory=3D.gitigno=
re
  bar.txt
  foo.txt

Is this the intended behavior?

Since Cogito specifies a few "default" ignore patterns with --exclude,
(such as .* and *.o) these become impossible to override with !
patterns in .gitignore files. In effect, the default patterns are
given priority over user-supplied patterns.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
