From: Ivan Todoroski <grnch_lists@gmx.net>
Subject: Re: Clone fails on a repo with too many heads/tags
Date: Tue, 27 Mar 2012 09:07:27 +0200
Message-ID: <4F71672F.7090202@gmx.net>
References: <4F69B5F0.2060605@gmx.net> <CAJo=hJu0H5wfXB_y5XQ6=S0VJ9t4pxHWkuy_=rehJL_6psf00g@mail.gmail.com> <20120321171423.GA13140@sigill.intra.peff.net> <4F6A33C5.2080909@gmx.net> <20120321201722.GA15021@sigill.intra.peff.net> <4F6E3373.7090500@gmx.net> <20120325010609.GB27651@sigill.intra.peff.net> <20120325023215.GA13958@sigill.intra.peff.net> <4F6F56D5.3000309@gmx.net> <4F6F5BCB.9050406@gmx.net> <20120326173301.GE7942@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Shawn Pearce <spearce@spearce.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 27 09:07:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCQUw-0000cb-HL
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 09:07:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753376Ab2C0HHA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Mar 2012 03:07:00 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:46165 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751449Ab2C0HG7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2012 03:06:59 -0400
Received: (qmail invoked by alias); 27 Mar 2012 07:06:57 -0000
Received: from unknown (EHLO [127.0.0.1]) [77.28.160.201]
  by mail.gmx.net (mp036) with SMTP; 27 Mar 2012 09:06:57 +0200
X-Authenticated: #14478976
X-Provags-ID: V01U2FsdGVkX18vhWAN5IIv7ZhmL9q/kYFwKuX8c+hWYhMfc39YA4
	dex5P9WN6TPrl6
User-Agent: Thunderbird 2.0.0.24 (Windows/20100228)
In-Reply-To: <20120326173301.GE7942@sigill.intra.peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194027>

On 26.03.2012 19:33, Jeff King wrote:
> On Sun, Mar 25, 2012 at 07:54:19PM +0200, Ivan Todoroski wrote:
> 
>>>>> That's weird. 405 is "Method Not Allowed". Clone shouldn't be doing
>>>>> anything more exotic than GET and POST. And the prior tests pass, so it
>> [...]
>> It's still failing on CentOS 5.8 with Apache 2.2.3. I will just find
>> another machine where the test suite works.
> 
> I'm running the tests with apache 2.2.22. So I wonder if there is some
> config syntax or behavior that is simply different in the much older
> version.

Most likely.

>> If you'd still like to debug the problem on CentOS 5.8 I can run any
>> commands or test any patches for you.
> 
> A few more things to try:
> 
>   - check httpd/access.log to confirm that apache really is returning a
>     405 (I can't imagine that curl would not be reporting it accurately,
>     but it's worth a shot)

Yeah, it has 405 in access log too.

>   - try running with GIT_CURL_VERBOSE=1 to get debug output from curl
> 
>   - try adding these to the apache config:
> 
>       RewriteLog "httpd/rewrite.log"
>       RewriteLogLevel 9
> 
>     which might yield more information.
> 
> I have no idea what you're looking for in any of those, but maybe
> something useful will be obvious. I don't have a lot of apache
> experience, so my next step in your shoes would be just trying to get
> more information on what's happening.

Thanks for the tips. I'll keep tinkering with this as time allows and 
post a patch if I find something.
