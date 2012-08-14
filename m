From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] fetch-pack: mention server version with verbose
 output
Date: Mon, 13 Aug 2012 21:56:57 -0700
Message-ID: <7v8vdiax5y.fsf@alter.siamese.dyndns.org>
References: <20120810075816.GC8399@sigill.intra.peff.net>
 <7v7gt6jz3s.fsf@alter.siamese.dyndns.org>
 <20120810211509.GB888@sigill.intra.peff.net>
 <7v393uif9g.fsf@alter.siamese.dyndns.org>
 <7vboieehrf.fsf@alter.siamese.dyndns.org>
 <7v7gt2ehl4.fsf_-_@alter.siamese.dyndns.org>
 <20120813205423.GA31630@sigill.intra.peff.net>
 <7v628mcxdf.fsf@alter.siamese.dyndns.org>
 <20120813211109.GA32688@sigill.intra.peff.net>
 <20120814015927.GA7891@sigill.intra.peff.net>
 <20120814020210.GB7891@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 14 06:57:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T19Bk-0003vx-Id
	for gcvg-git-2@plane.gmane.org; Tue, 14 Aug 2012 06:57:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752060Ab2HNE5D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Aug 2012 00:57:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33519 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751684Ab2HNE5A (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2012 00:57:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0CB688C06;
	Tue, 14 Aug 2012 00:57:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MrcE33DzKXPpVm/LIyjd4HZOswE=; b=KzxAZV
	bNvJVtwHnHoSlZ6DX2JIigl3c2ASw7WSCg3q2gI0cJyOJk6QZNXwvemdev8rjHCs
	Xt8Y0Mekct65kORbvL+sO9bTOS2S9Lb0iHL9dAZLwmqrr4yjJVb2uPxyNA6MR0ru
	b5kq+yXf0/wCFZNrE1+x6b/2YRpf60/dNrUqo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sp5CSiHv7mBnqDy9XVCTDaJj0q2zuG3j
	a2X/V2BnYAYmVxM2Tx/1VXn0jwR8bPDQ6dDAIPr3wxoiymbHQjnwOOnjyeDHzdE6
	U3MtHGY7V3DXSy+GujNC1L6Ty7hbzhZbFjLUBjuEqtJaBepWa+e82XcKkqMmOlzh
	ht8Pmd/sIUI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EE0C88C05;
	Tue, 14 Aug 2012 00:56:59 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5D9B38C04; Tue, 14 Aug 2012
 00:56:59 -0400 (EDT)
In-Reply-To: <20120814020210.GB7891@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 13 Aug 2012 22:02:10 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7AC91750-E5CC-11E1-8C22-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203384>

Jeff King <peff@peff.net> writes:

> +	if ((agent_feature = server_feature_value("agent", &agent_len))) {
>  		agent_supported = 1;
> +		if (args.verbose && agent_len) {
> +			fprintf(stderr, "Server version is %.*s\n",
> +				agent_len, agent_feature);
> +		}
> +	}

OK.  The one I queued in 'pu' said "Server version not disclosed"
when length was 0, but I think I like this one better.

Also I like the the update to the parsing code in the previous
patch.  It makes the logic clearer.

Thanks.
