From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/4] for-each-ref --format='%(symref) %(symref:short)
 %(flag)'
Date: Sat, 13 Feb 2010 12:30:29 -0800
Message-ID: <1266093033-9526-1-git-send-email-gitster@pobox.com>
References: <20100213085132.GA13181@coredump.intra.peff.net>
Cc: Jeff King <peff@peff.net>, Larry D'Anna <larry@elder-gods.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 13 21:31:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgOe3-0007TJ-4U
	for gcvg-git-2@lo.gmane.org; Sat, 13 Feb 2010 21:31:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757766Ab0BMUam (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2010 15:30:42 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57910 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754880Ab0BMUal (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2010 15:30:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CF47699A97;
	Sat, 13 Feb 2010 15:30:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to; s=sasl; bh=aUGk0qye4mEICu7
	cXrbPJUD7joY=; b=m9Au3R40LUB78P9eb/hkHh3rzYw9m7FeV4teMdg5/QbpTh+
	XdbvkxmctT5+Ucv+ElVV1G3tEFX2OWFyb75nwOhBU/gYIQVfSC0OQdbS923IWdxh
	qjnwIE2Ia8HC3ndKCCus2rx8+N+OH5c9LUAjq2ID7C/eySLc+IZmfp/r8Kpc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to; q=dns; s=sasl; b=Rky11Beju
	NLI0asVh3O1BoM0tUp091tPYpZWuMPAP1lX1t3CmqvibWIpjIcNkBl225tagteFT
	qS6Lbym7rMVfv9zn/fX8AQBWh5/Zhq/OEdmwmAatxYklxearu9EOVW/SeBzxzlMg
	JvPUKIGLi/OO9J90wrNkceNFLW9xAq1ZQY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id ABFCE99A93;
	Sat, 13 Feb 2010 15:30:37 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 142CD99A92; Sat, 13 Feb
 2010 15:30:34 -0500 (EST)
X-Mailer: git-send-email 1.7.0.169.g57c99
In-Reply-To: <20100213085132.GA13181@coredump.intra.peff.net>
X-Pobox-Relay-ID: A5225BBE-18DE-11DF-9108-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139830>

Here is my attempt to summarize the discussion so far.

Junio C Hamano (4):
  builtin-for-each-ref.c: comment fixes
  builtin-for-each-ref.c: check if we need to peel onion while parsing
    the format
  for-each-ref --format='%(symref) %(symref:short)'
  for-each-ref --format='%(flag)'

 builtin-for-each-ref.c |   77 ++++++++++++++++++++++++++++++++++++-----------
 1 files changed, 59 insertions(+), 18 deletions(-)
