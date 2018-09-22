Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF0A51F453
	for <e@80x24.org>; Sat, 22 Sep 2018 12:33:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730187AbeIVS0l (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Sep 2018 14:26:41 -0400
Received: from mail-ed1-f49.google.com ([209.85.208.49]:43618 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728233AbeIVS0l (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Sep 2018 14:26:41 -0400
Received: by mail-ed1-f49.google.com with SMTP id u23so3640281edx.10
        for <git@vger.kernel.org>; Sat, 22 Sep 2018 05:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=0QsxGwK8iAZfNVYlZtqUYfuIWM7cAP7g+DRz+r3ITpA=;
        b=pn8CQOSCCgeIkiMfon9Sb0omtWutc1sKuFNeJbXvZ/LaxjBPhzpKV2jAniHhOzyvUk
         03w4VYfNyUdySGa8kXO6OTJLyEe/HVWNSkfNQrDv11MPJ8hcOdr65NC2nFgTIPkl3o/k
         ztRMLdpONV7mPIXqGx5rNd6Z9j4YXO19y0GDMKPs12I/zyZ0qGgsUblF5jDgXOfuYUSy
         2EGW6rTgmA49YJZzFh2M4jY8m8jBAns0cnWtidD+eqimv0MiQaeSdEBe1kgvTT3Dl9sH
         wPEWsIpZY352UvWRg/orM3gsSlwIGBpPLtOA505JCmyLUTPXQ51urLSF+vwTKP2zZkSp
         NROg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=0QsxGwK8iAZfNVYlZtqUYfuIWM7cAP7g+DRz+r3ITpA=;
        b=SHYO833VKib15JUUFP4mhTspvBEOHPMb4lCX+tNkCOaGM3kZQQ6KtjMdtYsidhzxxs
         l4EvwA4CgPCeaOAIvlNGTYD0wWrJM2anjqs2SmMpypbsfDAFkVQMYu2q/ZT7tHGuyOZ5
         FkTxfy+LucK2w0LB+BCI7UcUt4TsIxcKJOVNsbd2T1rsHu4Nggi87g9pVShlvwWSwTrM
         LylX18xiKJDoJPhjeOAoEb+hAqKflUxtgLbm2oF9VpVMx+sp0dyN20fwB7PbcGaJlB2C
         72iVWzz63fB6gCasq/B9/U1KC2NUOwN65w/5YeeGaFOjuiaYPYqGxY/xNFB5LK7qBv75
         hSdw==
X-Gm-Message-State: ABuFfogcTDuT0lA4HOtg7RYmnaXe5pijU5fgW+Dc00uqDHYoTyiUjbin
        ljt52OloZQNScses9DAjGTlogH8bhWQ=
X-Google-Smtp-Source: ACcGV60NQzmJAzZSkhZARMs82K81rP1HjOPuqS/kcMxWS1WiCf2NPz9YcNwA98eLHBUVmAZbQYmkKQ==
X-Received: by 2002:a50:a267:: with SMTP id 94-v6mr3705085edl.189.1537619593786;
        Sat, 22 Sep 2018 05:33:13 -0700 (PDT)
Received: from evledraar (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id v1-v6sm2896389edf.3.2018.09.22.05.33.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Sep 2018 05:33:13 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "H.Merijn Brand" <h.m.brand@xs4all.nl>
Cc:     git@vger.kernel.org
Subject: Re: Coredump on ls-remote + --sort
References: <20180922124215.0c8172d1@pc09.procura.nl>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180922124215.0c8172d1@pc09.procura.nl>
Date:   Sat, 22 Sep 2018 14:33:11 +0200
Message-ID: <87in2xk8zc.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Sep 22 2018, H.Merijn Brand wrote:

> A small background why I wanted this: I need to build a new version of
> some software hosted in git, add a lot of shared/static stuff and
> automatically test it. I want to get the most recent *tag* and create a
> folder with the tagname in it, go into that folder and clone the repo,
> check out the tag, add the rest of the stuff, build and test
>
> As the default outpout of «git ls-remote --tags» or «git ls-remote» is
> topologically sorted by tagname, the most recent tag is likely to be in
> the middle.
>
> Linux 4.12.14-lp150.12.16-default [openSUSE Leap 15.0]
>
> $ git --version
> git version 2.19.0
>
> $ git ls-remote --tags github.com:Tux/App-ccdiff
> 5e2513ab6dd4a24c8f3a3ace0a3faba6a291d818        refs/tags/0.04
> 2f7ea0f1e751dc20c1ddb15f6d61c6fa62d5d6f1        refs/tags/0.05
> a3802907be5b10383c7438f1d1c660fe13a05d3f        refs/tags/0.06
> 3e4bfa7cde75fba221650b9d3aa5555b706803df        refs/tags/0.07
> 05829d1ac5b49bbdd2167bc363b94f8a12e752b3        refs/tags/0.08
> 9c6e5861ea9c6e50c501663d43c5a9f6d31b54bc        refs/tags/0.09
> e815b059f6326da936c3a92272ba67e273b1dc3e        refs/tags/0.10
> e6b40e331c945449bb8e71023de4920ca5574adc        refs/tags/0.20
> be55e6336b1db5ffad23a6a0a663763e2f5da779        refs/tags/0.21
> e283d563f02bb8d2131e8b95852072ac204b28b4        refs/tags/0.22
> 0d3d1830f542121bfef1d984f21343c6d9c774f8        refs/tags/0.23
> d7bf195a92095a4f0b810584810450e4001b1a2c        refs/tags/0.24
> 5c517cf3f79cb18173714e63bc5b80a3e3f888f1        refs/tags/0.25
>
> Whether or not supported, it should not dump core
>
> $ git ls-remote --tags --sort=authordate github.com:Tux/App-ccdiff
> Segmentation fault (core dumped)
>
> (gdb) where
> #0  0x00007ffff74784a6 in __strlen_sse2 () from /lib64/libc.so.6
> #1  0x000000000057a956 in for_each_replace_ref ()
> #2  0x0000000000596cec in do_lookup_replace_object ()
> #3  0x00000000005c14eb in oid_object_info_extended ()
> #4  0x000000000058b984 in get_object ()
> #5  0x000000000058ddde in populate_value ()
> #6  0x000000000058e36b in compare_refs ()
> #7  0x000000000061447a in msort_with_tmp.part ()
> #8  0x0000000000614505 in msort_with_tmp.part ()
> #9  0x0000000000614518 in msort_with_tmp.part ()
> #10 0x0000000000614518 in msort_with_tmp.part ()
> #11 0x000000000061459e in git_qsort_s ()
> #12 0x000000000058ed40 in ref_array_sort ()
> #13 0x000000000044ef66 in cmd_ls_remote ()
> #14 0x000000000040784f in handle_builtin ()
> #15 0x0000000000407bb0 in cmd_main ()
> #16 0x0000000000406b04 in main ()
>
> Linux 3.10.0-862.6.3.el7.x86_64 [CentOS Linux 7.5.1804 (Core)]
>
> $ git --version
> git version 2.18.0
>
> $ git ls-remote --tags https://github.com/Tux/App-ccdiff
> 5e2513ab6dd4a24c8f3a3ace0a3faba6a291d818        refs/tags/0.04
> 2f7ea0f1e751dc20c1ddb15f6d61c6fa62d5d6f1        refs/tags/0.05
> a3802907be5b10383c7438f1d1c660fe13a05d3f        refs/tags/0.06
> 3e4bfa7cde75fba221650b9d3aa5555b706803df        refs/tags/0.07
> 05829d1ac5b49bbdd2167bc363b94f8a12e752b3        refs/tags/0.08
> 9c6e5861ea9c6e50c501663d43c5a9f6d31b54bc        refs/tags/0.09
> e815b059f6326da936c3a92272ba67e273b1dc3e        refs/tags/0.10
> e6b40e331c945449bb8e71023de4920ca5574adc        refs/tags/0.20
> be55e6336b1db5ffad23a6a0a663763e2f5da779        refs/tags/0.21
> e283d563f02bb8d2131e8b95852072ac204b28b4        refs/tags/0.22
> 0d3d1830f542121bfef1d984f21343c6d9c774f8        refs/tags/0.23
> d7bf195a92095a4f0b810584810450e4001b1a2c        refs/tags/0.24
> 5c517cf3f79cb18173714e63bc5b80a3e3f888f1        refs/tags/0.25
>
> $ git ls-remote --tags --sort=authordate https://github.com/Tux/App-ccdiff
> Segmentation fault
>
> (gdb) where
> #0  0x00007ffff751a67f in __strlen_sse42 () from /lib64/libc.so.6
> #1  0x0000000000561c06 in for_each_replace_ref ()
> #2  0x000000000057c3fa in do_lookup_replace_object ()
> #3  0x00000000005a6aa8 in read_object_file_extended ()
> #4  0x00000000005731e5 in get_object ()
> #5  0x00000000005749df in populate_value ()
> #6  0x0000000000574e9d in compare_refs ()
> #7  0x00000000005efe57 in msort_with_tmp.part.0 ()
> #8  0x00000000005efe31 in msort_with_tmp.part.0 ()
> #9  0x00000000005efe0e in msort_with_tmp.part.0 ()
> #10 0x00000000005efe0e in msort_with_tmp.part.0 ()
> #11 0x00000000005eff5c in git_qsort_s ()
> #12 0x00000000005757e0 in ref_array_sort ()
> #13 0x000000000044c6b6 in cmd_ls_remote ()
> #14 0x000000000040730e in handle_builtin ()
> #15 0x000000000040760e in cmd_main ()
> #16 0x0000000000406554 in main ()

I can't reproduce this, I just get for both ssh and https:

    $ ~/g/git/git --exec-path=$PWD ls-remote --tags --sort=authordate https://github.com/Tux/App-ccdiff
    fatal: missing object 2f7ea0f1e751dc20c1ddb15f6d61c6fa62d5d6f1 for refs/tags/0.05
    $ ~/g/git/git --exec-path=$PWD version
    git version 2.18.0

Same thing on latest 'master' (v2.19.0-221-g150f307afc).

But maybe that's just a symptom of the same bug, when I clone the repo I
get a working 0.05 tag, and it passes fsck, and I do get the
2f7ea0f1e751dc20c1ddb15f6d61c6fa62d5d6f1 object (which is the 0.05 tag
object).
