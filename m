From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] Makefile: Handle broken curl version number in version check
Date: Fri, 30 Jan 2015 15:50:53 +0100
Message-ID: <87wq44gw4y.fsf@igel.home>
References: <54CA2E84.6090604@statsbiblioteket.dk>
	<1422611554-15393-1-git-send-email-tgc@statsbiblioteket.dk>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: "Tom G. Christensen" <tgc@statsbiblioteket.dk>
X-From: git-owner@vger.kernel.org Fri Jan 30 15:51:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YHCuV-0001aa-Q8
	for gcvg-git-2@plane.gmane.org; Fri, 30 Jan 2015 15:51:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422898AbbA3Ou6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2015 09:50:58 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:39049 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932542AbbA3Ou5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2015 09:50:57 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 3kYhLk2NJpz3hjJ6;
	Fri, 30 Jan 2015 15:50:54 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3kYhLk0BMGzvhMj;
	Fri, 30 Jan 2015 15:50:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id lNecyK-1NIse; Fri, 30 Jan 2015 15:50:53 +0100 (CET)
X-Auth-Info: f6l9VgXi0laL4PBLX2U/OJNefid9YjfcYKNx2FaMKAA6C3THAw781XY91jP+2DQU
Received: from igel.home (ppp-188-174-8-31.dynamic.mnet-online.de [188.174.8.31])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Fri, 30 Jan 2015 15:50:53 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
	id 109102C339A; Fri, 30 Jan 2015 15:50:53 +0100 (CET)
X-Yow: I was in EXCRUCIATING PAIN until I started reading JACK AND JILL
 Magazine!!
In-Reply-To: <1422611554-15393-1-git-send-email-tgc@statsbiblioteket.dk> (Tom
	G. Christensen's message of "Fri, 30 Jan 2015 10:52:34 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263176>

"Tom G. Christensen" <tgc@statsbiblioteket.dk> writes:

> diff --git a/Makefile b/Makefile
> index c44eb3a..69a2ce3 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1035,13 +1035,13 @@ else
>  	REMOTE_CURL_NAMES = $(REMOTE_CURL_PRIMARY) $(REMOTE_CURL_ALIASES)
>  	PROGRAM_OBJS += http-fetch.o
>  	PROGRAMS += $(REMOTE_CURL_NAMES)
> -	curl_check := $(shell (echo 070908; curl-config --vernum) 2>/dev/null | sort -r | sed -ne 2p)
> +	curl_check := $(shell (echo 070908; curl-config --vernum | sed -e '/^70[B-C]/ s/^7/07/') 2>/dev/null | sort -r | sed -ne 2p)

How about 's/^.....$/0&/' ?

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
