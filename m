From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] Change sed i\ usage to something Solaris' sed can handle
Date: Mon, 28 Oct 2013 18:39:47 +0100
Message-ID: <877gcx1eho.fsf@igel.home>
References: <1382909208-7716-1-git-send-email-bdwalton@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: gitster@pobox.com, git@vger.kernel.org
To: Ben Walton <bdwalton@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 28 18:40:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VaqnI-0000oE-Kp
	for gcvg-git-2@plane.gmane.org; Mon, 28 Oct 2013 18:40:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932253Ab3J1Rjz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Oct 2013 13:39:55 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:53138 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932250Ab3J1Rjy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Oct 2013 13:39:54 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3d7jqT6yT8z4KK4B;
	Mon, 28 Oct 2013 18:39:49 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3d7jqT6mKRzbbhg;
	Mon, 28 Oct 2013 18:39:49 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id vW76K9a4pB4k; Mon, 28 Oct 2013 18:39:47 +0100 (CET)
X-Auth-Info: TI0Ha8xwvq+4cA3JEuHU+K2EagjVhSYVw9OOxba4KkA=
Received: from igel.home (ppp-88-217-114-129.dynamic.mnet-online.de [88.217.114.129])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Mon, 28 Oct 2013 18:39:47 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
	id 5597B2C13B1; Mon, 28 Oct 2013 18:39:47 +0100 (CET)
X-Yow: In order to make PLANS for the WEEKEND...so that we can read RESTAURANT
 REVIEWS and decide to GO to that restaurant & then NEVER GO...so we can
 meet a FRIEND after work in a BAR and COMPLAIN about Interior Sect'y
 JAMES WATT until the SUBJECT is changed to NUCLEAR BLACKMAIL...and so
 our RELATIVES can FORCE us to listen to HOCKEY STATISTICS while we
 wait for them to LEAVE on the 7:48....
In-Reply-To: <1382909208-7716-1-git-send-email-bdwalton@gmail.com> (Ben
	Walton's message of "Sun, 27 Oct 2013 21:26:48 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236844>

Ben Walton <bdwalton@gmail.com> writes:

> diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
> index 3fb4b97..0126154 100755
> --- a/t/t4015-diff-whitespace.sh
> +++ b/t/t4015-diff-whitespace.sh
> @@ -145,7 +145,8 @@ test_expect_success 'another test, with --ignore-space-at-eol' 'test_cmp expect
>  test_expect_success 'ignore-blank-lines: only new lines' '
>  	test_seq 5 >x &&
>  	git update-index x &&
> -	test_seq 5 | sed "/3/i \\
> +	test_seq 5 | sed "/3/i\\
> +\
>  " >x &&

Why do you need the \<nl>?  Since it is inside double quotes the shell
will remove it during expansion.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
