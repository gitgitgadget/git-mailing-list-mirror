From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Test t5560: Fix test when run with dash
Date: Thu, 14 Jan 2010 00:41:42 -0800
Message-ID: <7vfx69hyd5.fsf@alter.siamese.dyndns.org>
References: <4B4EAB58.6040901@alum.mit.edu>
 <1263452477-15250-1-git-send-email-tarmigan+git@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Tarmigan Casebolt <tarmigan+git@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 14 09:42:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVLHD-0007P4-Gq
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 09:41:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756539Ab0ANIly (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 03:41:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756534Ab0ANIly
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 03:41:54 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45310 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756532Ab0ANIlx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 03:41:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F357790AFF;
	Thu, 14 Jan 2010 03:41:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=1ZfjnYo0qZfjOk0IbAIWv2YJs2g=; b=D+2N181lkpyMj6x9Qv0AQ4Y
	Z559TsnmRs8KHA9iKCTJnTBSupwYcWq7F9KVyl1F/SMJNip1F8SXERqc0CMb+i+Y
	asy1A4s7Yva1+vcv49TcXUE601CGvLjr30o3YDJKhk4RXtrjJiB6zk67NbEQYsoD
	4rqlJqKqPTQw0X4TOchk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=TqYrpiBudjwTAImBMPNL8+fGUXcPkG1dGfZBKP2ScrMYViKo9
	bL3bpid4QjGumYF5JF2FFLOqzQJZWpJCSwkEH4JC3fMeRjBdNboaL+23o6qo+Wzf
	6Zd24yPgFGzdjSe0EIqOT9pZUJ7xtz+8JRD4F3HXkQtQ8CESD5zUImz1pM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B1F0F90AFB;
	Thu, 14 Jan 2010 03:41:48 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D5DBF90AF7; Thu, 14 Jan
 2010 03:41:43 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A77FD53E-00E8-11DF-8317-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136967>

Tarmigan Casebolt <tarmigan+git@gmail.com> writes:

> dash is more finicky than some shells and this change seems to make it
> happier.

"Finicky" won't help other people to learn what to avoid making the same
mistake in the future.  Please spell the problem out more explicitly.

I think the issue is that some shells do not like the "Run this command
(and only this command) under these environment variable settings"

	VAR1=VAL1 VAR2=VAL2 command

if "command" is a shell function.

Does that match your understanding of the problem?
