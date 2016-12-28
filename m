Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B80B1FCA5
	for <e@80x24.org>; Wed, 28 Dec 2016 08:42:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751098AbcL1Ima (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Dec 2016 03:42:30 -0500
Received: from mail-wj0-f173.google.com ([209.85.210.173]:35137 "EHLO
        mail-wj0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751090AbcL1Im3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Dec 2016 03:42:29 -0500
Received: by mail-wj0-f173.google.com with SMTP id v7so333111039wjy.2
        for <git@vger.kernel.org>; Wed, 28 Dec 2016 00:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=MxQxGNg56vP6e7NMnsVJdfUiSI03wSHuNZL3nCrB4Ec=;
        b=SUZXvC/pRSs3v/5cWqj/wu98chGve9b7fMCzpyBda90YWdi0D616aSdJqCitUHXOjt
         apBj1ZHuHmwdAskpY69Y3+x23AtC03HQs+0tcNCFpGq1C6RymQatfrMy+icFIRpe0a6K
         a5RuRszs6SM9bbrYC8zr4xD1jyObuAYekZJmL5QdIl8cGZxMYlLAFuRzYmbL8Mv3bhV3
         t6YxaHkoNovR3O4hzorALgi9g4hhBxJqovU8JsYS4F2LHPFIudGR2c0r8rVAGzh15OE8
         lKdyHaVml7/WrsYquNXXpwPHJbKwH6yS1tz1d7GtiC1CEOEKV/KkO7pvej178FHM1a5a
         MAig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=MxQxGNg56vP6e7NMnsVJdfUiSI03wSHuNZL3nCrB4Ec=;
        b=RV3RzKLDg+7dvbo+3d66WZzMRNPccbksHsWqtCky/NyXfsXonF1tvhekmoz0NUOfe+
         rObT82xdGaEorpUE2Oc34gwSR5k7oAvKbDJ4CM/+m+/ALAo4Tgaez2y8oDoMvOVr/LP3
         vlNSzXbTskSVeYZ1onKy1nWYqzBn+gq/l01W8X59RXQ873JZ3Y2XuoUhncNmTAHttveb
         DY5GzfET6MK1caeU/QH8PBHd1PgJh8oDj8g0yEnHbIzNUmWmEIujIpbVAOsK66iI7LsO
         tZdWO7hR7RCxrSq6bGAzTW5LYSkKaf0y8LAtuJW0zAMTPs0V1n+tjaXB0KpiW45I84jN
         0pPw==
X-Gm-Message-State: AIkVDXIEVd0KWqMxML0l6G+2B6a6iUfOGLIk1cmCIGSkvlBv+FpTM+pKOHaSAlwQAiNaJQ==
X-Received: by 10.194.171.66 with SMTP id as2mr37564616wjc.77.1482914545561;
        Wed, 28 Dec 2016 00:42:25 -0800 (PST)
Received: from [192.168.0.213] (88-111-149-57.dynamic.dsl.as9105.com. [88.111.149.57])
        by smtp.gmail.com with ESMTPSA id v2sm63219735wja.41.2016.12.28.00.42.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Dec 2016 00:42:24 -0800 (PST)
Subject: Re: HowTo distribute a hook with the reposity.
To:     Jeff King <peff@peff.net>, Jacob Keller <jacob.keller@gmail.com>
References: <6e228b75-0208-63e8-b4e8-70905e3f9ea3@gmail.com>
 <CA+P7+xqHTgRvMRwgL2TJ7SRb_SR0sbtA039J_5N0xSjf3TNrgg@mail.gmail.com>
 <20161228060840.gelgcs2hd33id56j@sigill.intra.peff.net>
Cc:     Git mailing list <git@vger.kernel.org>
From:   "John P. Hartmann" <jphartmann@gmail.com>
Message-ID: <6801f971-418d-18c9-8002-9c2f7b8c8008@gmail.com>
Date:   Wed, 28 Dec 2016 08:42:25 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <20161228060840.gelgcs2hd33id56j@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks; your point is taken.  One final wrinkle:

This project is hosted on github.  If I put the hook into the repository 
manually (if I can; I don't know that), is it true that the hook would 
be distributed on a clone action, but not on a pull?

	j.

On 28/12/16 06:08, Jeff King wrote:
> On Tue, Dec 27, 2016 at 09:32:22PM -0800, Jacob Keller wrote:
>
>> On Tue, Dec 27, 2016 at 5:34 PM, John P. Hartmann <jphartmann@gmail.com> wrote:
>>> I would like a hook in .got/hooks to be made available to all who clone or
>>> pull a particular project.  I'd also like the hook to be under git control
>>> (changes committed &c).  I added a hook, but git status does not show it.
>>> Presumably git excludes its files in .git/ from version control lest there
>>> be a chiken-and-egg situation.
>>>
>>> Is there a way to achieve this?  Or a better way to do it?
>>>
>>> Thanks,  j.
>>
>> Best way I found, was add a script with an "installme" shell script or
>> similar that you tell all users of the repository that they are
>> expected to run this to install the scripts. You can' make it happen
>> automatically.
>
> I agree that is the best way to do it.
>
> I didn't dig up previous discussions, but the gist is usually:
>
>   1. Cloning a repository should not run arbitrary code from the remote
>      without the user on the cloning side taking some further affirmative
>      action.
>
>      This is for security reasons. Obviously the next step is quite often
>      to run "make" which does run arbitrary code, but that counts as an
>      action.
>
>   2. We could write a feature in git that manages hooks (or config, etc).
>      But ultimately you would still be running "git clone
>      --trust-remote-hooks" or something to satisfy point (1).
>
>   3. There's not much point in doing point (2), because you can just
>      spell it as "git clone && cd clone && ./install-hooks" and then git
>      does not have to care at all about your scripts.
>
>   4. A hook (or config) management system could do fancy things like
>      merging your custom local config, picking up changes from the
>      remote, etc. But all of that can happen outside of Git totally (and
>      quite often you want to manage things in contributors setups
>      _besides_ Git data anyway).
>
>      An example system is:
>
>        https://github.com/Autodesk/enterprise-config-for-git
>
>      (with the disclaimer that I've never used it myself, so I have no
>      idea how good it is).
>
> I think you probably know all that, Jake, but I am laying it out for the
> benefit of the OP and the list. :)
>
> -Peff
>
