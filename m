Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C76B2C433FE
	for <git@archiver.kernel.org>; Tue, 15 Mar 2022 01:53:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344312AbiCOBzB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 21:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232835AbiCOBzA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 21:55:00 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4001655B3
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 18:53:49 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id l18so13306738ioj.2
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 18:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=bLtiTZybMCXXqGm6bt2eV+9DSU9T3IZjAA0MX6bzO6M=;
        b=NijNsNhfqatz48nRAi3k9ruQq9vatM0iwe8YAf4x45lBK96eACpVd3TqPAqQMolCM5
         2Dw9YjUmJQdaoJtGowiMOj+Jv7K1/uzF37Fr+BdwG2XhByeVCGrkBIFsg3aCDscV+PRC
         4R9Pm1DSBfKyt6Xih0CGT9l8D7ilIwX+j9wyYl/8t2WaRTGAV/aKAWYNuUIIg+SB8pB6
         K3+oR/uNsg1RwvHdUdnvH1zgNQz8Pet4PfqmJd0qSrJXTRCV+6j7xiEff/CHwpUlfp1r
         FCPbxSXzWctM6RQ36JbvE6/26RMk22+GtoWrJc5sC8tzpAsZ4ezMS5SXhyuX0tSRc70/
         brtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=bLtiTZybMCXXqGm6bt2eV+9DSU9T3IZjAA0MX6bzO6M=;
        b=v6qsLqzXFT0qmzO/3SXX24fZgHPugaC4daERQdVpPYiDnyv+13qlea08lFBrjnRYXz
         4A8z2/JF3nehuqmGy4bl+cJqR+jDaCeALASlqLp7qE4eh/LoqVv6WkCUHG7qjKSpVeG/
         LaFucN8HVywzvfNeuvhKOv/CqIL+hbQOL/iEJyclbnlgb/WSravEMWuFYj6UtDukEDru
         H1B4m8QFIm0LlvvXmL3PB0tiQ/jHWjHnH90A8Siidz2Y9L/drtX8c+vmdzzsYnnLmOAh
         SFvuwQ+HPZ2jCceMnivPV/r2IQwBl8G80UkszQZgKwfV6Os7ytydMHYh8eemzsIgNfBq
         4jMw==
X-Gm-Message-State: AOAM5338eCSte/e+5if7Pjzje7s9Sx9Lmr2pcidc8fBnHFIWPMPA6PeT
        VG8ieP9H3atjLm5gUSC1YVy633CsDksBNg==
X-Google-Smtp-Source: ABdhPJxtuVCAMdvAKrXea6m58sXh6BZA9crzC8S/JArWGV7CImN2iu6jirA9XD2GtzIB37BiRSUk5g==
X-Received: by 2002:a02:7115:0:b0:2fa:a6d9:9e10 with SMTP id n21-20020a027115000000b002faa6d99e10mr21168002jac.293.1647309228435;
        Mon, 14 Mar 2022 18:53:48 -0700 (PDT)
Received: from EPIC51148 ([199.204.58.10])
        by smtp.gmail.com with ESMTPSA id a13-20020a056e020e0d00b002c61ec2817fsm9763048ilk.57.2022.03.14.18.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 18:53:48 -0700 (PDT)
References: <878rtebxk0.fsf@gmail.com>
User-agent: mu4e 1.7.9; emacs 27.2
From:   Sean Allred <allred.sean@gmail.com>
To:     git@vger.kernel.org
Cc:     sallred@epic.com, grmason@epic.com, sconrad@epic.com,
        Philip Oakley <philipoakley@iee.email>, rsbecker@nexbridge.com,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: Dealing with corporate email recycling
Date:   Mon, 14 Mar 2022 20:27:59 -0500
In-reply-to: <878rtebxk0.fsf@gmail.com>
Message-ID: <87o8282d79.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


(CC others who have been involved in the conversation; I started a
separate thread off the original post since this takes an entirely
separate direction.)

I wanted to provide a possible approach for other organizations that may
run into this issue in the future.  If you have the opportunity that we
do in rewriting history, we found a nice workaround by way of
'unique-ifying' the email address using the '+' syntax supported by most
email providers -- notably for us, we tested that it does work with
Exchange.

As I went through previously, the problem is that our organization
recycles emails like <Sean@corp.net>.  If the owner of <Sean@corp.net>
leaves, I have the opportunity to take ownership of <Sean@corp.net>
after a waiting period.  This presents the core problem: <Sean@corp.net>
could be two different people at two different points in time.

Our first approach to solving this problem was to collaborate with our
internal IT folks to see if we could additionally generate a totally
unique email address based on that employee's ID.  For various reasons
with which I'm not familiar enough to elaborate, this wasn't really
possible -- we could not be provided a totally static email address for
any given person.  After bouncing the problem around internally for a
while, we reached out to this list :-) and I think a lot of cool
conversation is happening that I want to continue!  It seems there is
still value in finding a generalizable solution.

---

As for solutions that are *not* necessarily generalizable, what we were
able to come up with is to use a 'unique-ified' email of the form
<Sean+314159@corp.net>, where 314159 might be my employee ID.  That way,
even if another Sean might inherit <Sean@corp.net>, they can never
inherit <Sean+314159@corp.net>.  The use of this unique-ified email
address will be enforced via pre-receive -- possibly checking for its
existence in the mailmap as well.

Using this unique-ified email address, we can construct a mailmap like
the following:

    Sean Allred <Sean@corp.net> <Sean+314159@corp.net>

This uses the already-built functionality of gitmailmap to interpret the
committer email of <Sean+314159@corp.net> to the friendlier
<Sean@corp.net> while still maintaining the requirement (for us) that
the email on the commit be a real, usable email.

When I eventually get hit by a bus and give up <Sean@corp.net>, the
mailmap can be updated to

    Sean Allred <devnull@corp.net> <Sean+314159@corp.net>
    Sean Allblue <Sean@corp.net> <Sean+271828@corp.net>

(possibly using some support list instead of <devnull@corp.net>).

This has proven itself in a few informal design chats already and is
going to be the approach we take for our replay.  I look forward to a
future situation where we might be able to use SSH key validity periods
instead :-) but that functionality will surely only be available after
our migration in a few months' time.

I hope this helps others!

--
Sean Allred
