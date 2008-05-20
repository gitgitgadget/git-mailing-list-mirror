From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: encoding bug in git.el
Date: Wed, 21 May 2008 00:09:00 +0200
Message-ID: <20080520220900.GA20570@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>,
	git@vger.kernel.org
To: Clifford Caoile <piyo@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Wed May 21 00:12:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jya2Z-0001mM-0K
	for gcvg-git-2@gmane.org; Wed, 21 May 2008 00:10:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763576AbYETWJl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 May 2008 18:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764306AbYETWJk
	(ORCPT <rfc822;git-outgoing>); Tue, 20 May 2008 18:09:40 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4808 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757915AbYETWJj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2008 18:09:39 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Jya0y-0005NH-00; Tue, 20 May 2008 23:09:00 +0100
Content-Disposition: inline
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82510>

Recently, some commits started misrecording the "=F6" in my name. (In
emacs, for example, it looks like this in a utf8 buffer:
Hasselstr\201\366m.) I'm guessing there's an extra latin1->utf8
conversion in there somewhere.

It turns out that the breakage occurs when I commit with the
git-status mode from git.el, and it was introduced by this commit:

  commit dbe48256b41c1e94d81f2458d7e84b1fdcb47026
  Author: Clifford Caoile <piyo@users.sourceforge.net>

      git.el: Set process-environment instead of invoking env

It's in master, but not yet in maint. (In fact, it's the _only_ change
to contrib/emacs that's in master but not in maint.)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
