From: Andrew Sayers <andrew-20120330@pileofstuff.org>
Subject: Re: [GSOC] Contributing to git.
Date: Fri, 30 Mar 2012 23:39:16 +0100
Message-ID: <4F763614.1010503@pileofstuff.org>
References: <CAH-tXsB39OpbmVcD3Fd+tq8UcBsyCf6JBZ-rSyf1VwrQPKLiFQ@mail.gmail.com> <20120330052631.GB11648@sigill.intra.peff.net> <201203301305.23567.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, jaseem abid <jaseemabid@gmail.com>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 31 00:39:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDkU0-0003Pn-7c
	for gcvg-git-2@plane.gmane.org; Sat, 31 Mar 2012 00:39:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935372Ab2C3Wjl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Mar 2012 18:39:41 -0400
Received: from mtaout01-winn.ispmail.ntl.com ([81.103.221.47]:7219 "EHLO
	mtaout01-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S935322Ab2C3WjW (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Mar 2012 18:39:22 -0400
Received: from aamtaout02-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout01-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20120330223919.VDTX29686.mtaout01-winn.ispmail.ntl.com@aamtaout02-winn.ispmail.ntl.com>;
          Fri, 30 Mar 2012 23:39:19 +0100
Received: from [192.168.0.2] (really [94.170.150.126])
          by aamtaout02-winn.ispmail.ntl.com
          (InterMail vG.3.00.04.00 201-2196-133-20080908) with ESMTP
          id <20120330223919.VVHQ3795.aamtaout02-winn.ispmail.ntl.com@[192.168.0.2]>;
          Fri, 30 Mar 2012 23:39:19 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.28) Gecko/20120313 Thunderbird/3.1.20
In-Reply-To: <201203301305.23567.jnareb@gmail.com>
X-Cloudmark-Analysis: v=1.1 cv=JvdXmxIgLJv2/GthKqHpGJEEHukvLcvELVXUanXFreg= c=1 sm=0 a=yXtjXN6ItgYA:10 a=aReBA_32PFcA:10 a=u4BGzq-dJbcA:10 a=IkcTkHD0fZMA:10 a=JQSNpBNHAAAA:8 a=1dG1fGEEAAAA:8 a=eHMbLMad-zLIjUB--yQA:9 a=5F_cP6whoG_av6qFaoUA:7 a=QEXdDO2ut3YA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194419>

On 30/03/12 12:05, Jakub Narebski wrote:
> But even if the JavaScript tests would have to be run in browser (like
> most of all of them seems to), having any automated test for gitweb's 
> JavaScript code would be a very good idea.
> 
> P.S. I wonder how JavaScript-scriptable Veracity DVCS solved that...

JS test suites generally run in the browser because knowing that your
tests pass in some sane command-line compiler tells you nothing about
how it will be mangled by IE (or in rare cases, other browsers).

IMHO, the best thing to do with JS unit tests would be to make them
easily available from gitweb.  Then when someone reports a bug, you just
ask them to run the tests in their browser - the pattern of errors will
quickly show you that e.g. their AdBlock filters are getting a bit
overexcited about all these `git add`s it can remove (that sort of thing
was a frequently-reported problem at my last job).

Obviously it's good to run tests automatically too - you might want to
consider writing tests with QUnit[1] and automating them with
Selenium[2].  The former is designed to be appealing to human eyes and
trivially testable with the latter (although I'd expect other suites to
include the necessary <div>s with the necessary id's too).  I haven't
used the Perl interface myself, but I'm sure you could make some TAP
output with WWW::Selenium pretty easily.

	- Andrew

1. http://docs.jquery.com/QUnit
2. http://seleniumhq.org/
