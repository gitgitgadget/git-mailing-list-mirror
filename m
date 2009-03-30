From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 0/2] bisect--helper: string output variables together
 with "&&"
Date: Mon, 30 Mar 2009 06:59:45 +0200
Message-ID: <20090330065945.edc862e3.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, John Tapsell <johnflux@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 30 07:02:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lo9dd-0004Da-Qz
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 07:02:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752356AbZC3FAu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 01:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752251AbZC3FAu
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 01:00:50 -0400
Received: from smtp6-g21.free.fr ([212.27.42.6]:44752 "EHLO smtp6-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751020AbZC3FAu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 01:00:50 -0400
Received: from smtp6-g21.free.fr (localhost [127.0.0.1])
	by smtp6-g21.free.fr (Postfix) with ESMTP id 68A03E08030;
	Mon, 30 Mar 2009 07:00:40 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp6-g21.free.fr (Postfix) with SMTP id 4E1DDE0801F;
	Mon, 30 Mar 2009 07:00:38 +0200 (CEST)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.12; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115066>

The goal of this 2 patches is to get rid of the need to pipe the
output of "eval 'git bisect--helper --next-vars'" into a "while read"
loop.

The only change since the previous version is that a brown paper bag bug
in "show_tried_revs" is fixed in the second patch.

  rev-list: pass a flag as last argument of "show_bisect_vars"
  bisect--helper: string output variables together with "&&"

 bisect.c           |    3 ++-
 bisect.h           |    9 +++++++--
 builtin-rev-list.c |   42 +++++++++++++++++++++++++-----------------
 git-bisect.sh      |   15 +--------------
 4 files changed, 35 insertions(+), 34 deletions(-)
