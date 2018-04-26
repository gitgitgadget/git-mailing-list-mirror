Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 092641F424
	for <e@80x24.org>; Thu, 26 Apr 2018 04:39:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751396AbeDZEjZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Apr 2018 00:39:25 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:55074 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751343AbeDZEjZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Apr 2018 00:39:25 -0400
Received: by mail-wm0-f51.google.com with SMTP id f6so10556777wmc.4
        for <git@vger.kernel.org>; Wed, 25 Apr 2018 21:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=IiijCh96fYL2Nj+TRi9hIBF+R/gvDRVGX7g5QI27Sxk=;
        b=Of5BeseRiTzERl9WhW6gH9K8TO4vopc+YGizyBUcH6/1IB9Aglam8e4IuxqWu2PKsW
         52u+RBsMd/atfeucBSj3jSvavmDKAyt1m3PxPqjkPVorwUa64wSrbXU8PQs3iP/Uzr6q
         eXoalCuXg/DPA8N2bk7/E6BolJB0iT+p4JmUci/CxweIiO0UL5Z0XTqXw3yp/GQyOQ1E
         MvvqZ4zV5KuP+84UuHEb9eh2Z7mBmtcE7nlujhR6vuaeqlbV6Sz6GYJ82BEhPwgQbge2
         G/1V+sM+myZqYA8Yte/QU/pse3zwYYCGmEkrddyEd4wG3vSOqU2Yp80yqZbyNwvBY8kZ
         EGCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=IiijCh96fYL2Nj+TRi9hIBF+R/gvDRVGX7g5QI27Sxk=;
        b=lcJcaxeFdveNbU+DYXNKGGqoq+ssZjUgpTRLqQevzPPCTjcaCID+vC1UCR8C0nsgtJ
         aqhzMgd1XwtWNC2YSwZ4sM8/UIJ8X94pp0SJ8raQPKab3YFbixaFTE4HOubDW1vXMFdg
         ME1zfh27ate8BnqkWzLvN65/tKfPksJ+0az5ErM3P66bb31P4L3jfxdtkn9KAr9E+wzk
         mERKi3zVe/42Fm0QBcWA57PotfyhlqneQ2yfVSWZkGXJOMxfhhEcDpYSHvOEFZ+eD8Or
         r5rr5DC2RTc3EKTjlFjpaE8NEJ0MjEArX/XknUslPuRMe+XOOK/6D0MG6y0K/teWYgzL
         MsmQ==
X-Gm-Message-State: ALQs6tByO+uIIvCErHGvQ9jZfpjwkvdiRiCrf23Gu+3S5NwUik8iidQc
        urZ3vn0aK9uI207rD24yvqc=
X-Google-Smtp-Source: AIpwx4/zfbEyCm55awDQ2TuAAkBbP5rdeIq5wL0zJl5Wd48r4IE26d/heG6Gh6qWIHN/WnY4ofnOZA==
X-Received: by 10.28.170.78 with SMTP id t75mr17194687wme.55.1524717563568;
        Wed, 25 Apr 2018 21:39:23 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 80sm21533026wml.44.2018.04.25.21.39.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Apr 2018 21:39:22 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Apr 2018, #03; Wed, 25)
References: <xmqqmuxr4r6n.fsf@gitster-ct.c.googlers.com>
        <CABPp-BHE0H+Y1FNH2NmYjjMRfPsKjzmfVfT5XQatqyFTi8_2kw@mail.gmail.com>
Date:   Thu, 26 Apr 2018 13:39:22 +0900
In-Reply-To: <CABPp-BHE0H+Y1FNH2NmYjjMRfPsKjzmfVfT5XQatqyFTi8_2kw@mail.gmail.com>
        (Elijah Newren's message of "Wed, 25 Apr 2018 09:21:29 -0700")
Message-ID: <xmqqefj237k5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Wed, Apr 25, 2018 at 1:37 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> * en/unpack-trees-split-index-fix (2018-04-24) 1 commit
>> * en/rename-directory-detection-reboot (2018-04-25) 36 commits
> ...
> Would you still like a re-roll?

Not really.  We can just merge them together and move on.
