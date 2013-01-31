From: Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH 0/3] GPG running out of pipes fixes
Date: Wed, 30 Jan 2013 18:01:03 -0800
Message-ID: <1359597666-10108-1-git-send-email-sboyd@codeaurora.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 31 03:01:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0jTO-0008G0-79
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 03:01:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755545Ab3AaCBR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2013 21:01:17 -0500
Received: from wolverine01.qualcomm.com ([199.106.114.254]:30435 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754325Ab3AaCBJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2013 21:01:09 -0500
X-IronPort-AV: E=Sophos;i="4.84,573,1355126400"; 
   d="scan'208";a="23137422"
Received: from pdmz-ns-mip.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.10])
  by wolverine01.qualcomm.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 30 Jan 2013 18:01:09 -0800
Received: from sboyd-linux.qualcomm.com (pdmz-ns-snip_218_1.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id ED89A10004C7
	for <git@vger.kernel.org>; Wed, 30 Jan 2013 18:01:08 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.439.g50a6b54
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215083>

While running --show-signatures on the linux kernel I noticed that after
a while git failed with an error message indicating it had run out of 
file descriptors. The first patch fixes this problem, and the next
two are randmom bits since I was in the area.

Stephen Boyd (3):
  gpg: Close stderr once finished with it in verify_signed_buffer()
  run-command: Be more informative about what failed
  gpg: Allow translation of more error messages

 gpg-interface.c | 8 +++++---
 run-command.c   | 8 ++++++--
 2 files changed, 11 insertions(+), 5 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
