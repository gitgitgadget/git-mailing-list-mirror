From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 0/3] dt/untracked-subdir
Date: Wed, 19 Aug 2015 20:01:23 +0700
Message-ID: <1439989286-24355-1-git-send-email-pclouds@gmail.com>
References: <1439702227-15453-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Turner <dturner@twopensource.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 19 15:01:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZS2zn-00048I-VS
	for gcvg-git-2@plane.gmane.org; Wed, 19 Aug 2015 15:01:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbbHSNBb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Aug 2015 09:01:31 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:33346 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751056AbbHSNBb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2015 09:01:31 -0400
Received: by pabyb7 with SMTP id yb7so2942849pab.0
        for <git@vger.kernel.org>; Wed, 19 Aug 2015 06:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=6/qD6MKh41UMvW8XuZeQMcZ/klRoKv/WAIOEJt8HLBA=;
        b=nNkfNYb6M3JjoBLCmkutpTlecT3iHHpdBpmkbPkkP8XmwdMEpSntMbu8PJafebE0nw
         ZPi+RaCjX/SQshep+cf3Vv85TevsIB5wpIYcCNvxvXJLBcII+wyjct7TkiRXXy1Hrdd3
         IBj+pvxs7/kp+UzTAp22aAIvXbLC3m03XXIHY38iikGjmEnTBSS1X0nv3REODVAGvJvu
         TAklYDyjv2KByhJjJkKbPVuQcG+y3L+pHlrjDElcbNRfAGQ4xfPVWBJiDFRuaqlXqjps
         sIl/MWt5KFcH4Zrc5y11BmfMHbUiCD3GbfA9fXMWarFsedDspzSj61yXeDC2LGO8C97L
         4+sg==
X-Received: by 10.66.232.102 with SMTP id tn6mr24145280pac.47.1439989290344;
        Wed, 19 Aug 2015 06:01:30 -0700 (PDT)
Received: from lanh ([171.232.84.126])
        by smtp.gmail.com with ESMTPSA id jw13sm837790pad.48.2015.08.19.06.01.27
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Aug 2015 06:01:29 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 19 Aug 2015 20:01:27 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1439702227-15453-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276173>

The first patch is a split from David's v3 patch because it should
belong to dt/untracked-sparse. The second is basically David's v3.
The third patch fixes untracked_cache_invalidate_path(). David fixed
it in v2, but there's another bug in this code.

David Turner (1):
  untracked-cache: fix subdirectory handling

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (2):
  t7063: use --force-untracked-cache to speed up a bit
  untracked cache: fix entry invalidation

 dir.c                             |  82 +++++++++++++++++++++++-------
 t/t7063-status-untracked-cache.sh | 102 ++++++++++++++++++++++++++++++=
++++++--
 2 files changed, 163 insertions(+), 21 deletions(-)

--=20
2.3.0.rc1.137.g477eb31
