From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Documentation/Makefile: clean up MAN*_TXT lists
Date: Fri, 01 Feb 2013 11:38:46 -0800
Message-ID: <7vehgzakop.fsf@alter.siamese.dyndns.org>
References: <20130201082538.GA25674@sigill.intra.peff.net>
 <20130201082650.GA25783@sigill.intra.peff.net>
 <20130201192010.GA12368@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, John Keeping <john@keeping.me.uk>,
	git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Max Horn <max@quendi.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 01 20:39:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U1MS7-00089V-OP
	for gcvg-git-2@plane.gmane.org; Fri, 01 Feb 2013 20:39:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755273Ab3BATiu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2013 14:38:50 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50598 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753600Ab3BATit (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2013 14:38:49 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BA774C512;
	Fri,  1 Feb 2013 14:38:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mvdkdhpU/6wiSx9VrWmVqSGIAJc=; b=lXsj/c
	xZGV6dFB3PDUTwXN18MLt85GxtbP6Rlyymz0riJCIw8nRTc4NRbm8gzROWJ3qS2W
	FzvTPXEMwJwTBvaL3OTDziA+Iz1lHy4WfdW1aevlosoBSyCLXLoJsmHPdPn+iTjw
	Kn/SMznriA/w+AGQlhQFurP9p5BF3K+MAcF70=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=x5jOPaKUrfCOnnx6N0mvFp908QM7gf8G
	BwKqTx2S8HUTf3p5wJ8HSjlbbvl2mUK6/IxixGclG+qh4H2QVOArVvTMqx296PA3
	KwPsO1Vba8givE6KdP52d2hG3849X9FVYKcSwQXwk53gSG2jCyKAv+Iq506DXVtt
	P6/IVc62718=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AEE86C511;
	Fri,  1 Feb 2013 14:38:48 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1286DC510; Fri,  1 Feb 2013
 14:38:48 -0500 (EST)
In-Reply-To: <20130201192010.GA12368@google.com> (Jonathan Nieder's message
 of "Fri, 1 Feb 2013 11:20:10 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FF7C31A6-6CA6-11E2-A174-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215258>

Jonathan Nieder <jrnieder@gmail.com> writes:

>> --- a/Documentation/Makefile
>> +++ b/Documentation/Makefile
>> @@ -1,13 +1,28 @@ MAN7_TXT += gitcredentials.txt
>> -MAN1_TXT= \
>> -	$(filter-out $(addsuffix .txt, $(ARTICLES) $(SP_ARTICLES)), \
>> -		$(wildcard git-*.txt)) \
>> -	gitk.txt gitweb.txt git.txt
>> +MAN1_TXT += git.txt
>> +MAN1_TXT += gitk.txt
>> +MAN1_TXT += gitweb.txt
>> +
>
> If the user happens to have MAN[157]_TXT set in the environment, this
> would be affected by that.  How about:
>
> 	# Guard against environment variables
> 	MAN1_TXT =
> 	MAN5_TXT =
> 	MAN7_TXT =
> 	
> 	MAN1_TXT += ...
> 	...
>
> With that change,
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Sounds sensible.  Let's go in that direction.

Thanks.
