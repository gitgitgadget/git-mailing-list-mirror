From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv2 0/2] gitweb: Make $prevent_xss protection for 'blob_plain' more usable
Date: Thu, 30 Jun 2011 11:39:19 +0200
Message-ID: <1309426761-819-1-git-send-email-jnareb@gmail.com>
Cc: Matt McCutchen <matt@mattmccutchen.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 30 11:40:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QcDjo-0006MR-RZ
	for gcvg-git-2@lo.gmane.org; Thu, 30 Jun 2011 11:40:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753062Ab1F3Jkk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jun 2011 05:40:40 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:43035 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751825Ab1F3Jki (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2011 05:40:38 -0400
Received: by fxd18 with SMTP id 18so2068871fxd.11
        for <git@vger.kernel.org>; Thu, 30 Jun 2011 02:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=tE0j+nlRJoAlwmbs8XWF0N+oa42LMpB8faJNBbfvJho=;
        b=XkCwrJs+f+dbX4LToTtbGU2ukf6ZIUMyuYDsHxnNBSUu3+LDlnwhS/LDSlFFlbeQKx
         lB0bIbpBm2D0kTgvDoiNoMdUOjSOIkShVtxG6j4cy+nJ8qwIR/trA9eVDWclhDXoTsO2
         CUvoYlSLCz4JSBh4NobQWfRx+uj7ZBXPQhQgY=
Received: by 10.223.145.144 with SMTP id d16mr2748970fav.100.1309426784514;
        Thu, 30 Jun 2011 02:39:44 -0700 (PDT)
Received: from localhost.localdomain (abwr29.neoplus.adsl.tpnet.pl [83.8.241.29])
        by mx.google.com with ESMTPS id 21sm1349341fay.45.2011.06.30.02.39.42
        (version=SSLv3 cipher=OTHER);
        Thu, 30 Jun 2011 02:39:43 -0700 (PDT)
X-Mailer: git-send-email 1.7.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176482>

This series is improvement and extending of patch with the same name,
containing only the first patch in the series, sent to git mailing
list on 10.06.2011, and present in 'pu' as fb76adb (jn/mime-type-with-params).

This series is to replace it.

The original impulse behind creating this series was the fact that the
summary of previously sent commit was quite cryptic, and didn't really
explain what it was intended to do.  While at it I have added one more
simplification on top of the one proposed by Junio.

The second path in this series is to have gitweb treat the same
'blob_plain' view of both *.xhtml (with application/xhtml+xml
mimetype) and *.html (text/html), when $prevent_xss is on.

Jakub Narebski (2):
  gitweb: Serve text/*  'blob_plain' as text/plain with $prevent_xss
  gitweb: Serve */*+xml 'blob_plain' as text/plain with $prevent_xss

 gitweb/gitweb.perl |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

-- 
1.7.5
