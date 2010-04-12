From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v3 0/2] gitk --color-words
Date: Mon, 12 Apr 2010 15:07:43 +0200
Message-ID: <cover.1271077334.git.trast@student.ethz.ch>
References: <s2kfc339e4a1004051153yc950b858lb919740f0de80e9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eelis van der Weegen <eelis@eelis.net>,
	Junio C Hamano <gitster@pobox.com>,
	Paul Mackerras <paulus@samba.org>, Miles Bader <miles@gnu.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 12 15:08:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1JMy-0006XC-Cz
	for gcvg-git-2@lo.gmane.org; Mon, 12 Apr 2010 15:08:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752063Ab0DLNH5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Apr 2010 09:07:57 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:33992 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751963Ab0DLNH5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Apr 2010 09:07:57 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.247.2; Mon, 12 Apr
 2010 15:07:56 +0200
Received: from localhost.localdomain (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.247.2; Mon, 12 Apr
 2010 15:07:46 +0200
X-Mailer: git-send-email 1.7.1.rc0.260.g2b919
In-Reply-To: <s2kfc339e4a1004051153yc950b858lb919740f0de80e9@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144723>

During development an unrelated gitk diff parsing bug hit me, which is
the new 2/3.  I think it should go in maint if the patch turns out to
be correct, but I'd like to have an ACK from Jens first.

Junio C Hamano wrote:
> I also think --color --word-diff=plain could show "{+new+}" in green and
> "[-old-]" in red and that may make things more consistent.

So here's a patch that does that.  I may be overdoing the "generic
diff style" code a bit, but it makes for slightly nicer code.

I similarly extended the support in gitk to have two different modes.
My use of the dropdown is again sheer voodoo and works merely by
accident...

I also taught gitk to not show the option and not parse the
command-line options unless the git version is at least v1.7.2, which
I expect will be the version that has the underlying diff support.

BTW:

Miles Bader wrote:
> For some reason, even though I can see the red and green well enough,
> I find the current --color-words output hard to parse.
> The use of _only_ color to distinguish old/new somehow doesn't jive
> with my brain...

I set my diff colors to bold red/blue which makes the changed words
very visible even in light conditions where green is very hard to tell
from black (sitting outside in the sun or so).

> I find _highlighting_ using color very useful, but I think using
> syntax and color together is better than using just color.

Well, I for one find the extra markup *very* confusing because I need
to mentally untangle it from the actual content...


Thomas Rast (3):
  diff: add --word-diff option that generalizes --color-words
  gitk: do not parse "  >" context as submodule change
  gitk: add the equivalent of diff --color-words
