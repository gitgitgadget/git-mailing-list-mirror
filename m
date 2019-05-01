Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C35E51F453
	for <e@80x24.org>; Wed,  1 May 2019 18:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbfEASje (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 May 2019 14:39:34 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39576 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbfEASje (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 May 2019 14:39:34 -0400
Received: by mail-wr1-f67.google.com with SMTP id a9so25565005wrp.6
        for <git@vger.kernel.org>; Wed, 01 May 2019 11:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ebg5KqYgg4VjHb2lWxz4zNoZERtQQYX8qF728+pVY4c=;
        b=pqmryrejKYNwgcqIYplCL71Uzth3Ma7mkxHJ0rOu5jw6vKpEyLU/CYD3csu2QX9Mli
         kIjQktF33rCadtrrYxggtkpzdQ2RVDqKzCk2GRf4wQlOFOUSIc+2lYEjR/SyB9xC9IVy
         d9Dh9/zzB2LszUSqI+nWJ40Sg/QpLd8GdEidcdiTBhtsHTEQ6enSJ2dOPruRaG9Qmtj/
         yrlQ+3P/HB1eWJl0qGbLnU6bepmRiPFzsi7cwvVMZjpC/1pIfv7K2vshuWP+phEwJMnD
         1z7I+reL2WsHuTE+uXDQ36JJkZgHR73fSt5IM0kyUw4GkQM32JPcErSIGe1/l7grI+a0
         35Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Ebg5KqYgg4VjHb2lWxz4zNoZERtQQYX8qF728+pVY4c=;
        b=o7s9LPZ9ajn0EJVJxcX6pkob5oZ5JodnkRIRIEDB+jSAYBcCVJSpSTuC1IEt4X3IK9
         +QTa/JUSt3Bf3/eXu+XF9MofrdV/wagiS3AveMAYnIhyA9LYY4kwmUCXnEvV2mDEu4Ig
         UH+WRyla04dlJf2r4KyC0+jB/Ld3Me0nwl/QsNC52OFs3VGmHkOZ9+OkLSFVME/kymtZ
         lur3rmYd2sUzzI9+M0YATbaw359ct0oxKE2Jc14xEkO418DI5I6YSNroGV2mXk+XvWNb
         uciNFnkqZ7yTJb2ak9yKeJc7rX+jJZHJgZQxxuRZK8cT7FEzLmpp8uI22wBFAi79DKPo
         2eYg==
X-Gm-Message-State: APjAAAUZsIYl1ZS+qx8NC+QCG9/lOWUyy9uv/W1ZI8+cfFizFok7OebQ
        MdiMz939d8H7foUFnRKiFMiP5/01
X-Google-Smtp-Source: APXvYqwo3txJ6Cgy3PFR8dZJjQfAmVBYekk4vvtXz/sq/NkRvMr33CQ9FIB13oWY6HAVakR3rJiPVQ==
X-Received: by 2002:adf:92e2:: with SMTP id 89mr16178387wrn.53.1556735971581;
        Wed, 01 May 2019 11:39:31 -0700 (PDT)
Received: from [192.168.0.104] (atoulouse-658-1-110-144.w86-199.abo.wanadoo.fr. [86.199.33.144])
        by smtp.gmail.com with ESMTPSA id s145sm13221296wme.38.2019.05.01.11.39.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 11:39:30 -0700 (PDT)
Subject: Re: [PATCH 2/2] mingw: enable DEP and ASLR
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>
Cc:     =?UTF-8?B?xLBzbWFpbCBEw7ZubWV6?= <ismail@i10z.com>,
        =?UTF-8?Q?=c4=b0smail_D=c3=b6nmez_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
References: <pull.134.git.gitgitgadget@gmail.com>
 <e142c1396ec3541486317819e885cf42be24af34.1556575015.git.gitgitgadget@gmail.com>
 <8e59dbf6-a339-74f3-4e60-e56b3817aea5@kdbg.org>
 <nycvar.QRO.7.76.6.1904301838400.45@tvgsbejvaqbjf.bet>
From:   Alban Gruin <alban.gruin@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=alban.gruin@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <2e7be484-74d7-7258-954e-3a4a34a36c01@gmail.com>
Date:   Wed, 1 May 2019 20:39:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1904301838400.45@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

Le 01/05/2019 à 00:41, Johannes Schindelin a écrit :
> Hi Hannes,
> 
> On Tue, 30 Apr 2019, Johannes Sixt wrote:
> 
>> [had to add Dscho as recipient manually, mind you]
> 
> I usually pick up responses to GitGitGadget patch series even if I am not
> on explicit Cc: (but it might take a couple of days when I am too busy
> elsewhere to read the Git mailing list).
> 
>> Am 29.04.19 um 23:56 schrieb İsmail Dönmez via GitGitGadget:
>>> From: =?UTF-8?q?=C4=B0smail=20D=C3=B6nmez?= <ismail@i10z.com>
>>>
>>> Enable DEP (Data Execution Prevention) and ASLR (Address Space Layout
>>> Randomization) support. This applies to both 32bit and 64bit builds
>>> and makes it substantially harder to exploit security holes in Git by
>>> offering a much more unpredictable attack surface.
>>>
>>> ASLR interferes with GDB's ability to set breakpoints. A similar issue
>>> holds true when compiling with -O2 (in which case single-stepping is
>>> messed up because GDB cannot map the code back to the original source
>>> code properly). Therefore we simply enable ASLR only when an

I don’t know if it stands true when combined with something like -ggdb3,
but I may be very wrong.  Feel free to correct me.

>>> optimization flag is present in the CFLAGS, using it as an indicator
>>> that the developer does not want to debug in GDB anyway.
>>>
>>> Signed-off-by: İsmail Dönmez <ismail@i10z.com>
>>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>>> ---
>>>  config.mak.uname | 6 ++++++
>>>  1 file changed, 6 insertions(+)
>>>
>>> diff --git a/config.mak.uname b/config.mak.uname
>>> index e7c7d14e5f..a9edcc5f0b 100644
>>> --- a/config.mak.uname
>>> +++ b/config.mak.uname
>>> @@ -570,6 +570,12 @@ else
>>>  	ifeq ($(shell expr "$(uname_R)" : '2\.'),2)
>>>  		# MSys2
>>>  		prefix = /usr/
>>> +		# Enable DEP
>>> +		BASIC_LDFLAGS += -Wl,--nxcompat
>>> +		# Enable ASLR (unless debugging)
>>> +		ifneq (,$(findstring -O,$(CFLAGS)))
>>> +			BASIC_LDFLAGS += -Wl,--dynamicbase
>>> +		endif
>>>  		ifeq (MINGW32,$(MSYSTEM))
>>>  			prefix = /mingw32
>>>  			HOST_CPU = i686
>>>
>>
>> I'm a bit concerned that this breaks my debug sessions where I use -O0.
>> But I'll test without -O0 before I really complain.
> 
> Weird. Jameson Miller also mentioned this very concern in an internal
> review.
> 
> I guess I'll do something like
> 
> 	ifneq (,$(findstring -O,$(filter-out -O0,$(CFLAGS))))
> 

-Og also exists to debug[0], even if it’s far less known.  Perhaps it’s
better to check for -g (and its variants[1]) as the user clearly states
their intent to debug the resulting binary, rather than checking for
special cases.

> Does that work for you?
> 
> Ciao,
> Dscho
> 

[0] https://gcc.gnu.org/onlinedocs/gcc/Optimize-Options.html#index-Og
[1] https://gcc.gnu.org/onlinedocs/gcc/Debugging-Options.html

Cheers,
Alban

