From: =?utf-8?q?J=C3=B6rg=20Sommer?= <joerg@alea.gnuu.de>
Subject: Teach rebase interactive more commands to do better preserve merges
Date: Thu, 10 Apr 2008 01:58:31 +0200
Message-ID: <1207785521-27742-1-git-send-email-joerg@alea.gnuu.de>
References: <7vabkoufzq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, Johannes.Schindelin@gmx.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 10 02:04:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjkGx-0004V7-NV
	for gcvg-git-2@gmane.org; Thu, 10 Apr 2008 02:04:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754799AbYDJADH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2008 20:03:07 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753942AbYDJADG
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Apr 2008 20:03:06 -0400
Received: from banki.eumelnet.de ([83.246.114.63]:3447 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751389AbYDJADE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2008 20:03:04 -0400
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id 06F8D488047; Thu, 10 Apr 2008 02:03:00 +0200 (CEST)
Received: from ibook.localnet ([192.168.0.5] helo=alea.gnuu.de)
	by alea.gnuu.de with esmtp (Exim 4.63)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JjkBe-0004mB-AD; Thu, 10 Apr 2008 01:58:42 +0200
Received: from joerg by alea.gnuu.de with local (Exim 4.69)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JjkBd-0007E1-MT; Thu, 10 Apr 2008 01:58:41 +0200
X-Mailer: git-send-email 1.5.4.5
In-Reply-To: <7vabkoufzq.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79155>


Junio proposed to add the commands mark, merge and reset to rebase
interactive for a better support of rebase with preserve merges. The
current format can only cope with flat lineare lists of commits and not
with the non=E2=80=90linear structure of branches with merges.

This patch series is not intended for inclusion. It's a RFC and meant f=
or
gathering ideas.

Currently it misses:
=C2=B7 commit messages
=C2=B7 documentation of the new commands
=C2=B7 update of the documentation of preserve merges
=C2=B7 tests for the merge command

I've included the patch to change the behaviour of git-merge from Junio=
,
because I don't know how to use the second syntax of git merge and pass
the merge strategies -s to git merge. Without this patch, a new merge
message gets appended to the commit message of a rebased merge commit.
This patch should not be part of the final commit series.

Open questions:
=C2=B7 Is it possible to get a list of all commits iterating the parent=
s from
  the last to the first and going to the child of a node before the
  neighbors?

=C2=B7 How to get a symbolic name (branch or tag) for a commit? Not som=
ething
  like git describe. I want to know if 0123 refers to the tip of a
  branch.

J=C3=B6rg.
