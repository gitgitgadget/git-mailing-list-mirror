From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [RFC v2 00/16] GSOC remote-svn, rewritten patch series
Date: Mon, 30 Jul 2012 16:31:07 +0200
Message-ID: <1343658683-10713-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1343287957-22040-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: florian.achleitner.2.6.31@gmail.com
To: Jonathan Nieder <jrnieder@gmail.com>,
	David Michael Barr <davidbarr@google.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 30 16:39:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Svr7r-0007n1-Aj
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 16:39:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754718Ab2G3OjJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jul 2012 10:39:09 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:39226 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754679Ab2G3OjI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2012 10:39:08 -0400
Received: by bkwj10 with SMTP id j10so2859087bkw.19
        for <git@vger.kernel.org>; Mon, 30 Jul 2012 07:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=fZzdX6n6IskXSAeCWN2jpQzjDALWXp54VSppNO5EGoY=;
        b=wWaFTjOkXGGRnNRmzI1al9uCDfU2RScupbcqWzrNsrAbog3vVdAeWlHtx7OpQq2z6Z
         0apN6MjoDLMYFoIM5R6pZbzvNTDrTQfki39veLj+VOxDLZhI6vbQyH0wFLy8lbRLP/EJ
         P/9mm6J27NemeWls8x47SGBS3w98pSiaBVfXjBhQCGpspDXYDBefOYmJaW/2/HfSV9U9
         44039nbwLTP0vSgN3gMMBZjEMkcBtkWXnX/myaWuAAOUDsptyXsKYRFSKbNAG6ysPXBY
         roV8xRLXmzCSEbtF7I5EFIzOvZjWX1QAyUjHtPMzvCbbYyEJ/lQ90+9tLiwE3f2w277Y
         9uBg==
Received: by 10.204.136.216 with SMTP id s24mr4075363bkt.137.1343659146172;
        Mon, 30 Jul 2012 07:39:06 -0700 (PDT)
Received: from localhost.localdomain (cm56-227-93.liwest.at. [86.56.227.93])
        by mx.google.com with ESMTPS id fu8sm3945866bkc.5.2012.07.30.07.39.04
        (version=SSLv3 cipher=OTHER);
        Mon, 30 Jul 2012 07:39:05 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1343287957-22040-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202545>

Updated after reviews.
Diff:
- remove all debug messages (printd).
- clarify url processing by splitting it into two variables url_in and url.
- Redesign to a central command dipatcher keeping a state (batch_active, batch_command).
	- remove tristate return value and the enum.
	- checks whether the batch is consistent and dies otherwise.

Changes concenctrate on patch 01, but have some tiny influence on the rest of 
the series (no more printd). 
