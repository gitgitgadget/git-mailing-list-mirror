From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCHv3 0/3] Fix patch detection for thunderbird saved mails
Date: Mon, 25 Jan 2010 16:33:56 -0800
Message-ID: <1264466039-22431-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Eric Blake <ebb9@byu.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 26 01:34:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZZNm-0003sS-Ub
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jan 2010 01:34:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207Ab0AZAeH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2010 19:34:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751122Ab0AZAeH
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jan 2010 19:34:07 -0500
Received: from mail-gx0-f217.google.com ([209.85.217.217]:51812 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751012Ab0AZAeF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2010 19:34:05 -0500
Received: by gxk9 with SMTP id 9so6019367gxk.8
        for <git@vger.kernel.org>; Mon, 25 Jan 2010 16:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=dkZWfxAqSekvFkPF5Fk5w+59LWRyxQop8RMh26aFFCs=;
        b=lvZrt6T35WB0rQgKhaXIgoSbZ1Ozv2+xWOeidAgQBf3uKlF91eUXI7ynkDyW9VqSRA
         l1TuflaJXWBpEwYzLaGjdPeNCrz6HaSOv1zZEu5rcX6ZcqaQ2GumPsR8BN73u0+GuSAV
         EK2CoUNxBxaM0/UzbnnvQq8cyn6jNP9g0RBaA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=AS28H9aXJuEZ033SxGTiJv5mdhwdtxwNys/5e0djY8m5YUBv/lS8e8CjMWjn4Q/sEY
         c8gR3fuDHB3vKVQZO7msNxwkzBedCzQwH1E7qQtDrLHXyjTANdSVyF5gJI5LHdTsrHYh
         2+7s54JViP3B6YMQfg0JsOixmEDRLHfcfcDOE=
Received: by 10.150.241.11 with SMTP id o11mr6090637ybh.112.1264466042166;
        Mon, 25 Jan 2010 16:34:02 -0800 (PST)
Received: from localhost (user-0c9haca.cable.mindspring.com [24.152.169.138])
        by mx.google.com with ESMTPS id 6sm1844010yxg.48.2010.01.25.16.34.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 25 Jan 2010 16:34:01 -0800 (PST)
X-Mailer: git-send-email 1.7.0.rc0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138012>

The original patch for this is a bit old (~1 month) but I'd like to see it
make it in. The first two patches are cleanup before the original patch in
the third spot. Now the test in patch 3 uses append_cr() instead of a hand
crafted version.

Stephen Boyd (3):
  tests: consolidate CR removal/addition functions
  t0022: replace non-portable literal CR
  am: fix patch format detection for Thunderbird "Save As" emails

 git-am.sh                     |    3 +-
 t/t0020-crlf.sh               |   55 +++++++++++++++-------------------------
 t/t0022-crlf-rename.sh        |    2 +-
 t/t3400-rebase.sh             |    4 ---
 t/t4012-diff-binary.sh        |    4 ---
 t/t4150-am.sh                 |   15 +++++++++++
 t/t6033-merge-crlf.sh         |    8 ------
 t/t9401-git-cvsserver-crlf.sh |    8 ------
 t/test-lib.sh                 |   16 ++++++++++++
 9 files changed, 55 insertions(+), 60 deletions(-)
