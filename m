From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [PATCH] Make rebase--interactive use OPTIONS_SPEC
Date: Sat, 12 Jul 2008 19:27:29 +0200
Message-ID: <20080712172729.GE7572@leksak.fem-net>
References: <1215877700-17080-1-git-send-email-s-beyer@gmx.net> <alpine.DEB.1.00.0807121728180.8950@racer> <1215877700-17080-1-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jul 12 19:28:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHitd-00019Z-2t
	for gcvg-git-2@gmane.org; Sat, 12 Jul 2008 19:28:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752354AbYGLR1e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jul 2008 13:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752280AbYGLR1e
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jul 2008 13:27:34 -0400
Received: from mail.gmx.net ([213.165.64.20]:43821 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751877AbYGLR1d (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jul 2008 13:27:33 -0400
Received: (qmail invoked by alias); 12 Jul 2008 17:27:32 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp066) with SMTP; 12 Jul 2008 19:27:32 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX19y1Z0rMzJytStZKZklnsetv9B1xyrZmCFbv0hTXH
	9BIc605JAO4lOX
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KHisb-0004uy-OG; Sat, 12 Jul 2008 19:27:29 +0200
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807121728180.8950@racer> <1215877700-17080-1-git-send-email-s-beyer@gmx.net>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88257>

Hi,

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > +	--onto)
> > +		shift
> > +		ONTO=$(git rev-parse --verify "$1") ||
> > +			die "Does not point to a valid commit: $1"
> 
> Didn't you have some check earlier that "--onto" can only be used when 
> starting a rebase?

Yes, and I still have. is_standalone does that:

# check if no other options are set
is_standalone () {
	test $# -eq 2 -a "$2" = '--' &&
	test -z "$ONTO" &&
	test -z "$PRESERVE_MERGES" &&
	test -z "$STRATEGY" &&
	test -z "$VERBOSE"
}

which is called on --continue/--abort/--skip before the saved options are
loaded again.

Regards.

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
