From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-reset.txt: Use commit~1 notation over commit^
Date: Wed, 01 Dec 2010 14:06:32 -0800
Message-ID: <7vfwuhtafr.fsf@alter.siamese.dyndns.org>
References: <1291227258-17922-1-git-send-email-jari.aalto@cante.net>
 <1291230820.11917.25.camel@drew-northup.unet.maine.edu>
 <877hftuvvz.fsf@picasso.cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Wed Dec 01 23:06:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNupA-0005Mh-Nv
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 23:06:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755815Ab0LAWGk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 17:06:40 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:60651 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755776Ab0LAWGk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 17:06:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 57569210F;
	Wed,  1 Dec 2010 17:06:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=20+lOrjwE1J3Rj2LTra/v/51ldE=; b=o2Trzrp292RuC2gE6gaOZLH
	WVcHmR+NXusxN7soRb8lxHIKoOd4qrPIdyJiWgFHf0ztRO7XUSFz1e9zLl6ECsj9
	Aug/gRQrfGZvjjUlTitVfMpqxRlEqNAhc8KNanvE70xo1qDLQ0dBQTKDmPL12Vc5
	zSFGfNd+CwND17JL0smk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=kzLbiv8PmsZmM2Nx4NDmkzoIFi6CiVEgeCaMvAYW8vh+iCoYV
	l5ojEMy/rTM+9ZbydeKCqGJIuPI6vIyNwUCKYVo0Dcf56wzEWQHzMoEFmoiwzk08
	7CPWB6NTvLnyYcPmI8ihuN9p7O9hXjEQ1LUnyBMO715pmPDOtlbPbLO4bw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 35461210E;
	Wed,  1 Dec 2010 17:06:56 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3824D2109; Wed,  1 Dec 2010
 17:06:52 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4F99CD96-FD97-11DF-9EFB-CDEAE6EC64FC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162623>

Jari Aalto <jari.aalto@cante.net> writes:

> What people appreciate, while learning, is constency. Sticking to one
> notation is better than giving multiple choices. And the "^" isn't
> exactly readable, don't you agree?
>
>     HEAD^^^^^^^^
>
> Right. How many was there again?

There is no question that you need to really count them, and that is why
we invented HEAD~8 notation in the first place.  It however is wrong to
use the above illustration to defend your change that replaces "HEAD^"
with "HEAD~1".  

The thing is, you need to name/call the previous one a lot more often than
you need to call the eighth previous one.  The previous one "HEAD~1" is
special because it directly relates to the current commit (it is the first
parent of the current commit) and that is why people often need to access
it.

And "HEAD^" is shorter and much easier to type, and more importantly, it
is more often used in the wild, so the readers of the documentation needs
to know it anyway to understand what other people do.
