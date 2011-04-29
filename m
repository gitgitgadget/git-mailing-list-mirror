From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/3] Return of "add -p [E]dit" fix
Date: Fri, 29 Apr 2011 15:49:30 -0700
Message-ID: <1304117373-592-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 30 00:49:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFwVR-0007vp-SW
	for gcvg-git-2@lo.gmane.org; Sat, 30 Apr 2011 00:49:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755194Ab1D2Wto (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2011 18:49:44 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:32778 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753053Ab1D2Wtn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2011 18:49:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8DA2C554C
	for <git@vger.kernel.org>; Fri, 29 Apr 2011 18:51:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id; s=sasl; bh=ZKRu+NMAGGEhZzutgdPtYUZGjx8
	=; b=bI3X7NLufOrmFSa2Pchvs+NjslszxCgv7+SJT7+ZJAXdYr3eIA2i5twyiNE
	MuXrVLX9n2iX4gN35629x0yRxj5VS+bGQ+lD7gCDEVQtdxjmeysN0Aqz/sl5X6P/
	DBw8Xsbl5AHe51oYPBAMiwU4pgO5Cxl2MPRFVQL3JyqxiK3M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id; q=dns; s=sasl; b=BZ6Rv9GcjGo8l84NdIt1fQVdBkmDi
	8uheZGL6CIbG9Q5fT1vlF8cn64KCVqgnwPABGt4GXJMXo4rSUhs/2RhFpwnyZfHw
	fHULqcrcdjlMJqdXqa6zcP0IGv9RMwd/eXsi6FieZmy6saCTvHe6/e48qlWSrz6m
	RVWW47XNBRQZGk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8A768554B
	for <git@vger.kernel.org>; Fri, 29 Apr 2011 18:51:41 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0BADC5549 for
 <git@vger.kernel.org>; Fri, 29 Apr 2011 18:51:37 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.252.g565191
X-Pobox-Relay-ID: 3FB44104-72B3-11E0-AD55-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172506>

I kept this in the stalled state for too long.  Resending with tests
to move the topic forward.

Junio C Hamano (3):
  t3701: Editing a split hunk in an "add -p" session
  add--interactive.perl: factor out repeated --recount option
  "add -p": work-around an old laziness that does not coalesce hunks

 builtin/apply.c            |    9 ++++++---
 git-add--interactive.perl  |   16 ++++++++--------
 t/t3701-add-interactive.sh |   36 ++++++++++++++++++++++++++++++++++++
 3 files changed, 50 insertions(+), 11 deletions(-)

-- 
1.7.5.252.g565191
