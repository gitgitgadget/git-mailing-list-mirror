From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/6] test updates around diff
Date: Sun, 15 Feb 2015 15:43:38 -0800
Message-ID: <1424043824-25242-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 16 00:43:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YN8qv-0006CL-Gb
	for gcvg-git-2@plane.gmane.org; Mon, 16 Feb 2015 00:43:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753980AbbBOXns (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2015 18:43:48 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62037 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750904AbbBOXnr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2015 18:43:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9B2BE39CE2;
	Sun, 15 Feb 2015 18:43:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id; s=sasl; bh=JDmeX9xwtG2b6CCUST03sP4qc6Q
	=; b=CWl8jxSt54aDeSis8km+xtLjiLUHlWN6tNaPRcW/KhXHbnvptrHVv9LGfd4
	gKhwzzrCUjQkDRoFpDvMgjOYQ6lR5KoGHgszWauo8Jsux+qeF+5oXtfabmaaXCwO
	aAuphnPPtvCrPWqKNwDc6ZLmp12LN0djcaO+OZ1k3gYeQJwg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id; q=dns; s=sasl; b=qNXyEm9AHOWW9hSFH4hUmGbZbtExv
	LqVSbmAVWD/h3TEB16dUwfIW0i3ZmUl990d4PYEMbgH41g9ueArZhAxCu3XBSmZR
	6RJp1PsQFvwaJlVwGah6qMcbyzsocrZcUyy//750LZlCjqHZwkMsY9pUOXKdldR9
	RG0zepD9Y3h5U8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 92FE239CE1;
	Sun, 15 Feb 2015 18:43:46 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1B0D639CE0;
	Sun, 15 Feb 2015 18:43:46 -0500 (EST)
X-Mailer: git-send-email 2.3.0-266-g5b48884
X-Pobox-Relay-ID: 7B823C90-B56C-11E4-9422-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263856>

This is primarily to update t4008 that will have to be updated in
the course of "diff -B -M" work to modern standard and also make it
easier to be used as the test bed.

Junio C Hamano (6):
  t4008: correct stale comments
  t9300: correct expected object names
  t4010: correct expected object names
  tests: do not borrow from COPYING and README from the real source
  t/diff-lib: check exact object names in compare_diff_raw
  t4008: modernise style

 t/diff-lib.sh                 |   2 +-
 t/diff-lib/COPYING            | 361 ++++++++++++++++++++++++++++++++++++++++++
 t/diff-lib/README             |  46 ++++++
 t/t4003-diff-rename-1.sh      |   4 +-
 t/t4005-diff-rename-2.sh      |   4 +-
 t/t4007-rename-3.sh           |   2 +-
 t/t4008-diff-break-rewrite.sh | 292 +++++++++++++++-------------------
 t/t4009-diff-rename-4.sh      |   4 +-
 t/t4010-diff-pathspec.sh      |   2 +-
 t/t9300-fast-import.sh        |   4 +-
 10 files changed, 547 insertions(+), 174 deletions(-)
 create mode 100644 t/diff-lib/COPYING
 create mode 100644 t/diff-lib/README

-- 
2.3.0-266-g5b48884
