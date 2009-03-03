From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH v3] send-email: add --confirm option and configuration setting
Date: Tue, 03 Mar 2009 19:11:28 +0900
Message-ID: <20090303191128.6117@nanako3.lavabit.com>
References: <7v1vtfjpad.fsf@gitster.siamese.dyndns.org>
 <1236055938-65407-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 11:13:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeRdH-0004hr-6s
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 11:13:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752834AbZCCKMW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 05:12:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752296AbZCCKMV
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 05:12:21 -0500
Received: from karen.lavabit.com ([72.249.41.33]:50965 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751630AbZCCKMU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 05:12:20 -0500
Received: from d.earth.lavabit.com (d.earth.lavabit.com [192.168.111.13])
	by karen.lavabit.com (Postfix) with ESMTP id 5C1E811B86C;
	Tue,  3 Mar 2009 04:12:18 -0600 (CST)
Received: from 5258.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id 5IUIFR97I9KH; Tue, 03 Mar 2009 04:12:18 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=2aCFjBSXhaN1ldhyvRfySbLiIlTq8x8DJEM219XGCkZNqphHbnUNRK/Ak7t5mK/kLLCqns/X/l9jmq7IKJQ3xeSD7GSKqQjfMzP8fRqU4jFPMw1p9rXSuhE4G0qpIysr3y7pLKxoahRW8Z8b4A8OPM1aT+OaHAA4sNByRArwFkk=;
  h=From:To:Cc:Subject:In-Reply-To:References:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <1236055938-65407-1-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112048>

Quoting Jay Soffian <jaysoffian@gmail.com>:

> Unfortunately, it is impossible to introduce this patch such that it
> helps new users without potentially annoying some existing users. We
> attempt to mitigate the latter by:
>
>  * Allowing the user to set 'git config sendemail.confirm never'
>  * Allowing the user to say 'all' after the first prompt to not be
>    prompted on remaining emails during the same invocation.
>  * Telling the user about the 'sendemail.confirm' setting if it is
>    unconfigured whenever we prompt due to Cc before sending.
>  * Only prompting if no --suppress related options have been passed, as
>    using such an option is likely to indicate an experienced send-email
>    user.
>
> There is a slight fib in message informing the user of the
> sendemail.confirm setting and this is intentional. Setting 'auto'
> differs from leaving sendemail.confirm unset in two ways: 1) 'auto'
> obviously squelches the informational message; 2) 'auto' prompts when
> the Cc list has been expanded even in the presence of a --suppress
> related option, where leaving sendemail.confirm unset does not. This is
> intentional to keep the message simple, and to avoid adding another
> sendemail.confirm value ('auto-except-suppress'?).

For what it's worth, I think this much more carefully addresses the issues to migrate existing users by giving adequate help where it matters than the previous patches.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
