From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 0/3] git-commit rejects messages with NULs
Date: Wed, 14 Dec 2011 21:08:16 +0700
Message-ID: <1323871699-8839-1-git-send-email-pclouds@gmail.com>
References: <1323777368-19697-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Miles Bader <miles@gnu.org>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 14 15:08:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RapVY-000298-VP
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 15:08:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757267Ab1LNOI2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Dec 2011 09:08:28 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:34174 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757207Ab1LNOI1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2011 09:08:27 -0500
Received: by ghbz12 with SMTP id z12so638879ghb.19
        for <git@vger.kernel.org>; Wed, 14 Dec 2011 06:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=WQ2ts052phRhJPVBSeCbIntui6Fi6DRpIFF73BZC5Gk=;
        b=KEfAhaJeykbv9ceXKctY2NYpv+jZpAIbNEzwuJjbcCJU3YItW4w7g/cRTBCIjcvcLM
         JnnQknRN1Sn8xmlubP6bzdQ1HuDN1FSP65hRS74MW3xB8aUYju25mv7rSAcJHFz/4OXQ
         blvb3c+P0VMVDTx5ZTmZlFrkXDJn5JVPf4tOs=
Received: by 10.50.184.230 with SMTP id ex6mr24719537igc.78.1323871706952;
        Wed, 14 Dec 2011 06:08:26 -0800 (PST)
Received: from tre ([115.74.57.162])
        by mx.google.com with ESMTPS id wn1sm4754018igc.3.2011.12.14.06.08.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 14 Dec 2011 06:08:25 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Wed, 14 Dec 2011 21:08:23 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1323777368-19697-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187116>

Hi,

I'm sorry I forgot the patch that makes commit_tree() take message
length. This version rewords the error message and use memchr()
instead.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (3):
  Make commit_tree() take message length in addition to the commit
    message
  merge: abort if fails to commit
  Do not create commits whose message contains NUL

 Documentation/config.txt |    4 ++++
 advice.c                 |    2 ++
 advice.h                 |    1 +
 builtin/commit-tree.c    |    2 +-
 builtin/commit.c         |    2 +-
 builtin/merge.c          |    8 ++++++--
 builtin/notes.c          |    2 +-
 commit.c                 |   13 +++++++++++--
 commit.h                 |    2 +-
 notes-cache.c            |    2 +-
 notes-merge.c            |    8 ++++----
 notes-merge.h            |    2 +-
 t/t3900-i18n-commit.sh   |    6 ++++++
 t/t3900/UTF-16.txt       |  Bin 0 -> 32 bytes
 14 files changed, 40 insertions(+), 14 deletions(-)
 create mode 100644 t/t3900/UTF-16.txt

--=20
1.7.8.36.g69ee2
