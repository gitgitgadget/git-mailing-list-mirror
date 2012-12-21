From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v7 0/7] coloring test output after traffic signal
Date: Thu, 20 Dec 2012 19:12:31 -0800
Message-ID: <1356059558-23479-1-git-send-email-gitster@pobox.com>
References: <CAOkDyE9tDYRYzojzNnjWsT7UygxMAurHqLSDGA66_LMPD2Wmnw@mail.gmail.com>
Cc: Adam Spiers <git@adamspiers.org>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 21 04:13:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tlt2i-0008TT-73
	for gcvg-git-2@plane.gmane.org; Fri, 21 Dec 2012 04:13:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751925Ab2LUDMm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2012 22:12:42 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47493 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751690Ab2LUDMl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2012 22:12:41 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D305FA80A;
	Thu, 20 Dec 2012 22:12:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=d5uK
	uwfyTWLAG03EIlqvxB1ga3g=; b=MedBvUu5O5I+EPy6SoBZvs7lxatlRjdn3TMm
	cM6Zris3+pEm1IJjbOxpqnNcRru6ol+ytyjLNeNxE5y6lyDFlxwfA1N/8WMTmo0F
	gDOapZyiEiQD1gz0WHw2fXzjtmSqm+Rg7EGRt+VoHCw9tWRRmbV4wb8FkSKlLuq0
	j1oLOY4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	UyeMS8Od2itu9GeT07Jzkjkm633l0WfFogix30aaldP48KXWqSS71Rk07YC5+p8a
	LNhMmr4BRNW9XalRrOAwvfhD6PP1MDpxQd2B0bSo7JJzf2j/td9B5+/YM09RRzRc
	XD32T6An6O3IM8AU82ph7lBogY0psAMwr7//tN+RAA0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C0D7CA809;
	Thu, 20 Dec 2012 22:12:40 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3FDA0A808; Thu, 20 Dec 2012
 22:12:40 -0500 (EST)
X-Mailer: git-send-email 1.8.1.rc2.225.g8d36ab4
In-Reply-To: <CAOkDyE9tDYRYzojzNnjWsT7UygxMAurHqLSDGA66_LMPD2Wmnw@mail.gmail.com>
X-Pobox-Relay-ID: 475884D6-4B1C-11E2-B734-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211944>

To conclude the bikeshedding discussion we had today, here is what I
queued by squashing stuff into relevant patches, so that people can
eyeball the result for the last time.

Adam Spiers (7):
  tests: test number comes first in 'not ok $count - $message'
  tests: paint known breakages in yellow
  tests: paint skipped tests in blue
  tests: change info messages from yellow/brown to cyan
  tests: refactor mechanics of testing in a sub test-lib
  tests: test the test framework more thoroughly
  tests: paint unexpectedly fixed known breakages in bold red

 t/t0000-basic.sh | 214 ++++++++++++++++++++++++++++++++++++++++++-------------
 t/test-lib.sh    |  29 +++++---
 2 files changed, 184 insertions(+), 59 deletions(-)

-- 
1.8.1.rc2.225.g8d36ab4
