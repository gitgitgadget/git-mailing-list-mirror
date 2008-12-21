From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: [PATCHv2] Have manpage reference new documentation on reverting merges.
Date: Sun, 21 Dec 2008 15:35:18 -0600
Message-ID: <E1LEVxk-0001jS-Cc@rei.iguanasuicide.net>
References: <200812201832.48992.bss@iguanasuicide.net> <7vtz8ytft0.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Nanako Shiraishi <nanako3@lavabit.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 21 22:37:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEVzO-0004Tg-KD
	for gcvg-git-2@gmane.org; Sun, 21 Dec 2008 22:37:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330AbYLUVfu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Dec 2008 16:35:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbYLUVfu
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Dec 2008 16:35:50 -0500
Received: from rei.iguanasuicide.net ([209.20.91.252]:37472 "EHLO
	rei.iguanasuicide.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751241AbYLUVfu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Dec 2008 16:35:50 -0500
Received: from ip72-204-50-125.fv.ks.cox.net ([72.204.50.125] helo=[10.0.0.123])
	by rei.iguanasuicide.net with esmtpsa (TLS-1.0:DHE_DSS_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LEVxk-0001jS-Cc; Sun, 21 Dec 2008 21:35:48 +0000
User-Agent: KMail/1.9.9
In-Reply-To: <7vtz8ytft0.fsf@gitster.siamese.dyndns.org>
X-Eric-Conspiracy: There is no conspiracy.
X-KMail-SignatureActionEnabled: false
X-KMail-EncryptActionEnabled: false
X-KMail-CryptoMessageFormat: 2
Content-Disposition: inline
X-Virus-Scanned: clamav@iguanasuicide.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103711>

Signed-off-by: Boyd Stephen Smith Jr <bss@iguanasuicide.net>
---
On Saturday 2008 December 20 20:36:43 Junio C Hamano wrote:
> "Boyd Stephen Smith Jr." <bss@iguanasuicide.net> writes:
> > +	Reverting a merge commit does not completely "undo" the effect of the
> > +	merge and it may make future merges more difficult.  For more details,
> > +	please read Documentation/howto/revert-a-faulty-merge.txt.
>
> I think these new lines need to be dedented, and the previous blank line
> should be turned into a line with a single '+'.

Fixed, I wasn't familiar with asciidoc.

> I'd also suggest removing "does not ... merge and it" from the above
> sentence to avoid confusing readers, because people who read only the
> above and do not read the howto document may get a wrong impression that
> the resulting tree may have some changes that came from the merge even
> after the revert, which is not the case.
>
> An alternative is to give a complete but brief explanation.  Perhaps like
> this:

I took the alternative approach.

 Documentation/git-revert.txt |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
index caa0729..daa77a9 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -44,6 +44,13 @@ OPTIONS
 	option specifies the parent number (starting from 1) of
 	the mainline and allows revert to reverse the change
 	relative to the specified parent.
++
+Reverting a merge commit declares to git that you will never want the tree
+changes brought in by the merge but never alters the history changes caused by
+the merge.  The history allows git to remember you rejected the tree changes
+and, as a result, later merges will only bring in changes introduced by commits
+that are not ancestors of the revert commit.  This may or may not be what you
+want.  See the 'revert-a-faulty-merge' HOWTO for more details.
 
 --no-edit::
 	With this option, 'git-revert' will not start the commit
-- 
1.5.6
-- 
Boyd Stephen Smith Jr.                     ,= ,-_-. =. 
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-' 
http://iguanasuicide.net/                      \_/     
