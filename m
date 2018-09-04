Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F8B41F404
	for <e@80x24.org>; Tue,  4 Sep 2018 15:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbeIDTjd (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 15:39:33 -0400
Received: from smtp6-g21.free.fr ([212.27.42.6]:45536 "EHLO smtp6-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726225AbeIDTjd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 15:39:33 -0400
Received: from [192.168.1.108] (unknown [164.177.97.114])
        (Authenticated sender: jn.avila)
        by smtp6-g21.free.fr (Postfix) with ESMTPSA id EA0E778038D;
        Tue,  4 Sep 2018 15:13:56 +0000 (UTC)
Subject: Re: [PATCH] i18n: fix dangling dot in die() messages
References: <CANYiYbHmU=j+MwLTumJ+BK_0msyPBeux92wF8VqL9J04VOc-FQ@mail.gmail.com>
 <20180904141816.26398-1-jn.avila@free.fr>
 <CACBZZX6Bm-xOO-mvDzmRAA9Xu6HrBr5z+39dp4t6fTTCmNHKbQ@mail.gmail.com>
From:   =?UTF-8?Q?Jean-No=c3=abl_Avila?= <jn.avila@free.fr>
To:     git <git@vger.kernel.org>
Cc:     Prathamesh Chavan <pc44800@gmail.com>
Message-ID: <2f6f52c8-4b8a-a954-5ffb-5d66dfb97fe1@free.fr>
Date:   Tue, 4 Sep 2018 17:13:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACBZZX6Bm-xOO-mvDzmRAA9Xu6HrBr5z+39dp4t6fTTCmNHKbQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/09/2018, Ævar Arnfjörð Bjarmason wrote:On Tue, Sep 4, 2018 at 4:59
PM Jean-Noel Avila <jn.avila@free.fr> wrote:
> Your commit message says "dangling dot"...

The dot is dangling on its own line. I don't really catch why this would
be needed.

>
>> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
>> index b56028ba9d..a011abfd7c 100644
>> --- a/builtin/submodule--helper.c
>> +++ b/builtin/submodule--helper.c
>> @@ -521,7 +521,7 @@ static void runcommand_in_submodule_cb(const struct cache_entry *list_item,
>>                 printf(_("Entering '%s'\n"), displaypath);
>>
>>         if (info->argv[0] && run_command(&cp))
>> -               die(_("run_command returned non-zero status for %s\n."),
>> +               die(_("run_command returned non-zero status for %s"),
> ...but here and below you're also removing the newline. Is this
> intended, and does it work as desired afterwards? I.e. were we just
> ignoring the \n?
>

I checked that usually, the die command does not have the final dot nor
a new line. But I'm not sure of what's intended here.

