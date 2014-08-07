From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH v9 3/8] add line number and file name info to `config_set`
Date: Thu, 07 Aug 2014 20:33:40 +0100
Message-ID: <53E3D494.1070606@ramsay1.demon.co.uk>
References: <1407412759-13833-1-git-send-email-tanayabh@gmail.com> <1407412759-13833-4-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Tanay Abhra <tanayabh@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 07 21:33:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFTRc-0005YY-MB
	for gcvg-git-2@plane.gmane.org; Thu, 07 Aug 2014 21:33:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751626AbaHGTdo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2014 15:33:44 -0400
Received: from mdfmta009.mxout.tbr.inty.net ([91.221.168.50]:38891 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750920AbaHGTdo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2014 15:33:44 -0400
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id 148FD384081;
	Thu,  7 Aug 2014 18:55:16 +0100 (BST)
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id D9B1B38407C;
	Thu,  7 Aug 2014 18:55:15 +0100 (BST)
Received: from [192.168.254.10] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP;
	Thu,  7 Aug 2014 18:55:15 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <1407412759-13833-4-git-send-email-tanayabh@gmail.com>
X-MDF-HostID: 4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254990>

On 07/08/14 12:59, Tanay Abhra wrote:
> Store file name and line number for each key-value pair in the cache
> during parsing of the configuration files.
> 
> Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
> ---
>  cache.h  |  5 +++++
>  config.c | 16 ++++++++++++++--
>  2 files changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/cache.h b/cache.h
> index 7292aef..0b1bdfd 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1383,6 +1383,11 @@ extern int git_config_get_bool_or_int(const char *key, int *is_bool, int *dest);
>  extern int git_config_get_maybe_bool(const char *key, int *dest);
>  extern int git_config_get_pathname(const char *key, const char **dest);
>  
> +struct key_value_info {
> +	const char *filename;
> +	int linenr;
> +};
> +

I haven't checked, but does this series now include a user for
this struct outside of config.c? If not, then I think it would
be better to leave the declaration in config.c until it is needed.
(To make it easier to see if it is necessary in the context of the
patch which will make use of it).

ATB,
Ramsay Jones
