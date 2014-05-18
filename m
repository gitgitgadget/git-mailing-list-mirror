From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH v4] format-patch --signature-file <file>
Date: Sun, 18 May 2014 13:22:01 -0700
Message-ID: <1400444522-15523-1-git-send-email-jmmahler@gmail.com>
Cc: git@vger.kernel.org, Jeremiah Mahler <jmmahler@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun May 18 22:22:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wm7bK-0005zc-0L
	for gcvg-git-2@plane.gmane.org; Sun, 18 May 2014 22:22:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751972AbaERUWS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 May 2014 16:22:18 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:52865 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751839AbaERUWR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 May 2014 16:22:17 -0400
Received: by mail-pa0-f44.google.com with SMTP id ld10so4799668pab.31
        for <git@vger.kernel.org>; Sun, 18 May 2014 13:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=OwsW5ZdLCFrUkjC0vNkS42IVi/mM5tCvBn20GwRZmfQ=;
        b=eQsQEdhGMN98XHaAVU4oeO8eQUNdFUen46lVNWKnLW2eFouDhyve1S6jCef/8cc3k6
         RSBEaxKsd5Etco/bGsCztri3Ilnh9bsVzavGThbA84gHVoyyi5JouYGoc7M98kwXXbis
         R3aNP7tA/7cPFInxnUUd5lPkx+/7kfbac0tvcz5CC3Ay9cTNNfFMImNT0pVqrR/nbEVo
         hlN0KKMRtZEphj6FPQ5spJRsFJ/rwGU+5+t6WDtWsPNPVqWOGMy7VJpHPLJyyIjD8OQ9
         EtTFtecKAhEjJWVnhbbPEZPXQHV5HxZUCcodv/0DRa/ABTzygcOY7FNA01GDpPoPVVyH
         mVTg==
X-Received: by 10.68.93.3 with SMTP id cq3mr37894517pbb.145.1400444537457;
        Sun, 18 May 2014 13:22:17 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id og3sm26121661pbc.48.2014.05.18.13.22.13
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 18 May 2014 13:22:15 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Sun, 18 May 2014 13:22:12 -0700
X-Mailer: git-send-email 2.0.0.rc3.4.g6308767.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249507>

v4 of patch to add format-patch --signature-file <file> option.

This revision includes more suggestions from Jeff King:

  - Added a format.signaturefile config option.

  - Fixed error messages, --signature and format.signature

  - Fixed error checking, dies if strbuf_read_file fails.

  - style: "cat > expect << EOF" to "cat >expect <<-\EOF"

  - Eliminated use of fgrep, which is not used anywhere else
	in the project.  Possibility of portability problems.
    Replaced with sed which is commonly used.

  - Eliminated use of diff in favor of test_cmp.

  - Removed redundant test, "--foo=bar" and "--foo bar"

  - Changed to use test_must_fail instead of "!"

Jeremiah Mahler (1):
  format-patch --signature-file <file>

 Documentation/config.txt           |  4 ++++
 Documentation/git-format-patch.txt |  4 ++++
 builtin/log.c                      | 16 ++++++++++++++++
 t/t4014-format-patch.sh            | 33 +++++++++++++++++++++++++++++++++
 4 files changed, 57 insertions(+)

-- 
Jeremiah Mahler
jmmahler@gmail.com
http://github.com/jmahler
