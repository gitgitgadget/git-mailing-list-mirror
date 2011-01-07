From: Junio C Hamano <gitster@pobox.com>
Subject: Re: clone breaks replace
Date: Fri, 07 Jan 2011 14:58:34 -0800
Message-ID: <7vmxnc48yt.fsf@alter.siamese.dyndns.org>
References: <4D262D68.2050804@cfl.rr.com> <20110106213338.GA15325@burratino>
 <4D276CD2.60607@cfl.rr.com> <20110107205103.GC4629@burratino>
 <4D278930.7010100@cfl.rr.com> <20110107214907.GA9194@burratino>
 <20110107220942.GB10343@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Phillip Susi <psusi@cfl.rr.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Stephen Bash <bash@genarts.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 07 23:58:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbLGq-0002VQ-Cc
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 23:58:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754241Ab1AGW6v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jan 2011 17:58:51 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:62098 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753932Ab1AGW6v (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jan 2011 17:58:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4816D2F29;
	Fri,  7 Jan 2011 17:59:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vIpOyNHEvYKV/ItKjJufrlXAXhc=; b=XsNb+E
	nq0qkVfbsPgZrCyZeP7iD/RLTFZlk0mGdLdEURtsgV/rAs3flm1JLQQvSjat9GQ3
	FyFqDYEJDOdW63C5NTzuIekw3DmdofArltYKxD2LX7tdvAt0VKyGzjDZtsoQSUkt
	NHEiWUQqUbhiHqtgW3GUK+ETueaV1R63JeEy4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=p8jTplkT3VCjo2nh1vWnR6OEmgfBxxWM
	pK9B9jsB+tukuRFPUsD+se/Ki9xqXIL73YUJiMPA/JF+ANxVjyAA9GT1AZlfPTzs
	KSirup555oSwWyq1aUdUE8oxPwrpNoHhOz1xsPXwoy5BXin3tm/Pf9JyeCXGeIfe
	PJ5BdyZlMjc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D3AD32F27;
	Fri,  7 Jan 2011 17:59:22 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2E0392F26; Fri,  7 Jan 2011
 17:59:14 -0500 (EST)
In-Reply-To: <20110107220942.GB10343@sigill.intra.peff.net> (Jeff King's
 message of "Fri\, 7 Jan 2011 17\:09\:42 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C46F3D40-1AB1-11E0-A79D-CBB45B885003-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164782>

Jeff King <peff@peff.net> writes:

>   2. Should clone fetch refs from refs/replace (either by default, or
>      with an option)?
> ...
> Which leads to the second question. It is basically a matter of saying
> "do you want to fetch the view that upstream has"? I can definitely see
> that being useful, and meriting an option. However, it may or may not be
> worth turning on by default, as upstream's view may be confusing.

I think that should be stated a bit differently.  "Do you want to fetch
the view that the upstream offers as an option, and if you want, which
ones (meaning: there could be more than one replacement grafts to give
different views)?"

And as an optional view, I would say it is perfectly Ok to fetch whichever
view you want as a separate step after the initial clone.
