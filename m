Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB1E52047F
	for <e@80x24.org>; Wed, 27 Sep 2017 21:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752140AbdI0VgU (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Sep 2017 17:36:20 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:50393 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752028AbdI0VgT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2017 17:36:19 -0400
Received: by mail-pg0-f48.google.com with SMTP id p5so8480244pgn.7
        for <git@vger.kernel.org>; Wed, 27 Sep 2017 14:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=behYz6Zd59fbZhyAW5um5pLQE5xzovcRl333X+1TxsM=;
        b=rkT2niNnpNlPZlZUDo8dRmp22RoKx251g/bsXlljWJ244NbUSSjJRCiLO9Yn8+2CIo
         J9RxXenAEcpqjx5yQP5nd5AW1U5CeQGH9q0OOUSwIOid2J0sD85Or06DJ2MiffEM7UYF
         RfeV34SK4SMI8BaxAjQOk0ZfaJMjsSdKt+HALU84Li/qlHqjae+HRZe23niUB2PEjUlu
         1gCxkDcuh6RDAaGN0wxYfRxoWjbO6z+vA87CL9MkHML5MhdOsTfelzH5aZOnte+swNK3
         ert5cYyqEZ1FGiybyVlLhHOIUl9gSOZsnLMyWbtqq68Mtgtm7StBIp3ZfOUjQgEmzLOU
         uhRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=behYz6Zd59fbZhyAW5um5pLQE5xzovcRl333X+1TxsM=;
        b=sDml4SJAaJeYEJkqm7fq9Ahwdf3h5pf9Uwao+RrxCWRoeRnmt6Uv8EpnWdw32iEIsr
         Lleredt9Cn6p8p1vWbRI3GrnhMYA5y59rsm/JPnsOy2JvTg6dAEMiP59pp+4hUHQrhQ6
         S3kvjtjPHqsXwgKi3cOniXpOP+OoRqr6gsO5KeCinPOYNl5BMXLjVBGR/87sAlq3k0lX
         qEVMWN8fq/pYQCGgUgDfttC7HF7axpgJt9NsQkrlgc6HTlgI7NdswFWIfreDmMpg4RcL
         qVcJlobKcxQn7Fqtl5YyQs5ESHRFZcStfgIhoMm4gZLUL5bSEih0MiiFm201HLdj9UGf
         Ooyg==
X-Gm-Message-State: AHPjjUgct+DEswIQzHXST8CUr09RSkH5zd7PzRR/9BPmVymU758DgmAE
        UUIueOoGxXOM+aJQDeb4LTRBew==
X-Google-Smtp-Source: AOwi7QCZ3oaz6Pr+GAhAimWZJ2g7wYREh/8D+kkTKKlh+EEEcQKNQd8JPTxys/3+DOlUm8zaegr4Dg==
X-Received: by 10.159.198.74 with SMTP id y10mr2292394plt.45.1506548178957;
        Wed, 27 Sep 2017 14:36:18 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:880:967f:fa0a:fc13])
        by smtp.gmail.com with ESMTPSA id u20sm20267323pfh.171.2017.09.27.14.36.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 27 Sep 2017 14:36:18 -0700 (PDT)
Date:   Wed, 27 Sep 2017 14:36:16 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, bturner@atlassian.com, git@jeffhostetler.com,
        jonathantanmy@google.com, jrnieder@gmail.com, peff@peff.net,
        sbeller@google.com
Subject: Re: [PATCH v2 8/9] http: tell server that the client understands v1
Message-ID: <20170927213616.GC68699@google.com>
References: <20170913215448.84674-1-bmwill@google.com>
 <20170926235627.79606-1-bmwill@google.com>
 <20170926235627.79606-9-bmwill@google.com>
 <xmqqfub864m8.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqfub864m8.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/27, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> > @@ -897,6 +898,21 @@ static void set_from_env(const char **var, const char *envname)
> >  		*var = val;
> >  }
> >  
> > +static void protocol_http_header(void)
> > +{
> > +	if (get_protocol_version_config() > 0) {
> > +		struct strbuf protocol_header = STRBUF_INIT;
> > +
> > +		strbuf_addf(&protocol_header, GIT_PROTOCOL_HEADER ": version=%d",
> > +			    get_protocol_version_config());
> > +
> > +
> > +		extra_http_headers = curl_slist_append(extra_http_headers,
> > +						       protocol_header.buf);
> > +		strbuf_release(&protocol_header);
> > +	}
> > +}
> > +
> >  void http_init(struct remote *remote, const char *url, int proactive_auth)
> >  {
> >  	char *low_speed_limit;
> > @@ -927,6 +943,8 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
> >  	if (remote)
> >  		var_override(&http_proxy_authmethod, remote->http_proxy_authmethod);
> >  
> > +	protocol_http_header();
> > +
> >  	pragma_header = curl_slist_append(http_copy_default_headers(),
> >  		"Pragma: no-cache");
> >  	no_pragma_header = curl_slist_append(http_copy_default_headers(),
> > diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
> > index 0642ae7e6..df1943631 100644
> > --- a/t/lib-httpd/apache.conf
> > +++ b/t/lib-httpd/apache.conf
> > @@ -67,6 +67,9 @@ LockFile accept.lock
> >  <IfModule !mod_unixd.c>
> >  	LoadModule unixd_module modules/mod_unixd.so
> >  </IfModule>
> > +<IfModule !mod_setenvif.c>
> > +	LoadModule setenvif_module modules/mod_setenvif.so
> > +</IfModule>
> >  </IfVersion>
> >  
> >  PassEnv GIT_VALGRIND
> > @@ -76,6 +79,10 @@ PassEnv ASAN_OPTIONS
> >  PassEnv GIT_TRACE
> >  PassEnv GIT_CONFIG_NOSYSTEM
> >  
> > +<IfVersion >= 2.4>
> > +	SetEnvIf Git-Protocol ".*" GIT_PROTOCOL=$0
> > +</IfVersion>
> > +
> 
> It is very nice to see that only with a single extra HTTP header and
> the server configuration, everybody else does not have to care how
> the version information is plumbed through ;-)

Having limited experience working with HTTP, it took me a bit to
figure out how to get the server configuration right, but once I got it
working it seemed to work pretty seamlessly :)

-- 
Brandon Williams
