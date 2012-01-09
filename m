From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 0/3] nd/index-pack-no-recurse
Date: Mon,  9 Jan 2012 10:59:03 +0700
Message-ID: <1326081546-29320-1-git-send-email-pclouds@gmail.com>
References: <1324901080-23215-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 09 04:59:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rk6Oa-0002J7-EL
	for gcvg-git-2@lo.gmane.org; Mon, 09 Jan 2012 04:59:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755365Ab2AID7R convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Jan 2012 22:59:17 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:35276 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755361Ab2AID7R (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jan 2012 22:59:17 -0500
Received: by iaeh11 with SMTP id h11so6123831iae.19
        for <git@vger.kernel.org>; Sun, 08 Jan 2012 19:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=uMSCNkFidV2KoIDzfGPqt2dGWSLF9UBWXxXqELJ8MfQ=;
        b=p7lNfnT4d42fdcYyKs1Vkpu3iI5Ad2UTRfoh/YYR1GbONIetoQ0MyCe7gq8CfC/qtW
         wxD7XlPRpTGfbqUCoLkCzudRbZDIOKafvHSekf9NWoQYclNBCk9bETvyAlISedAyrPNJ
         14XYugudvdQj7R7aYgrIOBkGyoqUxq3QJOfmA=
Received: by 10.50.45.195 with SMTP id p3mr7808990igm.2.1326081556472;
        Sun, 08 Jan 2012 19:59:16 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id q30sm30040036ibc.1.2012.01.08.19.59.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 08 Jan 2012 19:59:15 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 09 Jan 2012 10:59:07 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1324901080-23215-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188155>

Resend to incorporate the fixup commit from pu, no other changes.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (3):
  Eliminate recursion in setting/clearing marks in commit list
  index-pack: eliminate recursion in find_unresolved_deltas
  index-pack: eliminate unlimited recursion in get_delta_base()

 builtin/index-pack.c |  141 ++++++++++++++++++++++++++++++++----------=
--------
 commit.c             |   13 ++++-
 revision.c           |   45 ++++++++++------
 3 files changed, 131 insertions(+), 68 deletions(-)

--=20
1.7.3.1.256.g2539c.dirty
