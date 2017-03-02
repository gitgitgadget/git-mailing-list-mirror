Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35B3120133
	for <e@80x24.org>; Thu,  2 Mar 2017 11:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752429AbdCBLQb (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Mar 2017 06:16:31 -0500
Received: from mail-ot0-f179.google.com ([74.125.82.179]:36197 "EHLO
        mail-ot0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752226AbdCBLQ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2017 06:16:27 -0500
Received: by mail-ot0-f179.google.com with SMTP id i1so49748203ota.3
        for <git@vger.kernel.org>; Thu, 02 Mar 2017 03:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Obm1KE+pZ20hMlsWNZZaL/imjLLi4YoFGEQDrh1UQXg=;
        b=KhHVxGymKS7CJvETdEIgobNlcAN/LFusydNXA69xB48p4FezGgElODwQuXFK4J+Wli
         8D61bKPFxrx6C98NVhrd/7UO4zKo3JA3chGEb88hzParQqmeYBLcGfwFfstpX3fws/i6
         8UqxbRPdieA1jEwsh99EeFeTT69gL9rsjXtM7UEeaEYy4kCtKveeK5VVIxt/sFDZkvJd
         DOlubnF6Aeysoab5xz5VkW9EVVYAi0PHgnDOlriwrLt0za21Q32wG1vxIZ5A1OTkAxfu
         cs5AOZ1mgtEsAySiG6WrHl12jwub6IVqvY4UZlHYi+c3a4lUdgFZl4PBPd7UG0RO4zwI
         5cfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Obm1KE+pZ20hMlsWNZZaL/imjLLi4YoFGEQDrh1UQXg=;
        b=afOq1dYuoKFeaeplD8YPmOPyNAd1TIOjnlpfhBhVOVYTUMProVuaaSPVDiuST3SpUR
         BAowGT40cwshPXgajGEaMXKxDpyzmNcBAiURuHUF/oGxj+TXT0ire5u3dWZKrEF8BahU
         OURWZtrEncn2NiCWNoSAPmeOV8QZEsngocHu9976xeIqaZ+MO77BLV91moUL0s1iiI+/
         iRQVGLgLUYHAW0bJENlBut1oQR+nsPx4U+qBnlAWgfNgY5y6Gc9fpP9X1dli+95cQM6W
         ENxWiC0KNw+Tm6VGQmjmQP2TUi83Iupof0kh1jmoe/Df6AMsZIXw3IjY9D6YHcpAbP+w
         w1aQ==
X-Gm-Message-State: AMke39l6J9ffna/RkMCmXWl+QSIUsL+097vStG7R2zmEu3gIRjl9N8WSR2B7Od4u9ocQtfahGLaROjPN5KvCpQ==
X-Received: by 10.157.27.12 with SMTP id l12mr5949924otl.199.1488447108574;
 Thu, 02 Mar 2017 01:31:48 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.158.84 with HTTP; Thu, 2 Mar 2017 01:31:18 -0800 (PST)
In-Reply-To: <cbd281fc-3a4b-b4dc-5dff-145c97cd68d6@cafu.de>
References: <84c02ca1-269e-2f26-c625-476d7f087f5c@cafu.de> <ea0722e2-c2bd-bd80-a233-50676efcafda@web.de>
 <cbd281fc-3a4b-b4dc-5dff-145c97cd68d6@cafu.de>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 2 Mar 2017 16:31:18 +0700
Message-ID: <CACsJy8B3Qy1mra_GwhbYdk5LFrgYx=6NRqq=wvw2_wcWCO_yNw@mail.gmail.com>
Subject: Re: git status --> Out of memory, realloc failed
To:     Carsten Fuchs <carsten.fuchs@cafu.de>
Cc:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 2, 2017 at 3:12 AM, Carsten Fuchs <carsten.fuchs@cafu.de> wrote:
>>> The repository is tracking about 19000 files which together take 260 MB.
>>> The git server version is 2.7.4.1.g5468f9e (Bitbucket)
>>
>>
>> Is your repository publicly accessible?
>
>
> Unfortunately, no. There are no big secrets in there, but just a couple of
> database details so that I cannot make it universally available. I can
> gladly give you access though. (E.g. by adding your public SSH key?)

You could also try "git fast-export --anonymize" (read the doc first).
I'm not sure if it keeps blob size though, and delta chain might also
matter so an anonymized repo may or may not share the same problem,
I'm not sure.
-- 
Duy
