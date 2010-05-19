From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: [PATCH v5 0/4] EOL conversion series, take 5
Date: Wed, 19 May 2010 22:43:08 +0200
Message-ID: <cover.1274301351.git.eyvind.bernhardsen@gmail.com>
Cc: msysGit <msysgit@googlegroups.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 19 22:43:25 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OEq6u-0005Dv-VI
	for gcvg-git-2@lo.gmane.org; Wed, 19 May 2010 22:43:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753541Ab0ESUnT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 May 2010 16:43:19 -0400
Received: from mail-ew0-f216.google.com ([209.85.219.216]:36733 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752098Ab0ESUnS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 May 2010 16:43:18 -0400
Received: by ewy8 with SMTP id 8so2831435ewy.28
        for <git@vger.kernel.org>; Wed, 19 May 2010 13:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=WuHp6Q7Dmx0r0fapX7lrJ7ARpiB5JhKrFez3VlaU+bI=;
        b=uCuUWgNG1rqttEq6ygl+PGGgmp51GL/7DgXn4sUNvwBWn037PtvVYoOlet/Crx0EyV
         486ShYoI3NNC+EODJ70Juk3QmR/pOu83kpvUtGYtYl5TIhxSMkGoZ9l7SAMlfv0NOBbR
         C7C/uip36LRWufa//uA9YlIzaRtSqldcUNKeU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=jm+lnbmHC+zfv6e2Y/vGGLGXgu0mzhrK98ZKLgCHwOiyk9cKnS+awRKO309XGwRX0v
         WeJzPCB021kKI0ldzEZasz50+1Ltta92V+cfJBxgw5H5IkodZZU8udJDn34zbP9jpFTp
         YwPx8R1/+AWWTA2flLMVQod9FxsCvGGK/pkQE=
Received: by 10.213.42.19 with SMTP id q19mr3825114ebe.50.1274301797001;
        Wed, 19 May 2010 13:43:17 -0700 (PDT)
Received: from localhost.localdomain (eyvind.bernhardsens.net [84.49.224.5])
        by mx.google.com with ESMTPS id 13sm3814591ewy.9.2010.05.19.13.43.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 19 May 2010 13:43:15 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.5.gc3ee8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147341>

This is a resend of the latest crlf fix/rename series, including the
final "add core.eol" config variable patch and some minor fixes to the
tests.  I didn't include Finn Arne's "safe autocrlf" patch this time,
but it is still required.
-- 
Eyvind


Eyvind Bernhardsen (4):
  Add tests for per-repository eol normalization
  Add per-repository eol normalization
  Rename the "crlf" attribute "text"
  Add "core.eol" config variable

 Documentation/config.txt        |   28 +++++--
 Documentation/git-cvsserver.txt |   13 +--
 Documentation/gitattributes.txt |  167 +++++++++++++++++++++++++++++++--------
 Makefile                        |    3 +
 attr.c                          |    2 +-
 cache.h                         |   22 +++++-
 config.c                        |   18 ++++-
 convert.c                       |  148 ++++++++++++++++++++++++++---------
 environment.c                   |    3 +-
 git-cvsserver.perl              |   13 ++-
 t/t0025-crlf-auto.sh            |  155 ++++++++++++++++++++++++++++++++++++
 t/t0026-eol-config.sh           |   83 +++++++++++++++++++
 12 files changed, 562 insertions(+), 93 deletions(-)
 create mode 100755 t/t0025-crlf-auto.sh
 create mode 100755 t/t0026-eol-config.sh
