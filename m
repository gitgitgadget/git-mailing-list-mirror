From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/3] Make "git add dir/" notice removed "dir/file"
Date: Sat,  9 Mar 2013 00:22:35 -0800
Message-ID: <1362817358-24356-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 09 09:23:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEF3m-0003sY-GU
	for gcvg-git-2@plane.gmane.org; Sat, 09 Mar 2013 09:23:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755571Ab3CIIWm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Mar 2013 03:22:42 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47985 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752365Ab3CIIWl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Mar 2013 03:22:41 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AD5DC9FA8
	for <git@vger.kernel.org>; Sat,  9 Mar 2013 03:22:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id; s=sasl; bh=r6UzJ+l7cKvN8e12tjO/8bLvgI8
	=; b=RQYGdAmXHjoFKfMRVaPPsF/n7c88nsfDy1BM51yrLCHERj7bGuXKnc9UH2k
	WZHsAbdgQZe5giaOA0cL17mMesMKxCt035+oguMZyv0oxpk5W9dPhD9WNOB2U87E
	uKb+tlInbA5a/UqWW7TMJbi7Q5cWliopctVW1rasUdrZ3sLA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id; q=dns; s=sasl; b=yVEbE7sKLbI2fk6BXVoETIA5zkqKv
	ICiPo0dBjL5TCPqOKX4z2F6oz9l8D3NfyPPLM3QMu8JrkiA8TvrDvu3mEvndoeuD
	ymquTxxko5cQQ7ZXPgBNBjLqFSvwRBeymysTAJZJWZB9QFXNyW3957hAOc9znTlR
	lPUEmEU4aq0C0o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A0C469FA6
	for <git@vger.kernel.org>; Sat,  9 Mar 2013 03:22:40 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 254B39FA5 for
 <git@vger.kernel.org>; Sat,  9 Mar 2013 03:22:40 -0500 (EST)
X-Mailer: git-send-email 1.8.2-rc3-203-gc9aaab5
X-Pobox-Relay-ID: 81F71126-8892-11E2-ACAB-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217706>

This resurrects an ancient stalled topic from last year, rebased on
top of the recent "git add -u/-A" documentation updates 5cae93566027
(add: Clarify documentation of -A and -u, 2013-03-07) by Greg Price.

The first one is a pure clean-up.  The second one is a preparatory
step that can happen before Git 2.0 to prepare existing users to
form a habit of saying "--all" (or "--no-all") explicitly when
giving a directory name to "git add <pathspec>...".

Then the last one can be done in Git 2.0 to swap the default.

Junio C Hamano (3):
  builtin/add.c: simplify boolean variables
  git add: start preparing for "git add <pathspec>..." to default to "-A"
  git add <pathspec>... defaults to "-A"

 Documentation/git-add.txt | 22 +++++++++++++++++++---
 builtin/add.c             | 36 +++++++++++++++++++++++++-----------
 t/t2200-add-update.sh     |  6 +++---
 3 files changed, 47 insertions(+), 17 deletions(-)

-- 
1.8.2-rc3-203-gc9aaab5
