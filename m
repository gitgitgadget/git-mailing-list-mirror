From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG?] bulk checkin does not respect filters
Date: Fri, 24 Feb 2012 12:03:24 -0800
Message-ID: <7v7gzcyp6b.fsf@alter.siamese.dyndns.org>
References: <20120224030244.GA15742@sigill.intra.peff.net>
 <7vvcmw2a3m.fsf@alter.siamese.dyndns.org>
 <20120224082803.GB18688@sigill.intra.peff.net>
 <20120224093924.GA11680@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 24 21:03:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S11Mf-0000VM-3j
	for gcvg-git-2@plane.gmane.org; Fri, 24 Feb 2012 21:03:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757872Ab2BXUD2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Feb 2012 15:03:28 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57834 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755890Ab2BXUD0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2012 15:03:26 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 58DE16137;
	Fri, 24 Feb 2012 15:03:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=/kjnYUqWv96chy2WYTUC8RI2nb0=; b=K0dqG8jYwV3VeLjaPFGY
	1ruHxLAamrn0PuN7IMexnxrVrRKhKivXFDS54odaiTEcx92Axy2sQK5IiLonBkrG
	ziXtg6t8DAo4Qlgb2s531ZBHczm+QwQZx2+rwYjh9phRlLWrYV47SuYXyS7Qu+ow
	RBJCfqyb28MLbmF5KfWAKd4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=w0Abr3TwL5JqiPTb+QYValo0xivQdUAicK3G7w7ZMlH0I7
	MnTuMqSVNMD/c8+NkTtL/KdSR8g1bWSx7oAdDv5r2DXubwunc/fD5JH67AjLhE7f
	xiRtUNTWqZnNlqBp8ChNvNEoN1LKL7FzNkmk3PU0IJEqGYwd3TlE84hsyXe4I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 505B16135;
	Fri, 24 Feb 2012 15:03:26 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F08AD6134; Fri, 24 Feb 2012
 15:03:25 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9CAD2162-5F22-11E1-938C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191457>

Jeff King <peff@peff.net> writes:

> On Fri, Feb 24, 2012 at 03:28:03AM -0500, Jeff King wrote:
>
>> I don't like repeating all of the convert_to_git policy logic. Perhaps
>> if you pass a NULL buffer to convert_to_git, it should run through its
>> usual logic, stopping just short of actually writing anything, and
>> return a flag indicating whether it _would_ convert...

Makes very good sense.  Thanks.
