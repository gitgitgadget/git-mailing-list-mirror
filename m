From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/2] branch: improve verbose option
Date: Fri, 30 Aug 2013 17:59:41 -0500
Message-ID: <1377903583-3550-1-git-send-email-felipe.contreras@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 31 01:04:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFXjv-0006Tk-3g
	for gcvg-git-2@plane.gmane.org; Sat, 31 Aug 2013 01:04:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756565Ab3H3XEX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Aug 2013 19:04:23 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:62109 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756238Ab3H3XEV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Aug 2013 19:04:21 -0400
Received: by mail-ob0-f174.google.com with SMTP id wd6so2494042obb.33
        for <git@vger.kernel.org>; Fri, 30 Aug 2013 16:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=zrN/NLEtrffSJO5XP8qMcQ2p5+3K4gVghRhoe8E2P64=;
        b=NSnx6aaCCn3p6xBNjfMN21MgSDFrn+5k49YgXnxx8IEdsUtFzRVMCG0N1RE9dcAepB
         xgpuX/1RWatZSW7WWJEheMc9GghI1MizDGHAsRtwmTrMyWpqdhJQh2Yp/TA6M7fh1xtg
         VobGqCSuWXY8CdHZkDK6DUS22EB7wwwlTxEPV2fOUkkh0SxdCjzLAyu9yFpj5TsEs3QE
         1SvpxuGV1PcS503hNzJOgGvZXkDRnViBY6q3woOKmUo6vyhgiQ1ZiTdxfpi7Og0FwS7X
         9xnu6vGnn2U1pV95+qgSqlp+NqNDxaEapyOV6Oomf2EXbgj19iML5tuDv453ayYwfjBn
         n4jA==
X-Received: by 10.182.29.198 with SMTP id m6mr8633349obh.105.1377903861103;
        Fri, 30 Aug 2013 16:04:21 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id s14sm435512oeo.1.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 30 Aug 2013 16:04:20 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233480>

Hi,

This has been discussed before:

http://thread.gmane.org/gmane.comp.version-control.git/224489

but in the spirit of the perfect being the enemy of the good, nothing got done.

This series makes 'git branch -v' much faster, and gives us the most important
information; the configured upstream tracking branch. Showing ahead/behind is
not as important, specially considering that currently 'git branch -v' doesn't
show the branch we are comparing the ahead/behind to.

Strictly speaking it's a regression, but nobody would complain, and if somebody
does, it should be easy to revert if needed.

Felipe Contreras (2):
  branch: trivial cleanup
  branch: reorganize verbose options

 builtin/branch.c         | 33 +++++++++++++++------------------
 t/t6040-tracking-info.sh |  8 ++++----
 2 files changed, 19 insertions(+), 22 deletions(-)

-- 
1.8.4-fc
