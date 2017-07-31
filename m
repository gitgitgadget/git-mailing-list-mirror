Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84D5E1F991
	for <e@80x24.org>; Mon, 31 Jul 2017 22:21:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751970AbdGaWUt (ORCPT <rfc822;e@80x24.org>);
        Mon, 31 Jul 2017 18:20:49 -0400
Received: from mail-lf0-f52.google.com ([209.85.215.52]:38720 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751705AbdGaWUq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2017 18:20:46 -0400
Received: by mail-lf0-f52.google.com with SMTP id y15so119205527lfd.5
        for <git@vger.kernel.org>; Mon, 31 Jul 2017 15:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=crh7yzKM6Qzn6FJKg+5YWqVavr1XRTo0vg8wAnZ16KM=;
        b=G23s9tDx694ZhvJXXe9N/HCn15OI1HCI1unMJvj9I4/A7HvoiOCwiw1lGy+Qi57XqS
         v+K5AQbeKefr9POsf3O1xWxjrEDhBZtHt5ee7fckq4WtgJ2GnYrRKNGIg1YOj3BI1SzF
         Y9bPKjtPVGWZitQxNsKBHObCigS4h9IXyob7/2Hm77jNNGHPJSsoP6gUZ/wqt4yA2Gcl
         JELlGMEAoh6O/yLGukqnPws3vjEv50mmb2oYVkl0/wqVmONu2JPmeMawPmRxzLCE0oXt
         +Y02Iaj5Ipdw2x0+Ztx/ig+F6mC1FSePAxF0SHvsLbBFI0AvwLcKXWFAUyXj+AhJkM/k
         KIOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=crh7yzKM6Qzn6FJKg+5YWqVavr1XRTo0vg8wAnZ16KM=;
        b=e0aBneVbGPVG52gwXu3/DLOq2m876oilB8PocJbBlwpCNjuxtPeH140b1nVQQ4x/nk
         15GmOegXJg8Xwvwvan+X4VxKnFP1nbw6Q0Eqgv8xTSuifjSRFdr9MQAbolSSgRNH3Ypc
         GZ+mL8q8DejMw3QsX0lMrgmhccpfkgmxUTekRtYsJ2xZddLgTEJVoTr6pLyva4pmSVeo
         JNOZzVkTm2Sv+OwMMobH/QJcvploHRdjd29nUjzbD+tZuQLFLYdoHPf1FxbfxKNiOBaC
         dlaF6HpwfIYQjmKgJ2VqOfqyBdLv9fDPlUQtuB7Hl+ovsf+xkD/HR8eniC4hvRDTXeRb
         8Lpg==
X-Gm-Message-State: AIVw113P45B3RJq1iQI90hhkmyOYalEoAKEI4Jumkb6K3FwLGqFctbpY
        ZOa8MEAEmpQKkls9eisXD6uSO/eclYsN
X-Received: by 10.46.32.41 with SMTP id g41mr6024847ljg.96.1501539644930; Mon,
 31 Jul 2017 15:20:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.1.130 with HTTP; Mon, 31 Jul 2017 15:20:44 -0700 (PDT)
In-Reply-To: <20170731205621.24305-14-pc44800@gmail.com>
References: <20170731205621.24305-1-pc44800@gmail.com> <20170731205621.24305-14-pc44800@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 31 Jul 2017 15:20:44 -0700
Message-ID: <CAGZ79kYow5a-dwggDAvGweajrxYNhmtb+oWKTGKriiHtBj-kbw@mail.gmail.com>
Subject: Re: [GSoC][PATCH 13/13] submodule: port submodule subcommand
 'foreach' from shell to C
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 31, 2017 at 1:56 PM, Prathamesh Chavan <pc44800@gmail.com> wrote:
> This aims to make git-submodule foreach a builtin. This is the very
> first step taken in this direction. Hence, 'foreach' is ported to
> submodule--helper, and submodule--helper is called from git-submodule.sh.
> The code is split up to have one function to obtain all the list of
> submodules. This function acts as the front-end of git-submodule foreach
> subcommand. It calls the function for_each_submodule_list, which basically
> loops through the list and calls function fn, which in this case is
> runcommand_in_submodule. This third function is a calling function that
> takes care of running the command in that submodule, and recursively
> perform the same when --recursive is flagged.
>
> The first function module_foreach first parses the options present in
> argv, and then with the help of module_list_compute, generates the list of
> submodules present in the current working tree.
>
> The second function for_each_submodule_list traverses through the
> list, and calls function fn (which in case of submodule subcommand
> foreach is runcommand_in_submodule) is called for each entry.
>
> The third function runcommand_in_submodule, generates a submodule struct sub
> for $name, value and then later prepends name=sub->name; and other
> value assignment to the env argv_array structure of a child_process.
> Also the <command> of submodule-foreach is push to args argv_array
> structure and finally, using run_command the commands are executed
> using a shell.
>
> The third function also takes care of the recursive flag, by creating
> a separate child_process structure and prepending "--super-prefix displaypath",
> to the args argv_array structure. Other required arguments and the
> input <command> of submodule-foreach is also appended to this argv_array.
>
> Helped-by: Brandon Williams <bmwill@google.com>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
> ---
> In this new version, the following changes have been made:
> * Comment style is improved in the function runcommand_in_submodule()
>
> * Comment in added about why the variable "path" was exposed via args
>   argv_array instead of exposing it via the env_array.
>
> * This patch exposes the various variables when argc == 1 only, just
>   for maintaining a faithful porting. You can also find discussion about
>   the same at [1].
>
> [1]: https://public-inbox.org/git/CAME+mvUSGAFbN5j-_hv7QpAS57hq4wgH+yZ7XJMPuyQN1gALaA@mail.gmail.com/

Ah right, maybe add a NEEDSWORK or have the commit message explain
this behavior.
