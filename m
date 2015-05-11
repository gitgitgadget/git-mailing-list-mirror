From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bisect: print abbrev sha1 for first bad commit
Date: Sun, 10 May 2015 21:33:02 -0700
Message-ID: <xmqqmw1bg2dd.fsf@gitster.dls.corp.google.com>
References: <1431128763-28453-1-git-send-email-tbsaunde@tbsaunde.org>
	<CAGZ79kYjES6DXmvQdmXLAXrKMGrnvQ-vqJuHQU2QxVC4+6M0aA@mail.gmail.com>
	<20150509014152.GA31119@tsaunders-iceball.corp.tor1.mozilla.com>
	<20150509040704.GA31428@peff.net>
	<20150510231110.GA25157@tsaunders-iceball.corp.tor1.mozilla.com>
	<20150511011009.GA21830@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Trevor Saunders <tbsaunde@tbsaunde.org>,
	Stefan Beller <sbeller@google.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 11 06:33:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YrfOw-00085e-HF
	for gcvg-git-2@plane.gmane.org; Mon, 11 May 2015 06:33:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752117AbbEKEdG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2015 00:33:06 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54274 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750960AbbEKEdE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2015 00:33:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DADFA5182E;
	Mon, 11 May 2015 00:33:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=90mI0kFnkc3R795I4Pp3eIEilXw=; b=dtBz5G
	RfYXC3IHxsBYnOwaufqz0r3HefB54538LSsqNZhARfDyQowfXQwh/sYZgX0rgooW
	a5brU5jB1wCJ00aavWN3w3/70sUJl0Co/UbAnf1NwpHsM66gvlnowN2JKrYmhkfO
	ikyi9hItsDRlVJKS5jmQmIBHrfEDfbqzsQAGI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WqIuql5YzLbuYkDCeOdA21Q4ekl8jdCM
	LQYvJdwxDsjutsujzoF5v9tstbqpz565HQ5eh6O5SSLcZmHPq3pcm8UnPT6lp+bi
	KHdpjwK1t5a0czpvM4San3FeAVri62SgQvZxPqC1XELS6VTbGKnFQS2NmltPPmuv
	eReyphKBWSc=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D26085182D;
	Mon, 11 May 2015 00:33:03 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 56F5B5182C;
	Mon, 11 May 2015 00:33:03 -0400 (EDT)
In-Reply-To: <20150511011009.GA21830@peff.net> (Jeff King's message of "Sun,
	10 May 2015 21:10:09 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CFEF8000-F796-11E4-933C-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268755>

Jeff King <peff@peff.net> writes:

> I'd argue for simply never showing the diff (dropping the "opt.diff = 1"
> line from bisect.c:show_diff_tree), but that is mostly my personal
> opinion.

Yeah, I think that is sensible. It may even be OK to just give a
"log --oneline".  
