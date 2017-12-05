Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BE5820954
	for <e@80x24.org>; Tue,  5 Dec 2017 03:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752488AbdLEDjn (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 22:39:43 -0500
Received: from mail-it0-f46.google.com ([209.85.214.46]:36152 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752487AbdLEDjn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 22:39:43 -0500
Received: by mail-it0-f46.google.com with SMTP id d16so11995804itj.1
        for <git@vger.kernel.org>; Mon, 04 Dec 2017 19:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nsjZyToJi+SfSkNjp/eGdtpcgXcI6NPO/Q+JtQT33is=;
        b=IvEdjiYpYlyDgxv7YAVddm5rvzyIGByjaHUt+Uk3K0X84RUM/NCHgUL4uO8DmEoX03
         97wu0LRyObwlmrbIRAVR1wSemw1O44++Q+58E7MWob87vrJIY1zlCFoj/qQL4P7FXmrY
         Z/rNhxfL/L5lrD2g56EwFVE++hCx/CbLi5XAqIm/pYxEkybEwfWm6YwevZUXXx8Ilh/8
         wU7Es0ZWt5NqyOLGZMz4AZWVWJWZWcE79lNMPO4a2suQdtPmy3Z3SIYaG7TmOPJYexqr
         IPXDE6BjLV2oIDyVVnOwkaWgISpQoHpg+u+vIsWUgJGWmIAwJ6slbgmRn6A3GIsiXZ03
         0IFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nsjZyToJi+SfSkNjp/eGdtpcgXcI6NPO/Q+JtQT33is=;
        b=hVQMARX539m26xFR3rCGpeFkwnVWoQjGVxjPw1GKLyyR66rfMPqr8PkfEoVXuI+vn8
         CJhnIpvlMKb+P2/Dn1IReVMfR8oW5k+0mXxQ/1iWlJRV/JO8DOk/I4wz6qdetpSCrL5k
         m/QqZL9i0RY55ZQJLRIWAz8soP8bS8ix4KmsrkXxVR1EMIf1RFzOSlMJ/KZAWzM7kgzt
         lrwN+JJfbrQkO3V97zXPhEAR4YkBY9PX0pJW4hVqeh3tHWBvPBcSRQCtV2bUsjXKdBA4
         HKTc8KE2QpKDPq7UtzT+8Pa9fRFx/sXnMsBka9J2p7K5pt3ObqIhXGYGY4pYIDMGrBjK
         V46g==
X-Gm-Message-State: AKGB3mIgankvYytITuYf4SgDWEIULvnjcE4h/+SLVNB+6SZghJXc7oho
        nVIcUtVSe1QZ5hsqBWd/ffI=
X-Google-Smtp-Source: AGs4zMZOqN4OtmlJLAxLsBP4YPpi75Bsx8Nl16r1e7iRY4Nvty69K86anLy/1/b5JwLlerB+97L+lQ==
X-Received: by 10.36.250.8 with SMTP id v8mr7873770ith.128.1512445182471;
        Mon, 04 Dec 2017 19:39:42 -0800 (PST)
Received: from [192.168.3.104] (24-212-246-46.cable.teksavvy.com. [24.212.246.46])
        by smtp.gmail.com with ESMTPSA id v129sm358767ioe.39.2017.12.04.19.39.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Dec 2017 19:39:42 -0800 (PST)
Subject: Re: [PATCH v2 4/9] rebase -i: refactor transform_todo_ids
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net
References: <20171127045514.25647-1-liambeguin@gmail.com>
 <20171203221721.16462-1-liambeguin@gmail.com>
 <20171203221721.16462-5-liambeguin@gmail.com>
 <alpine.DEB.2.21.1.1712041541000.98586@virtualbox>
From:   liam Beguin <liambeguin@gmail.com>
Message-ID: <edf23a51-f08d-6e61-b1a5-af8929c477ab@gmail.com>
Date:   Mon, 4 Dec 2017 22:39:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1.1712041541000.98586@virtualbox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

On 04/12/17 09:42 AM, Johannes Schindelin wrote:
> Hi Liam,
> 
> On Sun, 3 Dec 2017, Liam Beguin wrote:
> 
>> The transform_todo_ids function is a little hard to read. Lets try
>> to make it easier by using more of the strbuf API. Also, since we'll
>> soon be adding command abbreviations, let's rename the function so
>> it's name reflects that change.
> 
> I am not really a fan of the new name, and would prefer the old one, but
> that's only a nit, not a reason to reject the patch.
> 

You're right, it's probably not the best name. I'll change it to
transform_todos() as we want the function name to reflect that it changes
both parts of the todo.

> The rest of it makes the code reads a lot nicer than before. Thank you,
> Johannes
> 

Thanks,
Liam
