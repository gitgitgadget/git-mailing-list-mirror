Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DA0D20A40
	for <e@80x24.org>; Tue,  5 Dec 2017 14:42:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752362AbdLEOmd (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Dec 2017 09:42:33 -0500
Received: from mail-it0-f45.google.com ([209.85.214.45]:37559 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752179AbdLEOmc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Dec 2017 09:42:32 -0500
Received: by mail-it0-f45.google.com with SMTP id d137so2020882itc.2
        for <git@vger.kernel.org>; Tue, 05 Dec 2017 06:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dn6Umcshbb3YM9MJN7pNuU5+8Lf8h7CQyxrOaX7n1IQ=;
        b=i7jW4rFQZrfsux9U6apBh6wlbYQpr0z1XjrRzWoxShJJjcM+0q+CB9KTeGyRf1iJPg
         PYF1blEYBMWe+eUCOMn6Z+49daFt+sATpAZ/LM4PggYHZr/iA6pN/aR1jRSrotSuc+C4
         Vo4IhFMwukrtuuaa1nEoW+47LGnwX+B7C+TDf+CYDS8T7ZDAgdvNAbuFvUlUVk4b/1p3
         F3+vbK3eow9npYR7IKC9r5M8v9RfNw9O/wvpk8+7PAOrnLpt64nCwRDIyTfwEx/4FbdZ
         MU+Qz4ZvpFuc54uUpCazUFLDHI+lrq2TnAZwd8AGxQAe4scid8m2rJ/QFR37KpBzfJS+
         +Ujg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dn6Umcshbb3YM9MJN7pNuU5+8Lf8h7CQyxrOaX7n1IQ=;
        b=R8rhOTV5H1zi6Qi2yatOnJXlgeD5oMYySG7EqaCN43unCA212ky1byHOGVYKQNkVGz
         IydrrcIj6nq8v1QvstAyETYIrGhSZ60GEeKDpo7CUf8sGncUPA81Yz03DMHmZ1Lalox9
         R3GLte2SAYoLDnyhZs8izsyVUu3SPvGY+55rv5VLE0vW6Qfz3yqsc3ShzzvZNDJuIWce
         2NeAtFVcCKBQUAW9xfx8d/8BKJzfEv31AvHUlPLrKuY1oIupSb9WcKJGnNmkDJfmhta6
         vGt44B8oaTSBgvqgga9R+/QogG8mMazW1xCWZsHIOi7r8K68ARmmMjETdcxKqgPMTEd4
         lrkA==
X-Gm-Message-State: AJaThX7HTfyo40uMe0o3bjcSH2BZoDZiFhHgh9qs6Z7Wo+U4+92BgNrg
        YYdq1bDW9JarOnJkZEhR1WM=
X-Google-Smtp-Source: AGs4zMbj5NIsuVMabjRsyI8GyzwkAK/vfeaUvakmshB6UPjEjQMSBQ2QoW0VkZHySP5L7cPF09dtkA==
X-Received: by 10.107.141.199 with SMTP id p190mr28215771iod.269.1512484949687;
        Tue, 05 Dec 2017 06:42:29 -0800 (PST)
Received: from [192.168.3.104] (24-212-246-46.cable.teksavvy.com. [24.212.246.46])
        by smtp.gmail.com with ESMTPSA id m72sm112927ioe.40.2017.12.05.06.42.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Dec 2017 06:42:29 -0800 (PST)
Subject: Re: [PATCH v2 6/9] rebase -i: update functions to use a flags
 parameter
To:     "Kerry, Richard" <richard.kerry@atos.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "peff@peff.net" <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
References: <20171127045514.25647-1-liambeguin@gmail.com>
 <20171203221721.16462-1-liambeguin@gmail.com>
 <20171203221721.16462-7-liambeguin@gmail.com>
 <alpine.DEB.2.21.1.1712041643250.98586@virtualbox>
 <22f665eb-0ed1-27d4-7184-e6063ea5b47e@gmail.com>
 <xmqqwp21jqpl.fsf@gitster.mtv.corp.google.com>
 <HE1PR0201MB19938A1581F799CB9D48AE999C3D0@HE1PR0201MB1993.eurprd02.prod.outlook.com>
From:   liam Beguin <liambeguin@gmail.com>
Message-ID: <a80f0166-3c3f-85aa-9961-67b1032a96b0@gmail.com>
Date:   Tue, 5 Dec 2017 09:42:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <HE1PR0201MB19938A1581F799CB9D48AE999C3D0@HE1PR0201MB1993.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On 05/12/17 07:41 AM, Kerry, Richard wrote:
> 
> "Shorted" is what happens when you put a piece of wire across the terminals of a battery ... (bang, smoke, etc).
> It's short for "short-circuited".
> Yes, I think you mean "shortened" in this case.
> 

Thanks for the explanation.
Sorry, my eyes stopped at the lowercase 's' in Johannes message.
Will fix.

> Regards,
> Richard.
> 
> 
> 
> Richard Kerry
> BNCS Engineer, SI SOL Telco & Media Vertical Practice
> 
> T: +44 (0)20 3618 2669
> M: +44 (0)7812 325518
> Lync: +44 (0) 20 3618 0778
> Room G300, Stadium House, Wood Lane, London, W12 7TA
> richard.kerry@atos.net
> 
> 

[...]

Thanks,
Liam
