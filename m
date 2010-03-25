From: Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH 0/5] add a --strategy option to "git cherry-pick"
Date: Thu, 25 Mar 2010 05:58:12 +0100
Message-ID: <20100325045519.14832.65964.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Alexander Gladysh <agladysh@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 25 06:03:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NufER-0002Gs-RZ
	for gcvg-git-2@lo.gmane.org; Thu, 25 Mar 2010 06:03:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752174Ab0CYFDW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Mar 2010 01:03:22 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:49309 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750842Ab0CYFDV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Mar 2010 01:03:21 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id D6A67818078;
	Thu, 25 Mar 2010 06:03:13 +0100 (CET)
Received: from style.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id BA0BD818045;
	Thu, 25 Mar 2010 06:03:10 +0100 (CET)
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143157>

The purpose of this series is to make it possible to test how "git cherry-pick"
would work with another merge strategy than the recursive one.

Junio suggested:

"It might not be a bad idea to teach a hidden primarily-for-debugging
option to "cherry-pick" to let it use resolve instead of recursive for
cases like this."

Christian Couder (5):
  revert: use strbuf to refactor the code that writes the merge message
  revert: refactor merge recursive code into its own function
  merge: refactor code that calls "git merge-STRATEGY"
  merge: make function try_merge_command non static
  revert: add "--strategy" option to choose merge strategy

 builtin/merge.c   |   81 ++++++++++++++-----------
 builtin/revert.c  |  174 ++++++++++++++++++++++++++++++----------------------
 cache.h           |    3 -
 merge-recursive.h |    4 +
 4 files changed, 149 insertions(+), 113 deletions(-)
