From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/7] A few minor test-prereq updates
Date: Mon,  9 Jun 2014 16:22:48 -0700
Message-ID: <1402356175-7249-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 10 01:23:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wu8uj-0004Rp-92
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 01:23:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934381AbaFIXXD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2014 19:23:03 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52697 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934256AbaFIXXB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2014 19:23:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3DB591D3EE;
	Mon,  9 Jun 2014 19:23:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id; s=sasl; bh=5gFTSHi1KXPxRrRG1rX5GwAJ1lE
	=; b=b4xEabfEF33vSQlSObue9wlWrct4BQc3zTBkSFfcNBtDlp2e2ioRKSikGsv
	6C8J0HYNgRP/WIiOg0CkRRlOfRjXOUpxEwNROgzHYVofFdAfZwBAJWGcpZj9YIO5
	RNb0iUgjRpdG/tlT8OnxEMVRvRE366tyOHxniM6tr6xfl4Ds=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id; q=dns; s=sasl; b=dMCLyRk51osoLhdc/M+dSEaTtY+Vu
	CtQllUx+p0i2+Ql2d6WLQ90ZeuZxbVrFMtiRgNGWjTwN4jSoCg5nG8osM8V3c0U2
	538ZIUePVSvHQGgTxMTmmmspFoxlQ4KN+N9vAwTgXQa4YSp+k0S1S/WxFqh/NVOU
	T2Buxn/Dvr743I=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 31E411D3E9;
	Mon,  9 Jun 2014 19:23:01 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 070F11D3D2;
	Mon,  9 Jun 2014 19:22:56 -0400 (EDT)
X-Mailer: git-send-email 2.0.0-483-g1a584c4
X-Pobox-Relay-ID: FD508570-F02C-11E3-997F-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251138>

While reviewing somebody's patch, I noticed that individual test
scripts set EXPENSIVE test prerequisite with copied-and-pasted
lines.  Here is a bit to update them, while fixing styles in old
test scripts that had these copied-and-pasted lines.

The last step discards support for GIT_{NOTES,PATCHID}_TIMING_TESTS
environment variables to enable EXPENSIVE tests in two test scripts,
which *is* a backward incompatible change and people may want to
argue against it (but I of course thought it is a good change and
that is why it is included).

Junio C Hamano (7):
  test: turn EXPENSIVE into a lazy prerequisite
  test: turn USR_BIN_TIME into a lazy prerequisite
  t3302: coding style updates
  t3302: do not chdir around in the primary test process
  t3302: drop unnecessary NOT_EXPENSIVE pseudo-prerequisite
  t3419: drop unnecessary NOT_EXPENSIVE pseudo-prerequisite
  tests: drop GIT_*_TIMING_TESTS environment variable support

 t/t0021-conversion.sh            |   2 -
 t/t3302-notes-index-expensive.sh | 130 +++++++++++++++++++++------------------
 t/t3419-rebase-patch-id.sh       |  25 +++-----
 t/t5551-http-fetch.sh            |   2 -
 t/test-lib.sh                    |   8 +++
 5 files changed, 85 insertions(+), 82 deletions(-)

-- 
2.0.0-435-g307a092
