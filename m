From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 07/13] remote-hg: redirect buggy mercurial output
Date: Thu, 04 Apr 2013 09:29:05 -0700
Message-ID: <7vr4iqjm3y.fsf@alter.siamese.dyndns.org>
References: <1364929382-1399-1-git-send-email-felipe.contreras@gmail.com>
 <1364929382-1399-8-git-send-email-felipe.contreras@gmail.com>
 <7vehesd7rl.fsf@alter.siamese.dyndns.org>
 <CAMP44s1C37+drw3HhysO4aRgxUt=knAKnT+Bk0JCqLr=CL5yjQ@mail.gmail.com>
 <7v8v50brfn.fsf@alter.siamese.dyndns.org>
 <515d9741985ca_69fd13fde181671a@nysa.mail>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Max Horn <max@quendi.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 04 18:29:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNn2g-0001h6-Cb
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 18:29:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762981Ab3DDQ3J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 12:29:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61351 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762973Ab3DDQ3I (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 12:29:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 93728130F3;
	Thu,  4 Apr 2013 16:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=F52SaxcoGmyUEKO4RRSiKFSY+Nk=; b=PDr2Kw
	NTr13khnSg6yRid3tIuKi3u+iaX8/ZfwgSAhyw65WRRxRb4pEcFwRWKe7I0ZfQWk
	HAvB+rFz/+DqevxyCCaw/eKzZSsk00pADj8/X8kphM4cE/glj3yNdMCfg6g81yQz
	N0S1s/kQ4AA6xjcqUQJKqBgnpQXb+5hCBXfjk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=M0jLqXiUsw6cnj6Cbj0TJAzKDHdVNM01
	4gW+A6nVfEgnD3da6zQ8kyLT+DNc1lPM2SvHXe+dB/bP6Co7UM3jDi2Hueer+FRX
	51VrCNPD7ZihSGDYJMOjNke1qGYu/OfxHk9drfLFT/Oxxulijjt3XUH5NJF9peQD
	e8E77FzzjxE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8B22F130F2;
	Thu,  4 Apr 2013 16:29:07 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 12A7D130F1; Thu,  4 Apr
 2013 16:29:06 +0000 (UTC)
In-Reply-To: <515d9741985ca_69fd13fde181671a@nysa.mail> (Felipe Contreras's
 message of "Thu, 04 Apr 2013 09:07:45 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C57803C6-9D44-11E2-9618-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220030>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> I saw that you update the commit message without consulting here first to:
>
> ---
> remote-hg: redirect unnecessary mercurial output
>     
> Mercurial emits messages like "searching for changes", "no changes
> found", etc. meant for the use of its own UI layer, which is of no
> use for our remote helper.  Squelch them.
> ---
>
> This is not correct. This patch does _not_ squelch the output, it's redirecting
> it to standard error, so the user actually sees it now, and we do that not
> because the output is "unnecessary", but because it *breaks* the pipe between
> the transport helper and remote helper. I'll reroll with the updated commit message.

I actually "consulted" by asking you what you meant by "buggy".  I
just misread/misunderstood your response in prose.

An update in the patch form obviously would not risk such a
misunderstanding ;-)

Thanks.
