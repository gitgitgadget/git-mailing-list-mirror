Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A149220C11
	for <e@80x24.org>; Mon, 27 Nov 2017 17:18:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753286AbdK0RSN (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Nov 2017 12:18:13 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:43548 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752682AbdK0RSM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Nov 2017 12:18:12 -0500
Received: by mail-pl0-f68.google.com with SMTP id s23so3575930plk.10
        for <git@vger.kernel.org>; Mon, 27 Nov 2017 09:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=V4Au8VVPouBvxv3asOy0xEZxUPc0WsXxiSJPnv+pkRM=;
        b=Rgi5LrXoZp6pt1gBePJCCCmZoH+TeP/XlTgYHP6CRdLmvw+ouDUET/idG35vHV/Qut
         fpxGN4vN5tTkuZF9NPcNEMvRQT4FD/wdkWqJ0gSB1rwePtB2hVrwAr8PpZqQ8/kXI5jT
         OmHtb/QQmpOVatDBQ4uUt17mnn8ED+Xtc/ottuhVU2UBtS8e/9RMtsH780Iiw1DmWsjb
         ASezDLlOkHBa5+lYxTgMrUHz4D/XFQJ59UlL6b2kKa0la34jyhptrJL0wzcrVYAAUo+w
         0QoHmYBKFQIcYMET0uVPgdaI3DIBJf94j/9msa+iiDivrzWYq0nw0ZaUy4npbMDmvhdw
         KCjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V4Au8VVPouBvxv3asOy0xEZxUPc0WsXxiSJPnv+pkRM=;
        b=nCC46inet85DE9H6muf5Py699DXfAH6YJ2Q+bmD6bSJXBDVwqlL4tsr4oHjVCpl13/
         AeLmWBDxnkCvI7omM+CEBXw3gShktaNwLxMHt2f3Ypb4Sfs1h5ytRXqSMLfxDdZzIzyn
         Q0TLwZd8TpKIHw8Zhl6WZBzOPkG93XxfCsePXE3F/fpyDRj5pmMvmB+ynUfWmwzPWj+C
         2NnhZGaIUIXPdQrTcSfy61OW6jrVYrGB97o5rymunYJ1zwCVl2SIDgazfV0ZYISoAbaR
         ++IukdpW/PScUxKOh5IG4iJk2CPcPGg1P+CDLdYh2jiHaA8deJaXb8JphtCPdGtXwcl+
         mOzQ==
X-Gm-Message-State: AJaThX5uk1Rbl+FoZrfD4pxVD/aRF52ScakqVfmuTErco0nYEELiz1ff
        iPOZdMLAYQgau3SkAKc1BlI=
X-Google-Smtp-Source: AGs4zMai16qV7/lEJRgreOKqX8Vua8yyd5EdnzyLOSUKeLLub8ikcs0oXvinsQSJtHponMuLeu3yUA==
X-Received: by 10.159.195.8 with SMTP id bd8mr3453410plb.322.1511803092165;
        Mon, 27 Nov 2017 09:18:12 -0800 (PST)
Received: from ?IPv6:2405:204:73c7:b4fb:72c8:dd31:37ff:6021? ([2405:204:73c7:b4fb:72c8:dd31:37ff:6021])
        by smtp.gmail.com with ESMTPSA id c24sm53696929pfl.2.2017.11.27.09.18.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Nov 2017 09:18:11 -0800 (PST)
Subject: Re: [PATCH v3] launch_editor(): indicate that Git waits for user
 input
To:     lars.schneider@autodesk.com, git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com, sunshine@sunshineco.com,
        Lars Schneider <larsxschneider@gmail.com>
References: <20171127134716.69471-1-lars.schneider@autodesk.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <1bb4eeb1-eaaf-11ec-8215-08d3490577a8@gmail.com>
Date:   Mon, 27 Nov 2017 22:47:59 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171127134716.69471-1-lars.schneider@autodesk.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Monday 27 November 2017 07:17 PM, lars.schneider@autodesk.com wrote:

> Show a message in the original terminal and get rid of it when the
> editor returns.
> 

"... except in the case when an error occurs." could  be included if needed.
> +		static const char *close_notice = NULL;
> +

IIRC, this variable is bound to be `static` for sake of future proofing. 
So, I guess you could use the following suggestion of Eric Sunshine in 
the below conditional.

     If you reverse this condition to say (!close_notice && isatty(2)),
     then you save an isatty() invocation each time if close_notice is
     already assigned.

> +		if (isatty(2) && !close_notice) {
> +			char *term = getenv("TERM");
> +
> +			if (term && strcmp(term, "dumb"))
> +				/*
> +				 * go back to the beginning and erase the
> +				 * entire line if the terminal is capable
> +				 * to do so, to avoid wasting the vertical
> +				 * space.
> +				 */
> +				close_notice = "\r\033[K";
> +			else if (term && strstr(term, "emacsclient"))
> +				/*
> +				 * `emacsclient` (or `emacsclientw` on Windows) already prints
> +				 * ("Waiting for Emacs...") if a file is opened for editing.
> +				 * Therefore, we don't need to print the editor launch info.
> +				 */
> +				;
> +			else
> +				/* otherwise, complete and waste the line */
> +				close_notice = _("done.\n");
> +		}
> +
> +		if (close_notice) {
> +			fprintf(stderr, _("Launched editor. Waiting for your input... "));
> +			fflush(stderr);
> +		}
> 
>   		p.argv = args;
>   		p.env = env;
> @@ -53,11 +82,14 @@ int launch_editor(const char *path, struct strbuf *buffer, const char *const *en
>   		sig = ret - 128;
>   		sigchain_pop(SIGINT);
>   		sigchain_pop(SIGQUIT);
> +
>   		if (sig == SIGINT || sig == SIGQUIT)
>   			raise(sig);
>   		if (ret)
>   			return error("There was a problem with the editor '%s'.",
>   					editor);
> +		if (close_notice)
> +			fputs(close_notice, stderr);
>   	}
> 
>   	if (!buffer)
> --
> 2.15.0
> 

