Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A02E81F62E
	for <e@80x24.org>; Thu, 17 Jan 2019 00:17:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbfAQARU convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 16 Jan 2019 19:17:20 -0500
Received: from mail-qk1-f178.google.com ([209.85.222.178]:40691 "EHLO
        mail-qk1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728404AbfAQARU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 19:17:20 -0500
Received: by mail-qk1-f178.google.com with SMTP id y16so4976836qki.7
        for <git@vger.kernel.org>; Wed, 16 Jan 2019 16:17:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=mRS0B4wkUjDQR0gNOmk9RYYyOfsviOAsRrOJKVZORZg=;
        b=gyoyXBq7/SWyvZ81zAvHlBWygz2wPyMRy0n3WVgGNjqaIWQEofGNBFPic094f2wHLK
         uXwCtSqxIlEATv8WwayWe9XUBPNrtdvoPMFWGGfDrQZq7zO5aCw9JZ2HqMM00X/SB4GK
         JtksULtLwPoF0WnKCEch2i1z3pCbvXh90goQKKimMOj9SlhNjXsNIsdt48710i3AO38j
         KWFqFIY1HAQP1tjMn+/RspKPfIT5btHM1STcMkS5139oZLqDBbYpdaKoCKvXW4DAtmaQ
         f2vpJrQF+udW/E84iPtn+L6bHyhuyFFTYDyexsV68uM4XSUyAU8EmkiDJVZMWtn3cH9W
         0Kww==
X-Gm-Message-State: AJcUukduwO6nW5jUEf/82T5ljpZtYmgq5sCT65jBFW3Gx5rV0PBLZ5no
        pBcwChUW2ITExwL7EFzIqchxGK/OF5oZLnPSW/ycn61o
X-Google-Smtp-Source: ALg8bN4VNiscEl8QJMcZvevfRrzBhthaHgtRIR91VM50pU7UBpbrPR3ZH6FlDxRK13ZhUpZORm76P503ZnjFuLJb+JY=
X-Received: by 2002:ae9:ed13:: with SMTP id c19mr8690657qkg.85.1547684238840;
 Wed, 16 Jan 2019 16:17:18 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?Q?Rory_O=E2=80=99Kane?= <rory@roryokane.com>
Date:   Wed, 16 Jan 2019 19:17:07 -0500
Message-ID: <CAD_ag1MODHkfkMyaovg2JgcsX-=Tk6+BHFSYxwE8g5HGhvZ-1g@mail.gmail.com>
Subject: Minor typos in the documentation for git checkout <branch>
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I noticed some errors in one paragraph of the documentation for the <branch>
argument of git-checkout. A convenient link to that documentation:
https://git-scm.com/docs/git-checkout#git-checkout-ltbranchgt

This is the current AsciiDoc source for that paragraph:

    You can use the `"@{-N}"` syntax to refer to the N-th last
    branch/commit checked out using "git checkout" operation. You may
    also specify `-` which is synonymous to `"@{-1}`.

That source comes from Documentation/git-checkout.txt:
https://github.com/git/git/blob/77556354bb7ac50450e3b28999e3576969869068/Documentation/git-checkout.txt#L290-L292

I suggest changing that source to this:

    You can use the `"@{-<n>}"` syntax to refer to the <n>th last
    branch/commit checked out using the "git checkout" operation. You
    may also specify `"-"`, which is synonymous to `"@{-1}"`.

These are the changes:

- Added the missing closing double quote to `"@{-1}` at the end.
- Added the word “the” before ‘"git checkout” operation’.
- Added quotes around “-”, to make it more visible and consistent with the
  other syntax in the paragraph.
- Added comma before “which”.
- For consistency, used the angle bracket style of placeholder also used by
  the explanation of the “@{-<n>}, e.g. @{-1}” syntax (see link) within the
  documentation for gitrevisions (see link).
  [gitrevisions source]:
https://github.com/git/git/blob/77556354bb7ac50450e3b28999e3576969869068/Documentation/revisions.txt#L94-L96
  [gitrevisions rendered]:
https://git-scm.com/docs/gitrevisions#gitrevisions-em-ltngtemegem-1em

(This is my first email to the Git mailing list; I hope I did it right.)
