From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH 0/2] fast-import: allow more operations on root directory
Date: Tue, 16 Aug 2011 16:08:55 +0600
Message-ID: <1313489337-2523-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <davidbarr@google.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 16 12:08:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtGZ2-0006vP-3E
	for gcvg-git-2@lo.gmane.org; Tue, 16 Aug 2011 12:08:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752190Ab1HPKH5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Aug 2011 06:07:57 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:62745 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752073Ab1HPKH5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2011 06:07:57 -0400
Received: by bke11 with SMTP id 11so3592725bke.19
        for <git@vger.kernel.org>; Tue, 16 Aug 2011 03:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=MHdX9a5dIFRPqSj1vq5HDtyUSVIs83/a594g9hua0wA=;
        b=DXMaa7O4pW8xB0rqUTbDHuydNKXt5oiKuzkT2bcq+x3NLJwy+lRGqZ2Y/g/DvJ7JQ5
         7NOPmQex6XYyj6bNwbwimzXJC9zKFrfNUyD4XTh6WbX33q9HuZuxjj8iUjn+gIAIItAu
         Aa4acaY0NnJWBRu5exBShWGD+r2B4KNMOLTFI=
Received: by 10.205.64.198 with SMTP id xj6mr1434961bkb.65.1313489275703;
        Tue, 16 Aug 2011 03:07:55 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id y8sm1836823bks.54.2011.08.16.03.07.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 16 Aug 2011 03:07:55 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179426>

[1/2] has been already reviewed in [1] where it didn't seem to have any effect,
but for this series it does, for 'ls ""' command.
So the change is about allowing to "ls" root directory and to copy or rename 
it to some subdirectory. The documentation doesn't deny these, but they don't
work. Make them work.

More details are in [2/2].

[1] http://thread.gmane.org/gmane.comp.version-control.git/178007/focus=178009

Dmitry Ivankov (2):
  fast-import: be saner with temporary trees
  fast-import: allow top directory as an argument for some commands

 fast-import.c          |   78 +++++++++++++++++++++++++++++++++++++++++------
 t/t9300-fast-import.sh |   58 +++++++++++++++++++++++++++++++++++
 2 files changed, 126 insertions(+), 10 deletions(-)

-- 
1.7.3.4
