From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: Exploiting SHA1's  "XOR weakness" allows for faster hash
 calculation
Date: Wed, 5 Dec 2012 12:20:11 -0500
Message-ID: <20121205172011.GH18885@thunk.org>
References: <k9n3jd$akg$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 05 18:20:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TgIeB-0001gy-QM
	for gcvg-git-2@plane.gmane.org; Wed, 05 Dec 2012 18:20:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754057Ab2LERUR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2012 12:20:17 -0500
Received: from li9-11.members.linode.com ([67.18.176.11]:36967 "EHLO
	imap.thunk.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753735Ab2LERUQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2012 12:20:16 -0500
Received: from root (helo=closure.thunk.org)
	by imap.thunk.org with local-esmtp (Exim 4.72)
	(envelope-from <tytso@thunk.org>)
	id 1TgIdf-00028V-EN; Wed, 05 Dec 2012 17:20:03 +0000
Received: by closure.thunk.org (Postfix, from userid 15806)
	id CDFC7241B85; Wed,  5 Dec 2012 12:20:11 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <k9n3jd$akg$1@ger.gmane.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211134>

On Wed, Dec 05, 2012 at 10:19:43AM +0100, Sebastian Schuberth wrote:
> 
> to say it in advance: I do not want to trigger any bogus security
> discussion here. Instead, I believe the findings from [1] allow for
> an up to 20% faster SHA1 calculation, if my brief reading of the
> presentation is correct. Any opinions on integration this
> optimization into Git?
> 
> [1] https://hashcat.net/p12/js-sha1exp_169.pdf

It's only useful if you are trying to do brute-force password
cracking, where the password is being hashed in a very specific way.
(If for example the password was replicated N times in the input
buffer for SHA-1, instead of keeping the padding constant in the rest
of theinput buffer, this particular optimization would't apply.)

In any case, it's not at all applicable for general purpose checksum
calculations, and hence wouldn't apply to git.

Regards,

						- Ted
