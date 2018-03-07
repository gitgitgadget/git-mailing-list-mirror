Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65CCC1F404
	for <e@80x24.org>; Wed,  7 Mar 2018 21:03:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754752AbeCGVDC (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Mar 2018 16:03:02 -0500
Received: from mail-wr0-f172.google.com ([209.85.128.172]:47044 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754333AbeCGVDA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Mar 2018 16:03:00 -0500
Received: by mail-wr0-f172.google.com with SMTP id m12so3560123wrm.13
        for <git@vger.kernel.org>; Wed, 07 Mar 2018 13:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=RCnYhHuu2FZFpl1EvAkm+yMFY+jTT0sbaEJEcsBq778=;
        b=riyWSvXZupQ5GV1lXGjkaDov/vHc1na+iLvyVsngCtWrXKeGy0pGOIPl/FdVcAONzZ
         AAKfbeyx2HA20iS/ooDqJe/OhQqGQMUNiTrX7rROPD5i6LWpw7BsGX1J0W8Nt5mcobwF
         phJJN1DQ0fQK5jY/UXKyB22f95QV+njMa+xfJpnWA+CFhJOahZMDaJkhMcp5BmExdjbK
         pBIHxD+Ta/zQEWOUMA5n4C9WJ7K59P8pdgwYlBNQ+Vsl9PRxIuEnTSSseAb7V+Fe4FcB
         w7eYYjDkqNAPZC41roZCGJcYX8/4xuIlWR0bKElXsHuq1iP/5jti+19ZEBikHVtevsk7
         Q/Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=RCnYhHuu2FZFpl1EvAkm+yMFY+jTT0sbaEJEcsBq778=;
        b=Jh4N4BuqjIS3hPGmvL9pwypGhYcvScZ8DJTCsNCLS8Ztl8Z3FSlTKb86S110ziCFPh
         UWgcn0wjOsbkpx3mY3nCoj/PcTjBZy55qZBu0IX8PC594KnPwIjCGdQC1IE4Z/LGCB18
         rHfeMTwVziM26Nv/tWKQs4s///jkJgje21ITsRPWXfDyXjNL7Sqg40mAR4b96yw9QftW
         8aK8NOjHh7WkQ+JRYBQltFrzroWtz4Qe6kHXyRMkva14EAjKN+ZjImXQNu4CY6uq4pKR
         5KpkvrCyyPKgjhFxUxiltwjgEhOFkCWWpvo7gvp/EwFlrkAOteAKgwOAM+bXpRUobWkI
         NWNQ==
X-Gm-Message-State: APf1xPDXPyG8VlJQ+9iwqXrZ0aXXyQSOzhPMDp88nYaUXBjbyzT5730a
        14GlyVT2MM7byJVBr0Q8q64=
X-Google-Smtp-Source: AG47ELt3cQtP09NQa/SaysSGpO+GTmSJUXMP4IqoZyfh2Fz94utQ6oYZRkByQOW2ZG5SPzC0nkQEcw==
X-Received: by 10.223.208.132 with SMTP id y4mr18991114wrh.185.1520456578773;
        Wed, 07 Mar 2018 13:02:58 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id u48sm17240856wrb.85.2018.03.07.13.02.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Mar 2018 13:02:56 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Vromen\, Tomer" <tomer.vromen@intel.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Bug report: git-stash doesn't return correct status code
References: <8ED425DE0F8BEC45AADD477A8872875788FB691C@hasmsx109.ger.corp.intel.com>
        <xmqqzi3jzp91.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 07 Mar 2018 13:02:56 -0800
In-Reply-To: <xmqqzi3jzp91.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 07 Mar 2018 10:58:50 -0800")
Message-ID: <xmqqina7zji7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Vromen, Tomer" <tomer.vromen@intel.com> writes:
>
>>> git stash && git checkout -b new-feature-branch && git stash pop
>>
>> This is useful when I realize that I want to open a new branch for my changes (that I haven't committed yet).
>> However, I might have forgotten to save my changes in the editor, so git-stash will give this error:
>>
>> No local changes to save
>
> This is given with "say" and not with "die", as this is merely an
> informational diagnosis.  The command did not find any erroneous
> condition, the command did not fail to do anything it was supposed
> to do, so the command exited with 0 status.

I guess that is only half an answer.  If you really want to avoid
creating the new branch when the working tree and the index are
clean, you'd need to check that yourself before that three-command
sequence.  In our shell script, we use these as such a check:

	git update-index --refresh -q --ignore-submodules
	git diff-files --quiet --ignore-submodules &&
	git diff-index --cached --quiet --ignore-submodules HEAD --

But stepping back a bit, why do you even need stash save/pop around
"checkout -b new-feature-branch" (that implicitly branches at the
tip) in the first place?  "checkout -b" that begins at the current
HEAD does not touch the index nor the working tree and take the
local changes with you to the new branch, so save/pop around it
seems totally pointless.
