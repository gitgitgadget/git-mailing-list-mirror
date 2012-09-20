From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] remote-curl: let users turn off smart http
Date: Thu, 20 Sep 2012 10:53:15 -0700
Message-ID: <7va9wkbmyc.fsf@alter.siamese.dyndns.org>
References: <20120920165938.GB18655@sigill.intra.peff.net>
 <20120920170517.GB18981@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 20 19:53:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEkwJ-0007Iw-76
	for gcvg-git-2@plane.gmane.org; Thu, 20 Sep 2012 19:53:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753231Ab2ITRxT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2012 13:53:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39331 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753213Ab2ITRxS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2012 13:53:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B02458AC6;
	Thu, 20 Sep 2012 13:53:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BrGds7f5+4mJGUXhMY/QVVOfO4U=; b=GvrRCZ
	U2nkuFkyejSYjq0zypYOQeU9EKC+LnIwQbEM6RdzZrjTGOZ1bJ49ULP9+QNiVd8t
	y0s5Mfz4no5NLNVj7b6NnMQXiZ+Qu7BJNLEnkHLVFaG4sUfJXWEfLWguFNOKcpOt
	Qw3FrPMjXK/Hp4MPK4uJ3REGuhE+AQLnFcQNI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AwFepJvS8uV531gqBThBdCtL0dUYqhnk
	WJ2GBHIELqteOjDWwc5aa39VTal15P8lH0223MZJ1di2tl1S3CwJk5u1X+pmeyVG
	Z5xxFBfx+5oxvNhb0k/PFSg0czpVibTKiuZ5lbPl3HKiX24tOMAEPpvt/77lZeYR
	MMhVXl2GyV0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E16C8AC1;
	Thu, 20 Sep 2012 13:53:17 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1B2508ABF; Thu, 20 Sep 2012
 13:53:17 -0400 (EDT)
In-Reply-To: <20120920170517.GB18981@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 20 Sep 2012 13:05:17 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0E8F08CC-034C-11E2-9C7E-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206063>

Jeff King <peff@peff.net> writes:

> I added the config item as remote.foo.smarthttp. You could also allow
> "http.$url.smart" (and just "http.smart", for that matter), which could
> be more flexible if you have multiple remotes pointing to the same
> broken server.

What would the user experience be when we introduce "even smarter"
http server protocol extension?  Will we add remote.foo.starterhttp?

Perhaps

    remote.$name.httpvariants = [smart] [dumb]

to allow users to say "smart only", "dumb only", or "smart and/or
dumb" might be more code but less burden on the users.

The code obviously looks correct, and the documentation reads fine.
