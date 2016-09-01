Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 267281F6BF
	for <e@80x24.org>; Thu,  1 Sep 2016 23:35:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752804AbcIAXfq (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 19:35:46 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:38853 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752778AbcIAXfo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 19:35:44 -0400
Received: by mail-wm0-f49.google.com with SMTP id 1so6068166wmz.1
        for <git@vger.kernel.org>; Thu, 01 Sep 2016 16:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=t8DIxw4DTykGFvVnSDHsMsTIjHXQJPjOyrDquSBVC0U=;
        b=Ppk2tgjHpuxt+cVhGFjjnLUukZhMIiIXbV1whJeuYfAsPMoFjeMVAkNt5IvVuDLMwH
         JTTKW0Pj9J+iB8d4vrcbn9L9OkptRzm/lZYfnOjfUgO4ZYIMITSHOA6GEsQI2Jj6vOte
         rHHrqGYanMQEshKcn2otOuyjTYIvfZE4mhYZ1mK88o6Am20fVEYhW20hJh1F/VOHMci+
         BM8AcVVShueC4qrTa+GC+qK6JhZyh1tjYgVWHiTCcD2o5C5OzxFcfgx2nqeE/lFM8yX4
         m/cB5BjrYkFrqzuwfVoKfZDK5YnYKxlQRineGb7N1zXnllhHAz6UMrcgh6Hmzt95VIC/
         Eabg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:newsgroups:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=t8DIxw4DTykGFvVnSDHsMsTIjHXQJPjOyrDquSBVC0U=;
        b=i3LG9U+vEofvaaq1VFJk/iK2nTvvbTYaAgodhra1PoR2S/TJcNCQsVRJwghojc5UKL
         J8JtsWPaXS9XaDdP7J8NZcF6gQWDkhzCBcchtFT4UiUFK2BKjxGRjukOW8Q9MXe5eA8W
         Q+wBuKpVRIOK21d9p2p+UK1+j2ZV21kprZpAZNIFNC9s7wFo8Y9kl7BfT/6n3rm5pE3x
         GLB4QsqZEg0mioTIJEAImPMvtrd/uXzbSpdFIaViy8pfOClqiG+bYJuN8V5oSXf3+dxG
         0bTwSINAA243HzauNF3Z3w8AqMrNOo/3aDGOVGM9qSaueOqrpVYKFrqYVkvvalIiMfrc
         cqMA==
X-Gm-Message-State: AE9vXwPZ31O08RayOGAw29Riyej3fC2+YLbZluzJZoVi5ZKAakGENtxQ7SVP1gS2Sci3bg==
X-Received: by 10.194.127.163 with SMTP id nh3mr16466129wjb.74.1472772943020;
        Thu, 01 Sep 2016 16:35:43 -0700 (PDT)
Received: from [192.168.1.26] (abrf30.neoplus.adsl.tpnet.pl. [83.8.99.30])
        by smtp.googlemail.com with ESMTPSA id w203sm709389wmw.7.2016.09.01.16.35.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Sep 2016 16:35:42 -0700 (PDT)
Subject: Re: [PATCH 22/22] sequencer: refactor write_message()
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
 <cb4253698ae3eca066c031e0aec4e83ede1fa3e5.1472457609.git.johannes.schindelin@gmx.de>
 <4c0ee8f6-1302-1dcc-602d-7a84150ec39d@gmail.com>
 <alpine.DEB.2.20.1609011619220.129229@virtualbox>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Newsgroups: gmane.comp.version-control.git
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <dbc1b08c-a151-29ab-a5a2-45343ca556d6@gmail.com>
Date:   Fri, 2 Sep 2016 01:35:36 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1609011619220.129229@virtualbox>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Johannes,

W dniu 01.09.2016 o 16:20, Johannes Schindelin pisze:
> On Thu, 1 Sep 2016, Jakub Narębski wrote: 
>> W dniu 29.08.2016 o 10:06, Johannes Schindelin pisze:

>>>  	if (commit_lock_file(&msg_file) < 0)
>>>  		return error(_("Error wrapping up %s."), filename);
>>
>> Another "while at it"... though the one that can be safely postponed
>> (well, the make message easier to understand part, not the quote
>> filename part):
>>
>>   		return error(_("Error wrapping up writing to '%s'."), filename);
> 
> As I inherited this message, I'll keep it.

Well, please then add quotes while at it, at least, for consistency

  		return error(_("Error wrapping up '%s'."), filename);

Best,
-- 
Jakub Narębski

