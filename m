Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 595E71FAE2
	for <e@80x24.org>; Sun, 25 Mar 2018 16:50:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753627AbeCYQug (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 12:50:36 -0400
Received: from mail-pl0-f51.google.com ([209.85.160.51]:39662 "EHLO
        mail-pl0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753620AbeCYQuf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Mar 2018 12:50:35 -0400
Received: by mail-pl0-f51.google.com with SMTP id s24-v6so81806plq.6
        for <git@vger.kernel.org>; Sun, 25 Mar 2018 09:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:to:cc:in-reply-to:from:date:subject;
        bh=W3YqaMx0mfHdfZ3s14rQT/CbCrjNVKjTF/iMlrPvFv8=;
        b=BFy8WgVRcWv8XhX3xqSw1j6ekq11qt1bvxHVsa7wsmAipQuVw0UCLFNTiiyWe9SOWw
         jJnnAngqYvnV9E+vmO+SU/Mg9vdGrxv3NIDxVQ3plE7flkBx3hhoEaOuj9zZs0SA+Kqm
         AwLAGTHRrbGjSPObJjf42u2C94qHYaZX/D6R942JXxrVbf+ugTac9+wHrb0QcV+Ikg2i
         /UXcmyfoI1nWCnOIhIvJajaM/uGLd/w3WbsZJgWDFllbJhJNUfAZiaHIm6muaeN4Oxic
         0sSVi97mIUIvMhZRbCUAOKDe5IdkkK5vtOsTVC7vVK91R6FZk17dy3Q/EficHQaSYz5v
         Slbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:to:cc:in-reply-to:from:date:subject;
        bh=W3YqaMx0mfHdfZ3s14rQT/CbCrjNVKjTF/iMlrPvFv8=;
        b=M/7KubQlGqQ0wlmZ2qxZhDoP7FqoDK428cfb20BnOwDQhhVvxitR2CJzmdz9+/bTWb
         RRoW0u2vG4N4Xou5ByUHCkXnu83dgsdC3v8TfKTheyOgKahmtpSHLnfENmXptawbrrOx
         PDkFzRqlKwVeGpZ1z1wDbVGAwH6JDjbRW4tw24SidKculTjNMtbmJZoxOlXzomc6LuLC
         T0ck+JKR6Rq3keeWnvl+gK9XwTKPG3saFJxP7qRu4GWzlgl0L4wGKOWGpE0cUyN9VZab
         /48NO1WQzzWxuGqpJFrat17jWX62ROArnn8G4q6J9yRZi8svivTgSOg1yzuYYAqKJPAy
         zOrQ==
X-Gm-Message-State: AElRT7FShzUJi6y4pc62izjQdhbr9BdETeO+/w0RfUxPxYt6egcV8DIH
        FZOyqC93wPnTFey0R6EkajE=
X-Google-Smtp-Source: AG47ELvmgPilk18mGKVn8pwrUS8ZPeuucf4KUAWOouG4+w9tZ2scJ+crXlfsBNHrGxcoMizwqLhUuw==
X-Received: by 2002:a17:902:8545:: with SMTP id d5-v6mr37015913plo.20.1521996635075;
        Sun, 25 Mar 2018 09:50:35 -0700 (PDT)
Received: from localhost (softbank126094196092.bbtec.net. [126.94.196.92])
        by smtp.gmail.com with ESMTPSA id t16sm22720056pgu.63.2018.03.25.09.50.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 25 Mar 2018 09:50:34 -0700 (PDT)
Message-ID: <5ab7d35a.9060650a.fe7a7.04ef@mx.google.com>
To:     Junio C Hamano <gitster@pobox.com>
CC:     git@vger.kernel.org
In-Reply-To: <xmqqr2o8f7hd.fsf@gitster-ct.c.googlers.com>
From:   Yuki Kokubun <orga.chem.job@gmail.com>
Date:   Sun, 25 Mar 2018 16:39:45 +0000
Subject: Re: [PATCH v3] filter-branch: fix errors caused by refs that point at non-committish
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

References: <xmqqr2o8f7hd.fsf@gitster-ct.c.googlers.com>
	<xmqqvadmilx5.fsf@gitster-ct.c.googlers.com>
	<5ab46520.0352650a.cc02b.a177@mx.google.com>
	<20180323050913.5188-1-orga.chem.job@gmail.com> 
Content-Type: text/plain

> Grammo (third-person singular 'prints' misspelt without 's'; the
> "when" clause has a complex subject but no verb).
> 
> Perhaps this will salvage what you meant:
> 
> 	"git filter-branch -- --all" prints error messages when
> 	processing refs that point at objects that are not
> 	committish.

Thanks. I'm gonna fix it.

> Please sign-off your patch (cf. Documentation/SubmittingPatches).

OK I'm gonna add it.

I greatly appreciate for your kind review.
I couldn't write this patch without your help.
Thanks.
