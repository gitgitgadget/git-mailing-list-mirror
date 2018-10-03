Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C262D1F453
	for <e@80x24.org>; Wed,  3 Oct 2018 19:08:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbeJDB6J (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 21:58:09 -0400
Received: from mail-ed1-f43.google.com ([209.85.208.43]:34578 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbeJDB6J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 21:58:09 -0400
Received: by mail-ed1-f43.google.com with SMTP id q19-v6so6391712edr.1
        for <git@vger.kernel.org>; Wed, 03 Oct 2018 12:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0BJ4TtIkM/BCabQORdGDcivu1e8AL8DYnTSHximlkW4=;
        b=EwfMCk5Mga4ZYcC50OoEnNKQb2aQj9cbP0Fsa0yjKsE7/XUqUXUoirsXGtUTRP3mFJ
         wAPUG8TpIFyvz+NduisDEqs/1/ybOnTGoznbMklREeMFtK3gN8zAKCFwPn32VTRDDmHB
         G73X9czKMwfuEGeRbyPqh05D0Qxk2g4IaquBjJyX7XkM6pKZCzY0hXCaDiY1znE31cdW
         U+rj75u/qWdkwiB9Djsgh9FcaXp7JPDlTAHP2/KSHk8YAtl7cuxVhhFm03XUQwY9DiA4
         21KwdyH4iA/3TkK8RnZLvDZ8FBqV0pkF107t+ezFAZtEuDBZh3c2lopu1J/bmA+VEVYj
         kZ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0BJ4TtIkM/BCabQORdGDcivu1e8AL8DYnTSHximlkW4=;
        b=AcmtSLMoC3S3gW/JardHCKDSEQNHO/52TFCij+I3psvjLWKzGnGpBWrISjaNC5BlAz
         Pta9LlFak9ZId7HD+4XD9l5iRlHLF47r10n57g1cVfZWvNmPyURaK50HI7i3XA3zFvjW
         6Uay7ryHskDnWh3jiNB5sKOp1EZF6Jr5NdOh32Czg4xuCH9b1oSggkDTty03BOsBwjiJ
         YktFS7OwTcq56GzRp5sYq8z99F2CC/0edE8UiLl2v01WAUrh33bTXn8X0sqZuaMUF7tn
         X8H3aSCMHPwQfWQygSO+XcXTpYW6sMAO+J7sp1oYnHg7u2DOMzqI47VMItRFc8Lvc9AX
         VfBw==
X-Gm-Message-State: ABuFfoiGB6RqbAOrBTdrDihJ3ZoGI6vgULefhpSyjTYUnyMCuOikp1mC
        Us3HSeLaKaOXAwYFCveEiF+Pyqq7EyQwsm+BJ175rQ==
X-Google-Smtp-Source: ACcGV63a56H2XRQPX6meVQ5Gaoc2W0T5T96PhyZCLo1DbQhW0dmlokElm5H3Nj5JU5yx7etJ5+6cq0C2pvM9Cr2+gkI=
X-Received: by 2002:aa7:d9cf:: with SMTP id v15-v6mr4180451eds.25.1538593707342;
 Wed, 03 Oct 2018 12:08:27 -0700 (PDT)
MIME-Version: 1.0
References: <87tvm3go42.fsf@evledraar.gmail.com> <20181003133650.GN23446@localhost>
 <87r2h7gmd7.fsf@evledraar.gmail.com> <20181003141732.GO23446@localhost>
 <87o9cbglez.fsf@evledraar.gmail.com> <20181003145308.GP23446@localhost>
In-Reply-To: <20181003145308.GP23446@localhost>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 3 Oct 2018 12:08:15 -0700
Message-ID: <CAGZ79kbyCZcMuj=_Od+C+tHg=PzzDd8QV+9RqS7iFcZS+Ht+Bg@mail.gmail.com>
Subject: Re: We should add a "git gc --auto" after "git clone" due to commit graph
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <stolee@gmail.com>, git <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>
> But you thought right, I do have an objection against that.  'git gc'
> should, well, collect garbage.  Any non-gc stuff is already violating
> separation of concerns.

I share these concerns in a slightly more abstract way, as
I would bucket the actions into two separate bins:

One bin that throws away information.
this would include removing expired reflog entries (which
I do not think are garbage, or collection thereof), but their
usefulness is questionable.

The other bin would be actions that optimize but
do not throw away any information, repacking (without
dropping files) would be part of it, or the new
"write additional files".

Maybe we can move all actions of the second bin into a new
"git optimize" command, and git gc would do first the "throw away
things" and then the optimize action, whereas clone would only
go for the second optimizing part?
