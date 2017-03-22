Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53FD920323
	for <e@80x24.org>; Wed, 22 Mar 2017 22:13:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751368AbdCVWNR (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 18:13:17 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:33639 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751250AbdCVWNQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 18:13:16 -0400
Received: by mail-pg0-f49.google.com with SMTP id w20so10865268pgc.0
        for <git@vger.kernel.org>; Wed, 22 Mar 2017 15:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1jOFjQ6IKHlzlws0umKHltVWt7ljkgvnQTUQYDu69+4=;
        b=HLBpO6IvNe3cNA7EOqK9KZBnHk2q7GsUXxxNj/7aVxpSJYzYucArtBXUBN62Duu0Ct
         0uXHVncF6xl/pgQb3ZBkYsGusl2q8STfCNdCKvzwx/tQYJWE9eFmfl9hFoe2IGOX/Xdn
         O5Lb9IdnEp4SMDV7xBEMx70y+dOshUHIcjF5upyD7mNaG62NmpsQCVkVFHoaLcADB/SZ
         pB2OUj6kcWqRWF0RfXhkRuJkx2b9TVUdY7vFplOpodKpf+ckzy1CfWkgQ6TcSYkwTD2T
         Hkq/ZPyxiOe0lsMnlNishWAnhwEiapJVx5EyMklpHN3kjGLyKRHTQJxvRDqKcc3zyS1l
         Ci6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1jOFjQ6IKHlzlws0umKHltVWt7ljkgvnQTUQYDu69+4=;
        b=hXhFTAyqlRGOmRurG6jm4tSOpo7l1Ss5mSl7KTlJQEghmFrT6QBb8OeU40W17DC6pB
         InVext/HwfmtetG5kuyXgD4bSyXgnM2Xe1ktfLF6eLjN7ORdoGNGcrHt8nGMyO/2PkyK
         D45RmaknpYXECp/2i7r3AJO2ZwOLtg5WXdZ1YYRxr03ExdoJ2qrCV9i6/HJPuI7b38NA
         yxI8X16Y7F2kt1eTVZd5xII4a50BlV4dkwvn3BzpLu3M2zTrFghWus0PzDki3PNra3JA
         Te/oenliJFOAFTsx4P6ZIU+/WG6E2cbgonVeJAud9djQNTGwcuJ5klfVhu6gLMrNRc2D
         +57w==
X-Gm-Message-State: AFeK/H3tIqGzkpu/jpFz0faP5U2rbmTkeDhGpUJVexV7M2tc06bPGgMZPKuxaHRX4debnKP1
X-Received: by 10.84.163.75 with SMTP id n11mr1511075plg.186.1490220794718;
        Wed, 22 Mar 2017 15:13:14 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:4506:c5a2:cf62:91cb])
        by smtp.gmail.com with ESMTPSA id x15sm5821339pgo.56.2017.03.22.15.13.13
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 22 Mar 2017 15:13:13 -0700 (PDT)
Date:   Wed, 22 Mar 2017 15:13:12 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] remote-curl: allow push options
Message-ID: <20170322221312.GD11254@google.com>
References: <20170322195102.165314-1-bmwill@google.com>
 <20170322195102.165314-3-bmwill@google.com>
 <20170322213826.GC26108@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170322213826.GC26108@aiede.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/22, Jonathan Nieder wrote:

I agree with most of these changes,  I'll make them locally and send out
a reroll.

