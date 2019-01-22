Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A49C1F453
	for <e@80x24.org>; Tue, 22 Jan 2019 21:38:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfAVViZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 16:38:25 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46384 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfAVViZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 16:38:25 -0500
Received: by mail-wr1-f68.google.com with SMTP id l9so8716wrt.13
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 13:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:mime-version:to:cc:subject:references
         :in-reply-to:content-transfer-encoding;
        bh=sPgGpn53Y42vEz1As/tr3xTZPnMwyo+cRgzA3Lh40To=;
        b=pNO6nV/pHcJekj6kLrMY8XOapILiKg4w4cJ0/yrAeU6/Dmz3TMFgHaCVmeI1n1Sqxh
         pek47giD/mgyM/O/vuNlu2KrIG/ITQpQ4dWG8iCPCK0IfOBiFNJ+G7qqeM/t3Ns99Wfj
         ofJSThJbiRyyiZAxttwKgu3iJNbnpvGhw3CVjBg80w6J+df1aQP3wCINnoIyAlQQEMuT
         gSssxaRW27m50FL4ZrbmIbn1q1+NXMhLFJFrly84DRogzG9gbAYnRyQ/UvT2OeWm0vYU
         fk5v8BSOwGz2PkJuig+EYeAwEXWnvrcEQLDoysBu3P+L5rWD3x7QR6zDVCw7C4l3BxLF
         SRXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:mime-version:to:cc:subject
         :references:in-reply-to:content-transfer-encoding;
        bh=sPgGpn53Y42vEz1As/tr3xTZPnMwyo+cRgzA3Lh40To=;
        b=GobfcvXKkbzXK2S7h+Yn+It95HtTceR0nDakLn8wwAuru3UpuJjiS/ezBg+B2EDhNL
         s7C6fXn0OcHBq5Wnfbm3zhW/TzgDKRQHsH+aOn+dwB5r1R6ai245uvFqMGrQLkU3O767
         UP0sdJDksN3OVQrcGKqClNPn2h5MxPW6WiDhTATUBdGpwEu8lDPROVJhBEaZ9Q1nlBge
         agU0WoPuSZKXe4PSIzJmzr/e4+YnQ5DknCj0ZF2cR2Cl3t33RmfGawT+lqGlITn6nTAx
         2GmxiGXA8XOdUS83xerlKMJseMyfkr+uRdeLOMWg9oxRInyHGjhiIL6CZ0BZA13C59Ym
         n9MQ==
X-Gm-Message-State: AJcUukc3Hhh7RUHj9wdcoHm2cpX9TODGO3IdKpYEPc+ZeTObq07mlPFK
        Zyl0epmI3YKscl+7DQYWl1zmbjiz
X-Google-Smtp-Source: ALg8bN55ILb+QKImFQ22GNheIOEyBxk7kkUYIJnq99kzZX7O4Z9OObGySwID2qChfIrCPt/Lyk6UdA==
X-Received: by 2002:adf:f550:: with SMTP id j16mr34180162wrp.258.1548193103266;
        Tue, 22 Jan 2019 13:38:23 -0800 (PST)
Received: from [192.168.1.75] (13.162.125.91.dyn.plus.net. [91.125.162.13])
        by smtp.gmail.com with ESMTPSA id i186sm68714603wmd.19.2019.01.22.13.38.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 13:38:19 -0800 (PST)
Message-ID: <5C478D44.2070405@gmail.com>
Date:   Tue, 22 Jan 2019 21:38:12 +0000
From:   Sven van Haastregt <svenvh@gmail.com>
MIME-Version: 1.0
To:     Junio C Hamano <gitster@pobox.com>
CC:     git@vger.kernel.org
Subject: Re: [PATCH] git-submodule.sh: shorten submodule SHA-1s using rev-parse
References: <20190120204653.3224-1-svenvh@gmail.com> <xmqqfttkfnmy.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqfttkfnmy.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/01/19 20:22, Junio C Hamano wrote:
> One thing it is not clear to me is that this codepath is prepared to
> handle sha1_src and sha1_dst referring to an object that does not
> exist (i.e. $missing_(src|dst)=t); the original code will still give
> us 7 hexdigit to show on the headline, but does the updated code
> that uses "rev-parse --short" give us a reasonable output?

Good point, I expect it will output an error message in that case.  I 
suppose we can fallback to the old echo and cut if the object does not 
exist; I'll update the patch.

>> diff --git a/git-submodule.sh b/git-submodule.sh
>> index 5e608f8bad..a422b0728d 100755
>> --- a/git-submodule.sh
>> +++ b/git-submodule.sh
>> @@ -850,8 +850,8 @@ cmd_summary() {
>>   			;;
>>   		esac
>>
>> -		sha1_abbr_src=$(echo $sha1_src | cut -c1-7)
>> -		sha1_abbr_dst=$(echo $sha1_dst | cut -c1-7)
>> +		sha1_abbr_src=$(GIT_DIR="$name/.git" git rev-parse --short $sha1_src)
>> +		sha1_abbr_dst=$(GIT_DIR="$name/.git" git rev-parse --short $sha1_dst)
>>   		if test $status = T
>>   		then
>>   			blob="$(gettext "blob")"
>

