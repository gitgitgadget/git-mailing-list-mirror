Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84FDE1FF7F
	for <e@80x24.org>; Wed,  7 Dec 2016 20:26:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753567AbcLGU0i (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 15:26:38 -0500
Received: from mail-qt0-f172.google.com ([209.85.216.172]:35459 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753493AbcLGU0h (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 15:26:37 -0500
Received: by mail-qt0-f172.google.com with SMTP id c47so391397997qtc.2
        for <git@vger.kernel.org>; Wed, 07 Dec 2016 12:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xIEFraT2vxLkigMl8bB4GPpvVwvVGEzXLHq0U06iiiw=;
        b=MQjeV5cZhR9xoLw6mFATNSQ/njChn13n0VzNKpaxkqED05324Nyl0IHVfUhvhHDAEm
         7z+5zqgYpGzZ6a5AtR9H78KIZEsfTnoXHu4FmolNVOr/eg+5rKaVu2qlotF/YqICTWV0
         Xkz9RNQ7rbVOv1az+s3B14KxP/Mbox/mMSJvdvktVnidDUCURrsbin5/58ODOeGZGImE
         z0Cx1EI/hWeu7tPiRqBGQdb+ljm8iR7YSEAyNdBzMoUchUyxrpP5mL+QGwv3iCncihsy
         jdBq0DCMsGWOcZlvYXuR79EXnkYgrYDSqVJKAD0k7uwkJUYnUXuNR7DjTpVZ6B58pZoZ
         AGsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xIEFraT2vxLkigMl8bB4GPpvVwvVGEzXLHq0U06iiiw=;
        b=iw2il4Pe2tlgtrCPrKjnMcKlPWLPjHk8fPjdcES7bf+jAXXY1teuLh0gqXwN6tYBf6
         RhwotkuI68/mJR99aXBl5xufGWA3GKnHlB9kgCd7oWIPJCq0KWFqzXRjU2fR1E5WhGKN
         V0dsIJj705y8HRCG8Zt52uyGpA0VzJ8AD2fPSNCPTTe/XqjQknSKkNiuYhJTrskJJEk5
         YphkmBTaq2/z/MFUxPVRyaSrDENnBIZ8kPO0VszmnGgDYWvigyuOPrFuGrpqjjHQG2rl
         VKBTZVOirRHg2dIqsz2KsUK9eX84HzNbHfnZSgGpfjXjinzHruszKcghUTdgxBJ+U0G3
         IMyQ==
X-Gm-Message-State: AKaTC018xhKh4k0NAc12gX2w8/D7xIMXFKKLns3q4KH2gERSc5xsnleojZPnWGOTbqL67HQTF9sDM0K7cs8RsxuP
X-Received: by 10.200.58.65 with SMTP id w59mr60014144qte.54.1481142396791;
 Wed, 07 Dec 2016 12:26:36 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.147.188 with HTTP; Wed, 7 Dec 2016 12:26:36 -0800 (PST)
In-Reply-To: <xmqq4m2fxzl2.fsf@gitster.mtv.corp.google.com>
References: <20161207184248.6130-1-vi0oss@gmail.com> <CAGZ79kY3LR2KA69b4iDJb164EhJLb3JuVSRRcN0-4-kp-eryog@mail.gmail.com>
 <xmqq4m2fxzl2.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 7 Dec 2016 12:26:36 -0800
Message-ID: <CAGZ79ka=XgO-VyS+Jqq2Fy28kPMy6HnXBAHb79Dt3NegZFd6kw@mail.gmail.com>
Subject: Re: [PATCH] submodule--helper: set alternateLocation for cloned submodules
To:     Junio C Hamano <gitster@pobox.com>
Cc:     vi0oss@gmail.com, "git@vger.kernel.org" <git@vger.kernel.org>,
        Stefan Beller <stefanbeller@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 7, 2016 at 12:18 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>>> This patch makes all not just the root repository, but also
>>> all submodules (recursively) have submodule.alternateLocation
>>> and submodule.alternateErrorStrategy configured, making Git
>>> search for possible alternates for nested submodules as well.
>>
>> Sounds great!
>
> Is it safe to assume that all the submodules used recursively by
> submodules share the same structure upstream?  Does the alternate
> location mechanism degrades sensibly if this assumption turns out to
> be false (i.e. "possible alternates" above turns out to be mere
> possibility and not there)?

According to the last test in the patch, this seems to be doing the
sensible thing.
