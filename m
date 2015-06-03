From: Jeff King <peff@peff.net>
Subject: Re: Suggestion: make git checkout safer
Date: Wed, 3 Jun 2015 15:06:16 -0400
Message-ID: <20150603190616.GA28488@peff.net>
References: <loom.20150603T104534-909@post.gmane.org>
 <20150603090654.GD32000@peff.net>
 <loom.20150603T110826-777@post.gmane.org>
 <20150603093514.GF32000@peff.net>
 <xmqqlhg0y9xj.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ed Avis <eda@waniasset.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 03 21:06:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0Dzh-0008I0-1M
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 21:06:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755866AbbFCTGY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 15:06:24 -0400
Received: from cloud.peff.net ([50.56.180.127]:40681 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758602AbbFCTGT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2015 15:06:19 -0400
Received: (qmail 11910 invoked by uid 102); 3 Jun 2015 19:06:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Jun 2015 14:06:19 -0500
Received: (qmail 23943 invoked by uid 107); 3 Jun 2015 19:06:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Jun 2015 15:06:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Jun 2015 15:06:16 -0400
Content-Disposition: inline
In-Reply-To: <xmqqlhg0y9xj.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270724>

On Wed, Jun 03, 2015 at 10:32:40AM -0700, Junio C Hamano wrote:

> "git checkout $paths" (and you can give "." for $paths to mean
> "everything") is akin to "cp -R $elsewhere/$path ." to restore the
> working tree copies from somewhere else.
> 
> "Ouch, 'git checkout .'  overwrote what was in my working tree" is
> exactly the same kind of confusion as "I ran 'cp -r ../saved .' and
> it overwrote everything".  As you said in your initial response,
> that is what the command is meant for.
> 
> What does that similar command outside world, "cp", have for "more
> safety"?  'cp -i' asks if the user wants to overwrite a file for
> each path; perhaps a behaviour similar to that was the original
> poster wanted to see?

Yeah, I'd say "cp -i" is the closest thing. I don't have a problem with
adding that, but I'd really hate for it to be the default (just as I
find distros which "alias rm='rm -i" annoying).

-Peff
