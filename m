From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Restrict ref-like names immediately below $GIT_DIR
Date: Wed, 12 Oct 2011 15:26:43 -0700
Message-ID: <7vobxl7snw.fsf@alter.siamese.dyndns.org>
References: <1316121043-29367-1-git-send-email-mhagger@alum.mit.edu>
 <1316121043-29367-20-git-send-email-mhagger@alum.mit.edu>
 <20111011161652.GA15629@sigill.intra.peff.net>
 <7vr52jfm8i.fsf@alter.siamese.dyndns.org>
 <7vmxd7flkw.fsf@alter.siamese.dyndns.org>
 <7v39ezffq5.fsf_-_@alter.siamese.dyndns.org>
 <20111011230749.GA29785@sigill.intra.peff.net>
 <7vehyjcckp.fsf@alter.siamese.dyndns.org>
 <20111012021128.GA32149@sigill.intra.peff.net>
 <7v39eyddoc.fsf@alter.siamese.dyndns.org>
 <20111012045004.GA22413@sigill.intra.peff.net>
 <7vvcru9k22.fsf_-_@alter.siamese.dyndns.org> <4E95D60B.5030904@alum.mit.edu>
 <7vr52i9j8g.fsf@alter.siamese.dyndns.org> <4E9609E3.1000300@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, cmn@elego.de,
	A Large Angry SCM <gitzilla@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Oct 13 00:27:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RE7GN-0004py-Jg
	for gcvg-git-2@lo.gmane.org; Thu, 13 Oct 2011 00:26:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753854Ab1JLW0s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Oct 2011 18:26:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33363 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753823Ab1JLW0r (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2011 18:26:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 049DD652F;
	Wed, 12 Oct 2011 18:26:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5xPhFSV+pGx4E38xE+wApK7AW00=; b=CxGDZx
	ZJpuKHNyvSpxHe1xFfxNb31MZ4poFvPoZ7DoHCxl41aIZRMwI5kjs/OfvsARwrFO
	V7hkb75A1lVrITED4BolCazy9ByANZZ+UK0ilUpmTd6W6TKiLDo/9ooDMvzBBMaE
	mQYvZPnLm2+Gu0bE6t/t2egxuo1ICGEbqA9ws=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EaBNociQsNTLwObSOiAhhBAwrgDZwNqu
	xcSJDZG5HKjFHG9UOeeppFKJJ3oa9mnoglITWE+jisTNgSjZFgd1QGnR4pziApC+
	uP99KH21OxDiKAMEIX9Dg4jY01Jt5xINbOq9j2B3JoERi9xTqd+asD/+/CEzEIio
	k4561oS8/6c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EF04A652E;
	Wed, 12 Oct 2011 18:26:45 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 730E2652D; Wed, 12 Oct 2011
 18:26:45 -0400 (EDT)
In-Reply-To: <4E9609E3.1000300@alum.mit.edu> (Michael Haggerty's message of
 "Wed, 12 Oct 2011 23:42:59 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 449F523A-F521-11E0-AD15-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183424>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> /*
>  * Accept strings that are either ALL_CAPS or include a '/'.
>  */
>
> (I think the underscore is implied by the example, but the comment could
> be expanded if necessary to be explicit.)

I like that comment hints "_" by having it between all and caps ;-).
