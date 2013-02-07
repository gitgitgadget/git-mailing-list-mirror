From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 4/5] Git.pm: add interface for git credential command
Date: Thu, 07 Feb 2013 15:38:17 -0800
Message-ID: <7v7gmj66fq.fsf@alter.siamese.dyndns.org>
References: <cover.1360242782.git.mina86@mina86.com>
 <cover.1360242782.git.mina86@mina86.com>
 <78516627e893e54d5aafe0694d1face9a37893de.1360242782.git.mina86@mina86.com>
 <vpq38x8m06f.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michal Nazarewicz <mpn@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Feb 08 00:38:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3b3E-0001xy-Nr
	for gcvg-git-2@plane.gmane.org; Fri, 08 Feb 2013 00:38:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945922Ab3BGXiW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2013 18:38:22 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50043 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1945893Ab3BGXiV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2013 18:38:21 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 77E53C9DC;
	Thu,  7 Feb 2013 18:38:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Os2siKrHqPz063Mr3SzSzhHXKE0=; b=ie+DVB
	xqfi9fg2RDrDz58vJlrdU9AZiai+NNbODx6z0RrG3K5Bo3+aman9yzMC6fcT6PNj
	oz+fyMxGgUOu0Do0ZWHMwurSZmQ8nKrgYLRUdLMmMpWmMSI97hmu2ZrmkAt/Lmtk
	K42NdesW21TduitjyE8z4kkp63ZocybNN8+t8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uTlGJMtbvjyRBUdHbBlbTq9Y43BbjOM+
	OeJIr+vo/dfp/bXNfcz6ktdPCoBs+PxuJu7nbjVOFcM3JW93a1tRxBwAEUmPOjzw
	SZjdMGDO7kmRKLMh1x9LpeI5M3jS+X0uAX7AxVu3k9f9MRnb35cg0FEC+e6z3gou
	e316cIyhe1Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 60317C9DB;
	Thu,  7 Feb 2013 18:38:20 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 99600C9D3; Thu,  7 Feb 2013
 18:38:19 -0500 (EST)
In-Reply-To: <vpq38x8m06f.fsf@grenoble-inp.fr> (Matthieu Moy's message of
 "Thu, 07 Feb 2013 19:46:48 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 74192ED8-717F-11E2-BF3E-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215735>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Michal Nazarewicz <mpn@google.com> writes:
>
>> From: Michal Nazarewicz <mina86@mina86.com>
>>
>> Add a credential() function which is an interface to the git
>> credential command.  The code is heavily based on credential_*
>> functions in <contrib/mw-to-git/git-remote-mediawiki>.
>
> I'm no perl expert, so I cannot comment much on style (there are many
> small changes compared to the mediawiki code that look like improvement
> though), but:
>
> Reviewed-by: Matthieu Moy <Matthieu.Moy@imag.fr>

Thanks.  I'd actually be more worried about the error checking issue
Peff raised during his review.  I have a feeling that "when in doubt,
do not cause harm" is a more prudent way to go than "I do not know,
so I'll let anything pass".
