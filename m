From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: Re: [PATCH] t9501: Skip testing load if we can't detect it
Date: Sat, 6 Feb 2010 15:09:39 -0500
Message-ID: <378C5218-C859-4E82-B39E-40BE5D7A572C@gernhardtsoftware.com>
References: <1265432440-52146-1-git-send-email-brian@gernhardtsoftware.com> <m3eikya9tn.fsf@localhost.localdomain> <0CD6B283-3181-4FAB-A6B2-13AFF9E5071C@gernhardtsoftware.com> <201002061505.13886.jnareb@gmail.com> <7vwryq1aid.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (iPhone Mail 7E18)
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 06 21:09:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdqyZ-0006Ma-Kz
	for gcvg-git-2@lo.gmane.org; Sat, 06 Feb 2010 21:09:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755849Ab0BFUJu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Feb 2010 15:09:50 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:55396 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755400Ab0BFUJu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Feb 2010 15:09:50 -0500
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 3E01A1FFC1CE; Sat,  6 Feb 2010 20:09:43 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.5
Received: from [10.124.230.248] (mobile-166-137-138-213.mycingular.net [166.137.138.213])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id BF9BB1FFC06B;
	Sat,  6 Feb 2010 20:09:40 +0000 (UTC)
In-Reply-To: <7vwryq1aid.fsf@alter.siamese.dyndns.org>
X-Mailer: iPhone Mail (7E18)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139189>

On Feb 6, 2010, at 1:31 PM, Junio C Hamano <gitster@pobox.com> wrote:

> Here is my attempt to reword the commit log message from Brian (the  
> "-1"
> one, squashed into a revert of the one from yesterday, the latter of  
> which
> I already pushed out).  I just added the first paragraph to better  
> justify
> the reason why we are testing the codepath that would never be  
> exercised
> in real life on platforms that lack /proc/loadavg.

Looks good to me.

>    Subject: t9501: Re-fix max load test
>
>    Revert the previous attempt to skip this test on platforms where we
>    currently cannot determine the system load.  We want to make sure  
> that
>    the max-load-limit codepath produces results cleanly, when gitweb  
> is
>    updated and becomes capable of reading the load average by some  
> other
>    method.
>
>    The code to check for load returns 0 if it doesn't know how to find
>    load.  It also checks to see if the current load is higher than the
>    max load.  So to force the script to quit early by setting the  
> maxload
>    variable negative which should work for systems where we can detect
>    load (which should be a positive number) and systems where we can't
>    (where detected load is 0)
>
>    Signed-off-by: Brian Gernhardt <brian@gernhardtsoftware.com>
