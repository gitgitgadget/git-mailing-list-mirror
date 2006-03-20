From: Alexandre Julliard <julliard@winehq.org>
Subject: Re: [PATCH] ls-files: Don't require exclude files to end with a newline.
Date: Mon, 20 Mar 2006 10:14:01 +0100
Message-ID: <87d5ghbhra.fsf@wine.dyndns.org>
References: <8764mccaji.fsf@wine.dyndns.org>
	<20060319212911.GD18185@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 20 10:14:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FLGTP-0006Vc-Aq
	for gcvg-git@gmane.org; Mon, 20 Mar 2006 10:14:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932260AbWCTJOh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Mar 2006 04:14:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932264AbWCTJOh
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Mar 2006 04:14:37 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:19408 "EHLO
	mail.codeweavers.com") by vger.kernel.org with ESMTP
	id S932260AbWCTJOg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Mar 2006 04:14:36 -0500
Received: from adsl-84-227-79-142.adslplus.ch ([84.227.79.142] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1FLGSi-0004SG-SA; Mon, 20 Mar 2006 03:14:06 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 3522F4F657; Mon, 20 Mar 2006 10:14:02 +0100 (CET)
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060319212911.GD18185@pasky.or.cz> (Petr Baudis's message of
	"Sun, 19 Mar 2006 22:29:11 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/22.0.50 (gnu/linux)
X-SA-Exim-Connect-IP: 84.227.79.142
X-SA-Exim-Mail-From: julliard@winehq.org
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on mail
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=AWL,BAYES_00,
	SPF_HELO_SOFTFAIL autolearn=no version=3.0.3
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on mail.codeweavers.com)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17745>

Petr Baudis <pasky@suse.cz> writes:

> Dear diary, on Sat, Mar 18, 2006 at 11:27:45AM CET, I got a letter
> where Alexandre Julliard <julliard@winehq.org> said that...
>> Without this patch, the last line of an exclude file is silently
>> ignored if it doesn't end with a newline.
>> 
>> Signed-off-by: Alexandre Julliard <julliard@winehq.org>
>
> $ echo -en "a\nb" | wc -l
> 1
>
> In UNIX, a line is a string terminated by a newline, therefore the blob
> past the last newline character is not really a line at all. ;-)
>
> Perhaps a warning might be in order. Why don't you just add the trailing
> newline to the file?

Of course I can do that, but I think that if a user entered something
on the last line it's a safe bet they didn't mean for it to be
ignored; and since it's trivial to DTRT here, I don't see why we
shouldn't.

-- 
Alexandre Julliard
julliard@winehq.org
