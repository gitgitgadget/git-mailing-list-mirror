From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Detect endianness on more platforms that don't use BYTE_ORDER
Date: Fri, 02 May 2014 12:34:33 -0700
Message-ID: <xmqq7g64asae.fsf@gitster.dls.corp.google.com>
References: <20140502074917.GA25198@hashpling.org>
	<1399017329-25645-1-git-send-email-cbailey32@bloomberg.net>
	<xmqqwqe4azyd.fsf@gitster.dls.corp.google.com>
	<20140502165830.GA29339@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Charles Bailey <cbailey32@bloomberg.net>
X-From: git-owner@vger.kernel.org Fri May 02 21:34:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgJEI-0006gg-8j
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 21:34:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751975AbaEBTei (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2014 15:34:38 -0400
Received: from smtp.pobox.com ([208.72.237.35]:60295 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751824AbaEBTei (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2014 15:34:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9EBE6124D0;
	Fri,  2 May 2014 15:34:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gU/QifU55yiallC4GCvDCC1aMTI=; b=eAHfGV
	aA0Voy17A8nXzhRHtFJFXvnRIA/mowOeCZDsQ8WXmG47HfW2ZCSoct1owUGzZo+A
	a8jsx/e23BTYwAKdBd9uFSPZ8sYlzhULNMOaRtW/RDPfjxTqFWHcYjHsf290rruQ
	MU3D3QELug0XTnjDhovWNQ0OOI1m1J3bylMLY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YmHHVTYLE8VYM9co3TqtZgf2goQ9yRUs
	ZU6X6fTwm7wFKzK9x6EX0q7aQuwOGPhKKMD3Te4XB/nA0cH2ah+68yPwvH26fTH5
	DTHCHMX92P9R4n6mnWJP46E7Q2VPWy7I7GAjREb5KytF/CTsQklK6C5+n7WhNsQt
	uSknI5ncrBQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 91D32124CF;
	Fri,  2 May 2014 15:34:37 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0DB97124C4;
	Fri,  2 May 2014 15:34:34 -0400 (EDT)
In-Reply-To: <20140502165830.GA29339@hashpling.org> (Charles Bailey's message
	of "Fri, 2 May 2014 17:58:30 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: CA9B29CE-D230-11E3-9353-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247961>

Charles Bailey <cbailey32@bloomberg.net> writes:

> I claim that any
> platform which provides both but with differing senses is somewhat
> broken so I cannot see the precedence mattering much.

I agree with that, and that is the reason why we shouldn't change
the order all of a sudden.  If it shouldn't matter, then there is
only downside of a possiblity to break such an insane set-up that
has been happily working by accident, without helping anybody if we
change it, no?
