From: Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [PATCH] config.c: mark error and warnings strings for translation
Date: Thu, 31 Jul 2014 17:41:21 +0530
Message-ID: <53DA3269.40901@gmail.com>
References: <1406806283-21571-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jul 31 14:11:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCpCi-000831-V3
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jul 2014 14:11:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750868AbaGaMLZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2014 08:11:25 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:56270 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750781AbaGaMLY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2014 08:11:24 -0400
Received: by mail-pd0-f172.google.com with SMTP id ft15so3383741pdb.31
        for <git@vger.kernel.org>; Thu, 31 Jul 2014 05:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=NGBICb1kWz6YCR262hRG9DouUtCemNd7/R2sQllql8E=;
        b=dLfFs+uNcifeYnHqAu1QWDrlOB0U0wJXSOdpNqt4QCctGO2tibig3UoQW9LI4bQLeH
         yw9q3OYUkWokOTyHGavc/mJwsQAU1NcvQkZDH/NYO9X+/jJ8LX5RsX3MvRdtqqD4OlgR
         ME0ztyx9qJ0RUxFQFkUvkZGG4yGr325Nt6GhLWMBXKj1StrVdnT9U2fhzscUBFodjPHU
         PNXi8IMjHDydNPan6otU6LuibDjNdGyQC4DL2yViSZJN8dcn9uUy5tDnKS2rmbV4VZIQ
         mafAUmSceVOttL7DW3KcRab3yJsnlbSCfIYg/EcNCgs9i5bBJBp/tnftx934s1XmxSwj
         GeuA==
X-Received: by 10.70.126.229 with SMTP id nb5mr11768265pdb.18.1406808684038;
        Thu, 31 Jul 2014 05:11:24 -0700 (PDT)
Received: from [127.0.0.1] ([223.229.21.143])
        by mx.google.com with ESMTPSA id bl12sm18578384pac.44.2014.07.31.05.11.21
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 31 Jul 2014 05:11:23 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <1406806283-21571-1-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254560>

On 7/31/2014 5:01 PM, Matthieu Moy wrote:
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
> Noticed while reviewing Tanay's patches, but this one is independant
> from his series, both syntactically and semantically.
> 
>  config.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/config.c b/config.c
> index a191328..76eeb63 100644
> --- a/config.c
> +++ b/config.c
> @@ -457,9 +457,9 @@ static int git_parse_source(config_fn_t fn, void *data)
>  			break;
>  	}
>  	if (cf->die_on_error)
> -		die("bad config file line %d in %s", cf->linenr, cf->name);
> +		die(_("bad config file line %d in %s"), cf->linenr, cf->name);
>  	else
> -		return error("bad config file line %d in %s", cf->linenr, cf->name);
> +		return error(_("bad config file line %d in %s"), cf->linenr, cf->name);

Can I package your patch with mine in which I am going to change the
error message to print the variable name also?

>  }
>  
>  static int parse_unit_factor(const char *end, uintmax_t *val)
> @@ -575,9 +575,9 @@ static void die_bad_number(const char *name, const char *value)
>  		value = "";
>  
>  	if (cf && cf->name)
> -		die("bad numeric config value '%s' for '%s' in %s: %s",
> +		die(_("bad numeric config value '%s' for '%s' in %s: %s"),
>  		    value, name, cf->name, reason);
> -	die("bad numeric config value '%s' for '%s': %s", value, name, reason);
> +	die(_("bad numeric config value '%s' for '%s': %s"), value, name, reason);
>  }
>  
>  int git_config_int(const char *name, const char *value)
> @@ -662,7 +662,7 @@ int git_config_pathname(const char **dest, const char *var, const char *value)
>  		return config_error_nonbool(var);
>  	*dest = expand_user_path(value);
>  	if (!*dest)
> -		die("Failed to expand user dir in: '%s'", value);
> +		die(_("Failed to expand user dir in: '%s'"), value);

nit : error messages start with a small letter. same case below for "Invalid". ;)

>  	return 0;
>  }
>  
> @@ -740,7 +740,7 @@ static int git_default_core_config(const char *var, const char *value)
>  		if (level == -1)
>  			level = Z_DEFAULT_COMPRESSION;
>  		else if (level < 0 || level > Z_BEST_COMPRESSION)
> -			die("bad zlib compression level %d", level);
> +			die(_("bad zlib compression level %d"), level);
>  		zlib_compression_level = level;
>  		zlib_compression_seen = 1;
>  		return 0;
> @@ -751,7 +751,7 @@ static int git_default_core_config(const char *var, const char *value)
>  		if (level == -1)
>  			level = Z_DEFAULT_COMPRESSION;
>  		else if (level < 0 || level > Z_BEST_COMPRESSION)
> -			die("bad zlib compression level %d", level);
> +			die(_("bad zlib compression level %d"), level);
>  		core_compression_level = level;
>  		core_compression_seen = 1;
>  		if (!zlib_compression_seen)
> @@ -873,7 +873,7 @@ static int git_default_core_config(const char *var, const char *value)
>  		else if (!strcmp(value, "link"))
>  			object_creation_mode = OBJECT_CREATION_USES_HARDLINKS;
>  		else
> -			die("Invalid mode for object creation: %s", value);
> +			die(_("Invalid mode for object creation: %s"), value);
>  		return 0;
>  	}
>  
> @@ -1173,7 +1173,7 @@ int git_config_early(config_fn_t fn, void *data, const char *repo_config)
>  
>  	switch (git_config_from_parameters(fn, data)) {
>  	case -1: /* error */
> -		die("unable to parse command-line config");
> +		die(_("unable to parse command-line config"));
>  		break;
>  	case 0: /* found nothing */
>  		break;
> @@ -1514,7 +1514,7 @@ static int store_aux(const char *key, const char *value, void *cb)
>  	case KEY_SEEN:
>  		if (matches(key, value)) {
>  			if (store.seen == 1 && store.multi_replace == 0) {
> -				warning("%s has multiple values", key);
> +				warning(_("%s has multiple values"), key);
>  			}
>  
>  			ALLOC_GROW(store.offset, store.seen + 1,
> 
