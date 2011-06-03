From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/4] index-pack (continued)
Date: Fri,  3 Jun 2011 15:32:13 -0700
Message-ID: <1307140337-27676-1-git-send-email-gitster@pobox.com>
Cc: Shawn O Pearce <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 04 00:32:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QScus-0005LU-72
	for gcvg-git-2@lo.gmane.org; Sat, 04 Jun 2011 00:32:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756263Ab1FCWcZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2011 18:32:25 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:41715 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754591Ab1FCWcY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2011 18:32:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7EED156E5;
	Fri,  3 Jun 2011 18:34:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id; s=sasl; bh=E9/Sb46Or1JDKiwfIhJ4+2Lc9hI
	=; b=AAo3qKTvYYhFyAWTqDtLIC5/kLKH9p9qjn5kDg5iuYOoMLN6ADEqqBNMfU0
	TobAjQns8fbFMVEDDMrBugsKKFfDDPZV21AliQptAa29IeCZaly2Ucpyg0IKbIqa
	4agRAzo2SCikETMxt7A7r4o9kEcade5qwPI0qP0ZkHSNnAGU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id; q=dns; s=sasl; b=ck9dIkJBESB1BUIDjDBex
	VSt15QciMe0aweAPCarYSJ7fIMtRapsx15Y6RLuGe0JyWcW1O9IBzB7w2gYM76V7
	GsDfBO01bZrcrnA6q2ngsr7LiVraLm8eC3gt6dwxXynpkpOodKdm+q4dM8dyQBup
	8wZnVELuPhPC3EfU9ZXymA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6A76056E3;
	Fri,  3 Jun 2011 18:34:30 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id AE82756E1; Fri,  3 Jun 2011
 18:34:28 -0400 (EDT)
X-Mailer: git-send-email 1.7.6.rc0.106.g68174
X-Pobox-Relay-ID: A592E89C-8E31-11E0-BD2E-EA23C7C1A288-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175032>

This is a contination of the earlier index-pack series that has been
in "stalled" state. I do not plan to push this forward for 1.7.6 (the
endgame of this series is a 2.0 material but it will be a long way to
get there).

Junio C Hamano (4):
  index-pack: a miniscule refactor
  index-pack: start learning to emulate "verify-pack -v"
  index-pack: show histogram when emulating "verify-pack -v"
  verify-pack: use index-pack --verify

 builtin/index-pack.c  |   74 +++++++++++++++++++++++++--
 builtin/verify-pack.c |  132 +++++++++---------------------------------------
 cache.h               |    1 -
 sha1_file.c           |   55 --------------------
 t/t5302-pack-index.sh |    5 +-
 5 files changed, 95 insertions(+), 172 deletions(-)

-- 
1.7.6.rc0.106.g68174
