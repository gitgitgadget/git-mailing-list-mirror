From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/3] rev-parse and "--"
Date: Mon, 09 Dec 2013 13:10:09 -0800
Message-ID: <xmqqvbyxwx1q.fsf@gitster.dls.corp.google.com>
References: <20131206211222.GB20482@sigill.intra.peff.net>
	<20131206211509.GB20536@sigill.intra.peff.net>
	<20131206220520.GA30652@sigill.intra.peff.net>
	<xmqqmwk9zvyy.fsf@gitster.dls.corp.google.com>
	<20131209191224.GR29959@google.com>
	<xmqqob4pycmv.fsf@gitster.dls.corp.google.com>
	<20131209205621.GW29959@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 09 22:10:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vq85z-0000zq-LR
	for gcvg-git-2@plane.gmane.org; Mon, 09 Dec 2013 22:10:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759837Ab3LIVKY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Dec 2013 16:10:24 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50579 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756043Ab3LIVKX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Dec 2013 16:10:23 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 69B9E59547;
	Mon,  9 Dec 2013 16:10:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=femt/byNyEwoa9Nx4D1or1bKNMg=; b=SBNhbt
	Qj3SRFAnAFT69qBXpVL2MjvkT94e29kGp4MO95AlxuM0i6PuLwihevkFeU2DMuAU
	orfOWz1cpPY1h4Bu/Y2PwDyoXQCSjAKDk1pk3u5wnPwFMVU2yotuHavqMAsZ3wYx
	A+rmI88pC6OEmwYe0PZRCZ7Uf+rkPTYauGVKg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pkK1tyD3YxgxLxaCwE/j4PIqa+txlzfc
	VWscaJehSTViHkHnYjpb4iGq3WjfSShWiBAWAhO5dEw9Zp8tLaB0TJD9cfJDPUCJ
	6xlWNeoWQ9tRrOZkamJF9mjybTG/RrY7+GN+gL8YATlVJOJcL1vaSo01ot2hQERR
	2odCGhRtuYI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3D33559545;
	Mon,  9 Dec 2013 16:10:22 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DCF655953A;
	Mon,  9 Dec 2013 16:10:20 -0500 (EST)
In-Reply-To: <20131209205621.GW29959@google.com> (Jonathan Nieder's message of
	"Mon, 9 Dec 2013 12:56:21 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4FF7A6E2-6116-11E3-874A-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239101>

Jonathan Nieder <jrnieder@gmail.com> writes:

>> But if we cook it for a while, I suspect that we will find more and
>> more breakages of expectations in the existing scripts in and out of
>> the tree;
>
> Alas, probably no, because nobody has "HEAD~3..HEAD" in their working
> directory.  That's exactly the problem --- it creates an edge case
> that nobody is likely to test...

I didn't mean to say that running and encoutering the issue is the
only way to find "more breakges of expectations", by the way.  I am
still on the fence, but leaning towards not merging it too hastily.
