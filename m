Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88E281F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 17:06:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730812AbeJLAec (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 20:34:32 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37313 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727795AbeJLAec (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 20:34:32 -0400
Received: by mail-wr1-f67.google.com with SMTP id y11-v6so10514624wrd.4
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 10:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CTZMNQsNBL0paP0iKsTh3p0/cgHsQwFcQmAiH+MbLdI=;
        b=CNOuv0qpsVFSOyu8toM2qFJVlsPDjW27UAsL1t11kugTAcxZjpbiq9eltPEVYQXIZG
         +WezVuljK/1zGtdD2u61ywxWBR4Y/tAg68Vox2qc1O/j+2JEIXI95u6gQjIgUpji0L55
         U6Q/aD5ciZDnDCx4hvwYaDk3zCZ/JxTOcVFQiX9I5y8QgqAY0E5KPIc63sAxcbnxcWO1
         ncTwojl7A2a9dbtZDjGvsQD5OXbsz3NH30ROy6YIySiML4oKhmaFy4c/EAUmOryt4JMS
         54GpDKcjVk5DyNUEGplO/Q2VLvn38VqCqOOJkJyIDG77Kr/ZRyWf3QWF2HY9KgrsBDT+
         9fCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=CTZMNQsNBL0paP0iKsTh3p0/cgHsQwFcQmAiH+MbLdI=;
        b=TEajxsAwyIlIKZQSYcQOCAdKwAbuxvNoOczKAXMb8PyEwSof7b3N4mTCIQr8mPVAea
         9sS+/C82tRuYGwEgTEY4LTJylbHkQtPk/UwGORG+Uh1iWl0wktKArS5hhlH67BH0mg0u
         PENqLrQBxACq9urhvSSJXRvXoascQNMDM3z9IQgM/Dsfwdv2SR9toLR85TqPPmjk6aka
         9f/qqjGXF8sjvanmebpqe2g3G8T9oe7tNDMao4HSA2XqHcXTLuUFryQW2Fx1nwEE/1Mr
         H7Buh5FO27Ka4ZzbN4tbiajp7Io11utWZA5D1Ku/u8eK+Bd9ug4suoaFlA+o41Ehumto
         Wk2w==
X-Gm-Message-State: ABuFfojoeDkHFfCtKkex2BdYCF9M1XuBmGNspi4TogDfFxCLwphZUKSs
        +SeKZ+WOcBsT7COZNu0Kv5w=
X-Google-Smtp-Source: ACcGV62V+ARYoDlB2PivTf07IfC9b2i/jekxWDMNm/6BZjRUXSBYqsJ9X/q1ks/F53rwfjJLZtXIzA==
X-Received: by 2002:a5d:4d09:: with SMTP id z9-v6mr2334269wrt.298.1539277583852;
        Thu, 11 Oct 2018 10:06:23 -0700 (PDT)
Received: from [192.168.0.104] (AToulouse-658-1-60-162.w92-136.abo.wanadoo.fr. [92.136.157.162])
        by smtp.gmail.com with ESMTPSA id 4-v6sm17030149wmt.16.2018.10.11.10.06.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 10:06:23 -0700 (PDT)
Subject: Re: [PATCH 08/15] sequencer: change complete_action() to use the
 refactored functions
To:     phillip.wood@dunelm.org.uk, git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <20181007195418.25752-1-alban.gruin@gmail.com>
 <20181007195418.25752-9-alban.gruin@gmail.com>
 <d0adf861-3046-f0b6-3217-c89d92319e43@talktalk.net>
From:   Alban Gruin <alban.gruin@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=alban.gruin@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <d14281c1-6beb-50fe-e9aa-3d8555aa307d@gmail.com>
Date:   Thu, 11 Oct 2018 19:06:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <d0adf861-3046-f0b6-3217-c89d92319e43@talktalk.net>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le 11/10/2018 à 15:51, Phillip Wood a écrit :
> On 07/10/2018 20:54, Alban Gruin wrote:
>> +    if (rewrite_file(todo_file, new_todo.buf.buf, new_todo.buf.len) <
>> 0) {
>> +        todo_list_release(&new_todo);
>> +        return error_errno(_("could not write '%s'"), todo_file);
>> +    }
> 
> rewrite_file() can truncate the old version of the file if there is an
> error when writing the new version, I think it would be better to use
> write_message() instead as that atomically updates the file. The same
> applies to patch 5 (refactor rearrange_squash()) after which I think
> there will be no callers to rewrite_file() so it can be deleted.

You’re right, I didn’t notice that.

> 
> Best Wishes
> 
> Phillip
> 

Cheers,
Alban

