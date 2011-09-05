From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/3] Add fetch.fsckobjects
Date: Sun,  4 Sep 2011 19:21:34 -0700
Message-ID: <1315189297-19497-1-git-send-email-gitster@pobox.com>
References: <7vliu4yv8w.fsf@alter.siamese.dyndns.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 05 04:21:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0Ool-00047d-TR
	for gcvg-git-2@lo.gmane.org; Mon, 05 Sep 2011 04:21:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751405Ab1IECVl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Sep 2011 22:21:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35429 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751318Ab1IECVk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Sep 2011 22:21:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 80BD444F7
	for <git@vger.kernel.org>; Sun,  4 Sep 2011 22:21:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=RfMN
	GOsARp0hxoA/dVkVTEklNPY=; b=AKZBm56JWG7bnvKUmLeNGi2y9T5PXxNLZ8zk
	qjwkqdIhegYRZCUuP+eP4mQqV6yDzGoVb6AB8RiOJaobEXjjHZ7cX5xQ6tR2wimw
	RFVMVv+gEpDkI9e6R7A8BezdX7A9n1t4DBTNklDFT3dYdPgc3dzqfrAXjUshcymv
	wgcKZIg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=jKnSQP
	h2Kpd375sLpJz7/Od1+f4NrbUXi/44xDPPNZicEOJdgT0uWROmFO6XszQ3ryDVC8
	CcgrD23DZyQs/viLr7yhUALjnDF3D5wJHNQthcXCng6cUq3olzW5a3ZVujn65EJ2
	XKL+1LSpKXjxMoiiv4vpJq0brIijQf0GZ6DM4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7425B44F5
	for <git@vger.kernel.org>; Sun,  4 Sep 2011 22:21:39 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 08DF944E7 for
 <git@vger.kernel.org>; Sun,  4 Sep 2011 22:21:38 -0400 (EDT)
X-Mailer: git-send-email 1.7.7.rc0.175.gb3212
In-Reply-To: <7vliu4yv8w.fsf@alter.siamese.dyndns.org>
X-Pobox-Relay-ID: C9538B88-D765-11E0-A490-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180709>

Interestingly enough, when we added receive.fsckobjects long time ago,
for some reason we forgot to add the corresponding fetch.fsckobjects,
which would have been an obvious thing to do.

So here is a series to add it.

Junio C Hamano (3):
  fetch.fsckobjects: verify downloaded objects
  transfer.fsckobjects: unify fetch/receive.fsckobjects
  test: fetch/receive with fsckobjects

 Documentation/config.txt        |   15 +++++-
 builtin/fetch-pack.c            |   18 +++++++
 builtin/receive-pack.c          |   17 +++++-
 t/t5504-fetch-receive-strict.sh |  104 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 150 insertions(+), 4 deletions(-)
 create mode 100755 t/t5504-fetch-receive-strict.sh

-- 
1.7.7.rc0.175.gb3212
