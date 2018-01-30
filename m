Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 622701F404
	for <e@80x24.org>; Tue, 30 Jan 2018 20:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752792AbeA3UF0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 15:05:26 -0500
Received: from mail-wr0-f178.google.com ([209.85.128.178]:33746 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752060AbeA3UFZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jan 2018 15:05:25 -0500
Received: by mail-wr0-f178.google.com with SMTP id s5so12571692wra.0
        for <git@vger.kernel.org>; Tue, 30 Jan 2018 12:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=zeYQrOwYxWgB2Jryi90xPn2L4E1AZVeDGJjrwkFNq6g=;
        b=ZdVwPm3sSC3bHzZqc1erGujGLFNnEmOfR6Lt0Ee5pK/Zqn3QBlc30yUqW8xJHg5fog
         48a3YCMDE2Vvdnd6PU5PjDQXVkg1bWLhWFSlncYCd8uqivszpIZSXMfi+EI6lDv9dodn
         fMVdr/6zg6n6zL0NYFMK3YuNOG4M83hjFS8fNcN3FEZdeEh9M75SxdnT7R314cz3bni+
         VpbfFBONXVWfquv/m6ggXtVRW8peM10qsCjN+r9jFUN5JEBdVSrcBVpoMdJMn79/6zT8
         7CzqAmN/HKZgQqz2xZ5U0ktcK5ztAq3coHZSlr7wNVyBqyNYoUSc+dfxY+S4gwoMVh0E
         6+FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=zeYQrOwYxWgB2Jryi90xPn2L4E1AZVeDGJjrwkFNq6g=;
        b=iidMdt+enwihcEP0ogpNNrLArZ+IzFrIZS9cawvOF0IBoKtYWwF3f4A7wJCrBKz8zn
         gRwe7sIa4dRa7dlMZq2eKwVAu9Ac5E1SD9USot0lBfw8QnZGd9aYR0KofqaiyFAZD0YI
         Z4cWU6l8hsyilPahjwItbdNvofEDAzY+GDPdo0oxeX+m2HVaA9sBu91Az4JfO6Rv5rG5
         V5swhdpZpoIb/Wh1sn/xR2pNEHDrqztmQQNLhSLmGhIxyyHhtGGqz7lcC2YhSpjAJUcy
         aKmIFHuBL/j9yvJXmm8drSv/Q/LuzQRZsz03euEKpncrizp8iz3CwpGQD6Zbg1gRrJl0
         HDMg==
X-Gm-Message-State: AKwxytey/OumHdmg+y/e7v5LUsdeo/E2KCcpHV1XJB6ILZIWV/XUDrC/
        /Zj529CoLgQBbzxTOf6K1Cs=
X-Google-Smtp-Source: AH8x2255WoskEzUCsB2ibr7daPBSutA5WXwlKoDylQeIUC1m97anT/VcRnErvhQyNv2qAF3L9aw3CA==
X-Received: by 10.223.150.208 with SMTP id u74mr13489909wrb.193.1517342723904;
        Tue, 30 Jan 2018 12:05:23 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 14sm4894568wrb.47.2018.01.30.12.05.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Jan 2018 12:05:22 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     tboegi@web.de
Cc:     lars.schneider@autodesk.com, git@vger.kernel.org, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        --to=larsxschneider@gmail.com,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v5 5/7] convert: add 'working-tree-encoding' attribute
References: <xmqqshawfgaa.fsf@gitster.mtv.corp.google.com>
        <20180129201908.9398-1-tboegi@web.de>
Date:   Tue, 30 Jan 2018 12:05:22 -0800
In-Reply-To: <20180129201908.9398-1-tboegi@web.de> (tboegi@web.de's message of
        "Mon, 29 Jan 2018 21:19:08 +0100")
Message-ID: <xmqqzi4vt8n1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

tboegi@web.de writes:

> +	if ((conv_flags & CONV_WRITE_OBJECT) && !strcmp(enc->name, "SHIFT-JIS")) {
> +		char *re_src;
> +		int re_src_len;

I think it is a bad idea to 

 (1) not check without CONV_WRITE_OBJECT here.
 (2) hardcode SJIS and do this always and to SJIS alone.

For (1), a fix would be obvious (and that will resurrect the dead
code below).

For (2), perhaps introduce a multi-value configuration variable
core.checkRoundtripEncoding, whose default value consists of just
SJIS, but allow users to add or clear it?

> +		re_src = reencode_string_len(dst, dst_len,
> +					     enc->name, default_encoding,
> +					     &re_src_len);
> +
> +		if (!re_src || src_len != re_src_len ||
> +		    memcmp(src, re_src, src_len)) {
> +			const char* msg = _("encoding '%s' from %s to %s and "
> +					    "back is not the same");
> +			if (conv_flags & CONV_WRITE_OBJECT)
> +				die(msg, path, enc->name, default_encoding);
> +			else
> +				error(msg, path, enc->name, default_encoding);

The "error" side of this inner if() is dead code, I think.
