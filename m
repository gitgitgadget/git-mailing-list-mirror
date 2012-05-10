From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 0/4] git-notes ui fixes regarding non-blobs notes
Date: Thu, 10 May 2012 21:04:57 +0700
Message-ID: <1336658701-9004-1-git-send-email-pclouds@gmail.com>
References: <1336482692-30729-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 10 16:09:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSU36-0008Ki-UT
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 16:08:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759584Ab2EJOIp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 May 2012 10:08:45 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:51081 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759575Ab2EJOIo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 10:08:44 -0400
Received: by yhmm54 with SMTP id m54so1484909yhm.19
        for <git@vger.kernel.org>; Thu, 10 May 2012 07:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=YFBPXcNqw+CmzaGP67mJLwTW8lxgn0Mkr3U4QMRrMxE=;
        b=AXQbdC/Bor9VyRdqcVNpIIunDkgqXTfhEGo52PT0hW4tZT5qacsbQO6ugnA2Yd24kX
         2ScmmwwInaO/8lu23YSzmv5zvzrfWcJ0MUUzykAJSo/qbAGPAhdlPx10YuJtb8wi0uh8
         Wuqnpg2ipoQbjLXOTjTaw2ccp+mFleiCLFph7mfcp3kFOoNHgosMFXhszBbm0v5B1X8t
         2arUFaPikehXejggt8Gwvo4gomvV6S3jpyN3dc5dTOQxpnV2NQszkpIBRTW+iefgsAZo
         eek3ELSXvccUlmQcH4v2kpBiHrRjSODVHJyQq3SvnenP3tdYIe1zWCl9P4UfOChkvH/i
         vmRw==
Received: by 10.68.228.195 with SMTP id sk3mr8417507pbc.20.1336658923743;
        Thu, 10 May 2012 07:08:43 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.38.158])
        by mx.google.com with ESMTPS id oz9sm9614627pbc.68.2012.05.10.07.08.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 May 2012 07:08:42 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 10 May 2012 21:05:02 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1336482692-30729-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197565>

Thanks Jeff and Junio for all the comments. This is basically what you
(and I) agree in v1's thread. The first patch is a new one, to avoid
git-notes from converting everything to blobs. I don't restrict the
"show" case either because git-notes uses "git show", which is
capable of displaying all kinds of objects.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (4):
  notes: preserve object type given by "add -C"
  notes: "add -c" refuses to open an editor with non-blobs
  notes: refuse to edit non-blobs
  notes: refuse to append to non-blob notes

 builtin/notes.c  |   21 +++++++++++++++------
 t/t3301-notes.sh |   22 ++++++++++++++++++++++
 2 files changed, 37 insertions(+), 6 deletions(-)

--=20
1.7.8.36.g69ee2
