From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH] move MAXDEPTH definition to the cache.h
Date: Tue, 20 Jan 2015 20:25:48 +0100
Message-ID: <54BEABBC.9070302@web.de>
References: <1421777797-14781-1-git-send-email-kuleshovmail@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alexander Kuleshov <kuleshovmail@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 20 20:26:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDeR6-0006Up-Jt
	for gcvg-git-2@plane.gmane.org; Tue, 20 Jan 2015 20:26:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752757AbbATTZ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2015 14:25:56 -0500
Received: from mout.web.de ([212.227.15.14]:62285 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752621AbbATTZz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2015 14:25:55 -0500
Received: from macce.local ([78.68.171.36]) by smtp.web.de (mrweb004) with
 ESMTPSA (Nemesis) id 0MVpJg-1YFtUG2D5U-00X4Lg; Tue, 20 Jan 2015 20:25:52
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <1421777797-14781-1-git-send-email-kuleshovmail@gmail.com>
X-Provags-ID: V03:K0:DDss9b4gO8P3RB+zTcoodn2tV+P4Gw44ufRve/pa1XRFNcPeVYq
 z0d2UlcjpmILCTm9P2Rstijl/r6sBGn81NikAOBJWI4A74Ess1jkVXfxmNdLt2/X6BQHG1b
 39zBTE5qEzjBnItAbXU3hdHZ2ViM5/jyCIeDnxto+u3RdHKbsiGs2bWypd43AazzIPab6ID
 FBNbGPAyJn/xriAQ52ZAg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262682>

> --- a/cache.h
> +++ b/cache.h
> @@ -1010,6 +1010,7 @@ extern int read_ref(const char *refname, unsigned char *sha1);
>   * Caps and underscores refers to the special refs, such as HEAD,
>   * FETCH_HEAD and friends, that all live outside of the refs/ directory.
>   */

What happened to the comment line ?
Should it go away or better stay ?

When we move the definition to a common file,
it is not 100% clear what MAXDEPTH is about,
and the comment is even more important, I think:

> +/* We allow "recursive" symbolic links. Only within reason, though. */
> +#define MAXDEPTH 5

On the other hand, if we find a better name for that definition,
we may skip the comment.

A first suggestion may be
#define MAXDEPTH_FOR_SYMLINKS 5
but other variants are possible.
