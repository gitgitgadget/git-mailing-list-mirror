Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 199A91FA14
	for <e@80x24.org>; Sat, 27 May 2017 01:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932229AbdE0BMD (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 May 2017 21:12:03 -0400
Received: from mail-lf0-f42.google.com ([209.85.215.42]:33415 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S944983AbdE0BEq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 May 2017 21:04:46 -0400
Received: by mail-lf0-f42.google.com with SMTP id m18so13376832lfj.0
        for <git@vger.kernel.org>; Fri, 26 May 2017 18:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+FQLz0NUDVIze8IZ+27LOGdEOYomesHSoytYd25HzOc=;
        b=AztIJpPLh+o2nOgq+4/Yjio715OR4ya57GFEQB1LNLNl11LGz/fb5UnpDUcQXGJoeT
         sosZJRUybSuFDEJIFzPQYSh2Xf8aX5oV1iEjVxe57b1rqY0vd+teifnkty9V5y7lkaUg
         X6JawI9kJ9+IUe2e5ixnr0q82vCLAUhXCe5QQdgrilsvDzYGosgrV1bxZZ81U86fVlEU
         gxSzZPbnzdhO1Rx76cC35Fgcw3/fR7otnKhlb6sW8xcP7BjoJ8/x1H3Gp54PApYAuSg1
         ljVcUj9Kgl96zpJg5Kg8agO/FGoaY6SB/NT20x8axZ63E+mcDmYC5sB1qU7nzzeETkgt
         AKkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+FQLz0NUDVIze8IZ+27LOGdEOYomesHSoytYd25HzOc=;
        b=DIzeaK5oQzIgragdydB6HYO98XpiCpnSOCT7gMKhpncdisANMy1itE3ZWPQ/tf9Yas
         vAyPE3lVgWLmEXVoOe+d9g+seQyH282EzJF3+mnnevWHOOPYb38RWhNH3D8erM781prg
         BWTco6NUW7QHvOiEe2vn75vRSupSfK5GdIi5zIpk9piHwmPlkuuzIk8ueXq1Xclwc6s0
         331SZlcAcoatkxALVl0OzSnEmlRSJdXLDq3wbDMZo/4q7ALYF+UUS0JCjCVMSa5+qo1d
         4ceKIuImgsx80lb8jSpt5nb9pl9edAhIxVDExLwVHeOn0Wptto6TbhiPjDO0nKrNg+F5
         n2qA==
X-Gm-Message-State: AODbwcBySF1mGol5wv3Kc3bd5pMLvJnzJUN5JchNiPOnYJ6DSsJEyBKD
        RtAB8dE3kcRRQPhwHW/UYnfebEMy8g==
X-Received: by 10.46.88.29 with SMTP id m29mr1419775ljb.37.1495847084593; Fri,
 26 May 2017 18:04:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.32.133 with HTTP; Fri, 26 May 2017 18:04:23 -0700 (PDT)
In-Reply-To: <20170523024048.16879-1-sbeller@google.com>
References: <20170518193746.486-1-sbeller@google.com> <20170523024048.16879-1-sbeller@google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 26 May 2017 18:04:23 -0700
Message-ID: <CA+P7+xrFjwUWNA9BQ3V4ad6mizrfXTcU4td+u1-i9GCBshPjfQ@mail.gmail.com>
Subject: Re: [PATCHv4 00/17] Diff machine: highlight moved lines.
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 22, 2017 at 7:40 PM, Stefan Beller <sbeller@google.com> wrote:
> v4:
> * interdiff to v3 (what is currently origin/sb/diff-color-move) below.
> * renamed the "buffered_patch_line" to "diff_line". Originally I planned
>   to not carry the "line" part as it can be a piece of a line as well.
>   But for the intended functionality it is best to keep the name.
>   If we'd want to add more functionality to say have a move detection
>   for words as well, we'd rename the struct to have a better name then.
>   For now diff_line is the best. (Thanks Jonathan Nieder!)
> * tests to demonstrate it doesn't mess with --color-words as well as
>   submodules. (Thanks Jonathan Tan!)
> * added in the statics (Thanks Ramsay!)
> * smaller scope for the hashmaps (Thanks Jonathan Tan!)
> * some commit messages were updated, prior patch 4-7 is squashed into one
>   (Thanks Jonathan Tan!)
> * the tests added revealed an actual fault: now that the submodule process
>   is not attached to a dupe of our stdout, it would stop coloring the
>   output. We need to pass on use-color explicitly.
> * updated the NEEDSWORK comment in the second last patch.
>
> Thanks for bearing,
> Stefan
>

One thing to note when I was playing around with what's on pu right
now, I noticed that the oldMovedAlternative and newMovedAlternative
are the first moved colors to be used if there is only one move. (Ie:
a simple case of literally one section moved) This is a bit weird that
the alternative colors are used before the "main" colors. I would have
thought it would be the other way.

I noticed this because the default colors do not work well for my
terminal color scheme and I had to configure but realized that I
needed to configure the alternative ones to make a difference in the
simple diff I was viewing.

Thanks,
Jake
