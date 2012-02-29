From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/2] "log --regexp-ignore-case -S/-G<string>"
Date: Tue, 28 Feb 2012 16:20:29 -0800
Message-ID: <1330474831-9030-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 29 01:21:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2XHz-0008RV-BC
	for gcvg-git-2@plane.gmane.org; Wed, 29 Feb 2012 01:21:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755731Ab2B2AUf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Feb 2012 19:20:35 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65523 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754493Ab2B2AUe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2012 19:20:34 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 48EC16449
	for <git@vger.kernel.org>; Tue, 28 Feb 2012 19:20:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id; s=sasl; bh=4SevsoR+4VhGXaJ70+bWoaBYeak
	=; b=MUAFjDmG+48Pq62AOjOnj5jb1ELCdtRlKQRlL0DZV9B281F/m3CQodtP20B
	eWfuHPIGSIvvQSSRAXyMROFNIuSwhuZ6QuuTZyaLO2CbmmcWf+h8zZwoo6EqFAdn
	CKlJR9mkvM7l4PgbAg7pho3+pjHF39S1THe8sx/o9FLFdYWg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id; q=dns; s=sasl; b=SUdpHATYsViTrQd2WMSNm+YI64L6U
	dIEZYm38/rqv3Iu399ANZFFCTp9/NTz2Kc9mK7RGoCs8XH90L0Mo2NIsVuvCF5ac
	0X1rWtVgED8lo3v39/2+cMq1vwekWulWzmGT5n0bPKgYQCC+H4oz1zUvHZ3MfY40
	iRn50eX9bGM/nA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 409C26448
	for <git@vger.kernel.org>; Tue, 28 Feb 2012 19:20:33 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C5D176447 for
 <git@vger.kernel.org>; Tue, 28 Feb 2012 19:20:32 -0500 (EST)
X-Mailer: git-send-email 1.7.9.2.344.g3e8c86
X-Pobox-Relay-ID: 316F4A1E-626B-11E1-A27B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191795>

This is a re-roll of the previous attempt to teach pickaxe to match
case insensitively.

Junio C Hamano (2):
  grep: use static trans-case table
  pickaxe: allow -i to search in patch case-insensitively

 cache.h                |    3 ++
 ctype.c                |   36 +++++++++++++++
 diff.h                 |    1 +
 diffcore-pickaxe.c     |    9 +++-
 grep.c                 |   11 ++---
 revision.c             |    1 +
 t/t4209-log-pickaxe.sh |  119 ++++++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 170 insertions(+), 10 deletions(-)
 create mode 100755 t/t4209-log-pickaxe.sh

-- 
1.7.9.2.344.g3e8c86
