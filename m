From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] jk/version-string and google code
Date: Fri, 10 Aug 2012 14:42:43 -0700
Message-ID: <7vboiiifu4.fsf@alter.siamese.dyndns.org>
References: <20120810075342.GA30072@sigill.intra.peff.net>
 <7vboiilpvs.fsf@alter.siamese.dyndns.org>
 <CAD0k6qTnQ+b8e2wt4WZ2HhOdsKXzcMkGbUZBkbw2j6_mQdE9GA@mail.gmail.com>
 <20120810180836.GA29597@sigill.intra.peff.net>
 <CAD0k6qSZYH5mvwR5PKhs1FFAPqMfRryXooxd_qhtt+eGXU7pUA@mail.gmail.com>
 <20120810182555.GA29707@sigill.intra.peff.net>
 <7vr4reigm8.fsf@alter.siamese.dyndns.org>
 <20120810213508.GC888@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dave Borowitz <dborowitz@google.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 10 23:43:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Szwz0-0005dm-AD
	for gcvg-git-2@plane.gmane.org; Fri, 10 Aug 2012 23:43:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759915Ab2HJVmx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Aug 2012 17:42:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46365 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759880Ab2HJVmq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2012 17:42:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AB5578FB9;
	Fri, 10 Aug 2012 17:42:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sQGdA6U85WOsxI8SE/XxeQ8xlz4=; b=FJoApl
	CGv+HT8RSUB4fQwMgYxuZIjxUDDnL9E3R/Wx2MX5G8MN4cXZYRWWi6WQ6RuS/uA4
	Ap+r40g8q15eO83myrGAD4xPKG+/4S+F6gYWxBfXbX5LtJhxrgix8fsyVdgQh6l+
	jjkhTVndI3Y1XnZR/u/cnQi2wIfPXrT2gbYHg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sciwwqd0LhpRfxfyPUeCoEr5bQJlZ1/R
	MteRw8tGvlUMznIGBXOH3bq0d20zGTQCm15Y523lT8hSKcoMAHXk2tYKlL5hP2vT
	vTnXLDH5gbk5Zq5/kTC2QyjcruJCjLRrlwNhNFexq/UiF0Gn96SaF7tdlN5Svyxv
	s3RI03NFUJk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 920068FB8;
	Fri, 10 Aug 2012 17:42:45 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0E7D88FB5; Fri, 10 Aug 2012
 17:42:44 -0400 (EDT)
In-Reply-To: <20120810213508.GC888@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 10 Aug 2012 17:35:08 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 51F59000-E334-11E1-BABC-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203268>

Jeff King <peff@peff.net> writes:

> Yes, I think that is all that is necessary to fix the immediate issue.
> The protocol-capabilities document talks about what to do when
> include-tag is not available ("SHOULD issue a subsequent fetch to
> acquire the tags that include-tag would have otherwise given the
> client"), but I am not sure how well we handle that (in theory we should
> be handling it already, but I didn't look).

Yeah, it is more like "A separate fetch only to follow tags was the
only way we handled it before we added include-tag, so we know it
used to work, and also we know the four combinations of new/old *
fetch/upload all used to work".

We may have broken some combinations over time, though.
