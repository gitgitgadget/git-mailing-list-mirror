From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 0/9] mailmap fixes
Date: Mon, 15 Jul 2013 02:54:04 -0400
Message-ID: <1373871253-96480-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 15 08:54:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uycg0-0003lB-2h
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 08:54:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754096Ab3GOGyY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 02:54:24 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:51027 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750753Ab3GOGyX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 02:54:23 -0400
Received: by mail-ie0-f175.google.com with SMTP id a11so17915653iee.20
        for <git@vger.kernel.org>; Sun, 14 Jul 2013 23:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        bh=TzxUC5r7uzI0j7+GkrG/kxXejGdaezoj+6WkUzeHtjg=;
        b=u2sPb1D+7lMdXupy2wbgeXagLM2fnN45c97aFjFk5+q79hNvtrtk5TcufwzFwbPqyK
         Tn/8PYQvJzMUUXPqiRO8Htw8h0EsxaUeHiwLyYxBZal9VP/SbpnZAE3dC668M87X8Fe3
         L9mH78IoE2gb4qHbxutwwl+rZkIBpwsOooxLqGog+V0kZbyIeS+MpQGTHC1VW+DPeTPx
         +cMgmklTHPyDWrN2zumxqHRcD/d2o7XS3cwHO7grsIL+ctSTTXrOzD3UhXZy/fsLPdbo
         Ar9ZGl0YCo/Leb9uhcqzwqrvBl5EmKYh6e24AqdpaEFg6fv7TZtC7dTNR6ep8oxH4uIS
         n9LA==
X-Received: by 10.50.29.9 with SMTP id f9mr6294498igh.11.1373871263001;
        Sun, 14 Jul 2013 23:54:23 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id y9sm16781487iga.9.2013.07.14.23.54.20
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 14 Jul 2013 23:54:21 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2.804.g0da7a53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230425>

This is a re-roll of jc/mailmap-case-insensitivity [1] in 'pu', which
fixes an off-by-one parsing bug and a case-losing bug in mailmap.

Changes since v1:

* Replace v1 [4/4] with new [1/9] and [3/9] which explicitly demonstrate
  each bug being fixed.

* Fix several crashes and issues in mailmap debug code (new patches
  [5/9] through [8/9].

[1]: http://thread.gmane.org/gmane.comp.version-control.git/230258/

Eric Sunshine (6):
  t4203: demonstrate loss of single-character name in mailmap entry
  t4203: demonstrate loss of uppercase characters in canonical email
  mailmap: debug: fix out-of-order fprintf() arguments
  mailmap: debug: fix malformed fprintf() format directive
  mailmap: debug: eliminate -Wformat field precision type warning
  mailmap: debug: avoid passing NULL to fprintf() '%s' directive

Junio C Hamano (3):
  mailmap: do not lose single-letter names
  mailmap: do not downcase mailmap entries
  mailmap: style fixes

 mailmap.c          | 67 +++++++++++++++++++++++++++++++-----------------------
 t/t4203-mailmap.sh | 18 +++++++++++++++
 2 files changed, 57 insertions(+), 28 deletions(-)

-- 
1.8.3.2.804.g0da7a53
