From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 0/5] resolve checkout-index --temp path mangling
Date: Wed, 24 Dec 2014 04:43:11 -0500
Message-ID: <1419414196-58587-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	"Shawn O . Pearce" <spearce@spearce.org>
To: git@vger.kernel.org, Russ Cox <rsc@golang.org>
X-From: git-owner@vger.kernel.org Wed Dec 24 10:44:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3iUP-00053S-TW
	for gcvg-git-2@plane.gmane.org; Wed, 24 Dec 2014 10:44:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751605AbaLXJoH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Dec 2014 04:44:07 -0500
Received: from mail-ie0-f170.google.com ([209.85.223.170]:64815 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751427AbaLXJoF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Dec 2014 04:44:05 -0500
Received: by mail-ie0-f170.google.com with SMTP id rd18so7345372iec.29
        for <git@vger.kernel.org>; Wed, 24 Dec 2014 01:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=A+FWBfB4vy7xHXqm82+8WxlMyBZ2sg9RWYrvy99Z884=;
        b=PICJrwcZDF0/q76N7Rz1XtlgS3wKNCGU+nySmS8p/A3fkBIXElA8HqZzQHKn7J4TOJ
         4hNUvL0lu6uya4EnKmAyj72+OdTnczOan8CgdeJl8Mddt8wzxO+j+kbHlQDVW57lePLT
         A82IUfOOidPVZC0x0lPqgoVUv5Eutznz9g4IGzUAjpdJr1qrLAEYLUbmHeFcZGtm+rRI
         XUGzE+75hNQImBqoBmAn08f4apBZnIddUDdKlyhCFdYkt+nAlbRVbs45+rsemPROevZw
         qrZy/W+K+LIwnBLjpJdlNAltyboM/nEsxf5sUjQqpGpRcQsKgz98mF9h2xYEkSHlepth
         0hIw==
X-Received: by 10.107.164.75 with SMTP id n72mr30323659ioe.17.1419414244013;
        Wed, 24 Dec 2014 01:44:04 -0800 (PST)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id l3sm7575581igj.9.2014.12.24.01.44.03
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 24 Dec 2014 01:44:03 -0800 (PST)
X-Mailer: git-send-email 2.2.1.267.g0ad48de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261796>

This patch series fixes a path mangling bug in checkout-index --temp
reported by Russ Cox[1]. As a bonus, it also squashes a bug in which
checkout-index was accessing and printing memory beyond end-of-string.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/261739

Eric Sunshine (5):
  t2004: modernize style
  t2004: drop unnecessary write-tree/read-tree
  t2004: standardize file naming in symlink test
  t2004: demonstrate broken relative path printing
  checkout-index: fix --temp relative path mangling

 builtin/checkout-index.c       |  16 +-
 t/t2004-checkout-cache-temp.sh | 400 +++++++++++++++++++++--------------------
 2 files changed, 213 insertions(+), 203 deletions(-)

-- 
2.2.1.267.g0ad48de
