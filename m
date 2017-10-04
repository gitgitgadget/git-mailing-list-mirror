Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C13AA20365
	for <e@80x24.org>; Wed,  4 Oct 2017 12:27:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751962AbdJDM1v (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Oct 2017 08:27:51 -0400
Received: from mail-qk0-f180.google.com ([209.85.220.180]:45319 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751947AbdJDM1u (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2017 08:27:50 -0400
Received: by mail-qk0-f180.google.com with SMTP id c67so10616675qkg.2
        for <git@vger.kernel.org>; Wed, 04 Oct 2017 05:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eeFHC/64/EqoJujmwvXzFNdLIXwF3Qt0BEBqia6AG/g=;
        b=MjYqBSJG9x8B3hpo1a0QwzLnDgUJfWzAl5VB4Xkaw3RboJ4OwLFjvRNX01pc5lVU+R
         Pc6eZZlOFzNEMpp7GmpYewZC6vgi3WCVUekBIGc3brVuc2JzsA9GheoJ1OR8RSvAhHSm
         uz3WYtc6S5bE1b99nuIquA3lqU+0ku3voLcepUCvE3LhxQfYY4WdICHJP8gj8VwPlcS/
         cqD1nVGnU7DkaiPqLDezNfdmsblLgaqhMuw/ubxFa6JeMrIm3rhhBhbc0EQ/C2z9xn4M
         Z7/K19ueOWJOxX5RlJem7N+9T9xaMHELCIb9N3OxhHpRTUjo/sLslX4KxC9mrO+3BgUx
         5l3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eeFHC/64/EqoJujmwvXzFNdLIXwF3Qt0BEBqia6AG/g=;
        b=HTOy+CwdYWBtf1j81CYvO+J7oSh1lFw/55qpF8yHcJpFkd7MEgmegCHaOC8i07Bth+
         bkqRJOJezIUMl01MUYaTSQxP8gWrJdbxVA3TOoAcsXyl1B82FYnm5HjSQveaNu5AElGT
         ZHRaHuPu96QhK2gl8cS/0jeBjp/5QrACPGghJsGUCKfJIyY0nKNZtqGuxr77PferYiJG
         LH85XXj4j4kgJf4w3ECqsTudL0oI7QZpJ204WAdRZ+2uqCdbf88828rZLwC0PX7XSgo6
         BVBfHYagJ/lTAFB3rOcMcP8Xh9b8Uws5ywgcBw3FjIGDHmOm7T4DHZNetSH++ErV1qph
         bqyA==
X-Gm-Message-State: AMCzsaUJEUkOp08VnN/uMzR+tXEdGodoxjI3CFOUKD6Lz6wFF6ux5pC8
        g0yBysTjk1PyTaJfdLut8zI=
X-Google-Smtp-Source: AOwi7QCRNMHoDoO04/6eoSvb96ja58xq21A2II7vZOtrEk026UDTVqKiwocbdeDUhsvf5+h+QSz8Lg==
X-Received: by 10.55.198.209 with SMTP id s78mr22397444qkl.143.1507120069485;
        Wed, 04 Oct 2017 05:27:49 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id m31sm10296802qtf.55.2017.10.04.05.27.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Oct 2017 05:27:48 -0700 (PDT)
Subject: Re: [PATCH v8 00/12] Fast git status via a file system watcher
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ben Peart <Ben.Peart@microsoft.com>,
        "David.Turner@twosigma.com" <David.Turner@twosigma.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "christian.couder@gmail.com" <christian.couder@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "johannes.schindelin@gmx.de" <johannes.schindelin@gmx.de>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "peff@peff.net" <peff@peff.net>
References: <20170919192744.19224-1-benpeart@microsoft.com>
 <20170922163548.11288-1-benpeart@microsoft.com>
 <xmqq7ewiz1mz.fsf@gitster.mtv.corp.google.com>
 <MWHPR21MB0478B8D1C5442B2FCE1ED465F47E0@MWHPR21MB0478.namprd21.prod.outlook.com>
 <xmqqk20fuvg7.fsf@gitster.mtv.corp.google.com>
 <fd972756-4ad3-4b96-23d0-e2c9e59189d1@gmail.com>
 <xmqqzi97fytt.fsf@gitster.mtv.corp.google.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <a7e5d944-7ff0-9c80-17db-7802607d4087@gmail.com>
Date:   Wed, 4 Oct 2017 08:27:47 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <xmqqzi97fytt.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/3/2017 10:09 PM, Junio C Hamano wrote:
> Ben Peart <peartben@gmail.com> writes:
> 
>> Well, rats. I found one more issue that applies to two of the
>> commits. Can you squash this in as well or do you want it in some
>> other form?
> 
> Rats indeed.  Let's go incremental as promised, perhaps like this
> (but please supply a better description if you have one).

Thank you.  Looks good.

> 
> -- >8 --
> From: Ben Peart <benpeart@microsoft.com>
> Subject: fsmonitor: MINGW support for watchman integration
> 
> Instead of just taking $ENV{'PWD'}, use the same logic that converts
> PWD to $git_work_tree on MSYS_NT in the watchman integration hook
> script also on MINGW.
> 
> Signed-off-by: Ben Peart <benpeart@microsoft.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>   t/t7519/fsmonitor-watchman                 | 2 +-
>   templates/hooks--fsmonitor-watchman.sample | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/t/t7519/fsmonitor-watchman b/t/t7519/fsmonitor-watchman
> index 7ceb32dc18..cca3d71e90 100755
> --- a/t/t7519/fsmonitor-watchman
> +++ b/t/t7519/fsmonitor-watchman
> @@ -36,7 +36,7 @@ my $system = `uname -s`;
>   $system =~ s/[\r\n]+//g;
>   my $git_work_tree;
>   
> -if ($system =~ m/^MSYS_NT/) {
> +if ($system =~ m/^MSYS_NT/ || $system =~ m/^MINGW/) {
>   	$git_work_tree = `cygpath -aw "\$PWD"`;
>   	$git_work_tree =~ s/[\r\n]+//g;
>   	$git_work_tree =~ s,\\,/,g;
> diff --git a/templates/hooks--fsmonitor-watchman.sample b/templates/hooks--fsmonitor-watchman.sample
> index 870a59d237..c68038ef00 100755
> --- a/templates/hooks--fsmonitor-watchman.sample
> +++ b/templates/hooks--fsmonitor-watchman.sample
> @@ -35,7 +35,7 @@ my $system = `uname -s`;
>   $system =~ s/[\r\n]+//g;
>   my $git_work_tree;
>   
> -if ($system =~ m/^MSYS_NT/) {
> +if ($system =~ m/^MSYS_NT/ || $system =~ m/^MINGW/) {
>   	$git_work_tree = `cygpath -aw "\$PWD"`;
>   	$git_work_tree =~ s/[\r\n]+//g;
>   	$git_work_tree =~ s,\\,/,g;
> 
