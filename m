From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] Supplant the "while case ... break ;; esac" idiom
Date: Mon, 24 Sep 2007 08:22:40 +0200
Message-ID: <85ps08k2fj.fsf@lola.goethe.zz>
References: <853ax5mb1j.fsf@lola.goethe.zz> <85myvdktb3.fsf@lola.goethe.zz>
	<7vhcllc9bz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 24 08:22:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZhLI-0005nS-SD
	for gcvg-git-2@gmane.org; Mon, 24 Sep 2007 08:22:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756325AbXIXGWo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2007 02:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756369AbXIXGWn
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Sep 2007 02:22:43 -0400
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:56352 "EHLO
	mail-in-01.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756283AbXIXGWm (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Sep 2007 02:22:42 -0400
Received: from mail-in-13-z2.arcor-online.net (mail-in-13-z2.arcor-online.net [151.189.8.30])
	by mail-in-01.arcor-online.net (Postfix) with ESMTP id 54F57176233;
	Mon, 24 Sep 2007 08:22:41 +0200 (CEST)
Received: from mail-in-04.arcor-online.net (mail-in-04.arcor-online.net [151.189.21.44])
	by mail-in-13-z2.arcor-online.net (Postfix) with ESMTP id 447431B8E4F;
	Mon, 24 Sep 2007 08:22:41 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-020-020.pools.arcor-ip.net [84.61.20.20])
	by mail-in-04.arcor-online.net (Postfix) with ESMTP id 1D4CF1C7360;
	Mon, 24 Sep 2007 08:22:41 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 6F6151C1F3DC; Mon, 24 Sep 2007 08:22:40 +0200 (CEST)
In-Reply-To: <7vhcllc9bz.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Sun\, 23 Sep 2007 15\:20\:48 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.2/4376/Mon Sep 24 04:15:24 2007 on mail-in-04.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59021>

Junio C Hamano <gitster@pobox.com> writes:

> David Kastrup <dak@gnu.org> writes:
>
>> Ok, this is not really what we have been talking about except in
>> one case, but I think it is actually more of an improvement.
>
> Gaah, didn't I say I do NOT think it is an improvement?

Ah, but I am not presuming to speak for you in my commit message and
postings.

>> I consider breaking out of the condition instead of the
>> body od the loop ugly,
>
> Well, as we all know that we disagree on this point, stating
> what you consider one-sidedly here is quite inappropriate.

Hm.  If I create a patch after you basically said "go ahead, I don't
mind, but I consider it unimportant", how am I going to put the
motivation for the patch in the commit message while expressing _your_
opinion?  I thought that using "I" to make clear that it is my
personal view would be doing that.

So what am I supposed to write instead?

"There is no good reason for this patch, but we might as well do it."?

>> and the implied "true" value of the non-matching case is not really
>> obvious to humans at first glance.
>
> It is more like "if you do not know shell".

It is more to take in.  Believe me, I do know shell.

> In other words, I am somewhat disgusted with the first part of
> your proposed commit log message, although I like what the patch
> does ;-).

Could you propose a commit message that would be acceptable to you,
yet not make it appear like a mistake to actually commit the patch?

>> -while case "$#" in 0) break ;; esac
>> +while test "$#" != 0
>>  do
>>      case "$1" in
>>      -a)
>
> And let's not quote "$#".

I kept this as it was originally.  Some authors prefer to quote every
shell variable as a rule in order to avoid stupid syntactic things
happening.  Of course, $# never needs quoting, but I did not want to
change the personal style of the respective authors.  I can make this
consistent if you want to.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
