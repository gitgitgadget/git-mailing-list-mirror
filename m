From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] tests: add initial bash completion tests
Date: Fri, 06 Apr 2012 16:22:30 -0700
Message-ID: <7vfwcgzbrd.fsf@alter.siamese.dyndns.org>
References: <1333740519-3792-1-git-send-email-felipe.contreras@gmail.com>
 <20120406201926.GA1677@sigill.intra.peff.net>
 <CAMP44s3-Ji33oG=Os_O9KpxawWzZzmiZ04QMTokQ+K6_x-31MA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 07 01:22:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGIUK-0004B8-9J
	for gcvg-git-2@plane.gmane.org; Sat, 07 Apr 2012 01:22:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754091Ab2DFXWe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Apr 2012 19:22:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36611 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752169Ab2DFXWd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2012 19:22:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 04AFA77CC;
	Fri,  6 Apr 2012 19:22:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lVpi7JGZ3MjTcfdZYfOEwKN619s=; b=uaRTdV
	J7YhBccksMBjEOcJin//V2gii5I2z/t212dWtl2+s2YsrLpzoWJnVFCcfgDONbX5
	hwJQfGz2/e3kmq0bKa1hA9/1pZ8/tHV9Z0AqK6hO9Mv5MnDs9PtWDgtEpLMYOPT3
	EHtWRtCwG7OGqtRw4RH5kKq8mKK+7rX8AG2dE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nyiiknOt6166NMCbxremHFv0cVYeoDdG
	JsbSuzHe7C0Z0YYVAd4d0SZBATFnn1c7W3AAk25BBWhqF2cWMVpRW9qpmiAmHT4l
	FwZxvxIBHcEgN8B8ivKhYgMlsMSsyWRPh9VW65Wk9+C0qSwGudPUFEbK+1npuxMB
	mUNECz7+PHA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EFE4977CB;
	Fri,  6 Apr 2012 19:22:32 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 835DC77CA; Fri,  6 Apr 2012
 19:22:32 -0400 (EDT)
In-Reply-To: <CAMP44s3-Ji33oG=Os_O9KpxawWzZzmiZ04QMTokQ+K6_x-31MA@mail.gmail.com> (Felipe
 Contreras's message of "Sat, 7 Apr 2012 02:12:22 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 62BA3420-803F-11E1-B91D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194922>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> What about this instead?
>
> #!/bin/sh
>
> if type bash >/dev/null 2>&1
> then
> 	# execute inside bash
> 	[ -z "$BASH" ] && exec bash $0
> else
> 	echo '1..0 #SKIP skipping bash completion tests; bash not available'
> 	exit 0
> fi

Please follow the CodingGuidelines and use

	test -z "$BASH" && ...

instead.

Other than that, it is very much simple and straight-forward.  I like it.
