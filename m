From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: [PATCH 0/1] incremental update against 'next' branch
Date: Thu, 18 Jul 2013 17:16:15 -0700
Message-ID: <3e0c11386c2e091f09c554bf0ba091d@f74d39fa044aa309eaea14b9f57fe79>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 19 02:16:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzyN4-00041P-Uy
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jul 2013 02:16:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933968Ab3GSAQ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jul 2013 20:16:26 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:46631 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759509Ab3GSAQZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jul 2013 20:16:25 -0400
Received: by mail-pd0-f180.google.com with SMTP id 10so3605725pdi.25
        for <git@vger.kernel.org>; Thu, 18 Jul 2013 17:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=t2pbRnc9sadr7PYRx+OvNoeUfgnsXW81WXCKTbiJLeA=;
        b=soXot/EgOTQ6QOCdf0mOmg0ab2WJZiM/FGW+GaXD4PlQ/+C7Dwhtu5lvJLuzOWaiOd
         YD2eROSFmgg2AI/MCyEldFgBkBmznumtWDBPZTeGvXP1Hs605PByrANAAby8UuejWnaw
         WFXGkc2WBp/58FwQLtKhi1QLq6WmozWDt/VzIBDfrrlKIuSgzFx3h/4UOHVJWJvE9HBQ
         fo5fvmtV5r2hZuUz6qU2RlfdiQfAh754i7t53KtxxztB2sFBXBYdDo4aAkx0X9aU8zWS
         nWR5NRSmGszHRfPrz1G0CIH0xrU9RyI1jtu6C4r4rdrq2fg6OdCMV2YISTJ7lL3b1Jx2
         3LMA==
X-Received: by 10.66.193.228 with SMTP id hr4mr13741403pac.163.1374192985171;
        Thu, 18 Jul 2013 17:16:25 -0700 (PDT)
Received: from localhost.localdomain (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id mr3sm16136191pbb.27.2013.07.18.17.16.23
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 18 Jul 2013 17:16:24 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230770>

NOTE: This patch requires:

  4e63dcc Git.pm: add new temp_is_locked function

which is currently in next.

Versions v2-v3 of the "allow git-svn fetching to work using serf" patch
introduced a bug when attempting to change the Git.pm _temp_cache function
to use the new temp_is_locked function at the suggestion of a reviewer.

This patch reverts that change as the logic in _temp_cache isn't really
conducive to using temp_is_locked because its tests are not exactly the
same as the ones in temp_is_locked.

Kyle J. McKay (1):
  Git.pm: revert _temp_cache use of temp_is_locked

 perl/Git.pm | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
1.8.3
