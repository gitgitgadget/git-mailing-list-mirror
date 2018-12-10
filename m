Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF57820A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 10:26:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbeLJK0t (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 05:26:49 -0500
Received: from mail-wr1-f52.google.com ([209.85.221.52]:36683 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbeLJK0s (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 05:26:48 -0500
Received: by mail-wr1-f52.google.com with SMTP id u3so9892915wrs.3
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 02:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=0Q2BIMcKynIfgkMyK1Tq9W+sHVciSCzovDM6r7yfbUY=;
        b=jAc4WmlSInMXQghnc31/eyI231JnwQH8loNLYdkXgpaAIj3WXpAi7ekX+lerV98qzM
         hcqtOQCXILcPIuOWxFFw3g3g7fzKnV46TGbNpRxEN3p9gwktoZV1uFtHpoC+02wEtUn4
         pviWjgNPwdJdViwCvkeOQhb2B0VRuteTeXOyk3gQMIU/Bm2Ey4IET4RxrlYWVbe1Y5UC
         H/EghhJXXA0Pxjn9z9VGNh0sfgReSg/vSw35BmdV8vWoWdQ9t2KjYMvgM+t132V+gOKW
         NiBoPLOqxPLKFI4nVaYhVLqmxyLs+E+INhFg4aH6kCrXYWzIAos1FKLZv6wwni1JtlQY
         fGNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=0Q2BIMcKynIfgkMyK1Tq9W+sHVciSCzovDM6r7yfbUY=;
        b=rQkN1tPPzvuwuc+yxLtU6IBk7/3QVeKRBi30bgNaeLFb3tcuQ1/WLIs74FvXbf/bfC
         hdL1QYLSqNrUwWx28T3XdIuMTIhXzJWKk1WBP20qKCdga5hT8obD91EFp7YcauQNwMGu
         azbsnSMXMyQBnyY4zd0r58TMJY7ilFVwPHkhetyseNkf/HCoTKBR4p4c6dOawptgrvsw
         rdNWsxqOQtas0lMKIsq4OumSoUS9xlsecOQ4D6WenjEzcHw3bp1nLmLfVYi/mJCJQqtq
         vWJ1fbgCVWv1RhHsiVnTmP74ccME0nU5XuoX0A5HiWQ8ocJmkk/TfN46b1ozOYB5jLvE
         sQgg==
X-Gm-Message-State: AA+aEWa+e3f12Xla73a8yINwuJ4SOcwya4ffMdeJrOvKFJLp23Hu2aBy
        MJBCHLTyR3g45HKzcpKxEVI=
X-Google-Smtp-Source: AFSGD/VsIuqHClfNSZcXXyeH6nKnT41WRfiVXtVf73egkQeBKDTFyPhNBwWmiiCnMxaN4SI6rySyhA==
X-Received: by 2002:adf:db01:: with SMTP id s1mr8923877wri.214.1544437606296;
        Mon, 10 Dec 2018 02:26:46 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 133sm9599561wme.9.2018.12.10.02.26.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 02:26:45 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Dec 2018, #01; Sun, 9)
References: <xmqq8t0z3xcc.fsf@gitster-ct.c.googlers.com>
        <20181209090300.GA32640@archbookpro.localdomain>
        <xmqqo99u2hjy.fsf@gitster-ct.c.googlers.com>
        <20181210035238.GA2104@archbookpro.localdomain>
Date:   Mon, 10 Dec 2018 19:26:45 +0900
In-Reply-To: <20181210035238.GA2104@archbookpro.localdomain> (Denton Liu's
        message of "Sun, 9 Dec 2018 22:52:38 -0500")
Message-ID: <xmqqtvjlisnu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> On Mon, Dec 10, 2018 at 12:21:05PM +0900, Junio C Hamano wrote:
>
>> And the "story" is not "If you have remote.$name.url and want to
>> move its value to remote.$name.pushurl while setting the former to a
>> new value, then..."  I want to know why the user gets in such a
>> situation in the first place.
> ...
> The following is the story that led to me writing the feature in the
> first place:
> ...

OK, so in essense, it is quite similar to the following,

>> ....  Perhaps you originally had a R/W URL that always
>> require authentication, but now you want to use an anonymous R/O URL
>> for your fetch traffic without having to authenticate?  If there is
>> a model situation to make all of these four hold, perhaps it can be
>> added somewhere to help users who would find the new feature useful
>> discover it.

i.e.

	You may have started your interaction with the repository
	with a single authenticated URL that can be used for both
	fetching and pushing, but over time you may have become sick
	of having to authenticate only to fetch.  In such a case,
	you can feed an unauthenticated/anonymous fetch URL to
	set-url with this option, so that the authenticated URL that
	you have been using for pushing becomes the pushURL, and the
	new, unauthenticated/anonymous URL will be used for
	fetching.

With something like that in the documentation, I think the users
won't be puzzled by a feature that is seemingly a bit too niche, I
would think.

Thanks.
