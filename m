From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t7502-commit.sh: fix a broken and-chain
Date: Tue, 28 Apr 2015 22:11:33 -0400
Message-ID: <20150429021132.GA438@peff.net>
References: <553F775C.3030102@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Wed Apr 29 04:11:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnHTS-0002OL-7S
	for gcvg-git-2@plane.gmane.org; Wed, 29 Apr 2015 04:11:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031388AbbD2CLg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2015 22:11:36 -0400
Received: from cloud.peff.net ([50.56.180.127]:51482 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1031315AbbD2CLf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2015 22:11:35 -0400
Received: (qmail 3121 invoked by uid 102); 29 Apr 2015 02:11:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Apr 2015 21:11:35 -0500
Received: (qmail 23254 invoked by uid 107); 29 Apr 2015 02:12:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Apr 2015 22:12:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Apr 2015 22:11:33 -0400
Content-Disposition: inline
In-Reply-To: <553F775C.3030102@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267953>

On Tue, Apr 28, 2015 at 01:04:44PM +0100, Ramsay Jones wrote:

> This test recently started failing for me. I haven't heard anyone
> else complaining about this, so maybe I should look into why my
> environment may be different to everyone else ... :-D (when I can
> find some time, of course!)
>
> [...]
>  test_expect_success !AUTOIDENT 'do not fire editor when committer is bogus' '
> -	>.git/result
> +	>.git/result &&

It looks like 92b269f (test-lib: turn on GIT_TEST_CHAIN_LINT by default,
2015-04-22) made it into pu recently, so you are probably just the first
person to test it whose system matches !AUTOIDENT (which in turn is
based on things like whether we can come up with a plausible-looking
email from your system).

Patch itself is obviously correct, and it looks like Junio has already
picked it up for pu. Thanks.

-Peff
