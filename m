From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] deprecating and eventually removing "git relink"?
Date: Mon, 14 Nov 2011 14:08:47 -0800
Message-ID: <7vmxbyicgg.fsf@alter.siamese.dyndns.org>
References: <7v4ny7mtbx.fsf@alter.siamese.dyndns.org>
 <buomxbzutjm.fsf@dhlpc061.dev.necel.com>
 <CAD=rjTXgH+AivmK+zLurQVC+=p1UYqFy_p=wBF-1-TOQ=Cqjtw@mail.gmail.com>
 <20111114103451.GA10847@sigill.intra.peff.net>
 <7vfwhqjw4u.fsf@alter.siamese.dyndns.org>
 <20111114202522.GA26269@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Simon Brenner <olsner@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 14 23:08:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQ4i0-0007qH-3P
	for gcvg-git-2@lo.gmane.org; Mon, 14 Nov 2011 23:08:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756334Ab1KNWIv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Nov 2011 17:08:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61117 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754268Ab1KNWIu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2011 17:08:50 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 833A96060;
	Mon, 14 Nov 2011 17:08:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fvLHlAboAlmIaOV7rBE+/tRMCAA=; b=VW/qqY
	8FJ9VlHJZOoPxl/3/OXVX3+NfJnXxTthXHGaf4F1DNgQlxuHo7IF+kkWX/qU12CM
	h2DJtKvjc8L4POLMoJqJFIIaZ17x4WIogVdXFh0EYJDXpP1KZSsxv5FJZEjdqZ4S
	d3LY6wlrZikzjODgFw8Yo1to1fLduP0vfrMbA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IxrB7XK1F3gtnKELLgcjlG0g7DpV5fWV
	WF8uMfD1ET+EK/xVjzBGw54d6f9/UlM9vtpB8grM0Mn6ne53vp3eJxSQzR6NpVje
	Mnip9RaaIy7PPTIyLUmU/I0hkkIBZz95bINvFSWvo1jiSYJ2gsvlvi5HPDo7yyuE
	DobN//qwxN4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7A714605F;
	Mon, 14 Nov 2011 17:08:49 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DAA07605D; Mon, 14 Nov 2011
 17:08:48 -0500 (EST)
In-Reply-To: <20111114202522.GA26269@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 14 Nov 2011 15:25:22 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3A8BE1C2-0F0D-11E1-96DA-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185408>

Jeff King <peff@peff.net> writes:

> On Mon, Nov 14, 2011 at 12:18:25PM -0800, Junio C Hamano wrote:
>
>> > Yes, I think that is sensible. I'm not sure there is even any core git
>> > code to be written. I think a wrapper that does the following would
>> > probably work:
>> 
>> I agree with your outline, which I find is in line with what I had in mind
>> in the message Miles responded.
>> 
>> The approach is different from what Miles alluded to, which is to have
>> "clients" create objects in the "central" place in the first place,
>> though.
>
> It seems to me that is simply an optimization that can come later.

I did not mean "it is wrong because it does not match what Miles said" by
that. In fact, I think it is a better approach to put things in clients
first and consolidating possible duplicates at the central one purely as
optimization, and I do not necessarily see "write to central from the
beginning" as a particularly good "optimization".
