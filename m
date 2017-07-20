Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3F651F600
	for <e@80x24.org>; Thu, 20 Jul 2017 19:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936180AbdGTTg0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jul 2017 15:36:26 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:37364 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934079AbdGTTgZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2017 15:36:25 -0400
Received: by mail-it0-f68.google.com with SMTP id j81so2499343ita.4
        for <git@vger.kernel.org>; Thu, 20 Jul 2017 12:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=uP7dCBPEUJNUoBDWcmKVnuHS7b+o5Cr9Keiw+H6ipTk=;
        b=UaLTKhLkqz/pLfC5EqbkxcRqyGxMlo2DNESMRnPRgcfjMimtaD7Lmyt+5tNHRhdshh
         /hN6o55HvpcomKe/9A47IQ7BATw5cjdN+3M8yVol/xVgYxhIvNq0icZ2F8PRyMH9Sg9w
         UPRFZnUznvdr2GmZqLg5x3EPCgq0dHnDrCw30+PYxvmK6kP1m04agm+f0NmpdNZCYDQk
         q12nvIR/ytL+OChcnG7Oqbc2FQ49O2k25u357OJOUNbIKN1fMxDVfCe0TGcKSFRdXH8p
         hNRwtYhhQ0QL601PRAouIDntspXZ8Un1MUAnG6W9BdlKbB2Tk4j35Wth7fTM1vvG40z0
         8ctw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=uP7dCBPEUJNUoBDWcmKVnuHS7b+o5Cr9Keiw+H6ipTk=;
        b=gu3EYkkQMmOMJ1Lu2Ya20LEycASHWFRp9LYf6IBSdsJeDiTAbdYH+pV1suD96oY2Kc
         QWJA3TQx0pd5aZSMd/YVKY0cRfQafPOxq72ctEywiy5F55OY56yCaQgfW+CpfYoCvW8r
         gmXylCQDjmu2BDsHguRVebu73VlP5uu9vcNDLU3sLuHfLYrJdM5tgU2VYzR99uKxErrs
         +iLsnaVIF9DQnF/j15MRNan+Dk092u2m60Iwt/AiPvoB0TbKTZhKFEt8uY+7jLYvAx6q
         nVtoisGw7OQgf3bF8iwpI0z7Xvom6EGbm49+glkXywtEMGFT1/wV90fLNfg8AsR9ptE+
         GNsg==
X-Gm-Message-State: AIVw110cm1YjPPWvxz/Qle3cYYvIO2DeEQFOcAlm+KZ2bENKRZmzZWPu
        vyAsnBcukbzbEPQd3IDTHNQOv/FACA==
X-Received: by 10.36.69.73 with SMTP id y70mr4796922ita.94.1500579385056; Thu,
 20 Jul 2017 12:36:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.149.148 with HTTP; Thu, 20 Jul 2017 12:36:24 -0700 (PDT)
In-Reply-To: <CAGZ79kZrVQZH3ASoZavEeCSUBei8By1xs3fAQaEbVSCMOXoYxg@mail.gmail.com>
References: <20170718204904.3768-1-pc44800@gmail.com> <20170718204904.3768-6-pc44800@gmail.com>
 <CAGZ79kZrVQZH3ASoZavEeCSUBei8By1xs3fAQaEbVSCMOXoYxg@mail.gmail.com>
From:   Prathamesh Chavan <pc44800@gmail.com>
Date:   Fri, 21 Jul 2017 01:06:24 +0530
Message-ID: <CAME+mvV9-spX0DrToZdtydhZ5cXA5A7R7JCca4f87Rn3tdLUpw@mail.gmail.com>
Subject: Re: [GSoC][PATCH 5/8] submodule: port submodule subcommand 'sync'
 from shell to C
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Firstly, thanks for reviewing my patches. I have even checked out the
other reviews
and improvised the other patches according to reviews as well.
I had a few doubts about this one though.

>> +       const struct submodule *sub;
>> +       char *sub_key, *remote_key;
>> +       char *sub_origin_url, *super_config_url, *displaypath;
>> +       struct strbuf sb = STRBUF_INIT;
>> +       struct child_process cp = CHILD_PROCESS_INIT;
>> +
>> +       if (!is_submodule_active(the_repository, list_item->name))
>> +               return;
>
> We can use the_repository here, as we also use child processes to
> recurse, such that we always operate on the_repository as the
> superproject.
>

Sorry, but can you explain this a bit more?

>
>> +
>> +       sub = submodule_from_path(null_sha1, list_item->name);
>> +
>> +       if (!sub || !sub->url)
>> +               die(_("no url found for submodule path '%s' in .gitmodules"),
>> +                     list_item->name);
>
> We do not die in the shell script when the url is missing in the
> .gitmodules file.
>

Then to have a faithful conversion, IMO, deleting the above lines
would be the correct way?

>> +
>> +       prepare_submodule_repo_env(&cp.env_array);
>> +       cp.git_cmd = 1;
>> +       cp.dir = list_item->name;
>> +       argv_array_pushl(&cp.args, "submodule--helper",
>> +                        "print-default-remote", NULL);
>> +       if (capture_command(&cp, &sb, 0))
>> +               die(_("failed to get the default remote for submodule '%s'"),
>> +                     list_item->name);
>> +
>> +       strbuf_strip_suffix(&sb, "\n");
>> +       remote_key = xstrfmt("remote.%s.url", sb.buf);
>> +       strbuf_release(&sb);
>> +
>> +       child_process_init(&cp);
>> +       prepare_submodule_repo_env(&cp.env_array);
>> +       cp.git_cmd = 1;
>> +       cp.dir = list_item->name;
>> +       argv_array_pushl(&cp.args, "config", remote_key, sub_origin_url, NULL);
>> +       if (run_command(&cp))
>> +               die(_("failed to update remote for submodule '%s'"),
>> +                     list_item->name);
>
> While it is a strict conversion from the shell script, we could also
> try to do this in-process:
> 1) we'd find out the submodules git dir using submodule_to_gitdir
> 2) construct the path the the config file as "%s/.gitconfig"
> 3) using git_config_set_in_file (which presumably takes file name,
>   key and value) the value can be set

Thanks for pointing that out. That surely reduced a child_process.
Although the path of the config file for the case of submodules
would be constructed by "%s/config".

Thanks,
Prathamesh Chavan
