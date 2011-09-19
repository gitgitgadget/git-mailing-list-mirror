From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] git-web--browse: invoke kfmclient directly
Date: Mon, 19 Sep 2011 22:44:20 +0200
Message-ID: <m2vcsotg7v.fsf@igel.home>
References: <20110918032933.GA17977@sigill.intra.peff.net>
	<1316341224-4359-1-git-send-email-judge.packham@gmail.com>
	<20110918183846.GA31176@sigill.intra.peff.net>
	<7vvcso9zzi.fsf@alter.siamese.dyndns.org>
	<20110919182049.GA26115@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Chris Packham <judge.packham@gmail.com>, git@vger.kernel.org,
	chriscool@tuxfamily.org, jepler@unpythonic.net
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 19 22:44:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5khd-0004ZJ-0t
	for gcvg-git-2@lo.gmane.org; Mon, 19 Sep 2011 22:44:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756272Ab1ISUo2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Sep 2011 16:44:28 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:57633 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754635Ab1ISUo1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2011 16:44:27 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id DCDD11C0F587;
	Mon, 19 Sep 2011 22:44:22 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.8.164])
	by mail.m-online.net (Postfix) with ESMTP id D7A801C0012C;
	Mon, 19 Sep 2011 22:44:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.8.164]) (amavisd-new, port 10024)
	with ESMTP id 5T5N8ZL7IfNH; Mon, 19 Sep 2011 22:44:21 +0200 (CEST)
Received: from igel.home (ppp-93-104-154-188.dynamic.mnet-online.de [93.104.154.188])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Mon, 19 Sep 2011 22:44:20 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 98F01CA296; Mon, 19 Sep 2011 22:44:20 +0200 (CEST)
X-Yow: Hey, LOOK!!  A pair of SIZE 9 CAPRI PANTS!!  They probably belong to
 SAMMY DAVIS, JR.!!
In-Reply-To: <20110919182049.GA26115@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 19 Sep 2011 14:20:49 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181705>

Jeff King <peff@peff.net> writes:

> On Mon, Sep 19, 2011 at 10:57:37AM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > Hmm. Actually, the one for custom browser commands might need it,
>> > because that one is expected to be a shell snippet. I suspect the
>> > simplest thing is to do something like:
>> >
>> >   eval "$browser_cmd \"\$@\""
>> 
>> Yeah, I agree, and the dq around $browser_cmd is kind of important, too,
>> for that to work and be readable.
>
> Oops, good catch. Probably the most readable version would be:
>
>   eval "\"$browser_cmd\"" '"$@"'

This make the use of eval even more questionable.  If $browser_cmd is
supposed to be whitespace splitted then this won't do it (unless it
contains embedded double quotes).

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
