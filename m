Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54870201C8
	for <e@80x24.org>; Mon, 13 Nov 2017 02:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751159AbdKMCbT (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Nov 2017 21:31:19 -0500
Received: from mail-pg0-f50.google.com ([74.125.83.50]:47877 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751107AbdKMCbT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Nov 2017 21:31:19 -0500
Received: by mail-pg0-f50.google.com with SMTP id o7so11621726pgc.4
        for <git@vger.kernel.org>; Sun, 12 Nov 2017 18:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=UI2RH3u0Gb/ROXlr6528EKXtixv9WvLUwfBv3OGSiBE=;
        b=mqN1r42wYDd6IKzP95+//XlbP8ek9pps/YMZ0FW8C0rnHUFofuCtIINJCdAHGq5fkY
         CTEcfSi3CJEBt2aW9s05NA64vBmS0q/yiuZ7v8Xv/qxellufaVchy7t11jdr2gzSYKwv
         hqV2/lHUYjQNeAYQJZlXuJVWZVd2DSpiGNikmoLsmziWonKq+OJ0hK7iBOD7QtTFINs1
         EZYlNTkapJwMj5shJInsVRcUkKVgDhug2TPmHcC4XtDScS6oKQa+FSewC0lkikNDmz0R
         OkHrXsoj3s5okCsjagFDyp0ETvQfO0c0Lh+fjAaZRJa1OlceK4Bapx06T1TP1uXlKxwd
         gs5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=UI2RH3u0Gb/ROXlr6528EKXtixv9WvLUwfBv3OGSiBE=;
        b=Q8DYRkZHtGSQWMgGBHmHOpkCj3zedl/+Vh4w5b0kd1yeiVIatxQ3V/cDb9nW7FhoGv
         KuWcZUrhvCcbNaiZKnIhNAcgjmFcaAuMBEsyHXrCBjrkdwUi3Yd1lz3ei5+zD1wcWyJO
         rcGAillMoN82H2VQUxPJXKgYZGz5BInZ0b0p+vuSLNCzDetDIzgciVah2QrxrvVgTQUi
         x7T3RSXIgR3368Jc1yZa47LpOQllRX/YVl8Ja1Fx9AYitfchy45iExAAgzJngql7mJbg
         sA5M+r8LnajePsii7kq3Ppa2pXPkzOX1wKcl8cao/emo9e/nQPjO2LxifyQTyv0NwF1Z
         YxxA==
X-Gm-Message-State: AJaThX6xqv8aFialYXJLklMVlUMdkK8BBIQco7UJAcZABetU5wa/ekLR
        A2BJYtB3Qvvn6+oL0etVdIE=
X-Google-Smtp-Source: AGs4zMaWxtHa/jBMB2QBd3Ejd1evuu5embfT90avzI5dQz1VwZA1Jtq9emSe5h3mSKfeyPwBfG2SgA==
X-Received: by 10.101.80.4 with SMTP id f4mr7144876pgo.432.1510540278535;
        Sun, 12 Nov 2017 18:31:18 -0800 (PST)
Received: from [192.168.43.71] ([117.209.192.7])
        by smtp.gmail.com with ESMTPSA id d68sm5776893pfl.38.2017.11.12.18.31.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Nov 2017 18:31:17 -0800 (PST)
Subject: Re: [RFC PATCH v3 4/4] builtin/branch: give more useful error
 messages when renaming
To:     Kevin Daudt <me@ikke.info>
References: <20170925082024.2691-1-kaarticsivaraam91196@gmail.com>
 <20171102065407.25404-1-kaartic.sivaraam@gmail.com>
 <20171102065407.25404-5-kaartic.sivaraam@gmail.com>
 <20171112182322.GA17612@alpha.vpn.ikke.info>
Cc:     git@vger.kernel.org,
        Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <29bd81e4-e8df-8fb8-9436-d70902106f49@gmail.com>
Date:   Mon, 13 Nov 2017 08:01:12 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20171112182322.GA17612@alpha.vpn.ikke.info>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sunday 12 November 2017 11:53 PM, Kevin Daudt wrote:
> On Thu, Nov 02, 2017 at 12:24:07PM +0530, Kaartic Sivaraam wrote:
>> From: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
>>
>> When trying to rename an inexistent branch to with a name of a branch
>
> This sentence does not read well. Probably s/with a/the/ helps.
>

Thanks. Seems I missed it somehow. Will fix it.

>> that already exists the rename failed specifying the new branch name
>> exists rather than specifying that the branch trying to be renamed
>> doesn't exist.
>>
>> [..]
>>
>> Note: Thanks to the strbuf API that made it possible to easily construct
>> the composite error message strings!
>
> I'm not sure this note adds a lot, since the strbuf API is not that new.
>

That was a little attribution I wanted make to the strbuf API as this 
was the first time I leveraged it to this extent and I was surprised by 
the way it made string manipulation easier in C. Just documented my 
excitation. In case it seems to be noise (?) which should removed, let 
me know.

---
Kaartic
