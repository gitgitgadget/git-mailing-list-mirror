From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3 1/6] alias.c: replace `git_config()` with `git_config_get_string()`
Date: Mon, 21 Jul 2014 14:52:37 +0200
Message-ID: <vpq8unmeuwa.fsf@anie.imag.fr>
References: <1405941145-12120-1-git-send-email-tanayabh@gmail.com>
	<1405941145-12120-2-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 21 14:52:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9D5H-0005Jn-3B
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jul 2014 14:52:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754607AbaGUMwr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2014 08:52:47 -0400
Received: from mx2.imag.fr ([129.88.30.17]:44485 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754141AbaGUMwq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2014 08:52:46 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s6LCqZIx011256
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 21 Jul 2014 14:52:35 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s6LCqbj3024101;
	Mon, 21 Jul 2014 14:52:37 +0200
In-Reply-To: <1405941145-12120-2-git-send-email-tanayabh@gmail.com> (Tanay
	Abhra's message of "Mon, 21 Jul 2014 04:12:20 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 21 Jul 2014 14:52:35 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s6LCqZIx011256
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1406551958.08438@yXSpuo6EHIlwv3KoMMBMrw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253958>

Tanay Abhra <tanayabh@gmail.com> writes:

> --- a/alias.c
> +++ b/alias.c
> @@ -1,26 +1,13 @@
>  #include "cache.h"
>  
> -static const char *alias_key;
> -static char *alias_val;
> -
> -static int alias_lookup_cb(const char *k, const char *v, void *cb)
> -{
> -	const char *name;
> -	if (skip_prefix(k, "alias.", &name) && !strcmp(name, alias_key)) {
> -		if (!v)
> -			return config_error_nonbool(k);
> -		alias_val = xstrdup(v);
> -		return 0;
> -	}
> -	return 0;
> -}
> -
> -char *alias_lookup(const char *alias)
> +char *alias_lookup(const char* alias)

Style: keep the * stuck to alias.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
