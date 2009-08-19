From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: ls-files -t broken? Or do I just not understand it?
Date: Wed, 19 Aug 2009 10:24:23 +0200
Message-ID: <20090819082423.GA18860@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 19 10:24:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdgTF-00006t-6E
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 10:24:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751892AbZHSIY2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Aug 2009 04:24:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751840AbZHSIY2
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 04:24:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:43437 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751795AbZHSIY1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2009 04:24:27 -0400
Received: (qmail invoked by alias); 19 Aug 2009 08:24:27 -0000
Received: from i59F55728.versanet.de (EHLO atjola.homenet) [89.245.87.40]
  by mail.gmx.net (mp015) with SMTP; 19 Aug 2009 10:24:27 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19Ms71sFq5Mr5WwNIOifNetx4Alv4Vwzh1x7FaCD9
	CFYpHrP0DkzH2s
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126516>

Hi,

ls-files -t seems to always show status H, even if the file was modifie=
d
or deleted, and thus gets shown by -m and -d respectively.

doener@atjola:git (master) $ git status
# On branch master
nothing to commit (working directory clean)
doener@atjola:git (master) $ rm git.c
doener@atjola:git (master) $ echo 123 > Makefile
doener@atjola:git (master) $ git ls-files -m
Makefile
git.c
doener@atjola:git (master) $ git ls-files -d
git.c
doener@atjola:git (master) $ git ls-files -t Makefile git.c
H Makefile
H git.c
doener@atjola:git (master) $ git add -u Makefile git.c
doener@atjola:git (master) $ git ls-files -m
doener@atjola:git (master) $ git ls-files -d
doener@atjola:git (master) $ git ls-files -t Makefile git.c
H Makefile
doener@atjola:git (master) $=20


I would have expected the first "ls-files -t" to say:
C Makefile
K git.c

Is that a bug, or am I just misunderstanding what -t is supposed to do?

Bj=F6rn
