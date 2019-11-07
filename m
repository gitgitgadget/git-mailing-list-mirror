Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6175F1F454
	for <e@80x24.org>; Thu,  7 Nov 2019 16:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729516AbfKGQco (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 11:32:44 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44844 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727606AbfKGQco (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 11:32:44 -0500
Received: by mail-pf1-f196.google.com with SMTP id q26so2915148pfn.11
        for <git@vger.kernel.org>; Thu, 07 Nov 2019 08:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rHi06pwFMwLv2ABXBErVboG1NpRVYplXStPNqjdVpNk=;
        b=gVrkFvMOCu3q+hvTJ0TqHkPWIYi9MifmGImE3oapyR7eRm7FhI6G2/VGoNZ3/juH3R
         a2b94dXEdsIl0iUiFxzfmrna/ypKNgsl5q34YqvV+HdEyxjiK3omSJuDxa34gDosN+9r
         nlgj3g7sS0ncw9MgHvXSO7V5tYtj2MPjbBaB8YfOfR4gsLsdNFl3rqLppukqWTnnrgEE
         x+3ir0VlHJPAvI/mjhTqNi1sQ7qbjQd2uAbFI29iIaqmVLZXV1LrJuheTbY+QjVtQjAG
         T7Ug/uSErJVKw45Nlb6lCZEMckmP5UF6uMptSdAhCZD2zxIVfk5LI6KxpDVwvHSBYH3s
         t+XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rHi06pwFMwLv2ABXBErVboG1NpRVYplXStPNqjdVpNk=;
        b=Es/RiI0Po8HH1WBwKMmBsUBCB8Dy0KDsFJ9Ocu2wC75miSlaXneHJ8XrQYtbxhgbDh
         PIqfsC9k3CiuKOaTR3rkejVk9aHyZFFjI3nLi2VHvs50eSf2ztCrB0YAWTlok+JX7Vhz
         qpVmYWNHvSPkPHNE9agkcU1V/41jS/k5WHP0vN/t6WtMHgSGChCmMkFJRlT3zi1Zp68T
         T6m+/cgQZ48tySd2mUp2TUOGzjh1gUVFiSwvXL2AEuLTcgAhFwpDQX4P4cos0Oocdap6
         GszUQEsr1kyNcWwg+zpjPa3hdNKF7smxGKlR0iNgoQ7ehWbZxdxO/wlhFK5IBenN3GeJ
         p3IQ==
X-Gm-Message-State: APjAAAX7RqJW4mVoZLlZnTRRqbjL6cL+SXwdx5poOwTriVsWY85MdOl5
        mWS0iYNR3Qt5s3TSFKdev1i/FhZE/Fc=
X-Google-Smtp-Source: APXvYqzlj3HQXjNf07zV1w6yJAVGf+9dICrilaqOTl7HmyWkpjZOlT/nZy/ch1n2Ebz1Dv1tl+uKBg==
X-Received: by 2002:a63:d308:: with SMTP id b8mr5586923pgg.246.1573144363200;
        Thu, 07 Nov 2019 08:32:43 -0800 (PST)
Received: from localhost ([2402:800:6375:16b7:502d:9b82:436:143a])
        by smtp.gmail.com with ESMTPSA id 65sm5826252pff.2.2019.11.07.08.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 08:32:41 -0800 (PST)
Date:   Thu, 7 Nov 2019 23:32:40 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 8/8] sequencer: reencode commit message for am/rebase
 --show-current-patch
Message-ID: <20191107163240.GF8096@danh.dev>
References: <20191031092618.29073-1-congdanhqx@gmail.com>
 <cover.1573094789.git.congdanhqx@gmail.com>
 <36796e2b679cd8b2d341058e775db401f9abcef7.1573094789.git.congdanhqx@gmail.com>
 <20191107063223.GF6431@sigill.intra.peff.net>
 <20191107074858.GC8096@danh.dev>
 <20191107080307.GB11245@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191107080307.GB11245@sigill.intra.peff.net>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019-11-07 03:03:07 -0500, Jeff King wrote:
> On Thu, Nov 07, 2019 at 02:48:58PM +0700, Danh Doan wrote:
> 
> > > # and if we resolve and commit, presumably we'd get a broken commit,
> > > # with iso8859-1 and no encoding header
> > > echo resolved >file
> > > git add file
> > > GIT_EDITOR=: git rebase --continue
> > > -- 8< --
> > > 
> > > But somehow it all seems to work. The resulting commit has real utf8 in
> > > it. I'm not sure if we pull it from the original commit via "commit -c",
> > 
> > Yes, somehow it worked. But, without this patch, git also warns:
> > 
> >     % GIT_EDITOR=: git rebase --continue
> >     Warning: commit message did not conform to UTF-8.
> >     You may want to amend it after fixing the message, or set the config
> >     variable i18n.commitencoding to the encoding your project uses.
> > 
> > Checking with strace (on glibc, musl strace can't trace execve):
> > 
> > > [pid 12848] execve("/home/danh/workspace/git/git", ["/home/danh/workspace/git/git", "commit", "-n", "-F", ".git/rebase-merge/message", "-e", "--allow-empty"], 0x558fb02e8240 /* 51 vars */) = 0
> > 
> > Turn out, it's because of: commit.c::verify_utf8
> > 
> >     /*
> >      * This verifies that the buffer is in proper utf8 format.
> >      *
> >      * If it isn't, it assumes any non-utf8 characters are Latin1,
> >      * and does the conversion.
> >      */
> >     static int verify_utf8(struct strbuf *buf)
> > 
> > Hence, your test is just pure luck (because it's in latin1).
> 
> Ah, thanks for resolving that mystery. Is it worth turning the scenario
> above into a test?

Yes, it's worth to have a test.
In fact, I found another breakage (rebase with encoding) while writing
this test. I'll delay the re-roll a bit to include that breakage.

-- 
Danh
