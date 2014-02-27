From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Branch Name Case Sensitivity
Date: Thu, 27 Feb 2014 11:50:45 -0800
Message-ID: <xmqqvbw0xrl6.fsf@gitster.dls.corp.google.com>
References: <CAJHY66EQD280QgXBCoZU4y_aqSEu3A1hXzeW7X-rtT6vMZ92oA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Lee Hopkins <leerhop@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 27 20:50:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJ6yr-0007Xi-Dh
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 20:50:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751408AbaB0Tut (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Feb 2014 14:50:49 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53352 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751155AbaB0Tut (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Feb 2014 14:50:49 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2629370B1E;
	Thu, 27 Feb 2014 14:50:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=n6iBUHmtiz8k6tYZUiU6oRs8I34=; b=mqjFyP
	/9rYFdfdM5s0Q7VObCqPCAT4ZgmdwEozv8e5lC8l+E4Z0DIgmRF0FXnJKzIgFTo9
	azws2IOrqwRWwA7qZ9mLYFa2Ts4jMvFMoNnVpWa1ciPthwxsn2TXbzHp7an5rkpe
	qgiODgAG7z3JkbQEtvfJxhtt/KIJwetLT+0d8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ViXYCDh/nbMR0Ggb+7SsERTHN7NecD5O
	xRV+LSBN2MDm4fihgXClnSRYyXJ+DCTcfy3CnzK0dwy4SG92ll4k7ubt8z6LIHal
	QCw54dULdicsK4RRJjutJ3LS2vDiWYlUih/+2rZKU4PJ+vn6LvZ+crP1McWGb4hD
	4oOZN5HUajA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E76B070B1D;
	Thu, 27 Feb 2014 14:50:47 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0D48770B18;
	Thu, 27 Feb 2014 14:50:46 -0500 (EST)
In-Reply-To: <CAJHY66EQD280QgXBCoZU4y_aqSEu3A1hXzeW7X-rtT6vMZ92oA@mail.gmail.com>
	(Lee Hopkins's message of "Wed, 26 Feb 2014 16:06:54 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 73863E78-9FE8-11E3-835B-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242846>

Lee Hopkins <leerhop@gmail.com> writes:

> Last week I ran across a potential bug with branch names on case
> insensitive file systems, the complete scenario can be found here:
>
> https://groups.google.com/forum/#!topic/msysgit/ugKL-sVMiqI
>
> The tldr is because refs are stored as plain text files except when
> packed into packed-refs, Git occasionally cannot tell the difference
> between branches whose names only differ in case, and this could
> potentially lead to the loss of history.
>
> It sounds like this is a known issue, and after some more digging I
> did find some older threads related to this topic, but nothing recent.

Yes, it is not limited to branch names but also applies to tags and
filenames in your working tree.

Perhaps git-{branch,tag}.txt and possibly gitrepository-layout.txt
in Documentation/ may need a new "*Note*" section to warn against
this.

Thanks.
