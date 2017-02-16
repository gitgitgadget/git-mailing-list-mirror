Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3685A1FC44
	for <e@80x24.org>; Thu, 16 Feb 2017 22:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933471AbdBPWzN (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 17:55:13 -0500
Received: from mail-lf0-f44.google.com ([209.85.215.44]:36489 "EHLO
        mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933157AbdBPWzN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 17:55:13 -0500
Received: by mail-lf0-f44.google.com with SMTP id z134so15147461lff.3
        for <git@vger.kernel.org>; Thu, 16 Feb 2017 14:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rUBoBca3Jeuq6nnY20P5gpuq76uTU6yuOFKGOW8cOCI=;
        b=Nhlb+lzZ0FVDdOTE7ba+oNg+Ld6r6LODi7YZ2JBOEbVMEIruAxKS6QBm/NNSxcgmwT
         o4WAgk/+h+DJxEmYHXOekSse8cOz/+M3kV/WAJneDh3YNMKhztud51pxtTZMkEXnHX3E
         jejOmP7i6ErU723b4JQ4Nf1XdYYmajxeD0xe6iC2fgkcnmoSP30fGnsW4wALcMcAIl6b
         wr7zZ70abNh1DBwITOOQwNjUPC95W087gOja2JuHrPzWcNvtcCSDdipSe1GSnpFuyotV
         hHatBA6V0LO7CVDccJBDfMuGSDfhJj1c4xfQBe74/0fmL79fsKcFPZRK78ZiRXAggipr
         CfOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rUBoBca3Jeuq6nnY20P5gpuq76uTU6yuOFKGOW8cOCI=;
        b=uVB/ioV7c9OrAIUn73kfFZTiZasu9wiPoYi/+4YFmLftTpZT2vnq9OkjnD3LLiTcV7
         dAJ5fer5XhDkoI7MTC31uRUbQqK2/1H8qo8QgbIlRFXttHQgNbIUMhbUOFSY3JFLskp6
         agNGA0MGu/FCRAaWtrvCCdyGKrKspUQc3ESkuG4onkn5t9hNnPlAffe/OSg50vKXavm/
         Dw17COUaFQYDqE6MQ1XDf5ls7Ejt7ggz7fkRr9lhYz9yyXNejVDiIrZT1iS/mF8UhBQ2
         SgKCxxUfr6b1+cIWelOL1OYCWINgoLL3iWcLuhfTcWZP18jXEPElpkpG+GDfz/zNxA6B
         Aziw==
X-Gm-Message-State: AMke39l4cvM6Mtry6yo8kTmv/a4zUj78JoIfKQCfQr+MIE+2KGR1m0Imt6iY1KVryaJ16l4hBlhu4XPIfwrq4Q==
X-Received: by 10.46.7.18 with SMTP id 18mr16109ljh.119.1487285711284; Thu, 16
 Feb 2017 14:55:11 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.145.14 with HTTP; Thu, 16 Feb 2017 14:54:50 -0800 (PST)
In-Reply-To: <xmqqlgt5vlse.fsf@gitster.mtv.corp.google.com>
References: <xmqq8tp74823.fsf@gitster.mtv.corp.google.com> <20170216003811.18273-1-sbeller@google.com>
 <xmqqlgt5vlse.fsf@gitster.mtv.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 16 Feb 2017 14:54:50 -0800
Message-ID: <CA+P7+xpWqiWeMOMauYgtVaiUngd73_dUqRxyWcp0QPHvgOe+vg@mail.gmail.com>
Subject: Re: [RFCv4 PATCH 00/14] Checkout aware of Submodules!
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Git mailing list <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 16, 2017 at 2:00 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> Integrate updating the submodules into git checkout,...
>
> It was more or less a pleasant read, once I decided to pretend that
> I were a machine who uses identifiers only to identify locations in
> the program ;-) IOW, for human consumption, the new names introduced
> were sometimes quite confusing and went against helping understanding.
>

Based on my cursory reading, I agree. I had trouble understanding how
the process worked because the names were somewhat confusing. They
started to make some sense as I read more. I think v4 had better names
than v3, but they were still somewhat confusing to me.

Regards,
Jake
