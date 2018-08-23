Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EB891F954
	for <e@80x24.org>; Thu, 23 Aug 2018 09:15:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729607AbeHWMoe (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 08:44:34 -0400
Received: from mail-yw1-f52.google.com ([209.85.161.52]:38945 "EHLO
        mail-yw1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728107AbeHWMod (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 08:44:33 -0400
Received: by mail-yw1-f52.google.com with SMTP id m62-v6so205879ywd.6
        for <git@vger.kernel.org>; Thu, 23 Aug 2018 02:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=QX8LUIgFPaIax3wJsgRh7+2mAZ0WQOD/qLd2XB1oe5E=;
        b=gRmYSqPGMCu1e7B7sOVjLvJ038i6yS7fmIOL0k7AlpoHkjpqj7OUCMmNrNnMo+5OE/
         dFOQqXbXLGAnMP5Paj2Z1agC068DsU5GcEwtjOGOJ8SjZ9CPidquyAycvIW3Lm+gCUgI
         YfPA+JQRrMpxfKnWYaHCMJL1elVuxHR1A+q1cPQyGEZtNFcyl+JDxbSpNudMlirEMVgp
         d/u04IbAYnNnLyWuaVik+8BMfee8e3SfMrSquf8MhC7LlIfc2zK3A504789ZXAp86x/C
         5g4jCkaba/e5OLIdttbsKbdJ5tflQdlOErH2pyZh07R1qK/3LB7r7eZJFNCRU2BHl68E
         k9ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=QX8LUIgFPaIax3wJsgRh7+2mAZ0WQOD/qLd2XB1oe5E=;
        b=qLJ+Ax/RrJ7cNLiBD7GLwP0UpLmhrXA5mX3WU1NXTIr/dMI1TauFfnhCNkoIGDtWt8
         VeWdVDrZL7QhOGHfxuEBA0PAFv8qPyS67kBPNJ8xOfJYvir+7ukcvxCBeanI30CMcYf0
         5gjSrvb2CvfCqlMEQ3oO1Cr5WBcMHlAoeTS6O50cDA2Q8Ok6WAOLv0eUj5tv+jjFtrEQ
         1CX0a/9oVw/q9gDHccW9DgfMPsBeBzbeNrGG3EhumoCJLoKfvGVsPLQmWpCJigYZW1h2
         HEOiiLFzL/ybwzTw9R5k/VJYrn8JHXqP0+X83EkUB58QzV044B/ErEdwGn0jEdWnsKAg
         A8Xg==
X-Gm-Message-State: APzg51BwYhY7DR8hF1b4ehw+owueD29WiwGUucLy9XfFkhy5byZw2GDB
        912BPwsrRrt961oTMe866EBt6n9iybS5g0kDKz5q8mYo
X-Google-Smtp-Source: ANB0VdZQbf7X3wIDi4c8tLlZ6t7ow6PG4CXTtJ7Sn9Pebj67AuQsWhC1rgVs5aYfZs0gSHOuj2/x7U7/PhB9ejubQDg=
X-Received: by 2002:a81:4c12:: with SMTP id z18-v6mr2160414ywa.161.1535015746769;
 Thu, 23 Aug 2018 02:15:46 -0700 (PDT)
MIME-Version: 1.0
Reply-To: timothee.cour2@gmail.com
From:   Timothee Cour <thelastmammoth@gmail.com>
Date:   Thu, 23 Aug 2018 02:15:19 -0700
Message-ID: <CANri+EzXBxEf7XtjnJONAYD4h_woqw06-4mcWCH6xODNMMp26w@mail.gmail.com>
Subject: [feature] how to output absolute paths in git diff? => --show-abs-path
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This has all the context:
https://stackoverflow.com/questions/22698505/how-to-show-full-paths-in-git-diff

I'd like `--show-abs-path` to show absolute paths in:
git diff --show-abs-path args...

eg:
git diff --no-index `get_file1` `get_file2`
could show:
--- a/Users/timothee/temp/ripgrep/help0.txt
+++ b/help1.txt

* passing '--dst-prefix=$PWD' and '--src-prefix=$PWD' doesn't help
because path arguments could be absolute, so it'll create
$PWD/Users/timothee/temp/ripgrep/help0.txt (wrong)

* passing '--dst-prefix=.' will behave weirdly, replacing leading `/`
by `.` (seems wrong)
diff --git .Users/timothee/temp/ripgrep/help0.txt b/help1.txt

NOTE: I'm invoking the `git diff` command via a more complicated case
(with multiple arguments including git diff flags and git diff files),
so it's awkward for me to parse which arguments correspond to a file
vs a flag (ie prevents easily converting input file arguments to
absolute paths), but `git` could do it easily via a flag, eg
`--show-abs-path`
