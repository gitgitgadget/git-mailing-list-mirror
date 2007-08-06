From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] send-email: let sanitize_address_rfc822 do rfc2047 quoting
Date: Mon, 06 Aug 2007 02:21:35 +0200
Organization: At home
Message-ID: <f95pie$8lv$1@sea.gmane.org>
References: <11863445481996-git-send-email-ukleinek@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 06 02:21:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHqLz-0001RK-W0
	for gcvg-git@gmane.org; Mon, 06 Aug 2007 02:21:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758437AbXHFAVp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 5 Aug 2007 20:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758416AbXHFAVp
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 20:21:45 -0400
Received: from main.gmane.org ([80.91.229.2]:48230 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758424AbXHFAVo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 20:21:44 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IHqLr-0000iD-Ro
	for git@vger.kernel.org; Mon, 06 Aug 2007 02:21:39 +0200
Received: from host-89-229-8-65.torun.mm.pl ([89.229.8.65])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 06 Aug 2007 02:21:39 +0200
Received: from jnareb by host-89-229-8-65.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 06 Aug 2007 02:21:39 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-8-65.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55093>

[Uwe Kleine-K=F6nig <ukleinek@informatik.uni-freiburg.de>,
 git@vger.kernel.org]

Uwe Kleine-K=F6nig wrote:

> Without this patch I'm not able to properly send emails as I have a
> non-ascii character in my name.

Nice.

> The former version tried to fix-up the real name part with double quo=
tes
> if it includes a '.'. =A0I removed this as rfc2047 can handle a dot, =
too.

Not nice. I'd rather use double quotes if rfc2047 is not needed.
It means:
 - no quotes for us-ascii name, without '.'
 - quotes for us-ascii name with '.' and perhaps other forbidden charac=
ters
   like '"' or something
 - full rfc2047 quoting if name contains characters outside us-ascii.

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
