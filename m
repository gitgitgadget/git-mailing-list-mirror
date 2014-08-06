From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH v8 3/8] add line number and file name info to `config_set`
Date: Wed, 06 Aug 2014 16:49:54 +0100
Message-ID: <53E24EA2.2030807@ramsay1.demon.co.uk>
References: <1407336792-16962-1-git-send-email-tanayabh@gmail.com> <1407336792-16962-4-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Tanay Abhra <tanayabh@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 06 17:50:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XF3TX-0002RA-6y
	for gcvg-git-2@plane.gmane.org; Wed, 06 Aug 2014 17:50:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753410AbaHFPt7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2014 11:49:59 -0400
Received: from mdfmta009.mxout.tch.inty.net ([91.221.169.50]:39547 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753191AbaHFPt6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2014 11:49:58 -0400
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP id EA437128089;
	Wed,  6 Aug 2014 16:49:50 +0100 (BST)
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP id 4D2F61280C0;
	Wed,  6 Aug 2014 16:49:50 +0100 (BST)
Received: from [192.168.254.10] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mdfmta009.tch.inty.net (Postfix) with ESMTP;
	Wed,  6 Aug 2014 16:49:49 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <1407336792-16962-4-git-send-email-tanayabh@gmail.com>
X-MDF-HostID: 22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254872>

On 06/08/14 15:53, Tanay Abhra wrote:
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

Hmm, why was this moved here? As far as I can tell, it is
(still) not needed outside of config.c. What am I missing?

ATB,
Ramsay Jones