> Brandon Williams wrote:
> 
> > --- a/builtin/send-pack.c
> > +++ b/builtin/send-pack.c
> > @@ -152,6 +152,7 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
> >  	int progress = -1;
> >  	int from_stdin = 0;
> >  	struct push_cas_option cas = {0};
> > +	struct string_list push_options = STRING_LIST_INIT_DUP;
> 
> It's safe for this to be NODUP, since the strings added to it live in
> argv.
> 
> >  
> >  	struct option options[] = {
> >  		OPT__VERBOSITY(&verbose),
> > @@ -171,6 +172,9 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
> >  		OPT_BOOL(0, "stateless-rpc", &stateless_rpc, N_("use stateless RPC protocol")),
> >  		OPT_BOOL(0, "stdin", &from_stdin, N_("read refs from stdin")),
> >  		OPT_BOOL(0, "helper-status", &helper_status, N_("print status from remote helper")),
> > +		OPT_STRING_LIST('o', "push-option", &push_options,
> > +				N_("server-specific"),
> > +				N_("option to transmit")),
> 
> Does this need the short-and-sweet option name 'o'?  For this command,
> I think I'd prefer giving it no short name.
> 
> Should this option be documented in the manpage, too?
> 
> [...]
> > --- a/remote-curl.c
> > +++ b/remote-curl.c
> > @@ -22,6 +22,7 @@ struct options {
> >  	unsigned long depth;
> >  	char *deepen_since;
> >  	struct string_list deepen_not;
> > +	struct string_list push_options;
> >  	unsigned progress : 1,
> >  		check_self_contained_and_connected : 1,
> >  		cloning : 1,
> > @@ -139,6 +140,9 @@ static int set_option(const char *name, const char *value)
> >  		else
> >  			return -1;
> >  		return 0;
> > +	} else if (!strcmp(name, "push-option")) {
> > +		string_list_append(&options.push_options, value);
> > +		return 0;
> 
> push_options has strdup_strings enabled so this takes ownership of a
> copy of value.  Good.
> 
> [...]
> > --- a/t/t5545-push-options.sh
> > +++ b/t/t5545-push-options.sh
> > @@ -102,7 +102,9 @@ test_expect_success 'two push options work' '
> >  	test_cmp expect upstream/.git/hooks/post-receive.push_options
> >  '
> >  
> > -test_expect_success 'push option denied properly by http remote helper' '\
> > +test_expect_success 'push option denied properly by http server' '
> 
> Should this test use test_i18ngrep to check that the error message
> diagnoses the problem correctly instead of hitting an unrelated error
> condition?
> 
> [...]
> > @@ -113,6 +115,32 @@ test_expect_success 'push option denied properly by http remote helper' '\
> >  	git -C test_http_clone push origin master
> >  '
> >  
> > +test_expect_success 'push options work properly across http' '
> 
> Nice.
> 
> Tested-by: Jonathan Nieder <jrnieder@gmail.com>
> 
> With whatever subset of the following changes seems sensible to you
> squashed in,
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
> 
> Thanks.
> 
> diff --git i/Documentation/git-send-pack.txt w/Documentation/git-send-pack.txt
> index a831dd0288..966abb0df8 100644
> --- i/Documentation/git-send-pack.txt
> +++ w/Documentation/git-send-pack.txt
> @@ -81,6 +81,12 @@ be in a separate packet, and the list must end with a flush packet.
>  	will also fail if the actual call to `gpg --sign` fails.  See
>  	linkgit:git-receive-pack[1] for the details on the receiving end.
>  
> +--push-option=<string>::
> +	Pass the specified string as a push option for consumption by
> +	hooks on the server side.  If the server doesn't support push
> +	options, error out.  See linkgit:git-push[1] and
> +	linkgit:githooks[5] for details.
> +
>  <host>::
>  	A remote host to house the repository.  When this
>  	part is specified, 'git-receive-pack' is invoked via
> diff --git i/builtin/send-pack.c w/builtin/send-pack.c
> index 6796f33687..832fd7ed0a 100644
> --- i/builtin/send-pack.c
> +++ w/builtin/send-pack.c
> @@ -144,6 +144,7 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
>  	unsigned force_update = 0;
>  	unsigned quiet = 0;
>  	int push_cert = 0;
> +	struct string_list push_options = STRING_LIST_INIT_NODUP;
>  	unsigned use_thin_pack = 0;
>  	unsigned atomic = 0;
>  	unsigned stateless_rpc = 0;
> @@ -152,7 +153,6 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
>  	int progress = -1;
>  	int from_stdin = 0;
>  	struct push_cas_option cas = {0};
> -	struct string_list push_options = STRING_LIST_INIT_DUP;
>  
>  	struct option options[] = {
>  		OPT__VERBOSITY(&verbose),
> @@ -166,15 +166,15 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
>  		{ OPTION_CALLBACK,
>  		  0, "signed", &push_cert, "yes|no|if-asked", N_("GPG sign the push"),
>  		  PARSE_OPT_OPTARG, option_parse_push_signed },
> +		OPT_STRING_LIST(0, "push-option", &push_options,
> +				N_("server-specific"),
> +				N_("option to transmit")),
>  		OPT_BOOL(0, "progress", &progress, N_("force progress reporting")),
>  		OPT_BOOL(0, "thin", &use_thin_pack, N_("use thin pack")),
>  		OPT_BOOL(0, "atomic", &atomic, N_("request atomic transaction on remote side")),
>  		OPT_BOOL(0, "stateless-rpc", &stateless_rpc, N_("use stateless RPC protocol")),
>  		OPT_BOOL(0, "stdin", &from_stdin, N_("read refs from stdin")),
>  		OPT_BOOL(0, "helper-status", &helper_status, N_("print status from remote helper")),
> -		OPT_STRING_LIST('o', "push-option", &push_options,
> -				N_("server-specific"),
> -				N_("option to transmit")),
>  		{ OPTION_CALLBACK,
>  		  0, CAS_OPT_NAME, &cas, N_("refname>:<expect"),
>  		  N_("require old value of ref to be at this value"),

-- 
Brandon Williams
