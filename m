From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] ls-remote: default to 'origin' when no remote specified
Date: Wed, 07 Apr 2010 22:35:40 -0700
Message-ID: <7v8w8y8q1f.fsf@alter.siamese.dyndns.org>
References: <1270699083-5424-1-git-send-email-rctay89@gmail.com>
 <20100408044552.GA30473@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tay Ray Chuan <rctay89@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 08 07:35:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzkPE-0000BC-Sx
	for gcvg-git-2@lo.gmane.org; Thu, 08 Apr 2010 07:35:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753616Ab0DHFfv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Apr 2010 01:35:51 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33485 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753064Ab0DHFft (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Apr 2010 01:35:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 16CE6A953B;
	Thu,  8 Apr 2010 01:35:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5dsYb1buLsGTNj+EVDLyRrKnMnQ=; b=UCm9mR
	MJNivROUK0EMV6Ux8BC0O7SG+8PP20T+Dg45lQGsUqwa9bHyLeXHgOp/Wn0IR8vW
	TJsz9h7ihmGO6a2QKBmChlXSJphjjL/0YcRuzJp83i2eLtxRrLHSeKjEl57AV89G
	Yfwgj5sjosAEMres1Jpw4KhwsERnpittHJS8g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=n34mjfKltSySysZw+RCKd2g/PIJSfN4l
	RZo6CeK0w5omRfjDvjGUlIlLE9ex4RO3NmSEBiMozJufvGQsVYLFIkZFxDa1vCwF
	JihgjrZLuFwdF7PJa4LLc6p/dcgz3uVK/DUl7IT8tLhEMnQeTtOSA84geVfxkvAw
	PutQYHihriQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CED94A9539;
	Thu,  8 Apr 2010 01:35:45 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C2AF3A9536; Thu,  8 Apr
 2010 01:35:41 -0400 (EDT)
In-Reply-To: <20100408044552.GA30473@coredump.intra.peff.net> (Jeff King's
 message of "Thu\, 8 Apr 2010 00\:45\:52 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9496C0CA-42D0-11DF-A1FE-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144318>

Jeff King <peff@peff.net> writes:

> I don't really see a problem with this. The current behavior produces an
> error, so it is not as if we are breaking somebody's workflow, and the
> only sensible default is the same one used by the other commands.

I'd agree only if "the other commands" default to the same remote;
otherwise as a plumbing, ls-remote should insist that the user be more
explicit.

The only odd-man out that would worry me is "git pull", as I expect
everybody written in C would just use remote_get(NULL).
