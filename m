From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: 'git rebase' silently drops changes?
Date: Sun, 08 Feb 2015 14:49:31 +0100
Message-ID: <54D7696B.3060407@kdbg.org>
References: <87386ispb3.fsf@osv.gnss.ru> <54D68455.5070305@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sebastian Schuberth <sschuberth@gmail.com>,
	Sergey Organov <sorganov@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 08 14:49:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKSF8-0000Ml-8p
	for gcvg-git-2@plane.gmane.org; Sun, 08 Feb 2015 14:49:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752193AbbBHNtg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2015 08:49:36 -0500
Received: from bsmtp7.bon.at ([213.33.87.19]:32761 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751679AbbBHNtf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2015 08:49:35 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 3kgBYm5wVkz5tlB;
	Sun,  8 Feb 2015 14:49:32 +0100 (CET)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 065CF19F922;
	Sun,  8 Feb 2015 14:49:31 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <54D68455.5070305@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263514>

Am 07.02.2015 um 22:32 schrieb Sebastian Schuberth:
> On 06.02.2015 22:28, Sergey Organov wrote:
> 
>> # Now rebase my work.
>> git rebase -f HEAD~1
>>
>> # What? Where is my "Precious" change in "a"???
>> cat a
>> </SCRIPT>
>>
>> I.e., the modification marked [!] was silently lost during rebase!
> 
> Just a wild guess: Maybe because you omitted "-p" / "--preserve-merges"
> from "git rebase"?

No, that would not help. --preserve-merges repeats the merge, but does
not apply the amendment.

It's just how rebase works: It omits merge commits when it linearizes
history.

Sergey, it is impossible for git rebase to decide to which rebased
commit the amendement applies. It doesn't even try to guess. It's the
responsibility of the user to apply the amendment to the correct commit.

-- Hannes
