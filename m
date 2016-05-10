From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 1/3] tests: Adjust the configuration for Apache 2.2
Date: Tue, 10 May 2016 00:13:56 -0700
Message-ID: <xmqqbn4es7uz.fsf@gitster.mtv.corp.google.com>
References: <cover.1462342213.git.johannes.schindelin@gmx.de>
	<cover.1462774709.git.johannes.schindelin@gmx.de>
	<4a15c4e6c35cfb425da568d87e8b20b984e5325c.1462774709.git.johannes.schindelin@gmx.de>
	<20160509080315.GA14383@sigill.intra.peff.net>
	<alpine.DEB.2.20.1605091557050.4092@virtualbox>
	<20160509142711.GA9552@sigill.intra.peff.net>
	<alpine.DEB.2.20.1605091710310.4092@virtualbox>
	<xmqqwpn3w5c7.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1605100832350.4092@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Lars Schneider <larsxschneider@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue May 10 09:14:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b01rq-0001Ps-RR
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 09:14:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282AbcEJHOC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 03:14:02 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56780 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751274AbcEJHOA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 03:14:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0F1ABECEC;
	Tue, 10 May 2016 03:13:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NtoM1ncHkbQJ/SnCwtywSSJYHT8=; b=i+ISMY
	u0CbGhGhWnIF2nbgBegZUSeoQMwjtTG8u0P7/K0dkA3z/S4gbjC0T+MdxDL/G4Cj
	/IrLcX6Ftvssv3+tKK19oY22cYgWhm8YhiC5SOhOubzj2G1dOlH19/RtpM4xU9bd
	FSjaXySR5XxCqu42h3A/BZuMvBzf7Bgn/nbL0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I0Z8GaC7UGa0qWL1GHKmsAgRBENAuSEv
	/cKGyIhCt3aZ+NEQo8TYjYnuimbfI+Kcr7fiKQQZJ1zrrrZEfVd7PonmR+i/+Khz
	FcyB0NzlHhTx4FbOjpq4Wke0L2RDr01a4wbNncHyLNwmXASQ8X818NJYCGU4HVR5
	2kSbnQ9WHPY=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 06B15ECEB;
	Tue, 10 May 2016 03:13:59 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 757B2ECEA;
	Tue, 10 May 2016 03:13:58 -0400 (EDT)
In-Reply-To: <alpine.DEB.2.20.1605100832350.4092@virtualbox> (Johannes
	Schindelin's message of "Tue, 10 May 2016 08:53:07 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C39D39B6-167E-11E6-AA97-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294108>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> To be honest, I do not quite understand why you call it "ugly hack"
>> at all.
>
> Well, it is convoluted. I would have preferred to say "if this condition
> is not met or that condition is not met, fail". Instead I had to say "If`
> these two conditions are met, proceed as before. Otherwise, fail."
>
> And of course its ugliness increased in my mind because I had to go
> through so many iterations until it finally worked. Not really
> straight-forward a solution.

To my eyes without your battle scar, it felt more natural to say "If
somebody says he is user $U and gives a password $P, let him in;
keep everybody else out" when configuring a server than saying "Fail
anybody whose user name is not $U or who says his password is not
$P".  I can certainly understand if somebody who has spent a lot of
effort to make things _fail_ finds the latter more natural.
