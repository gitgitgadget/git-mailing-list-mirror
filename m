Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F8592013A
	for <e@80x24.org>; Wed, 15 Feb 2017 18:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752418AbdBOSwo (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Feb 2017 13:52:44 -0500
Received: from mail-it0-f42.google.com ([209.85.214.42]:35294 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752166AbdBOSwn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2017 13:52:43 -0500
Received: by mail-it0-f42.google.com with SMTP id 203so73271243ith.0
        for <git@vger.kernel.org>; Wed, 15 Feb 2017 10:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7gzjOLWmOBpZ6JG1kJLHnKcsLOylOJKPpg+0ySNoLwY=;
        b=fFoJDRQNT6rE59Sss9STbuxOJ2U+gqOcUEWmRqI0Byk3zQCC2p3v7fUquW5NDsPwqo
         23Hqu1bwKqc7g0YgZxnY6Vvo7pgGZbF4YRNh9kPGDI9Q4aApQxUN9LFphcY0MDn6W69h
         nMTw56HqZJYb5NnPw4wcHHvWUrmGyJNEhzP+ELtcAZCpuIkm8veYz8flmstonW6MOCas
         J6vfgP63evNlQTUhwxzEi58JJ7wbt/pVbpaGXqivt7urSZLDBn4M5JNIuNMLDvlGi7h2
         Sbi8MLUhG30xAhYM5w2tS8oJ8uau3dp46h7ELThv8AL0PF+a3KuGxa8v/19LhykACnnH
         VFRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7gzjOLWmOBpZ6JG1kJLHnKcsLOylOJKPpg+0ySNoLwY=;
        b=LKhy8BA8toRqTpq1BLMBHlyPYfjG/je07yNhXvfi/WrGKMYACVgRT438P7iI+ORBXw
         /3heaX4tE5i515kWJeVIbMhMZnX4+qoAC6nzSoN2jyCRoVvEsqG/XmYOEtwtnjjz0Be4
         KbwtSiGrVtX+E9MUM+hVXtIPAiyv/bEcYsriiEmddamU513Ehbp7VT84XD2JM7iRqmgr
         BhO58yF1/mepJM+R80FYrYGRGEYb0ce60zyVlMbvE2CuQB7Snoo+ixb8Awe0yZ3xIW6k
         xck8EBSXUOR9fXPPxS8ceY2jmsPtkEeAL7OAGbS4kz8PjfXVafjzyM+RKT07WwoGLhxI
         +APQ==
X-Gm-Message-State: AMke39kGxVnHR6OcURelmKWFscrJHungEwnej8npK47zTdseUwhlOBUr2vqVZbcEtjLwqF+d3UDe7umaU6FjgKtJ
X-Received: by 10.36.65.161 with SMTP id b33mr10495162itd.114.1487184762885;
 Wed, 15 Feb 2017 10:52:42 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.33.148 with HTTP; Wed, 15 Feb 2017 10:52:42 -0800 (PST)
In-Reply-To: <20170215165107.GA29448@google.com>
References: <20170215003423.20245-1-sbeller@google.com> <20170215003423.20245-3-sbeller@google.com>
 <20170215165107.GA29448@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 15 Feb 2017 10:52:42 -0800
Message-ID: <CAGZ79kaYRHHas-qiAr+RJB2+TLwEgcsOcXUk-SQ65qiSPSWXOw@mail.gmail.com>
Subject: Re: [PATCH 02/14] lib-submodule-update.sh: define tests for recursing
 into submodules
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 15, 2017 at 8:51 AM, Brandon Williams <bmwill@google.com> wrote:
> On 02/14, Stefan Beller wrote:
>> diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
>> index 61c54f2098..7c8c557572 100755
>> --- a/t/lib-submodule-update.sh
>> +++ b/t/lib-submodule-update.sh
>> @@ -4,6 +4,7 @@
>>  # - New submodule (no_submodule => add_sub1)
>>  # - Removed submodule (add_sub1 => remove_sub1)
>>  # - Updated submodule (add_sub1 => modify_sub1)
>> +# - Updated submodule recursively (modify_sub1 => modify_sub1_recursively)
>>  # - Submodule updated to invalid commit (add_sub1 => invalid_sub1)
>>  # - Submodule updated from invalid commit (invalid_sub1 => valid_sub1)
>>  # - Submodule replaced by tracked files in directory (add_sub1 =>
>> @@ -19,8 +20,8 @@
>>  #                    /    ^
>>  #                   /     remove_sub1
>>  #                  /
>> -#       add_sub1  /-------O
>> -#             |  /        ^
>> +#       add_sub1  /-------O---------O
>> +#             |  /        ^         modify_sub1_recursive
>>  #             | /         modify_sub1
>>  #             v/
>>  #      O------O-----------O---------O
>> @@ -73,6 +74,14 @@ create_lib_submodule_repo () {
>>               git add sub1 &&
>>               git commit -m "Modify sub1" &&
>>
>> +             git checkout -b modify_sub1_recursively modify_sub1 &&
>> +             git -C sub1 checkout -b "add_nested_sub" &&
>> +             git -C sub1 submodule add --branch no_submodule ./. sub2 &&
>
> I thought we were trying to avoid './.' when adding submodules?
>

Yes we should; I'll fix that in a reroll.
It's also still on my long term fix list to remove the ./.
$ git grep 'add \./\.'
lib-submodule-update.sh:                git submodule add ./. sub1 &&
t7001-mv.sh:    git submodule add ./. sub &&
t7001-mv.sh:    git submodule add ./. deep/directory/hierarchy/sub &&
t7507-commit-verbose.sh:        git submodule add ./. sub &&
t7800-difftool.sh:      git submodule add ./. submod/ule &&
