From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 0/2] auto-detect getdelim()
Date: Tue,  2 Jun 2015 14:18:56 -0400
Message-ID: <1433269138-10890-1-git-send-email-sunshine@sunshineco.com>
Cc: Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 02 20:20:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yzqn8-0005yV-SY
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 20:19:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754438AbbFBSTy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 14:19:54 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:34469 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753760AbbFBSTx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2015 14:19:53 -0400
Received: by igbhj9 with SMTP id hj9so93078105igb.1
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 11:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=FGH/hM7vur5xy41GtrjSUlUboVERsmF7ZoTW7L6Z0Bk=;
        b=sXwU29ISQocLf2vSOhEHsVZTKyrzjXNt7ChZ56hiDl/tHSVcaWvIjNONjXT6dFhkpQ
         edkTANEfTCB0Y06d65Wnq8U704yAlnyEQV1LhOxsWjZ0BUW+GgS4uf8jLVZarP5R5DxD
         FrScXrVftNysDkrIUulzr4kLVWUoNLOT04NviDQHo0InkvskRAAhTDAGexIXavKpLSlz
         OLv4nKE3lmvgNVAUsxhxnD73LsCw2GHe9mAPY6E4IzX15xkjhK1QuLEJRFxZxKlKsVPM
         PKNVpfM7tdp0/4pI1NAHGqCP+NTXBiGzplf2Bns095u/V2wG4VjcPOwYHJTJ2VWDJQ2Q
         FyNw==
X-Received: by 10.50.64.243 with SMTP id r19mr21858752igs.5.1433269192579;
        Tue, 02 Jun 2015 11:19:52 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id v14sm10451458igd.12.2015.06.02.11.19.51
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Jun 2015 11:19:52 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.674.gb037150
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270576>

As an optimization, strbuf takes advantage of getdelim() when available
(HAVE_GETDELIM). Currently, HAVE_GETDELIM is defined automatically only
for Linux. This patch series updates config.mak.uname to define
HAVE_GETDELIM on Mac OS X (Darwin) based upon version ("uname -r"), and
more generally via a configure script check.

Eric Sunshine (2):
  config.mak.uname: Darwin: define HAVE_GETDELIM for modern OS X
    releases
  configure: add getdelim() check

 config.mak.uname | 3 +++
 configure.ac     | 6 ++++++
 2 files changed, 9 insertions(+)

-- 
2.4.2.598.gb4379f4
