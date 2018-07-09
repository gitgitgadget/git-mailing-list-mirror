Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2A301F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 07:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754431AbeGIH7g (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 03:59:36 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35423 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754210AbeGIH7f (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 03:59:35 -0400
Received: by mail-lj1-f193.google.com with SMTP id p10-v6so7974660ljg.2
        for <git@vger.kernel.org>; Mon, 09 Jul 2018 00:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zCWMBnvwXRKNmlYvpzGTXcU2cpBEN59ikASJYCdb/UE=;
        b=RzZmN0JEoc3CuZEYsXCcP2iNzOOkxhSej7sSHdJY6NdlxDxrKm9isopUuFq7kLxJ2+
         HbXjMqyP6R7As5L6FOzqBDPKnwvaoE8/3MorvKHogyhKPdhcPiGo22/ig6YocouSG+Td
         tQALW9m5ghRe4JFJ+ltYw6wzkhopEwyQfzcfua8W0jgoQbbBMJLnNa1KgiecJ3tNe6iE
         Gwd7LS4IXceR05cLf3Bwz17ULjtCN0PkwHcjmMo6OdSnB4iUVshyIBVcOEeCsAwjQFQK
         rbLuZ3cMQgP6oHsSfAPKit+8p6BqeSQ0vSs/brls8AUv6V3979Y7aPzyrxB4zczZ4Uxq
         +Qcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zCWMBnvwXRKNmlYvpzGTXcU2cpBEN59ikASJYCdb/UE=;
        b=VLYHtRkwVyDeww+W8n90RsKD6BjrwZ3bRVlV3YOXqx5piMTrnWaPiq64zMnaCX8UJd
         xTqSC0A1KrmPxeB6+TOoR0sXXK8y3ywZjTzYCPxOMCSkJ45esi/0rswC3gCBubWQseH9
         +F+SREe1WKVfwEtHeXIyhifsE2Pr70skxfyF4Onhm5B2z7TnKQfDWI9FY9D8OtOIzrqm
         0qFYmY75O0RpF0j7UtfUet1SCOxdpuYxwXx32AW+OKqE/y604pqLngAAquF2S06SidHH
         xNXjE+S/0vZGN93DpGQ524V8eZH0D7Rq8G3Ipm/eegVS6ciix/Ok8Q40TVo82M8SpTcE
         NkEA==
X-Gm-Message-State: APt69E0Te8m1R+vq6kWWIjLOIJ5vXUzocmwEZex2cXjxAfBtHhRD1XwM
        1pF1o53ieADV/CeD/Vn3Mgk=
X-Google-Smtp-Source: AAOMgpfKJeraRWgC00dS5UU5G7LaYSZtjP2gP4rWDYeTT9tzUjtguQo4e2RMQWRG1du5AfPpgAPx0A==
X-Received: by 2002:a2e:428e:: with SMTP id h14-v6mr11576086ljf.136.1531123173753;
        Mon, 09 Jul 2018 00:59:33 -0700 (PDT)
Received: from [192.168.221.164] ([185.79.217.61])
        by smtp.gmail.com with ESMTPSA id p74-v6sm3732228lfg.88.2018.07.09.00.59.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 00:59:32 -0700 (PDT)
Subject: Re: [PATCH v4 1/4] rebase: start implementing it as a builtin
To:     Pratik Karki <predatoramigo@gmail.com>, git@vger.kernel.org
Cc:     christian.couder@gmail.com, Johannes.Schindelin@gmx.de,
        sbeller@google.com, alban.gruin@gmail.com, gitster@pobox.com
References: <20180628074655.5756-1-predatoramigo@gmail.com>
 <20180708180104.17921-1-predatoramigo@gmail.com>
 <20180708180104.17921-2-predatoramigo@gmail.com>
From:   Andrei Rybak <rybak.a.v@gmail.com>
Message-ID: <857b04d8-37b4-596f-6f3e-45b6e2a59442@gmail.com>
Date:   Mon, 9 Jul 2018 09:59:31 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <20180708180104.17921-2-predatoramigo@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018-07-08 20:01, Pratik Karki wrote:
> +
> +static int use_builtin_rebase(void)
> +{
> +	struct child_process cp = CHILD_PROCESS_INIT;
> +	struct strbuf out = STRBUF_INIT;
> +	int ret;
> +
> +	argv_array_pushl(&cp.args,
> +			 "config", "--bool", "rebase.usebuiltin", NULL);
> +	cp.git_cmd = 1;
> +	if (capture_command(&cp, &out, 6))
> +		return 0;

Does strbuf out leak on return here?

> +
> +	strbuf_trim(&out);
> +	ret = !strcmp("true", out.buf);
> +	strbuf_release(&out);
> +	return ret;
> +}


