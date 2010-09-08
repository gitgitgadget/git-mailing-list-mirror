From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv2 0/2] Fix resolvable rename + D/F conflict testcases
Date: Wed,  8 Sep 2010 00:40:39 -0600
Message-ID: <1283928041-9882-1-git-send-email-newren@gmail.com>
Cc: gitster@pobox.com, oinksocket@letterboxes.org,
	Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 08 08:39:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtEJh-00060v-C9
	for gcvg-git-2@lo.gmane.org; Wed, 08 Sep 2010 08:39:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751545Ab0IHGjS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Sep 2010 02:39:18 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:58568 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751241Ab0IHGjQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Sep 2010 02:39:16 -0400
Received: by qyk36 with SMTP id 36so4236710qyk.19
        for <git@vger.kernel.org>; Tue, 07 Sep 2010 23:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=y0UejsOQJqjIyS9ijQ9Mo0ZpiEYKskbJO27vCMXKKtY=;
        b=QGzE/2CDMh8R++/5omQBhyx14jiy3dqLomElrFZJzg8UdPg01Iwtb+yVRXjzumm020
         lFElKPikOhBadzc9txFSB6vU2zSgLzZpkDorzIFqxf2JiKPUH/M9Lp2ppdXeBVuW2LUA
         fZ8E1ixL+/qVeMZZsfRqniFhfbYiWaYldcnnU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=WidpxFAUS6h6XG6gosvo6YBRU0gvPSLk4MyMj5OmaKIfVrEmzk5+72cf/Li7fz90qP
         OgTz4hD9Cvj6IU0xBB46hUP8b54z5JQVysRMsDSXNQrMXeAVY2ZImM3+Xr1AY34JP5dB
         B+zRWaR5RXVhtzwL+H7AbTNcr31Nvy6zIIeTU=
Received: by 10.229.189.140 with SMTP id de12mr2336846qcb.5.1283927955892;
        Tue, 07 Sep 2010 23:39:15 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id t4sm8076432qcs.40.2010.09.07.23.39.13
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 07 Sep 2010 23:39:15 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.rc0.8.g2ec3f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155770>

This fixes an issue reported by Nick (no lastname given) on the
mailing list, as well as a closely related issue in the handling of
rename + directory/file conflicts, namely where a filename on one side
of the rename is a directory name on the other side of the merge.

Change since v1:
  * Split unrelated 2/3 patch out into a separate submission

Elijah Newren (2):
  t3509: Add rename + D/F conflict testcase that recursive strategy
    fails
  merge-recursive: D/F conflicts where was_a_dir/file -> was_a_dir

 merge-recursive.c               |   16 +++++-----
 t/t3509-cherry-pick-merge-df.sh |   66 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+), 8 deletions(-)

-- 
1.7.3.rc0.8.g2ec3f
