From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/6] config: add helper function for parsing key names
Date: Tue, 15 Jan 2013 08:04:22 -0800
Message-ID: <20130115160422.GC21815@sigill.intra.peff.net>
References: <20130114145845.GA16497@sigill.intra.peff.net>
 <20130114150012.GA16828@sigill.intra.peff.net>
 <7v8v7veixc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Joachim Schmitz <jojo@schmitz-digital.de>,
	=?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 17:04:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tv90I-0006C0-Cu
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 17:04:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756893Ab3AOQE0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 11:04:26 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:34110 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756860Ab3AOQEZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 11:04:25 -0500
Received: (qmail 30412 invoked by uid 107); 15 Jan 2013 16:05:42 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (12.144.179.211)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 15 Jan 2013 11:05:42 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Jan 2013 08:04:22 -0800
Content-Disposition: inline
In-Reply-To: <7v8v7veixc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213643>

On Mon, Jan 14, 2013 at 10:08:47AM -0800, Junio C Hamano wrote:

> > +extern int match_config_key(const char *var,
> > +		     const char *section,
> > +		     const char **subsection, int *subsection_len,
> > +		     const char **key);
> > +
> 
> I agree with Jonathan about the naming s/match/parse/.

I see this is marked for re-roll in WC. I'm happy to re-roll it with the
suggestions from Jonathan, but before I do, did you have any comment on
the "struct config_key" alternative I sent as a follow-up?

You said:

> After looking at the callers in your later patches, I think the
> counted interface to subsection is probably fine.  The caller can
> check !subsection to see if it is a two- or three- level name, and
> 
>     if (parse_config_key(var, "submodule", &name, &namelen,  &key) < 0 ||
> 	!name)
> 	return 0;
> 
> is very easy to follow (that is the result of your 5th step).

but I wasn't sure if that was "it is not worth the trouble of the other
one" or "I did not yet read the other one".

-Peff
