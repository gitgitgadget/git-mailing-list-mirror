Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28AE12013A
	for <e@80x24.org>; Wed, 15 Feb 2017 22:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752196AbdBOW2N (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Feb 2017 17:28:13 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35120 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751994AbdBOW2M (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2017 17:28:12 -0500
Received: by mail-pf0-f193.google.com with SMTP id 68so13631pfx.2
        for <git@vger.kernel.org>; Wed, 15 Feb 2017 14:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=BP5zXpG2bUgPjYJXIk1Mv+I+R+Hm7lO4PRRdWHD4Gj4=;
        b=JR/EDqcwjOdQTFzPWXe5P3qDQ1PleMxOYdFf8UAwVPkMATCNMyip+wFt7oHDXhT3Z9
         lqVgFYBuvthX8yL+203TBYtSG3Y4Hc42A55SCk65JheKHxIgFm0ujR9dKvUulO+B8sEr
         hQAdkHfv0G0z2l8AHDuBFX6WAuLDcon2FgJ74g7TnhxzU1PjSYRe6dhNfjoO4+811PHa
         7vOBLFibyYoqJkz5yda/4fZHeRJ4A0aDRTA3EjqZLGVSLSrOUyC2b6j8pUdsBkJAhm4F
         t/Qjdi5oBs/puPu/IStswCRRCQ3K6utM7iph1S+VLW24C+ubAm2oXpXF4DdlGts4ILXa
         7vTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=BP5zXpG2bUgPjYJXIk1Mv+I+R+Hm7lO4PRRdWHD4Gj4=;
        b=fQWYsNqrL8COhGt3cSGhDkBlejqf4ckoiiz+ta37o43dJBYv9Zic0ihdZAjtZ0Kmsf
         WIV63YXGJvlbJormDhVE52sG04B5ZjIkBUG9Ff+6m17Jjuc0mG58sNoHxv27YeimHR0W
         huGYALS6WV/LFXLSq7Xzd8ChSfzskMBTgiScHp7Zl3WGl6xZNNINmw5bAGp1z93/KhmM
         jIO+5K4bD5unDrMQWb/CHeQY3P51WxcQ3qOZTJNsxUoarmVSVrS4FYu8kAurq5rq64yK
         MWjXUm+HZgmKCa5N7DAVDU/HpYiG4Tezrt+302Zmv54HkW3oSfBIlbWDv5TIbQZKcdph
         syeA==
X-Gm-Message-State: AMke39l2MnUzBKav5oLsdau4tValBC0Nd38NadHmA4X1xl5jKgbCwPsZqMlm78QyTp3K8g==
X-Received: by 10.84.137.37 with SMTP id 34mr46917965plm.29.1487197691764;
        Wed, 15 Feb 2017 14:28:11 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:3551:31c7:1fe1:8b9b])
        by smtp.gmail.com with ESMTPSA id v9sm9298147pfl.102.2017.02.15.14.28.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 15 Feb 2017 14:28:10 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?Q?J=C3=A1chym_Barv=C3=ADnek?= <jachymb@gmail.com>,
        git@vger.kernel.org
Subject: Re: Confusing git messages when disk is full.
References: <CABpqov=FE-h_2s=O9fkSjFjgFXSy6hDwc2fu5ijiVvkaLx9f_Q@mail.gmail.com>
        <20170215213221.lnraiktneokpk3mg@sigill.intra.peff.net>
        <xmqqk28r2kk4.fsf@gitster.mtv.corp.google.com>
        <20170215215151.a5chtxyjhbe3og4p@sigill.intra.peff.net>
Date:   Wed, 15 Feb 2017 14:28:10 -0800
In-Reply-To: <20170215215151.a5chtxyjhbe3og4p@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 15 Feb 2017 16:51:51 -0500")
Message-ID: <xmqq7f4r2io5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>>   abort:
>>  	strbuf_release(&note);
>>  	free(url);
>> -	fclose(fp);
>> +	if (ferror(fp))
>> +		rc = -1;
>> +	if (fclose(fp))
>> +		rc = -1;
>>  	return rc;
>
> Yeah, I think this works. Normally you'd want to flush before checking
> ferror(), but since you detect errors from fclose, too, it should be
> fine.
>
> We probably should write something stderr, though. Maybe:
>
>   if (ferror(fp) || fclose(fp))
> 	rc = error_errno("unable to write to %s", filename);

Yes, and somehow make sure we do fclose(fp) even when we have an
error already ;-)
