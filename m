From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/6] A smoother transition plan for cvsimport
Date: Sun, 13 Jan 2013 23:25:45 -0800
Message-ID: <1358148351-31552-1-git-send-email-gitster@pobox.com>
References: <7v8v7wiv3a.fsf@alter.siamese.dyndns.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 14 08:26:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TueQy-0002NF-4m
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 08:26:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755340Ab3ANHZz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 02:25:55 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61207 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752804Ab3ANHZy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 02:25:54 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D7E2DB8A5
	for <git@vger.kernel.org>; Mon, 14 Jan 2013 02:25:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=xm1v
	eldWZiAZtAAXdFqkytKJs2o=; b=XLOYn73wkRma4kurnnk4P/MPM/fQUsjfX+o+
	J0em8CxzVPoJ7U/G7DYYETJ1ckh5z3g/kcAFCO5CWOTlmgtljKlOsizFD56axz0K
	pns19BoPYasboZeDWYiNUtFY4dhCTk3NUAkN2/1IBRyj7aeZyFWtpZclnpWbaR/J
	oqDTYto=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=O3I1aA
	NJZWb5BzFufLCYMgzpLSPtwJLuMNp2oIIk6tVRcxfvDspmy7bpBeHCM1EG9OLQ5k
	aF/POQnv6blX4tetgaeeYsm1BxeYDxVDnPghwonEyBi6qMHaqHfPpbvN4rw234A1
	Kzlr9zJ4KJLhabc0xBBxeXC9HqNd0kk5jZriE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CC1AAB8A4
	for <git@vger.kernel.org>; Mon, 14 Jan 2013 02:25:53 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5A9F6B8A3 for
 <git@vger.kernel.org>; Mon, 14 Jan 2013 02:25:53 -0500 (EST)
X-Mailer: git-send-email 1.8.1.421.g6236851
In-Reply-To: <7v8v7wiv3a.fsf@alter.siamese.dyndns.org>
X-Pobox-Relay-ID: A10EEC4C-5E1B-11E2-A2F0-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213460>

The theme is the same as the previous 3-patch series ($gmane/213415).

The first one is unrelated.

The last two are new, adding the "dual-use test" framework hinted
at the end of the previous round.

Oh, also this time the series is formatted with "format-patch -M",
to avoid overwhelming the readers with the rename.

Junio C Hamano (6):
  Makefile: add description on PERL/PYTHON_PATH
  cvsimport: allow setting a custom cvsps (2.x) program name
  cvsimport: introduce a version-switch wrapper
  cvsimport: start adding cvsps 3.x support
  cvsimport: make tests reusable for cvsimport-3
  cvsimport-3: add a sample test

 .gitignore                                 |   1 +
 Makefile                                   |  43 +++-
 git-cvsimport.perl => git-cvsimport-2.perl |   4 +-
 git-cvsimport-3.py                         | 344 +++++++++++++++++++++++++++++
 git-cvsimport.sh                           |   5 +
 t/lib-cvs.sh                               |  55 ++++-
 t/t9650-cvsimport3.sh                      |   4 +
 7 files changed, 440 insertions(+), 16 deletions(-)
 rename git-cvsimport.perl => git-cvsimport-2.perl (99%)
 create mode 100755 git-cvsimport-3.py
 create mode 100755 git-cvsimport.sh
 create mode 100755 t/t9650-cvsimport3.sh

-- 
1.8.1.421.g6236851
