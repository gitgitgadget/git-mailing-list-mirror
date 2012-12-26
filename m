From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/5] merge-tree fix-ups
Date: Wed, 26 Dec 2012 15:03:35 -0800
Message-ID: <1356563020-13919-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 27 00:04:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1To014-000797-M4
	for gcvg-git-2@plane.gmane.org; Thu, 27 Dec 2012 00:04:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362Ab2LZXDo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Dec 2012 18:03:44 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33882 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751142Ab2LZXDn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Dec 2012 18:03:43 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CCB3AA31A
	for <git@vger.kernel.org>; Wed, 26 Dec 2012 18:03:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id; s=sasl; bh=XclNG+xEx8Ub/XHKOWnrIIrkd34
	=; b=IS+B81rdWfXjIGuK8CHglNVHh8p9CUxwMeTbhUGSMt9N48doZMQ+94Wkrxd
	FGyl0oIJ4WEL2Ck9iNsJdTyez6CLM4TjiXRREcah+JgjjO0yX2R5O4o/+X8mgxuA
	zFgKqMCgWPSFwvrsyOXE5NdzDtDSdo9EH48KzPuU0d3IWrzA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id; q=dns; s=sasl; b=jN9XLpkk5NhKt0gAhm02q2kpjxBt6
	z9rGyGCx9d3drABmMsUfWeply4Jl6HpeJVmnAgPVcH4diaHzgrrDKKzD1FN0r8jB
	/MidoPKDQMDZqWEGgrUEjbe7AnWrD2DJ8r71SHxcsRfrtqmBiAU4Iafnq0fvrrlN
	gfayzZMCAsgSH0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B9FD4A319
	for <git@vger.kernel.org>; Wed, 26 Dec 2012 18:03:42 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4A094A318 for
 <git@vger.kernel.org>; Wed, 26 Dec 2012 18:03:42 -0500 (EST)
X-Mailer: git-send-email 1.8.1.rc3.356.g686f81c
X-Pobox-Relay-ID: 7E1B623E-4FB0-11E2-821C-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212162>

This is a small preparatory step to build a new merge strategy based
on the disused merge-tree proof-of-concept code.  It starts with a
small set of code clean-up patches and ends with two bugfixes, at
least for now.

Junio C Hamano (5):
  Which merge_file() function do you mean?
  merge-tree: lose unused "flags" from merge_list
  merge-tree: lose unused "resolve_directories"
  merge-tree: add comments to clarify what these functions are doing
  merge-tree: fix d/f conflicts

 Makefile              |   2 +-
 builtin/merge-index.c |   4 +-
 builtin/merge-tree.c  |  92 +++++++++++++++++++++++--------------
 merge-blobs.c         | 124 ++++++++++++++++++++++++++++++++++++++++++++++++++
 merge-blobs.h         |   8 ++++
 merge-file.c          | 124 --------------------------------------------------
 merge-file.h          |   7 ---
 merge-recursive.c     |   6 +--
 t/t4300-merge-tree.sh |  44 ++++++++++++++++++
 9 files changed, 239 insertions(+), 172 deletions(-)
 create mode 100644 merge-blobs.c
 create mode 100644 merge-blobs.h
 delete mode 100644 merge-file.c
 delete mode 100644 merge-file.h

-- 
1.8.1.rc3.356.g686f81c
