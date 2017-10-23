Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76213202A0
	for <e@80x24.org>; Mon, 23 Oct 2017 22:54:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751242AbdJWWyh (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Oct 2017 18:54:37 -0400
Received: from mail-it0-f53.google.com ([209.85.214.53]:51529 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750835AbdJWWyg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Oct 2017 18:54:36 -0400
Received: by mail-it0-f53.google.com with SMTP id o135so7877676itb.0
        for <git@vger.kernel.org>; Mon, 23 Oct 2017 15:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HpWf8yy7hQ4oo5aLtpwRZcGV2DbUbsWv2vNOu+odt+U=;
        b=nSjrlzdy5vESuaMM2HHEe9GNwq8UGe/5KGs239TausKF52fMpJQL+ygfXtUCfBOcoX
         P7u+AKGmih+69iulYIzPsrdC1kRmfDyfFj2RKPK2CG+qyFPSDCAtrmyZyIeOtCQSOm21
         wnW4klVJGUtEaPfJVSKiGdbfj0bLHlw6tJgICXwXnWAoQHOMpzj+1uDwZkE2rclKnL28
         mtWq9jxeDBmc8GmQn5Ps3unwj5imVVHh7S9ssHMFepOPWjEbV0MMqQ3GCGiPfXesd04y
         2c93uqZDX7r2NQDnTkjz4i3m5rZ6aTZGaDylBPc6/TIoGZNS4fZTN/n/P8IKzgWMbbN1
         Sq8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HpWf8yy7hQ4oo5aLtpwRZcGV2DbUbsWv2vNOu+odt+U=;
        b=Rit163JsO0zKRwzY1mEV4fwU/PPwtH4ZUU+A2h1/1zX4jfGTmXFCL5Soonu1MJGIdx
         wRol4LiSAWSztGG6XaNv8xrS1qzM5VZsqlRXVw7OGs+D62FZDi0DqMI+GDA2nujFHIPx
         E4VqCApaQ/z7rcW8zPLSq+ZSm4ZnkcFW+tCxyWqBjNem6/X1oNGy5e4tyvhPaRmfKKJ/
         FxyHlEkGgf3HOAejWfGFlNrZcNQNN0PfoPvJf85BTtygOkUHFk1aGTjSrSe6cpMMoAJo
         i3CwhUlvuZeCdAYxU7a5KJ28osSrH2k7hcmFaRqrsq0c3nfv1WHr/wpVIdSRyqdECOqb
         reZg==
X-Gm-Message-State: AMCzsaUQwTHKL3B9L3YbWc7/ym5pKQu4Gj0kYQgOHeEH/N1007Y68N2f
        fpmIXPh8Rrp+1O0YbZmrWlA=
X-Google-Smtp-Source: ABhQp+TXQ1YJwJcGQyeA6SxWXSRm0NCU9DMWSH+gwtLxhUZvgkVVHTmyyjfLScqAi6yi9JyTEscDcw==
X-Received: by 10.36.76.79 with SMTP id a76mr11201228itb.84.1508799275553;
        Mon, 23 Oct 2017 15:54:35 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id 80sm18765itk.40.2017.10.23.15.54.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Oct 2017 15:54:35 -0700 (PDT)
Date:   Mon, 23 Oct 2017 15:54:32 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Bryan Turner <bturner@atlassian.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>, William Yan <wyan@google.com>
Subject: Re: [PATCH 3/5] ssh: 'auto' variant to select between 'ssh' and
 'simple'
Message-ID: <20171023225432.2lj4gaybkvpyhcgm@aiede.mtv.corp.google.com>
References: <20170926235627.79606-1-bmwill@google.com>
 <20171003201507.3589-1-bmwill@google.com>
 <20171003201507.3589-11-bmwill@google.com>
 <20171003214206.GY19555@aiede.mtv.corp.google.com>
 <20171016171812.GA4487@google.com>
 <20171023212740.qodxzsq5w7rn2r6y@aiede.mtv.corp.google.com>
 <20171023213159.eitrjrqrh277advm@aiede.mtv.corp.google.com>
 <CAGZ79kZTjUvcq_hKHCqTDoaBxt2x+9XcqYc6ao1bhcET2SM-PQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kZTjUvcq_hKHCqTDoaBxt2x+9XcqYc6ao1bhcET2SM-PQ@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller wrote:
> On Mon, Oct 23, 2017 at 2:31 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:

>>  1. First, check whether $GIT_SSH supports OpenSSH options by running
>>
>>         $GIT_SSH -G <options> <host>
>>
>>     This returns status 0 and prints configuration in OpenSSH if it
>>     recognizes all <options> and returns status 255 if it encounters
>>     an unrecognized option.  A wrapper script like
>>
>>         exec ssh -- "$@"
>>
>>     would fail with
>>
>>         ssh: Could not resolve hostname -g: Name or service not known
>
> capital -G?

The actual error message uses lowercase (presumably they use tolower on
the hostname).

>> -       if (variant == VARIANT_TORTOISEPLINK)
>> -               argv_array_push(&conn->args, "-batch");
>> +               detect.use_shell = conn->use_shell;
>
> Why do we have to use a shell for evaluation of this
> test balloon?

If the user set GIT_SSH_COMMAND instead of GIT_SSH then we need to run
it using a shell.  The above line inherits the use_shell setting so it
ends up doing whatever conn would do.

[...]
>> +               argv_array_push(&detect.args, "-G");
> ...
>> +               variant = run_command(&detect) ? VARIANT_SIMPLE : VARIANT_SSH;
>
> What if we have a VARIANT_SIMPLE, that doesn't care about -G
> but just connects to the remote host (keeping the session open), do we need
> to kill it after some time to have run_command return eventually?
>
> Or can we give a command to be executed remotely (e.g. 'false') that
> we know returns quickly?

Since stdin is /dev/null, it would presumably return quickly.  But I
also don't expect this kind of behavior from GIT_SSH commands.  The
kinds I'd expect are

 A. The repo case, which forwards to 'ssh' and supports all 'ssh'
    flags

 B. The travis-ci case, which expects a host and command and does
    not accept any flags

 C. More sophisticated wrappers that parse flags but still do not
    handle -G

For case (A), the detection run would figure out that this accepts
OpenSSH options. Good.

For case (B), the detection run would figure out that this does not
accept OpenSSH options. Good.

For case (C), the detection run would think that this does not accept
OpenSSH options, when it accepts some. But I think that's the best we
can do for now. Longer term, we need to work with the author of such a
script to find out what kind of interface they want.

Thanks and hope that helps,
Jonathan
