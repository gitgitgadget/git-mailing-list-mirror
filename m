From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] builtins: search builtin commands via binary search.
Date: Sat, 27 Jul 2013 11:13:59 +0200
Message-ID: <m2k3kc4b6w.fsf@linux-m68k.org>
References: <1374871850-24323-1-git-send-email-stefanbeller@googlemail.com>
	<20130726205737.GI14690@google.com> <51F38997.9010507@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Eric Sunshine <sunshine@sunshineco.com>
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Sat Jul 27 11:14:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V30Zv-00068L-3d
	for gcvg-git-2@plane.gmane.org; Sat, 27 Jul 2013 11:14:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105Ab3G0JOO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Jul 2013 05:14:14 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:49234 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751042Ab3G0JON (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jul 2013 05:14:13 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3c2M0s1qlSz3hhmx;
	Sat, 27 Jul 2013 11:14:05 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3c2M0s1g12zbc02;
	Sat, 27 Jul 2013 11:14:05 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id NpD0JQzViWf0; Sat, 27 Jul 2013 11:14:03 +0200 (CEST)
X-Auth-Info: itEWtEPeqhM4/Tv54xXJRI0WMlexSzc5dBCDVhLbv9Q=
Received: from linux.local (ppp-93-104-141-187.dynamic.mnet-online.de [93.104.141.187])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Sat, 27 Jul 2013 11:14:03 +0200 (CEST)
Received: by linux.local (Postfix, from userid 501)
	id 2B64614E422; Sat, 27 Jul 2013 11:14:00 +0200 (CEST)
X-Yow: YOW!!
In-Reply-To: <51F38997.9010507@googlemail.com> (Stefan Beller's message of
	"Sat, 27 Jul 2013 10:49:27 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231232>

Stefan Beller <stefanbeller@googlemail.com> writes:

> My approach would have been:
>
> sorted_internal_cmds: git.c
> 	{ awk '/cmd_struct commands/,/};/ { if (match($2,/"/)) print $2 }' <git.c >builtin.actual && \
> 	sort <builtin.actual >builtin.expect && \
> 	cmp -s builtin.expect builtin.actual && \
> 	rm builtin.expect builtin.actual \
> 	}

You need a semicolon before the closing }.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
