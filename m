Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA086208EB
	for <e@80x24.org>; Wed,  8 Aug 2018 15:17:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbeHHRh3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 13:37:29 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38985 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727602AbeHHRh3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 13:37:29 -0400
Received: by mail-wm0-f68.google.com with SMTP id q8-v6so3159440wmq.4
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 08:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UYui82gxuz2PeueE0O2vjoB8oLrcR1ItkVWFjTsajVg=;
        b=DOBMHYSb5+U4LSYlE3nByjwZk+RgnOyEtwP8rsvAlPzQjfInC+EzJ6h2mKgrxOnzpb
         kmiFKlGvlHqmvs4/taPsr3twcuVcTWoi6cHiZ4FTRJUeZwYBcCOet6ROCjQZSx4HMa1l
         YUtv+EE+Ju4rl4sqTTQltGw7hRunWB5CsfA6+qAv0mhlCG6OWbEDhdYxPsDb4sWvCusV
         5wknOVIan+BZCD9E2AKlxEORiUppcPkJQiSgPXVE69yjhuMcbjBp79ZsfSmTPeudjzrG
         x3l9E2W0c//f0iTMQppSLUEjdxHGYrDn0Xkjqfj/KTXW01Ep56iojukU6+qduBzFHiFf
         AdqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UYui82gxuz2PeueE0O2vjoB8oLrcR1ItkVWFjTsajVg=;
        b=DPr6kZWKKOnlpHr9VSCdRjLpQYk1UytAqZO8veDrpxABGzE3DPfZ4ANVRzBV82KW6v
         98NbxhRf5g7GYSqvhZ5JqbQh59bG0A7ehGhcfqBOGfjpcF0FMVfGh9BaEkNgu2vCevmm
         p3k42Pm42gcKEmS2o/MJOVVYUgBXtLoa0hZW+2D10rr/V11idIBWfsTUF2r52FEbsI/Z
         woEArUC/oPdkwoDnn4/wI9QsYiILuKFCLmr1CbxnAwyd6ODSkIHCuGxcNbZ3IvWLN8TX
         hgZjfPO/E+LPUuuMCZcABzuUA8MMTYMoNYoUesifTuDYfyMkBB88ffENXsTP4IeNFmMG
         +GUg==
X-Gm-Message-State: AOUpUlHuIgmkBkg/SaoByxTYIlT4MLj6Xvf585OXaRhKyU3eZETrOosJ
        oVPbyiPu4Sx5ePBAtL+KRpE=
X-Google-Smtp-Source: AA+uWPyIzpg8ArE23K9LbwB6OPEiBVav2Czfdo+xZ9FiWd5reHsjhMv4JmsXtcfZ6OqYIDQ6/RI6hg==
X-Received: by 2002:a1c:4885:: with SMTP id v127-v6mr2100085wma.161.1533741441006;
        Wed, 08 Aug 2018 08:17:21 -0700 (PDT)
Received: from [192.168.0.104] (AToulouse-658-1-30-228.w86-222.abo.wanadoo.fr. [86.222.29.228])
        by smtp.gmail.com with ESMTPSA id e137-v6sm8014209wma.20.2018.08.08.08.17.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 08:17:20 -0700 (PDT)
Subject: Re: [GSoC][PATCH v5 04/20] rebase -i: rewrite the edit-todo
 functionality in C
To:     phillip.wood@dunelm.org.uk, git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        gitster@pobox.com
References: <20180724163221.15201-1-alban.gruin@gmail.com>
 <20180731180003.5421-1-alban.gruin@gmail.com>
 <20180731180003.5421-5-alban.gruin@gmail.com>
 <325fd5d2-2a93-2270-7d1e-394c265f42d4@talktalk.net>
From:   Alban Gruin <alban.gruin@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <6826d318-b0ab-4e8e-e2ba-5425e3bf6f5f@gmail.com>
Date:   Wed, 8 Aug 2018 17:17:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <325fd5d2-2a93-2270-7d1e-394c265f42d4@talktalk.net>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

Le 07/08/2018 à 16:00, Phillip Wood a écrit :
> On 31/07/18 18:59, Alban Gruin wrote:
>> +
>> +int edit_todo_list(unsigned flags)
>> +{
>> +	struct strbuf buf = STRBUF_INIT;
>> +	const char *todo_file = rebase_path_todo();
>> +	FILE *todo;
>> +
>> +	if (strbuf_read_file(&buf, todo_file, 0) < 0)
>> +		return error_errno(_("could not read '%s'."), todo_file);
>> +
>> +	strbuf_stripspace(&buf, 1);
>> +	todo = fopen_or_warn(todo_file, "w");
> 
> This truncates the existing file, if there are any errors writing the
> new one then the user has lost the old one. write_message() in
> sequencer.c avoids this problem by writing a new file and then renaming
> it if the write is successful, maybe it is worth exporting it so it can
> be used elsewhere.
> 
>> +	if (!todo) {
>> +		strbuf_release(&buf);
>> +		return 1;
>> +	}
>> +
>> +	strbuf_write(&buf, todo);
>> +	fclose(todo);
> 
> There needs to be some error checking after the write and the close
> (using write_message() would mean you only have to check for errors in
> one place)
> 

Right.  Should I find a new nawe for write_message()?

Cheers,
Alban

