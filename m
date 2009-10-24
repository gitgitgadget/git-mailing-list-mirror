From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] tar: on extract, -o is --no-same-owner
Date: Sat, 24 Oct 2009 11:49:10 +0200
Message-ID: <m28wf1unop.fsf@whitebox.home>
References: <1256328943-22136-1-git-send-email-rep.dot.nop@gmail.com>
	<20091023202524.GE4615@mx.loc> <20091023210648.GA23122@mx.loc>
	<7vocnxajj6.fsf@alter.siamese.dyndns.org>
	<20091024091758.GF4615@mx.loc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, vda.linux@googlemail.com,
	busybox@busybox.net, git@vger.kernel.org
To: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 24 11:49:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1dFQ-000619-O9
	for gcvg-git-2@lo.gmane.org; Sat, 24 Oct 2009 11:49:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752130AbZJXJtL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Oct 2009 05:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752034AbZJXJtL
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Oct 2009 05:49:11 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:38779 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752003AbZJXJtK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Oct 2009 05:49:10 -0400
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id DE40C1C001E1;
	Sat, 24 Oct 2009 11:49:11 +0200 (CEST)
X-Auth-Info: JFtc626pY3m8wEVFRkAemd6aQMytoE4Na+xWff/ZK64=
Received: from whitebox.home (DSL01.83.171.146.84.ip-pool.NEFkom.net [83.171.146.84])
	by mail.mnet-online.de (Postfix) with ESMTP id D2430902BA;
	Sat, 24 Oct 2009 11:49:11 +0200 (CEST)
Received: by whitebox.home (Postfix, from userid 501)
	id 358FE1E5379; Sat, 24 Oct 2009 11:49:11 +0200 (CEST)
X-Yow: I love FRUIT PICKERS!!
In-Reply-To: <20091024091758.GF4615@mx.loc> (Bernhard Reutner-Fischer's
	message of "Sat, 24 Oct 2009 11:17:58 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131154>

Bernhard Reutner-Fischer <rep.dot.nop@gmail.com> writes:

> On Fri, Oct 23, 2009 at 02:26:53PM -0700, Junio C Hamano wrote:
>>Bernhard Reutner-Fischer <rep.dot.nop@gmail.com> writes:
>>
>>> On Fri, Oct 23, 2009 at 10:25:24PM +0200, Bernhard Reutner-Fischer wrote:
>>>>On Fri, Oct 23, 2009 at 10:15:43PM +0200, Bernhard Reutner-Fischer wrote:
>>>>>GNU tar-1.22 handles 'o' as no-same-owner only on extract,
>>>>>on create, 'o' would be --old-archive.
>>>>
>>>>FYI this was prompted by:
>>>>
>>>>Signed-off-by: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>
>>>>
>>>>diff -rdup git-1.6.5.oorig/templates/Makefile git-1.6.5/templates/Makefile
>>>>--- git-1.6.5.oorig/templates/Makefile	2009-10-11 03:42:04.000000000 +0200
>>>>+++ git-1.6.5/templates/Makefile	2009-10-23 21:43:06.000000000 +0200
>>>>@@ -50,4 +50,4 @@ clean:
>>>> install: all
>>>> 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(template_instdir_SQ)'
>>>> 	(cd blt && $(TAR) cf - .) | \
>>>>-	(cd '$(DESTDIR_SQ)$(template_instdir_SQ)' && umask 022 && $(TAR) xfo -)
>>>>+	(cd '$(DESTDIR_SQ)$(template_instdir_SQ)' && umask 022 && $(TAR) x --no-numeric-owner -f -)
>>>
>>> argh, sorry! --no-same-owner of course.
>>
>>Either way, your change would break non-GNU tar implementations that are
>>properly POSIX.1, isn't it?
>
> I suppose xf - -o would work?

Isn't that the same as 'xfo -'?

(tar isn't specified by POSIX, btw.)

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
