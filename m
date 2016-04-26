From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] http: Support sending custom HTTP headers
Date: Tue, 26 Apr 2016 17:33:33 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1604260851390.2896@virtualbox>
References: <abe253758829795c285c2036196ebe7edd9bab34.1461589951.git.johannes.schindelin@gmx.de> <xmqq7fflleau.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 26 17:33:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1av4zj-00058u-51
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 17:33:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752021AbcDZPdn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2016 11:33:43 -0400
Received: from mout.gmx.net ([212.227.15.18]:63641 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751101AbcDZPdm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 11:33:42 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0LbM2k-1baDJ6262c-00kvKU; Tue, 26 Apr 2016 17:33:34
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqq7fflleau.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:lbOzTcAYrQtgAnzlr+qWnbocDx9OxDUcEsCkSH5bmkqX649Z9fA
 AhrlZxl+qiR3v5y2KFiKLrabf3gD/K+kJbgoQYsD1i3fYvkNXw0S39ITIcRp+2Z/2vx2/al
 hqxtrCi24WeQ+FzeotrRmC6KvjJTBraj60EKNdMSjp+bxu56HbYig6/iP9l4LklVmZwMrUj
 fgkQyynpPFrgVrCzo6XSw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:cDWCoqfU8wE=:8xnUtlaB5zWWn03bMy8iBN
 /+wUXhLAoQey83CDC4By8uBfn6L4JKUVmyp+FDufQiyXdztj2KIM0TodIBQ8dvmk/CCdvRy7G
 JC4dMvzl0fabWNhZfbbENor08FFkY9Cm+GapU0Oak5CtKu/R5scEoBwmBceeaF3CM8u125n0m
 TVQqAh478eBd6y042VuV3TJU311YzTIPNbmvrHiy0w0iMYUS/AcLK++hMdym8BhEZgfe+wNma
 fanluu0iGm5kua9BOAzWbj+1cxx+XYrS0/w4vZR409Tcbq1DK72yD/Gho/OOekLFoN8UyKGEg
 9kVu7s7okI4dnGofOeyEq6JEfg4Qi0TRRomO+OIHVEd5jza9gokh26bs4RqOPNSfcgewDWmdQ
 NCVBShrP2dwFht7SzI3SaY4AYDLVcpCQlmFcVbSpuL/2U57gYo6I4sn8xIq6xgSGSoJrWD/TV
 iDVeXytiv3RwrtsfnP2tlWz9YtTUQRU6lq/+oDp38kA/RjjqUXolMQrPwDfYzLNBZt16t9xB2
 xpELsnQbQcavEnD7ZEjTUibI4DXx8lkXURHoEar+50fDysz1bwbohpfB84Mj8EuCzgxxDjWOS
 7jhqSkETBmgNPg0tnL4jGmshhygWm8Fr5qJ+L8nMBnMZDTJxU2CWH7pOFi/wYQROUNKXd0vPw
 wOCg6nROM93CFyolOkNjLORZ299dQ0uhLCWF7xJT3R+i90M+N+y7YUSoEOnMXFHgBpYKexXeY
 /Kswk3hEcul3B0WEjOG5IbGWY4aafqTFUQvF0FZl9BY1+0e5++CsJYLgGey2pEhmfs6lNNSJ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292603>

Hi Junio,

On Mon, 25 Apr 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > To make communication for `git fetch`, `git ls-remote` and friends
> > extra secure, we introduce a way to send custom HTTP headers with all
> > requests.
> 
> I think an ability to send custom headers may be a good addition and
> have no problem with it, but I tend to agree with Shawn that its log
> message that advertises it as if it has anything to do with security is
> probably a bad idea in both ways (i.e. it isn't very secure, and the
> usefulness of the feature is not limited to security).

You know, it never occurred to me that anybody could even *think* that I
was talking about the security of the client setup.

You see, it is much easier to read $HOME/.netrc than /proc/, especially if
you are looking outside of Linux, where the proc filesystem does not even
exist.  And it is almost as easy to query the credential helper for a
plain text password as looking at $HOME/.netrc.

So I took it for granted that everybody knows that they have to keep their
own computer safe.

Instead, I was thinking of server side security (with the clear
expectation that the users will keep their client setups secure).

I will rephrase the commit message to describe the actual use case I have
here: build agents need temporary access to private repositories, and I'd
like to do that via sort of One-Time-Passwords, sent as additional HTTP
headers (via HTTPS, I should not need to point out, but now feel I have to
spell out).

> > Published-As: https://github.com/dscho/git/releases/tag/extra-http-headers-v1
> 
> Move this after "---".

Whoops. That is what I intended, but overlooked. Will fix.

> This obviously needs documentation updates and tests, no?

Documentation, yes. I have that already, but somehow it slipped out of the
patch.

Testing the headers? I dunno, do we have tests for that already? I thought
we did not: it requires an HTTP server (so that the headers are actually
sent) that we can force to check the header...

So I see we have some tests that use Apache, and one that uses our own
http-backend. But is there already anything that logs HTTP requests? I did
not think so, please correct me if I am wrong.

Ciao,
Dscho
