Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76D2220D0A
	for <e@80x24.org>; Thu,  1 Jun 2017 19:17:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751161AbdFATRU (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 15:17:20 -0400
Received: from mail-io0-f182.google.com ([209.85.223.182]:35336 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751097AbdFATRT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 15:17:19 -0400
Received: by mail-io0-f182.google.com with SMTP id f102so42246227ioi.2
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 12:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5ds/2uVpAeBu979uxI6PaCjYmNSPnFNMg+4rrKz0h5E=;
        b=MH3y3DdkSCfKQ0Ctg/9lS4ehwYTsbIfhfvUiyySnzKQ9yJNNlhoz/5lzXPj8ifavhm
         8SYKWnvuJR3CADvmGhGy2kW/3uFXGx4Dn7pKPeRskGTKWaeQhSPhO8HvtC45ZXT8k9IM
         E3piu/Dcdhyqux3MXnc/9Pb452BcxqP9L9XbMDBKGbpOzbeRivf/JdZX8tsvTpF+F4a4
         OmUChPVCi8dV3CbreWAW4bej+B2m3GvLGbbWGW07Y8LQ7I7mKoP9hlCvQ6EoC5W6BZPe
         JfzX5CVguP+fvcADdsLoLFJcj/9XaeMQU6T9zgV1o+V8+g/xTTKUBzWD/UdZ7p6qL5b8
         s6+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5ds/2uVpAeBu979uxI6PaCjYmNSPnFNMg+4rrKz0h5E=;
        b=nOAPyW0ww7b5yEvGk6qmot3xwKl+ZE6l70GBHLhoEhrGZGueqxxiqQfRdOEJmEbxBW
         PFz7yGz9M7sFqjI9OptzRWAJ0TQ13+XV4Nuq4DrmWRIfSA0PFACrpJUXFZtuTUE1JFKb
         nG3HS61PNM0Lh23F1v6ZitAJiJxjJ7FaaF5aOH6Fvq8WZYT4NGJOTf69/4MIFKP1JkPj
         bCqcnSm36G91xP0nWlO0IpMoAjjS3gw996hosOYWlMqf3L2AuFualRCcvbq9xFsgyPF/
         JdpF7uAs6n2Fn1vWm7/vduFamrZPkEiIunQ2uo//yIjWt0rdeNlJTSY4D7MmbV0dNCYr
         nvgQ==
X-Gm-Message-State: AODbwcACyecKaGaBsPSI0OkuTCgrGZDToluc8zKFUpGS/kqO7wPsF4xC
        KFOi6YW/o8bDv/IYa5gzE8BKtJjjww==
X-Received: by 10.107.195.5 with SMTP id t5mr4541238iof.17.1496344638717; Thu,
 01 Jun 2017 12:17:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.150.90 with HTTP; Thu, 1 Jun 2017 12:16:38 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.21.1.1706012052480.3610@virtualbox>
References: <xmqqshjk5ezb.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.21.1.1706012052480.3610@virtualbox>
From:   Samuel Lijin <sxlijin@gmail.com>
Date:   Thu, 1 Jun 2017 15:16:38 -0400
Message-ID: <CAJZjrdVS5e5udjLtZoZcTEUg8WGFPuaG+MB_enPJ9poti3LktQ@mail.gmail.com>
Subject: Re: preserve untracked cache, was Re: What's cooking in git.git (Jun
 2017, #01; Thu, 1)
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        David Turner <dturner@twosigma.com>,
        Ben Peart <benpeart@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 1, 2017 at 2:56 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Junio,
>
> On Thu, 1 Jun 2017, Junio C Hamano wrote:
>
>> * dt/unpack-save-untracked-cache-extension (2017-05-20) 1 commit
>>   (merged to 'next' on 2017-05-23 at 3196d093d6)
>>  + unpack-trees: preserve index extensions
>>
>>  When "git checkout", "git merge", etc. manipulates the in-core
>>  index, various pieces of information in the index extensions are
>>  discarded from the original state, as it is usually not the case
>>  that they are kept up-to-date and in-sync with the operation on the
>>  main index.  The untracked cache extension is copied across these
>>  operations now, which would speed up "git status" (as long as the
>>  cache is properly invalidated).
>
> It was my understanding that Ben's analysis conclusively proved that the
> patch as well as the test are sound, and Dave agreed.
>
> What is holding this topic up? Anything Ben or I can do to move this
> closer to `next` or even `master`?

It's in `next` right now (3196d093d6).

> Ciao,
> Dscho
