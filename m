From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH] sha1_file.c: fix a declaration-after-statement
Date: Thu, 06 Aug 2015 11:08:31 +0100
Message-ID: <55C3321F.5080801@ramsay1.demon.co.uk>
References: <55C32EA5.2010302@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 06 12:08:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNI6M-0006xD-1C
	for gcvg-git-2@plane.gmane.org; Thu, 06 Aug 2015 12:08:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755376AbbHFKIh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2015 06:08:37 -0400
Received: from mdfmta004.mxout.tch.inty.net ([91.221.169.45]:41277 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753378AbbHFKIh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2015 06:08:37 -0400
Received: from mdfmta004.tch.inty.net (unknown [127.0.0.1])
	by mdfmta004.tch.inty.net (Postfix) with ESMTP id 6BCE4AC40EA;
	Thu,  6 Aug 2015 11:08:35 +0100 (BST)
Received: from mdfmta004.tch.inty.net (unknown [127.0.0.1])
	by mdfmta004.tch.inty.net (Postfix) with ESMTP id CC57BAC4129;
	Thu,  6 Aug 2015 11:08:34 +0100 (BST)
Received: from [10.0.2.15] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mdfmta004.tch.inty.net (Postfix) with ESMTP;
	Thu,  6 Aug 2015 11:08:34 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.8.0
In-Reply-To: <55C32EA5.2010302@ramsay1.demon.co.uk>
X-MDF-HostID: 17
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275423>

On 06/08/15 10:53, Ramsay Jones wrote:
> 
> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> ---
> 
> Hi Junio,
> 
> Sorry for this hit-n-run patch, but I'm in a hurry ... :-D
> Could you please squash this (or something like it) into
> the relevant patch; Thanks!

Ah, I've just read your 'What's Cooking' email and I see that
you are already aware of this.

Sorry for the noise!

ATB,
Ramsay Jones

> 
> [I noticed this simply because I have '-Wdeclaration-after-statement'
> and '-Werror' (among others) set in CFLAGS (via config.mak).]
> 
> HTH
> 
> ATB,
> Ramsay Jones
> 
>  sha1_file.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/sha1_file.c b/sha1_file.c
> index 43386a8..a0af574 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -1462,8 +1462,9 @@ int git_open_noatime(const char *name)
>  	static int sha1_file_open_flag = O_NOATIME;
>  
>  	for (;;) {
> +		int fd;
>  		errno = 0;
> -		int fd = open(name, O_RDONLY | sha1_file_open_flag);
> +		fd = open(name, O_RDONLY | sha1_file_open_flag);
>  		if (fd >= 0)
>  			return fd;
>  
> 
