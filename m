From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Alternates corruption issue
Date: Fri, 03 Feb 2012 13:51:33 -0800
Message-ID: <7vmx8zmvq2.fsf@alter.siamese.dyndns.org>
References: <20120131204417.GA30969@sigill.intra.peff.net>
 <20120131214047.GA13547@burratino>
 <20120131214740.GA2465@sigill.intra.peff.net>
 <20120131215501.GF13252@burratino>
 <20120131220510.GA3253@sigill.intra.peff.net>
 <20120131222258.GG13252@burratino>
 <20120202215913.GA26727@sigill.intra.peff.net>
 <7vzkd0u4ik.fsf@alter.siamese.dyndns.org>
 <20120203120215.GA31441@sigill.intra.peff.net>
 <7v8vkjstq2.fsf@alter.siamese.dyndns.org>
 <20120203212906.GB1890@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	GIT Mailing-list <git@vger.kernel.org>,
	"Hart\, Darren" <darren.hart@intel.com>,
	"Ashfield\, Bruce" <Bruce.Ashfield@windriver.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 03 22:51:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtR2i-00040V-Vj
	for gcvg-git-2@plane.gmane.org; Fri, 03 Feb 2012 22:51:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758013Ab2BCVvi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Feb 2012 16:51:38 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44522 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757984Ab2BCVvf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Feb 2012 16:51:35 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 441FF7E15;
	Fri,  3 Feb 2012 16:51:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Tx6DzBWUND4q0PNxEH6WdftIH8w=; b=RZ80dj
	No+ZMp1MraRvhgD5G9p2Z8tgLI0BAqsyN/l2/lLnsq2kSkMIOzM1Zqwmhz5CwkZg
	1Kf5GFjgPaJY+2ynrEFad+tmGDe6e948p7ySY47lTlQb1JeUoVMz7vvdnn9GXRs4
	IKFR0J4WMSnzJeHNyQjy5RgTHubRUVqYP4AGk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bBt4wV3dUTmhBLX3kJYZl8EAHFOOcvaO
	vk3h5nH6hx+5EQfHpERrlXqMg1BIvVbZ+yVZr1CHllBSzGeoNsYphtLGVGbLDj3Y
	XbuV9HUjcTZeH2K7dx40BYGplsfbSi3er7uxvmixdgw5jKJ6xo5PIHBqdN8zC2ht
	IWq7iMQNyAc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3A6CE7E14;
	Fri,  3 Feb 2012 16:51:35 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BF3297E13; Fri,  3 Feb 2012
 16:51:34 -0500 (EST)
In-Reply-To: <20120203212906.GB1890@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 3 Feb 2012 16:29:06 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3DA4ACB6-4EB1-11E1-AFCD-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189810>

Jeff King <peff@peff.net> writes:

>> No, thanks for working on this.
>
> What do you want to do with it, then? Take my patch and ignore the
> gitfile issue, or have me refactor it more heavily? I could go either
> way.

How about queuing it as is in next and see if anybody screams loudly
enough so that we can fix-up if necessary in-tree?
