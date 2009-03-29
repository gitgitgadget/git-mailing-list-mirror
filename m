From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 0/4] bisect--helper: fix reading many paths
Date: Sun, 29 Mar 2009 11:44:38 +0200
Message-ID: <20090329114438.6642fb64.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, John Tapsell <johnflux@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 29 11:47:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lnrbn-00046d-Ap
	for gcvg-git-2@gmane.org; Sun, 29 Mar 2009 11:47:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752296AbZC2Jpo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Mar 2009 05:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751990AbZC2Jpn
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Mar 2009 05:45:43 -0400
Received: from smtp4-g21.free.fr ([212.27.42.4]:56362 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751931AbZC2Jpn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Mar 2009 05:45:43 -0400
Received: from smtp4-g21.free.fr (localhost [127.0.0.1])
	by smtp4-g21.free.fr (Postfix) with ESMTP id C1CDD4C81AE;
	Sun, 29 Mar 2009 11:45:33 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp4-g21.free.fr (Postfix) with SMTP id AA1704C8163;
	Sun, 29 Mar 2009 11:45:30 +0200 (CEST)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.12; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115004>

These patches fix reading more than one path in "git bisect--helper":

  quote: implement "sq_dequote_many" to unwrap many args in one string
  quote: add "sq_dequote_to_argv" to put unwrapped args in an argv
    array
  bisect: fix reading more than one path in "$GIT_DIR/BISECT_NAMES"
  bisect: test bisecting with paths

 bisect.c                    |   14 +++++-----
 quote.c                     |   35 +++++++++++++++++++++++-
 quote.h                     |   10 +++++++
 t/t6030-bisect-porcelain.sh |   60 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 110 insertions(+), 9 deletions(-)
