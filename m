From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-cvsimport: strip question-mark characters in tags
Date: Wed, 14 Apr 2010 07:29:03 -0700
Message-ID: <7vfx2yqf9s.fsf@alter.siamese.dyndns.org>
References: <20100414133831.GA12135@f.santiago.vpn.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ed Santiago <santiago@redhat.com>
X-From: git-owner@vger.kernel.org Wed Apr 14 16:29:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O23aj-00089q-5G
	for gcvg-git-2@lo.gmane.org; Wed, 14 Apr 2010 16:29:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755727Ab0DNO3M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Apr 2010 10:29:12 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:64583 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755573Ab0DNO3L (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Apr 2010 10:29:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B3B8FAA432;
	Wed, 14 Apr 2010 10:29:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LnQ/ja48Vmmr715Mcy9AIY4C770=; b=EeF9QU
	3GLBk4yMRgWITwMhigQ5ldf1UlixPhaBVaQomM9i7QfnYK9h02jac6bmfINbIp9G
	nnqqhccF4lBIqZb/FdjbYffvHAYavvd3HUZiDtpqzo3x1fH9fBC/I+GDaPAOdq+F
	6D5jam9bA0zdJjjhkZ2/9SxVCJVJZwKWyEbqc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UdtqXfyl7YgnIWftxwvJYmm/HDCEtHrF
	rbbcgK8vIPn7MtWEKvst/G0Bu+bGNdyiUsUoU9PNUE4tWZfZINJGKSvWaehJMeRQ
	1bYYcOTaz5Awbv3eHFMG+FWF42LlyWbSafU4z1yKzUZx9o7wB3RhENWbz5fVFY1e
	/l9k/n2tYSU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 74E0CAA431;
	Wed, 14 Apr 2010 10:29:07 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B6FE3AA42E; Wed, 14 Apr
 2010 10:29:04 -0400 (EDT)
In-Reply-To: <20100414133831.GA12135@f.santiago.vpn.redhat.com> (Ed
 Santiago's message of "Wed\, 14 Apr 2010 07\:38\:31 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 157F1998-47D2-11DF-AC55-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144876>

Ed Santiago <santiago@redhat.com> writes:

> Question mark character appears to be valid in a CVS tag,
> but not a git one.  Remove it.  Leave open the possibility that there may
> be more such characters; and comment (FIXME) that we may want to replace
> those instead of removing them.

I agree that people may want to optionally replace them to avoid mapping
two originally different tags into the same one.

Does your regexp chain check other invalid refname sequences, such as ".name",
"na..me", etc.?

> Also: if git tag command fails, do not include $! in our
> error message: it is not useful after system(), and will
> only serve as a red herring.
> ---

Sign-off?
