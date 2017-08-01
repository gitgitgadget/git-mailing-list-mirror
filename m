Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33B582047F
	for <e@80x24.org>; Tue,  1 Aug 2017 21:15:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752074AbdHAVO7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Aug 2017 17:14:59 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:35015 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751912AbdHAVO6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2017 17:14:58 -0400
Received: by mail-io0-f194.google.com with SMTP id f1so2406520ioj.2
        for <git@vger.kernel.org>; Tue, 01 Aug 2017 14:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CTl/JNQcLIQ4Jh3AQejiumjWfHf/Oe96yj0xfx9mdnc=;
        b=FG2LbIt7o5Trz1cb2hcPEHWs2QPsqdmO00cR3kYf8TiwNkWHU6ZdglIwN1EBOOJVSp
         BuUfdfb4UpeGUlLHHD57puegOputV8a+taf1pTx5ByMBFYIqTYE2Xc/F7ZmIE/98lHCS
         Jv+erpOWQwQ8hZnLMDK4Bihwy+iD26yziQEMRr8xey05Cz8AgJ4KEuHQ+owwIkXqpY6X
         VDJ8tx5of0k7thOqlfH66IGtD1/RVlc9FshJZl2psrwdXEKNKwgrweWBp0NYf68gdmk3
         C7bNg0r0ilOlgPLPwJigR2Bro3SSai9Km2O1iRpyboTMBBj4w7m/c2dI18RC0TvBwhE2
         954g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CTl/JNQcLIQ4Jh3AQejiumjWfHf/Oe96yj0xfx9mdnc=;
        b=oi412lNil8D8JkyWZxJ1xG/OEXQjKiEdFXtobYkM8ixr+DDClInkdcoz58v4A98uWm
         cNt3Z9bg3DZTvOGeRB3Bz8zcAfxJsx0jgR8N3crxMrG/OmGycyLyWJsWmxr3hmutcvYj
         ytzqm1cNx5mzhbmVqTj/mr2EQEHTJqiHuYg/GbHPr/I1wULoZlJPp0Rsj31WwEcbqjl/
         CJ3ZdMvNG2clE09z9g9K0bn+UtgrkwYx+1A5Vj67UTMJ1wPuHhvjjqWrn66B5GmrZpmg
         GkS1YpWK3Kc1SLxLgDZwGY72zWaf/R8HPlz1s/ue5CmyVg/Rp8SZP4YwmZARsYjcvgan
         rb/w==
X-Gm-Message-State: AIVw111m9gVdZMFHJK7FbfwY+S2ykFavuQDe6qdDGzp3LCxREDYejOfj
        c+bhpJnlpsgVyVfh29DHJv3wY8zsXw==
X-Received: by 10.107.47.10 with SMTP id j10mr23422856ioo.237.1501622098114;
 Tue, 01 Aug 2017 14:14:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.149.134 with HTTP; Tue, 1 Aug 2017 14:14:57 -0700 (PDT)
In-Reply-To: <CAGZ79kaL48k=tCL-nnzFJBm4Qx2Q9uON=Cv82RhUr4ArG66rDA@mail.gmail.com>
References: <20170731205621.24305-1-pc44800@gmail.com> <20170731205621.24305-5-pc44800@gmail.com>
 <CAGZ79kaL48k=tCL-nnzFJBm4Qx2Q9uON=Cv82RhUr4ArG66rDA@mail.gmail.com>
