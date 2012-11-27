From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: [PATCH] Third try at documenting command integration
 requirements.
Date: Tue, 27 Nov 2012 12:56:19 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20121127175618.GA11845@thyrsus.com>
References: <20121126053557.E56434065F@snark.thyrsus.com>
 <7vzk24qgjx.fsf@alter.siamese.dyndns.org>
 <20121126214134.GA1713@thyrsus.com>
 <50B4A8E1.7050801@alum.mit.edu>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Nov 27 18:56:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdPOg-0004RX-Dk
	for gcvg-git-2@plane.gmane.org; Tue, 27 Nov 2012 18:56:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083Ab2K0R4X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 12:56:23 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:56838
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755514Ab2K0R4W (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 12:56:22 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id 4C79F40661; Tue, 27 Nov 2012 12:56:19 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <50B4A8E1.7050801@alum.mit.edu>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210580>

Michael Haggerty <mhagger@alum.mit.edu>:
> OK, now let's discuss *which* minimum Python version that git should
> support in the hypothetical new world...

By all means!
 
> It would be a shame to leave RHEL 5 users behind if Python is used to
> implement important git functionality.  Python 2.4 is missing some of
> Python's shiny new features, but still quite OK.  What features would
> you miss the most if we were to target Python 2.4 instead of 2.6?

Off the top of my head...the 'with' statement, the conditional
expression, and built-in JSON support.  Other developers would be
likely to kick about the string format() method; personally I'm
cheerfully old-school about that.

I agree that 2.4 is still quite OK.  I'm a little concerned that dropping that
far back might store up some transition problems for the day we decide to
make the jump to Python 3.

On the other hand, I think gating features on RHEL5 might be
excessively cautious.  According to [1], RHEL will red-zone within 30
days if it hasn't done so already ([1] says "Q4").  And RHEL6 (with
Python 2.6) has been shipping for two years.

Policy suggestion: we aim to stay friendly for every version of RHEL that
is still in Support 1.  I doubt anyone will code anything critical 
in Python before Dec 31st - I'm certainly not planning to!

[1] http://en.wikipedia.org/wiki/Red_Hat_Enterprise_Linux RHEL5 is going
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
