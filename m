From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 0/2] merge-base: add --merge-child option
Date: Sun, 12 May 2013 22:02:39 -0700
Message-ID: <7vppwvqxow.fsf@alter.siamese.dyndns.org>
References: <cover.1368274689.git.john@keeping.me.uk>
	<518FB8DE.7070004@bracey.fi> <20130512162823.GK2299@serenity.lan>
	<20130512165829.GM2299@serenity.lan> <518FD182.5020606@bracey.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Kevin Bracey <kevin@bracey.fi>
X-From: git-owner@vger.kernel.org Mon May 13 07:02:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbkuM-00089H-Nq
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 07:02:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752206Ab3EMFCn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 01:02:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49436 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751418Ab3EMFCm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 01:02:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E41B19C6D;
	Mon, 13 May 2013 05:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Nz0TU7hvYCSHR1C29ZpqXPzfeWs=; b=srQOjb
	azWueEm0dTiA4F4cz9AvKmFITkIGjzWbmlV+2qga8nGipofdDbr2Zpd+SVcL/Sp1
	/CejE8iIRSGGg3/3fam4tLEYEvKzft6uCLEp7w77su0n9GnfUNDle9NcGpjvSkdb
	hGZaexN3EXiH3spcMWkEiRUnZcmGaFIvzZanQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sEspzEsYBk4NI5WnzoyBUu4sZIGnsNBz
	jmUDN8OtIIibLaNM33DqcJS+Yce7lfc+kr0+eegaqrWLpQHnKus7XS6H4Ps6DBuO
	VtiOtEGVIH7bSDhpvLijbmRN100F0kxtUpaK6kb3Mr1N4z/RF9VE5z8In7fwM8r8
	WOF5mMQuYW0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F238019C6C;
	Mon, 13 May 2013 05:02:41 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 726AC19C6A;
	Mon, 13 May 2013 05:02:41 +0000 (UTC)
In-Reply-To: <518FD182.5020606@bracey.fi> (Kevin Bracey's message of "Sun, 12
	May 2013 20:29:38 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5716C944-BB8A-11E2-B908-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224088>

Kevin Bracey <kevin@bracey.fi> writes:

> On 12/05/2013 19:58, John Keeping wrote:
>>
>> With the patch below, the --ancestry-path version drops to under 2
>> seconds.
>>
>> I'm not sure if this is a good idea though.  It helps me say "I know
>> nothing that isn't on the ancestry path can be patch-identical, so don't
>> bother checking if it is" but it regresses users who want the full
>> cherry-pick check while only limiting the output.
>
> Hmm. Should an excluded commit be a valid comparator? Is it
> sensible/correct to show a left commit as "=" to a right commit that
> has been excluded by the revision specifiers? Doesn't sound right to
> me.

Neither to me.
