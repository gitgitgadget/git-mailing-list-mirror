Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 224842095D
	for <e@80x24.org>; Wed, 22 Mar 2017 21:46:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751250AbdCVVqr (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 17:46:47 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:36262 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751178AbdCVVqp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 17:46:45 -0400
Received: by mail-pg0-f46.google.com with SMTP id g2so112630077pge.3
        for <git@vger.kernel.org>; Wed, 22 Mar 2017 14:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=T89oyjNmaMmTsQDUNOpka6O5hxUFwibzvGHggRdqNpE=;
        b=eqHAVNlE9flnyXS+TnonCucUZ2IS3FZUnjJ5AFMLlcvu+WGRUvVIDGN6UFe+oMhKPZ
         0FzCZaIEmMOOI82G2G2dbL1j/MBuoPnwaogDI165xWePeOqtb7FtWVpvOnThtlntbomU
         aTdz2k/IQqRewo0Rv3T9bRTzwKEUsYWzR++u0TaDQahIN8GlYUz+BZCDuVlGy8vrW+TJ
         PVLnZ2opH+Jzzwj1MV6lp7Y0yuhxKJSszr3Fp3tIfJha2ufPD0akozsd4W7+3/6QxAQl
         R9ruCtl005REDGVPYYuAI0zUazHiivbJ1JNX3g1rC7Y7nsaWU45/aFrQIO5cbLVMocRN
         AKvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T89oyjNmaMmTsQDUNOpka6O5hxUFwibzvGHggRdqNpE=;
        b=ndAa+2vuXqg8Rz+MSx8ZndmmqZgHvAZuHkngp4MUyktQ0E4hxo/099/6LskACIJR9P
         saQHZP342jBeOhzADZk+TaHvqhPVw2bG47Gpy0evctoE0ABEqWXR4jAh3TGxuzkNQzkc
         22HxAVep5ogt8i1zZ2xCbrbnYX6iQMql6jqYrbEHJOFX4i0GxFSuSGaXwKgW2TqjtGLE
         2PmlZzsxIWkaEimaGSZL+H2LbHBqa0lCiaYkMsNedL+T7FcI2M1uQmZ2Uf4rqAb6drR2
         bX4m207DQ0fiDTU5IKc48iMOM4kzSks/KFXeBxAKA5di5GoK6iTcSxabTG5O90tLPFvj
         IIIg==
X-Gm-Message-State: AFeK/H3Lc+LW5KuDydqt8vgNpdSe0NKXETs+tgXhg+FSKUKHzV2tKdJPM1RcpPD+biezSg==
X-Received: by 10.84.128.15 with SMTP id 15mr26428281pla.37.1490218708721;
        Wed, 22 Mar 2017 14:38:28 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:55f5:992d:bc78:c749])
        by smtp.gmail.com with ESMTPSA id u69sm5722056pfg.121.2017.03.22.14.38.27
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 22 Mar 2017 14:38:28 -0700 (PDT)
Date:   Wed, 22 Mar 2017 14:38:26 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] remote-curl: allow push options
Message-ID: <20170322213826.GC26108@aiede.mtv.corp.google.com>
References: <20170322195102.165314-1-bmwill@google.com>
 <20170322195102.165314-3-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170322195102.165314-3-bmwill@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams wrote:

> --- a/builtin/send-pack.c
> +++ b/builtin/send-pack.c
> @@ -152,6 +152,7 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
>  	int progress = -1;
>  	int from_stdin = 0;
>  	struct push_cas_option cas = {0};
> +	struct string_list push_options = STRING_LIST_INIT_DUP;

It's safe for this to be NODUP, since the strings added to it live in
argv.

