From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 06/25] gettextize: git-fetch formatting messages
Date: Thu, 2 Sep 2010 16:28:16 -0400
Message-ID: <20100902202816.GA20362@sigill.intra.peff.net>
References: <1283373845-2022-1-git-send-email-avarab@gmail.com>
 <1283456446-22577-7-git-send-email-avarab@gmail.com>
 <20100902195936.GA2531@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 02 22:28:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrGOX-00019q-QS
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 22:28:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756956Ab0IBU2F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Sep 2010 16:28:05 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:47253 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756862Ab0IBU2E (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Sep 2010 16:28:04 -0400
Received: (qmail 3978 invoked by uid 111); 2 Sep 2010 20:28:02 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 02 Sep 2010 20:28:02 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Sep 2010 16:28:16 -0400
Content-Disposition: inline
In-Reply-To: <20100902195936.GA2531@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155195>

On Thu, Sep 02, 2010 at 02:59:37PM -0500, Jonathan Nieder wrote:

> (+cc: some fetch ui authors, just as a heads up)

Thanks. I think Nico actually did the fetch code, though, and I more or
less copied it for push.

> > @@ -249,8 +249,8 @@ static int update_local_ref(struct ref *ref,
> >  		 * If this is the head, and it's not okay to update
> >  		 * the head, and the old value of the head isn't empty...
> >  		 */
> > -		sprintf(display, "! %-*s %-*s -> %s  (can't fetch in current branch)",
> > -			TRANSPORT_SUMMARY_WIDTH, "[rejected]", REFCOL_WIDTH, remote,
> > +		sprintf(display, _("! %-*s %-*s -> %s  (can't fetch in current branch)"),
> > +			TRANSPORT_SUMMARY_WIDTH, _("[rejected]"), REFCOL_WIDTH, remote,
> 
> Regardless of the answer, we should probably be either consistently
> translating or not translating it within this patch.  e.g. for not
> translating (though I suspect translating is the better choice):
> 
> 		sprintf(display, "! %-*s %-*s -> %s  %s",
> 			TRANSPORT_SUMMARY_WIDTH, "[rejected]", REFCOL_WIDTH, remote,
> 			pretty_ref, _("(can't fetch in current branch)"));

I think you can translate "[rejected]" here, too.

However, do be aware of the --porcelain output for git-push. It was
tacked on much later, and I fear it may use some of the same strings.
Some of them are perhaps OK to translate (the human readable bit at the
end, e.g.), but others maybe not. I haven't looked closely.

-Peff
