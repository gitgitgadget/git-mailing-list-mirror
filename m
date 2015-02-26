From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v9 1/1] http: Add Accept-Language header if possible
Date: Thu, 26 Feb 2015 17:36:03 -0500
Message-ID: <20150226223603.GA27946@peff.net>
References: <1422446677-8415-2-git-send-email-eungjun.yi@navercorp.com>
 <xmqqpp8xmwnp.fsf@gitster.dls.corp.google.com>
 <20150226030416.GA6121@peff.net>
 <xmqqmw40l777.fsf@gitster.dls.corp.google.com>
 <20150226213356.GA14464@peff.net>
 <xmqqa900l57y.fsf@gitster.dls.corp.google.com>
 <CAGZ79kbUOhbs2DpM3CK=f+Gwj3v-q44Q7beiVgDHPPwm+rhEng@mail.gmail.com>
 <20150226220609.GA24663@peff.net>
 <20150226220759.GB24663@peff.net>
 <CAGZ79kar4Uf-mCwXpexPvNztwd_vfjdCoT_dDXULkOrCqUhG=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Yi EungJun <semtlenori@gmail.com>,
	Git List <git@vger.kernel.org>,
	Yi EungJun <eungjun.yi@navercorp.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	Michael Blume <blume.mike@gmail.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Feb 26 23:36:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YR72T-0005jb-Cv
	for gcvg-git-2@plane.gmane.org; Thu, 26 Feb 2015 23:36:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754019AbbBZWgI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2015 17:36:08 -0500
Received: from cloud.peff.net ([50.56.180.127]:53921 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751718AbbBZWgH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2015 17:36:07 -0500
Received: (qmail 20323 invoked by uid 102); 26 Feb 2015 22:36:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 26 Feb 2015 16:36:06 -0600
Received: (qmail 28926 invoked by uid 107); 26 Feb 2015 22:36:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 26 Feb 2015 17:36:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Feb 2015 17:36:03 -0500
Content-Disposition: inline
In-Reply-To: <CAGZ79kar4Uf-mCwXpexPvNztwd_vfjdCoT_dDXULkOrCqUhG=A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264476>

On Thu, Feb 26, 2015 at 02:26:05PM -0800, Stefan Beller wrote:

> On Thu, Feb 26, 2015 at 2:07 PM, Jeff King <peff@peff.net> wrote:
> >
> > Here it is, with the commit message and the missing hunk. This works for
> > me both with and without NO_GETTEXT defined.
> 
> This compiles here though a warning is spit:
> In file included from cache.h:8:0,
>                  from userdiff.c:1:
> gettext.h:92:1: warning: function declaration isn't a prototype
> [-Wstrict-prototypes]
>  const char *get_preferred_languages();
>  ^

Hmph. The compiler is right that it should be:

 const char *get_preferred_languages(void);

but my gcc (4.9.2, with -Wstrict_prototypes) does not seem to notice it!
Weird.

-Peff
