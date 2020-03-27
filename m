Return-Path: <SRS0=iK8c=5M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35723C43331
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 11:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09C3520748
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 11:54:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=appsbroker.com header.i=@appsbroker.com header.b="bGdGxMZW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgC0LyE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Mar 2020 07:54:04 -0400
Received: from mail-io1-f48.google.com ([209.85.166.48]:36303 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbgC0LyD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Mar 2020 07:54:03 -0400
Received: by mail-io1-f48.google.com with SMTP id d15so9516267iog.3
        for <git@vger.kernel.org>; Fri, 27 Mar 2020 04:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=appsbroker.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=uD4IFFnd4DqKY3gZ7sWbUW1cwE7e+HhO0VPPPU1rdzE=;
        b=bGdGxMZWm0Y0TspsebmGmjoql3n9LVYa7I5MnQ1CL7zef/LgbhQjhnANDk6aYT8KYI
         TU7TJlsJ8NRWgiMFaaIsdMkwE9d7Zxl68pjuDzv8jyOqB7rbDHWZrAaSnehlviTjd0cA
         YtI8QpAevtTHE//KD1jVMzl5/NCuBVSqhefnw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=uD4IFFnd4DqKY3gZ7sWbUW1cwE7e+HhO0VPPPU1rdzE=;
        b=pAohFo+KAKhUSaTgYghvo9IrkZdd4tMyHdW2DTEfoMuGSkOVYh7SID+G1kyI2doZkP
         CHaTzdJt4BQmx8tUFKQNqfovaoBK3AIXSWmT3nDFHtup+Qwjqb2In6zoEIfFFGU7W793
         Q/HTbEUaKT6ddYikXoO4kwc9VYCgUTSukLRboKj8iqNnKrDtVK6CikMsoSlQixPTjJMk
         7QBDgv/IqLZUZUhmsyLd936MWQC+JC3e/jhuAeIdXaFqJDhBqwXx3Vg4lsv6Gff8BDdU
         yQQjsAiIflp89p3EghMRt1e98K73HHRf+p88RqBOwkhuXilA2/fULZuota++oIUfXWg1
         1wsg==
X-Gm-Message-State: ANhLgQ0j3mITFaPKIqXedRFJYsHzqhGvl6unGeabgImc4Tw9V9paw5YP
        yf+VXqqA6rjBEd9OBxMW5LqJfeRwFCM5syMxC58O/B4mT/NScslIBeLoLp7aN7wwXwtdbUMomra
        T12EHprtV+cW+/NBdQPoNifWk/w==
X-Google-Smtp-Source: ADFU+vvbALAaIsNJ86cbEq3yGrPHj2JvoW+CGgR7J9nck0HFsMiF7tyWGSnyCE6n/pqzTTxFwu69XOh57iLYavIPQsc=
X-Received: by 2002:a02:cc37:: with SMTP id o23mr12410257jap.106.1585310042736;
 Fri, 27 Mar 2020 04:54:02 -0700 (PDT)
MIME-Version: 1.0
From:   James Yeoman <james.yeoman@appsbroker.com>
Date:   Fri, 27 Mar 2020 11:53:52 +0000
Message-ID: <CAJ+U58yrKi=4VHRCAw68yAste=j3vzrvd2DoEW6QL-_sRWO2Aw@mail.gmail.com>
Subject: Bug Report
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

gitk and git-gui are both not respecting git config.

When I set the diff.algorithm global config to patience, the command
line git respects the config. However, both gitk and git-gui don't.
When I use "git status -vv" to get a diff of the working directory,
the diff produced respects the algorithm choice. The diff of the
working directory in gitk and git-gui both still use the default diff
algorithm, rather than the algorithm from the config.

-- 



