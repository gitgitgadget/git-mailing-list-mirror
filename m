From: Steven Grimm <koreth@midwinter.com>
Subject: Re: Basename matching during rename/copy detection
Date: Thu, 21 Jun 2007 09:57:30 -0700
Message-ID: <467AADFA.9040804@midwinter.com>
References: <20070621030622.GD8477@spearce.org> <200706211050.03519.andyparkins@gmail.com> <Pine.LNX.4.64.0706211252190.4059@racer.site> <200706211344.47560.andyparkins@gmail.com> <vpqodj9zcxf.fsf@bauges.imag.fr> <Pine.LNX.4.64.0706211417090.4059@racer.site> <vpqfy4lxwvl.fsf@bauges.imag.fr> <Pine.LNX.4.64.0706211451480.4059@racer.site> <467A9B2C.2060907@midwinter.com> <Pine.LNX.4.64.0706211649520.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jun 21 18:57:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1PyS-0004mH-Kq
	for gcvg-git@gmane.org; Thu, 21 Jun 2007 18:57:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755259AbXFUQ5f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Jun 2007 12:57:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754994AbXFUQ5f
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jun 2007 12:57:35 -0400
Received: from 91.86.32.216.static.reverse.layeredtech.com ([216.32.86.91]:43946
	"HELO midwinter.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with SMTP id S1752763AbXFUQ5e (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2007 12:57:34 -0400
Received: (qmail 979 invoked from network); 21 Jun 2007 16:57:34 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=gl3rMfdcBdRFwY2w0uv0DAo8ulwXPjZkRepWb/+bag8JD2tBE8qvFBZdASNGhNDs  ;
Received: from localhost (HELO sgrimm-mbp.local) (koreth@127.0.0.1)
  by localhost with SMTP; 21 Jun 2007 16:57:34 -0000
User-Agent: Thunderbird 2.0.0.4 (Macintosh/20070604)
In-Reply-To: <Pine.LNX.4.64.0706211649520.4059@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50644>

Johannes Schindelin wrote:
> No, that message did not convince me. It was way too short on the side of 
> facts.
>   

Short of posting multiple historical versions of the third-party source 
code in question, I'm not sure what I can do to convince you. And I'd 
rather not violate the license agreement on that code. I would have 
thought, though, that the fact that I supplied a detailed, reproducible 
test case with obviously broken behavior would itself have been pretty 
convincing.

The fact that not all projects contain any short files, or any files 
whose contents have ever been identical, does not cause git's behavior 
in that test case to be correct. "It's broken and unfixable" is one 
thing; "It's broken and we don't care" is another; and "It's broken and 
we care but it's not at the top of anyone's priority list to fix" is 
something else again. All of those are fine, but "If it's broken, you 
are stupid" and "If it's broken, it's a sign your project isn't real" 
are not.

Or, to take another tack on this entirely, it is not the proper function 
of a version control system to dictate the contents of the projects 
under its control. It should take whatever we humans throw at it and 
reproduce those contents faithfully with coherent, non-jumbled history. 
It should do so even if what we're throwing at it is completely stupid.

By the way, I'll toss out one more example of legitimate duplicate 
files, though admittedly one where you might not care so much about 
history jumbling: if you have a project that makes use of two GPL 
libraries or utilities whose source you want to keep locally, e.g. 
because you are making local modifications, you will have two copies of 
the GNU "COPYING" file. Neither one produced by a build system (or at 
least, not by *your* build system) and you are not permitted by the 
terms of the GPL to publish a copy of either piece of software without a 
verbatim copy of its license -- it says so right in section 1 of the GPL 
(the "keep intact" wording.) Removing one of those copies and expecting 
a build system to reconstruct it after someone clones your repository 
would arguably be a violation of the GPL.

-Steve
