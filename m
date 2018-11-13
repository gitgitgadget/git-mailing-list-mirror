Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28F001F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 22:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbeKNIxt (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 03:53:49 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37008 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbeKNIxt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 03:53:49 -0500
Received: by mail-pf1-f195.google.com with SMTP id u3-v6so4143893pfm.4
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 14:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vRymGs5f955BkU5SzYqF9APyHIvGcPsYTJ/9H8hUwyk=;
        b=kwcVcADKbqeZfSrn4eNSKiI0zjdbfKpHYPO92J9YZ4mq7kWoE1dplkT+ng+W/iKBkC
         Lf0h+s3RzbmxLGgmTorwVMp+eTOgg3bmOa2KlaOPxByPeZZdzV1CNc9sqQfoiWTGN/pf
         5AjRRoXTAdR9QGSmLYnEdsDYlzDw6xsAeT5Wfj3rVzb7ADHcz/bpqp+BlcJ7oxkNtCmC
         RQ68xe8ZzQOUuNItQmU5IHJsrZCOnwcqmHZhZOwRnY+iHbVXHdifqok7o2sXjsglrQB0
         30UVmU8mrE3mQ3hEIKBzQ+R7PwhhCcfx7YG2kRBCXK7MXCz66xz35GT0DlLoaf6Vu2NU
         5aIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=vRymGs5f955BkU5SzYqF9APyHIvGcPsYTJ/9H8hUwyk=;
        b=t7zyktq28ivcoHGePBrGKU4nMvSAYWi/ImVe27r6scW7LLFEK8228Hf+OCyTVHGpn4
         /rsWbUIIF9HRWEij17Jie4ANiEIUAGPZTeg7YUkHYdFNyBqfm+XwhaeSiqLXnsCs/DQZ
         aGAdZVetxUrVkOV1lopvSre/zEVLroldFJPegznNOBusuWVHhdZ/rIyACVIhE5ILNdXc
         THAwu48co4iV8gK/rH4ax5H8b2jAwlRly9lfSbaVE/zylSpUxmjrNmVMukBwbcn8yEq2
         f9cIFoilEGhVtEiNnLb73AMSfnefNnnMKK9vNs8RUBw1CWLBQwkd2XIVFhJaXXqMz1OP
         o1GQ==
X-Gm-Message-State: AGRZ1gKoBHIAfake3F4eAJh1PQrB+wOOFgZH+Z5dEVWNgtibqRsGCBbP
        w5blKOLIdt5Bjm7eJQLMgmO/cObMZbpWSg==
X-Google-Smtp-Source: AJdET5f42DCuijvNNfs9nRInZhEvdGeea1jLJ2OUmp6qhGiLjn2xXDIOxV+tKfVlzgS/fSyMJb1RNQ==
X-Received: by 2002:a63:d547:: with SMTP id v7mr6410539pgi.339.1542149607285;
        Tue, 13 Nov 2018 14:53:27 -0800 (PST)
Received: from google.com ([2620:0:100e:913:5bb:3076:546:99b0])
        by smtp.gmail.com with ESMTPSA id w3sm18411070pge.8.2018.11.13.14.53.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Nov 2018 14:53:25 -0800 (PST)
Date:   Tue, 13 Nov 2018 14:53:20 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, sbeller@google.com, jrnieder@gmail.com
Subject: Re: [PATCH v3 1/1] protocol: advertise multiple supported versions
Message-ID: <20181113225320.GG126896@google.com>
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        sbeller@google.com, jrnieder@gmail.com
References: <cover.1539305180.git.steadmon@google.com>
 <cover.1542059029.git.steadmon@google.com>
 <b9968e3fb005a00e9f78627467b4fc86a6259977.1542059029.git.steadmon@google.com>
 <xmqqr2fpwrqg.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqr2fpwrqg.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018.11.13 13:01, Junio C Hamano wrote:
> steadmon@google.com writes:
> 
> > Currently the client advertises that it supports the wire protocol
> > version set in the protocol.version config. However, not all services
> > support the same set of protocol versions. When connecting to
> > git-receive-pack, the client automatically downgrades to v0 if
> > config.protocol is set to v2, but this check is not performed for other
> > services.
> 
> "downgrades to v0 even if ... is set to v2" you mean?  Otherwise it
> is unclear why asking for v2 leads to using v0.

The downgrade on push happens only when the the configured version is
v2. If v1 is requested, no downgrade is triggered. I'll clarify the
commit message in the next version.

> > This patch creates a protocol version registry. Individual operations
> > register all the protocol versions they support prior to communicating
> > with a server. Versions should be listed in preference order; the
> > version specified in protocol.version will automatically be moved to the
> > front of the registry.
> >
> > The protocol version registry is passed to remote helpers via the
> > GIT_PROTOCOL environment variable.
> >
> > Clients now advertise the full list of registered versions. Servers
> > select the first recognized version from this advertisement.
> 
> Makes sense.
> 
> > +void get_client_protocol_version_advertisement(struct strbuf *advert)
> > +{
> > +	int tmp_nr = nr_allowed_versions;
> > +	enum protocol_version *tmp_allowed_versions, config_version;
> > +	strbuf_reset(advert);
> > +
> > +	have_advertised_versions_already = 1;
> > +
> > +	config_version = get_protocol_version_config();
> > +	if (config_version == protocol_v0) {
> > +		strbuf_addstr(advert, "version=0");
> > +		return;
> > +	}
> > +
> > +	if (tmp_nr > 0) {
> > +		ALLOC_ARRAY(tmp_allowed_versions, tmp_nr);
> > +		copy_array(tmp_allowed_versions, allowed_versions, tmp_nr,
> > +			   sizeof(enum protocol_version));
> > +	} else {
> > +		ALLOC_ARRAY(tmp_allowed_versions, 1);
> > +		tmp_nr = 1;
> > +		tmp_allowed_versions[0] = config_version;
> > +	}
> > +
> > +	if (tmp_allowed_versions[0] != config_version)
> > +		for (int i = 1; i < nr_allowed_versions; i++)
> > +			if (tmp_allowed_versions[i] == config_version) {
> > +				enum protocol_version swap =
> > +					tmp_allowed_versions[0];
> > +				tmp_allowed_versions[0] =
> > +					tmp_allowed_versions[i];
> > +				tmp_allowed_versions[i] = swap;
> > +			}
> > +
> > +	strbuf_addf(advert, "version=%s",
> > +		    format_protocol_version(tmp_allowed_versions[0]));
> > +	for (int i = 1; i < tmp_nr; i++)
> > +		strbuf_addf(advert, ":version=%s",
> > +			    format_protocol_version(tmp_allowed_versions[i]));
> > +}
> > +
> 
> So the idea is that the protocols the other end can talk come in
> advert in their preferred order, and we take an intersection of them
> and our "allowed-versions", but the preference is further skewed
> with the "swap" thing if we have our own preference specified via
> config?

We currently don't intersect with our own allowed list, we just accept
the first version that we recognize. This introduces its own version
negotiation bug; if we add v2 push in the future, a new client
talking to an old server would try to use v2 even though the server may
not have the corresponding v2 push implementation. I'll fix this in the
next version.

In any case, the ordering of the server's allowed versions won't matter;
we'll pick the the first version in the client's list which is also
allowed on the server.

> I am wondering if the code added by this patch outside this
> function, with if (strcmp(client_ad.buf, "version=0") sprinkled all
> over the place, works sensibly when the other side says "I prefer
> version=0 but I do not mind talking version=1".

Depends on what you mean by "sensibly" :). In the current case, if the
client prefers v0, it will always end up using v0. After the fixes
described above, it will always use v0 unless the server no longer
supports v0. Is that what you would expect?

> Isn't tmp_allowed_versions[] leaking when we return from this
> function?

Yes, sorry about that. Will fix.
