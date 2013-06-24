From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/6] Reroll of rr/triangular-push-fix
Date: Sun, 23 Jun 2013 21:33:02 -0700
Message-ID: <1372048388-16742-1-git-send-email-gitster@pobox.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 24 06:33:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UqyT5-00045x-0R
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 06:33:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102Ab3FXEdM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 00:33:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40898 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750990Ab3FXEdL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 00:33:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9D7D026599;
	Mon, 24 Jun 2013 04:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id; s=sasl; bh=ZPGdZYO5o1M2a5QFz41m+xqjQSY
	=; b=MNnrJpvbXjQt7ETxiTG+AU1hAkVRNvLQO0iMy0zh5cgEefnbLs4UDHq6cEd
	mxlWeSCQqpg36ML9R1X3Yvzp4TWNw1SNgCdUcsU5F4tpIMMAmSeFvzdf4bYbM87Q
	I5oUu4whoMLPeld1LxIGx993kjEVArAPFsipiuc/cyuedKhU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id; q=dns; s=sasl; b=ORePiXnTM4YaG5kaUxiii
	IAueJbZdX+3ShueslJjfmS7Zzm//DSHf0dQGoBOymaPzwBlHZhLK7AqwmJiscJ9u
	Xo2IGLKav+ilKb0tQ9RDPn+mR5lhVdoJCua8GBZeU7p/O5eLydDxuo0MS6kmaHPB
	btnzZoFDFs7/RFFrEc28js=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 94BE026598;
	Mon, 24 Jun 2013 04:33:10 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 016C026596;
	Mon, 24 Jun 2013 04:33:09 +0000 (UTC)
X-Mailer: git-send-email 1.8.3.1-721-g0a353d3
X-Pobox-Relay-ID: 2C851258-DC87-11E2-9DEF-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228770>

This is mostly Ram's triangular-push-fix series, but the fix-up
commits I queued on top of it when the series was queued to 'pu'
have been squashed in.

  [PATCH 1/6] t/t5528-push-default: remove redundant test_config lines

  No changes, as posted by Ram.

  [PATCH 2/6] config doc: rewrite push.default section

  Reorganization (including moving of 'matching' to the end) is Ram's,
  but otherwise moderately rewritten.

  [PATCH 3/6] push: change `simple` to accommodate triangular workflows

  Sqaushed in the fix to keep the semantics of "simple" when used in
  the centralized workflow the same as before.

  [PATCH 4/6] t/t5528-push-default: generalize test_push_*

  As posted by Ram.

  [PATCH 5/6] t/t5528-push-default: test pushdefault workflows

  A style fix from the review, and comment tweaks to describe what
  each tests mean better.

  [PATCH 6/6] push: honor branch.*.push

  This is new.  It probably needs tests and docs.

I am trying this myself primarily because this changes the plan for
Git 2.0 and jc/push-2.0-default-to-simple topic needs to be redone,
but before we can do so, we need to see this topic solidify enough.

Junio C Hamano (1):
  push: honor branch.*.push

Ramkumar Ramachandra (5):
  t/t5528-push-default: remove redundant test_config lines
  config doc: rewrite push.default section
  push: change `simple` to accommodate triangular workflows
  t/t5528-push-default: generalize test_push_*
  t/t5528-push-default: test pushdefault workflows

 Documentation/config.txt | 80 ++++++++++++++++++++++++++++++------------------
 builtin/push.c           | 59 +++++++++++++++++++++++++++--------
 remote.c                 |  5 +++
 remote.h                 |  2 ++
 t/t5528-push-default.sh  | 65 ++++++++++++++++++++++++++++++++++++---
 5 files changed, 165 insertions(+), 46 deletions(-)

-- 
1.8.3.1-721-g0a353d3