From:   Prathamesh Chavan <pc44800@gmail.com>
Date:   Wed, 2 Aug 2017 02:44:57 +0530
Message-ID: <CAME+mvXsh53kLJ4se4uKY=SJcvSbHtEZQ6K2CgAPs=1wxUxk1A@mail.gmail.com>
Subject: Re: [GSoC][PATCH 04/13] submodule: port submodule subcommand 'status'
 from shell to C
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 1, 2017 at 2:42 AM, Stefan Beller <sbeller@google.com> wrote:
> On Mon, Jul 31, 2017 at 1:56 PM, Prathamesh Chavan <pc44800@gmail.com> wrote:
>> This aims to make git-submodule 'status' a built-in. Hence, the function
>> cmd_status() is ported from shell to C. This is done by introducing
>> three functions: module_status(), submodule_status() and print_status().
>>
>> The function module_status() acts as the front-end of the subcommand.
>> It parses subcommand's options and then calls the function
>> module_list_compute() for computing the list of submodules. Then
>> this functions calls for_each_submodule_list() looping through the
>> list obtained.
>>
>> Then for_each_submodule_list() calls submodule_status() for each of the
>> submodule in its list. The function submodule_status() is responsible
>> for generating the status each submodule it is called for, and
>> then calls print_status().
>>
>> Finally, the function print_status() handles the printing of submodule's
>> status.
>>
>> Mentored-by: Christian Couder <christian.couder@gmail.com>
>> Mentored-by: Stefan Beller <sbeller@google.com>
>> Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
>> ---
>> In this new version, the following changes have been made:
>> * parameters passed to the function print_status() have been changed.
>>   Instead of passing char *sub_sha1, instead the object_id is being passed.
>>
>> * Also, since the passed parameter displaypath's value isn't changed
>>   by the function, it is passed to the funcition as const char *displaypath
>>   instead of char *displaypath.
>>
>> * the output type of the function handle_submodule_head_ref() is changed
>>   from strbuf to object_id, as we will use the object_id instead of the
>>   hex of sha1 being stored in a struct strbuf.
>>
>> * diff_files_args is cleared after using it by passing it as args in the
>>   function cmd_diff_files.
>>
>> * In the function status_submodule(), for checking if a submodule has merge
>>   conflicts, the patch currently checks if the value of any of the ce_flags
>>   is non-zero. Currently, I think the we aren't interested in a partiular flag,
>>   but I'm not sure on this.
>>
>> * Debugging leftovers and suprious new-lines are removed.
>>
>> * The confusion with displaypath being passed as te super-prefix in many
>>   of the ported subcommands may be a result of the fact that the
>>   function generating the displaypath: get_submodule_displaypath()
>>   uses the super-prefix as simply a path concatenated with the current
>>   submodule name to denote our current location.
>>   The function get_super_prefix() is declared in cache.h and defined in
>>   environment.c, but is majorly used in the builtin/submodule--helper.c
>>   and also in unpack-trees.c
>>   Also, for generating any submodule's displaypath, it would be important to
>>   have ".." passed to the submodule, and currently it is possible only via the
>>   super-prefix.
>>   This is also other instaces where the super-prefix contained ".." as well.
>>   One of such instance is Test 4 from t7406-submodule-update.sh
>>   Hence, maybe documenting the value of displaypath might a solution
>>   for the above problem.
>>   I'm just stating my views and would like to recieve your opinion on this
>>   matter.
>
> Yes, I agree that the display path is not quite easily understood as it can be
> ambiguous.  I am confused by this paragraph:
> * does test 4 from 7406 fail here, or was it just the starting point
>   of the discussion and it all works fine?

Sorry for misleading there. In the discussion earlier, Brandon mentioned that
displaypath's value may contain ".." as well.
To this, I replied pointing out one of the test which checks for the value of
displaypath.
In this test, ( Test 4 from t7406-submodule-update.sh), the value of displaypath
is being calculated via the submodule_init() function present in
submodule--helper.c
Here, I wanted to point out that, even in the case of this function,
the variable
displaypath is evaluated after receiving the value of "../super/" as
the value returned
by the function get_super_prefix().
Hence, to correct this confusion about the usage of super-prefix,
(which as pointed out by Brandon has been traditionally defined
as the path from the root of the superproject down to the root of
the submodule which further means that there should not ever be
any relative '..'s.), we may either have to get the value of super-prefix's
Documentation to accomodate this change, and to accept the way it is
used in submodule--helper and the current patch series, or else,
change the way it is being used in the various function, and used
another method for evaluation of displaypath.

Thanks,
Prathamesh Chavan
