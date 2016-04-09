From: Jeff King <peff@peff.net>
Subject: Re: git segfaults on older Solaris releases
Date: Sat, 9 Apr 2016 16:35:31 -0400
Message-ID: <20160409203530.GA18989@sigill.intra.peff.net>
References: <5706A489.7070101@jupiterrise.com>
 <xmqqoa9lz2uw.fsf@gitster.mtv.corp.google.com>
 <xmqqk2k9z20p.fsf@gitster.mtv.corp.google.com>
 <5706C0D4.9030707@jupiterrise.com>
 <5708A90E.1050705@jupiterrise.com>
 <20160409173904.GA5127@sigill.intra.peff.net>
 <57096374.6030608@jupiterrise.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: "Tom G. Christensen" <tgc@jupiterrise.com>
X-From: git-owner@vger.kernel.org Sat Apr 09 22:39:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aozeq-0000jw-Oa
	for gcvg-git-2@plane.gmane.org; Sat, 09 Apr 2016 22:39:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754505AbcDIUfg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Apr 2016 16:35:36 -0400
Received: from cloud.peff.net ([50.56.180.127]:46999 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753241AbcDIUff (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Apr 2016 16:35:35 -0400
Received: (qmail 13274 invoked by uid 102); 9 Apr 2016 20:35:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 09 Apr 2016 16:35:34 -0400
Received: (qmail 14354 invoked by uid 107); 9 Apr 2016 20:35:38 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 09 Apr 2016 16:35:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 09 Apr 2016 16:35:31 -0400
Content-Disposition: inline
In-Reply-To: <57096374.6030608@jupiterrise.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291127>

On Sat, Apr 09, 2016 at 10:17:56PM +0200, Tom G. Christensen wrote:

> On 09/04/16 19:39, Jeff King wrote:
> 
> >   [1/3]: config: lower-case first word of error strings
> >   [2/3]: git_config_set_multivar_in_file: all non-zero returns are errors
> >   [3/3]: git_config_set_multivar_in_file: handle "unset" errors
> >
> 
> I applied them to 2.8.1 and ran the testsuite again on Solaris 8/x86 and the
> segfault is gone.

Thanks for testing. By the way, I ran the whole test suite with "--tee -v"
and grepped for "(null)", which does find this case on glibc systems. I
didn't see any other interesting cases (there _are_ mentions of
"(null)", but they are from our code, not glibc converting NULLs). Which
I guess is just corroborating your testing, since you would have seen
any bad cases as segfaults.

-Peff
