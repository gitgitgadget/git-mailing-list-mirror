Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C8CC6FD1C
	for <git@archiver.kernel.org>; Thu,  9 Mar 2023 12:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjCIMHa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Mar 2023 07:07:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjCIMH3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2023 07:07:29 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711F3E7ED4
        for <git@vger.kernel.org>; Thu,  9 Mar 2023 04:07:27 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id ne1so1205942qvb.9
        for <git@vger.kernel.org>; Thu, 09 Mar 2023 04:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678363646;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NO+vCUsdhsR8ammHVW5y1SNDRTwxmnDc93VYMaG3E8I=;
        b=H4eHMAXJ3QpsSpqw5/uX8CqJFURDJXnmYrBcEMBelOGjQdc3PQSXICcQiJy6wEFcu6
         WKSy/MkP4O6M6OsQzMaWnoDpI6dsz9O8LaqRURRwktYjpfE5Pom9uFSX0gCI1vo0EJWG
         Q/1DDb/82z1WEO8S2AhACdzGT4EhgUDfw2EzTa+ckiWPkTpCebkZfG5unX2+twZVJB6d
         pNVf7UjiN5TSF/sHa8FpshaqPpZ/D8Zd1MPV+YYzH0IPkxNUgJ77G13b78EEvEtVPVjT
         01V1Mb6OX+pQSfSwWwDgU3QoNYfhhI8UEE37l0yT2AIKGA+biR27kMccUewzs/D+NsGu
         Rcaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678363646;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NO+vCUsdhsR8ammHVW5y1SNDRTwxmnDc93VYMaG3E8I=;
        b=OPzTtXnGtDE+2BmHpRPUxmVVnX/+TufeaYVQPNXslqvRVhwfpzL6QUpQ85n1rMkvbz
         ljQVlZakf/QWTJKGpTyXDcQsLGnxHeQ+ZYrFk5cwooiYkB43Rp4G4rDV0sSJWKgfITMX
         +P7HRZdFMhqVJPNbpq7T7qXEbheQdRqFzwyGTbNe347YYIV+Tzvh/NDsDK1BpusHDPhi
         2eplzbWN3lrlXfnrlZNqD0xxvjD/xsm/ERHke3b+Lf7Hms4RecB3R95SHY+uLpI+TTb/
         Yf1US9SpXW52TxQY0D6TG/lOvVz2nPpEIHnujrKzoWPbtF/FxyE1i0BArrZsKPgXqltq
         vkBQ==
X-Gm-Message-State: AO0yUKXlQKoE0Y2ZsMhgHQFz6HfL8hQlQvkHv5Pbs1DRRCfJew/HRlMI
        6zB0uoQKB5yncVDNFjYKj937v9TgaXqCU7bVduvDkL0oqkDLtQ==
X-Google-Smtp-Source: AK7set8RwRweHEw0LpvSHO/CQ+U5PvxKSLq84kI0vupHb9TqrBBw3XRk/MdbP68JtVIraB2BPXh2xpbpPt6Sl/uEt2k=
X-Received: by 2002:a05:6214:4a43:b0:56e:9ad3:ab9c with SMTP id
 ph3-20020a0562144a4300b0056e9ad3ab9cmr5297714qvb.1.1678363646270; Thu, 09 Mar
 2023 04:07:26 -0800 (PST)
MIME-Version: 1.0
From:   Khalid Masum <khalid.masum.92@gmail.com>
Date:   Thu, 9 Mar 2023 18:07:14 +0600
Message-ID: <CAABMjtGXGZtUnU+8KgEccNeLXRJmWnE5f24BMG8ysbZKfT-ctQ@mail.gmail.com>
Subject: [GSoC23] Working on project Idea from SOC 2011
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is this SOC 2011 idea named "Resumable clone" here:

https://archive.kernel.org/oldwiki/git.wiki.kernel.org/index.php/SoC2011Ideas.html

...
Currently cloning a remote repository has to be done in one session.
If the process fails or is aborted for any reason any already downloaded
data is lost and one has to start from scratch.


There is also currently a bug where, after successfully loading
all data during cloning, an failure in applying the data
to the working directory leaves the repository in some
unusable state. In this a normal clone
behaves differently
than a clone --no-checkout followed by checkout.
Fixing this bug would also be part of this project.


While not necessarily being part of this project fetch
might also benefit from a resume mechanism.

Goal: Allow Git to resume a cloning process that
has been aborted for any reason.
Languages: C
...

Can I work on this idea for GSoC23? If so how should I get started?
I have completed one of the microprojects by the way.

Thanks,
-- Khalid Masum
