From: =?utf-8?q?Santi=20B=C3=A9jar?= <sbejar@gmail.com>
Subject: [PATCHv4 0/4] Show author and/or committer in some cases
Date: Sun,  4 May 2008 18:04:48 +0200
Message-ID: <1209917092-12146-1-git-send-email-sbejar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Santi=20B=C3=A9jar?= <sbejar@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 04 18:06:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jsgim-00071e-QT
	for gcvg-git-2@gmane.org; Sun, 04 May 2008 18:05:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288AbYEDQFE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 May 2008 12:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbYEDQFD
	(ORCPT <rfc822;git-outgoing>); Sun, 4 May 2008 12:05:03 -0400
Received: from fk-out-0910.google.com ([209.85.128.189]:54680 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750871AbYEDQFB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2008 12:05:01 -0400
Received: by fk-out-0910.google.com with SMTP id 18so338389fkq.5
        for <git@vger.kernel.org>; Sun, 04 May 2008 09:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        bh=NyGyu4t9Uf/a2nF6iCLehzp9+ehHFMvSmqu/XFCcjMI=;
        b=TxESnMgz3ivgydAFjNzWdc8DaQsceX/bfr6OZR6T+Vkp2y5J0KfKva3a051thJWimrlY7ECyuniIM8e79nBA/hcw8S3RDfTeEhb34lek2WA0dXVUajY1oLDWRF762Oqr65RpSXvAnPTx7z5YmyonHRarMYwwKjtrM/4j6Heme1Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=abuFhBEt6wkxlId7g4CHigMkiIfADCFpQ6vaUcQJWMuYV94uDwjhdx5Z55SypQEfmKdHMckFOqM06a5CaMNjDuyUUBD1qg2ZuUteVEWPsLQp7TcuVnz/Xy/pXyHdrnZiFdl+OkfLqiR3pGFuUK3A+KD2eoDR3g97OuMeldmlWgo=
Received: by 10.86.53.8 with SMTP id b8mr9847218fga.5.1209917100190;
        Sun, 04 May 2008 09:05:00 -0700 (PDT)
Received: from localhost ( [91.13.106.248])
        by mx.google.com with ESMTPS id 12sm4341896fgg.0.2008.05.04.09.04.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 04 May 2008 09:04:59 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1.224.gadb29
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81177>

Hi *,

  This patch series tries to make more evident the author and committer=
 ident
in case the user might be using an unintended author/committer identity=
=2E

Santi

Santi B=C3=A9jar (4):
  Preparation to call determine_author_info from prepare_to_commit
  commit: Show author if different from committer
  commit: Show committer if automatic
  user.warnautomatic: add config to control if the committer ident is
    shown

 Documentation/config.txt |    4 ++
 builtin-commit.c         |  112 +++++++++++++++++++++++++++++---------=
-------
 cache.h                  |    2 +
 config.c                 |    9 ++++
 environment.c            |    2 +
 ident.c                  |    3 +
 t/t7502-commit.sh        |   38 ++++++++++++++++
 7 files changed, 130 insertions(+), 40 deletions(-)
