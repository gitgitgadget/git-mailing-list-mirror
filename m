From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/5] "status --ignored"
Date: Sat, 10 Apr 2010 00:40:51 -0700
Message-ID: <1270885256-31589-1-git-send-email-gitster@pobox.com>
References: <20100410040959.GA11977@coredump.intra.peff.net>
Cc: Jeff King <peff@peff.net>, Eric Raymond <esr@snark.thyrsus.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 10 09:41:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0VJi-0000KR-Q0
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 09:41:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751470Ab0DJHlM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 03:41:12 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56353 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750982Ab0DJHlG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 03:41:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 610E8A9549;
	Sat, 10 Apr 2010 03:41:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to; s=sasl; bh=SYJ8kBWbmH04Jys
	YmuHgYcgmbEA=; b=HnLNtIkHiqEp5FJqw9HH6fGXTim4q4TmKRxFV0syLJjc3ng
	XvzSmsrTh//XMx8YH17BUYRBWfzlgAxgvpB4wk35fm5pXbCvnVmFSw9hsH5C5Va4
	xjrF+hAbMO7qVEzCJSoOW2TzJTUi5ci44dLoLGkFYa+Kylokt8bc9fE5Q/8M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to; q=dns; s=sasl; b=rbByXdJTB
	Rrtxv7QLcabIq8Y2/mSEfkckgqrYiybHgTcbkfAGyaKRZtc1fQRele6ywu9nvRgj
	kO8l0Gl8vrSc3K5emki8FMcdVC6zRayXaOGrUfHy0eBzge0TAZJZyJFuUmn3Pki5
	WnLsmVe+3pPohy99tKXcEPUw6FEkOujtVs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B509A9548;
	Sat, 10 Apr 2010 03:41:00 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 95C2FA9547; Sat, 10 Apr
 2010 03:40:57 -0400 (EDT)
X-Mailer: git-send-email 1.7.1.rc0.264.g94f6e
In-Reply-To: <20100410040959.GA11977@coredump.intra.peff.net>
X-Pobox-Relay-ID: 68587E90-4474-11DF-A34E-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144525>

Jeff King <peff@peff.net> writes:

>> If ignored files are not listed, that's another problem. Even more
>> serious, actually.
>
> See above.
>
> It wouldn't be too hard to add them in, and would look something like
> the patch below.

As I didn't see a patch, I did a rough outline just for fun.

Junio C Hamano (5):
      wt-status: remove unused workdir_untracked field
      wt-status: plug memory leak while collecting untracked files
      wt-status: collect ignored files
      wt-status: rename and restructure status-print-untracked
      status: --ignored option shows ignored files
