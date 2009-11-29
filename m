From: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
Subject: Re: [PATCH 3/4] build dashless "test-bin" directory similar to installed bindir
Date: Sat, 28 Nov 2009 21:23:55 -0700
Message-ID: <20091129042355.GA2252@comcast.net>
References: <1259433537-3963-1-git-send-email-mmogilvi_git@miniinfo.net> <1259433537-3963-2-git-send-email-mmogilvi_git@miniinfo.net> <1259433537-3963-3-git-send-email-mmogilvi_git@miniinfo.net> <1259433537-3963-4-git-send-email-mmogilvi_git@miniinfo.net> <7vtywefn88.fsf@alter.siamese.dyndns.org> <20091128194910.GA17605@coredump.intra.peff.net> <7vaay6f4ce.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 29 05:24:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NEbKV-0000HW-Vk
	for gcvg-git-2@lo.gmane.org; Sun, 29 Nov 2009 05:24:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753892AbZK2EXv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Nov 2009 23:23:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753872AbZK2EXv
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Nov 2009 23:23:51 -0500
Received: from qmta02.emeryville.ca.mail.comcast.net ([76.96.30.24]:40892 "EHLO
	QMTA02.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753758AbZK2EXv (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Nov 2009 23:23:51 -0500
Received: from OMTA10.emeryville.ca.mail.comcast.net ([76.96.30.28])
	by QMTA02.emeryville.ca.mail.comcast.net with comcast
	id AsG01d0020cQ2SLA2sPyrA; Sun, 29 Nov 2009 04:23:58 +0000
Received: from mmogilvi.homeip.net ([24.8.125.243])
	by OMTA10.emeryville.ca.mail.comcast.net with comcast
	id AsPx1d0035FCJCg8WsPxRl; Sun, 29 Nov 2009 04:23:58 +0000
Received: by mmogilvi.homeip.net (Postfix, from userid 501)
	id BE9D489115; Sat, 28 Nov 2009 21:23:55 -0700 (MST)
Content-Disposition: inline
In-Reply-To: <7vaay6f4ce.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.4i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133990>

On Sat, Nov 28, 2009 at 06:32:33PM -0800, Junio C Hamano wrote:
> Why can't t/Makefile have a dependency on its 'default' target that goes
> up and prepares test-bin/, i.e. "cd .. && make test-bin-stuff"?

That wouldn't help with someone manually running specific tests,
which is a common way to run tests when working on git:

   hackhackhack && make && cd t && ./tXXXX-*.sh

Perhaps we could invoke make from test-lib.sh, but at that point
it starts to look more attractive to just do it the same way as the
valgrind option, even though that means duplicating the appropriate
list of executables in test-lib.sh.

Also, "make all" already builds some test suite support
binaries (test-*).  Is it really worth any effort to leave
a few short wrapper scripts out of "make all" when it is already
building several test binaries?

(See also my much longer email response that crossed this one in the
mail.)

--
Matthew Ogilvie   [mmogilvi_git@miniinfo.net]
