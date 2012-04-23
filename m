From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 2/4] push: introduce new push.default mode "simple"
Date: Mon, 23 Apr 2012 10:38:42 +0200
Message-ID: <vpq397u4zcd.fsf@bauges.imag.fr>
References: <vpqfwbye9re.fsf@bauges.imag.fr>
	<1334933944-13446-1-git-send-email-Matthieu.Moy@imag.fr>
	<1334933944-13446-3-git-send-email-Matthieu.Moy@imag.fr>
	<xmqqy5pqkrl4.fsf@junio.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 23 10:38:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMEnR-0003AK-0o
	for gcvg-git-2@plane.gmane.org; Mon, 23 Apr 2012 10:38:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754379Ab2DWIiy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Apr 2012 04:38:54 -0400
Received: from mx1.imag.fr ([129.88.30.5]:58280 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754355Ab2DWIiw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2012 04:38:52 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q3N8WHCk025996
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 23 Apr 2012 10:32:17 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SMEnD-0004rG-0u; Mon, 23 Apr 2012 10:38:43 +0200
In-Reply-To: <xmqqy5pqkrl4.fsf@junio.mtv.corp.google.com> (Junio C. Hamano's
	message of "Fri, 20 Apr 2012 14:42:47 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 23 Apr 2012 10:32:17 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q3N8WHCk025996
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1335774738.08609@2bFcp+kK2TsCnoR678DI6w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196105>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>
>> Except for the broken-ness, this adds the last line in the warning message:
>
> Hmm?  What brokenness?

The brokenness of my previous iteration.

>> +		      "To chose either option permanently, read about push.default in git-config(1)\n"),
>
> Nice ;-)

But as Jeff pointed out, this should be displayed only if the option
hasn't been set explicitely.

> I think SIMPLE should come between CURRENT and UPSTREAM in the order of
> logical progression, i.e. CURRENT < SIMPLE < UPSTREAM,

I disagree. There's actually a partial order with SIMPLE < CURRENT,
SIMPLE < UPSTREAM, and CURRENT not comparable with UPSTREAM. Any
successfull push with SIMPLE would have done exactly the same thing for
either CURRENT and UPSTREAM.

> SIMPLE is a bit more advanced (you can take advantage of
> @{upstream})

You don't really "take advantage of @{upstream}". You just get
suspicious pushes denied.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
