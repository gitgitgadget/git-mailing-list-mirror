From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] rebase -i -p: use rerere to resolve conflicts if enabled
Date: Mon, 18 Jun 2012 21:06:36 +0200
Message-ID: <4FDF7C3C.90300@kdbg.org>
References: <1339769855-94161-1-git-send-email-ddkilzer@kilzer.net> <7vwr38bmj5.fsf@alter.siamese.dyndns.org> <B4036488-1ECA-41C9-BD97-B2ABD116D54C@kilzer.net> <7vd34z96lv.fsf@alter.siamese.dyndns.org> <76A6615B-5758-4D67-A556-2EE131FF7B20@kilzer.net> <7vmx427aj0.fsf@alter.siamese.dyndns.org> <1917D067-6FB3-4393-B178-BBE36B4B5D4E@kilzer.net> <4FDE2252.5030802@kdbg.org> <B5E2DD4F-4EEB-4440-A149-DD718B0C2EFD@kilzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: David Kilzer <ddkilzer@kilzer.net>
X-From: git-owner@vger.kernel.org Mon Jun 18 21:06:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SghHh-0001j1-Dg
	for gcvg-git-2@plane.gmane.org; Mon, 18 Jun 2012 21:06:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752873Ab2FRTGk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jun 2012 15:06:40 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:17174 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752114Ab2FRTGk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jun 2012 15:06:40 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id EC7EC13004B;
	Mon, 18 Jun 2012 21:02:02 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id C7E2F19F6E2;
	Mon, 18 Jun 2012 21:06:36 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120421 Thunderbird/12.0
In-Reply-To: <B5E2DD4F-4EEB-4440-A149-DD718B0C2EFD@kilzer.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200159>

Am 17.06.2012 23:30, schrieb David Kilzer:
> On Jun 17, 2012, at 11:30 AM, Johannes Sixt wrote:
> 
>> Am 17.06.2012 15:46, schrieb David Kilzer:
>>> If it could be guaranteed that all changes in a merge commit would be
>>> preserved when running "git rebase -i -p" with rerere.autoupdate
>>> enabled, I think that would be an argument for not returning control
>>> to the user during the rebase operation.  However, changes to
>>> non-conflicted files in a merge commit are currently lost in this
>>> case, so it would be too dangerous to enable this behavior now.
>>
>> You can test this patch:
>>
>>  git://repo.or.cz/git/mingw/j6t.git preserve-merges-by-cherry-pick
>>
>> I think it suits you needs unless you run into the one use-case where
>> the patch is a regression (as documented by the new test_expect_failure
>> in the test suite).
> 
> 
> I'd love to try it, but I'm running into an issue pulling the repository:
> 
> $ git clone git://repo.or.cz/git/mingw/j6t.git -b preserve-merges-by-cherry-pick j6t.git
> Cloning into 'j6t.git'...
> remote: error: Could not read 942cf39b9a36ae27a4377d22093827ef4df25239
> remote: fatal: Failed to traverse parents of commit 051ba02462dd65a0ceb3e527a75f24416378880f
> remote: aborting due to possible repository corruption on the remote side.
> fatal: early EOF
> fatal: index-pack failed

Don't do that then ;) Enter your favorite git.git clone, then

  git pull git://repo.or.cz/git/mingw/j6t.git preserve-merges-by-cherry-pick

should work like a charm. But I've now removed the branches that
needed the missing commit, and your command should work as well.

-- Hannes
