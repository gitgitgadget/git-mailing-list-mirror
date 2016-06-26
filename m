Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68EFF1F744
	for <e@80x24.org>; Sun, 26 Jun 2016 04:28:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751997AbcFZE2S (ORCPT <rfc822;e@80x24.org>);
	Sun, 26 Jun 2016 00:28:18 -0400
Received: from mail-it0-f47.google.com ([209.85.214.47]:34692 "EHLO
	mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751936AbcFZE2R (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jun 2016 00:28:17 -0400
Received: by mail-it0-f47.google.com with SMTP id g127so11935219ith.1
        for <git@vger.kernel.org>; Sat, 25 Jun 2016 21:28:16 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=edDMic3blpCxZKumSUn9lQkKWfpaHxYyMZ4InEqtc4o=;
        b=ytZjfP6VWZ4jO7V5PoTlmbKGEHca6nj7PPp338F5+TJp+UPcNSC/41cYp0bPxlL2oL
         ckLOyg/xvtO85IrDB8EeDdt0jAF7GnhhXMnuWBaeei+PFcliZPAl4biZOZA8ZAkpVLL/
         /GL4QgFFyvhNYcdaCsRumRMIqdOayQJXZyFHC0UiEF0eVwFRCIINjPblfLnJTTe2CpIJ
         UkecNMBO+Xlw1auJz8Xypq045rdsDTF/2uK+h1lb7uVntkqRrtrY6cRebTDnloeC2jut
         B5oLNgL3oVcnT3uo4KNkp7IgVVGyPAmFIEiXSPWG0BAEvhXVaevqSxjbLQJe8s+lrGT+
         05rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=edDMic3blpCxZKumSUn9lQkKWfpaHxYyMZ4InEqtc4o=;
        b=cgFFaEg9ZCzxOG1JgpfCLLF/HFyr435sBcQQpNQlxBH/phgbQL2OS64XgexYXeC8uP
         zL7s7xfIj9lPliaAmsImuqjYX4v8uFLMEZKnaugP/L1XrzKFzi613Boj+GcWS1G4NaBq
         AKDCUIePYIAAtkdvBPT9QcHgyz3YWEkSz/ttnAEfpG9jpTbdmEkUPf8x2hDmAwJfuQk2
         461H/sWf1sqfH1+9TKu+dyQhCotZRP5//6NUozGhSvscDEQaz7kKNgX+QLAb+sq1HEs4
         ++px1InQPUVFDhaLrTz09+cLWbfjTa3b1OEZqI1NV2Clvki0WJSqCdOXEt25QKvM/RlS
         JYNA==
X-Gm-Message-State: ALyK8tK69BM7DsCdwSF8aID3tAZCLRJTdzaFjG2OBseFUc4IbjggdJXTyCdB7akrBKWeLb/WSD1x3c89kNTOag==
X-Received: by 10.36.80.139 with SMTP id m133mr4120726itb.63.1466915296319;
 Sat, 25 Jun 2016 21:28:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Sat, 25 Jun 2016 21:27:46 -0700 (PDT)
In-Reply-To: <576ED9A2.8070202@novalis.org>
References: <1463694357-6503-1-git-send-email-dturner@twopensource.com>
 <1463694357-6503-5-git-send-email-dturner@twopensource.com>
 <CACsJy8CftPGmrKP8Yeok90T9=whzj69bfE3_X6wHyWOEp6vRzg@mail.gmail.com> <576ED9A2.8070202@novalis.org>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Sun, 26 Jun 2016 06:27:46 +0200
Message-ID: <CACsJy8Dqvv-Ty-wG0qkenyvLNLyqVueJmhjiQXnr0zVUGFvDeA@mail.gmail.com>
Subject: Re: [PATCH v12 04/20] index-helper: new daemon for caching index and
 related stuff
To:	David Turner <novalis@novalis.org>
Cc:	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sat, Jun 25, 2016 at 9:21 PM, David Turner <novalis@novalis.org> wrote:
> On 06/25/2016 10:33 AM, Duy Nguyen wrote:
>>>
>>> +               /*
>>> +                * Our connection to the client is blocking since a
>>> client
>>> +                * can always be killed by SIGINT or similar.
>>> +                */
>>> +               set_socket_blocking_flag(client_fd, 0);
>>
>>
>> Out of curiosity, do we really need this? I thought default behavior
>> was always blocking (and checked linux kernel, it seemed to agree with
>> me). Maybe for extra safety because other OSes may default to
>> something else?
>
>
> Yes -- see this bug report for details:
> https://bugs.python.org/issue7995
>

I think we should refer to this issue in the comment block right
before set_socket_blocking_flag() call. Imagine a year from now, I may
read the code, decide this code is useless and try to remove it.

-- 
Duy
