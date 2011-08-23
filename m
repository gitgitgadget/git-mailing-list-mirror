From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/2] clone-local fixup
Date: Mon, 22 Aug 2011 18:05:14 -0700
Message-ID: <1314061516-24964-1-git-send-email-gitster@pobox.com>
References: <7vliulun2a.fsf@alter.siamese.dyndns.org>
Cc: Hui Wang <jason77.wang@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 23 03:05:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvfQi-0006TX-IJ
	for gcvg-git-2@lo.gmane.org; Tue, 23 Aug 2011 03:05:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754612Ab1HWBFU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Aug 2011 21:05:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50512 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751719Ab1HWBFT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Aug 2011 21:05:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7E8DA4AAC;
	Mon, 22 Aug 2011 21:05:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=uiVQ
	Xak9VS8eOuQT+J8ZH98G6/o=; b=B4XDDPXeR9Ia11FdIgPoa3mZfDp97cj6ddvJ
	s1f5RHv8n1wqmoSZx41alhwBz+dOUMwG7dt1sx4jIIqR4UcdV5AwTcfuXZ/WPwd5
	JF85o+SOLEENS8cJdOLOD696qipqbjABtY5tWkQLWPrysdwxcUax9cCL3jU73hBU
	I4aiLJI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	ckNihnz+7JqhB7ebxki45LtDQEjgG6eae5HS7+4VrelNNqZUzMGVAnFsOhXYmN/k
	EDd99lnKFhFAlr8Ga1GGE8xUbIYx2D/K1JHMopv7pCvxSUkcSrZU+EMTIyAXrJNG
	FOhp+GwEK13ItxTunIUyyQWaoadoArcJKPpNxy5vsck=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 744984AAB;
	Mon, 22 Aug 2011 21:05:18 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E003B4AAA; Mon, 22 Aug 2011
 21:05:17 -0400 (EDT)
X-Mailer: git-send-email 1.7.6.557.gcee42
In-Reply-To: <7vliulun2a.fsf@alter.siamese.dyndns.org>
X-Pobox-Relay-ID: F765609C-CD23-11E0-9EEE-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179908>

So I ended up tackling this myself. I didn't bother moving the
add_to_alternates_file(), though.

Junio C Hamano (2):
  clone: allow more than one --reference
  clone: clone from a repository with relative alternates

 builtin/clone.c  |   82 +++++++++++++++++++++++++++++++++++++++++------------
 sha1_file.c      |    2 +-
 t/t5601-clone.sh |   23 +++++++++++++++
 3 files changed, 87 insertions(+), 20 deletions(-)

-- 
1.7.6.557.gcee42
