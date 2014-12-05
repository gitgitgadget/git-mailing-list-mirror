From: Alex Stangl <alex@stangl.us>
Subject: Re: error: core.autocrlf=input conflicts with core.eol=crlf
Date: Fri, 5 Dec 2014 10:33:58 -0600
Message-ID: <20141205163358.GA77231@scout.stangl.us>
References: <20141205054205.GA71681@scout.stangl.us>
 <54816863.90208@web.de>
 <5481D587.2050103@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 05 17:34:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwvpV-0008Pr-4I
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 17:34:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751076AbaLEQeA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2014 11:34:00 -0500
Received: from stangl.us ([66.93.193.95]:28805 "EHLO stangl.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750980AbaLEQd7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Dec 2014 11:33:59 -0500
Received: from scout.stangl.us (localhost [127.0.0.1])
	by scout.stangl.us (Postfix) with ESMTP id C961622816
	for <git@vger.kernel.org>; Fri,  5 Dec 2014 10:33:58 -0600 (CST)
X-Virus-Scanned: amavisd-new at stangl.us
Received: from stangl.us ([127.0.0.1])
	by scout.stangl.us (scout.stangl.us [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vWVhjzqbAZqg for <git@vger.kernel.org>;
	Fri,  5 Dec 2014 10:33:58 -0600 (CST)
Received: by scout.stangl.us (Postfix, from userid 1001)
	id 50BA822814; Fri,  5 Dec 2014 10:33:58 -0600 (CST)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <5481D587.2050103@web.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260874>

On Fri, Dec 05, 2014 at 04:55:51PM +0100, Torsten B?gershausen wrote:
> On 12/05/2014 09:10 AM, Torsten B?gershausen wrote:
> Or a test case showing the problem is welcome too.

I mentioned some examples in my previous post. Here they are in
condensed form. They assume core.eol isn't set in your global config.

These work fine:
$ mkdir -p /tmp/ex1_$$;cd /tmp/ex1_$$;git init;git config --global core.autocrlf input;git config core.autocrlf false;git config core.eol crlf;git status                                                                                                                                                                                                     
$ mkdir -p /tmp/ex3_$$;cd /tmp/ex3_$$;git init;git config --global core.autocrlf input;git -c core.autocrlf=false -c core.eol=crlf status

These equivalents fail:
$ mkdir -p /tmp/ex2_$$;cd /tmp/ex2_$$;git init;git config --global core.autocrlf input;git config core.eol crlf;git config core.autocrlf false;git status
$ mkdir -p /tmp/ex4_$$;cd /tmp/ex4_$$;git init;git config --global core.autocrlf input;git -c core.eol=crlf -c core.autocrlf=false status

Alex
