From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 0/8] merge: allow --log to append shortlog to -m
Date: Tue, 11 May 2010 01:17:44 +0800
Message-ID: <1273511872-4924-1-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>,
	"Miklos Vajna" <vmiklos@frugalware.org>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 10 19:18:24 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBWcV-0007Vr-8L
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 19:18:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755859Ab0EJRSO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 May 2010 13:18:14 -0400
Received: from mail-pz0-f204.google.com ([209.85.222.204]:49993 "EHLO
	mail-pz0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755821Ab0EJRSN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 May 2010 13:18:13 -0400
Received: by pzk42 with SMTP id 42so275995pzk.4
        for <git@vger.kernel.org>; Mon, 10 May 2010 10:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=bwAX6psqeik82CF1Dwyq9OlvoEB8Ji6TLw03yUFd51Y=;
        b=sJp35NnOZ2ZvAjNhuy7dVBK3QjKpDdvVJor+8SmNhv2eNjQUZErMNHbdTsQPbU8bPD
         PfmZFwc8yDRAIZUILB5hi3xXqUx6AJbgwajk7JZ6Eg9ZckxQHytG8G1iQyCTa8WHCv96
         kqsCrIw5Y8r6RTogJCmtKLnZzzxsw/KOlwnjc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=uQcv7be1icInxYOeXsaAaFycwXasYNlI+5slzPoGjYsLcZE6SVB42ieWmDui2oqAcf
         B4UdQr1gFCcyO3Nreu60fQbzxbs34U/RdX2mgT9MjJkTY5KivGaREov+tJNxw1mvIFxF
         7lxd1u6FhnvrAGvOs4NCrhd0wIjLWIkfZZu1g=
Received: by 10.115.65.19 with SMTP id s19mr3382700wak.203.1273511892264;
        Mon, 10 May 2010 10:18:12 -0700 (PDT)
Received: from localhost.localdomain (cm71.zeta153.maxonline.com.sg [116.87.153.71])
        by mx.google.com with ESMTPS id v13sm27449213wav.2.2010.05.10.10.18.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 10 May 2010 10:18:11 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.337.gbd0bc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146830>

Previously, --log didn't have any effect if a message was specified
with -m. This allows one to create commit messages like:

  Merge in new feature

  * commit c2:
    c2's message

Contents:
[PATCH 1/8] t7604-merge-custom-message: shift expected output creation
[PATCH 2/8] t7604-merge-custom-message: show that --log doesn't append to -m
[PATCH 3/8] merge: update comment
[PATCH 4/8] merge: rename variable
[PATCH 5/8] fmt-merge-msg: minor refactor of fmt_merge_msg()
[PATCH 6/8] fmt-merge-msg: refactor merge title formatting
[PATCH 7/8] fmt-merge-msg: add function to append shortlog only
[PATCH 8/8] merge: --log appends shortlog to message if specified

 Documentation/git-merge.txt     |    7 +++-
 builtin.h                       |    1 +
 builtin/fmt-merge-msg.c         |   76 ++++++++++++++++++++++++--------------
 builtin/merge.c                 |   20 ++++++----
 t/t7604-merge-custom-message.sh |   24 ++++++++++--
 5 files changed, 87 insertions(+), 41 deletions(-)
