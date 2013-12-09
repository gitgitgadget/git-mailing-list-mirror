From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/3] rev-parse and "--"
Date: Mon, 09 Dec 2013 11:05:09 -0800
Message-ID: <xmqqmwk9zvyy.fsf@gitster.dls.corp.google.com>
References: <20131206211222.GB20482@sigill.intra.peff.net>
	<20131206211509.GB20536@sigill.intra.peff.net>
	<20131206220520.GA30652@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 09 20:05:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vq68x-0002fT-Fl
	for gcvg-git-2@plane.gmane.org; Mon, 09 Dec 2013 20:05:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932677Ab3LITFS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Dec 2013 14:05:18 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44256 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932662Ab3LITFO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Dec 2013 14:05:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9DCAC58B1E;
	Mon,  9 Dec 2013 14:05:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=S8G5Nue9D8cvmrY5guHRj/uKzbQ=; b=TyDPZL
	PL7TLNpQAMYuTzd/mgjoRVCGMbKOfPe2JB/oGWn/NGEu+1THp5wakfbHrwiBGMwE
	dufw4psivRPOgMi9J+0ZEBBJjbRz6DXBukWw38zqc9EeLbTvndZtLBwsy7Pi7Qmw
	/N1FvOZ+WOxi1/2qg3TRFca9Cxo9+5kzYbQV0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kZYAWCQWjaLwTtJpXfKiLvC6jwnl0cHC
	a2bvCbbntQu/YUgbdv7N4Kb+vZnBdsOaLNLVucpKqomzJjpIBG8zjehFv2jMEM1u
	lc/fExyOEOLr2F2UIS5RuGfSRfLFWgKfCqxk11AeGdEfx1oZrQ+M9wZlVKSbRJu+
	gkUsurFi6d0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A1DA058B19;
	Mon,  9 Dec 2013 14:05:12 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 55FDD58B16;
	Mon,  9 Dec 2013 14:05:11 -0500 (EST)
In-Reply-To: <20131206220520.GA30652@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 6 Dec 2013 17:05:20 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D3DF4436-6104-11E3-B0EB-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239076>

Jeff King <peff@peff.net> writes:

> Is it better for "rev-parse" to be more careful, and to behave more like
> the rest of git? Or is better to be historically compatible?
>
> One thing to note is that "git rev-parse HEAD" is slightly broken there
> already. Because "git rev-parse $some_branch" may do very different
> things than what the caller expects if $some_branch does not exist (but
> there is a file with the same name). So maybe we are doing a favor by
> calling out the problem; if they want a rev, they should be using
> "--verify" (or "--").

I tend to agree with the reasoning in the last sentence. Let's cook
it for a while and see what happens.

Thanks.
