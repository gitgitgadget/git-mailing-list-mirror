From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 0/4] Migrate simple builtins to parse-options
Date: Tue,  7 Jul 2009 22:15:37 -0700
Message-ID: <1247030141-11695-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 08 07:16:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOPVs-00082W-EI
	for gcvg-git-2@gmane.org; Wed, 08 Jul 2009 07:16:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754814AbZGHFPq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jul 2009 01:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753305AbZGHFPq
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jul 2009 01:15:46 -0400
Received: from mail-px0-f181.google.com ([209.85.216.181]:37259 "EHLO
	mail-px0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752377AbZGHFPp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2009 01:15:45 -0400
Received: by pxi11 with SMTP id 11so141523pxi.33
        for <git@vger.kernel.org>; Tue, 07 Jul 2009 22:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=mIUhn2oksNeEdmrH08FpVbZXQOWRT1Vis3p1z+H3Iy0=;
        b=SEpd1Yf2Sdi7lnkouVcYRjSi1XlcNP5f0fuFpBBmyXHsYmfcpilTJJPA8ze0/6CWWn
         heH79iNg6OWANNguTbqG1+oBVtKiU9C6Q+qFanNZqbPIH5KqBuaNCKVZ/npeWs5nlLjX
         Sp6WP+Puz1MgDkWMSs6TH8rTsWz2vthXS2+qA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=GMyHjkBEhhgqLxjp2YEvq0AvWi8UuUZ7MjvntPmd6TDRVlJGNezvwnm0gEOKuw6+yx
         rf8GV2wP3/2v4JPstBntmA+3jPnF7raKwFlXClBqkmVMJu7XpFjgkIZJBcErqJD2w59v
         NEClcZ4pv2d77VTl0ISeDxP0UwL7jl17507RQ=
Received: by 10.114.208.12 with SMTP id f12mr10585050wag.226.1247030144817;
        Tue, 07 Jul 2009 22:15:44 -0700 (PDT)
Received: from earth (cpe-66-75-25-79.san.res.rr.com [66.75.25.79])
        by mx.google.com with ESMTPS id n9sm2704586wag.58.2009.07.07.22.15.42
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 07 Jul 2009 22:15:44 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Tue, 07 Jul 2009 22:15:41 -0700
X-Mailer: git-send-email 1.6.3.3.385.g60647
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122889>

These are builtins with options that are fairly simple and the number
of options is small so code review will hopefully be easier.

Stephen Boyd (4):
  write-tree: migrate to parse-options
  tag-verify: migrate to parse-options
  verify-pack: migrate to parse-options
  prune-packed: migrate to parse-options

 Documentation/git-prune-packed.txt |    4 ++-
 Documentation/git-verify-pack.txt  |    3 +-
 builtin-prune-packed.c             |   29 ++++++++++---------------
 builtin-verify-pack.c              |   40 ++++++++++++++++-------------------
 builtin-verify-tag.c               |   21 ++++++++++--------
 builtin-write-tree.c               |   40 +++++++++++++++++------------------
 6 files changed, 66 insertions(+), 71 deletions(-)
