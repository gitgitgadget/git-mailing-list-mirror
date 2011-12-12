From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Breakage (?) in configure and git_vsnprintf()
Date: Mon, 12 Dec 2011 10:30:27 +0100
Message-ID: <m262hmgmrw.fsf@igel.home>
References: <4EE4F97B.9000202@alum.mit.edu>
	<20111212064305.GA16511@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	git discussion list <git@vger.kernel.org>,
	Michal Rokos <michal.rokos@nextsoft.cz>,
	Brandon Casey <casey@nrlssc.navy.mil>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 12 10:30:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ra2Dc-0002le-0a
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 10:30:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752258Ab1LLJah (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 04:30:37 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:38139 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752085Ab1LLJaf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 04:30:35 -0500
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 08C4D1801969;
	Mon, 12 Dec 2011 10:30:28 +0100 (CET)
X-Auth-Info: gbe+I2aGze+tXTxSv2VZweChNKnYHhvB7N1f8vnnEz0=
Received: from igel.home (ppp-88-217-124-61.dynamic.mnet-online.de [88.217.124.61])
	by mail.mnet-online.de (Postfix) with ESMTPA id 52F371C0012D;
	Mon, 12 Dec 2011 10:30:28 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id 03E31CA29C; Mon, 12 Dec 2011 10:30:27 +0100 (CET)
X-Yow: All of life is a blur of Republicans and meat!
In-Reply-To: <20111212064305.GA16511@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 12 Dec 2011 01:43:05 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.92 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186901>

Jeff King <peff@peff.net> writes:

>  	if (maxsize > 0) {
> -		ret = vsnprintf(str, maxsize-SNPRINTF_SIZE_CORR, format, ap);
> +		va_copy(cp, ap);
> +		ret = vsnprintf(str, maxsize-SNPRINTF_SIZE_CORR, format, cp);

You also need to call va_end on the copy.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
