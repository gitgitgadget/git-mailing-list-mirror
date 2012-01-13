From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 00/10] nd/clone-detached
Date: Fri, 13 Jan 2012 14:21:52 +0700
Message-ID: <1326439322-15648-1-git-send-email-pclouds@gmail.com>
References: <1326189427-20800-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 13 08:22:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlbSt-0007qa-2K
	for gcvg-git-2@lo.gmane.org; Fri, 13 Jan 2012 08:22:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752504Ab2AMHWO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Jan 2012 02:22:14 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:35052 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752214Ab2AMHWO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jan 2012 02:22:14 -0500
Received: by iabz25 with SMTP id z25so3939442iab.19
        for <git@vger.kernel.org>; Thu, 12 Jan 2012 23:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=P2iFZtLZViTeYGKuX0+BJRssHNDrjPYd0iItFL5AljE=;
        b=c2IuH9VKYYS6JYN+JB+oezhjhON4pZVYhMCc9UrNEZ1NobBpZM4BcT0X7njMQ5fNDF
         5TR0hkfdF1dvrQOSa2ovIqX/60wJtAbNRgMGX7xlgpJicyVuYCT3f2MXDrthjX9OaXO3
         nHyKnmdOS8CF8ICpw+BiPQJSTbRQ1jTRvLZN8=
Received: by 10.50.180.138 with SMTP id do10mr1452741igc.20.1326439333544;
        Thu, 12 Jan 2012 23:22:13 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id pb6sm13076511igc.5.2012.01.12.23.22.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 12 Jan 2012 23:22:12 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 13 Jan 2012 14:22:02 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1326189427-20800-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188497>

Some comment updates after discussion and squash in the fixup patch.
The code is exactly the same as nd/clone-detached in pu.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (10):
  t5601: add missing && cascade
  clone: write detached HEAD in bare repositories
  clone: factor out checkout code
  clone: factor out HEAD update code
  clone: factor out remote ref writing
  clone: delay cloning until after remote HEAD checking
  clone: --branch=3D<branch> always means refs/heads/<branch>
  clone: refuse to clone if --branch points to bogus ref
  clone: allow --branch to take a tag
  clone: print advice on checking out detached HEAD

 Documentation/git-clone.txt |    5 +-
 advice.c                    |   14 +++
 advice.h                    |    1 +
 builtin/checkout.c          |   16 +---
 builtin/clone.c             |  256 +++++++++++++++++++++++++----------=
--------
 t/t5601-clone.sh            |   40 ++++++-
 t/t5706-clone-branch.sh     |    8 +-
 transport.c                 |    5 +-
 8 files changed, 211 insertions(+), 134 deletions(-)

--=20
1.7.3.1.256.g2539c.dirty
