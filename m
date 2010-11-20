From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] git-send-email.perl: Deduplicate "to:" and "cc:" entries with names
Date: Sat, 20 Nov 2010 21:15:35 +0100
Message-ID: <m2mxp3zr88.fsf@igel.home>
References: <1290272809.27951.30.camel@Joe-Laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Joe Perches <joe@perches.com>
X-From: git-owner@vger.kernel.org Sat Nov 20 21:15:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJtqi-0007T7-T8
	for gcvg-git-2@lo.gmane.org; Sat, 20 Nov 2010 21:15:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751967Ab0KTUPj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Nov 2010 15:15:39 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:59321 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751916Ab0KTUPi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Nov 2010 15:15:38 -0500
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 7ECD81C1DA12;
	Sat, 20 Nov 2010 21:15:36 +0100 (CET)
Received: from igel.home (ppp-88-217-101-192.dynamic.mnet-online.de [88.217.101.192])
	by mail.mnet-online.de (Postfix) with ESMTP id 1EBBE1C001C5;
	Sat, 20 Nov 2010 21:15:36 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id DD7FCCA2A0; Sat, 20 Nov 2010 21:15:35 +0100 (CET)
X-Yow: I brought my BOWLING BALL - and some DRUGS!!
In-Reply-To: <1290272809.27951.30.camel@Joe-Laptop> (Joe Perches's message of
	"Sat, 20 Nov 2010 09:06:49 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2.90 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161842>

Joe Perches <joe@perches.com> writes:

> diff --git a/git-send-email.perl b/git-send-email.perl
> index f68ed5a..1ae5fbf 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -960,7 +960,7 @@ sub maildomain {
>  sub send_message {
>  	my @recipients = unique_email_list(@to);
>  	@cc = (grep { my $cc = extract_valid_address($_);
> -		      not grep { $cc eq $_ } @recipients
> +		      not grep { $cc eq $_ || $_ =~ /<${cc}>$/ } @recipients
                                                    /<\Q${cc}\E>$/

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
