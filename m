From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFD] Expanded Pretty Format Placeholders Proposal
Date: Thu, 17 Mar 2011 14:35:35 -0700
Message-ID: <7vvczh1lco.fsf@alter.siamese.dyndns.org>
References: <1299804441.6220.1.camel@walleee>
 <1300395454.2004.9.camel@walleee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Will Palmer <wmpalmer@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 22:36:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0KrW-0008Fp-Su
	for gcvg-git-2@lo.gmane.org; Thu, 17 Mar 2011 22:36:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755819Ab1CQVfy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2011 17:35:54 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:58124 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755734Ab1CQVfo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2011 17:35:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DB097491C;
	Thu, 17 Mar 2011 17:37:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jM1cDi6xs23+Iy9FluntH1X3GJM=; b=gwygk6
	y5Vhu6Ex5szq2mZXYUXWC/TwBg5qeAmNd5kIGgjmfiUznE+vhjg+OpkGZvDZWdBs
	8zZ02Yh/KnryfcwntkKx9642wXw+uGZUgkveGJbRK+VtD48Kx0bZr9buLaqJVB41
	+Fj7GOudF0xLEhhqShqOUYcC+13uZqVyCjQvs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eQn+6sFk6+/LdC+szMPLaGCYNS6G5eBc
	p98Xz2rDUTvefim5Yb15Q5y4atbPO3HMj3h2yat7VU1g0+AJ2SoAb1c030e8ZIpF
	uzc1MoAhKFoZJGZJNKIwE+pII2NO6az+ukxSd0zlX9haBdiMnQq7jWeb0xFO2pVH
	kaFgljQQVu4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B94654918;
	Thu, 17 Mar 2011 17:37:14 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E10AE4916; Thu, 17 Mar 2011
 17:37:11 -0400 (EDT)
In-Reply-To: <1300395454.2004.9.camel@walleee> (Will Palmer's message of
 "Thu, 17 Mar 2011 20:57:34 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B9872D4E-50DE-11E0-9CC4-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169280>

Will Palmer <wmpalmer@gmail.com> writes:

> On Fri, 2011-03-11 at 00:47 +0000, Will Palmer wrote:
> ...
>> 	%(foo-condition: %(format: %H, aka %h), %H )
>
> of course, this conflicts with the need to embed a literal ")" within a
> sub-format. The simplest option for this would be to either allow %) as
> an escape, as with %%. Even simpler, of course, would be %x29, but this
> seems needlessly obscure. The only objection I have to %) is "It's
> ugly". To me, %(format: "this is a paren: )") is easier to read, but
> that would just be moving the problem around, adding the necessity of
> the just-as-ugly-or-moreso %", or alternatively C-style \" and \\.
> So I think that %) will be the best option.

I somehow had an impression that you will be using "" to quote strings to
protect leading or trailing whitespaces, and if you were to support double
quotes anyway, \" and \\ become a very natural thing to do (so does your
"close parenthesis inside dq").
