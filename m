From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 0/8] shortstatus updates
Date: Mon, 10 Aug 2009 01:54:17 -0700
Message-ID: <1249894465-11018-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 10 10:54:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaQeS-0007fg-9W
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 10:54:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752728AbZHJIy1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2009 04:54:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752583AbZHJIy0
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 04:54:26 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44888 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752501AbZHJIy0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2009 04:54:26 -0400
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 89FFC569B
	for <git@vger.kernel.org>; Mon, 10 Aug 2009 04:54:27 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2DED1569A for
 <git@vger.kernel.org>; Mon, 10 Aug 2009 04:54:27 -0400 (EDT)
X-Mailer: git-send-email 1.6.4.173.g72959
X-Pobox-Relay-ID: 68F51F14-858B-11DE-BF20-EAC21EFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125413>

Another round of "git status won't be a preview of git commit someday".
This builds on the part that are already in 'pu', and is queued in 'pu'.

Junio C Hamano (8):
  commit: --dry-run
  wt-status: move many global settings to wt_status structure
  wt-status: move wt_status_colors[] into wt_status structure
  Make git_status_config() file scope static to builtin-commit.c
  wt-status: collect untracked files in a separate "collect" phase
  git stat: the beginning
  git stat: pathspec limits, unlike traditional "git status"
  git stat -s: short status output

 Documentation/git-commit.txt |    7 +-
 Makefile                     |    1 +
 builtin-commit.c             |  312 +++++++++++++++++++++++++++++++++++-------
 builtin.h                    |    1 +
 git.c                        |    1 +
 wt-status.c                  |  206 ++++++++++++----------------
 wt-status.h                  |   17 ++-
 7 files changed, 367 insertions(+), 178 deletions(-)
