From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH 2/2] Makefile: work around ksh's failure to handle missing list argument to for loop
Date: Mon, 05 Jul 2010 22:00:12 +0200
Message-ID: <m2hbkd66nn.fsf@igel.home>
References: <80typu1ozt.fsf@tiny.isode.net>
	<8YdP-GcDDflOVZnykNVIGceOm01bqeg9PDvdgIfgqUnh29RKC-6Qi8_KBVoqLIt5iyt7g1TX5l96M5KyLrfOqg@cipher.nrlssc.navy.mil>
	<4C30D4D5.3020900@drmicha.warpmail.net>
	<4C31796E.9050109@viscovery.net>
	<7vy6dpyeqf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Brandon Casey <casey@nrlssc.navy.mil>, git@vger.kernel.org,
	PWalker752@aol.com, newsletter@dirk.my1.cc,
	bruce.stephens@isode.com, Brandon Casey <drafnel@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 05 22:00:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVrqI-0006qw-Qs
	for gcvg-git-2@lo.gmane.org; Mon, 05 Jul 2010 22:00:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755675Ab0GEUAT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jul 2010 16:00:19 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:43042 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753202Ab0GEUAQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jul 2010 16:00:16 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 2A5871C157C0;
	Mon,  5 Jul 2010 22:00:13 +0200 (CEST)
Received: from igel.home (ppp-88-217-100-141.dynamic.mnet-online.de [88.217.100.141])
	by mail.mnet-online.de (Postfix) with ESMTP id 1353A1C001CB;
	Mon,  5 Jul 2010 22:00:13 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id E244FCA297; Mon,  5 Jul 2010 22:00:12 +0200 (CEST)
X-Yow: As President I have to go vacuum my coin collection!
In-Reply-To: <7vy6dpyeqf.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 05 Jul 2010 11:18:16 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150291>

Junio C Hamano <gitster@pobox.com> writes:

> +	$(foreach p,$(REMOTE_CURL_ALIASES), \
> +		{ \
> +		$(RM) "$$execdir/$p" && \
> +		ln "$$execdir/git-remote-http$X" "$$execdir/$p" 2>/dev/null || \
> +		ln -s "git-remote-http$X" "$$execdir/$p" 2>/dev/null || \
> +		cp "$$execdir/git-remote-http$X" "$$execdir/$p" || exit; \
> +		} && ) : \
                       ^^
>  	./check_bindir "z$$bindir" "z$$execdir" "$$bindir/git-add$X"

Missing && at the end of the preceding line (otherwise the last line is
effectively commented out).

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
