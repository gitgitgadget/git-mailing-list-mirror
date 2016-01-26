From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 17/19] mingw: fix git-svn tests that expect chmod to work
Date: Tue, 26 Jan 2016 09:42:20 -0800
Message-ID: <xmqqwpqwck5f.fsf@gitster.mtv.corp.google.com>
References: <cover.1453650173.git.johannes.schindelin@gmx.de>
	<9045a31ec16da672a74d9b1e0b65807d21ef277e.1453650173.git.johannes.schindelin@gmx.de>
	<xmqq1t96be2k.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1601251910080.2964@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 26 18:42:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aO7dL-0007XY-Tj
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 18:42:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965026AbcAZRmY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2016 12:42:24 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58451 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932586AbcAZRmX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2016 12:42:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1EAA63E18F;
	Tue, 26 Jan 2016 12:42:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=a7w2SCuCVtKaVv8VmH8IjfkUWRQ=; b=v7VRnE
	r68DGv9zEWM8zFSO/ENHadqtmicKF6W2Bpkkvlpea4lJJkH22/BCRBBm9FwXnC+a
	C6YPd4nh2t+jqOUMeG7ziawuKxEutqphRd6uPQ+6MpJGRlRjHLNhfdXsfUfI6VWP
	9BVr5jSA46QZG68S+pVEEy57F6pXoiXG3yjdo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NIdhJZDuD+i9rJtRhN0g7bEfN30rx4Pd
	e7guAvO5DVgna3/oGwNyDBDNl6eVJjOWrMq9u/sZcIjUan4uKvWvlvmyrBI12zw8
	I3NWCyx9KjZuyrsNS9iWFgIgGYjnDfkJxZe1vEmt1iW428veIXYnDIXu/R7bC4P1
	jg/Wn1k8r+0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 169B83E18D;
	Tue, 26 Jan 2016 12:42:22 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 88F103E18C;
	Tue, 26 Jan 2016 12:42:21 -0500 (EST)
In-Reply-To: <alpine.DEB.2.20.1601251910080.2964@virtualbox> (Johannes
	Schindelin's message of "Tue, 26 Jan 2016 07:31:27 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2706F500-C454-11E5-A53A-80A36AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284844>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> This is my fault: there are two MINGW prereqs, and they guard against
> trying to work with file names ending in a dot (which is illegal on
> Windows' file systems).

Ahh, I failed to notice that MINGW was protecting against the "dot"
thing.  So I was wrong; that one cannot be !POSIXPERM.

Thanks for clarifying.
