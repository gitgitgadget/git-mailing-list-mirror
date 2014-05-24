From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH v9 0/2] format-patch --signature-file=<file>
Date: Fri, 23 May 2014 21:08:12 -0700
Message-ID: <cover.1400904004.git.jmmahler@gmail.com>
Cc: git@vger.kernel.org, Jeremiah Mahler <jmmahler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 24 06:08:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wo3G6-0002ZA-9r
	for gcvg-git-2@plane.gmane.org; Sat, 24 May 2014 06:08:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750848AbaEXEIa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 May 2014 00:08:30 -0400
Received: from mail-pb0-f41.google.com ([209.85.160.41]:34908 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750713AbaEXEIa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 May 2014 00:08:30 -0400
Received: by mail-pb0-f41.google.com with SMTP id uo5so5054578pbc.28
        for <git@vger.kernel.org>; Fri, 23 May 2014 21:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=borAd11cHpSmfCskchPy/yx1ETvPBGNX7M3nc/gvqfM=;
        b=uYnWtAoIFbQaA9J4FSep6NCRu012uLB5umBqs7JXA5XRjvO/T76ss9b2JdeO+Iiv3L
         X0DEmdDojkMrkbvrJ2V0eZBQkTc/ykyxOMUWfCta2deyi/2eo578LIhmyf2wKiTsGmX9
         u7gf3WUwZUR1eoGHG16AbBUhDJlRyrpBRxEl5hxSdXA5gEgiK7vbecRma1dpWc8rzDqd
         jLoP5lXX6p4KPemM/kHOOn1G/ob93LFlpXQShSVLvKxw5rwRYxp6HCQy1t7YWfnSAn8V
         /wFvQlNNRYr3rxlH/Ik4mnVDOI7WBsgwJyxzPr7rPaLUBuFJYuta8usivihuheRt6TEr
         y3Ew==
X-Received: by 10.67.13.134 with SMTP id ey6mr11268309pad.44.1400904509617;
        Fri, 23 May 2014 21:08:29 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id zq5sm7068422pbb.37.2014.05.23.21.08.26
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 23 May 2014 21:08:28 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Fri, 23 May 2014 21:08:25 -0700
X-Mailer: git-send-email 2.0.0.rc2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250052>

v9 of patch to add format-patch --signature-file <file> option.

This revision includes more suggestions from Junio C Hamano.

  - Reworded patch description.  Using "special characters" is
	not a feature of this patch.

  - Changed patch description to follow gitcli(7) guidlines.
    "--signature-file=name" instead of "--signature-file name"

  - Reduced set of crucial test cases.

    --signature-file works

    format.signaturefile works

    --no-signature suppresses format.signaturefile

    --signature-file overrides format.signaturefile

    --signature overrides format.signaturefile

  - Note, the control logic had to be re-worked to satisfy these test cases.


Jeff King (1):
  format-patch: make newline after signature conditional

Jeremiah Mahler (1):
  format-patch --signature-file=<file>

 Documentation/config.txt           |  4 +++
 Documentation/git-format-patch.txt |  4 +++
 builtin/log.c                      | 26 ++++++++++++++--
 t/t4014-format-patch.sh            | 61 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 93 insertions(+), 2 deletions(-)

-- 
Jeremiah Mahler
jmmahler@gmail.com
http://github.com/jmahler
