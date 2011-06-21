From: Andrew Wong <andrew.w@sohovfx.com>
Subject: Re: [PATCH] stash: Add --clean option to stash and remove all untracked
 files
Date: Tue, 21 Jun 2011 01:08:50 -0400
Message-ID: <4E002762.3050803@sohovfx.com>
References: <1308612986-26593-1-git-send-email-david@porkrind.org> <20110621003852.GB2050@sigill.intra.peff.net> <4DFFF5AA.4030401@porkrind.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: David Caldwell <david@porkrind.org>
X-From: git-owner@vger.kernel.org Tue Jun 21 07:09:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYtDT-0003JR-3x
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 07:09:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751938Ab1FUFJB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jun 2011 01:09:01 -0400
Received: from smtp04.beanfield.com ([76.9.193.173]:52542 "EHLO
	smtp04.beanfield.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751072Ab1FUFJA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2011 01:09:00 -0400
X-Spam-Status: No
X-beanfield-mta04-MailScanner-From: andrew.w@sohovfx.com
X-beanfield-mta04-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-2.9, required 6, autolearn=not spam, ALL_TRUSTED -1.00,
	BAYES_00 -1.90)
X-beanfield-mta04-MailScanner: Found to be clean
X-beanfield-mta04-MailScanner-ID: 1QYtCl-0005Fp-8r
Received: from [24.246.58.202] (helo=ZanarkandMac.local)
	by mta04.beanfield.com with esmtpsa (TLSv1:CAMELLIA256-SHA:256)
	(Exim 4.76)
	(envelope-from <andrew.w@sohovfx.com>)
	id 1QYtCl-0005Fp-8r; Tue, 21 Jun 2011 01:08:51 -0400
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
In-Reply-To: <4DFFF5AA.4030401@porkrind.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176122>

Ah, this patch will be very useful. I actually ran into several 
scenarios before where I wished stash could do exactly this.

On 11-06-20 9:36 PM, David Caldwell wrote:
> On 6/20/11 5:38 PM, Jeff King wrote:
>> Hmm. I think I would call this something like "--untracked", as to me
>> the main function is saving those files, not cleaning them afterwards
>> (the fact that they are cleaned is really just making the untracked-file
>> handling in line with what we do for tracked files; we put the changes
>> in the stash and remove them from the working tree).
>
> I see your point but I thought "--clean" was pretty descriptive of how
> the working dir ended up afterward. Maybe "git stash --everything" (or
> "--all")?
I personally think "--untracked" (and -u) is more intuitive too, since 
it tells you what "git stash" is about to do. i.e. "git stash" is about 
to do the usual stash operation *and* also stash the "untracked" files.
It seems more clear and precise than saying "git will stash my tree to a 
state that is clean", which doesn't exactly tell me how is that 
different from the usual stash.To me, "--clean" might even sounds more 
like "do a stash, and then do a clean", which doesn't make sense.

I would've liked "--all" too, except it reminds me too much of "git 
commit --all", which is just committing all tracked files.

Again, that's just my personal preference.
