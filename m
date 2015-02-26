From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v9 1/1] http: Add Accept-Language header if possible
Date: Wed, 25 Feb 2015 22:10:29 -0500
Message-ID: <20150226031029.GA20457@peff.net>
References: <CAPc5daXEFZ+3Qr8fg0g9Mi6V+3r5yNmAFpAwVXciaMTwK244kg@mail.gmail.com>
 <1422446677-8415-1-git-send-email-eungjun.yi@navercorp.com>
 <1422446677-8415-2-git-send-email-eungjun.yi@navercorp.com>
 <xmqqpp8xmwnp.fsf@gitster.dls.corp.google.com>
 <20150226030416.GA6121@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Yi EungJun <semtlenori@gmail.com>, Git List <git@vger.kernel.org>,
	Yi EungJun <eungjun.yi@navercorp.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	Michael Blume <blume.mike@gmail.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 26 04:10:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQoqU-00018B-4x
	for gcvg-git-2@plane.gmane.org; Thu, 26 Feb 2015 04:10:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752706AbbBZDKc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2015 22:10:32 -0500
Received: from cloud.peff.net ([50.56.180.127]:53465 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751479AbbBZDKc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2015 22:10:32 -0500
Received: (qmail 29813 invoked by uid 102); 26 Feb 2015 03:10:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Feb 2015 21:10:32 -0600
Received: (qmail 21120 invoked by uid 107); 26 Feb 2015 03:10:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Feb 2015 22:10:33 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Feb 2015 22:10:29 -0500
Content-Disposition: inline
In-Reply-To: <20150226030416.GA6121@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264423>

On Wed, Feb 25, 2015 at 10:04:16PM -0500, Jeff King wrote:

> Another variant of this would for gettext.c to provide a git_setlocale
> that just wraps setlocale (and does nothing when NO_GETTEXT is given).

This doesn't _quite_ work. In addition to the function, we have to have
LC_MESSAGES defined. So we cannot provide a straight git_setlocale, but
it has to be something like "git_message_locale". At which point we
might as well just provide get_preferred_languages() as the interface
between gettext.c and the rest of the program.

-Peff
