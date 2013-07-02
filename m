From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/2] Fix t1512 (disambiguation of object names)
Date: Mon,  1 Jul 2013 22:12:33 -0700
Message-ID: <1372741955-20691-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 02 07:12:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UtstO-0004lK-Qf
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jul 2013 07:12:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751546Ab3GBFMi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jul 2013 01:12:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47691 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750994Ab3GBFMi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jul 2013 01:12:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4495F27D3A
	for <git@vger.kernel.org>; Tue,  2 Jul 2013 05:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id; s=sasl; bh=Wf49DudMV60DN4l5N/COOesWOAI
	=; b=Z+lF+CLwrYqrHF8kNyEHD2WGDiM/qAmlQGdNFHXCS9+maboSqGKaKeb6mFy
	M7P1WRbCd2jnezqW+ao65xUT/Zd9Mw65RjV9JGPyE3yCOTCk3PE8KuZvL8oIFm7A
	jVe+6q8HvLNEcbOLRMfk0RAW3JMCY9RWMSJFJfb+LPSF1UTg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id; q=dns; s=sasl; b=EmQt0S1vqEk9GOS6cDZ3YEdk+0dtM
	PT6B4e5nlp3xpcbhBsShHxptIk5mRQhCQmIwImkijnCpTyUWr0oV5O/JDYJgLU3Z
	pP7TpkyryerzxaVke+LSIOya3zYRpdyMWUh6I97qdKwvY2/lSJBuFeaAXMrSt1sQ
	TVcDozWD+3gX28=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 39A8827D39
	for <git@vger.kernel.org>; Tue,  2 Jul 2013 05:12:37 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B70A727D38
	for <git@vger.kernel.org>; Tue,  2 Jul 2013 05:12:36 +0000 (UTC)
X-Mailer: git-send-email 1.8.3.2-795-g615e8f0
X-Pobox-Relay-ID: 028377C4-E2D6-11E2-8EAF-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229359>

Here is a small two-patch series to break a test that has been
passing by mistake.

Junio C Hamano (2):
  t1512: correct leftover constants from earlier edition
  get_short_sha1(): correctly disambiguate type-limited abbreviation

 sha1_name.c                         |  2 +-
 t/t1512-rev-parse-disambiguation.sh | 32 ++++++++++++++++++++++----------
 2 files changed, 23 insertions(+), 11 deletions(-)

-- 
1.8.3.2-795-g615e8f0
