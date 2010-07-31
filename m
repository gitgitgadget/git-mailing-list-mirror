From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 0/5] nd/fix-sparse-checkout v2
Date: Sat, 31 Jul 2010 13:14:24 +0700
Message-ID: <1280556869-707-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 31 08:14:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Of5LT-000233-FQ
	for gcvg-git-2@lo.gmane.org; Sat, 31 Jul 2010 08:14:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754493Ab0GaGOn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 31 Jul 2010 02:14:43 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:61247 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753457Ab0GaGOm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jul 2010 02:14:42 -0400
Received: by pxi14 with SMTP id 14so799495pxi.19
        for <git@vger.kernel.org>; Fri, 30 Jul 2010 23:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=oO/brzdefH4dl9xe9+6YzAJMVLxWDTE4sJAm02Tl73c=;
        b=oY83U13+pyR661kbGKgCSV0H4NoMhhYKey4Ut4CknIQbtiC/iqeNYVe8V27NCTV7lA
         k8EkBmk7Bc1Z8fD1BLKjyRcdS+OeqTzjni0frSzN8mnsmk9ihBpIEkgtsbxb6khvjfbi
         Gl4KRAtvgaRqNzz8HFhMqw2WEhllrSV4CMCqY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=wsPu+UEbkGIlXUVaz/HL4lwk3csBdPoJkakxpVPtPBPrgTXGJwdjedB0xS20Ty6nbU
         2ymhJNlpDXycq0rxvEK+k43szbbA0CGUYbN24OFX8A7v77VMEwLn8NXQITRVqdbrRgFA
         PKJ9mHmtSQMgAunccdUE+Rs532BkOgIJE/I6o=
Received: by 10.114.39.20 with SMTP id m20mr1100094wam.205.1280556881866;
        Fri, 30 Jul 2010 23:14:41 -0700 (PDT)
Received: from dektop ([123.200.231.45])
        by mx.google.com with ESMTPS id k23sm5378008waf.17.2010.07.30.23.14.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 30 Jul 2010 23:14:40 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Sat, 31 Jul 2010 13:14:31 +0700
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152309>

Discussion of patch 1/3 from the first series resulted in 2/5 in this
series. 2/3 and 3/3 from the former have commit messages revised,
code change remains the same.

Jonathan Nieder (1):
  t1011 (sparse checkout): style nitpicks

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (4):
  unpack-trees: only clear CE_UPDATE|CE_REMOVE when skip-worktree is al=
ways set
  unpack-trees: let read-tree -u remove index entries outside sparse ar=
ea
  unpack-trees: do not check for conflict entries too early
  unpack-trees: mark new entries skip-worktree appropriately

 cache.h                              |    3 +-
 t/t1011-read-tree-sparse-checkout.sh |  123 +++++++++++++++++++++-----=
--------
 unpack-trees.c                       |   56 +++++++++-------
 3 files changed, 108 insertions(+), 74 deletions(-)
