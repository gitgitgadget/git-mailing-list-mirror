Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD7921FF7F
	for <e@80x24.org>; Thu,  8 Dec 2016 01:16:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932955AbcLHBQN (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 20:16:13 -0500
Received: from mail-pf0-f172.google.com ([209.85.192.172]:34368 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932532AbcLHBQM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 20:16:12 -0500
Received: by mail-pf0-f172.google.com with SMTP id c4so80222777pfb.1
        for <git@vger.kernel.org>; Wed, 07 Dec 2016 17:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/gPC2c+O0CxFe0Gl0XHZ0asuM5kEs4SCWHqh32gy8Yw=;
        b=gxNCX2Sj3heRy+gIR5hFhRkhS0C3B277yR+kzeAu9CRZG8dUzseTGPvHYqbq6RCYTN
         3ngQstZrZNjf6hSvUiYP4HVTU4ZwU5sxBdSGav4iUJVH5iTCPVoR7AuF29BNp/ZLg+Gi
         arj1JN1W3o9I/9K5uFCblMZuMUTp4bcScim0+LlXJt3EKDwKCILznsiirZBFzU/kiI8w
         vaeRLAsnZ1N3GzlKZ+2esO1PE4iAmUKWlnWly49Abtito37F3df4rYphSJsverVgV2A9
         p+ZVoTAxemnTDPnRpsfzE18VmVKNHbLLN+4IJnggNv3AA9Ajsz/KMIA+bbeUfmdc8iHE
         qBag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/gPC2c+O0CxFe0Gl0XHZ0asuM5kEs4SCWHqh32gy8Yw=;
        b=V3vrw2p4vtEjmvJIKdAHDDPLSJ1a88MrHR7tzCer93bXgDldirEoiHbRiZl1e+BV7Z
         IGj+hXIQfMNXa49NIWOb09mDH78wCNgwaR62U8ilwu19D4iZEAWlrCxXl1aJyLEA3PPv
         r4cGiLeoI/jX8vfIxs4130y4ESSmk8Q1Pv0tcpqt86xF7KtWT74tVNx8eIwxrH/o1+B9
         FL/E000VJUonXtHigL515CoPZg5l4e4tt2ktNtpdq34NX0zTR4OmWFZ16UWrYAlUSarI
         ddLaoLGYX/E03NXHuFYndDZFWPFBks4j0dtZFCruScYsrRPEb5v8nt41fYnpH52KYfgW
         rXhA==
X-Gm-Message-State: AKaTC02I5s3d4/A0ieN6UwOyR9+z0w966FAWNMu03/aagi8gcamSjHAa0AaNXsCiy9wNTCpJ
X-Received: by 10.99.184.18 with SMTP id p18mr9274993pge.33.1481159682410;
        Wed, 07 Dec 2016 17:14:42 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:ccae:4719:31da:e07d])
        by smtp.gmail.com with ESMTPSA id n24sm45356131pfb.0.2016.12.07.17.14.41
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 07 Dec 2016 17:14:41 -0800 (PST)
Date:   Wed, 7 Dec 2016 17:14:40 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCHv5 4/5] worktree: get worktrees from submodules
Message-ID: <20161208011440.GM116201@google.com>
References: <20161207210157.18932-1-sbeller@google.com>
 <20161207210157.18932-5-sbeller@google.com>
 <xmqqvauvuzna.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kZiS9dx6QUOcFYh8sSNoVsrv2eNLXJd6X54UekzUiC8VQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kZiS9dx6QUOcFYh8sSNoVsrv2eNLXJd6X54UekzUiC8VQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/07, Stefan Beller wrote:
> On Wed, Dec 7, 2016 at 2:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > Stefan Beller <sbeller@google.com> writes:
> >
> >> +     submodule_common_dir = strbuf_detach(&sb, NULL);
> >> +     ret = get_worktrees_internal(submodule_common_dir, flags);
> >> +
> >> +     free(submodule_gitdir);
> >
> > This sequence felt somewhat unusual.  I would have written this
> > without an extra variable, i.e.
> >
> >         ret = get_worktrees_internal(sb.buf, flags);
> >         strbuf_release(&sb);
> 
> Yours is cleaner; I don't remember what I was thinking.
> 
> Feel free to squash it in; in case a resend is needed I will do that.

Just make sure to leave that free in as it refers to another variable
(submodule_gitdir).  It actually turns out there is a memory leak in the
original code because submodule_common_dir is never freed after being
detached from the strbuf.

-- 
Brandon Williams
