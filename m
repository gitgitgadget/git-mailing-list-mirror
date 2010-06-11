From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] unpack-trees: Make index lookahead less pessimal
Date: Thu, 10 Jun 2010 21:26:40 -0700
Message-ID: <7vljamkxdr.fsf@alter.siamese.dyndns.org>
References: <20100610001005.GA2635@glaurung.lavos.net>
 <20100610170804.GB2635@glaurung.lavos.net>
 <20100610181421.GC2635@glaurung.lavos.net>
 <20100611025907.GG2635@glaurung.lavos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brian Downing <bdowning@lavos.net>
X-From: git-owner@vger.kernel.org Fri Jun 11 06:26:55 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMvpW-0004z2-Fb
	for gcvg-git-2@lo.gmane.org; Fri, 11 Jun 2010 06:26:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751050Ab0FKE0t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jun 2010 00:26:49 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57231 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750874Ab0FKE0s (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jun 2010 00:26:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 993DDBBA3E;
	Fri, 11 Jun 2010 00:26:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OF6yXzfspXAj1LsNhHl0QyPtN2I=; b=sOJekz
	iCctbstJlGFTPMqJnHgpcdvqzqfu1xnx4xU+5X/avNHZvm/xeu9zhNN84lZHX4li
	chlBP6j1/1vs9Jx5NeYjD8eNcFojWiYowLY83otJUEKZMqjUUgCwUfadzPRhRjVl
	HImuy+YyvfaKWINp0FSensBn5sYcItk/3uw8g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JqdXgifa5gIozu3Ir83nv1SmJCOSJTsh
	uj3HJQrzUv/hcs8gjnU8UyjnohqCCZ6OPAN+Aol29BevmHz0IRhiYOhN+o2wlDjY
	HrXJFvbQO4uBZg3pIbKbzhF9TfMIZOprrXM5bMo5tqLEKNBQxBurVq0dj3sL/7CF
	ti0Hf1j6qLY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7410CBBA3D;
	Fri, 11 Jun 2010 00:26:44 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D021ABBA3B; Fri, 11 Jun
 2010 00:26:41 -0400 (EDT)
In-Reply-To: <20100611025907.GG2635@glaurung.lavos.net> (Brian Downing's
 message of "Thu\, 10 Jun 2010 21\:59\:07 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8A970396-7511-11DF-9FC0-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148922>

I _knew_ I coded that one pessimally and the code could be optimized not
to scan the same thing over and over again.

I haven't looked at the affected codepath for quite some time, but I'll
try to find time to review the patch when able.

Thanks.
