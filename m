From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t4014: shell portability fix
Date: Tue, 31 May 2016 23:57:36 -0700
Message-ID: <xmqqoa7l1jmn.fsf@gitster.mtv.corp.google.com>
References: <xmqqbn3l3kmc.fsf@gitster.mtv.corp.google.com>
	<20160531225628.GA4585@sigill.intra.peff.net>
	<CAPig+cR989yU4+JNTFREaeXqY61nusUOhufeBGGVCi29tR1P5w@mail.gmail.com>
	<20160601023159.GA5411@sigill.intra.peff.net>
	<20160601033139.GB5411@sigill.intra.peff.net>
	<20160601034413.GC5411@sigill.intra.peff.net>
	<20160601053325.GA20797@sigill.intra.peff.net>
	<20160601054048.GB20797@sigill.intra.peff.net>
	<xmqqshwx1k0p.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 01 08:57:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8065-0003eD-4o
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 08:57:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757299AbcFAG5l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 02:57:41 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52086 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752209AbcFAG5k (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2016 02:57:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A0FD518393;
	Wed,  1 Jun 2016 02:57:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vVFUL1XySIPkZ3etqE2inXOs6Qw=; b=W6M3c5
	kpu66L9mRmkBGQZRcpROoSXWLgBYQHlDnoSwL5M8vibbYI0c4+clrHL5fpndqoe4
	WKJ1SlLx6vt1pDPY+JjCSeGXhybtS+E9m8gmVJ8oTnXHx7BGEt7uG8PLx0+oCSWy
	UOBHfoSF2lFQ5z8bU0rOOQupCPnpStPoi5Rac=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Rkp5vGswQMFztlGLKueNR/viiXSlk6YD
	rnIljOMokguP4gdYRoR+0M943BL5QkIksSIj3ZYnl6lr2UCLcfEaFhivCLGuVGot
	p91Dpx0N9aFXaz7PhGAOvzknfNfOkQqYF4RoRNW5txFIvAkntLGY7J7CLsojuBz6
	ih/qoPlrCRQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9966F18392;
	Wed,  1 Jun 2016 02:57:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3845B18391;
	Wed,  1 Jun 2016 02:57:38 -0400 (EDT)
In-Reply-To: <xmqqshwx1k0p.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Tue, 31 May 2016 23:49:10 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 206D0006-27C6-11E6-95A1-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296057>

Junio C Hamano <gitster@pobox.com> writes:

>> 				*)
>> 					"$@"
>> 					exit
>
> ... or 'exec "$@"'

Not really.  I am an idiot.

The whole point of this exercise is that we would want to have a
shell function as $1 at this point in the flow; 'exec' would not
be appropriate here.
