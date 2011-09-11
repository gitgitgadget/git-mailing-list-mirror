From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] Fix some "variable might be used uninitialized"
 warnings
Date: Sun, 11 Sep 2011 13:48:09 -0700
Message-ID: <7vpqj6olfa.fsf@alter.siamese.dyndns.org>
References: <4E6D0E74.1020801@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sun Sep 11 22:48:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R2qwr-0006wG-CF
	for gcvg-git-2@lo.gmane.org; Sun, 11 Sep 2011 22:48:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754571Ab1IKUsM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Sep 2011 16:48:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51876 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754364Ab1IKUsM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Sep 2011 16:48:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CBFE95AFB;
	Sun, 11 Sep 2011 16:48:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rKw5Z80tUxIRmwyLGWTmCzgchD4=; b=O6i0G8
	C46HOM/43b2raMyULklPCqjSP8BH17ns0w9MWJRuiNF5qS9+Lqf7kIh0hjYZIWpT
	1C6RvU0D5O7MMXR+TtcE9qQzbPrXQgiVDiLTK88/cxV89OIYcgNl6bgz/b3MKWS6
	43DTa3jhWh7HJ8pqYzJq93CuqLXmQ1r0GPD3c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ATVG1rDMX+hjyNV5OU7O7l1U5dxgc1jt
	U6CdSgWQOHgslunbdAdATVxtBug2j/FKl/SXOSqyL/K+rdxFGNNRlAuBLNQqWsAk
	al3xiJEJHAq4XdisaRKKky5+7AQn89UInTVPXUX5WPXqoo66I9wx/9JRaJ9KeR8w
	mac+RJj0R/w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C29B75AFA;
	Sun, 11 Sep 2011 16:48:11 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4FA2D5AF9; Sun, 11 Sep 2011
 16:48:11 -0400 (EDT)
In-Reply-To: <4E6D0E74.1020801@ramsay1.demon.co.uk> (Ramsay Jones's message
 of "Sun, 11 Sep 2011 20:39:32 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5CB15BCA-DCB7-11E0-82A4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181193>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> In particular, gcc complains as follows:
>
>         CC tree-walk.o
>     tree-walk.c: In function `traverse_trees':
>     tree-walk.c:347: warning: 'e' might be used uninitialized in this \
>         function
>
>         CC builtin/revert.o
>     builtin/revert.c: In function `verify_opt_mutually_compatible':
>     builtin/revert.c:113: warning: 'opt2' might be used uninitialized in \
>         this function

Could you also add something to this effect to the commit log message:

	but I have verified that these are gcc being not careful
	enough and they are never used uninitialized.

If that is what you indeed have done, that is.

Thanks.
