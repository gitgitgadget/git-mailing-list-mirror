Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 117101F453
	for <e@80x24.org>; Fri, 18 Jan 2019 22:19:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729925AbfARWTO (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 17:19:14 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38869 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729865AbfARWTN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 17:19:13 -0500
Received: by mail-qk1-f193.google.com with SMTP id m17so1491727qki.5
        for <git@vger.kernel.org>; Fri, 18 Jan 2019 14:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WIYSKP/WqJCVzdwoLJsIzB5UXZJmxfqCWD7FZObRY4Y=;
        b=SrFVliNcRMBXaSMI02dA8D0p3qkNWP8cwfXF5f2Bc5xJ3sgoKzjfsZWxHAn3bRTHLR
         Chf2ErzVXbCZlpLT5ZBwOrh8KgMRx8VxOnNNtNGtAtbaAP4eEG7zcfPm0TSx5Fhaa06z
         iX1MlWlvh8pJ/vekSL1L1oc7poHQDl6x/cPJ23u8iscWdt8AuqO5zgCwkt6oGhaSFaqu
         dajDoqhgH3/VYRhtNIvtTXt+jOmH/0xEnK8h33s/gv2yMeMz5xAjTtGH8aLm4wEw4TbM
         6CONFAH8r9mWOZBJ3b5MM6C7WQnHCr2lebE1EfGeuaZtrZNlVWoOt0OmcV3ulqblEuqO
         oqAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WIYSKP/WqJCVzdwoLJsIzB5UXZJmxfqCWD7FZObRY4Y=;
        b=tHRsazUi+IZpcQRSfGShNasPnVWplQsX/sR2PCif+CS/gIuluWXZlr4ty3IuPOC95m
         bVthXjJvvLJ6f3y6gFRypUiXfGoUUI9mCvIcu5oATXcPzURe6pPmwCaJluj6I5J2D1KO
         mJDExlN6oOC/RQIaIsrYZnb3+8X2UdxBNdT6IkE3tHDcLa4Rjt2kTPXvNgJ+0h4dFf+1
         GP3SMGFq1UlD+oyfQ8St0hU6auoWKWkcRc1YVnwWtuMDmR+LhIGjurwjznI6sdwvdXCp
         iiFZzRUSd045tQTLe0rhoCHLuacQCX+iqt5gWw7c9TWdwUtA3VtOtF64QwS0MNayn/q1
         uaNg==
X-Gm-Message-State: AJcUukdoduflcljjwP0d2bNgJEuLoKp/m9qMkzKUjrdu8vllXEFReeEu
        BkIt1bHZZefUt8k6t1UeP/IR2ZMe0t2kwkNl5lc=
X-Google-Smtp-Source: ALg8bN7/ESNSbxj/DDh3VBq4i8tmGvcjlghPLRsQfWJuinnm2K89C0vKA5MYJfL+cwy0E+nlNyDPyX5fsctS5RDEIlo=
X-Received: by 2002:a05:620a:151a:: with SMTP id i26mr16631091qkk.281.1547849952841;
 Fri, 18 Jan 2019 14:19:12 -0800 (PST)
MIME-Version: 1.0
References: <20190106002619.54741-1-nbelakovski@gmail.com> <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
 <20190106002619.54741-3-nbelakovski@gmail.com> <xmqqzhsc8f32.fsf@gitster-ct.c.googlers.com>
 <e313d0b1-54b1-9fe2-6c75-d2ae7b57fe3a@iee.org> <CAC05384uh_xRboFhxohRq-vKFrTPDnszSaS3vW+BAv30h-Zd+g@mail.gmail.com>
 <xmqqbm4jw1aq.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqbm4jw1aq.fsf@gitster-ct.c.googlers.com>
From:   Nickolai Belakovski <nbelakovski@gmail.com>
Date:   Fri, 18 Jan 2019 14:18:46 -0800
Message-ID: <CAC053875ZH2Sx55s3gzL8Kcp3mduwc_D60=w_v7CjsG+_=LsQQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] branch: Mark and color a branch differently if it
 is checked out in a linked worktree
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Philip Oakley <philipoakley@iee.org>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Rafael_Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I will start a separate thread containing these replies for the
potential change to allow deleting branches checked out in worktrees.

Getting back on track for this series, specifically this 2/3 patch,
how do you feel about it? As I pointed out the goal is to communicate
to the user that the branches marked/colored will behave differently
from the other branches if the user tries to delete them or check them
out.
