From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH v3] MSVC: fix t0040-parse-options crash
Date: Sat, 29 Mar 2014 22:34:50 +0100
Message-ID: <87ha6gpu2t.fsf@igel.home>
References: <1396008298-1434-1-git-send-email-marat@slonopotamus.org>
	<1396123762-28673-1-git-send-email-marat@slonopotamus.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Marat Radchenko <marat@slonopotamus.org>
X-From: git-owner@vger.kernel.org Sat Mar 29 22:35:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WU0u4-0004J5-3z
	for gcvg-git-2@plane.gmane.org; Sat, 29 Mar 2014 22:35:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752595AbaC2Vez (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Mar 2014 17:34:55 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:40121 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752007AbaC2Vez (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Mar 2014 17:34:55 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3fxCrX661Dz3hhwp;
	Sat, 29 Mar 2014 22:34:51 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3fxCrW2spSzbbt1;
	Sat, 29 Mar 2014 22:34:51 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id 0ncsCJDjnOB0; Sat, 29 Mar 2014 22:34:50 +0100 (CET)
X-Auth-Info: R/hOWgmX2sMTmbU+w2jZ9av8giBa0OTzvfDpK9Yltmw=
Received: from igel.home (ppp-188-174-150-178.dynamic.mnet-online.de [188.174.150.178])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Sat, 29 Mar 2014 22:34:50 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
	id 78F222C3890; Sat, 29 Mar 2014 22:34:50 +0100 (CET)
X-Yow: Feel th' WHIRLING BUFFERS buffing away all that stress...
 Years of ROAD TAR gently washing away...
In-Reply-To: <1396123762-28673-1-git-send-email-marat@slonopotamus.org> (Marat
	Radchenko's message of "Sun, 30 Mar 2014 00:09:22 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245441>

Marat Radchenko <marat@slonopotamus.org> writes:

> diff --git a/test-parse-options.c b/test-parse-options.c
> index 434e8b8..6f6c656 100644
> --- a/test-parse-options.c
> +++ b/test-parse-options.c
> @@ -60,7 +60,7 @@ int main(int argc, char **argv)
>  		OPT_STRING('o', NULL, &string, "str", "get another string"),
>  		OPT_NOOP_NOARG(0, "obsolete"),
>  		OPT_SET_PTR(0, "default-string", &string,
> -			"set string to default", (unsigned long)"default"),
> +			"set string to default", (intptr_t)"default"),

Why doesn't OPT_SET_PTR take a pointer?

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
