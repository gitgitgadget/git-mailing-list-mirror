Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52C3F202A5
	for <e@80x24.org>; Mon, 25 Sep 2017 20:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965026AbdIYUEw (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 16:04:52 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34159 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934287AbdIYUEv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 16:04:51 -0400
Received: by mail-pg0-f67.google.com with SMTP id u18so5438588pgo.1
        for <git@vger.kernel.org>; Mon, 25 Sep 2017 13:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ix4iqyJW7GJlEOMRapwKo/v3QAyXfYFzyPU6zzrsRQg=;
        b=gdlE8SXic5JMjVRjHr2+dJl3T7dk/YyGc+3VD2oSH5MtrywbYGZl0jMzCKuxXrllzM
         kGag8cR6uKar5OQ8Fs4RvLLx5YBdvW9Ogse0B3YdkJCiNAGzQ4KYagcQKtTKUp4U3jp0
         KqD+n8Kyjh0jfRT5odtkazjrpMCttKt6UIcaErquVWX/Gj87SfqTnJWcK1NVQWhz5VFJ
         e+XVawygteHtlxwooF2FykyVZ/WkZ0tMRENZmuEObXCYyIjxYNPn0U+zvymuuC/6Uelm
         P+e91bqyrjRpGdXHsZ/a8yi96KnKasQmLVbW+dAoIPz8Y03PjoxaDmHCU1eng5LTnEYy
         ZR/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ix4iqyJW7GJlEOMRapwKo/v3QAyXfYFzyPU6zzrsRQg=;
        b=UBaBSwIg1kYZM6esb3r84TMgsULWBz001DhhAyRVTUBV2Wu89cJavM91F/S59ntxbs
         5rYYSIQ0HlvALAo4VHzOUOq8tAtdmrTjRcnmEVsR7u5rc0bav45AUibN/LD2pfAiwO1M
         2jcyYQTyCpsMAzdZX56Ys/gvaZRPYG9HdLvwXupaAmp+9kTJh5q6q5CerQD6bI6MEog0
         EKNKzlwlX8OVcJ9EsV9zUGv4lsUayxQj7gdEH/5FlW3pEKUVhO/2mkMF+BYCfB+OnHg+
         /76kSF36TQ9rp80Qy3dqpfn10g9VOlkYc4BUStuEgCNbuxe/dfzj7Fo0NVR/oaeqfnJs
         qfog==
X-Gm-Message-State: AHPjjUiYceOej0ABPuGiBRUu+rLvfmF9c3jb/3tJy6RRMh2xEuPIstGj
        zG/YF/lr5lWUsJKEZb9FUxoxgc9M
X-Google-Smtp-Source: AOwi7QBfpJzba78ctST6o9Angj2qAcjGIuD6s6/toAqTNmHNFhGDLBrv45BKa0gVnagz959m1T71yw==
X-Received: by 10.98.220.209 with SMTP id c78mr8656813pfl.37.1506369890535;
        Mon, 25 Sep 2017 13:04:50 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:b5cd:5017:828c:d0cb])
        by smtp.gmail.com with ESMTPSA id o5sm12526939pfh.67.2017.09.25.13.04.49
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 25 Sep 2017 13:04:49 -0700 (PDT)
Date:   Mon, 25 Sep 2017 13:04:48 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] t7406: submodule.<name>.update command must not be run
 from .gitmodules
Message-ID: <20170925200448.GY27425@aiede.mtv.corp.google.com>
References: <20170925195533.15172-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170925195533.15172-1-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller wrote:

> submodule.<name>.update can be assigned an arbitrary command via setting
> it to "!command". When this command is found in the regular config, Git
> ought to just run that command instead of other update mechanisms.
> 
> However if that command is just found in the .gitmodules file, it is
> potentially untrusted, which is why we do not run it.  Add a test
> confirming the behavior.
> 
> Suggested-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  t/t7406-submodule-update.sh | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
> index 034914a14f..780af4e6f5 100755
> --- a/t/t7406-submodule-update.sh
> +++ b/t/t7406-submodule-update.sh
> @@ -406,6 +406,16 @@ test_expect_success 'submodule update - command in .git/config' '
>  	)
>  '
>  
> +test_expect_success 'submodule update - command in .gitmodules is ignored' '
> +	test_when_finished "git -C super reset --hard HEAD^" &&
> +
> +	git -C super config -f .gitmodules submodule.submodule.update "!false || echo >bad" &&

What does the '!false || echo >bad' do?

Ideally we want this test to be super robust: e.g. if it runs the
command but from a different directory, we still want the test to fail,
and if it runs the command but using exec instead of a shell, we still
want the test to fail.

Maybe write_script would help with this.  E.g. would something like

	test_when_finished ... &&
	write_script must_not_run.sh <<-EOF &&
	>$TEST_DIRECTORY/bad
	EOF

	git -C super config -f .gitmodules submodule.submodule.update \
		"!$TEST_DIRECTORY/must_not_run.sh" &&
	...

work?

Thanks,
Jonathan
