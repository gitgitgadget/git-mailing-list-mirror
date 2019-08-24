Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 997631F461
	for <e@80x24.org>; Sat, 24 Aug 2019 06:54:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbfHXGyd (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Aug 2019 02:54:33 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:45285 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbfHXGyc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Aug 2019 02:54:32 -0400
Received: by mail-vs1-f67.google.com with SMTP id j25so7694669vsq.12
        for <git@vger.kernel.org>; Fri, 23 Aug 2019 23:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C77DZVyHmKh4Dv8anDBGnGpJBrS9Q5zo+5J0j/SV8uc=;
        b=N2ClElGJNxWDz39a9Ta9wcrC77aLzK5QPRnKQheQvtzw+pZCs6rGtYXNy7vaYQDX7n
         dYmEBhLYHXUPTwPQz6S92YDpeybKQBfW1u9ofVKVzRvz6xJAxmIIVpIjokRkyRXmT/PQ
         /qCJR/HpvBkCl7RtwoS+hHqhpxr+tV2d59WE6TyiFxB5ofpFz+5gHtxbxzCEelNGs9qD
         erlveusVe81ZekaSafmBpO3UjK+fBN7nRkg48UEgM1+xSaKngpIk+I+Y3Hp+rB9gY3u/
         8DYKmX+HAqbVKkbFTPNrZF1aYGTQ3MZS7PV00dvwUizBSuUhsp0rJyqzr9jf96tJX11L
         zlhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C77DZVyHmKh4Dv8anDBGnGpJBrS9Q5zo+5J0j/SV8uc=;
        b=Dy8k4oGtypQLfsgzDwkn7UJaV3nLCZ3MGMM876u5CGDZrv3+3iRqqydKSA5v3LedsN
         OU4ChQMkUGGdDSXpOh1DlZMCussl+5aHkS7edYlWczur2HkQDLYvUzacbtycGwlHfnsd
         H+VwUiwH8nifQG0A8XUY0XlzZlY5iz07fRtQ4JC/xLlPIhnCU0eoIdvvXPGkGojbJUl4
         XK8wa7oU1OBgP57fxkR6yFbmGaHGyDnPHmCYgZG8SpNrv0t4HHVynvrEg6psq/DFPR1E
         h2a+NRnnu4SMct3ut8kMLts2/Xdiw41lBqnsuEici5Kl4iWcVVNhdIB9s+Z19AFg13oF
         oOSw==
X-Gm-Message-State: APjAAAXDGeVW+6M3qk44Ov/dTFBr3w045zTgv/wtec1I8zt9t3sDvJT+
        weyuEJjK0aWcv8BXgUj8kyv4SVafJqkZnyXUkRgYvgkhAps=
X-Google-Smtp-Source: APXvYqyBsVycj0wmRbIoPimM5oA3v39tqw78jW31OvxSAiYPx7B5owIRzPU/Aa2nHBQYonPXmdOADt+u0vLKtd1c7FQ=
X-Received: by 2002:a67:e45:: with SMTP id 66mr4892765vso.197.1566629671656;
 Fri, 23 Aug 2019 23:54:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190819214110.26461-1-me@yadavpratyush.com> <20190822220107.4153-1-me@yadavpratyush.com>
 <20190823234339.GA17088@gmail.com>
In-Reply-To: <20190823234339.GA17088@gmail.com>
From:   Bert Wesarg <bert.wesarg@googlemail.com>
Date:   Sat, 24 Aug 2019 08:54:20 +0200
Message-ID: <CAKPyHN17vKR9PEegUD49j0nz_RDqn-H7or6-5Bo6q-RBYp+5rQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] git-gui: Add ability to revert selected hunks and lines
To:     David Aguilar <davvid@gmail.com>
Cc:     Pratyush Yadav <me@yadavpratyush.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 24, 2019 at 1:43 AM David Aguilar <davvid@gmail.com> wrote:
>
> On Fri, Aug 23, 2019 at 03:31:03AM +0530, Pratyush Yadav wrote:
> > Hi,
> >
> > This series adds the ability to revert selected lines and hunks in
> > git-gui. Partially based on the patch by Bert Wesarg [0].
> >
> > The commits can be found in the topic branch 'py/revert-hunks-lines'
> > at https://github.com/prati0100/git-gui/tree/py/revert-hunks-lines
> >
> > Once reviewed, pull the commits from
> > 415ce3f8582769d1d454b3796dc6c9c847cefa87 till
> > 0a1f4ea92b97e673fda40918dae68deead43bb27, or just munge the patches and
> > apply them locally, whichever you prefer.
> >
> > Changes in v2:
> > - Add an option to disable the revert confirmation prompt as suggested
> >   by Johannes Sixt.
> > - Base the patches on Pat's git-gui tree instead of git.git.
>
>
> We've had these features for years in git-cola.

this series does not introduce new hotkeys.

>
> Please copy our keyboard shortcuts.
> IMO we should not re-invent the user interactions.
>
> http://git-cola.github.io/share/doc/git-cola/hotkeys.html

my part for the homework:

>
> Ctrl-u is our revert-unstaged-edits hotkeys.

https://github.com/patthoyts/git-gui/commit/b677c66e299c8754a6093cbd19ce71b0ad2a8a17

> "s" is for
> staging/unstaging (or Ctrl-s if the file list is focused).

https://github.com/patthoyts/git-gui/commit/cd16a6c9298778265a044e5f9a39b006277b32f2

https://github.com/patthoyts/git-gui/commit/e210e67451f22f97c1476d6b78b6fa7fdd5817f9#diff-ceba4b88c7e634c5401a4487d45d3ab4R774

Bert

>
> The same hotkey is used for operating at the line level.
> If no lines are selected, the hunk surrounding the current cursor
> position is used.
>
> Please make keyboard interaction a first-class design consideration.
>
