From: Junio C Hamano <gitster@pobox.com>
Subject: Re: help: bisect single file from repos
Date: Tue, 08 Dec 2009 10:35:11 -0800
Message-ID: <7vein5e2lc.fsf@alter.siamese.dyndns.org>
References: <4B1CFC4C.6090406@bfs.de> <4B1D1A5A.9060004@drmicha.warpmail.net>
 <4B1D27B6.7010900@bfs.de> <200912080917.17220.chriscool@tuxfamily.org>
 <4B1E5796.2090201@bfs.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Michael J Gruber <git@drmicha.warpmail.net>, wharms@bfs.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 08 19:35:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NI4uL-0005dv-Qf
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 19:35:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754859AbZLHSfV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2009 13:35:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754775AbZLHSfT
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 13:35:19 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53583 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754334AbZLHSfS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2009 13:35:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DC3438689D;
	Tue,  8 Dec 2009 13:35:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=p9QpKH9WZezd6nQ8gxue6+WP8lU=; b=TPc2Uq
	DmdBfRfvYkHk2aXyEhcECa91zfdKe6v3XmzgZ18JZ9P82JZUB91vKg0kJYywPwgm
	BkrRhea8Nk+1idbWkCro2ukoka+rla4bd2A9Tc9/zgFtxCEwnMEkhHf8LN66igWe
	IW/pGkVAyKzl416vMUqeAXmCeMLcJDoiBHSzk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=imamcKLE30Ct60YlzsglbDy3/lwOmUuT
	F3Lc5yxOlwebadtFtuwhBYOvlR1hBiRmVjfwX5rDwRQf54GHsVrFPEOV71PR5H+X
	gytYyBvetU4xde1fds/Ai06H5cTjD8wTJe0y3k3UEkbb5Vwr1OUMSl7MtZHWsanz
	VY1qsLStzrA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7BA8E8689A;
	Tue,  8 Dec 2009 13:35:18 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9572C8688B; Tue,  8 Dec
 2009 13:35:13 -0500 (EST)
In-Reply-To: <4B1E5796.2090201@bfs.de> (walter harms's message of "Tue\, 08
 Dec 2009 14\:41\:42 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6F4BA580-E428-11DE-BEA2-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134902>

walter harms <wharms@bfs.de> writes:

> Christian Couder schrieb:
> ...
> i am sorry, i am not familiar with git and when i am stating i am looking
> for examples first. the examples in my man page are like
> git bisect start v2.6.20-rc6 v2.6.20-rc4
> there is nothing like:
> git bisect start 6a87a68a6a8 65a76a8a68a7
>
> I ASSUME that you can use tags like "v2.6.20-rc6" and commit-id like "6a87a68a6a8"
> interchangeable but that was not clear from beginning.

The misconception here is "naming commit is done completely differently
from naming branches and tags", which is false in the git land, but it may
hold true in some other systems (e.g. Subversion, which made them into
different dimensions by making branches and tags into a location in a
larger whole tree namespace when their commits are named by serial version
number of that whole tree namespace).

We can call this a misconception, tell users to learn how things work
before using git (sometimes unlearning CVS and Subversion helps for this
exact reason), dismiss the issue and move on.  But I wonder if there is
something we _could_ have done better in the documentation area to avoid
this from the beginning, iow, make it easier to "learn how things work
before using"?  I think there is a lesson to be learned by us in here, and
I'd like to hear comments and improvement suggestions, especially from
"usability" and "friendly to new people" advocates.
