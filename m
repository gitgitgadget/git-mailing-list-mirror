Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13B621F424
	for <e@80x24.org>; Thu, 26 Apr 2018 23:24:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754716AbeDZXYo (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Apr 2018 19:24:44 -0400
Received: from mail-wr0-f180.google.com ([209.85.128.180]:38252 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754166AbeDZXYn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Apr 2018 19:24:43 -0400
Received: by mail-wr0-f180.google.com with SMTP id h3-v6so38578wrh.5
        for <git@vger.kernel.org>; Thu, 26 Apr 2018 16:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=WNP3jEoJniDo9JNK1B3quBrkO+FUi/bIohtY0k0elhY=;
        b=OD/cVCKpjKljHu0u9zK1rsER4iWyhPHtntxwdA4XA64aefOskAjyptdnHxxjM8YJjx
         ljf6JTwKCN/2aKyaqOdvTC6fhnFpQ+TslHQr9lcNkBB0Sb2f892ql+SYiUuJBhuQjUiQ
         isZXsaaIfAJCjc0W6m1I8isnC7iOk860SvlLCKYdK5aw+RvLOYxuscrsvofl7I6n9goA
         8pxUuw75flD2MvRPWTT/nVwmcQBE6LzvbdHIPFPLbom7gWvy6eiXeEA87eNiXkN54qst
         OS3KJw06ZqTMIexCOsB4ndtfnWpZbNgMO1l7HI/0W+KXKuuk3ckqTZHx2zIkhYdpTCIu
         cnyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=WNP3jEoJniDo9JNK1B3quBrkO+FUi/bIohtY0k0elhY=;
        b=mlPs7yMW8guftE0k5gjPXvw4Ch1bF4x2kHPGP+R//LsqvOPYSn5tBSZroEaGB/JbEn
         /A/OwgxI1u8Y1uevCpqs0zv8t5qbo2GJjV8GE2aWc4u8iaiIfxoCL7zU5yM7rGelhBwj
         ViYsQEDK2wvI3nMnnCmY8eR4rYXNep61scvfJeKVPfj2UfW/1RZzpZuh/kO0q3FvPOsm
         dxlxbR0ES4TeCogL5c8e7uMQAVPfDzRUkJtigjGF6jGXwK0hpFnleB0n9l0WKXFQrARH
         VZh8q/WgRP+Hqc/m+ilVzSz8mJrm3jk4iI2aMQXEXBU2uB97PnwbMLPIg3VKdYu35O9e
         jhXw==
X-Gm-Message-State: ALQs6tDy2UYXs4SK9Y0yPPSOtO6ojFu4D1EM4HzNBfwMZRfSc97HI359
        YUaH2q/yN7os1O0nxHCo/Cs=
X-Google-Smtp-Source: AB8JxZoRE+qfEa4z2Q3KnRhO7LSYwBD9sBKZXttbs4mFpYEkAQ7qSTS8qQaL0+4Yokyo9Nygl2qPiw==
X-Received: by 2002:adf:8f25:: with SMTP id p34-v6mr6671wrb.193.1524785081534;
        Thu, 26 Apr 2018 16:24:41 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 42-v6sm39229wrx.24.2018.04.26.16.24.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Apr 2018 16:24:40 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Wink Saville <wink@saville.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: Fetching tags overwrites existing tags
References: <CAKk8isrAmWOdioJe2CdY+2F_AzKxcTGwd+kBsrAmGx-U=ZHGgA@mail.gmail.com>
        <xmqqzi1s3y5h.fsf@gitster-ct.c.googlers.com>
        <CAKk8isr-7bSVqEv8EjF2UgFfw75D2oVZPJFui30pbY6kWfeL_Q@mail.gmail.com>
        <CAKk8ispWBoG7D+u8x+s+iB+wzXUN=7vpxgmz5wjL67P6XUmw9g@mail.gmail.com>
        <xmqqfu3h1t22.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 27 Apr 2018 08:24:40 +0900
In-Reply-To: <xmqqfu3h1t22.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 27 Apr 2018 07:50:13 +0900")
Message-ID: <xmqqbme51rgn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Wink Saville <wink@saville.com> writes:
>
>> I've tried to teach 'git remote add' the --prefix-tags option using the
>> technique Junio provided. At moment it is PR #486 on github [1]
>> and I'd love some comments on whether or not this the right direction
>> for fetching tags and putting them in the branches namespace.
>>
>> -- Wink
>>
>> [1] https://github.com/git/git/pull/486
>
> FWIW, here is how that pull/486/head looks like.
>
> -- >8 --
>
> From: Wink Saville <wink@saville.com>
> Date: Thu, 26 Apr 2018 09:56:11 -0700
> Subject: [PATCH] Teach remote add the --prefix-tags option
>
> When --prefix-tags is passed to `git remote add` the tagopt is set to
> --prefix-tags and a second fetch line is added so tags are placed in
> the branches namespace.

When I hear "branches namespace", what comes to my mind is refs/heads/
or perhaps refs/remotes/*/.  "... are placed in a separate hierarchy
per remote" or something, perhaps?

>
> ...
> And the .git/config remote "gbenchmark" section looks like:
>   [remote "gbenchmark"]
>     url = git@github.com:google/benchmark
>     fetch = +refs/heads/*:refs/remotes/gbenchmark/*
>     fetch = +refs/tags/*:refs/remote-tags/gbenchmark/*
>     tagopt = --prefix-tags
> ---

Missing sign-off ;-)

> +static void add_remote_tags(const char *key, const char *branchname,
> +		       const char *remotename, struct strbuf *tmp)
> +{
> +	strbuf_reset(tmp);
> +	strbuf_addch(tmp, '+');
> +	strbuf_addf(tmp, "refs/tags/%s:refs/remote-tags/%s/%s",
> +				branchname, remotename, branchname);

With "+refs/tags/%s:refs/remote-tags/%s/%s", combine addch/addf into
one, perhaps?

> +	git_config_set_multivar(key, tmp->buf, "^$", 0);
> +}

Calling the second parameter "branchname" makes little sense, I
would think.  Practically, you would call this at most once with its
second parameter set to '*', and even if the second parameter is not
a wildcard/asterisk, it would be a tagname.


>  static const char mirror_advice[] =
>  N_("--mirror is dangerous and deprecated; please\n"
>     "\t use --mirror=fetch or --mirror=push instead");
> @@ -161,6 +172,9 @@ static int add(int argc, const char **argv)
>  		OPT_SET_INT(0, "tags", &fetch_tags,
>  			    N_("import all tags and associated objects when fetching"),
>  			    TAGS_SET),
> +		OPT_SET_INT(0, "prefix-tags", &fetch_tags,
> +			    N_("import all tags and associated objects when fetching and prefix with <name>"),
> +          TAGS_SET_PREFIX),

Funny indent.  Use monospaced font in your editor, set tab width to
8 and align, imitating how the above OPT_SET_INT() item does for
TAGS_SET.

> @@ -215,10 +229,35 @@ static int add(int argc, const char **argv)
>  	}
>  
>  	if (fetch_tags != TAGS_DEFAULT) {
> +		if (fetch_tags == TAGS_SET_PREFIX) {
> +			strbuf_reset(&buf);
> +			strbuf_addf(&buf, "remote.%s.fetch", name);
> +			if (track.nr == 0)
> +				string_list_append(&track, "*");
> +			for (i = 0; i < track.nr; i++) {
> +				add_remote_tags(buf.buf, track.items[i].string,
> +						name, &buf2);
> +			}

The "track" thing is made incompatible with anything but mirror in
early part of this function (outside the precontext).  I highly
suspect that --prefix-tags does *not* make sense when mirroring.

Hence (1) we should detect and error out when --prefix-tags is used
with mirror fetch near where we do the same for track used without
mirror fetch already, (2) detect and error out when --prefix-tags is
used with track, and (3) add "+refs/tags/*:refs/remote-tags/$name/*"
just once without paying attention to track here.  We may not even
want add_remote_tags() helper function if we go that route.

> +		}
> +
>  		strbuf_reset(&buf);
>  		strbuf_addf(&buf, "remote.%s.tagopt", name);
> -		git_config_set(buf.buf,
> -			       fetch_tags == TAGS_SET ? "--tags" : "--no-tags");
> +		char* config_val = NULL;

decl-after-statement.  Also "char *var", not "char* var".

> +		switch (fetch_tags) {
> +		case TAGS_UNSET:
> +			config_val = "--no-tags";
> +			break;
> +		case TAGS_SET:
> +			config_val = "--tags";
> +			break;
> +		case TAGS_SET_PREFIX:
> +			config_val = "--prefix-tags";
> +			break;
> +		default:
> +			die(_("Unexpected TAGS enum %d"), fetch_tags);
> +			break;
> +		}
> +		git_config_set(buf.buf, config_val);
>  	}
>  
>  	if (fetch && fetch_remote(name))
> diff --git a/remote.c b/remote.c
> index 91eb010ca9..f383ce3cdf 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -447,6 +447,8 @@ static int handle_config(const char *key, const char *value, void *cb)
>  			remote->fetch_tags = -1;
>  		else if (!strcmp(value, "--tags"))
>  			remote->fetch_tags = 2;
> +		else if (!strcmp(value, "--prefix-tags"))
> +			remote->fetch_tags = -1; // A fetch for refs/tags is present so tags are retrieved

We are old fashioned and do not use // comments, but more
importantly it is not clear what this comment is trying to
say, at least to me.

>  	} else if (!strcmp(subkey, "proxy")) {
>  		return git_config_string((const char **)&remote->http_proxy,
>  					 key, value);
