From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] make pack-objects a bit more resilient to repo
 corruption
Date: Fri, 22 Oct 2010 14:59:33 -0700
Message-ID: <7v4ocdlwhm.fsf@alter.siamese.dyndns.org>
References: <alpine.LFD.2.00.1010220037250.2764@xanadu.home>
 <20101022144600.GA5554@sigill.intra.peff.net>
 <alpine.LFD.2.00.1010221427390.2764@xanadu.home>
 <alpine.LFD.2.00.1010221606550.2764@xanadu.home>
 <AANLkTimy-ihrF1syWYe3T4W6-UHzCaj5Jud5rdFmv3D5@mail.gmail.com>
 <alpine.LFD.2.00.1010221714450.2764@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Fri Oct 22 23:59:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9PeS-0008Rz-CF
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 23:59:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753176Ab0JVV7r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 17:59:47 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:35530 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752834Ab0JVV7q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 17:59:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 71859E00CC;
	Fri, 22 Oct 2010 17:59:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0xePb3PVQgz0F27/mDKqOXhHa20=; b=KJflWP
	2XLp3yNT97Gk1DupRjmvd/CfA9RU0RkI4ZtI7KrDs+4vXP/gc3VQkw2bE30oCtUc
	w3F6hfKVxRFnCsETyPkbAImxk1vU1KYzhEEz/greXMi/raczr335eHliYxaSH/8i
	wxagle6kPJelApWNf8QU0b6oR49vBroDMrFio=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uz9ZDRnI5tL1NoQ5+NRb2g/3gysiJ0JI
	9HPaPLCq76HupoqEMivCdABcgyadZy98FzWtNfam6OD0sOLmLFQaWB8hKEQ24JxA
	7VwP4AiGPsGSbsTyujf2SnGZlA4fjmvBE4NCD1VaK3Wt+dOt1hMHrWM6rFu+6xXY
	kUYl+pbe2DQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D4A0E00C6;
	Fri, 22 Oct 2010 17:59:40 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 29CF6E00C2; Fri, 22 Oct
 2010 17:59:35 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.00.1010221714450.2764@xanadu.home> (Nicolas
 Pitre's message of "Fri\, 22 Oct 2010 17\:19\:29 -0400 \(EDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AB266442-DE27-11DF-BC8A-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159758>

Nicolas Pitre <nico@fluxnic.net> writes:

> Yes, only the first one, ...
> ...  Comprehensive reporting is the job of 
> fsck.

I had the same knee-jerk reaction, and about to suggest using one bit from
flags, but I agree the design balance you struck here is a good one.

Thanks.
