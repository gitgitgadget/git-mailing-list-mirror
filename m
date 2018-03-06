Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24BD51F404
	for <e@80x24.org>; Tue,  6 Mar 2018 19:45:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753831AbeCFTpn (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Mar 2018 14:45:43 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:40372 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933348AbeCFTof (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Mar 2018 14:44:35 -0500
Received: by mail-wr0-f193.google.com with SMTP id o76so22165492wrb.7
        for <git@vger.kernel.org>; Tue, 06 Mar 2018 11:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2Pkn11oDFO1ujX1ax/R1Ze5JxqH87sL8qfl/bIZ5qHw=;
        b=mT/rP744CRlQg5Z03ccX8jBqIEtV4FscNJAxBo/l5AQeZzWatO4cBB7WWKLXPDbGpZ
         svSXzkoxN1gVs4b0/XaOf+iZYXzb/p/S6Z40XdBgNtcR2/V1ptMEHLjtT/YchFdIQtye
         /slbfZk+pPzRO7DF6e+9x0dxoS7AsSV2jPFV/KEAFucJ3fQhRUcKVIyTdF+rCvbA/lgr
         Abh8/Ycz5HEL/D0iGVQR1/8Qx2RD4sT8RBIhwXiJZhZkNUm7cXaOLpt1SPM4TaH09eh9
         Q7MJjvLtmJgpezwcLtHxdvz2vZBWVdK+lV/vb1fK4FYAOjgaZLzDUQszPFjvcgolx/Yv
         V/6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2Pkn11oDFO1ujX1ax/R1Ze5JxqH87sL8qfl/bIZ5qHw=;
        b=rADyxz7Io5esvnCheWOJ2ymxlRKHs51Web1xDUpNKx0BWGpC9Gx8YhhhLLTQhfGylp
         LsgX/mtYjC140mfGdwYGAbO9kakuL4bZ/e3RXKMiuJ46UFseB+kIVuUAz836XyeZK4Eg
         bRv0FpXpo/7Gr1uBMu+uFbCF1tL0rhsbY88lXgdJXF+rjoVSdUuNhjl01VONLw65Y3VY
         QfQx4FN40254qO3zNoZrX3uX2y+0eGlv6tsOn8UkhZB/p77bEQWKsZgCfnO8vMZmwzNi
         b+2oRA41b+f/n2jTyKrlSk489Wn7H2xQ75sbUYQ4eMNLuffhtGKMrzdE2G9CBz5W/rRm
         7LpQ==
X-Gm-Message-State: APf1xPAW1rn63h2yRBy5LLaxvOW4V6iobWz1B3lZ9IaVwp8C8h97d1Pr
        wq3FxhG668oT5mOM6KpjCz4=
X-Google-Smtp-Source: AG47ELupGy5vrzO8vbN/4fQ9TZlR0aJT6yu2gF0It+dPLWjymUkTwWgRnhrtGxKfqkHOk6gihYBY5w==
X-Received: by 10.223.165.67 with SMTP id j3mr17794568wrb.111.1520365474005;
        Tue, 06 Mar 2018 11:44:34 -0800 (PST)
Received: from sebi-laptop ([91.250.255.140])
        by smtp.googlemail.com with ESMTPSA id p12sm12706854wre.89.2018.03.06.11.44.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Mar 2018 11:44:33 -0800 (PST)
Message-ID: <1520365472.27478.7.camel@gmail.com>
Subject: Re: [GSoC][PATCH v3] Make options that expect object ids less
 chatty if id is invalid
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Date:   Tue, 06 Mar 2018 21:44:32 +0200
In-Reply-To: <xmqqzi3m6ooi.fsf@gitster-ct.c.googlers.com>
References: <20180303210938.32474-1-ungureanupaulsebastian@gmail.com>
         <xmqqzi3m6ooi.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Junio,

Thank you for reviewing my code. I appreciate it. I made the changes
here [1].

On Mon, 2018-03-05 at 16:19 -0800, Junio C Hamano wrote:
> Taking these together, I _think_ this patch is moving things in the
> right direction, in that it allows callers of parse_options_step()
> to tell "user knew what option s/he wanted, and sufficient error
> message has already be given" and "user gave us a nonsense option
> and would be helped by usage text" cases apart by introducing a new
> value PARSE_OPT_ERROR, but in order to be able to correctly give
> PARSE_OPT_ERROR back to the caller, parse_long_opt() and
> parse_short_opt() (possibly, but I didn't check) would need a bit of
> tweak to help their callers in this function.

I am not sure I got this right, but I believe this is already done.

- If an error occurs during value parsing in parse_short_opt or
parse_long_opt then -1 is returned and parse_option_step returns
PARSE_OPT_ERROR.

- If parse_short_opt and parse_long_opt encounter an unknown option
then -2 is returned and parse_option_step returns PARSE_OPT_UNKNOWN
(but only if PARSE_OPT_KEEP_UNKNOWN is not specified).

- If usage is shown by calling usage_with_options_internal then
PARSE_OPT_HELP is going to be forwarded and also returned by
parse_options_step.

What I also changed in the new patch [1] is to make parse_long_opt
return -3 when ambiguous option are found, in which case
parse_options_step will handle this return value by showing usage and
returning PARSE_OPT_HELP.

Please correct me if I am wrong.

[1] https://public-inbox.org/git/20180306193116.23876-1-ungureanupaulse
bastian@gmail.com/T/#u

Best regards,
Paul Ungureanu

