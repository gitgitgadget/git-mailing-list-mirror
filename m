From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] remote: add new sync command
Date: Mon, 07 Nov 2011 13:25:23 -0800
Message-ID: <7vhb2f1v7g.fsf@alter.siamese.dyndns.org>
References: <1320682032-12698-1-git-send-email-felipe.contreras@gmail.com>
 <20111107172218.GB3621@sigill.intra.peff.net>
 <CAMP44s358k4EsCg+K6MeLEU4eLbb4mWyX9AdAf4P9CHvf9Lrwg@mail.gmail.com>
 <20111107183938.GA5155@sigill.intra.peff.net>
 <CAMP44s0M-qnZeHCUadSJJCYO=t881sUOi11G3fCG2vaAakPyBQ@mail.gmail.com>
 <20111107210134.GA7380@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 07 22:25:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNWh9-0005HC-5Q
	for gcvg-git-2@lo.gmane.org; Mon, 07 Nov 2011 22:25:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751651Ab1KGVZ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Nov 2011 16:25:26 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45740 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751319Ab1KGVZZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Nov 2011 16:25:25 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 40C805F22;
	Mon,  7 Nov 2011 16:25:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WY+hkUOpJ3FnSnMUn4V5e1X9mBA=; b=hLja/c
	j9xCLmLuH2CQ3o04tNefpn/DthtOhShDaGD6h/9g6KZVBKBqCpUZyY6DLblOg0VF
	9AYWHcffhk02cTDGaiQ/6aWPnryRgGU6TuW4fcWIFubMOT1xseilJ9KlxsW6REWA
	rM9/vtZJzm458+E14vJeCPGfw1tRSv/En0ER0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ljacB6P1I+2EU4mAIj1OAMXX6cEIHcZ2
	as3RS4Sq14EvX/bc1xzLvCFt2xm2c8L3tk4YAihTMPYC3qDMhWMI7gThvlCYtHwF
	6Qjih92s450wn7x5hg+mKZIaCT1sBaf5r6q4LNjY8PfjHkSCBeP1O7JNMNK/LHHf
	+bz/QQoutjs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3727A5F21;
	Mon,  7 Nov 2011 16:25:25 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A87115F1F; Mon,  7 Nov 2011
 16:25:24 -0500 (EST)
In-Reply-To: <20111107210134.GA7380@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 7 Nov 2011 16:01:34 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 016D7B98-0987-11E1-AD29-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185028>

Jeff King <peff@peff.net> writes:

> That makes sense. But I think it fits in with git's current UI to do
> this via a combination of push options and refspecs. Even if we want to
> wrap it in some "git remote" command for convenience, I think what
> you're asking should be implemented as part of "git push".

Yeah, I think it makes sense to give --prune to "push" just like "fetch"
already has. These two are the primary (and in the ideal world, only)
operations that talk to the outside world. "remote add -f" might have been
a tempting "convenience" feature, but I personally think it probably was a
mistake for the exact reason that letting anything but "push" and "fetch"
talk to the outside world just invites more confusion. There does not have
to be 47 different ways to do the same thing.
