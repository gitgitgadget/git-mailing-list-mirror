From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v2 0/2] bash completion: more options for gitk/log/shortlog
Date: Mon, 16 Feb 2009 17:34:55 +0100
Message-ID: <cover.1234801852.git.trast@student.ethz.ch>
References: <adf1fd3d0902150156w67a16e6fp3c946446c5ae2bfd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?q?Santi=20B=C3=A9jar?= <santi@agolina.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 16 17:36:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZ6Sa-0000Iq-40
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 17:36:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751581AbZBPQfL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 11:35:11 -0500
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751388AbZBPQfL
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 11:35:11 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:44459 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751123AbZBPQfK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 11:35:10 -0500
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 16 Feb 2009 17:35:08 +0100
Received: from localhost.localdomain ([129.132.153.233]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 16 Feb 2009 17:35:08 +0100
X-Mailer: git-send-email 1.6.2.rc0.328.g2c702
In-Reply-To: <adf1fd3d0902150156w67a16e6fp3c946446c5ae2bfd@mail.gmail.com>
X-OriginalArrivalTime: 16 Feb 2009 16:35:08.0369 (UTC) FILETIME=[879DD410:01C99054]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110200>

Santi B=C3=A9jar wrote:
> 2009/2/15 Junio C Hamano <gitster@pobox.com>:
> > Many options you add here are useful for git-log and not present in=
 its
> > completion, but as you point out not all git-log options necessaril=
y make
> > sense for gitk.  I think it would make sense to introduce an extra
> > variable $__git_log_basic_options that holds the basic ones that ca=
n be in
> > both, and add the ones that are specific to gitk or git-log in thei=
r own
> > completion functions.  I suspect gitk's addition will be nil, while
> > git-log would add --graph, --walk-reflogs and --no-merges to the ba=
sic
> > set.

Right.  Somehow git patches have a tendency to grow in scope; while I
was trying to refactor them in good ways, I couldn't help notice that
shortlog falls in the same category.

(Probably there's another log-like command that I missed?)

> I sometimes use the --no-merges with gitk, normally within a range
> (the last 'next' update or so).

=46or me that falls in the "mangles history in horrible ways" category,
but since you use it, I put it in.

2/2 is new; I figured since gitk has this bit of code already, why not
have git-log do it the same way?


Thomas Rast (2):
  bash completion: refactor common log, shortlog and gitk options
  bash completion: only show 'log --merge' if merging

 contrib/completion/git-completion.bash |   56 ++++++++++++++++++++++--=
-------
 1 files changed, 40 insertions(+), 16 deletions(-)
