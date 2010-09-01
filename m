From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 01/13] git-clone: use builtin.h to get gettext.h
Date: Wed,  1 Sep 2010 20:43:53 +0000
Message-ID: <1283373845-2022-2-git-send-email-avarab@gmail.com>
References: <1283373845-2022-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 01 22:44:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OquAd-0006jZ-3C
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 22:44:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753152Ab0IAUob convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Sep 2010 16:44:31 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:54032 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752292Ab0IAUo3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Sep 2010 16:44:29 -0400
Received: by mail-ww0-f44.google.com with SMTP id 40so478054wwj.1
        for <git@vger.kernel.org>; Wed, 01 Sep 2010 13:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=l8VS/ULR+jRu4ibpCrnFOX8OAVdb3uoAv+1obXAP5v0=;
        b=cSDyLih0KSefgfLx0UwGsSex2mdLjZBm3WSb5K+81zMMJ5wTcajYvzbo0rrZX92tUD
         dvEEMBn/5UJnbFPDHJpsTTxe8lI9hG3HwK15k9TSttsAe6XiFurZBRZ8KVe1IScNSFTM
         sDl8eSk7CpKE7ZjnrOwn4el8hSHso+BCnXOHY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=dAcRnkdTqRk+j7LFuEuLo1Wxme2FP9KY4R6VomQrqCjQJonGT7oyPMZtckmpd3TBja
         YFLcZ8XPdln7Ot3ofUeUsAl76aDRcqtpZXxFwOGsUcRDZ2wre6rRtgAOwmfZwblghEkF
         lypPLADau2HBEliiInRakJ0hKQu3rhRBVOtis=
Received: by 10.216.17.211 with SMTP id j61mr8390029wej.14.1283373868616;
        Wed, 01 Sep 2010 13:44:28 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id v11sm6461150weq.16.2010.09.01.13.44.27
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 01 Sep 2010 13:44:27 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.579.g2183d
In-Reply-To: <1283373845-2022-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155078>

Change builtin/clone.c to use builtin.h. The only other command in
'mainporcelain common' which doesn't include it yet is builtin/reset.c

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---

This is just here so that the series applies stand-alone to pu. It's
made redundant by my "[PATCH] builtin: use builtin.h for all builtin/
commands" patch, but Junio expressed some reservations about it, so
here's a more minimal version sufficient for this series.

 builtin/clone.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 19ed640..994d527 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -8,7 +8,7 @@
  * Clone a repository into a different directory that does not yet exi=
st.
  */
=20
-#include "cache.h"
+#include "builtin.h"
 #include "parse-options.h"
 #include "fetch-pack.h"
 #include "refs.h"
@@ -16,7 +16,6 @@
 #include "tree-walk.h"
 #include "unpack-trees.h"
 #include "transport.h"
-#include "strbuf.h"
 #include "dir.h"
 #include "pack-refs.h"
 #include "sigchain.h"
--=20
1.7.2.2.579.g2183d
