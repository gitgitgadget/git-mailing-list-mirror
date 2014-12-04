From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH 12/13] refs.c: use a bit for ref_update have_old
Date: Thu, 04 Dec 2014 18:00:25 +0100
Message-ID: <87wq67ic46.fsf@igel.home>
References: <1417681763-32334-1-git-send-email-sbeller@google.com>
	<1417681763-32334-13-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: ronniesahlberg@gmail.com, mhagger@alum.mit.edu, jrnieder@gmail.com,
	gitster@pobox.com, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Dec 04 18:00:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwZlh-0004kg-6u
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 18:00:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932847AbaLDRAe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 12:00:34 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:37340 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932795AbaLDRAc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2014 12:00:32 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 3jtjwW5925z3hkrW;
	Thu,  4 Dec 2014 18:00:27 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3jtjwV654bzvh3q;
	Thu,  4 Dec 2014 18:00:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id p4z-8tpqDGhu; Thu,  4 Dec 2014 18:00:26 +0100 (CET)
X-Auth-Info: QKiMpS+eMi0rmsErtvrC95wR17vweaPebxVNR7gPcmwCuamM/3JYBxPcccbJvpP/
Received: from igel.home (host-188-174-211-246.customer.m-online.net [188.174.211.246])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Thu,  4 Dec 2014 18:00:26 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
	id CD1F32C16EB; Thu,  4 Dec 2014 18:00:25 +0100 (CET)
X-Yow: Did you move a lot of KOREAN STEAK KNIVES this trip, Dingy?
In-Reply-To: <1417681763-32334-13-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Thu, 4 Dec 2014 00:29:22 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260766>

Stefan Beller <sbeller@google.com> writes:

> diff --git a/refs.c b/refs.c
> index b54b5b3..2942227 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -3532,7 +3532,7 @@ struct ref_update {
>  	unsigned char new_sha1[20];
>  	unsigned char old_sha1[20];
>  	int flags; /* REF_NODEREF? */
> -	int have_old; /* 1 if old_sha1 is valid, 0 otherwise */
> +	int have_old:1; /* 1 if old_sha1 is valid, 0 otherwise */

A signed one-bit field cannot store a value of 1.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
