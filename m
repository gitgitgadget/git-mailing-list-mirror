Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDDC9202BB
	for <e@80x24.org>; Wed, 27 Mar 2019 13:21:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729657AbfC0NVg (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Mar 2019 09:21:36 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33107 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbfC0NVg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Mar 2019 09:21:36 -0400
Received: by mail-ed1-f65.google.com with SMTP id q3so14003336edg.0
        for <git@vger.kernel.org>; Wed, 27 Mar 2019 06:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3c3ycWaAvBfT3/iT2ADot8bUwJi6NCL9jZ7Wbe4P3cY=;
        b=hP2mAyd+OsQFUzWKxnGY1M8UfKerMP4ad9agm0lYb6xxNXWKvEFf9Y96oIrg++Fczm
         w9Z8ZWfZyhq347I30lsV0KG3T1y7EAeOcxGSzF75syJBS561bM7+84JPKamlYkJd/Z/L
         Zj6DcrHEzLjA94maJRyO+8uv1uJmVKemmpQz7BxqFmL9vv/VWNY2cG6gePqbN4oNzlQ5
         dQQl0JkXx1HTI7wYtdkDMzGlCw9dzyB6x9HppxdExF44E1aw0s1gQubIpJaN6pjncH+X
         DWqg1wHTiU9JnBqYEhUZrnk0P/WZBx8j2bmuyxqxc2dJa31Ir/5Fy+gjYiDy/KPBidr8
         acBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3c3ycWaAvBfT3/iT2ADot8bUwJi6NCL9jZ7Wbe4P3cY=;
        b=jsfU55oi/jyugT7CcNNKQSt4hPjoiRy7j9ur/qHmbasGs7kChKm0lGJJPNu8Mmdm/6
         XqGRqAflQ1QGD17nxTIhpCHq4oHQAR6emLppFTXFqKCR07WV3+6FzpDYUhxvhp07PPH3
         q/bsMhs2rqOg8zCDIAvkWA1meG4Q0/LPGlcbxIyNiF5frbVSjmaSa4DQFC/M99CXMcXs
         ZqIKHXCZTxqtv5OvUnBPE4AphpRGylKChst4JHcgzxR2Ow8RkpnnU+qopT1IbEeAGk+0
         OvzIp4qnX7SPf93CTAjMbmNdALYAQp75nScdzlsp8kFifbvKJ0OZzxZiAf6PDZkebT6Z
         i0SA==
X-Gm-Message-State: APjAAAW7w5py7ZWdoiJNDxdzD6ceejgLp7IirqcSDcwjuvM+n5ct1o/+
        K+sjQzmHEnTsmHSFQ2NKRBLlPnZm9FL1T+ZhQJM=
X-Google-Smtp-Source: APXvYqyFE6azzdoaJvOVLzwNeMpb2YIgUCzgYMDowlX+wFkqxdL3m7DXAWXmVXst9FHKVoEAZ0rEp6jZeSUwiJueLq0=
X-Received: by 2002:a50:91ac:: with SMTP id g41mr22695905eda.188.1553692894302;
 Wed, 27 Mar 2019 06:21:34 -0700 (PDT)
MIME-Version: 1.0
References: <mvmd0mcsjkf.fsf@suse.de> <CAP8UFD1qU_kJ97MdLFwzx+g3F6Q+fQ9LWOBxd=1m4vSi-fxF=Q@mail.gmail.com>
In-Reply-To: <CAP8UFD1qU_kJ97MdLFwzx+g3F6Q+fQ9LWOBxd=1m4vSi-fxF=Q@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 27 Mar 2019 14:21:23 +0100
Message-ID: <CAP8UFD111-zqa7Fhr1KnmWYAKpBN4ofqn0AvD_nP3s_WBFzLqw@mail.gmail.com>
Subject: Re: git replace --graft does error checking too late
To:     Andreas Schwab <schwab@suse.de>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 27, 2019 at 2:11 PM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Wed, Mar 27, 2019 at 11:24 AM Andreas Schwab <schwab@suse.de> wrote:
> >
> > When running `git replace --graft A B' where B is a non-commit (eg. a
> > tag) it displays an error,
>
> Yeah, it seems that when A is a commit and B a tag I get:
>
> "error: object A is a tag, not a commit"
>
> which is wrong as A is a commit.

Actually I get the above only if A is a commit but there is a tag
pointing to it. If there is no tag pointing to it I get:

error: object C is a tag, not a commit

where C is the hash of the tag object B (C=$(git rev-parse B))

So yeah, this is weird.
