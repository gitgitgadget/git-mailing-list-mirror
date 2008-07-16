From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [PATCH 1/2] t/test-lib.sh: Let test_must_fail fail on signals
	only
Date: Wed, 16 Jul 2008 13:57:32 +0200
Message-ID: <20080716115732.GB25087@leksak.fem-net>
References: <1215877672-17049-1-git-send-email-s-beyer@gmx.net> <20080716051829.GB4030@segfault.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jul 16 13:58:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJ5ec-00040i-14
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 13:58:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753978AbYGPL5n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 07:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752122AbYGPL5n
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 07:57:43 -0400
Received: from mail.gmx.net ([213.165.64.20]:57061 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753978AbYGPL5l (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 07:57:41 -0400
Received: (qmail invoked by alias); 16 Jul 2008 11:57:38 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp064) with SMTP; 16 Jul 2008 13:57:38 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1+LzARTOc2LzDpCBTsUSjZDadKsnzOsYAQr3+vRh1
	j1VUbyyrINzO66
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KJ5dU-0006nK-8Y; Wed, 16 Jul 2008 13:57:32 +0200
Content-Disposition: inline
In-Reply-To: <20080716051829.GB4030@segfault.peff.net>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88672>

Hi,

Jeff King wrote:
> On Sat, Jul 12, 2008 at 05:47:51PM +0200, Stephan Beyer wrote:
> 
> > The test_must_fail function in test-lib.sh has been designed
> > to distinguish segmentation faults from controlled errors.
> > But in the current implementation this only works if a git
> > command does not return a small negative value, like -1, -2
> > or -3. But some git commands do.
> 
> This is probably a fine protective measure, and it looks like Junio has
> already applied it. But shouldn't any git commands returning such values
> be fixed?

I didn't want to change any error codes and I wouldn't say that the term
"fix" is the right one here.

> Which commands return such bogus error codes?

Why bogus?

To answer your question, some are:
	git diff-files
	git diff-index
	git diff
	git merge-file

I think at least one test case failed "test_must_fail git merge-file ..."
without that change.

Regards.

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
