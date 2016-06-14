From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] Sharness v1.0.0
Date: Tue, 14 Jun 2016 14:50:29 -0700
Message-ID: <xmqqy467784a.fsf@gitster.mtv.corp.google.com>
References: <CAP8UFD0uvaB-2_CrXs2ZvoqLRHfCd8efA-S7-tE2Qa6Pn+rAAg@mail.gmail.com>
	<20160614213453.GA21560@sigill.intra.peff.net>
	<xmqq7fdr8n0o.fsf@gitster.mtv.corp.google.com>
	<20160614214655.GA22334@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Christian Couder <christian.couder@gmail.com>,
	git <git@vger.kernel.org>,
	Mathias Lafeldt <mathias.lafeldt@gmail.com>,
	Alexander Sulfrian <alexander.sulfrian@fu-berlin.de>,
	Dennis Kaarsemaker <dennis@kaarsemaker.net>,
	John Keeping <john@keeping.me.uk>,
	Konstantin Koroviev <kkoroviev@gmail.com>,
	"Mark A. Grondona" <mark.grondona@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Maxim Bublis <b@codemonkey.ru>,
	Richard Hansen <rhansen@rhansen.org>,
	Roman Neuhauser <rneuhauser@suse.cz>,
	Simon Chiang <simon.a.chiang@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 14 23:50:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCwEL-0007Wl-Sd
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jun 2016 23:50:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439AbcFNVud (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2016 17:50:33 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54488 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751119AbcFNVuc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2016 17:50:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6DC6725E7A;
	Tue, 14 Jun 2016 17:50:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Hb41ZU9sRkOynx7qo4rRJKFxhuc=; b=iyY9gz
	Li0RSnH4ksADXam+sAgL4Gmwep19vZ9Yym1Zy0hMZx49j41r+HVqUMmegDnT4iCm
	d/BkqS8191yPiOm3TDh60tTDpVTETAS6iyHse7TMhZ15x567fPKwp/7acWGZm/Ff
	5Q3SXIAEJ/Jxv4de4qXDxyScdjpxYMFFvBjVc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nXKus+7f+S1q4tglBPzouSyatIfycevR
	BMm3vA6kElgYp+1sZpLUKmSzL3+BXnMYnCJSNqnBk3zZqxYCNTwb+5i3LKJGc6An
	Cmyc5xe7jWrNNtpHb1ggttZ6D2GJr7S3/2KxKOGgAedAqkfakbZ1fUCg6lJ/lhbd
	cWsHzFcCUfA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6558825E79;
	Tue, 14 Jun 2016 17:50:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DFD8725E78;
	Tue, 14 Jun 2016 17:50:30 -0400 (EDT)
In-Reply-To: <20160614214655.GA22334@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 14 Jun 2016 17:46:55 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 03A562EC-327A-11E6-80D6-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297340>

Jeff King <peff@peff.net> writes:

> Yeah, I don't think it has kept up with our work. My statement above was
> "I don't think we'd _ever_ want to consider sharness the upstream, even
> if it were up to date", but obviously there would be a lot of work to
> even get it there.

I actually was a lot more optimistic when they started, and if it
were up to date, I would have at least tried to see what the damage
to our t/ part will be if we swapped t/test-lib{,-functions}.sh with
it, which was the original reason why I took a look until I found
out that it did not have some things.
