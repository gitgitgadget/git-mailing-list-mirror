Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,URIBL_BLACK shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3560C20131
	for <e@80x24.org>; Fri,  6 Oct 2017 18:58:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752563AbdJFS6V (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 14:58:21 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:55918 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752276AbdJFS6T (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 14:58:19 -0400
Received: by mail-wm0-f50.google.com with SMTP id u138so9656444wmu.4
        for <git@vger.kernel.org>; Fri, 06 Oct 2017 11:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KTKC6dYIY4+991Nqcw2Y1Zl2ehJ8tBvifNjrE4/IgA4=;
        b=R+rNPUC18tuqWQ9UqqGaTqEICLu9gjqqRE0tHwzRQaWCkmU6st1azxKa62v5j+8Fpm
         nkm2O2lYX+6ihbQkPW4ZSeJyPpOVJv/Ap6f+gB9/eplewqJB0tcUTxIua8BhYz4ni1xM
         7dtBvpTmTPbKad0B48ULS/8mm/c6zatFXkgARZxBCih0Duw2d/BskZfgCEuOuZAkNXHN
         Ss8+zrJ0U/pMeMOgD9cb1vc+z9WcoCtKm/zvlCsYL9pyoNgJVzHGXGnxnoeFnhGZtxME
         e66WgwUDq7GIJ4kG2atkFSgNxKrNHwR41mzl7fcygrgzr9CRZyZz/cPhp+kaFaSFTsVm
         ygAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KTKC6dYIY4+991Nqcw2Y1Zl2ehJ8tBvifNjrE4/IgA4=;
        b=n97WRcOalC8F7yS8848E+uwUlAzoHdcVHLog4oieWgHJp6fufC4M6KMllj7eeviwJk
         GHM4LzwCbl7bIgC65y58oO1+FOOWVj5TL/buI66wvB+FXy/6jtAYBRDCFvC67A50AMzq
         0dXXQYyxnYRfPxeRVsec6CC2r/FRjY8vmpDXFT9VACh3R1BCfc48vF6hLPvXZsWUEeFR
         D20dCNg3gDwaifzp6PjJYJrMNohWXGjBN6UDQovnlSOukyaRip+S0zsO/XK/HdMxv3Xt
         dXej6ZZqZXPAJj0FjjJt5gTHGaSd5S5McE14ROet8miGKmpWWfKhpcdU+C2vJwVGVB3w
         Y6Gw==
X-Gm-Message-State: AMCzsaWNo4qaVT5DpHfufI2kOFwspUouWB50ewYNqZkwHE5abl3IuAYS
        V66hsi83Y473a8HUvGhiqP3A+g==
X-Google-Smtp-Source: AOwi7QCQMnf4NLGWLpMxrsJ3ddH0Zq3JbYhr4IBsaqDEnrfWwkTV/0wN2T0LUTPfParK3MBIBgFPzw==
X-Received: by 10.80.222.8 with SMTP id z8mr4639070edk.214.1507316298038;
        Fri, 06 Oct 2017 11:58:18 -0700 (PDT)
Received: from ?IPv6:2001:a61:103e:7401:51cc:1510:e458:9af3? ([2001:a61:103e:7401:51cc:1510:e458:9af3])
        by smtp.googlemail.com with ESMTPSA id e50sm2469174ede.18.2017.10.06.11.58.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Oct 2017 11:58:16 -0700 (PDT)
Subject: Re: Git config multiple values
To:     Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
Cc:     "aleksander.baranowski" <aleksander.baranowski@yahoo.pl>,
        git@vger.kernel.org
References: <4b848032-e8b6-be67-58d9-e3fcc2c11853@yahoo.pl>
 <20171006143219.4bn63aoenluc77fd@sigill.intra.peff.net>
 <20171006172530.GV19555@aiede.mtv.corp.google.com>
From:   Andreas Heiduk <asheiduk@gmail.com>
Message-ID: <962cbecd-4be1-f041-30e3-cc4cd19310d0@gmail.com>
Date:   Fri, 6 Oct 2017 20:58:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20171006172530.GV19555@aiede.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-BE
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Am 06.10.2017 um 19:25 schrieb Jonathan Nieder:
> Hi,
> 
> Jeff King wrote:
>> On Fri, Oct 06, 2017 at 01:10:17PM +0200, aleksander.baranowski wrote:
> 
>>> It's just an opinion, but this behaviour is no consistent for me.
>>>
>>> If it's not the bug it's a feature just let me know.
>>
>> It's a feature, though I agree that git-config is rather baroque. We're
>> mostly stuck with it for reasons of backwards compatibility, though.
> 
> This feels like a dodge.  Can we make a list of what is baroque here,
> with an eye to fixing it?  E.g. if we introduce a new --set option,
> then what should its semantics be, to be more intuitive?


My reading of the manual for 

	git config --global user.name Foo2 Bar

is this:

       Multiple lines can be added to an option by using the --add option.

Does not apply here - no `--add` option, so no new value should be added.

       If you want to update or unset an option which can occur on multiple
       lines, a POSIX regexp value_regex needs to be given. 

does not apply: First: no "--unset" variant is used here leaving only "update".
Second: before that command there is only one value.

       Only the existing values that match the regexp are updated or unset.

Since "Two" does not match the previous value and `update` is the only 
described case left I'd expect that the command changes nothing.I don't
understand how the description allows `git config` to add a new value,
because the manual talks about "update" twice, nothing about adding.


Confused
--Andreas
