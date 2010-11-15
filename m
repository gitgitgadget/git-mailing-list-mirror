From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] use persistent memory for rejected paths
Date: Mon, 15 Nov 2010 15:05:07 -0800
Message-ID: <7v62vyjiho.fsf@alter.siamese.dyndns.org>
References: <7vbp5ymfyo.fsf@alter.siamese.dyndns.org>
 <20101114130205.GA27560@localhost> <vpq62vymmsz.fsf@bauges.imag.fr>
 <20101115194133.GA3297@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Tue Nov 16 00:05:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PI873-0003Kt-1D
	for gcvg-git-2@lo.gmane.org; Tue, 16 Nov 2010 00:05:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756787Ab0KOXFU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Nov 2010 18:05:20 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44267 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751556Ab0KOXFT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Nov 2010 18:05:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BB0B12A19;
	Mon, 15 Nov 2010 18:05:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5swRqUf1Yl4oxVFemfbA1EfAk9Y=; b=q50d/9
	hFTCwBPeL7fk4PQyteWKKFFWInDpY9vGT53P4CG5yqul01dMRq0W0rmK7TlTFqnR
	0yyPpLSFI4Lh8yaPxPp2KltLnXYlDs2vh2VDrUmhEhDx9N1JBTcRr6q8U2SmR6I3
	tB73KH4hAKwequ/Hwlp0mBCFeahlvV09HX+8A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nWwaiUG3SDSxeF5LP6/q4IsKOwctnDlb
	winm1JznadkYUPAOaFTzHIpO1zc7qBDlbKCGaeJ36QFVz4p1ckRPHmQpVdo9N63S
	2TZ6AtgodrjkXi958Dv32FW2xLo6EJtilIyeKXhL3NNrzYIU55gkLNBvEHElETXA
	YNxfrEzZjrI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7A15A2A12;
	Mon, 15 Nov 2010 18:05:22 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 266C32A0E; Mon, 15 Nov 2010
 18:05:16 -0500 (EST)
In-Reply-To: <20101115194133.GA3297@localhost> (Clemens Buchacher's message
 of "Mon\, 15 Nov 2010 20\:41\:33 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D2E614E4-F10C-11DF-8802-B53272ABC92C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161521>

Clemens Buchacher <drizzd@aon.at> writes:

> On Mon, Nov 15, 2010 at 08:03:40PM +0100, Matthieu Moy wrote:
>> Clemens Buchacher <drizzd@aon.at> writes:
>> 
>> > An aborted merge prints the list of rejected paths as part of the
>> > error message. Some of those paths do not have static buffers, so
>> > we have to keep a copy.
>> 
>> Like Junio, I'm surprised by this, but I guess you encountered the
>> problem.
>
> You don't have to take my word for it, just try the test. It should
> be failing nicely.  :-)

As far as I remember the tests were about the output order and never about
"ah we are showing stale contents from stack" (which is rather hard to
arrange for reliable testing anyway).

>> Did you remove all uses of "struct rejected_paths_list"? If so, you
>> can remove its declaration, if not, why?
>
> Indeed I can. Thanks.

I see you have v2 now; will replace.  Thanks.
