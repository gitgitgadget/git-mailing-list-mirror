From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: Re: [PATCH] send-email: Honour SMTP domain when using TLS
Date: Sun, 16 Oct 2011 00:18:00 -0400
Message-ID: <B691D22B-2FB3-407B-A986-EECB97ED29B0@gernhardtsoftware.com>
References: <1318668292-13818-1-git-send-email-mattjd@gmail.com> <7v62jpvc8f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Matthew Daley <mattjd@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 16 06:18:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFIAv-0005jD-Ho
	for gcvg-git-2@lo.gmane.org; Sun, 16 Oct 2011 06:18:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750927Ab1JPESF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Oct 2011 00:18:05 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:33452 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750765Ab1JPESE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Oct 2011 00:18:04 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 24B111FFC6D7; Sun, 16 Oct 2011 04:17:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.5 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [10.10.10.10] (cpe-74-65-60-43.rochester.res.rr.com [74.65.60.43])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id AB19B1FFC6D7;
	Sun, 16 Oct 2011 04:17:50 +0000 (UTC)
In-Reply-To: <7v62jpvc8f.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1251.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183686>


On Oct 15, 2011, at 11:36 PM, Junio C Hamano wrote:

> Matthew Daley <mattjd@gmail.com> writes:
> 
>> git-send-email sends two SMTP EHLOs when using TLS encryption, however
>> only the first, unencrypted EHLO uses the SMTP domain that can be
>> optionally specified by the user (--smtp-domain).  This is because the
>> call to hello() that produces the second, encrypted EHLO does not pass
>> the SMTP domain as an argument, and hence a default of
>> 'localhost.localdomain' is used instead.
>> 
>> Fix by passing in the SMTP domain in this call.
>> 
>> Signed-off-by: Matthew Daley <mattjd@gmail.com>
> 
> Sounds sensible, thanks.
> 
> Brian, who did 69cf7bf (send-email: Cleanup smtp-domain and add config,
> 2010-04-10) to make the initial hello use $smtp_domain, could you take a
> quick look and an Ack?

It does look sensible to me, but I wasn't the one who added all the HELO work.  I mostly was mucking about with variable names and how they got set.  Jari Aalto added them originally in 134550f.

~~ Brian