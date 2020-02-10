Return-Path: <SRS0=dWK1=36=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C733C352A4
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 21:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68A4D2072C
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 21:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TFgivLU6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbgBJVBu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Feb 2020 16:01:50 -0500
Received: from mail-qk1-f169.google.com ([209.85.222.169]:39028 "EHLO
        mail-qk1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbgBJVBu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Feb 2020 16:01:50 -0500
Received: by mail-qk1-f169.google.com with SMTP id w15so8012902qkf.6
        for <git@vger.kernel.org>; Mon, 10 Feb 2020 13:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=bY/v0yxYpO8T0DDQuD/KLvjK+2F+q2IAwgMgmiZisMc=;
        b=TFgivLU6CzFdGj8iZI0lNhgRUvY8L+O9S4r6golz7ZO9bNy8ibm6tyZ3iVa8ccpKgs
         2dvSppJlcYvGdtl+ukvkp1s5sEqpG2AwsM1MptnsJ0unMF+JgTY5FEpqwMg1axlYNYFW
         ibn6vpTCZ4ocf5Iwy0vGA9SAhPOp9IgkkYYgvCHXtk0g4ALP5u1MvrbJmWt+soc4g63f
         fAG/tB0kk1E7G914oAQAhdXP5WPtXg5N1OHMS2aSdlxvXkRrz/PBp0+Ncx2Nmkwabqnl
         +2kkRtbJDsA8KItDPBvQVzvYrsqsFs9ggV8/fLAfA40KEA9+DAg76C049h6Hvv3Ycjsu
         GuCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=bY/v0yxYpO8T0DDQuD/KLvjK+2F+q2IAwgMgmiZisMc=;
        b=Rgs5ewPIMPBJL2hxyePMvY22c5y+H/wwcKi4Gm4qN2h5fgJ3Y4RamORodkH4x//HFr
         FLEpOeog0yT3t6kKK7b0XTVeUYksjstpStyjDzb0FQSfzKbEo/Wfs9GeVbbDLy+rMKQf
         um6toN+o2sl921S7UuKYxaH2spbo2J0CfGjOvaioyxQD+3pJU8a1FuDiJ8LN5qBD0E59
         8RgibCOxHu1WZPWFA9NEaMe2eOSgS1r4e8yM7aj0qRYEyVDVPDZlT8laSIWBMgq/FHNS
         AC6zuXH2PS+e0tOfA1+BsnzUGaOMTkN3OwCb8pYFxDiFGYNv7FOZnYw64RotQadVjQCH
         BbaQ==
X-Gm-Message-State: APjAAAVwjCX4so+xhH+GeU5jA9ggo2D4t2bLU7zvSmV51U5uSey1AJOT
        yllRttxXEQZzvQAr8rBrjYFeomyODsm67pLHzDE=
X-Google-Smtp-Source: APXvYqxfjzRyChBcfFLZZgearwYp31JoXEpaoeGDGHLi85iw7NNEy9I08cth0n9+PpMW4p+TOsKOx6JZ3SkVn5N/kkA=
X-Received: by 2002:a05:620a:10b3:: with SMTP id h19mr3292459qkk.149.1581368509362;
 Mon, 10 Feb 2020 13:01:49 -0800 (PST)
MIME-Version: 1.0
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
Date:   Tue, 11 Feb 2020 02:30:00 +0530
Message-ID: <CAHk66ftUsKU2+Uhy-a7V5QcRdO7ShcYUk28qz7WAm28wGFmPOg@mail.gmail.com>
Subject: Re: Git tedious verbosity
To:     midenok@gmail.com
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Greetings Aleksey

You can look into using `--short` and `--porcelain` flags.

> Git offered enabling/disabling advice by using the 'advice.*' key in the configuration.

Read up on this StackOverflow question on "How to turn off the help
hints in git output?" [1]. These should do the trick, but feel free to
elaborate if you need something more specific.

Regards
Abhishek

[1]: https://stackoverflow.com/q/55463863
