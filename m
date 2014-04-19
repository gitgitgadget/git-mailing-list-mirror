From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/5] fc/transport-helper-sync-error-fix rebased
Date: Sat, 19 Apr 2014 00:00:38 -0700
Message-ID: <1397890843-27035-1-git-send-email-gitster@pobox.com>
References: <1397334812-12215-1-git-send-email-felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 19 08:59:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WbPF4-0006om-9T
	for gcvg-git-2@plane.gmane.org; Sat, 19 Apr 2014 08:59:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbaDSG7J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Apr 2014 02:59:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57062 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750996AbaDSG7I (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Apr 2014 02:59:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DAA5A6E5FD
	for <git@vger.kernel.org>; Sat, 19 Apr 2014 02:59:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=xFdJ
	LstydB8rbIIA7gG3mI8bYu8=; b=GZwms+c4C0GWn9mF1hU5gsVv/KVnay5EeNOX
	gVCiKfaXM9lb3qRLQiycMfBVVDy4XaFUpsXSS+vIQnLQYX3hmdY+t1rnbGiu5OhS
	aA7Du7JbT5iLrmiNStDBHW6wBj1ub8Q5B9pfZsjWe3xUd+6FxC96zUowMqPVwIsQ
	i98AgPs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=L4/4kD
	UFjNNOEAEAopkH30yjcDm8P9ROKCIMg5eMFS+/Ghb9qn7b3Hu0p/6A3giYp1umb+
	wUUQkRK/myrAy1SVcCoHg6u2Yiurw0YHNyvuXGxqd/0GsuT8J4iokjlF7EPCTBGt
	pflJ4iEII3huakWjstgumulic/A+vLDjmfKnY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C98706E5FC
	for <git@vger.kernel.org>; Sat, 19 Apr 2014 02:59:07 -0400 (EDT)
Received: from pobox.com (unknown [198.0.213.178])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4F45A6E5F5
	for <git@vger.kernel.org>; Sat, 19 Apr 2014 02:59:04 -0400 (EDT)
X-Mailer: git-send-email 1.9.2-459-g68773ac
In-Reply-To: <1397334812-12215-1-git-send-email-felipe.contreras@gmail.com>
X-Pobox-Relay-ID: 180366A0-C790-11E3-A64D-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246501>

As I have said in the recent What's cooking reports, the original
posted here were based on older codebase and needed to be rebased,
but it had some conflicts and I wanted to see the result double
checked by the original author before we can merge it to 'next',
cooked there and hopefully merged to 'master' before tagging -rc1.

So here is the series that has been queued in 'pu' for the past
several days.

Felipe, can you double check it?

Thanks.

Felipe Contreras (5):
  transport-helper: remove barely used xchgline()
  remote-helpers: make recvline return an error
  transport-helper: propagate recvline() error pushing
  transport-helper: trivial cleanup
  transport-helper: fix sync issue on crashes

 t/t5801-remote-helpers.sh | 20 ++++++++++++-
 transport-helper.c        | 73 ++++++++++++++++++++++++++++-------------------
 2 files changed, 63 insertions(+), 30 deletions(-)

-- 
1.9.2-459-g68773ac
