Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A7B120C11
	for <e@80x24.org>; Fri,  1 Dec 2017 03:40:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752217AbdLADkv (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Nov 2017 22:40:51 -0500
Received: from mail-qt0-f172.google.com ([209.85.216.172]:41372 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751846AbdLADku (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Nov 2017 22:40:50 -0500
Received: by mail-qt0-f172.google.com with SMTP id i40so11548647qti.8
        for <git@vger.kernel.org>; Thu, 30 Nov 2017 19:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wokrEc4IBQ7r95t9AtyW6w2vjJRmLCza0qU+Io96Zvo=;
        b=n4Pl9r3FuSota900ByO/3h8FxEpxMEvqMTsl6mzCnIfWh9+ZANuvD4kQ8CNylOEfcO
         6shZ8pCpSjikSPS7Vge/NmelI6npOak/NLvDjFWKC5gvMiHITAZhIFtFmkmRkujsSfmA
         SI/iMYxMVFw/1Oxf08zHZSN0qU1qDDMlf3onunqzDYoQNNns1T2RSE+JMv2IcUbjQ6d+
         sJbL5sPWJaVEGs8Li7zZtcG4vskg56LXUeEIzumVm4b1diFZgu14FbLK06vJXr/hw+oJ
         v9Ysj1kd8nTem7ARw0OoTuNHRFw8okPqOxN5jOT4zGtbIVxVkag41qstqzYAIvt2uOge
         FIbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=wokrEc4IBQ7r95t9AtyW6w2vjJRmLCza0qU+Io96Zvo=;
        b=IBw3POyx27gJ0HqvFMSa580k7bi7u7WMf0eL0LMuqqMlszgISkD6WGPrn3F/Z5gbnc
         +cszKLG8mpcGmFnMLwnT3z3t9CiqfpRH/av4ofIn3DIlg3nu98F2VlUr/aN7nnbzvZhC
         4VezvE2Gy9hxkYBn6C8vufiYAJHZAIumbdqpmJXPXZocJqvyqGxclzmeH//Zv0oMnUNi
         WwEXCc/COubRc+hi2DuWhyKP4CFrsoARChzXSkWh9cZZdOAmRPpITFcPSL0pEvyKD9LF
         BDlhz5RoQtOFvxRKI07txxt5ftFJH70unVURq4nWdNx/5G3u00P2XSiHIwoB4lutRi1G
         Rn6w==
X-Gm-Message-State: AKGB3mIBmMmiAa38gJWGpY90Pt4P7ts6S+rqlWK3tpsqDOad1OFx0MWq
        mSKnnVbIUun61zqHjOwwUmg=
X-Google-Smtp-Source: AGs4zMZl7eC6z+ekGg715ZgX/MDPbZ5o337Q/jXR/BT8BK56h1hMtFsNBzUWDsO+3u0X8F3Hu36pcw==
X-Received: by 10.200.42.14 with SMTP id k14mr6719389qtk.20.1512099649659;
        Thu, 30 Nov 2017 19:40:49 -0800 (PST)
Received: from zaya.teonanacatl.net (pool-173-67-181-41.hrbgpa.fios.verizon.net. [173.67.181.41])
        by smtp.gmail.com with ESMTPSA id w143sm3907374qka.84.2017.11.30.19.40.48
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 30 Nov 2017 19:40:49 -0800 (PST)
Date:   Thu, 30 Nov 2017 22:40:47 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Eric Wong <e@80x24.org>
Subject: Re: [PATCH 0/2] t/lib-git-svn.sh: improve svnserve tests with
 parallel make test
Message-ID: <20171201034047.GC3693@zaya.teonanacatl.net>
References: <20171201023239.26153-1-tmz@pobox.com>
 <20171201030727.GH20640@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20171201030727.GH20640@aiede.mtv.corp.google.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

Jonathan Nieder wrote:
> Todd Zullinger wrote:
>
>> These tests are not run by default nor are they enabled in travis-ci.  I
>> don't know how much testing they get in user or other packager builds.
>>
>> I've been slowly increasing the test suite usage in fedora builds.  I
>> ran into this while testing locally with parallel make test.  The
>> official fedora builds don't run in parallel (yet), as even before I ran
>> into this issue, builds on the fedora builders randomly failed too
>> often.  I'm hoping to eventually enable parallel tests by default
>> though, since it's so much faster.
>
> This background could go in the commit message for patch 2, but it
> also speaks for itself as an obviously good change so I could go
> either way.

Heh.  If there's something in there in particular that seems useful, I
can certainly add it.  I'm not sure what parts of this text would be
beneficial to someone down the line though.

I usually err on the 'too much information' side of commit messages.
I'm happy that it's much harder to do that here.  I'd rather have to
skim a long message than wonder about the motivation for a change.

>> I'm not sure if there's any objection to changing the variable needed to
>> enable the tests from SVNSERVE_PORT to GIT_TEST_SVNSERVE.  The way
>> SVNSERVE_PORT is set in this patch should allow the port to be set
>> explicitly, in case someone requires that -- and they understand that it
>> can fail if running parallel tests, of course.  Whether that's a
>> feature or a bug, I'm not sure. :)
>
> micronit: can this just say something like
>
> 	Patch 2 is the important one --- see that one for rationale.
>
> 	Patch 1 is an optional preparatory style cleanup.
>
> next time?  That way, you get an automatic guarantee that all the
> important information is available in "git log" output to people who
> need it later.

Yeah, I'll try to remember that.  I started this without the
whitespace cleanup and as I was writing in the single patch
description that I didn't think the whitespace cleanup was warranted,
I talked myself into doing it as the prep patch. :)

Thanks,

-- 
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Tradition: Just because you've always done it that way doesn't mean
it's not incredibly stupid.
    -- Demotivators (www.despair.com)

