From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git push default behaviour?
Date: Thu, 08 Mar 2012 10:22:43 -0800
Message-ID: <7vlinbdkb0.fsf@alter.siamese.dyndns.org>
References: <CAFsnPqp1+jX3ZY0LZ1QDmvA=2_ebApPBttwFjr36OuTX2_MHug@mail.gmail.com>
 <87k42vs8pi.fsf@thomas.inf.ethz.ch>
 <CAFsnPqopZEZeeuFzK4ZoUjGnfpiv5oMs=xV5XBSgSyGLXOwgqA@mail.gmail.com>
 <1331202483.21444.11.camel@beez.lab.cmartin.tk>
 <CAFsnPqpnH2CTki8zz6Mpz=qrdxF_aTA92cPrn1L9MQZVMoxdeg@mail.gmail.com>
 <1331203321.21444.13.camel@beez.lab.cmartin.tk>
 <CAFsnPqpoBLHoshgv0MsUUStA3Q=niM8hP9yaHr+rSQvh-JWHZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org
To: Jeremy Morton <jeremy@configit.com>
X-From: git-owner@vger.kernel.org Thu Mar 08 19:22:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5hzI-0007HN-Eg
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 19:22:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756568Ab2CHSWr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 13:22:47 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46321 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755458Ab2CHSWq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2012 13:22:46 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 501967B11;
	Thu,  8 Mar 2012 13:22:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zGRxCY7YKHbcC9KQsSmXZB7tIlo=; b=Cfwh1H
	MZD6RaPl3UfycSOZRV3s0yrGCXwcNx/FZarxm+HiCasEgD7nlv/jbxvevCFajH6z
	JfS7FGDtX1GgGWxEsIbbe/4OddTY4TyN/diTOWVWqTpyyndb2zb+S1CxgTea8D6p
	QxRgYqkvonZ42BNNGMoMAS0AWjgu6OwUiHEPQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tqo36P3piRDwRfTJ/hwhzEDueXOrf1SO
	H+xVeKzF6E+LNcxrDiGGA+upK9VDsPylfjj9BcrC41IpjTGigIpqwWdlmkO5nojw
	PlyJ5yeQ8Z9zBdJ4ZtZgwbcpsIaz0iB0v8hSlJD3MlwSCrebAc4O0diRZ0YprP59
	nwwHhAsdgLw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4736A7B10;
	Thu,  8 Mar 2012 13:22:45 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CED1F7B0E; Thu,  8 Mar 2012
 13:22:44 -0500 (EST)
In-Reply-To: <CAFsnPqpoBLHoshgv0MsUUStA3Q=niM8hP9yaHr+rSQvh-JWHZA@mail.gmail.com> (Jeremy
 Morton's message of "Thu, 8 Mar 2012 10:43:12 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B33FC230-694B-11E1-A63C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192628>

Jeremy Morton <jeremy@configit.com> writes:

> Obviously - but my point is that it needn't be so dangerous by
> default.  It tries to push all matching branches - is that really a
> more common requirement than pushing the current branch?

Depends on the way you work. If you publish to your own repository
and let others pull, the behaviour is not dangerous at all with or
without --force (well, --force brings its own danger but that does
not have anything to do with which branches are pushed).  If you
default to 'current' in such a workflow, you risk forgetting to
push, which is the more dangerous option between the two.

When using a single shared central repository to work with others,
current may be more appropriate, and that is why the behaviour is
configurable.
