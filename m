Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 959411F454
	for <e@80x24.org>; Sat,  9 Nov 2019 06:38:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbfKIGi5 (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Nov 2019 01:38:57 -0500
Received: from mout.web.de ([212.227.17.11]:57691 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725861AbfKIGi5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Nov 2019 01:38:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1573281532;
        bh=C/3egCS/HTlF9Y5hxQyC89ukmO4CpPlxFCJ/YVLSWoc=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Hf1xYr9BXAV2WU4zSiNsNBSbOwzazmuelDUMtu1LHtPqg+v0T4m56rR1lb+GeXqL/
         nAnrwxJuY+vSOjkvqpDAZdt/C8E+tXLJw68W1SMFrpPyFnObuMQZBCIwF27kci5ERX
         tg5LfbyX6D23DDAGBHXOELxK4hi6U7QCgsQ4cSIo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.146.29]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M6UxL-1hitfc3RhT-00yNbv; Sat, 09
 Nov 2019 07:38:51 +0100
Subject: Re: [PATCH v2 09/10] pretty: implement 'summary' format
To:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
References: <cover.1572897736.git.liu.denton@gmail.com>
 <cover.1573241590.git.liu.denton@gmail.com>
 <e74eab6d21f655698ef8b6e1286b44ea070a7af7.1573241590.git.liu.denton@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <f66f8fbe-af46-f38e-87df-fc688110610a@web.de>
Date:   Sat, 9 Nov 2019 07:38:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <e74eab6d21f655698ef8b6e1286b44ea070a7af7.1573241590.git.liu.denton@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UNxct4ziaF4xU+OSqV/h+QGpaTq4YZk/1XBvgxzJHSIrk+Xk1Ra
 qQysWFzGqlic50/lQ+2N60HEynZUDcdyBrSXtypo8M5qyEwrvWdxIKto603e7SDaaDxwzec
 LM16HueqRJQTaZXTxAj4d+J7P7Zc21mdjH1eUG2qWx8LbrpJya/+AHXI+dDNv72eUDuechZ
 lfRfZW1A10bzc2y4z9QgQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HdotnxeKeNE=:FPPfXSEnEzpG6M4/simNU3
 AdzIO8mOPTXpJFf8tG+/Pi7yPQksfekbJ/nAaWAyZHo+ubqOWqiTDAvaBFvpM8Gp5xtwNDFTp
 efbGBknNS4U28sdJl7uFjTBV/9IGAUkPYjUvkvV8kpOZV6yQxQIozqNlzXTXyHty6NfM2oh6G
 mt9A+zzgDW7TentHzZRJ0U4hVc2MuiaUWvMlNwWG6n/tv7P4H2xG+eJqzmN5qb5FlreyzxGNB
 n4c43Z7qK7bCO+F0AQk6JgAXbPWCoDCZbcsjlDJhIn/pfcAd24NFSEZFKS/MqnMhQ3rRigQmf
 uKYlP2HpHdhk3QZfFWdlooBkjKzayoh6wWYrmodMDqzsJSI/BZrsj7VKiDO1QSoIyeaLkKPv5
 fhTum3X/hQTxfQv57q1pwoawYGLWkEMthrKRky6hp4zRllI34c52W5+6RJlcTkazgbJl8EfLY
 FJt+CBFnaXlDUlxJN+BwPB8ywdJSK9HPIoanxl/MVXksR6IMRW7RgoB5ixU+Pvz0NQHjQzNqE
 mjPNDwXfduRI+MNNQ7zOvr29zAy3tL4d43hRHvRS3to+LuoJBXGaQQ1lKSCNbRdr9tQX9W+fy
 P9fvjyUYBLd7zhZsk+Ljn91V+Ny5g3xv4vvpRskNWkCjloRgncI71RbCI8qp8aHlj+AFMji/t
 x1qqtssh9qbjM8/j+V4+MGXTz7etXRpNnXR2oC47RY+iE1maiuikfgRJMmGEBz2iw3i3X3msj
 0WfgQAX2b9NZG5K5EG10oqK5eInIJPmigHuQlZZwZ9Xm2uoB/bKum3k7RLCk3xIlk2I92JnVb
 B+A5r/enGtzAstTvHZhDFDZXZEjQcdWvaFy8oxL0PMt97+bXDicvfQbsFH4GORiOYjj+yFM67
 LTYKbx7iZR7VIWN5MMdKW+RHtGgoOUJtceofAMfJYKkYhqiVunUc+EdyxRoxbKxQO4TD8Rm9d
 7L05yq8JAWNCD6nCGPL76XfHXsrxVFNqY7YGDo7bKd1MMTLk24oKgVQ8UTV1mamlmoW1Im9sg
 EdHxq7rQKrNBWQuD7INMqFzzrRxO5HG5oGfwA/M8F5q1JBARHpuzsRVRii8m9WNeej0MQVkcs
 YNz3drRCybXJxxQNgaLTM14s61+vvXYtAaVFEr8vGTqtyhbx6nkyTc0tHXPVEjThQ24nrA6x2
 Cd48freG0UTdaFpPexLuywz6D55vylxh2iu6CKKY+sPLiwqGvM601NPY/BiuFjh1ZsUaFRN8E
 Lge7SvVfpLuJxdLFt3iwvC/AKJNb1UsqX4M2U8g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 08.11.19 um 21:08 schrieb Denton Liu:
> The standard format for referencing other commits within some projects
> (such as git.git) is the summary format. This is described in
> Documentation/SubmittingPatches as
>
> 	If you want to reference a previous commit in the history of a stable
> 	branch, use the format "abbreviated hash (subject, date)",
> 	with the subject enclosed in a pair of double-quotes, like this:
>
> 	....
> 		Commit f86a374 ("pack-bitmap.c: fix a memleak", 2015-03-30)
> 		noticed that ...
> 	....
>
> Since this format is so commonly used, standardize it as a pretty
> format.

If the title contains a double quote then we get results like these:

   26b455f21e ("hashmap_put takes "struct hashmap_entry *"", 2019-10-06)
   01991cee86 ("config/alias.txt: change " and ' to `", 2019-06-05)

I noticed the lack of quoting in the code and was worried about the
output being confusing or unclean, but after staring at the examples
above for a while I find that it's not that bad.  It's reversible by
removing the outer quotes.  So perhaps we can keep it like this.

Ren=C3=A9