>  
>  	struct option options[] = {
>  		OPT__VERBOSITY(&verbose),
> @@ -171,6 +172,9 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
>  		OPT_BOOL(0, "stateless-rpc", &stateless_rpc, N_("use stateless RPC protocol")),
>  		OPT_BOOL(0, "stdin", &from_stdin, N_("read refs from stdin")),
>  		OPT_BOOL(0, "helper-status", &helper_status, N_("print status from remote helper")),
> +		OPT_STRING_LIST('o', "push-option", &push_options,
> +				N_("server-specific"),
> +				N_("option to transmit")),

Does this need the short-and-sweet option name 'o'?  For this command,
I think I'd prefer giving it no short name.

Should this option be documented in the manpage, too?

[...]
> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -22,6 +22,7 @@ struct options {
>  	unsigned long depth;
>  	char *deepen_since;
>  	struct string_list deepen_not;
> +	struct string_list push_options;
>  	unsigned progress : 1,
>  		check_self_contained_and_connected : 1,
>  		cloning : 1,
> @@ -139,6 +140,9 @@ static int set_option(const char *name, const char *value)
>  		else
>  			return -1;
>  		return 0;
> +	} else if (!strcmp(name, "push-option")) {
> +		string_list_append(&options.push_options, value);
> +		return 0;

push_options has strdup_strings enabled so this takes ownership of a
copy of value.  Good.

[...]
> --- a/t/t5545-push-options.sh
> +++ b/t/t5545-push-options.sh
> @@ -102,7 +102,9 @@ test_expect_success 'two push options work' '
>  	test_cmp expect upstream/.git/hooks/post-receive.push_options
>  '
>  
> -test_expect_success 'push option denied properly by http remote helper' '\
> +test_expect_success 'push option denied properly by http server' '

Should this test use test_i18ngrep to check that the error message
diagnoses the problem correctly instead of hitting an unrelated error
condition?

[...]
> @@ -113,6 +115,32 @@ test_expect_success 'push option denied properly by http remote helper' '\
>  	git -C test_http_clone push origin master
>  '
>  
> +test_expect_success 'push options work properly across http' '

Nice.

Tested-by: Jonathan Nieder <jrnieder@gmail.com>

With whatever subset of the following changes seems sensible to you
squashed in,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.

diff --git i/Documentation/git-send-pack.txt w/Documentation/git-send-pack.txt
index a831dd0288..966abb0df8 100644
--- i/Documentation/git-send-pack.txt
+++ w/Documentation/git-send-pack.txt
@@ -81,6 +81,12 @@ be in a separate packet, and the list must end with a flush packet.
 	will also fail if the actual call to `gpg --sign` fails.  See
 	linkgit:git-receive-pack[1] for the details on the receiving end.
 
+--push-option=<string>::
+	Pass the specified string as a push option for consumption by
+	hooks on the server side.  If the server doesn't support push
+	options, error out.  See linkgit:git-push[1] and
+	linkgit:githooks[5] for details.
+
 <host>::
 	A remote host to house the repository.  When this
 	part is specified, 'git-receive-pack' is invoked via
diff --git i/builtin/send-pack.c w/builtin/send-pack.c
index 6796f33687..832fd7ed0a 100644
--- i/builtin/send-pack.c
+++ w/builtin/send-pack.c
@@ -144,6 +144,7 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 	unsigned force_update = 0;
 	unsigned quiet = 0;
 	int push_cert = 0;
+	struct string_list push_options = STRING_LIST_INIT_NODUP;
 	unsigned use_thin_pack = 0;
 	unsigned atomic = 0;
 	unsigned stateless_rpc = 0;
@@ -152,7 +153,6 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 	int progress = -1;
 	int from_stdin = 0;
 	struct push_cas_option cas = {0};
-	struct string_list push_options = STRING_LIST_INIT_DUP;
 
 	struct option options[] = {
 		OPT__VERBOSITY(&verbose),
@@ -166,15 +166,15 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 		{ OPTION_CALLBACK,
 		  0, "signed", &push_cert, "yes|no|if-asked", N_("GPG sign the push"),
 		  PARSE_OPT_OPTARG, option_parse_push_signed },
+		OPT_STRING_LIST(0, "push-option", &push_options,
+				N_("server-specific"),
+				N_("option to transmit")),
 		OPT_BOOL(0, "progress", &progress, N_("force progress reporting")),
 		OPT_BOOL(0, "thin", &use_thin_pack, N_("use thin pack")),
 		OPT_BOOL(0, "atomic", &atomic, N_("request atomic transaction on remote side")),
 		OPT_BOOL(0, "stateless-rpc", &stateless_rpc, N_("use stateless RPC protocol")),
 		OPT_BOOL(0, "stdin", &from_stdin, N_("read refs from stdin")),
 		OPT_BOOL(0, "helper-status", &helper_status, N_("print status from remote helper")),
-		OPT_STRING_LIST('o', "push-option", &push_options,
-				N_("server-specific"),
-				N_("option to transmit")),
 		{ OPTION_CALLBACK,
 		  0, CAS_OPT_NAME, &cas, N_("refname>:<expect"),
 		  N_("require old value of ref to be at this value"),
