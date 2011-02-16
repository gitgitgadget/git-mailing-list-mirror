From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 0/2] CHERRY_PICK_HEAD
Date: Wed, 16 Feb 2011 05:08:21 -0500
Message-ID: <1297850903-65038-1-git-send-email-jaysoffian@gmail.com>
Cc: Jay Soffian <jaysoffian@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 16 11:09:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpeJm-0002YS-4E
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 11:09:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755887Ab1BPKJA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Feb 2011 05:09:00 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:35090 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755794Ab1BPKI6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Feb 2011 05:08:58 -0500
Received: by qwa26 with SMTP id 26so1093928qwa.19
        for <git@vger.kernel.org>; Wed, 16 Feb 2011 02:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=pmIhOYg6XgWKr13lFn07MncmBlvFBVOIuc0ntcDY04o=;
        b=bGKhEVshK/UACiIIeD3a/ifIQdN0hbnFvAddrrLKSadMzga1nMIhzqYv5r0TU+QflV
         9b775oQlf3rKoFZWlW3GkZ+bgEtv/Mb+JV1BOz9LY9qDJxi0lV256x5zPriAgnaauWMz
         RZWgC2MIlxTNvemh8dcfCbWzwJJIzjJxSCm8w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=ELxYfKgSMAjCuoiohIOxXzUzqpsXV0HPjGR/6ACxSOThLZHKXKlwFQ9k0Rc6gnSoIA
         HaDeOVGMt42UmD4sbDO0eewgBFDhwyRRGmgNxxoTlp7fvuH3d5te5SJih3ZtlRASZqSc
         3fxRHPBG1SUdfROYpYMMBcIhw/NyPnqxQ/e3M=
Received: by 10.224.11.75 with SMTP id s11mr510272qas.16.1297850937400;
        Wed, 16 Feb 2011 02:08:57 -0800 (PST)
Received: from localhost (cpe-071-077-014-091.nc.res.rr.com [71.77.14.91])
        by mx.google.com with ESMTPS id e10sm1688968vch.19.2011.02.16.02.08.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 16 Feb 2011 02:08:56 -0800 (PST)
X-Mailer: git-send-email 1.7.4.1.28.gd46b3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166945>

Re-roll of http://thread.gmane.org/gmane.comp.version-control.git/166878

If not ready for inclusion, hopefully very close.

Jay Soffian (2):
  Introduce CHERRY_PICK_HEAD
  Teach commit about CHERRY_PICK_HEAD

 Documentation/git-cherry-pick.txt      |   19 +++++
 Documentation/git-commit.txt           |    7 +-
 Documentation/revisions.txt            |    5 +-
 branch.c                               |    1 +
 builtin/commit.c                       |  136 ++++++++++++++++++++++----------
 builtin/merge.c                        |    7 ++
 builtin/revert.c                       |   68 ++++------------
 contrib/completion/git-completion.bash |    2 +
 t/t3507-cherry-pick-conflict.sh        |   22 +++++-
 t/t7509-commit.sh                      |   29 +++++++
 wt-status.c                            |    4 +-
 wt-status.h                            |    8 ++-
 12 files changed, 204 insertions(+), 104 deletions(-)

-- 
1.7.4.1.28.gd46b3
