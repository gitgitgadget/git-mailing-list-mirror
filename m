From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] config includes, take 2
Date: Sun, 05 Feb 2012 23:41:37 -0800
Message-ID: <7vobtc8l3i.fsf@alter.siamese.dyndns.org>
References: <20120206062713.GA9699@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 06 08:41:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuJCq-0002C4-Uu
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 08:41:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751681Ab2BFHll (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Feb 2012 02:41:41 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43086 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750928Ab2BFHlk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2012 02:41:40 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9DA5A4988;
	Mon,  6 Feb 2012 02:41:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cMP22NbiQHsIXwkd0pW6RIRz2Vk=; b=WUHy1+
	7RTHEu+gD13EK2OELR3hs9KwzeUrrk4/R3TAjOQoAVWTLjJaXjUchAsdaV2lwDvW
	4yuRCQICZYZVa//RulrpUnhkjQEf1zIuD+Jffl5UM80fKMnHBPOP2Hbxt6miVM3K
	hdBO3A//aTEwgwcN+gqSi3SggbJZop+J7ntys=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Zo7k1mUZway0w/XnZ5stih3ugsXCB/XF
	L+IlzXYpCPzOlRlL3+VCaLIlct/aE5bR7FoS0NoSu+5FKU4kNE3ag93RRizd8Eoj
	2FSXKGh+BJi4/tXAhwpaTz9sfUFdlYCia0dcMUig+9B5no6x667fsajVXXh4wGKD
	dzyW35XnhBs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 957C14987;
	Mon,  6 Feb 2012 02:41:39 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2AA2B4986; Mon,  6 Feb 2012
 02:41:39 -0500 (EST)
In-Reply-To: <20120206062713.GA9699@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 6 Feb 2012 01:27:13 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 011D6616-5096-11E1-9BDE-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190038>

Jeff King <peff@peff.net> writes:

> ... But the point of
> duplicate suppression was that individual config files wouldn't have to
> know or care what was being included elsewhere.

I think you wanted to say "the point of inclusion mechanism" is that
individual configuration files would not have to know, and I think I
agree.

> So I'm actually thinking I should drop the duplicate suppression and
> just do some sort of sanity check on include-depth to break cycles
> (i.e., just die because it's a crazy thing to do, and we are really just
> trying to tell the user their config is broken rather than go into an
> infinite loop). As a bonus, it makes the code much simpler, too.

Yeah, I stand corrected. It was a bad suggestion.

Thanks.
