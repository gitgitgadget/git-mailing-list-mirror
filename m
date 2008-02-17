From: Theodore Tso <tytso@MIT.EDU>
Subject: Re: [RFC/PATCH] Teach git mergetool to use custom commands defined
	at config time
Date: Sun, 17 Feb 2008 16:49:42 -0500
Message-ID: <20080217214942.GJ8905@mit.edu>
References: <20080216185349.GA29177@hashpling.org> <CD749541-1B3B-4EA7-82A5-0DFC67B953BE@zib.de> <20080217002029.GA504@hashpling.org> <alpine.LSU.1.00.0802170045210.30505@racer.site> <20080217005620.GB504@hashpling.org> <7vbq6g758h.fsf@gitster.siamese.dyndns.org> <FBA2E61E-5CAF-49E3-A917-ACDD10586928@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Charles Bailey <charles@hashpling.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Feb 17 22:51:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQrQS-000541-Ui
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 22:51:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752215AbYBQVvW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 16:51:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751645AbYBQVvW
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 16:51:22 -0500
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:39469 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751122AbYBQVvV (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Feb 2008 16:51:21 -0500
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id m1HLntDU027202;
	Sun, 17 Feb 2008 16:49:56 -0500 (EST)
Received: from closure.thunk.org (c-66-30-1-139.hsd1.ma.comcast.net [66.30.1.139])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id m1HLnqXk024410
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 17 Feb 2008 16:49:53 -0500 (EST)
Received: from tytso by closure.thunk.org with local (Exim 4.67)
	(envelope-from <tytso@mit.edu>)
	id 1JQrON-0001qt-7L; Sun, 17 Feb 2008 16:49:47 -0500
Content-Disposition: inline
In-Reply-To: <FBA2E61E-5CAF-49E3-A917-ACDD10586928@zib.de>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74186>

On Sun, Feb 17, 2008 at 08:59:31AM +0100, Steffen Prohaska wrote:
>
> I am not upset at all and I really appreciate Charles work for
> adding a generic mechanism.  I was just wondering why not taking
> the direct way of adding tools to git-mergetool one by one until
> we eventually have a rather complete list of supported tools.
> This would be the easiest solution for end users if their
> preferred tool is supported.  It is also easier to add support
> for a specific tool than a generic mechanism.

I have no objection to a generic mechanism, but I don't see the value
of Charles suggestion to rip out support for the existing tools
supported by git-mergetool.

I think it *would* be better to use %(foo) extrapolation that
environment variables, so that it's not required for users to write
shell scripts unless absolutely necessary.

When we get around to rewriting git-mergetool in C, it might make
sense to put the tool support in the various shell scripts that are
installed in the git helper binary directory (i.e.,
git-mergetool-kdiff3, git-mergetool-meld, etc.)  That would make it
easier for users to create new shell scripts to support new tools if
necessary.

					- Ted
