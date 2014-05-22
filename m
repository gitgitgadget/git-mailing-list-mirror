From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/9] strbuf: add strbuf_tolower function
Date: Thu, 22 May 2014 14:04:20 -0700
Message-ID: <xmqqppj5msob.fsf@gitster.dls.corp.google.com>
References: <20140521102524.GA30301@sigill.intra.peff.net>
	<20140521102742.GB30464@sigill.intra.peff.net>
	<AD42BA87-3C73-4EB2-AF88-96C4F7E6FA0C@gmail.com>
	<20140522055852.GA16587@sigill.intra.peff.net>
	<xmqq38g1oe2y.fsf@gitster.dls.corp.google.com>
	<20140522184113.GC1167@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Kyle J. McKay" <mackyle@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 22 23:04:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnaAA-000278-4x
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 23:04:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752212AbaEVVE0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2014 17:04:26 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61662 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751011AbaEVVEZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2014 17:04:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 32C0D19E98;
	Thu, 22 May 2014 17:04:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GbkA0Z/sVloGJeLfDw0ma2YWCks=; b=vjyadd
	nYC5ODtwRL2CuiZPz4BeBPlGByJmmQZYvwNkyajUvkrfcifbNOr5YC1h1WKaFo60
	+Rq/x3hOqdRmuk55Ryx2q4zNIrsilKgw/hBlvxDPAxaTgHEhh9huaGgw7eLpfymn
	gAnVFCojjBt5zUvjnIkm72p2EGifr979oQGQs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PN8nm11VApII3Epj74gYC6OhS5WK2y+U
	lRsnPZBQjpaXy2o2qwED8qtWU8xcRhxUtZvphhbD+kZj3EZ3e92NsQHuHfPEEVtZ
	hMx13GUI6qjjqweHEb5a1B7+HQ1RPemLlmUkF2e2FXjBBDFClOBioOCQCnZ0M2NS
	IWsUVvedgcw=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2951019E97;
	Thu, 22 May 2014 17:04:25 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E04EA19E8D;
	Thu, 22 May 2014 17:04:21 -0400 (EDT)
In-Reply-To: <20140522184113.GC1167@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 22 May 2014 14:41:14 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A5AFFCF6-E1F4-11E3-8CB3-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249945>

Jeff King <peff@peff.net> writes:

>> > Yes, and that would be fine with me (I actually wrote strbuf_tolower for
>> > my own use, and _then_ realized that we already had such a thing that
>> > could be replaced).
>> ...
> ... I think
> the bigger question is: is this refactor worth doing, since there is
> only one caller?

If you wrote it for your own use and then realized that it is
applicable to this codepath, wouldn't that say that there are
multiple potential callers that would benefit from having it?
