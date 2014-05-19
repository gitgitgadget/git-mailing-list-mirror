From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote-helpers: point at their upstream repositories
Date: Mon, 19 May 2014 15:27:47 -0700
Message-ID: <xmqqzjidv1y4.fsf@gitster.dls.corp.google.com>
References: <xmqqa9aid52a.fsf@gitster.dls.corp.google.com>
	<20140516084126.GB21468@sigill.intra.peff.net>
	<xmqq8uq1br9c.fsf@gitster.dls.corp.google.com>
	<20140516225228.GA3988@sigill.intra.peff.net>
	<5376f2ca5c90d_65b915db2f877@nysa.notmuch>
	<20140517062413.GA13003@sigill.intra.peff.net>
	<xmqq1tvq4r43.fsf@gitster.dls.corp.google.com>
	<53795ef8e4023_10da88d30825@nysa.notmuch>
	<xmqqppja2t8a.fsf@gitster.dls.corp.google.com>
	<537a75e0a53b7_afee5d300f3@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 20 00:27:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmW2H-000069-5q
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 00:27:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbaESW1x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2014 18:27:53 -0400
Received: from smtp.pobox.com ([208.72.237.35]:65418 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750937AbaESW1w (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2014 18:27:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 140961964E;
	Mon, 19 May 2014 18:27:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eraeG7z0IUwHMwAtUhd/triQtJ8=; b=B78p4h
	3CjkL/wypQOtw3n9QQqyg3TJsurw8LczWYmeCT6vtEOr+Xw7xajYnSWJkwg/nvQa
	D48DseSgYNiIqicpxUEFxXI+VvfEFMjcQwqNsgYTL03qZwp48tClR0Jk9FmQwyTV
	1SvPnaeWeM7Nf2d1NxzlcBDLi5RLf8rbo2Eio=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kCoa0fIyp6bkuf+gwtRMTyH9Vf/aNOzX
	GRdrYTFWBBgli0XDP8Im2BrMubDgHwVdQQb9D68BDsIkpcpjK1L69qEXthXjbr85
	jdds25dEEIB3bN9UAiZEjyy0ZpDwndef36rx4z9qhJjaBL0PVut+8KCLFSR29WM0
	7I1lCQ1Dh7U=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0A51A1964D;
	Mon, 19 May 2014 18:27:52 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 20A4719648;
	Mon, 19 May 2014 18:27:49 -0400 (EDT)
In-Reply-To: <537a75e0a53b7_afee5d300f3@nysa.notmuch> (Felipe Contreras's
	message of "Mon, 19 May 2014 16:21:36 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: CEFB6822-DFA4-11E3-853B-B784E8FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249629>

Felipe Contreras <felipe.contreras@gmail.com> writes:

>> We could add these two to the warning, then, to discourage people
>> who see "please visit this URL" and say "Yuck, I have no time for
>> that" without actually visiting.
>
> We could. Personally I don't see the point of making the warning any
> more annoying. The instructiosn are just one click away, and if they
> have no time for that, they can just ignore the warning.

Yes, if they know a short-and-sweet instruction is at the top of the
page, "just one click away" is a good justification, but the reason
I suggested to add the instruction to the warning is because the URL
alone does not tell them that there is a short and easy-to-follow
instruction is behind it, not giving them enough clue to judge if
they have time for that or not.

> To me the endgame is that the code is removed, and only stubs remain.
> ...
> I meant I want 3. eventually, hopefully for v2.1.
> ...
> No, I don't want them crippled for v2.0. A warning should suffice.

OK, I think I understand what you want, and I am fine with that
timeline.

I can start preparing -rc4 now, but it may slip into tomorrow.

Thanks.
