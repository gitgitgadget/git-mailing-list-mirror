From: =?utf-8?q?Santi=20B=C3=A9jar?= <sbejar@gmail.com>
Subject: [PATCH 0/3] Show author and/or committer in some cases
Date: Wed, 30 Apr 2008 10:47:13 +0200
Message-ID: <1209545236-4266-1-git-send-email-sbejar@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Santi=20B=C3=A9jar?= <sbejar@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 30 10:48:16 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jr7z5-0002XP-FX
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 10:48:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757107AbYD3Ir2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2008 04:47:28 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756834AbYD3Ir2
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 04:47:28 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:27396 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755179AbYD3Ir1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2008 04:47:27 -0400
Received: by nf-out-0910.google.com with SMTP id d3so194568nfc.21
        for <git@vger.kernel.org>; Wed, 30 Apr 2008 01:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer;
        bh=irj0l0r+WiubZ0A7i8qLlADkKiyFdsxa9QRsHVI8u9o=;
        b=b1IUUe73G74bnfCdRl0aiGIOMlZQD4upN0beWnr9u8c2LvWeJD2KRt6N5xQB2guPveWKdEgX2iX9CuL3YSMQV1ncgLAx3VyhhYgS4yp0bWabomwK1dxBFGdQuR7/GnVvt8OlrNKlujXempytLvWjtsnn6dIdBhZEqX053j/SwdE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=DwZdk9E+4yTR3DOXaLGsKQTvUoqPSSwrRcxIliFJTYXmdB8zT3QI+QP0jeOYNhmVOakCpBnoJSV/d6PqfC92WLOV9a7yTGEuesjCzk1iESGpB8oX+2ciZKzRpaFUWUcBINzfeAXgL5x3KlAbw6P2KuavX8FKikDov7A/vV2Fs/k=
Received: by 10.210.11.13 with SMTP id 13mr409807ebk.142.1209545244176;
        Wed, 30 Apr 2008 01:47:24 -0700 (PDT)
Received: from localhost ( [91.13.102.119])
        by mx.google.com with ESMTPS id u9sm2270533muf.12.2008.04.30.01.47.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 30 Apr 2008 01:47:23 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1.148.g37726
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80812>

Hi *,

  This patch series tries to make more evident the author and committer=
 ident
used in a commit trying to be minimize when it is shown.

Santi

Santi B=C3=A9jar (3):
  Preparation to call determine_author_info from prepare_to_commit
  commit: Show author if different from committer
  commit: Show the committer ident when is different from the parent

 builtin-commit.c  |  127 ++++++++++++++++++++++++++++++++++++---------=
--------
 t/t7502-commit.sh |   22 +++++++++
 2 files changed, 109 insertions(+), 40 deletions(-)
