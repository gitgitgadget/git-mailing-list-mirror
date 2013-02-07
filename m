From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] git-send-email: add ~/.authinfo parsing
Date: Thu, 07 Feb 2013 08:08:59 +0100
Message-ID: <vpq4nhowqgk.fsf@grenoble-inp.fr>
References: <2f93ce7b6b5d3f6c6d1b99958330601a5560d4ba.1359486391.git.mina86@mina86.com>
	<7vvcafojf4.fsf@alter.siamese.dyndns.org>
	<20130130074306.GA17868@sigill.intra.peff.net>
	<7v6226pdb7.fsf@alter.siamese.dyndns.org>
	<vpqa9rhaml6.fsf@grenoble-inp.fr> <876225o5mj.fsf@lifelogs.com>
	<vpqmwvhxyuj.fsf@grenoble-inp.fr> <87sj59mo2y.fsf@lifelogs.com>
	<20130206215724.GA27507@sigill.intra.peff.net>
	<8738x9ghpu.fsf@lifelogs.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Michal Nazarewicz <mpn@google.com>, git@vger.kernel.org,
	Krzysztof Mazur <krzysiek@podlesie.net>,
	Michal Nazarewicz <mina86@mina86.com>
To: Ted Zlatanov <tzz@lifelogs.com>
X-From: git-owner@vger.kernel.org Thu Feb 07 08:10:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3LcJ-0002TS-MC
	for gcvg-git-2@plane.gmane.org; Thu, 07 Feb 2013 08:09:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751535Ab3BGHJd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2013 02:09:33 -0500
Received: from mx1.imag.fr ([129.88.30.5]:40103 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750925Ab3BGHJc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2013 02:09:32 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r1778x27032567
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 7 Feb 2013 08:09:01 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1U3LbQ-0005TH-8I; Thu, 07 Feb 2013 08:09:00 +0100
In-Reply-To: <8738x9ghpu.fsf@lifelogs.com> (Ted Zlatanov's message of "Wed, 06
	Feb 2013 18:12:13 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 07 Feb 2013 08:09:03 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r1778x27032567
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1360825746.60618@58YiPODVlh7O6FAVmBv+Pg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215674>

Ted Zlatanov <tzz@lifelogs.com> writes:

> Logically they are different steps (query and response), even though the
> data protocol is the same.  But it's really not a big deal, I know what
> it means either way.

Yes, but if you rename write() to query(), then on the helper side,
you'll have to call query() to send the response, and response() to read
the query. Much worse than keeping read/write.

Plus, read/write has already been used for a while in the C API, so I'd
rather keep the same names for the Perl equivalent.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
