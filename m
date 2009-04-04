From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 0/4] start refactoring binary search function
Date: Sat, 4 Apr 2009 22:59:20 +0200
Message-ID: <20090404225920.6a10fe78.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 04 23:02:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqD05-0001lq-VK
	for gcvg-git-2@gmane.org; Sat, 04 Apr 2009 23:02:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754105AbZDDVAa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Apr 2009 17:00:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754005AbZDDVAa
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Apr 2009 17:00:30 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2]:43002 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751027AbZDDVA3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Apr 2009 17:00:29 -0400
Received: from smtp2-g21.free.fr (localhost [127.0.0.1])
	by smtp2-g21.free.fr (Postfix) with ESMTP id 48F074B00D5;
	Sat,  4 Apr 2009 23:00:20 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp2-g21.free.fr (Postfix) with SMTP id 45AAB4B0085;
	Sat,  4 Apr 2009 23:00:18 +0200 (CEST)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.12; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115595>

There are many binary search functions in the code base and I have been
asked to refactor them in these message:

http://thread.gmane.org/gmane.comp.version-control.git/105363/focus=105436
http://thread.gmane.org/gmane.comp.version-control.git/114735/focus=115391

so here is a start

The following patch applies on top of pu where they can be squashed into other
patches:

  sha1-lookup: add new "sha1_pos" function to efficiently lookup sha1
  patch-ids: use the new generic "sha1_pos" function to lookup sha1
  bisect: use the new generic "sha1_pos" function to lookup sha1
  replace_object: use the new generic "sha1_pos" function to lookup
    sha1

 bisect.c         |   23 +++++-------
 patch-ids.c      |   93 +++-----------------------------------------------
 replace_object.c |   24 +++++--------
 sha1-lookup.c    |  101 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 sha1-lookup.h    |    7 ++++
 5 files changed, 131 insertions(+), 117 deletions(-)
