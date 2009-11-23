From: Carlo Marcelo Arenas Belon <carenas@sajinet.com.pe>
Subject: Re: [PATCH] unset GREP_OPTIONS in test-lib.sh
Date: Mon, 23 Nov 2009 11:22:21 +0000
Message-ID: <20091123112221.GA7175@sajinet.com.pe>
References: <1258560919-28054-1-git-send-email-bert.wesarg@googlemail.com> <7v1vjvebem.fsf@alter.siamese.dyndns.org> <4B095F91.8030305@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org
To: Ren? Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Mon Nov 23 12:30:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCX80-0005Vf-8j
	for gcvg-git-2@lo.gmane.org; Mon, 23 Nov 2009 12:30:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757111AbZKWLac (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Nov 2009 06:30:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757054AbZKWLac
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Nov 2009 06:30:32 -0500
Received: from sajino.sajinet.com.pe ([76.74.239.193]:55492 "EHLO
	sajino.sajinet.com.pe" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756997AbZKWLac (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Nov 2009 06:30:32 -0500
X-Greylist: delayed 496 seconds by postgrey-1.27 at vger.kernel.org; Mon, 23 Nov 2009 06:30:32 EST
Received: by sajino.sajinet.com.pe (Postfix, from userid 1000)
	id E98FFA5826B; Mon, 23 Nov 2009 11:22:21 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <4B095F91.8030305@lsrfire.ath.cx>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133498>

On Sun, Nov 22, 2009 at 04:58:09PM +0100, Ren? Scharfe wrote:
> Junio C Hamano schrieb:
> > Do we kill that environment variable when we call out to external grep in
> > grep.c?  If not, we should.  An alternative is to teach our internal one
> > to also honor it, but I personally do not find it too attractive to mimic
> > the design mistake of GREP_OPTIONS myself.
> 
> We don't.  Here's a patch with a simple test case that makes git grep
> unset GREP_OPTIONS before it calls the external grep.
> 
> While we're at it, also unset GREP_COLOR and GREP_COLORS in case
> colouring is not enabled, to be on the safe side.  The presence of
> these variables alone is not sufficient to trigger coloured output with
> GNU grep, but other implementations may behave differently.

why not better to apply the proposed patch from Junio in :

  http://article.gmane.org/gmane.comp.version-control.git/127980/

it would IMHO correct all reported issues and serve as well as a catch
all from other tools that could be introduced in the future and that
will be similarly affected by this misfeature.

Carlo
