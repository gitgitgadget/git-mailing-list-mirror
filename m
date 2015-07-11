From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: Git Smart HTTP with HTTP/2.0
Date: Sat, 11 Jul 2015 10:00:55 +0300
Message-ID: <20150711070055.GA4061@LK-Perkele-VII>
References: <BLU403-EAS33258611CF3B5B553B1C996A09E0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: ForceCharlie <fbcharlie@outlook.com>
X-From: git-owner@vger.kernel.org Sat Jul 11 09:06:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDorP-0006AX-2x
	for gcvg-git-2@plane.gmane.org; Sat, 11 Jul 2015 09:06:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752647AbbGKHGA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Jul 2015 03:06:00 -0400
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:57005 "EHLO
	emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752117AbbGKHF7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jul 2015 03:05:59 -0400
X-Greylist: delayed 302 seconds by postgrey-1.27 at vger.kernel.org; Sat, 11 Jul 2015 03:05:58 EDT
Received: from LK-Perkele-VII (a91-155-194-207.elisa-laajakaista.fi [91.155.194.207])
	by emh07.mail.saunalahti.fi (Postfix) with ESMTP id 661613FFA;
	Sat, 11 Jul 2015 10:00:55 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <BLU403-EAS33258611CF3B5B553B1C996A09E0@phx.gbl>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273853>

On Sat, Jul 11, 2015 at 11:10:48AM +0800, ForceCharlie wrote:
> As we known, HTTP/2.0 has been released. All Git-Smart-HTTP are currently
> implemented using HTTP/1.1.

Nit: It is HTTP/2.
 
> Frequently used Git developers often feel Git HTTP protocol is not
> satisfactory, slow and unstable.This is because the HTTP protocol itself
> decides

Note that there are already two versions of HTTP transport, the old "dumb"
one and the newer "smart" one.

The smart one is difficult to speed up (due to nature of the negotiations),
but usually is pretty reliable (the efficiency isn't horrible).

Now, the old "dumb" protocol is pretty unreliable and slow. HTTP/2 probably
can't do anything with the reliability problems, but probably could improve
the speed a bit.

Websockets over HTTP/2 (a.k.a. "websockets2") has not been defined yet.
With Websockets(1), it would probably already be possible to tunnel the
native git smart transport protocol over it. Probably not worth it.

> When HTTP/2.0 is published. We might be able to git developers jointly,
> based on HTTP/2.0 Git-Smart-HTTP service and client support.
> HTTP/2.0: https://tools.ietf.org/html/rfc7540

Well, it is published already.
 

-Ilari
