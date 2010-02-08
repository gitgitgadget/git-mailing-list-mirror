From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-grep: option parsing conflicts with prefix-dash searches
Date: Sun, 07 Feb 2010 17:06:45 -0800
Message-ID: <7vljf41qoq.fsf@alter.siamese.dyndns.org>
References: <alpine.LSU.2.01.1002052351060.30204@obet.zrqbmnf.qr>
 <7vsk9fs1j9.fsf@alter.siamese.dyndns.org>
 <20100206035143.GA31784@sigill.intra.peff.net>
 <7v7hqrdkxb.fsf@alter.siamese.dyndns.org>
 <20100206115817.GA11605@sigill.intra.peff.net>
 <7v8wb64623.fsf@alter.siamese.dyndns.org>
 <20100207044415.GA6622@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Jan Engelhardt <jengelh@medozas.de>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 08 02:07:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NeI5q-0005Hl-Hi
	for gcvg-git-2@lo.gmane.org; Mon, 08 Feb 2010 02:07:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755048Ab0BHBG7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Feb 2010 20:06:59 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:65288 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754211Ab0BHBG6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Feb 2010 20:06:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0436C976C4;
	Sun,  7 Feb 2010 20:06:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pp15yYtdrwupj3M1y521C27YCwg=; b=maktNl
	XdG/F8lP18f8kX27uNMo0hK3icgT3mDdglIB3ZXi7Zq39jRV22vkWTfy3TzFJL/7
	oebDAHTRIdvdXioWfyowhurv08TusO3UK4oBIcInUgKbONUKG1Bc0AB4wKfHOVIX
	DSka6mhAyvhhtlji/BcERHY+28WGAzSiYli4k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZW0rbLxO2dsNF+yAPY0q4UYpYnUa6eql
	fnxnjHUxGd3zzvUNq3ZsfZlWXqFIGs2WnjNTunFxg4pg1Pp7mkZ4AtOVU5vjdPaP
	efuZCHVSW+UZUG59GwaGiBeFBpzT77wFvPjR1hHoPl3RWQwAtb7KWZNQ1yB2Fkzt
	24yiHwIcs2E=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C65A3976C2;
	Sun,  7 Feb 2010 20:06:51 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EE0BA976B9; Sun,  7 Feb
 2010 20:06:46 -0500 (EST)
In-Reply-To: <20100207044415.GA6622@coredump.intra.peff.net> (Jeff King's
 message of "Sat\, 6 Feb 2010 23\:44\:15 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3D983D22-144E-11DF-9869-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139269>

Jeff King <peff@peff.net> writes:

> Here it is with a commit message and some tests. While it is a minor
> change, we are pretty late in the release cycle, so perhaps it is best
> to leave it post-1.7.0 just to be on the safe side.

Your explanation that "-- marks the end of options" makes perfect sense
and it is not inconsistent with what we do either.  "grep" is an oddball
that among its non-option arguments the first one _can_ be a non-path
(namely, the single pattern you are looking for), but with your patch,
that logic is nicely expressed, too.

I am tempted to push it into 1.7.0 but I'd keep it in 'next' for now.

Thanks.
