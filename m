Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B055E20357
	for <e@80x24.org>; Mon, 10 Jul 2017 23:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755053AbdGJXpO (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jul 2017 19:45:14 -0400
Received: from mail-qt0-f170.google.com ([209.85.216.170]:35000 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754982AbdGJXpN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2017 19:45:13 -0400
Received: by mail-qt0-f170.google.com with SMTP id b40so86207558qtb.2
        for <git@vger.kernel.org>; Mon, 10 Jul 2017 16:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=R19GVWt/JRYogf4WrhHDkX15iontu1nvQ8RRbRTPazU=;
        b=ZoBal7qEcC69OXMgF+cubYtS+ull2O/Jtgh+z1rDUSM7adcO3p797eVfQVmNqiNjjr
         m9534KvwdOyO+nEGc+D9EVqmm1nOstG4YNhPAHSmfZNiUoYyAYgqvU28LnyVDW0shl54
         eKsavmKgdX4qCpM6BOi160OeWFZmU+wjHVQUrlXLp6jKSTT4C4uf93T25jPqV7qwZIu9
         3bhhMykOAp3M52243JerPNFqyhr2dCii4isO+HcOW8FsWKNfvII9jnnXY7AEsFYCufqk
         TiU3RGfapdQoWYogdOKnM9+9S8y+8/syPHBsNMKrpIO3t4+uDa7AhoA+thi3TH2mApT/
         fJrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=R19GVWt/JRYogf4WrhHDkX15iontu1nvQ8RRbRTPazU=;
        b=HWwXIXJfDYsFuPu6Yk9LH9EN81DdgbndcnjCBbRcFopFE/OyU03cO4aSEXwsNVdM5g
         7YUAK5I3h7CBGucLG4isd0IObE8SNo2wL8BsSa4GnS4A8U5tDTEa8XOI1mZP8xZOt3bg
         frU0JYxBNTOB4EvOfdBbBlQErQbifDVIK0Jhqv1qCSkaJOipaAlywYJ0rzEM6lo/dtZt
         6ox6mI4BfT/SMMHR8Vlb9hZEgxArGgtmJmP+ARKwLlCNpfQT0wP5B8Kk3du3U20j2hBt
         DXdiLpxx+YXaHPmJbSkWO6Nwi1gAQSpYZr1vorIQtFxqm2+RowVb1KNUKHPOPhxwAVaD
         iR1A==
X-Gm-Message-State: AIVw110720CzDzgfXn5pA2vJ60ne72VnEABkm/7Q+UBiJO/i9kt/IqnK
        zflmpmmaZ+3Lnq8OsZ1+4/s+0r+ScneL
X-Received: by 10.237.42.20 with SMTP id c20mr7564974qtd.74.1499730312700;
 Mon, 10 Jul 2017 16:45:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.237.45.7 with HTTP; Mon, 10 Jul 2017 16:45:12 -0700 (PDT)
From:   Peter Eckersley <peter.eckersley@gmail.com>
Date:   Mon, 10 Jul 2017 16:45:12 -0700
Message-ID: <CAOYJvnJ1FxevnWf+Aj0-5r6WfmfPkzWhOk_n4y4Yz7HvvfvaBQ@mail.gmail.com>
Subject: Weirdness with git change detection
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have a local git repo that's in some weird state where changes
appear to be detected by "git diff" and prevent operations like "git
checkout" from switching branches, but those changes are not removed
by a "git reset --hard" or "git stash".

Here's an example of the behaviour, with "git reset --hard" failing to
clear a diff in the index:

https://paste.debian.net/975811/

Happy to collect additional debugging information if it's useful.
-- 
Peter
