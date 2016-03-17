From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v2.7.4 (and updates to older maintenance tracks)
Date: Thu, 17 Mar 2016 14:07:51 -0700
Message-ID: <xmqqlh5gzuc8.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Thu Mar 17 22:08:14 2016
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1agf9P-0008HN-JE
	for glk-linux-kernel-3@plane.gmane.org; Thu, 17 Mar 2016 22:08:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031023AbcCQVH6 (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Thu, 17 Mar 2016 17:07:58 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:62539 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S936881AbcCQVH4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2016 17:07:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9C88F4CA26;
	Thu, 17 Mar 2016 17:07:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=5
	Ph4AKBH0xJqyXtRvLwAjA9tKlo=; b=lLEq7LczERy6lwDMTfv9UIpkJL0m+o/DM
	Jl36BB/o/XlKcGu+hnhA3XruqfA3IX8G1C8zn4hsqYznjebL4eoBmIhX4lYKCDj4
	cOgM7MhU5JNWG40Zrs776A0m6fjeuYiHWzEXqUuevUrxDiRrwNB3s2VNzHrBK7bz
	SxeL5/B+wI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=Fe+uWAw+ZXYDWcggOIiHaK0/5qkIhrmTmQnm9U6Curx5XyssNUeBk6ht
	Mca5vgsVX1S78SFBHsy+DU5ObUdIzLuoTzEKL5i55NkLB2JmA9QP5R9yY5g3UsYD
	62dHih/PO1+bwEa4IRPy4XoYlflJMBOU1td8sfcwc+RBHPxV8H8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9366D4CA25;
	Thu, 17 Mar 2016 17:07:54 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1F1644CA24;
	Thu, 17 Mar 2016 17:07:53 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5047F7CC-EC84-11E5-A967-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289156>

The latest maintenance release Git v2.7.4 is now available at the
usual places.  The same set of bugfix patches from the current
'master' have been backported to older maintenance tracks and are
available as v2.4.11, v2.5.5 and v2.6.6.  These are to fix a heap
corruption / buffer overflow bug and users are strongly encouraged
to upgrade.  The fix has already been in the release candidate
v2.8.0-rc3 as well.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.7.4'
tag and the 'maint' branch that the tag points at:

  url = https://kernel.googlesource.com/pub/scm/git/git
  url = git://repo.or.cz/alt-git.git
  url = git://git.sourceforge.jp/gitroot/git-core/git.git
  url = git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url = https://github.com/gitster/git

----------------------------------------------------------------

Git v2.7.4 Release Notes
========================

Fixes since v2.7.3
------------------

 * Bugfix patches were backported from the 'master' front to plug heap
   corruption holes, to catch integer overflow in the computation of
   pathname lengths, and to get rid of the name_path API.  Both of
   these would have resulted in writing over an under-allocated buffer
   when formulating pathnames while tree traversal.

----------------------------------------------------------------

Changes since v2.7.3 are as follows:

Jeff King (7):
      add helpers for detecting size_t overflow
      tree-diff: catch integer overflow in combine_diff_path allocation
      http-push: stop using name_path
      show_object_with_name: simplify by using path_name()
      list-objects: convert name_path to a strbuf
      list-objects: drop name_path entirely
      list-objects: pass full pathname to callbacks

Junio C Hamano (4):
      Git 2.4.11
      Git 2.5.5
      Git 2.6.6
      Git 2.7.4
