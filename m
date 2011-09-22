From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to use git attributes to configure server-side checks?
Date: Thu, 22 Sep 2011 10:26:07 -0700
Message-ID: <7vwrd0xzdc.fsf@alter.siamese.dyndns.org>
References: <4E7A3BDE.3040301@alum.mit.edu>
 <7vy5xh1whq.fsf@alter.siamese.dyndns.org> <4E7AF1AE.5030005@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git discussion list <git@vger.kernel.org>,
	Jay Soffian <jaysoffian@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Sep 22 19:26:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6n2P-0003W9-8q
	for gcvg-git-2@lo.gmane.org; Thu, 22 Sep 2011 19:26:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752753Ab1IVR0N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Sep 2011 13:26:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61163 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751881Ab1IVR0L (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Sep 2011 13:26:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AE2FE6823;
	Thu, 22 Sep 2011 13:26:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oTWHkH7wPZ3Gw7WRcSdBHuGTAhc=; b=aUahmx
	X5yO6VS7N+jdtN2jyOY7FwzA1krTf/M5F9pnBErXk5rkAaY/7woUu7BlC87YERhg
	1/6pfLuszUB3inAEsR4jiqUlX56OHAX1TS55HvEHqLExGhIHUp2E5DXg1yAeWhyN
	Ka8wWSukMni/Sn/cY8iSVduiBHzuufbctjebI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RhkE7BFvKGlNkS1q6FSHDBnosNdE4OD+
	Jdmk/Gb0OpDHrFoCAcSz49DSVV8FuBQyTVgR6nXWEYc13bJP+t104KDRGjBU3V3F
	bI/TVbBtKXiQZq16Hp6Aq6AhPo8LxN1WOHJAfwxXzDuiSe/JoZSRVBLbcBCfjhsz
	82zs0ze+UqA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A5FB76822;
	Thu, 22 Sep 2011 13:26:09 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3CB8C6821; Thu, 22 Sep 2011
 13:26:09 -0400 (EDT)
In-Reply-To: <4E7AF1AE.5030005@alum.mit.edu> (Michael Haggerty's message of
 "Thu, 22 Sep 2011 10:28:30 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F5EA66CA-E53F-11E0-8D47-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181903>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> I would like the checking configuration to be *versioned* along with the
> code.  For example, suppose my project decides to enforce a rule that
> all Python code needs to be indented with spaces.  It might be that not
> all of our old code adheres to this rule, and that we only want to clean
> up the code in master.

You want to sneak in a badly formatted code? Add an entry to the in-tree
attributes file to disable whitespace checking to cover that file!

So even though I agree with you that the check mechanism may need to be
aware of what revision it is checking and adjust which rules are applied
when checking the revision, I do not think using in-tree attribute file is
the right solution to that problem.
