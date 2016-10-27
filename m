Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18E552022A
	for <e@80x24.org>; Thu, 27 Oct 2016 00:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934928AbcJ0AWu (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Oct 2016 20:22:50 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:37095 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932430AbcJ0AWt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2016 20:22:49 -0400
Received: by mail-wm0-f43.google.com with SMTP id 140so958531wmv.0
        for <git@vger.kernel.org>; Wed, 26 Oct 2016 17:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pelly-co.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=2lmRFWfKjZyN5FsdSr0lNPWMeMPKK2LsqyxJ60CF6Hk=;
        b=okHH4obAjeoPGlszNOEo8KkdblgHjGuOgMFZvuHY5uJcrsPmmwHyqAFzHFhJppIPrV
         1TPnOJv/OrOKeODjm4dR5ss+u8SMwFDiUN/Ko3bWnW1eoCR5uM+HPoUrnlqBoWfwpmMV
         S4O5+ygZjhHC0ujOZo/ghdmZ7Rb41f07I2AWYwlCg0txfe0SlZStYtsSR9b9jtW9CWDf
         sLQqUJZBYDsQDRBJf/zm8ihsezeZ7zqcSfqQhvtD2BZY5icThDJOAdjFRF1eO4s+P+To
         p5Qf7Xypp5Dhp3cPXO0BXsNkE3ib93y8vp00kCxRRRRT/0o48AaA7nKlDTF8nFu8HddM
         ea6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=2lmRFWfKjZyN5FsdSr0lNPWMeMPKK2LsqyxJ60CF6Hk=;
        b=MTDoIQfXJcH2HkIRPZDFnzmwDqkVoH+C8vdZ6GZZoOs4orY9UePMi+B8cAK32mQ/4S
         sQiXzobJvIC7mr319RiRDXvyoFQxAlse08RetDanJkikHhRMeNc0SnI6EBmhHiz2SUWp
         /Eo6f9RB5UvDBFfBfVjQsxkKQYIGdGGIfysty2hIlAnNDP+QCpbEyOMjUra/FbzaQbJ6
         TF8cWlg/gmpuLGF7pAZ9bytgCLmrymXZrIjnqTh2NS1cWJtL30vpADd7pN6486cu/wqq
         OvtPVmNQ3vJwNpUSrRr+BunqDWMemCuiLghfCtDI0mklz6NYeaMUjeNXlBP6KlwhKh64
         d3IA==
X-Gm-Message-State: ABUngvcgPRFvrQT2sZZGYyOJLzOs0PPrKr4vxgIec+8+Z8kpAc+WoY4pbar+WBJE7BO7Hw==
X-Received: by 10.28.148.200 with SMTP id w191mr4742495wmd.43.1477527767459;
        Wed, 26 Oct 2016 17:22:47 -0700 (PDT)
Received: from [10.3.1.6] ([49.50.252.82])
        by smtp.googlemail.com with ESMTPSA id 72sm94652wme.15.2016.10.26.17.22.45
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Oct 2016 17:22:47 -0700 (PDT)
To:     git@vger.kernel.org
From:   Aaron Pelly <aaron@pelly.co>
Subject: Expanding Includes in .gitignore
Message-ID: <80919456-7563-2c16-ba23-ce4fcc2777de@pelly.co>
Date:   Thu, 27 Oct 2016 13:22:43 +1300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I want a feature. It may be a bad-idea(tm). Advice appreciated.

I want git to be able to include, in its gitignore files, sub-files of
ignores or have it understand a directory of ignore files. Or both.

The use case for this is where I did not write my own rules, but I want
to keep them updated. https://github.com/github/gitignore is a damn good
resource, but I want to pull it and include relevant bits project by
project and/or system wide. I don't want to have to update many projects
manually if that, or any other, repo changes.

A very brief look at dir.c would indicate that a recursive call from
add_excludes to itself when it parses some sort of include tag would do
it within a file. I'm sure it'd be pretty straight forward to hook into
something in dir.c to parse directories too.

I'm thinking something like ". path/to/include/file" in an ignore file,
and/or creating .gitignore.d and/or allowing $HOME/.config/git/ignore
and $GIT_DIR/info/exclude to be directories. Or some sane and consistent
mixture of these things.

In the case of a directory the plan would be to add links to files
stored/sourced elsewhere. This does pose a precedence question which I
haven't thought about yet, but probably makes it too hard for the
limited value it brings.

There is also the issue of malicious/accidental recursion which I
haven't thought about deeply either.

I would like to know the desirability/practicality/stupidity of such a
feature as I believe it is within my skillset to implement it.
