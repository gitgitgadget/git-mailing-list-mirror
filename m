From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/3] Move the user-facing test library to
 test-lib-functions.sh
Date: Thu, 16 Feb 2012 14:14:19 -0800
Message-ID: <7v7gzmxw78.fsf@alter.siamese.dyndns.org>
References: <cover.1329428159.git.trast@student.ethz.ch>
 <d5127b0051d354fc0c02666b972b853d1736d09c.1329428159.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Feb 16 23:14:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ry9at-0007cg-Mj
	for gcvg-git-2@plane.gmane.org; Thu, 16 Feb 2012 23:14:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753610Ab2BPWOX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Feb 2012 17:14:23 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49150 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752224Ab2BPWOW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Feb 2012 17:14:22 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 560717B86;
	Thu, 16 Feb 2012 17:14:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wpbJ4DlTRu1LK9vAsP8UEV+uopA=; b=KF6ThK
	rCbEpXPS3CRXb2GbN3PO1bqpdEmBcjU0mkgu60kyMAaScn2Oq9rOLhKC1lQnOoyj
	QJejK3nc06DiMCk0t7m/2Pyfd6xkX6p+eo7/iH4nQlmcjcY+SRjuX7VXvKMG34jj
	Jvj8Hs+eiMA+jhZEuheeAwadsseMLIdipRG5g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=voIqIGyH/8IlwjUgfK2LTZ4nJqaXyqg9
	mtVIM9L2QhC7BdMk4DwElDr/qDF4C4dcvyExh3CqvYtzI+AcrJttfwHLv4iTRw/g
	07Nj/RESy9FSmS750Vdmya7AOHS3Oh+Yzpate0dVYaYP52JP7GMkINhAkDguJ6J7
	/rorOUayS6w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4D3D17B85;
	Thu, 16 Feb 2012 17:14:21 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B80467B84; Thu, 16 Feb 2012
 17:14:20 -0500 (EST)
In-Reply-To: <d5127b0051d354fc0c02666b972b853d1736d09c.1329428159.git.trast@student.ethz.ch> (Thomas Rast's message of "Thu, 16 Feb 2012 22:41:13 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 932DE79E-58EB-11E1-8752-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190917>

Thomas Rast <trast@student.ethz.ch> writes:

> This just moves all the user-facing functions to a separate file and
> sources that instead.
>
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>
> ---
>  t/test-lib-functions.sh |  835 +++++++++++++++++++++++++++++++++++++++++++++++
>  t/test-lib.sh           |  552 +-------------------------------
>  2 files changed, 840 insertions(+), 547 deletions(-)
>  create mode 100644 t/test-lib-functions.sh

I would have expected from the log description that the number of deleted
lines would be about the same as the number of added lines, and the
difference would primarily come from the addition of "include" aka "dot"
". ./test-lib-functions.sh" that becomes necessary in t/test-lib.sh, some
boilerplate material at the beginning of the new file e.g. "#!/bin/sh",
and copying (not moving) the same Copyright block to the new file.

But 835-552 = 283 feels way way more than that.  What else is going on?
