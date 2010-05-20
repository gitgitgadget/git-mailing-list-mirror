From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-status and git-diff now very slow in project with a
 submodule
Date: Thu, 20 May 2010 06:28:35 -0700
Message-ID: <7vy6fe7ldo.fsf@alter.siamese.dyndns.org>
References: <ht3194$1vc$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 20 15:28:48 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OF5nr-0001PS-3W
	for gcvg-git-2@lo.gmane.org; Thu, 20 May 2010 15:28:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753029Ab0ETN2n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 May 2010 09:28:43 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36495 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751961Ab0ETN2m (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 May 2010 09:28:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A4E7B46EB;
	Thu, 20 May 2010 09:28:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=aMKekuTvBTk/ezAiIEvs/8wnwM0=; b=DC1eldqlweHmx3KAWf0JwPe
	bck9U5c1QIVnG6+NVbJkklY97Ue7nz0LWohT2+nMEQQXCp6992GOQIvAsp9h21KU
	2eDQKQD1Cc89QprcLFvUOtPuOXFDeV4OM/0clM3BTCNEtiL6FL22LvhRFO9IyGpq
	AYGgOYU/zXo6GRl7NkBY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=YZ867heB7lGRk6L8OMsCrPFoFd6E5o8nfouy8oFe9QElQ/CrR
	NA+fBf/QP/oLqFZ8yY0VPtNBm9u0HokQWhHihGWl6G6hIH28eFIb3Wftf2ygGahZ
	gRu0uwPJVz28qV/xktXYbiwYeGB0Vmh85t3F7Cnen8FT6+BXL9ALdxhIzE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CF696B46EA;
	Thu, 20 May 2010 09:28:39 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 33A59B46E6; Thu, 20 May
 2010 09:28:37 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9A2D05DA-6413-11DF-AB5C-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147388>

Andy Parkins <andyparkins@gmail.com> writes:

> One additional small point: why do untracked files in a submodule make the 
> module dirty?  I've often got a few "temp.ps" or "debug.log" or 
> "backtrace.log" files lying around -- inappropriate to add to an ignore 
> file, but they don't make my working directory dirty.

"They don't make my working directory dirty" is something only you can
decide, until you tell git about that fact, isn't it?

The way to tell git about them is to use the ignore/exclude mechanism.
Why are they "inappropriate to add to an ignore file"?  At least you could
have "*.log" in your personal exclude $GIT_DIR/info/exclude, no?

As to the not-working-configuration I don't remember the codepath well, so
sorry but no answer from me right now.
