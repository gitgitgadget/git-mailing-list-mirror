From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 0/4] Improve "remote show" output
Date: Thu, 19 Feb 2009 00:14:27 -0500
Message-ID: <1235020471-59982-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 19 06:16:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1La1Gj-0005K5-5k
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 06:16:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750982AbZBSFOg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 00:14:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750914AbZBSFOf
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 00:14:35 -0500
Received: from yx-out-2324.google.com ([74.125.44.30]:42066 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750794AbZBSFOf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 00:14:35 -0500
Received: by yx-out-2324.google.com with SMTP id 8so102372yxm.1
        for <git@vger.kernel.org>; Wed, 18 Feb 2009 21:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=jv7QFu/KZJ2l2u1EwvBDFHr6D4Ba1qMPQhkv38TBkt8=;
        b=pj9bgKv7pvw8n0vbriJBp5KttMSdyHYQdINQ6cCj4skarmsHg6ixjLyYkkC+OpTMzd
         jL1tzfrZ+bhGvOXaBBAR7zKxu7TSMAyvuMrFUivPFXLiHeum5WyeIiqHar7ChwiwAwGV
         lJA1QwYnaGrSh/5qb0nLvPfBM0hteVBjw0Rfk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=UOrptYRqPDKvh6dJ4TyIT5gwMaKj4F7bjFtgrB6zS+TOxysmaG27Ee96hPLqrVPfZr
         yOvFMieI4r8GySO+i7vIYLksdEaDnQAY5bwNu2rfZeG/mYPrYp9QWTAgb+g3S5slONUP
         bvbKabw36Wyp2MbxzuMd5C3dLjairB3HNASz0=
Received: by 10.151.107.8 with SMTP id j8mr592867ybm.183.1235020473797;
        Wed, 18 Feb 2009 21:14:33 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id s30sm2035370elf.11.2009.02.18.21.14.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 18 Feb 2009 21:14:33 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.218.g1b4fab
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110625>

This patch series was inspired by
http://thread.gmane.org/gmane.comp.version-control.git/109301/

I've based it on pu.

Jay Soffian (4):
  remote: minor code cleanups in preparation for changing "show" output
  remote: move append_ref_to_tracked_list to get rid of prototype
  string-list: add for_each_string_list()
  remote: new show output style

 builtin-remote.c  |  232 +++++++++++++++++++++++++++++++++++------------------
 string-list.c     |   10 +++
 string-list.h     |    5 +
 t/t5505-remote.sh |   32 ++++----
 4 files changed, 184 insertions(+), 95 deletions(-)
