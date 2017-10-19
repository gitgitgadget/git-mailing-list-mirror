Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCD17202DD
	for <e@80x24.org>; Thu, 19 Oct 2017 21:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752212AbdJSVqf (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Oct 2017 17:46:35 -0400
Received: from mail-qt0-f169.google.com ([209.85.216.169]:46162 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752013AbdJSVqf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Oct 2017 17:46:35 -0400
Received: by mail-qt0-f169.google.com with SMTP id 1so16314430qtn.3
        for <git@vger.kernel.org>; Thu, 19 Oct 2017 14:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0vXoInfVzy71rPu6XI5KaJrf9rgDL2dRWBb7dARHDFE=;
        b=tuZb66dgp6cR+xi+X/XyT0EIYd/NUWxeWnJtIFRxWdJFJzBtYTy6d+VxFYIBr3MsdG
         vn4QynAhdwzvU24Tv9YBDSkY18Ar1iSPOyysBEaRCTfcaYAa+thbluXQ9R6+tHmPhHnk
         ObXOIzahw26cUcydux+FEgsTDM9Rm6OmEEvxjbNVeQV9TnNnBDNI3gAqg53mruQa59Jg
         YbHdLJquzcPQN0LF32bKyM427erL8tePf8lj34UeXOCg5KEBXxp0HH+vfCRZ0wtKc0sK
         b/PvhO5BeZexiJH+LbIytAAWw73F+JxCEAPBhyOx5Pu+XBy9EXHk70SupYZCIPRVXyZz
         aIig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0vXoInfVzy71rPu6XI5KaJrf9rgDL2dRWBb7dARHDFE=;
        b=n/bt474kQdxfwDBBb0O9NZJq700TFsFgWE8/clgA4a/PGxsAd4h6iWuBfhXjV7c3m4
         4h/USMG0KXh25eFazY4poZCJnxgn0DNtgaur6TgPM5jJBRr1RxbxMvlasBzPgjfHnZF7
         ldZWVA8mkW66CSEpnwnm56CKgr0q5sNCav7HN/gZm3GfUBOpjlBveAmTTGoJFiqWnvEc
         4lZgYfH4j5YkTK2o2wgu6fWjEeuJ5rLjKFWP3A/T2yYBJfej7B9qIw69DPM78COmf8jN
         OEqw8R5QXw9jB8pjG1lmDZNNsCckyPTieT+U7hQR4NPPAXPMAiZRB6wlXflRiKMXvr0B
         KY4w==
X-Gm-Message-State: AMCzsaWg6FtjKbgjyxp8QTT/BzaVDzrcVtbd2wr8YmhXwmUtxrk2ZsAQ
        sSyvcVRjpLgoUqLrpNYgPkgulzd2qW8xynIt7ciTew==
X-Google-Smtp-Source: ABhQp+TitT11rxAH8qlbkZuGH5DT5nvnHhTwBAslFCV+43SPObErJ6qnOJKetRVUzw74X35nHF2gUOLvws69eY7T5s8=
X-Received: by 10.200.40.146 with SMTP id i18mr4276846qti.79.1508449594123;
 Thu, 19 Oct 2017 14:46:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Thu, 19 Oct 2017 14:46:33 -0700 (PDT)
In-Reply-To: <20171019210730.sgm4g4tmor2dgjv7@sigill.intra.peff.net>
References: <20171019210140.64lb52cqtgdh22ew@sigill.intra.peff.net> <20171019210730.sgm4g4tmor2dgjv7@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 19 Oct 2017 14:46:33 -0700
Message-ID: <CAGZ79kYTmUnM+fcf222-cvwB3Fg4+J_xy28E7A3AYryx4qDf_w@mail.gmail.com>
Subject: Re: [PATCH 2/3] t5615: avoid re-using descriptor 4
To:     Jeff King <peff@peff.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I also considered trying to bump the "set -x" output descriptor to "9".
> That just moves the problem around, but presumably scripts are less
> likely to go that high. :)
>
> It would also be possible to pick something insanely high, like "999".
> Many shells choke on descriptors higher than 9, but since the issue is
> related to BASH_XTRACEFD, we could make it a bash-only thing. I don't
> know if it's worth the trouble. I hate leaving a subtle "don't use
> descriptor 4 in a subshell or your script will break" hand-grenade like
> this lying around, but we do seem to have only one instance of it over
> the whole test suite.

I would imagine that a higher fd for BASH_XTRACEFD
would be less explosive than requiring the tests to skip
the low number 4. (It is not *that* low. In e.g. git-submodule.sh
we make use of 3 in cmd_foreach, not needing more.)

Thanks,
Stefan
