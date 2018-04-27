Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PI_IMPORTANCE_HIGH,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8154A1F42D
	for <e@80x24.org>; Fri, 27 Apr 2018 02:24:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757272AbeD0CYE (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Apr 2018 22:24:04 -0400
Received: from mail-wr0-f174.google.com ([209.85.128.174]:44811 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754298AbeD0CX7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Apr 2018 22:23:59 -0400
Received: by mail-wr0-f174.google.com with SMTP id o15-v6so261110wro.11
        for <git@vger.kernel.org>; Thu, 26 Apr 2018 19:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:importance:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=OZxg4zqLgHhLavukY4MkaNPjWKqvWW5FoZLjt6i4Sas=;
        b=IbaKOtQXKjkH87c9qD8Txe0wlgXIUDLDE8RhCB5HaakQ93RnH6p7QoVcingBvN+LhS
         ylH1SucNSFyCGdPM+Vwl5GqtCsQ5GEtqy0Z9hgm5sY5Ok6mZ1hWAjrWCupIhc3Fh29qx
         O9BFBFwqJQXwUefLRyrvkVKea4lTnzz5Ma1gll4cD1uu5nROMBPL781OUPFEo84Ylit6
         vAOZSRoew568EehlQK9QvHYN0UQ/WEaFs6nxygcYP0ndpz/FFP4K8ai4yZ0+Wtqay+7/
         S5Znwx+GS89vs4PiADtpnAasclORzCUv7xkRK/hIcZFC1ecXEuW4zfwgfuDQbkF5mCBR
         iaNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:importance
         :date:in-reply-to:message-id:user-agent:mime-version;
        bh=OZxg4zqLgHhLavukY4MkaNPjWKqvWW5FoZLjt6i4Sas=;
        b=HgvsVAvom966xh+F2BmjXcx+Cmh9d/qdfbRIvmsx2lDEg53KbC+XsC9W7/EYKJYrcH
         YsEgQCc/X/sZQSaaIcuAu1PGeoxZ0D0+CW9ksCws9GqrisqpiA8w2mn83N6VVykkLoqB
         zg+pmP06zBlmhNn4ndRQAvZZ+HBEZMioqo1s5Ww16mdX6ppHbj/AIaMk7R3TUEX5DQWh
         ZYkhZmsOgzWmPKFSI9pWU6oUs5HYz7knMQwfu4j7p9VqjHDAL7AVfIywcH+r/d5ObVXT
         FyOuLA1GsoVV8MdIdJQ6ZsUUl9KZbSFNJVKvcxcYQprBWiDLt11FFw1Bo3sKHZumbQfe
         cDiA==
X-Gm-Message-State: ALQs6tDrrdlIsVygtKnT9OAB4ML73WbG2qh5cIB6cxeJgRt/Fp+WMgSQ
        /kQC4OSqO/SSoTTC5Us1z9I=
X-Google-Smtp-Source: AB8JxZpzaHaiLlGQTkss/BLG99R5bvDPumNfBEhhAC8D6UFEfj06wWbr0AaLXuzRnJNRCIU2Agw94w==
X-Received: by 2002:adf:b807:: with SMTP id h7-v6mr255184wrf.113.1524795837593;
        Thu, 26 Apr 2018 19:23:57 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id i10sm63440wmf.24.2018.04.26.19.23.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Apr 2018 19:23:56 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        "peff\@peff.net" <peff@peff.net>,
        "pclouds\@gmail.com" <pclouds@gmail.com>,
        "vmiklos\@frugalware.org" <vmiklos@frugalware.org>,
        Kevin Willford <kewillf@microsoft.com>,
        "Johannes.Schindelin\@gmx.de" <Johannes.Schindelin@gmx.de>,
        "eckhard.s.maass\@googlemail.com" <eckhard.s.maass@googlemail.com>
Subject: Re: [PATCH v3 2/3] merge: Add merge.renames config setting
References: <20180420133632.17580-1-benpeart@microsoft.com>
        <20180426205202.23056-1-benpeart@microsoft.com>
        <20180426205202.23056-3-benpeart@microsoft.com>
        <CABPp-BE29rwZCDqFHH-nzrDub6MMdtoiorj0jv3K6B6cmfcaLA@mail.gmail.com>
        <7de8f144-8a37-e471-48e8-0b6f17a7bf29@gmail.com>
Importance: high
Date:   Fri, 27 Apr 2018 11:23:56 +0900
In-Reply-To: <7de8f144-8a37-e471-48e8-0b6f17a7bf29@gmail.com> (Ben Peart's
        message of "Thu, 26 Apr 2018 20:54:20 -0400")
Message-ID: <xmqqy3h9z8sj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <peartben@gmail.com> writes:

> Color me puzzled. :)  The consensus was that the default value for
> merge.renames come from diff.renames.  diff.renames supports copy
> detection which means that merge.renames will inherit that value.  My
> assumption was that is what was intended so when I reimplemented it, I
> fully implemented it that way.
>
> Are you now requesting to only use diff.renames as the default if the
> value is true or false but not if it is copy?  What should happen if
> diff.renames is actually set to copy?  Should merge silently change
> that to true, display a warning, error out, or something else?  Do you
> have some other behavior for how to handle copy being inherited from
> diff.renames you'd like to see?
>
> Can you write the documentation that clearly explains the exact
> behavior you want?  That would kill two birds with one stone... :)

I think demoting from copy to rename-only is a good idea, at least
for now, because I do not believe we have figured out what we want
to happen when we detect copied files are involved in a merge.

But I am not sure if we even want to fail merge.renames=copy as an
invalid configuration.  So my gut feeling of the best solution to
the above is to do something like:

 - whether the configuration comes from diff.renames or
   merge.renames, turn *.renames=copy to true inside the merge
   recursive machinery.

 - document the fact in "git merge-recursive" documentation (or "git
   merge" documentation) to say "_currently_ asking for rename
   detection to find copies and renames will do the same
   thing---copies are ignored", impliying "this might change in the
   future", in the BUGS section.

