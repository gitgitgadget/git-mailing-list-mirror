Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9F4020756
	for <e@80x24.org>; Wed, 11 Jan 2017 01:14:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760746AbdAKBOi (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jan 2017 20:14:38 -0500
Received: from mail-qk0-f173.google.com ([209.85.220.173]:36281 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760652AbdAKBOh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2017 20:14:37 -0500
Received: by mail-qk0-f173.google.com with SMTP id 11so95314915qkl.3
        for <git@vger.kernel.org>; Tue, 10 Jan 2017 17:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=M08dVtog4zKMcjZ/leQ7GvdmqnmtSCXzvbUo1k+xxs4=;
        b=IkGdbR1g6f1vCWV/ud/xKSAAY+6zDFyxLifRW+4WxWLnk5vVdnMvdmfYZSJHbYsP3t
         fa1SDyDSsEA4OHZG6WrjZ54Zd1dqpYUfVaIL+P0DHOIB5cSwLfBZSufIRLE33VMn+BNC
         H+dAVDyx6pPL0yk5YxwaCENQBILQ3LHmZRmlrH+NC+MpICFknRxbrqT+6k/ZGmbCn/7v
         aRmzbGh+AQ7NzsioklqsfVbIDonef2Vz11sSH9gjVnC824DVOnymWAZAwdMupalW++OI
         1AGk5uADbEAqTQ+9SnpJu/zukBMklIjTqM8XyJSraVvokPUtMYijWeZ51jwHdvItqAy0
         vYDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=M08dVtog4zKMcjZ/leQ7GvdmqnmtSCXzvbUo1k+xxs4=;
        b=XhFF5GLfIVgJkPXoZ7OQl4evKCAIzyL2yhgOnoKHpJL5i1vhoIMx2BImhxvhnccHSP
         BP3jKbbYHA2NyhhnGw4k7+/jdJSjYle7AO9+TbTfvrXCb/5SOFsK8zrlTrWTFRV7tgW5
         SayZxYM0hUpgTxNZG8rRINujKM4WFc5jQY4+TgSAzNkBOQme0lX+hyrkk7qk2j7Y0Dcb
         ax2Tdb4VCPdDF16/ctutJ73P87DTcMckXSww1LkSaPLZlWJI8jCttJk85/h18kFuEFrs
         IUGb+2l24A3WEZeTyZM21Gx6UwvBv4OB1CKKQb89nZC/4DBdGNruCwdnEK+Hqpp5UmMt
         pqxQ==
X-Gm-Message-State: AIkVDXJ0j3V4phSKQnF+gJdLqjnB4OgsgJRklmOUsHO3DDXMC9ey/Jz7vjbG66gHsUpHAQv2
X-Received: by 10.55.201.141 with SMTP id m13mr5426542qkl.247.1484097276292;
        Tue, 10 Jan 2017 17:14:36 -0800 (PST)
Received: from hansenr.cam.corp.google.com ([2620:0:1004:2:8459:597d:aa56:dd3a])
        by smtp.gmail.com with ESMTPSA id g130sm2828666qkb.35.2017.01.10.17.14.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jan 2017 17:14:35 -0800 (PST)
Subject: Re: [PATCH 2/2] diff: document the pattern format for diff.orderFile
To:     Junio C Hamano <gitster@pobox.com>
References: <20170110004031.57985-1-hansenr@google.com>
 <20170110004031.57985-3-hansenr@google.com>
 <xmqq8tqismdx.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org
From:   Richard Hansen <hansenr@google.com>
Message-ID: <17d48ccd-fd19-3922-8ee8-af6558d22632@google.com>
Date:   Tue, 10 Jan 2017 20:14:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <xmqq8tqismdx.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-01-10 15:14, Junio C Hamano wrote:
> Richard Hansen <hansenr@google.com> writes:
>
>> Document the format of the patterns used for the diff.orderFile
>> setting and diff's '-O' option by referring the reader to the
>> gitignore[5] page.
>>
>> Signed-off-by: Richard Hansen <hansenr@google.com>
>> ---
>>  Documentation/diff-config.txt  | 3 ++-
>>  Documentation/diff-options.txt | 3 ++-
>>  2 files changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
>> index 875212045..a35ecdd6b 100644
>> --- a/Documentation/diff-config.txt
>> +++ b/Documentation/diff-config.txt
>> @@ -100,7 +100,8 @@ diff.noprefix::
>>
>>  diff.orderFile::
>>  	File indicating how to order files within a diff, using
>> -	one shell glob pattern per line.
>> +	one glob pattern per line.
>> +	See linkgit:gitignore[5] for the pattern format.
>
>
> I do not think it is wise to suggest referring to gitignore, as the
> logic of matching is quite different, other than the fact that they
> both use wildmatch() internally.  Also, unlike gitignore, orderfile
> does not allow any negative matching i.e. "!<pattern>".

I was looking at the code to see how the two file formats differed and 
noticed that match_order() doesn't set the WM_PATHNAME flag when it 
calls wildmatch().  That's unintentional (a bug), right?

-Richard


>
>>  	If `diff.orderFile` is a relative pathname, it is treated as
>>  	relative to the top of the work tree.
>>  	Can be overridden by the '-O' option to linkgit:git-diff[1].
>> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
>> index e6215c372..dc6b1af71 100644
>> --- a/Documentation/diff-options.txt
>> +++ b/Documentation/diff-options.txt
>> @@ -467,7 +467,8 @@ endif::git-format-patch[]
>>
>>  -O<orderfile>::
>>  	Output the patch in the order specified in the
>> -	<orderfile>, which has one shell glob pattern per line.
>> +	<orderfile>, which has one glob pattern per line.
>> +	See linkgit:gitignore[5] for the pattern format.
>>  	This overrides the `diff.orderFile` configuration variable
>>  	(see linkgit:git-config[1]).  To cancel `diff.orderFile`,
>>  	use `-O/dev/null`.

