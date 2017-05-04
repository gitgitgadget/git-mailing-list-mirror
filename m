Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A974207FF
	for <e@80x24.org>; Thu,  4 May 2017 03:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932592AbdEDD3Z (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 23:29:25 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:34193 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932606AbdEDD3Q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 23:29:16 -0400
Received: by mail-pg0-f50.google.com with SMTP id v1so1263015pgv.1
        for <git@vger.kernel.org>; Wed, 03 May 2017 20:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QXtRlmweq3Q31XMM6MSnlVddgtgtegR8AYPucVp1LIc=;
        b=D/Hv/Qrtt3m/caucEcjoTFNXSJu7lYlJGRuvgqR+qirabYwDZawrBVXNAQEiDqLQtW
         IQtMMA+0FckWKFtP4L5IrULNYFXA/FWwBWd0rUwfEcBfkSB7fH6BbJQ4fpAgUQsymePQ
         wQwFtZor5R0YEH5rtNH8DvmiZxN4/xaEq/peBd6u56NNCx+RUTDgsSaD9gOFOmv2I3U2
         YjgoxM0xuW6DEHeVkHIM0UbsTULDwnLiNEvR+jC+/Ii9rcNtPtw39PCRByJXErKrU0+Y
         WQ2almHhH079yh/CoPk9+r+D0gHpOWmOoHp+4D0YTI0qKbZUYEoIGs8KUmsi8MzQ3pmN
         okuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QXtRlmweq3Q31XMM6MSnlVddgtgtegR8AYPucVp1LIc=;
        b=WCsoHnoTWDzk3l+RPCUca1ktzAJRH/osmcQFGRsP/4ENE1c3p7tM2vVFAA/VuqMu9S
         AMhB+wKp3I1iEUCoMHSeV77IR202FpAv+rd8PBrxx6A8tA+9ls3eUSEw4XJsifypShGe
         uHlcsPSzKIHTNU0gj6b25hJxNPXDtuaXk2ds7pjcx0lFdu5PBSj/IJnZLKdfksb3MToc
         Ur1vPx6FJYplNdJ4vTlTtqxG6KlKcMxSORJ9T3T+tBLpriBxg/gv3mLKkryfKwO8TdaM
         OuLbS2R99KRNP0gvjmNe6xP2qQsJ+5qKkvZKwb6rkN/vDG/0CbbqtfAjoi/MA6KuQ6Nb
         tJMQ==
X-Gm-Message-State: AN3rC/75wCM8OioX98SMcRpOuFJZBEhvzVm1PTGIzOhQ2rxde0+JsRQ0
        F/l17dd4gsnvr0wP
X-Received: by 10.98.211.202 with SMTP id z71mr3496800pfk.46.1493868555571;
        Wed, 03 May 2017 20:29:15 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:1c5a:250c:656:7a04])
        by smtp.gmail.com with ESMTPSA id o76sm288530pfi.119.2017.05.03.20.29.14
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 03 May 2017 20:29:14 -0700 (PDT)
Date:   Wed, 3 May 2017 20:29:13 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Samuel Lijin <sxlijin@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 0/5] Start of a journey: drop
 NO_THE_INDEX_COMPATIBILITY_MACROS
Message-ID: <20170504032913.GB139188@google.com>
References: <20170501190719.10669-1-sbeller@google.com>
 <xmqq7f20f3a8.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kZkssTEdNyzYh1YYv89szvig=rn2j3DJcHxsbzdADRw-w@mail.gmail.com>
 <b2d1d2fe-1b9b-4afa-192f-267bbb5df487@jeffhostetler.com>
 <CAJZjrdWF4NLPty81wmPsgUoVz1FddYhTGdjrNuB1LcME5qrwDQ@mail.gmail.com>
 <CAGZ79kZs8q2cn7wJr-2ZFGZEwSsy8K2RZ_xBXfUuZBiGM0Gjog@mail.gmail.com>
 <CAJZjrdWRjAC4GbJExhHw7OBRbjuUs2bs5bpvaD91W_aj5e3a9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZjrdWRjAC4GbJExhHw7OBRbjuUs2bs5bpvaD91W_aj5e3a9g@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/03, Samuel Lijin wrote:
> On Wed, May 3, 2017 at 12:14 PM, Stefan Beller <sbeller@google.com> wrote:
> > On Wed, May 3, 2017 at 4:31 AM, Samuel Lijin <sxlijin@gmail.com> wrote:
> >>
> >> Just to throw out an example, I'm relatively new to the codebase (I've
> >> been lurking on the mailing list for a few months now) and for a
> >> recent project (I'm an undergrad wrapping up my senior year, and one
> >> of my classes' final projects was to do something that involved
> >> concurrency) I took a shot at parallelizing the estimate_similarity()
> >> calls in diffcore_rename(). The only way I was able to get it to work
> >> was by dropping global mutexes in one or two files (the code for those
> >> mutexes still makes me cringe), because of concurrent writes to global
> >> data structures.
> >
> > That sounds like a challenge. As we have many globals, we need to be
> > very careful about threading.
> >
> > Also an interesting discussion about threading:
> > https://public-inbox.org/git/9e4733910708111412t48c1beaahfbaa2c68a02f64f1@mail.gmail.com/
> 
> Thanks.
> 
> > Are the patches available for discussion?
> 
> I was planning on revisiting the patch series before sending it out -
> the changes in attr.c and sha1_file.c are not pretty (and I'm pretty
> sure one of them is non-portable) - but it is published at
> https://github.com/sxlijin/git/commits/parallelize.thread-pool.1 (it's
> based off v2.12.2).

I spent a good chunk of time reworking the attribute code a few months
back in order to make it thread-safe so you may want to rebase on top of
a newer version and see if your changes get a little less messy (if so
then I did my job :).

-- 
Brandon Williams
