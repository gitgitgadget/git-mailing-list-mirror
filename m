From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v2 0/5] git-reset documentation changes
Date: Sun, 18 Jul 2010 20:23:21 +0200
Message-ID: <cover.1279477130.git.trast@student.ethz.ch>
References: <7v7hkvrwd0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jul 18 20:23:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OaYWW-0002KL-Cx
	for gcvg-git-2@lo.gmane.org; Sun, 18 Jul 2010 20:23:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756932Ab0GRSXd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jul 2010 14:23:33 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:54304 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756925Ab0GRSXb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jul 2010 14:23:31 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Sun, 18 Jul
 2010 20:23:30 +0200
Received: from localhost.localdomain (129.132.209.162) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.0.702.0; Sun, 18 Jul
 2010 20:23:29 +0200
X-Mailer: git-send-email 1.7.2.rc3.317.gc287
In-Reply-To: <7v7hkvrwd0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151231>

Junio C Hamano wrote:
[on patch 2/5]
> >  DESCRIPTION
> >  -----------
> > +Sets the current branch to the specified <commit> and optionally
> > +resets the index and working tree to match.  The <commit> defaults to
> > +HEAD in all forms.
> 
> With a careless reading of this paragraph, I got an impression that HEAD
> is always affected, but I happen to know that is not the case ;-).
> 
>  - "reset" is primarily about resetting the index and the --soft option
>    can be used to optionally not to do this.
> 
>    . with paths, the command is about fixing up the index contents for
>      given specific paths, to prepare for the next commit.  HEAD is not
>      moved.
> 
>    . without paths, the command is about changing what commit to build
>      your next commit on, i.e. HEAD is moved.

You're right, I completely left out the <paths> mode there.  I rewrote
this as a short summary of all three modes in this version.

> "git reset HEAD frotz" from a head commit without frotz gets rid of frotz
> from the index, no?

True.  I thought it didn't (and required rm --cached) but I must have
mixed up something.

The other patches are unchanged from v1.


Thomas Rast (5):
  Documentation/git-reset: reorder modes for soft-mixed-hard
    progression
  Documentation/reset: separate options by mode
  Documentation/reset: promote 'examples' one section up
  Documentation/reset: reorder examples to match description
  Documentation/reset: move "undo permanently" example behind "make
    topic"

 Documentation/git-reset.txt |  347 ++++++++++++++++++++++---------------------
 1 files changed, 178 insertions(+), 169 deletions(-)

-- 
1.7.2.rc3.317.gc287
