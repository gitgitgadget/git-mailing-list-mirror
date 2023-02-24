Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB13C61DA4
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 02:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjBXCtL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 21:49:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjBXCtK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 21:49:10 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8095A1BADF
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 18:49:05 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id e9so10278845plh.2
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 18:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=HhSt7mu/1/CNa5YXoy/c0fWpLpNoNNFWfd53JmwpO7Q=;
        b=G6If4rnN37Kd+QHc+bPbj3OT2CaJaaU8q+TxqVmC0LEVe9nBlOHXpHuuEG3p1qtkie
         RFnspUtX6ivPTXEbejT6Gfy7bjNmnAzF5TdJKQGIr6E/hedJmn7W3WpZXf0ESL05AStR
         Iqm39IAp/32UAGSqPcofp/oVN8bNGMfDlaWbuLi01sGhSq+ElynFpRiTzbI8XBxiE8Yg
         uqoN4sVkJl5pKM/4fugtzVEt4KbwF6uTg7+Fkp4XCCRHKAezfTGIkwYeXOIVkBa5Ue7L
         40bUjr/B5cisiwpKaG7P6pBxYIlE9Pbsb+GXCodC3ZRDDHGoC7JyD8jrNQMtBlxvh8bZ
         aOYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HhSt7mu/1/CNa5YXoy/c0fWpLpNoNNFWfd53JmwpO7Q=;
        b=s6mn+0j8gECaY0Vas3ocjPbDKTy5vhkvlT3CJ6fiOgmSVILGGy8mz84VW4ios7RRGf
         vgwYSGH8SwLGX7y1ydmfXXsvjRDqxc2tOCDBIHq+GOZpC4waG7AWX8yWTsy94JrVIoFF
         JSt1TeqXjuyFfcsXYiKI5hwgnalap3mNseDdjP/VWc+ddL3i2NsV4u3Ke7bKLDthu9IJ
         hpQKmRJQkODj4XxPMzbbLUaATD2cs/+xACrcmH0+IgqlVCkCB6s7gGdC9quX7Vj8wMyi
         hKrILAk9iVjh/DKslM/lFV/HlEH8iWwYn9h9nG7PVqSfe1qeAu8349OTS8YkMzLlHpp6
         Ubhg==
X-Gm-Message-State: AO0yUKU5F3GesVCpeKFbgkZlTJH29nA9aCaZoKRr5PzDvQw3jurSj0/E
        bticIhMBE6ouBATVImdTQCI=
X-Google-Smtp-Source: AK7set+T5vyTjGOP1P/VYu/X4UefVzmwvAsDW7BU4EWgay9yZvW90Tfph9qCgNQa4Jjgl5GlCx+clA==
X-Received: by 2002:a05:6a20:6909:b0:cc:24de:4d6d with SMTP id q9-20020a056a20690900b000cc24de4d6dmr5287632pzj.4.1677206944866;
        Thu, 23 Feb 2023 18:49:04 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id c186-20020a6335c3000000b00502f21d6c14sm2133473pga.94.2023.02.23.18.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 18:49:04 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Zhang Yi <18994118902@163.com>
Cc:     git@vger.kernel.org, v.garg.work@gmail.com
Subject: Re: [GSOC] [PATCH v2 0/3] t9700:moderizen test scripts
References: <CADupsJPpZnjA=Pu_RZZZXy7Titj3UD7ppww48KvcHHHbrGx=rw@mail.gmail.com>
        <20230224013413.1969003-1-18994118902@163.com>
Date:   Thu, 23 Feb 2023 18:49:04 -0800
Message-ID: <xmqqo7pj3hi7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Zhang Yi <18994118902@163.com> writes:

> The style of t9700-perl-git.sh is old.There are 3 things need improve:
> * A title is not on the same line with test_expect_success command.Need to combine them.
> * A test body is indented by whitespaces.Need to replace whitespaces by TAB
> * There are whitespaces after redirect operators.Need to delete whitespaces.
>
> ---
> Thanks for all suggestions.Here are so many interesting things to learn.

It is a good idea to summarize the difference between the previous
round and this round, to help reviewers who have already spent
cycles to review the previous round to skim the parts of the updated
series that haven't been changed (and they have already reviewed).

And the cover letter is the ideal place to do so.

Alternatively, you can write after the three-dash lines between the
proposed log message and the patch text of each patch message.

> Zhang Yi (3):
>   t9700:fix title style
>   t9700:change indents to TAB
>   t9700:delete whitespaces after redirect operators

You are missing space after the colon, all of them.  Also you are
missing space after full-stop that concludes each sentence in all of
your proposed log messages.

Even though you _could_ treat these three things as logically
separate changes, I would suspect that each of them is so small that
it may be easier to review as a single patch.

Thanks.
