Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50528219FC
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 18:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wUsIt+Qm"
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE8DB7
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 11:41:39 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a92864859bso30077027b3.0
        for <git@vger.kernel.org>; Mon, 23 Oct 2023 11:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698086499; x=1698691299; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SvF5c3gi9PtZeQJ2LyVL03KDLCoCLaVBbVQ5QjGLLOk=;
        b=wUsIt+QmnXvG83OU9wUqqRKHUvLAkLXnwWDttJ1QC/0JDM1LDLYkbJW6TVw41jHQNI
         DCuRwW7UWc9vLlJQXNziwH6NGLCGKK6QD8r1zi7Z78rgC3XHPfb3II1MNwhfjbiz3Bx9
         0KTy9QDi07Fk9G/3eETcyS6j4qNveYVxhMiRMdZaxWNtzbJuZQtnodE7ALRsWuE4Yq8w
         907tDvLsPhTph1oSNwqP3p9BJkzGtgbzdqp5YAXs91s4m9Ylp+zuqBstWwo4W5HRcrTV
         6dwj4TofXJl4+7d1hGi+dM4doBABdW7lbJN+529T4RHeNmwCqhkcLAVJej8kkmtNPcpQ
         bjmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698086499; x=1698691299;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SvF5c3gi9PtZeQJ2LyVL03KDLCoCLaVBbVQ5QjGLLOk=;
        b=IYGssuiQfXbtffkmnYeB9+Disa51wKI9hio3fX4Z9u1q+bZn78yQ1UHeat2AUJJ8sj
         4cekwUObTZAGgWefizOntdlGypDS2/9r0OQ4Ih1l1RsCNQ/sMiT4L4TC/nu+U+TABq7J
         O12+zPcQ6X1Afxt29kDOMBMDMy9A2++60NLVGbhG4QHMhT6kCFMws+VG823t3IZtmkco
         IG1u/tkXsUFbwmU2K4Rx8jQpIBZaco88yU6Zc262Pm0q5A4DDDcUsw+o+rlD7rYWhCLD
         bj8GA57DOqLaBCEO+/YKhWcZrA1/DETHigalZlZJJtLoMtJSo/0NgOG7sO6G5R+PU4Ab
         ZlcQ==
X-Gm-Message-State: AOJu0YweK+ayhmXF1OSD8Dk0hUJ5uwoWNaMolKntybgANDyiZ1hmlJ7R
	4gI3O6O2Bv/MiZlw+HBV4HLi3y+WXKf6is+KAEkr
X-Google-Smtp-Source: AGHT+IEQisQBGbok4grL1sZOIhXOYYWq5fX1vxHi39Ze763k/+oRuTi7VWZAdzaX3dmqSJd3zSvpIMguW5P91SfoYSOf
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:29f6:5cb7:f652:5c5e])
 (user=jonathantanmy job=sendgmr) by 2002:a25:da8d:0:b0:d9b:454d:352d with
 SMTP id n135-20020a25da8d000000b00d9b454d352dmr204967ybf.9.1698086499138;
 Mon, 23 Oct 2023 11:41:39 -0700 (PDT)
Date: Mon, 23 Oct 2023 11:41:37 -0700
In-Reply-To: <a888045c04d27864edf5751ea8641fdba596779c.1695330852.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Message-ID: <20231023184137.994212-1-jonathantanmy@google.com>
Subject: Re: [PATCH v3 3/5] config: report config parse errors using cb
From: Jonathan Tan <jonathantanmy@google.com>
To: Josh Steadmon <steadmon@google.com>
Cc: Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org, calvinwan@google.com, 
	glencbz@gmail.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"

Josh Steadmon <steadmon@google.com> writes:
> From: Glen Choo <chooglen@google.com>
> 
> In a subsequent commit, config parsing will become its own library, and
> it's likely that the caller will want flexibility in handling errors
> (instead of being limited to the error handling we have in-tree).
> 
> Move the Git-specific error handling into a config_parser_event_fn_t
> that responds to config errors, and make git_parse_source() always
> return -1 (careful inspection shows that it was always returning -1
> already). This makes CONFIG_ERROR_SILENT obsolete since that is
> equivalent to not specifying an error event listener. Also, remove
> CONFIG_ERROR_UNSET and the config_source 'default', since all callers
> are now expected to specify the error handling they want.

I think this has to be better explained. So:

- There is already a config_parser_event_fn_t that can be configured
by a user to receive emitted config events. This callback can return
negative to halt further config parsing.

- Currently, it is git_parse_source() that detects when an error
occurs, and it emits a CONFIG_EVENT_ERROR and either dies, prints
an error, or swallows the error depending on error_action; no
matter what error_action is, it halts config parsing, as one would
expect. This commit moves the die/print/swallow handling to a
config_parser_event_fn_t that will see the CONFIG_EVENT_ERROR and die/
print/swallow.

- This new config_parser_event_fn_t does not need to swallow, since
that's the same as not passing in a callback. So it just needs to die/
print.

> @@ -1039,6 +1042,29 @@ static int do_event(struct config_source *cs, enum config_event_t type,
>  	return 0;
>  }
>  
> +static int do_event_and_flush(struct config_source *cs,
> +			      enum config_event_t type,
> +			      struct parse_event_data *data)
> +{
> +	int maybe_ret;
> +
> +	if ((maybe_ret = flush_event(cs, type, data)) < 1)
> +		return maybe_ret;
> +
> +	start_event(cs, type, data);
> +
> +	if ((maybe_ret = flush_event(cs, type, data)) < 1)
> +		return maybe_ret;
> +
> +	/*
> +	 * Not actually EOF, but this indicates we don't have a valid event
> +	 * to flush next time around.
> +	 */
> +	data->previous_type = CONFIG_EVENT_EOF;
> +
> +	return 0;
> +}

A lot of this function only makes sense if the type is ERROR, so maybe
rename this as flush_and_emit_error() (and don't take in a type). As
it is, right now there is some confusion about how you can flush (I'm
referring to the second flush) with the same type as what you passed
to start_event().

Also, I don't think we should set data->previous_type here. Instead
there should be a comment saying that if you're emitting ERROR, you
should halt config parsing. The return value here is useless too (it
signals whether we should halt config parsing, but the caller should
always halt, so we don't need to return anything).

