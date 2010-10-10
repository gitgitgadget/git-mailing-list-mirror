From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 0/2] Re: [PATCH v5 3/4] [RFC] Only show bulkmoves in output.
Date: Sun, 10 Oct 2010 21:59:53 +0200
Message-ID: <1286740795-7929-1-git-send-email-ydirson@altern.org>
References: <20101010123954.GB4983@home.lan>
Cc: Yann Dirson <ydirson@altern.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 10 22:32:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P52ZD-00070z-VL
	for gcvg-git-2@lo.gmane.org; Sun, 10 Oct 2010 22:32:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211Ab0JJUcK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Oct 2010 16:32:10 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:51478 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750776Ab0JJUcI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Oct 2010 16:32:08 -0400
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 5A337D48171;
	Sun, 10 Oct 2010 22:32:01 +0200 (CEST)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1P52j5-00025i-Ef; Sun, 10 Oct 2010 22:42:35 +0200
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <20101010123954.GB4983@home.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158698>

>Thinking twice, that approach has a major problem: it will break when
>a file is named "*".  Finally looks like differing this to display
>time will be the most sensible solution.

So here is a matching implementation (patch 1/2).  At first I also
thought of moving the responsibility of the toplevel special case
(displaying toplevel dir az "./") to the formatting routines (patch
2/2), but unless there are compelling reasons to proceed that way, I
guess that approach should be dropped - correct ?

Yann Dirson (2):
  [RFC] Only show bulkmoves in output.
  [RFC] Transfer special display of toplevel dir to display-time.

 diff.c                           |   15 +++++++++++++++
 diffcore-rename.c                |    9 ++-------
 diffcore.h                       |    1 +
 t/t4046-diff-rename-factorize.sh |   22 +++++++++++-----------
 4 files changed, 29 insertions(+), 18 deletions(-)

-- 
1.7.2.3
