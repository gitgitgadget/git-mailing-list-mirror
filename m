From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] t6022: Use -eq not = to test output of wc -l
Date: Tue, 16 Nov 2010 08:12:02 +0100
Message-ID: <4CE22EC2.7040603@viscovery.net>
References: <1289251766-48316-1-git-send-email-brian@gernhardtsoftware.com> <7vaalajkiq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Brian Gernhardt <brian@gernhardtsoftware.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 16 08:12:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIFiA-0006Bk-GO
	for gcvg-git-2@lo.gmane.org; Tue, 16 Nov 2010 08:12:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759389Ab0KPHMJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Nov 2010 02:12:09 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:21642 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759386Ab0KPHMI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Nov 2010 02:12:08 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1PIFhz-00036E-9k; Tue, 16 Nov 2010 08:12:03 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 090731660F;
	Tue, 16 Nov 2010 08:12:02 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <7vaalajkiq.fsf@alter.siamese.dyndns.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161545>

Am 11/15/2010 23:21, schrieb Junio C Hamano:
> Brian Gernhardt <brian@gernhardtsoftware.com> writes:
> 
>> When comparing numbers such as "3" to "$(wc -l)", we should check for
>> numerical equality using -eq instead of string equality using = because
>> some implementations of wc output extra whitespace.
>>
>> Signed-off-by: Brian Gernhardt <brian@gernhardtsoftware.com>
>> ---
>>  The alternative would be to use 3 = $(wc -l) (sans quotes), but other parts
>>  of the test used the -eq method.
> 
> ... which looks a tad ugly.
> 
> How about doing something like below after merging Jonathan's fb3340a
> (test-lib: introduce test_line_count to measure files, 2010-10-31) instead?
> 
> -- >8 --
> test_line_count: learn how to read from a pipe

I don't think that any of this (neither Jonathan's nor yours) has any benefit:

- The result is not easier to read.

- Nor are the lines of shell code shorter.

- If something in the pipe requires quoting, you need an extra level of
quotes.

- It doesn't save any messages or fix-ups during review: instead of "do
not quote!" we have to say "use test_line_count!".

Just my opinion.

-- Hannes
