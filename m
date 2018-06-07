Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8C341F403
	for <e@80x24.org>; Thu,  7 Jun 2018 08:34:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753326AbeFGIeg (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Jun 2018 04:34:36 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:33635 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752570AbeFGIed (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jun 2018 04:34:33 -0400
Received: by mail-yb0-f195.google.com with SMTP id x36-v6so2955071ybi.0
        for <git@vger.kernel.org>; Thu, 07 Jun 2018 01:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=QTbV+vpHy/+sLtp7elw7Bgcau//FBDyiiz0EOrL3kgc=;
        b=KjkSUbJFRgBK8MRWjHEvST9MqFZ3g3CrPA3jbzUlgUnmExemdblMdr57VjTvCZjL/P
         Ea46CxGEtVhEs6MQUognUCzVM2no4jWwggdpYSAbMcZnyBOWpRbUcDa6Ka7gfF/N45Qs
         +voWbD5q5zeBgyDUW717JMMcY4LkRCxWWmovvkX2n7W3Mqyc8Pq+vmCG162UTOSvD9PF
         K438LNAeBHm7ZnEhoL6jv/nP0jBxM5t77MAoPpYjTwH5ho9+EH6N8oAM+dNbG+NfQHnu
         fGlSG1Wh7a0z+ptv+S76Y/8onqH3tQdBtw9pqMZat+XelhA1rEGTLijI7C/6maVqXHPf
         Ey/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=QTbV+vpHy/+sLtp7elw7Bgcau//FBDyiiz0EOrL3kgc=;
        b=CK4KjcPIhNWpwsYofWr3llwYRD3r8lukfC+iXm1MOBLfWBlCiEudKx46GFC4LqMQy0
         xc1OGWPycboIVIuEtIqigT9/vKkqHiCDSeTm0A6YXenlqMM5Fr8CRGCqVZj6/jsdaSv8
         vHAA6cNWOOubfBDBL226e6bkvFrYZqrdzzkuR2SaunJ+pSZfrrPPWr4o+NyqwgGxCmXw
         OsFZcTc/wpKGOugDUfyOwlXpRKAlrVoxqPfvaAhlT7m3GnmufGqWhg6kV6b5LBpiQS0s
         IWF31SWGWqBNwNT9612K63ofn2bWfWs01AewTj0OSauy0iMmULRWZt51WDXyrA4HxFSe
         96xA==
X-Gm-Message-State: APt69E0uV0fY0OaOECjP6o+QiAIWqxwL/gJ+G5PouVjcUf/e6Bhp00fh
        49LRQDRJsr3IsYzTD3uNmXGr7BRFPg73IQGMqx8=
X-Google-Smtp-Source: ADUXVKIOpGBruRRR47eRj7um+rJ2TfjQeH7xyDf2nmkT4eoKqxm0TblRJl7Jmwy0vdXPZc0ZKR8edyFuX1sYi6NpMaI=
X-Received: by 2002:a25:2284:: with SMTP id i126-v6mr462236ybi.295.1528360472894;
 Thu, 07 Jun 2018 01:34:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5b:784:0:0:0:0:0 with HTTP; Thu, 7 Jun 2018 01:34:32 -0700 (PDT)
In-Reply-To: <CACsJy8D=6fAEpO5m4cc7KZyggAW1AosSkUWaunQBFH0nr-YrdA@mail.gmail.com>
References: <20180530080325.37520-1-sunshine@sunshineco.com> <CACsJy8D=6fAEpO5m4cc7KZyggAW1AosSkUWaunQBFH0nr-YrdA@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 7 Jun 2018 04:34:32 -0400
X-Google-Sender-Auth: LGmrXiV4ZW0cjdpemTRA5Jbivwg
Message-ID: <CAPig+cS1M3U0T7yd2hKv4Uv1NMub20bTy13-D-6drpJLJjNNAA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] format-patch: automate cover letter range-diff
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 6, 2018 at 3:16 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Wed, May 30, 2018 at 10:03 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> Dscho recently implemented a 'tbdiff' replacement as a Git builtin named
>> git-branch-diff[1] which computes differences between two versions of a
>> patch series. Such a diff can be a useful aid for reviewers when
>> inserted into a cover letter. However, doing so requires manual
>> generation (invoking git-branch-diff) and copy/pasting the result into
>> the cover letter.
>
> Another option which I wanted to go is delegate part of cover letter
> generation to a hook (or just a config key that contains a shell
> command). This way it's easier to customize cover letters. We could
> still have a good fallback that does shortlog, diffstat and tbdiff.

It is common on this mailing list to turn down requests for new hooks
when the requested functionality could just as easily be implemented
via a wrapper script. So, my knee-jerk reaction is that a hook to
customize the cover letter may be overkill when the same functionality
could likely be implemented relatively easily by a shell script which
invokes git-format-patch and customizes the cover letter
after-the-fact. Same argument regarding a config key holding a shell
command. But, perhaps there are cases which don't occur to me which
could be helped by a config variable or such.

Of course, by the same reasoning, the --range-diff functionality
implemented by this patch series, which is just a convenience, could
be handled by a wrapper script, thus is not strictly needed. On the
other hand, given that interdiffs and range-diffs are so regularly
used in re-rolls on this list (and perhaps other mailing list-based
projects) may be argument enough in favor of having such an option
built into git-format-patch.
