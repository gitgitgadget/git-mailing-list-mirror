From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v1.8.5.5
Date: Thu, 13 Feb 2014 14:41:39 -0800
Message-ID: <xmqqob2ak53w.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Thu Feb 13 23:41:54 2014
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1WE4yf-0005H9-U2
	for glk-linux-kernel-3@plane.gmane.org; Thu, 13 Feb 2014 23:41:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752412AbaBMWlp (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Thu, 13 Feb 2014 17:41:45 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65457 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752307AbaBMWln (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Feb 2014 17:41:43 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D9766CB32;
	Thu, 13 Feb 2014 17:41:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=f
	FKqII3CvKTpACWtdQ1WbWbeDeQ=; b=NwYxZOQ5ZSo6W8cIhpR33/mK2OdWIVW8t
	7PIZS52eyMLTnY+SL1SDPoRJiypeKRdCTTa+oVETm+Z0IRK7AZu+ISpCv+nxVh7z
	a1p/02V8vmCQQ+JXFpciQoN38VVctibV+IaZHWxDFER7oQk6v13bpYoqV7PXRK8W
	+yu7hLyCG0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=MEWfLKcb2Io8tDh9LywT7gATkefJnk5pgCuFmwSntxyo9lr8bUrz7rvT
	BZ0F6Ugs9a6ybXvRUVNoJdqezd2bxjxrJpE+uG/3SbWYD3YW0QnhA5GAndj6vo2b
	ey/vLXpoQ6UIRV2P4bWxOxHbje/zThfGjFoU7dtEOeJnPEpH/8I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E483B6CB31;
	Thu, 13 Feb 2014 17:41:41 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1AFC16CB2E;
	Thu, 13 Feb 2014 17:41:41 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 01A290F6-9500-11E3-9840-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242081>

The latest maintenance release Git v1.8.5.5 is now available at
the usual places.  Hopefully this will be the last update to the
1.8.5.x series.

The release tarballs are found at:

    http://code.google.com/p/git-core/downloads/list

and their SHA-1 checksums are:

7bb4ea883b1f8f6f7f927035f85e8e27b57e0194  git-1.8.5.5.tar.gz
39dd7979c8757d2dc4bc3aaa82741ba93557d566  git-htmldocs-1.8.5.5.tar.gz
a4a2aef1440d4751f37c65359da57c9bd51a7beb  git-manpages-1.8.5.5.tar.gz

The following public repositories all have a copy of the v1.8.5.5
tag and the maint branch that the tag points at:

  url = https://kernel.googlesource.com/pub/scm/git/git
  url = git://repo.or.cz/alt-git.git
  url = https://code.google.com/p/git-core/
  url = git://git.sourceforge.jp/gitroot/git-core/git.git
  url = git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url = https://github.com/gitster/git

Also, http://www.kernel.org/pub/software/scm/git/ has copies of the
release tarballs.

Git v1.8.5.5 Release Notes
==========================

Fixes since v1.8.5.4
--------------------

 * The pathspec matching code, while comparing two trees (e.g. "git
   diff A B -- path1 path2") was too aggressive and failed to match
   some paths when multiple pathspecs were involved.

 * "git repack --max-pack-size=8g" stopped being parsed correctly when
   the command was reimplemented in C.

 * A recent update to "git send-email" broke platforms where
   /etc/ssl/certs/ directory exists but cannot be used as SSL_ca_path
   (e.g. Fedora rawhide).

 * A handful of bugs around interpreting $branch@{upstream} notation
   and its lookalike, when $branch part has interesting characters,
   e.g. "@", and ":", have been fixed.

 * "git clone" would fail to clone from a repository that has a ref
   directly under "refs/", e.g. "refs/stash", because different
   validation paths do different things on such a refname.  Loosen the
   client side's validation to allow such a ref.

 * "git log --left-right A...B" lost the "leftness" of commits
   reachable from A when A is a tag as a side effect of a recent
   bugfix.  This is a regression in 1.8.4.x series.

 * "git merge-base --octopus" used to leave cleaning up suboptimal
   result to the caller, but now it does the clean-up itself.

 * "git mv A B/", when B does not exist as a directory, should error
   out, but it didn't.

Also contains typofixes, documentation updates and trivial code clean-ups.

----------------------------------------------------------------

Changes since v1.8.5.4 are as follows:

Andy Spencer (1):
      tree_entry_interesting: match against all pathspecs

Jeff King (9):
      fetch-pack: do not filter out one-level refs
      interpret_branch_name: factor out upstream handling
      interpret_branch_name: rename "cp" variable to "at"
      interpret_branch_name: always respect "namelen" parameter
      interpret_branch_name: avoid @{upstream} past colon
      interpret_branch_name: find all possible @-marks
      repack: fix typo in max-pack-size option
      repack: make parsed string options const-correct
      repack: propagate pack-objects options as strings

Junio C Hamano (5):
      merge-base: separate "--independent" codepath into its own helper
      merge-base --octopus: reduce the result from get_octopus_merge_bases()
      revision: mark contents of an uninteresting tree uninteresting
      revision: propagate flag bits from tags to pointees
      Git 1.8.5.5

Ruben Kerkhof (1):
      send-email: /etc/ssl/certs/ directory may not be usable as ca_path
