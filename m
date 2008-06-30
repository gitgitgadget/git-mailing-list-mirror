From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH] Fix t4017-diff-retval for white-space from wc
Date: Sun, 29 Jun 2008 21:29:18 -0400
Message-ID: <2A25C1B7-2C95-4B9F-AA3A-3FFB653ADBBE@silverinsanity.com>
References: <1214789205-43490-1-git-send-email-benji@silverinsanity.com>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Mon Jun 30 03:30:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KD8Dh-0002GY-6A
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 03:30:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753533AbYF3B3U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2008 21:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753887AbYF3B3U
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 21:29:20 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:45126 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752966AbYF3B3U (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 21:29:20 -0400
Received: from [192.168.1.11] (c-75-75-94-94.hsd1.va.comcast.net [75.75.94.94])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id CB1091FFC023;
	Mon, 30 Jun 2008 01:29:09 +0000 (UTC)
In-Reply-To: <1214789205-43490-1-git-send-email-benji@silverinsanity.com>
X-Mailer: Apple Mail (2.924)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86858>

Sorry about duplicate.  Forgot to remove sendemail.to when testing git- 
send-email.  (Finally tracked down my problems to a bug in  
Term::ReadLine::Perl when the prompt was longer than the terminal  
width.)

~~ Brian

On Jun 29, 2008, at 9:26 PM, Brian Gernhardt wrote:

> Signed-off-by: Brian Gernhardt <benji@silverinsanity.com>
> ---
> t/t4017-diff-retval.sh |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/t/t4017-diff-retval.sh b/t/t4017-diff-retval.sh
> index d748d45..60dd201 100755
> --- a/t/t4017-diff-retval.sh
> +++ b/t/t4017-diff-retval.sh
> @@ -123,7 +123,7 @@ test_expect_success 'check detects leftover  
> conflict markers' '
> 		git --no-pager diff --cached --check >test.out
> 		test $? = 2
> 	) &&
> -	test "$(grep "conflict marker" test.out | wc -l)" = 3 &&
> +	test 3 = $(grep "conflict marker" test.out | wc -l) &&
> 	git reset --hard
> '
>
> -- 
> 1.5.6.105.g6f4b
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
