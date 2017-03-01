Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7EC72023D
	for <e@80x24.org>; Wed,  1 Mar 2017 19:30:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753011AbdCATap (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 14:30:45 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36667 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752233AbdCATan (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 14:30:43 -0500
Received: by mail-pg0-f68.google.com with SMTP id 25so6767254pgy.3
        for <git@vger.kernel.org>; Wed, 01 Mar 2017 11:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=td6QzzOfRY34ISmjvP6NbECxyz5FDDI+BqMg0K3xDqI=;
        b=d69v/bla3WmN4bLWcwO/9VLaDsrs/H3vQn2QyvU7Zal5mSoUPDV6fp3Wvz6sM/QDHp
         /z28ma6MWDOoPX9r0bDrroPgcArPG6t/5T6cct1gf9lUYmiSVXCBbR+Qpcv7NETEyRzI
         vUsUaczbQ89pYzzMmenS7NJL7CTXsE6qF7+emGIod9H3Gwsvnnn1L8aXnuzIMke1fbfv
         kTzIOxWgpNFARQ0x+rqEOoO4fIDtMUzFS9uXOhfTSZ5BEBjE0GPipVJlwP/WJcwTjD2a
         +e+U2DSA+C4jUEkV35i8RGz7+hPGdyCFiCdvu0e+SXC+QaytKt0qJECIH7squaTfG1SP
         cgpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=td6QzzOfRY34ISmjvP6NbECxyz5FDDI+BqMg0K3xDqI=;
        b=FsbdekvW0ACQ7pHj6vOJ4yUsc+6b2LCwWXukzHzypkQdHmgT7gDZ6zFdXPXTtIqe2E
         4+fPmsZQs4u9rbhwnvmlMzlaUQjZIZxw95543Vd8OnL93WU25slBOuxLf9yhZ3VhvWlY
         jPN1lGzN+LW1EUm6Ts+nTRPQ1ISHWn0FA7N1/ajmak1kjjaeqrR2rPaDTqBfzf97X2YC
         ksKlYf8FquQMwktWtZvuYkA4I2653TWyz5pI2kJ1jD4P83P9KZ086+iuSGdseVv0CAib
         yxeGwzwTKLfTUIMPTG0v5BStkrNcVfjTue/4raOZXmfRGphJu+QjnEgMCOe8V/oNBMgw
         QTCw==
X-Gm-Message-State: AMke39kO6g7oENBbPcxvfVl9qkEZEXhVujqrwuS4r8XKd81wAZvpKrHcXo/NfiDpQnTKPA==
X-Received: by 10.98.11.144 with SMTP id 16mr8705038pfl.78.1488390462548;
        Wed, 01 Mar 2017 09:47:42 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:dd87:32f4:da52:1d3d])
        by smtp.gmail.com with ESMTPSA id e129sm11859449pfe.8.2017.03.01.09.47.41
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 01 Mar 2017 09:47:41 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        sschuberth@gmail.com, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Philip Oakley <philipoakley@iee.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v7 3/3] config: add conditional include
References: <20170224131425.32409-1-pclouds@gmail.com>
        <20170301112631.16497-1-pclouds@gmail.com>
        <20170301112631.16497-4-pclouds@gmail.com>
Date:   Wed, 01 Mar 2017 09:47:40 -0800
In-Reply-To: <20170301112631.16497-4-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Wed, 1 Mar 2017 18:26:31 +0700")
Message-ID: <xmqqo9xkhosj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

>  int git_config_include(const char *var, const char *value, void *data)
>  {
>  	struct config_include_data *inc = data;
> +	const char *cond, *key;
> +	int cond_len;
>  	int ret;
>  
>  	/*
> @@ -185,6 +271,12 @@ int git_config_include(const char *var, const char *value, void *data)
>  
>  	if (!strcmp(var, "include.path"))
>  		ret = handle_path_include(value, inc);
> +
> +	if (!parse_config_key(var, "includeif", &cond, &cond_len, &key) &&
> +	    (cond && include_condition_is_true(cond, cond_len)) &&
> +	    !strcmp(key, "path"))
> +		ret = handle_path_include(value, inc);
> +
>  	return ret;
>  }

So "includeif.path" (misspelled one without any condition) falls
through to "return ret" and gives the value we got from inc->fn().
I am OK with that (i.e. "missing condition is false").

Or we can make it go to handle_path_include(), effectively making
the "include.path" a short-hand for "includeIf.path".  I am also OK
with that (i.e. "missing condition is true").

Or we could even have "include.[<condition>.]path" without
"includeIf"?  I am not sure if it is a bad idea that paints
ourselves in a corner, but somehow I find it tempting.
