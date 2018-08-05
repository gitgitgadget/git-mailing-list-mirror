Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 170141F597
	for <e@80x24.org>; Sun,  5 Aug 2018 19:34:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbeHEVjr (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Aug 2018 17:39:47 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:33929 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbeHEVjr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Aug 2018 17:39:47 -0400
Received: by mail-wr1-f48.google.com with SMTP id c13-v6so10339257wrt.1
        for <git@vger.kernel.org>; Sun, 05 Aug 2018 12:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AAH9g1mMFAmLEPkz0iLfGo2PfttkHj7ooo6SpDd4DK8=;
        b=eXUJgRLOvqlrn2rYy4WF7RnWhaJP/dlSjNRE8N4RbPuc/wbLIFZjquA+aTm0I0i23T
         PXGwPvaSBbs1yn6uurQolDicT8JBwi5QT1z2ZKuPDowOCwuOj5CkP/NN3VpIlZGOUivu
         ICFqwoy9WnbWGQrJSoigkkHOJX2xFqio5A8IRK9FHRsx5Tl4aI/Ci1UkezBKXl9wXuX7
         35hVVuygsv80Qt1ap7oVQsDLC6VuzG1D2p24OP8l3dEYhLHUMFD42ykPIs32Q7O0fT3K
         Ez0ol5/dirxQZj4XLSLjIxzg/Oa0hJLHEJoE1907VnuNXcTM8FL7dDZ7OSJva+L1RUY3
         ZlkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AAH9g1mMFAmLEPkz0iLfGo2PfttkHj7ooo6SpDd4DK8=;
        b=uC9NxTG+duShVdaarIyMTFssberXtfttzjal1lShcNli8D7fI6y7GNlLv29/V5h+Sl
         MSVPNZzfjaFHmR/4VP4KZUZWPrM3NW6SnwgLbQmzfRVMtXNAOlkADI53AI16tbfJtPWi
         GAOadhUye1C9PpBX3NkAz+zisK55T46+/ipazAhL3s9+lwDCXd4wkgFhJBHV9+JxhCE9
         mONNS3nTRznH+uDYXynT5Cub4DwQldipbEIbUf+NZUk5F5PDuBMaRz+0REhXWLR3fsg+
         9VyLirrv3LPuR6gw2oWyQq+Kmjv023YLr7bT+8E1s2GxsXLFE62RtaIh72b5s3JSy9vk
         QJLQ==
X-Gm-Message-State: AOUpUlHgbhT50rzXN+iH3arGkAu0TBfXdwxjUMpUAesaXnbkvlBAWfbG
        ikOS8nVxwiKRI3lscgq7X3wQXZrL
X-Google-Smtp-Source: AAOMgpd/7HhYzaCwE4dqhLpqvLF6sKgRqnTEyz6Cg7tVbd8jnpLqYbNGc8v0mJg80uPPpFA0RggnuA==
X-Received: by 2002:a5d:4147:: with SMTP id c7-v6mr8027914wrq.61.1533497648155;
        Sun, 05 Aug 2018 12:34:08 -0700 (PDT)
Received: from localhost ([2.30.88.37])
        by smtp.gmail.com with ESMTPSA id m207-v6sm4392576wma.31.2018.08.05.12.34.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 05 Aug 2018 12:34:07 -0700 (PDT)
Date:   Sun, 5 Aug 2018 20:34:06 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Alexander Mills <alexander.d.mills@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Subject: exit code in git diff-index [was: Re: concurrent access to multiple
 local git repos is error prone]
Message-ID: <20180805193406.GH2734@hank.intra.tgummerer.com>
References: <CA+KyZp4fxRfnPNozEtwgLPuFAnEsXCBPPubzNjv0wUMnBV_eww@mail.gmail.com>
 <CA+KyZp43YGf1qLDHOtrfjJxREcaVQNN12iMLDL5qX=RXhmMCYQ@mail.gmail.com>
 <20180805014631.GD258270@aiede.svl.corp.google.com>
 <CA+KyZp5i0EXPJ10v+SXmHWCYvZ7=XT8K8gcka0qxCBYXq=OevA@mail.gmail.com>
 <20180805061312.GA44140@aiede.svl.corp.google.com>
 <CA+KyZp4Yc4_Xaw3v+BPwxi_PW75=GXmj=Re7EpsurXi2_hMc9w@mail.gmail.com>
 <20180805081116.GG44140@aiede.svl.corp.google.com>
 <CA+KyZp6KXFfEKNho7njg=0tDxAk-mSMP9r9hZFFH+gZcJ8KptQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+KyZp6KXFfEKNho7njg=0tDxAk-mSMP9r9hZFFH+gZcJ8KptQ@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/05, Alexander Mills wrote:
> Also, as an aside, this seems to be a bug, but probably a known bug:
> 
> $ git diff-index  HEAD; echo $?
> 
> :100755 100755 60e5d683c1eb3e61381b1a8ec2db822b94b9faec
> 0000000000000000000000000000000000000000 M      cli/npp_check_merge.sh
> :100644 100644 35a453544de41e2227ab0afab31a396d299139e9
> 0000000000000000000000000000000000000000 M      src/find-projects.ts
> :100644 100644 c1ee7bc18e6604cbf0d16653e9366109d6ac2ec9
> 0000000000000000000000000000000000000000 M      src/tables.ts
> :100644 100644 29d9674fbb48f223f3434179d666b2aa991ad05a
> 0000000000000000000000000000000000000000 M
> src/vcs-helpers/git-helpers.ts
> 0
> 
> $ git diff-index --quiet HEAD; echo $?
> 1
> 
> different exit codes depending on whether --quiet was used. In this
> case, the exit code should be consistent.
> The bug is with the `git diff-index` command, as you can see.

This is not a bug. 'git diff-index' (and 'git diff') only give an exit
code other than 0 in the default case if something actually goes wrong
with generating the diff, which in the usual case it shouldn't.

To get an exit code from 'git diff-index' if there are differences,
you'd have to pass the '--exit-code' flag.  The '--quite' flag implies
'--exit-code', as there's not much use in 'git diff --quiet' if
there's not even an exit code showing whether there are differences or
not.

The original patch (and more importantly the reasoning why
'--exit-code' is not the default behaviour for 'git diff') can be
found at [1].

[1]: https://public-inbox.org/git/81b0412b0703131717k7106ee1cg964628f0bda2c83e@mail.gmail.com/

> -alex

