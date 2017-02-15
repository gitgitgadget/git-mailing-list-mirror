Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 806582013C
	for <e@80x24.org>; Wed, 15 Feb 2017 02:41:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751516AbdBOCl1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 21:41:27 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34921 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751410AbdBOCl0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 21:41:26 -0500
Received: by mail-pf0-f195.google.com with SMTP id 68so5611055pfx.2
        for <git@vger.kernel.org>; Tue, 14 Feb 2017 18:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=VXjOXoCIGLj51NK2kwxgxaR3kD45pXrSXIXmxx3nJ/8=;
        b=aHkyNlll2q7WUXF+draHz8kvW2KeDAHGa0vq9K6DqfQ2rrFKYrmIlMc4/cVEONhqN2
         3XgcI/Q0kgM03V2OytK1+qxB2oMYP5Ls3mein/mvRlzIdrOV3jtii2vydmFzFVKgroZW
         omL3pE9r2vxGIc/TN9R50qvxfbaDuJrLK2Kmzcpd30d88lUDVcctRT9LyrnmpqJJQFzu
         Cxlh3po+HvdQDANNld09F6RqQSaQb/ZDuQI3PoONJA1YKz7ul+uSXgWXWlHQ6CKXkuaE
         5cx+fOgULJTzhRvWlYR1sNY3rsw0fggS2fvmousj+7MMXe61hep9czMnoEG32tnMxxkq
         IjWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=VXjOXoCIGLj51NK2kwxgxaR3kD45pXrSXIXmxx3nJ/8=;
        b=RRpYxctSxZEUbFZxiPbE1Yn/7invq9Q4aGVQAQmy4zojTeYA4rDwcHs/RC/wjVc93V
         3Dk55ul9ntV7tPHtrDTo5Y4iT5As7Y3/Jte84A+39CPGqXqmhcDm6lHHw7rg3Po+eAQA
         dsSvWOGHIuZnym6xXOJeaNnyfQ197vF4+q+z2iVJNX1AwyFjuPE1pUp9OB39HOJkMdwz
         LqwCHjzjJAj8ZAuVSoajGln+nnrKh/GjXieNbIPBaxhN9JlG2rBiXUnFwPWf+sVlYumx
         SoIfzNkSx+GCSGj+wEGQp6AmKG8oXdWhSFR1JO3Wy6IhOUpyw+qCyZ1EJFuZvNKJWAT9
         0rEQ==
X-Gm-Message-State: AMke39nqMZf0t/NpZWroD9K6YB60K8KKdTsnTsowJ+uANEaST/xVmds4FnSzjVk8sH5e2w==
X-Received: by 10.98.163.23 with SMTP id s23mr34636075pfe.60.1487126485453;
        Tue, 14 Feb 2017 18:41:25 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:2447:f72c:8fdf:75c6])
        by smtp.gmail.com with ESMTPSA id l3sm3645667pgn.10.2017.02.14.18.41.23
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 14 Feb 2017 18:41:23 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] completion: restore removed line continuating backslash
References: <20170213192036.10671-1-szeder.dev@gmail.com>
        <xmqqfujhddl2.fsf@gitster.mtv.corp.google.com>
        <CAM0VKjmU57saSfyRuoWfC+UZFNypH1Wp9X33VgzPq9fatD=qtg@mail.gmail.com>
Date:   Tue, 14 Feb 2017 18:41:22 -0800
In-Reply-To: <CAM0VKjmU57saSfyRuoWfC+UZFNypH1Wp9X33VgzPq9fatD=qtg@mail.gmail.com>
        ("SZEDER =?utf-8?Q?G=C3=A1bor=22's?= message of "Wed, 15 Feb 2017 02:35:28
 +0100")
Message-ID: <xmqqtw7w41m5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

>> If you feel uncomfortable and want these to cook longer, please tell
>> me so.
>
> Well, it was mainly my surprise that a 20+ patch series arriving so
> late that it gets queued on top of -rc0 would still make it into the
> release.

It all depends on what area the changes are about ;-)

Not meaning to make light of your contribution, but if the upcoming
version of Git shipped with a slightly broken completion, and the
breakage is severe enough, the only thing we need to do is to do a
maintenance release that reverts a single script.  Distro packagers
may do that for us.  While waiting, the user can choose not to load
the completion and can keep using Git just fine.  A broken
"mergetool" would be similar in that a workaround to inspect "git
diff" is available.  If we break "pull" or "commit" on the other
hand, the necessary workaround would be a lot more involved.

Some changes in low-impact areas can wait without reducing the
end-user value of the new release, but if the risk of regression is
small, I favour merging them, rather than postponing them for one
cycle, if only to reduce the number of patches that I need to hold
onto.  Patches to clarify existing documentation fall into this
category.

My perception of "risk of regression" obviously is affected by the
size of the series, and 20+ is certainly on the larger side.  But
other things also come into the picture.  Patches from an author who
knows the area the patches touch very well and with track record of
not causing embarrassing regressions, would make me feel safer than
patches from others, for example.

