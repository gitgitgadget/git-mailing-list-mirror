From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 2/2] test: allow prerequisite to be evaluated lazily
Date: Fri, 27 Jul 2012 10:15:02 -0700
Message-ID: <7vfw8d15yh.fsf@alter.siamese.dyndns.org>
References: <7vboj25dk7.fsf@alter.siamese.dyndns.org>
 <7v7gtq5da3.fsf@alter.siamese.dyndns.org>
 <20120727154500.GA11957@sigill.intra.peff.net>
 <20120727155000.GB11957@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jul 27 19:15:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Suo8F-00020a-85
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jul 2012 19:15:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751557Ab2G0RPK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jul 2012 13:15:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48649 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751208Ab2G0RPJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2012 13:15:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 37B978B09;
	Fri, 27 Jul 2012 13:15:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6blxahJauarA3ir8CRl5CFvdlB0=; b=nV3weB
	ITLfQ36ekTz2Cuc/D3Ve2jhchzbO+lFBs4wSnvM18NE0AIOGo25bDKm/Kv1Ymqz6
	afF6HciCFr1mYtX5Dibn+JlWcdVgKmjzoDrrRpQob743TGawnyPOv+pj/DHovBsH
	Dys5i0d6O4lPo8a+kM/oGFPT5qtyTG72XG6qs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ljohpf9J1/D3d15H3FZCWJUHOWvww2Cv
	PWVyZP3tQ7jRKXoN9POAYyPE00orHdyfEyB8eyRmcRpI9bifJVbCu2honB5WBQxa
	jffLdOq59AgDTK3TIojfLnTKasoKwlGeTN/KG8i6nWIUXa2IX0ZK3xCsxFLOeYvq
	lqwbbi5w8jo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 231A68B08;
	Fri, 27 Jul 2012 13:15:08 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A2B4C8B06; Fri, 27 Jul 2012
 13:15:06 -0400 (EDT)
In-Reply-To: <20120727155000.GB11957@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 27 Jul 2012 11:50:00 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9CA09CB6-D80E-11E1-B85C-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202360>

Jeff King <peff@peff.net> writes:

> On Fri, Jul 27, 2012 at 11:45:00AM -0400, Jeff King wrote:
>
>> And of course with non-broken probes, "-v" would also help to see exactly
>> when the probe is run, using which commands, and what output they
>> produced. E.g., for SYMLINKS, we should probably drop the stderr
>> redirection from the probe so we can see how "ln" complains.
>> 
>> It might also be worth doing a "say >&3" at the end of the check, too,
>> to tell "-v" users the outcome.
>
> Here is an updated version of my suggestion that does both of those
> things.  I think it should just be squashed into your patch.

Thanks. The changes look good.
