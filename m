From: Jeff King <peff@peff.net>
Subject: Re: git: please refuse push containing commits marked for
 autosquash by default
Date: Mon, 26 Jul 2010 11:50:27 -0400
Message-ID: <20100726155027.GB18762@coredump.intra.peff.net>
References: <20100716123715.16356.65888.reportbug@richter>
 <20100716190432.GA16371@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Simon Richter <sjr@debian.org>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 26 17:50:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdPwq-0003c9-3H
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 17:50:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752960Ab0GZPua (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jul 2010 11:50:30 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:46082 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752485Ab0GZPu3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jul 2010 11:50:29 -0400
Received: (qmail 8943 invoked by uid 111); 26 Jul 2010 15:50:28 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO coredump.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) ESMTPSA; Mon, 26 Jul 2010 15:50:28 +0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Jul 2010 11:50:27 -0400
Content-Disposition: inline
In-Reply-To: <20100716190432.GA16371@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151850>

On Fri, Jul 16, 2010 at 02:04:32PM -0500, Jonathan Nieder wrote:

> > When using the --autosquash feature, quite a number of temporary commits
> > are created that should never be pushed anywhere. It might be a good
> > idea to have an option to refuse to transfer commits whose messages
> > start with "fixup!" or "squash!", both on the server and client side.
> 
> At first glance this looks very useful, as an optional hook rather
> than on by default[1].

Yeah, from my cursory look, this really seems like policy that should be
going in a hook.

> Sending side: there is no pre-push hook yet, but there was some work
> towards that about a year and a half ago[2].  Maybe someone interested
> could revive the topic or figure out what remains to be done.

If somebody is interested in that, they should read this related thread:

  http://thread.gmane.org/gmane.comp.version-control.git/128273

which talks about a "pre-push" hook that could interactively confirm
push of specific refs. So ideally any pre-push hook interface would not
just be "do the push or not" but would actually be able to munge the
list of commits to push.

-Peff
