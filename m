From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 3/8] upload/receive-pack: allow hiding ref hierarchies
Date: Wed, 06 Feb 2013 07:57:13 -0800
Message-ID: <7vzjzhmo4m.fsf@alter.siamese.dyndns.org>
References: <1359571542-19852-1-git-send-email-gitster@pobox.com>
 <1359571542-19852-4-git-send-email-gitster@pobox.com>
 <20130205085047.GA24973@sigill.intra.peff.net>
 <7vwqumvk76.fsf@alter.siamese.dyndns.org>
 <20130206113112.GB5267@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 06 16:58:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U37Nt-0004KC-2i
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 16:58:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757559Ab3BFP5S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 10:57:18 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46094 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757232Ab3BFP5P (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2013 10:57:15 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 82B8CB70A;
	Wed,  6 Feb 2013 10:57:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mS45FNvQVD6I0OhAjkvdBDiN5lc=; b=Np6wl3
	AuTLrz7XR+76NVal3sicmqaUjohaloyKqKqtNoYCO0XMh2v81x7KwFcdlGNK6aXe
	gNHGE0ejK44ph313D3mqsD1DjPMFaVc7onJ9yfKAvt4l3g6zJEeRYxcuS4dNT0Sd
	0yA0N1hYanrsnNRgbEaj5gEbc4XCRT5UTcnck=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pL+coKRH8ZXIbV9MSKRdHpFWjRimgzZA
	Qnixnl6qODuQhLwpPlEKovq06VQ9JYyn1jrr/FFXOYyxWHtuiYaTnjgVz/pJMiOm
	vnHTlh4cuE+l+P/sLqqKTvxjMb6V4+/aQC1izvtm+i3agWy3UunL8Aa5oZMnUi2f
	E6+FX30bbbM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 775AFB709;
	Wed,  6 Feb 2013 10:57:15 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0DA2BB706; Wed,  6 Feb 2013
 10:57:14 -0500 (EST)
In-Reply-To: <20130206113112.GB5267@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 6 Feb 2013 06:31:12 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E044CCA8-7075-11E2-A8D2-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215592>

Jeff King <peff@peff.net> writes:

> On Tue, Feb 05, 2013 at 07:45:01AM -0800, Junio C Hamano wrote:
>
>> > In the earlier review, I mentioned making this per-service, but I see
>> > that is not the case here. Do you have an argument against doing so?
>> 
>> Perhaps then I misunderstood your intention.  By reminding me of the
>> receive-pack side, I thought you were hinting to unify these two
>> into one, which I did.  There is no argument against it.
>
> What I meant was that there should be transfer.hiderefs, and an
> individual {receive,uploadpack}.hiderefs, similar to the way we have
> transfer.unpacklimit.

Yes, as I said, I misunderstood your intention.
