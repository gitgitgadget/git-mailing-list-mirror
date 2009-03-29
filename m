From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 0/2] bisect--helper: string output variables together with
 "&&"
Date: Sun, 29 Mar 2009 11:55:38 +0200
Message-ID: <20090329115538.a9519bcf.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, John Tapsell <johnflux@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 29 11:58:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lnrmb-0006TP-Gu
	for gcvg-git-2@gmane.org; Sun, 29 Mar 2009 11:58:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753548AbZC2J4o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Mar 2009 05:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753476AbZC2J4n
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Mar 2009 05:56:43 -0400
Received: from smtp6-g21.free.fr ([212.27.42.6]:59537 "EHLO smtp6-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753407AbZC2J4n (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Mar 2009 05:56:43 -0400
Received: from smtp6-g21.free.fr (localhost [127.0.0.1])
	by smtp6-g21.free.fr (Postfix) with ESMTP id 289C6E08186;
	Sun, 29 Mar 2009 11:56:33 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp6-g21.free.fr (Postfix) with SMTP id D842EE081BD;
	Sun, 29 Mar 2009 11:56:30 +0200 (CEST)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.12; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115010>

The goal of this 2 patches is to get rid of the need to pipe the
output of "eval 'git bisect--helper --next-vars'" into a "while read"
loop.

This applies on top of my previous "bisect--helper" series on pu.

  rev-list: pass a flag as last argument of "show_bisect_vars"
  bisect--helper: string output variables together with "&&"

 bisect.c           |    3 ++-
 bisect.h           |    9 +++++++--
 builtin-rev-list.c |   44 +++++++++++++++++++++++++++-----------------
 git-bisect.sh      |   15 +--------------
 4 files changed, 37 insertions(+), 34 deletions(-)
