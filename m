From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/4] allow recovery from command name typos
Date: Sun, 6 May 2012 04:21:30 -0400
Message-ID: <20120506082130.GB27878@sigill.intra.peff.net>
References: <1336287330-7215-1-git-send-email-rctay89@gmail.com>
 <1336287330-7215-2-git-send-email-rctay89@gmail.com>
 <1336287330-7215-3-git-send-email-rctay89@gmail.com>
 <1336287330-7215-4-git-send-email-rctay89@gmail.com>
 <1336287330-7215-5-git-send-email-rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 06 10:22:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQwjR-0002MD-BJ
	for gcvg-git-2@plane.gmane.org; Sun, 06 May 2012 10:22:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752214Ab2EFIVe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 May 2012 04:21:34 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59396
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752018Ab2EFIVd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2012 04:21:33 -0400
Received: (qmail 7537 invoked by uid 107); 6 May 2012 08:21:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 06 May 2012 04:21:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 06 May 2012 04:21:30 -0400
Content-Disposition: inline
In-Reply-To: <1336287330-7215-5-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197156>

On Sun, May 06, 2012 at 02:55:30PM +0800, Tay Ray Chuan wrote:

> If suggestions are available (based on Levenshtein distance) and if the
> terminal isatty(), present a prompt to the user to select one of the
> computed suggestions.
> 
> In the case where there is a single suggestion, present the prompt
> "[Y/n]", such that "", "y" and "Y" as input leads git to proceed
> executing the suggestion, while everything else (possibly "n") leads git
> to terminate.
> 
> In the case where there are multiple suggestions, number the suggestions
> 1 to n, and accept as input one of the numbers, while everything else
> (possibly "n") leads git to terminate. In this case there is no default;
> that is, an empty input leads git to terminate. A sample run:
> 
>   $ git sh --pretty=oneline
>   git: 'sh' is not a git command. See 'git --help'.
> 
>   Did you mean one of these?
>   1:	show
>   2:	push
>   [1/2/.../n] 1

Ugh. Please protect this with a config variable that defaults to
"off".  It is very un-Unix to prompt unexpectedly, and I suspect a lot
of people would be annoyed by this behavior changing by default (I know
I would be).

-Peff
