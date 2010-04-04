From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 0/2] gitk --color-words
Date: Sun, 4 Apr 2010 15:46:37 +0200
Message-ID: <cover.1270388195.git.trast@student.ethz.ch>
References: <cover.1269996525.git.trast@student.ethz>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eelis van der Weegen <eelis@eelis.net>,
	Junio C Hamano <gitster@pobox.com>,
	Paul Mackerras <paulus@samba.org>, Miles Bader <miles@gnu.org>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 04 15:47:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyQAg-0000pk-Ud
	for gcvg-git-2@lo.gmane.org; Sun, 04 Apr 2010 15:47:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754206Ab0DDNrH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Apr 2010 09:47:07 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:55444 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752271Ab0DDNrF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Apr 2010 09:47:05 -0400
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.234.1; Sun, 4 Apr
 2010 15:47:01 +0200
Received: from localhost.localdomain (217.162.250.31) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Sun, 4 Apr
 2010 15:46:40 +0200
X-Mailer: git-send-email 1.7.0.3.521.ga1e9e
In-Reply-To: <cover.1269996525.git.trast@student.ethz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143926>

Miles Bader wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> > How readable can you make this for human consumption while still keeping
> > it machine readable?  The answer could be it already is human readble.
> >
> > Two reasons I ask the above question are that I find the feature quite
> > interesting, and would want to see if it can be also fed to humans, and
> > that the combination of this new option and the existing --color-words is
> > misnamed.
> 
> There's the format used by the "wdiff" program, which is more like
> traditional diff output in that it doesn't use color, but is human
> friendly, and also seems to be somewhat machine-parseable:
> 
>    $ echo 'This is a test' > /tmp/a
>    $ echo 'This is funky test' > /tmp/b
>    $ wdiff /tmp/a /tmp/b
>    This is [-a-] {+funky+} test
> 
> [I say "somewhat" because wdiff itself doesn't appear to escape potentially
> ambiguous content, e.g., if there's actually a "{+" in the file....]

Junio C Hamano wrote:
> If you call this --word-diff, then it would become more clear that
> --color-words perhaps should have been called --word-diff=color or
> something.

Excellent ideas!  I don't have anything to add ;-)

This makes [1/2] a rather new patch though, I moved the whole
prefix/suffix handing further out to accommodate different styles.

There's a little change in [2/2] apart from the obvious option
renaming, too: it interprets --color-words and --word-diff as an
initial setting for the checkbox.


Thomas Rast (2):
  diff: add --word-diff option that generalizes --color-words
  gitk: add the equivalent of diff --color-words
