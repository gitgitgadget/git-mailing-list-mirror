From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH v2 2/2] convert: Stream from fd to required clean filter instead of mmap
Date: Sun, 17 Aug 2014 13:03:43 +0200
Message-ID: <871tsfwf74.fsf@igel.home>
References: <1407303134-16635-1-git-send-email-prohaska@zib.de>
	<1407303134-16635-3-git-send-email-prohaska@zib.de>
	<20140816102703.GD7857@serenity.lan>
	<FA3F1197-25C5-42E4-9418-1C821D430819@zib.de>
	<874mxc9xp3.fsf@igel.home>
	<7147D39A-66CE-4824-B051-C625789BFFA5@zib.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Scott Chacon <schacon@gmail.com>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Aug 17 13:03:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XIyFf-0000jy-Oy
	for gcvg-git-2@plane.gmane.org; Sun, 17 Aug 2014 13:03:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbaHQLDt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2014 07:03:49 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:59723 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751211AbaHQLDs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2014 07:03:48 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3hbb9D6WKYz3hhsK;
	Sun, 17 Aug 2014 13:03:44 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3hbb9D6FDCz7S6SR;
	Sun, 17 Aug 2014 13:03:44 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id b1jUS8Zjch_N; Sun, 17 Aug 2014 13:03:44 +0200 (CEST)
X-Auth-Info: JVUpza/cckxK3S+s95e82dnIlKk70c3wZKXd1mZwNFg=
Received: from igel.home (ppp-188-174-150-52.dynamic.mnet-online.de [188.174.150.52])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Sun, 17 Aug 2014 13:03:44 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id EF4FE2C38DB; Sun, 17 Aug 2014 13:03:43 +0200 (CEST)
X-Yow: Mr and Mrs PED, can I borrow 26.7% of the RAYON TEXTILE production
 of the INDONESIAN archipelago?
In-Reply-To: <7147D39A-66CE-4824-B051-C625789BFFA5@zib.de> (Steffen Prohaska's
	message of "Sun, 17 Aug 2014 12:08:30 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.93 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255364>

Steffen Prohaska <prohaska@zib.de> writes:

> On Aug 16, 2014, at 7:00 PM, Andreas Schwab <schwab@linux-m68k.org> wrote:
>
>> Steffen Prohaska <prohaska@zib.de> writes:
>> 
>>> The test should confirm that the the file that is added is not mmapped to
>>> memory.
>> 
>> RSS doesn't tell you that.  You can mmap a big file without RSS getting
>> bigger.
>
> All data are accessed after mapping, so RSS should be fine.

RSS can shink any time when memory is tight.

> The test always did what I expected.

Not a sufficient condition.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
