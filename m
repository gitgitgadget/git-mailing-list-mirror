From: Jeff King <peff@peff.net>
Subject: Re: regression: "96b9e0e3 config: treat user and xdg config
 permission problems as errors" busted git-daemon
Date: Fri, 12 Apr 2013 01:05:50 -0400
Message-ID: <20130412050550.GA15724@sigill.intra.peff.net>
References: <20130411181103.GJ27070@google.com>
 <20130411181439.GA2820@sigill.intra.peff.net>
 <7vwqs8hmh1.fsf@alter.siamese.dyndns.org>
 <20130411200330.GA15667@odin.tremily.us>
 <7vip3shfpd.fsf@alter.siamese.dyndns.org>
 <20130411222301.GA11283@sigill.intra.peff.net>
 <20130412005748.GA17116@odin.tremily.us>
 <7vvc7sfkwn.fsf@alter.siamese.dyndns.org>
 <20130412043501.GA12942@sigill.intra.peff.net>
 <7vr4igfj9w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "W. Trevor King" <wking@tremily.us>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Mike Galbraith <bitbucket@online.de>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 12 07:05:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQWBR-0001Yi-Ot
	for gcvg-git-2@plane.gmane.org; Fri, 12 Apr 2013 07:05:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752101Ab3DLFFx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Apr 2013 01:05:53 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:41214 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750836Ab3DLFFw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Apr 2013 01:05:52 -0400
Received: (qmail 23341 invoked by uid 107); 12 Apr 2013 05:07:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 12 Apr 2013 01:07:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Apr 2013 01:05:50 -0400
Content-Disposition: inline
In-Reply-To: <7vr4igfj9w.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220952>

On Thu, Apr 11, 2013 at 09:46:35PM -0700, Junio C Hamano wrote:

> >>     --user::
> >> 	... current description ...
> >>     +
> >>     (Like|Unlike) many programs that let you run programs as
> >>     specified user, the daemon does not reset environment variables
> >>     such as $HOME when it runs git programs like upload-pack and
> >>     receive-pack. Set and export HOME to point at the home directory
> >>     of the user you specify with this option before you start the
> >>     daemon, and make sure the Git configuration files in that
> >>     directory is readable by that user.
> >
> > So choosing "Like" here, I think this makes sense.
> 
> I would prefer the simplicity ;-)
> 
> "Set and export HOME to point at the home directory of the user you
> specify with this option" screams that it wants to be rephrased at
> me, though.  It somehow sounds as if this option is a way to set and
> export the environment variable unless re-read carefully X-<.

Perhaps:

  Like many programs that switch user id, the daemon does not reset
  environment variables such a `$HOME` when it runs git programs like
  `upload-pack` and `receive-pack`. When using this option, you may also
  want to set and export `HOME` to point at the home directory of
  `<user>` before starting the daemon, and make sure the Git
  configuration file in that directory are readable by `<user>`.

I tried to address your concern above (which I agree with), smooth over
a few clunky wordings, and use "<user>", which is defined in the heading
of the option:

  --user=<user>, --group=<group>

-Peff
