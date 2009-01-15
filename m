From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [PATCH] git-am: add --directory=<dir> option
Date: Thu, 15 Jan 2009 02:08:56 +0100
Message-ID: <20090115010856.GF32313@leksak.fem-net>
References: <7vbpudjanf.fsf@gitster.siamese.dyndns.org> <20090114234602.GD32313@leksak.fem-net> <7vzlhtxvu5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>,
	Simon 'corecode' Schubert <corecode@fs.ei.tum.de>,
	Kevin Ballard <kevin@sb.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 15 02:10:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNGkk-0006fN-3j
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 02:10:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753902AbZAOBJO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 20:09:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753888AbZAOBJN
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 20:09:13 -0500
Received: from mail.gmx.net ([213.165.64.20]:50013 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753044AbZAOBJM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 20:09:12 -0500
Received: (qmail invoked by alias); 15 Jan 2009 01:09:10 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp050) with SMTP; 15 Jan 2009 02:09:10 +0100
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX19hFlhbjUxhdsyAIPV0j/S0hF7DHiAhMFESgTZCId
	bwZedTccPevhEL
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1LNGjA-0003Rz-RE; Thu, 15 Jan 2009 02:08:56 +0100
Content-Disposition: inline
In-Reply-To: <7vzlhtxvu5.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105750>

Hi,

Junio C Hamano wrote:
> > Do I have a thinko or should it be this:
> >
> > +		sed -e 's/'\''/'\''\\\'\'''\''/g' -e 's/.*/ '\''&'\''/'
> > 		                   ^^
> > 			(added for escaping ' outside single quotes)
> 
> Almost.
> 
> Certainly my original was bad; shell unquotes to "s/'/'\''/g", but that
> backslash is not protected from further interpretation by sed, which
> happily turns backslash-single quote into a single quote, which I forgot.
> 
> You feed "s/'/'\\\''/g" which correctly protects one backslash from sed by
> doubling it, but it has one unnecessary extra backslash.

My attempt was to escape one backslash and to escape one single quote.

> The extra one
> does not hurt because the backslash + single quote is eaten by sed to
> produce a single quote, but it is not quite right.

Well, this explains why my syntax highlighting has "gone mad" in your
former and in my version.

> We should be feeding sed with "s/'/'\\''/g", so you need to add one
> backslash to mine.

Ok, works like a charm :-)

> > Have you forgotten to add the files prefixed with "am-test-5-" or is this
> > patch based on another one?
> 
> The one I actually queued is b47dfe9 (git-am: add --directory=<dir>
> option, 2009-01-11) and it does include these test vectors.  My bad.

Ohh, I did not even notice that you queued it, because I do not track "next".

And in my git-am.txt snippet I even forgot adding the option to the synopsis.
Oh, boy. :-)

I think it's fine now. :-)

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
