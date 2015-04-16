From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/3] UTF8 BOM follow-up
Date: Thu, 16 Apr 2015 10:52:51 -0700
Message-ID: <1429206774-10087-1-git-send-email-gitster@pobox.com>
References: <xmqqoamohu2m.fsf@gitster.dls.corp.google.com>
Cc: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>,
	Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 16 19:53:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YinyI-00063j-F4
	for gcvg-git-2@plane.gmane.org; Thu, 16 Apr 2015 19:53:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752697AbbDPRw5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2015 13:52:57 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59618 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752024AbbDPRw4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2015 13:52:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B83744A1FF;
	Thu, 16 Apr 2015 13:52:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=pIZ/
	egiVWnWuOXgZ5/uqNk51b0I=; b=PpHtg9BLcpvbze5fIQANxWMUT34VGdYm0HKL
	+K4slDUU4NtBR83D4lmJ49RWcokqL8yLz2GSpy6nargnrjtlADGmaZkJZgI8nHdG
	FUDTNUljIDhvq6TWiI9R/ftFr/WlJPVYUgbac2tbaIHnXINTmC1qIiL6/lvGMHsa
	YGgeO/A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	Rcvtpyp6vrCWD9TB3onFT4u4PceIAYiav/2rkD0aQBzIAsmb6y3TvwttTUzPbJwf
	DutXoowqQvd5Xeq94DJitrd8yP9jQn4wIr/QHKgRx3o3m7nWP23im/GuIhraqu0z
	aPICbSrJjOvKP1muuhCDCyCzoCwn3/kcQY61ARgMGts=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B14054A1FE;
	Thu, 16 Apr 2015 13:52:55 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 37C564A1FD;
	Thu, 16 Apr 2015 13:52:55 -0400 (EDT)
X-Mailer: git-send-email 2.4.0-rc2-171-g98ddf7f
In-Reply-To: <xmqqoamohu2m.fsf@gitster.dls.corp.google.com>
X-Pobox-Relay-ID: 68FF1286-E461-11E4-84BF-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267315>

This is on top of the ".gitignore can start with UTF8 BOM" patch
from Carlos.

Junio C Hamano (3):
  utf8-bom: introduce skip_utf8_bom() helper
  config: use utf8_bom[] from utf.[ch] in git_parse_source()
  attr: skip UTF8 BOM at the beginning of the input file

 attr.c   |  9 +++++++--
 config.c |  6 +++---
 dir.c    |  8 +++-----
 utf8.c   | 11 +++++++++++
 utf8.h   |  3 +++
 5 files changed, 27 insertions(+), 10 deletions(-)

-- 
2.4.0-rc2-171-g98ddf7f
