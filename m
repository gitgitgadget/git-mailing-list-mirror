Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B536211B4
	for <e@80x24.org>; Mon, 14 Jan 2019 15:07:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbfANPHy (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Jan 2019 10:07:54 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:38704 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfANPHy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jan 2019 10:07:54 -0500
Received: by mail-io1-f67.google.com with SMTP id l14so17806141ioj.5
        for <git@vger.kernel.org>; Mon, 14 Jan 2019 07:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H4GtXmaKpz/WwP1jDL0uAd1TyHl+yMAA8e3jlacxdRY=;
        b=kZcXAHNyYBhRCrdvoVb+Fc0OlEHLKAn+lTPFWom9lnf3g4/B0GZktvaHw7psjefHKg
         Kyor3x7CpUmigjmjQmukLj/XqmYwABfoY3FsoGqdz1vNpWNuHrWgZn+z2WyufFtxvJ3C
         EktaIfRE/BcZGl+B761jIrASagEmO3oHepHz9TOt8UWCL9xZD8lm10tsEuOOFdL3FxQm
         f0SHyC6nbN2cWhQN6pBUKWkz2NF+8go239w6ifp/gUeC5HtohqDWm/6qxOjnZThJd2VN
         JfqFZgPcqJ0iq/okOwGOjCTsRbpaiUn2prhTcbrV9jO5j3Syf4WhrAHN+5kbdgBG9dgx
         8iew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H4GtXmaKpz/WwP1jDL0uAd1TyHl+yMAA8e3jlacxdRY=;
        b=eryLlBf8bJZjufSmtx8R7ZMwGGtH2VVFUwY1HZuwPe0qF2qoHn8NfEGsoQejVz4fj5
         Bc9fY5DF9vMtzzq56F4AOh52LJc8085ynaTP5pgcQvrg1znfj/r/1zyJpmVAnIyeYPaS
         XWwF9NyOaiUKzVJovbz2C59FVh9WqEIwIBaiEPA1GTWRjMjwVOoKQLNc5bseqboPkLj6
         QO9TtT+zbrlT7a5vsVvq9suF6sGKpiTwcPpqP/rVsg7EbTFtDsjVbsL7TPxxEhLUF5aI
         2NK235SDl1aftlrDtLEG/Cyqsw0EMJc/TQ8MqHyrc/hQgET3IvbUk2GD0x/ODr0bSXe0
         1FEA==
X-Gm-Message-State: AJcUukc/ltMwc3H77oiz0l0MJX5gELmYPt5a4C3n0NA2oNZmlFE6EbHA
        qQstEhw5xoK7Nin9garT7eLx9an98tpLHEElEQX9eA==
X-Google-Smtp-Source: ALg8bN60PNWCe6fe15VSMQF0FaRLbvU6zSsMhz7kFLNR1EtYGZNuPXjKFrrkbYOjcaIR/85jWeuA24zatIcZ8GqRPho=
X-Received: by 2002:a6b:c544:: with SMTP id v65mr16571053iof.118.1547478473804;
 Mon, 14 Jan 2019 07:07:53 -0800 (PST)
MIME-Version: 1.0
References: <002601d4ac18$83d4a210$8b7de630$@nexbridge.com> <CACsJy8AEi4gzRpHY+ehFz3GEOaQ0rmdC2kKMpUSp80cdQbuc6g@mail.gmail.com>
In-Reply-To: <CACsJy8AEi4gzRpHY+ehFz3GEOaQ0rmdC2kKMpUSp80cdQbuc6g@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 14 Jan 2019 22:07:27 +0700
Message-ID: <CACsJy8AtyTDs25R2PBd+nAvCW9aCYxtPHdXTS57JSS5VzgSFwQ@mail.gmail.com>
Subject: Re: [Possible Bug] Commit generates GC repack failure
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 14, 2019 at 10:03 PM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Mon, Jan 14, 2019 at 9:51 PM Randall S. Becker
> <rsbecker@nexbridge.com> wrote:
> >
> > Hi All,
> >
> > I'm trying to track down what happened this morning. We had a commit that
> > caused a background gc to occur. What happened was:
> >
> > $ git commit -m "history commit ... "
> > Auto packing the repository in background for optimum performance.
> > See "git help gc" for manual housekeeping.
> > warning: The last gc run reported the following. Please correct the root
> > cause
> > and remove .git/gc.log.
> > Automatic cleanup will not be performed until the file is removed.
> >
> > fatal: open /dev/null failed: Invalid function argument
>
> sanitize_stdfds() in setup.c can attempt to open /dev/null then
> redirect stdout and stderr to it. I think this is part of the
> daemonization that is done in background gc.

However the message does not match. I think you will find this "open
/dev/null failed" line in run-command.c
-- 
Duy
