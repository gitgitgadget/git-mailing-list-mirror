Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31F1920954
	for <e@80x24.org>; Wed, 29 Nov 2017 02:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752470AbdK2CIz (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Nov 2017 21:08:55 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:38343 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752269AbdK2CIy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Nov 2017 21:08:54 -0500
Received: by mail-it0-f68.google.com with SMTP id r6so2263701itr.3
        for <git@vger.kernel.org>; Tue, 28 Nov 2017 18:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2SXGZBwETpcAJn8BCrpgUZJVP2w3/XZwM/RS5yqsHdI=;
        b=d/Yvg+W9fPivF877vvSE7d86cX2O5ZvleDBiXjEgu/fOs7Qv1Lhh/yKSomb4RpqTyT
         ym65LvDfjBOGgkIpflnQvxXusTn6mHRA6nInRkI/ZHXAkHN9gKu1T3ZIc3hqcYZI6qIy
         HrfFiUoyGxVqHjcwax9uxmJUtXeYVENWSQPBDMumpDMitRZLPvIxo6R7r+iBIU1QVY97
         cHlrhcNeQ/7Z52hR0SvIgXi2KKUb/xwr/7hKDHn76DNPWdVlOhP4BlUM7nKKnsz27z17
         FJPzCOEBTSmTbUa3QZY7RseXY2hhepQh/7y83zOxJA/l9nCCYBovfEQihzCu5hXi3N5Y
         ii/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2SXGZBwETpcAJn8BCrpgUZJVP2w3/XZwM/RS5yqsHdI=;
        b=Fn1BgVe6WZZBDnPb2kNBcwqSDwPSb950hj0fN104xaA0U6qKbxL/K+NJix2nTw4tfl
         W5Xac2x/ZHLh6qM+GtNdJOXT8KMtHEiU3MXJO7kNnP1gft9zH5yzVzluhQP3LSXcflOz
         zQlyugIGdM4MlSzG0OIpjlEwFIbEryAQMoUFODclqR1pCGHB/vTIrvF4cb6/q/BmtirF
         XaPf8cbQ0JUr/EX+P3yAfR5qkteZarnCcy1TGvVOfAwidlXV83OqTcJtAP86dPXqPVVw
         TAh/4VKSGv4uwxvTpNXWQH9OxUynC6DDTIhEp14kbqHVoVS60ZbgwSmOHEQ7yPsO2bzP
         FJrA==
X-Gm-Message-State: AJaThX66fRZ6qlwZ+eAWzdkbKYzEu4TpghIi5B63hXU/Z2zWrPqXcBHe
        A21hwVtQh3wdl2UhPirEnT9W8Nut3pU=
X-Google-Smtp-Source: AGs4zMZCJ5wXmiib1c6xbg1nJPnfjD0Dri/LGt+/vZ3Dal1NFK8LqdjEtpFe5ux6bvZ/74rkZEPqyg==
X-Received: by 10.36.89.73 with SMTP id p70mr893568itb.23.1511921333912;
        Tue, 28 Nov 2017 18:08:53 -0800 (PST)
Received: from [192.168.3.104] (24-212-246-46.cable.teksavvy.com. [24.212.246.46])
        by smtp.gmail.com with ESMTPSA id d186sm493634itd.22.2017.11.28.18.08.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Nov 2017 18:08:53 -0800 (PST)
From:   liam Beguin <liambeguin@gmail.com>
Subject: Re: [PATCH 4/5] rebase -i: learn to abbreviate command names
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de, avarab@gmail.com
References: <20171127045514.25647-1-liambeguin@gmail.com>
 <20171127045514.25647-5-liambeguin@gmail.com>
 <xmqq1skke1so.fsf@gitster.mtv.corp.google.com>
Message-ID: <edecde30-dfde-89a7-3110-c791f4ee3a38@gmail.com>
Date:   Tue, 28 Nov 2017 21:08:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <xmqq1skke1so.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On 27/11/17 12:19 AM, Junio C Hamano wrote:
> Liam Beguin <liambeguin@gmail.com> writes:
> 
>>  	if (command == MAKE_SCRIPT && argc > 1)
>> -		return !!sequencer_make_script(keep_empty, stdout, argc, argv);
>> +		return !!sequencer_make_script(keep_empty, abbreviate_commands,
>> +					       stdout, argc, argv);
> 
> This suggests that a preliminary clean-up to update the parameter
> list of sequencer_make_script() is in order just before this step.
> How about making it like so, perhaps:
> 
>     int sequencer_make_script(FILE *out, int ac, char **av, unsigned flags)
> 
> where keep_empty becomes just one bit in that flags word.  Then another
> bit in the same flags word can be used for this option.
> 
> Otherwise, every time somebody comes up with a new and shiny feature
> for the function, we'd end up adding more to its parameter list.
> 

Will do.
Thanks, 

Liam
