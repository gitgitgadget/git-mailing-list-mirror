Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47A651F453
	for <e@80x24.org>; Fri,  9 Nov 2018 07:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbeKIRWW (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Nov 2018 12:22:22 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33690 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727962AbeKIRWW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Nov 2018 12:22:22 -0500
Received: by mail-wm1-f68.google.com with SMTP id f19-v6so3172997wmb.0
        for <git@vger.kernel.org>; Thu, 08 Nov 2018 23:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=lgGUpQuPfYqwnAKeqplMY79+IOGejJ5oqnfnTdl7fnc=;
        b=pYEe5P/yoBOWudnHXT6VIAmDq1uY9mb1ewEVHWMDYG1YvDzXN/tb5t3iZpkNc8PaYX
         +25yrJVJgP9+LFNrGYZipEsXgrRKBTn6ioTa/FYGtDq+VYN/WLNuPWIPwbNOAbH+UzOB
         ezYz7LBr+VF5/z909FRK+zwhP5Zilne7ScYo9XSC7DYpmb6xvF+40IYVNJ43pmmEq1n2
         t8T31OYD3MCjm/k2HLysLnor8y+NqfIWobTa3sADKq66Fsy1E6CSv4vF9R5fDuOPWpuY
         PdeR/D5rQcApLqQ7s8ghHVSDc9mFs7QEHPGhjHZOjpC/z6GzwRiIwmPsaoK1EgC3Yzhd
         BPGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=lgGUpQuPfYqwnAKeqplMY79+IOGejJ5oqnfnTdl7fnc=;
        b=CLE643KDGLPktWvWT7viOTAmq60TcDCugJNudxintnGsoLPxuoKmR/2kmbMo2wgAuF
         hsoxtbdMxe9A/LsNssY98ff+hUTygWnw+QqxhOiQoL3GSdTE0Q3xfiaxYE+c6XU0AKRU
         ctBIIyjVqXHSYeg9IUoDY+Dphheoc2ExwIEC6zqUzR/S1IAsETCr56FlN8xjDcmIgF7M
         EeLCXXbeTVJQ6zT2haFSgB8ev0lHTmVphrRB+X23jbVPe831OIUHH8Fd7wDEg/h885ir
         A2XoQKGHtAH6Q7WlZO9RoPkS47DVSqTy/fuLU6f1rs5h76fdkzXHHWzll/r1mB+FRdBS
         kPKA==
X-Gm-Message-State: AGRZ1gLG8PJiIOAfkXZ+3KY3vVwsYP14psUTd2vJtpNkQwUQhno30BVP
        JFiNlIxVjIZVNXXR5BU/7OGexv4ckTND53sWaDh5hVuIT8U=
X-Google-Smtp-Source: AJdET5fO1SNpWZSJ7XWpegH0nfa7K06EN6wvyNNkXmZpRIhR7o2DJd2aEpZLx5LuJk3UWegqjP8PFPkyzezuhAZm1SU=
X-Received: by 2002:a1c:3a8d:: with SMTP id h135-v6mr3810030wma.92.1541749380665;
 Thu, 08 Nov 2018 23:43:00 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Date:   Fri, 9 Nov 2018 10:37:58 +0300
Message-ID: <CAL21BmnoZuRih3Ky66_Tk0PweD36eZ6=fbY3jGumRcSJ=Bc_pQ@mail.gmail.com>
Subject: [RFC PATCH 0/5] ref-filter: add new formatting options
To:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add formatting options %(objectsize:disk) and %(deltabase), as in
cat-file command.

I can not test %(deltabase) properly (I mean, I want to have test with
meaningful deltabase in the result - now we have only with zeros). I
tested it manually on my git repo, and I have not-null deltabases
there. We have "t/t1006-cat-file.sh" with similar case, but it is
about blobs. ref-filter does not work with blobs, I need to write test
about refs, and I feel that I can't catch the idea (and it is hard for
me to write in Shell).

Finally, I want to remove formatting logic in cat-file and use
functions from ref-filter (we are almost there, so many work was done
for this). I had an idea to make this migration in this patch (and
stop worrying about bad tests about deltabase: we already have such
test for cat-file and hopefully that could be enough). But I have
another question there. cat-file has one more formatting option:
"rest" [1]. Do we want such formatting option in ref-filter? It's
easier for me to support that in ref-filter than to leave it only
specifically for cat-file.

Thank you!

[1] https://git-scm.com/docs/git-cat-file#git-cat-file-coderestcode
