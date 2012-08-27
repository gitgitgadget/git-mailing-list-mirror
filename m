From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v2 0/7] Gettext poison fixes
Date: Mon, 27 Aug 2012 13:36:48 +0800
Message-ID: <cover.1346045253.git.worldhello.net@gmail.com>
References: <1345523464-14586-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 27 07:37:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T5s0d-0002qE-Eu
	for gcvg-git-2@plane.gmane.org; Mon, 27 Aug 2012 07:37:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751928Ab2H0FhD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Aug 2012 01:37:03 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:57439 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751882Ab2H0FhB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2012 01:37:01 -0400
Received: by pbbrr13 with SMTP id rr13so6802416pbb.19
        for <git@vger.kernel.org>; Sun, 26 Aug 2012 22:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=MSqwpzfENtrUS4lJOdXRQEnhcnfZlIdyhwxuULu0w4M=;
        b=gCwGSyOc9MfEnCmJEzkp66UXAHeqDKbK5zt9FhNN0Cjve7ArJ4o8lqa2lQxuPIiIWs
         X0yD3KCuz5psCcoR9Kj6kd+pdvU0GWsHFOGG8y8JiJbWtmFHzeYfmTATzV0beA79xbdc
         upk73HiZ4muTXquCreaA8MU5nYzIgH0lTBF0myXhGESCOwUPf3kDZMMAK3F3jZif/B74
         7+5Jtlk/eun9d6iCBh0kzgOkegF6A+w5B65s8ScSdhTYo25aPjvLAfH2l3Y17YWoHoIN
         ZRJsrndSTIHN56FVxADuxpajne55dV9+0ML2geJlFN3c+0nYWOTRsXoiwI9WWlzmUKWf
         WjDw==
Received: by 10.68.242.231 with SMTP id wt7mr31319941pbc.99.1346045820557;
        Sun, 26 Aug 2012 22:37:00 -0700 (PDT)
Received: from localhost.foo.bar ([123.116.231.150])
        by mx.google.com with ESMTPS id gf3sm13924207pbc.74.2012.08.26.22.36.55
        (version=SSLv3 cipher=OTHER);
        Sun, 26 Aug 2012 22:36:59 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.92.gaa91cb5
In-Reply-To: <1345523464-14586-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204319>

Update patch 5/7 (Fix tests under GETTEXT_POISON on pack-object)
and patch 6/7 (Fix tests under GETTEXT_POISON on git-remote) in
this new series of patches.

Not much to say. With this series, the test suite should pass again with
gettext poison on. It's independent with the parseopt-i18n series I
sent yesterday as the test suite was broken even before.

Jiang Xin (7):
  Fix tests under GETTEXT_POISON on relative dates
  Fix tests under GETTEXT_POISON on git-stash
  Fix tests under GETTEXT_POISON on diffstat
  Fix tests under GETTEXT_POISON on git-apply
  Fix tests under GETTEXT_POISON on pack-object
  Fix tests under GETTEXT_POISON on git-remote
  Fix tests under GETTEXT_POISON on parseopt

 t/t0006-date.sh                 |  2 +-
 t/t0040-parse-options.sh        | 34 +++++++++++++++++++++++++++++-----
 t/t1300-repo-config.sh          |  2 +-
 t/t1502-rev-parse-parseopt.sh   |  2 +-
 t/t2006-checkout-index-basic.sh |  4 ++--
 t/t2107-update-index-basic.sh   |  4 ++--
 t/t3004-ls-files-basic.sh       |  4 ++--
 t/t3200-branch.sh               |  4 ++--
 t/t3501-revert-cherry-pick.sh   |  4 ++--
 t/t3903-stash.sh                |  2 +-
 t/t4006-diff-mode.sh            |  8 ++++----
 t/t4012-diff-binary.sh          |  4 ++--
 t/t4120-apply-popt.sh           |  4 ++--
 t/t4133-apply-filenames.sh      |  4 ++--
 t/t4200-rerere.sh               |  4 ++--
 t/t4202-log.sh                  |  2 +-
 t/t4205-log-pretty-formats.sh   |  4 ++--
 t/t5300-pack-object.sh          |  4 ++--
 t/t5505-remote.sh               | 28 +++++++++++++++++-----------
 t/t5530-upload-pack-error.sh    |  4 ++--
 t/t6500-gc.sh                   |  4 ++--
 t/t7508-status.sh               |  2 +-
 t/t7600-merge.sh                |  2 +-
 23 files changed, 83 insertions(+), 53 deletions(-)

-- 
1.7.12.92.gaa91cb5
