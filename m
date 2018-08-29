Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_03_06,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIM_INVALID shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C61461F404
	for <e@80x24.org>; Wed, 29 Aug 2018 22:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbeH3CgM (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 22:36:12 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44902 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbeH3CgL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 22:36:11 -0400
Received: by mail-wr1-f67.google.com with SMTP id v16-v6so6233835wro.11
        for <git@vger.kernel.org>; Wed, 29 Aug 2018 15:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:references:message-id:user-agent
         :mime-version;
        bh=unONI1owgCTqieF0oYb3OH/XSV7UH1xrrEpLKw2wd3s=;
        b=KxrXoAq85RmMOaYOsjcrv80mFwcig3W9bD7yFrhpKP/jaDWcCxCo9wxqJzZfkUIQVa
         /KvFrWeM5hPhEMi6czhhlU4tXiccfWH8vmcQUs/VFX6rucsDFuCmWSkcqr189gWu4ItP
         BaoXmgqRw9dj2pAGxWN02r/4N6UZlyHStK6jD3hEAfNMX1Dbo83HdkV3rq4pyOIbBHoH
         NErxKpb5QI/PL1+YBGW4RmuBdoT3d9eEC5GgJ768mpiD5GK4dPeqT+JV2wz4vjPmr0V/
         ZApi/RfYn/7QrzJERX2H/B+SXlPv5QhFjNHKxuqM3msJVm2b9eYl56k3g8qzvNxBbB/d
         Jxbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:references
         :message-id:user-agent:mime-version;
        bh=unONI1owgCTqieF0oYb3OH/XSV7UH1xrrEpLKw2wd3s=;
        b=sZzmvjfmFTu2DnmMDnLdAYR4iWzOyu+Z8qVCBhWHsUQiylSXHJHEndSEdr3n4oB6s5
         T1ky9edNuE+wpuBmdbQRixRrOTG2eVWATBo8qQ9HTXA4e2HzYGXZYvGIhY+oew9QZK2e
         Msfs8cWLTxtmTXWBPVbBwHu1zvGz7yjluDS2CHyXMHGd/HdotnIpp+JvcaRzNnAUkObG
         dTZ1+HVD8EuG8/oB6byU67Pl63hVCTXUThvFHXrz5JVg5Mt5ufuZXxcfGt0e5y+npUwR
         4ibem9WWzo32yJKHcStQJELdFSfPOpr4OgLBh6rd2NYjJmuJsrA99yPZI+s4Vs2NF6TU
         SmCg==
X-Gm-Message-State: APzg51DuD2GaoNEZczlsW9pMcAORNJSeu4ey0i/9lc2/VdYnU62gt1BP
        BsRVgtdX+0+pXeK5Hiz7KPg=
X-Google-Smtp-Source: ANB0VdayRmqZrTRNLT6EYjRtqic6ATmJbQ3DMrWyEOf9W/jB68Zhmu1EmIHzZsyVSolxVxQSvDBMhg==
X-Received: by 2002:adf:9f13:: with SMTP id l19-v6mr5986077wrf.206.1535582226885;
        Wed, 29 Aug 2018 15:37:06 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 124-v6sm39246wmk.20.2018.08.29.15.37.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 15:37:05 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Tim Schumacher <timschumi@gmx.de>, git@vger.kernel.org,
        sunshine@sunshineco.com
Subject: Re: [PATCH v3] doc: Don't echo sed command for manpage-base-url.xsl
Date:   Wed, 29 Aug 2018 12:19:00 -0700
References: <20180829134334.14619-1-timschumi@gmx.de>
        <20180829154720.20297-1-timschumi@gmx.de>
        <20180829165540.GB170940@aiede.svl.corp.google.com>
Message-ID: <xmqqtvnc94vi.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Tim Schumacher wrote:
>
>> Subject: doc: Don't echo sed command for manpage-base-url.xsl
>
> Cribbing from my review of v2: a description like
>
> 	Documentation/Makefile: make manpage-base-url.xsl generation quieter
>
> would make it more obvious what this does when viewed in "git log
> --oneline".

Sounds good; let's take it.

>> Previously, the sed command for generating manpage-base-url.xsl
>> was printed to the console when being run.

The convention is that we talk about the state before the current
series in question is applied in the present tense, so "previously"
is not needed.  Perhaps

    The exact sed command to generate manpage-base-url.xsl appears in
    the output, unlike the rules for other files that by default only
    show summary.

is sufficient.  The output is not always going to "the console", and
it is not like we change behaviour depending on where the output is
going, so it is misleading to say "the console" (iow, the phrase "to
the console" has negative information density in the above
sentence).

>> Make the console output for this rule similiar to all the
>> other rules by printing a short status message instead of
>> the whole command.

Likewise, s/console //;

I'll all do the above tweaks while queueing.

Thanks, both.

>>
>> Signed-off-by: Tim Schumacher <timschumi@gmx.de>
>> ---
>>  Documentation/Makefile | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Oh!  Ignore my reply to v2; looks like you anticipated what I was
> going to suggest already.  For next time, if you include a note about
> what changed between versions after the --- delimiter, that can help
> save some time.
>
> With or without the suggested commit message tweak,
>
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
>
> Thank you.
