Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86022201A7
	for <e@80x24.org>; Mon, 15 May 2017 19:45:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965551AbdEOTpx (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 15:45:53 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:34414 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965374AbdEOTpw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 15:45:52 -0400
Received: by mail-pf0-f178.google.com with SMTP id 9so28233337pfj.1
        for <git@vger.kernel.org>; Mon, 15 May 2017 12:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dDyiDOP2LPTGP3avV6P91nA9gwR5S+FQ64hUmEpJonA=;
        b=VDz47TEwMI4KlvzzfZcOWnKJtEkR1/OvlVjkrooDw+lk7ZrpxRcl0MdBxr0WX/54aD
         w5jesUVNtKu4bMcVo83IfyClW1ZpwAW0e11RodhuVgT7hYAGnkXHtFAFX3/eVd7tbD3D
         jprQWDG+FBZLqiHqkmI2AEK99tVoVFCIGoXe8TOTJEQQg7EEnqNqAoLJOUepaRuAcNQc
         I1I/XkQ9Y2MEKTUaceSikwwhh5YGWQ8Eo/PzHJbL9c6sh5aaPJiaZUh/a8xFWjBZ6wW5
         PnVUiRLDoA4rtpnDYAOI4BxDeE03JadWHI1PConOw6Vk/LeTJX47606T3VTojKVAhk1Q
         5J6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dDyiDOP2LPTGP3avV6P91nA9gwR5S+FQ64hUmEpJonA=;
        b=CavSi1dCjSLt44Zkp08II3j3exsw68ePeFmraLBxLLJ24fg+2Es+bUD3sxnuQdZrOM
         nGjkOws+xDzRYk2QloBypVvS6W4fsyvVqyrx1odYiyhGZQZVdgey2GZdt282uvoSU2zX
         9Qih925sKxtgygOTVv1ffpP7Cl+xRnAkc0/Co9g0DFaeTmCeC6pABfbaN20ISyLpl+Ox
         9aEGVo0rCcn1GhAISs/Vz+pYQkGeIK/Aam+boIiwqZpKOOiD/e1j3IlRpkYk+kb9wZgj
         QXZPen69mKvyv5v1irRyDAlrCSM5QJerozbMySpwrYQMGuFf75/b+1WX0axUI1GCVy1h
         cIYQ==
X-Gm-Message-State: AODbwcALBX9g7bGtD/g/1puvNjgHxclUdvQxVXCDfprJMMnwo8YuJfrU
        F/c074sc6CHfVGNx
X-Received: by 10.98.163.152 with SMTP id q24mr8050851pfl.217.1494877551294;
        Mon, 15 May 2017 12:45:51 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:8923:f8dd:f0f0:f864])
        by smtp.gmail.com with ESMTPSA id v63sm14570452pfi.133.2017.05.15.12.45.49
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 15 May 2017 12:45:50 -0700 (PDT)
Date:   Mon, 15 May 2017 12:45:49 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 03/19] diff.c: drop 'nofirst' from emit_line_0
Message-ID: <20170515194549.GD79147@google.com>
References: <20170514040117.25865-1-sbeller@google.com>
 <20170514040117.25865-4-sbeller@google.com>
 <20170515192242.GB79147@google.com>
 <CAGZ79kZMHuk8g7wwwoDxBOG17Vo3P0s9v9bwzpwy5WnuNUogtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kZMHuk8g7wwwoDxBOG17Vo3P0s9v9bwzpwy5WnuNUogtw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/15, Stefan Beller wrote:
> On Mon, May 15, 2017 at 12:22 PM, Brandon Williams <bmwill@google.com> wrote:
> 
> > Does the order of newline/carriage return always the same?
> 
> https://en.wikipedia.org/wiki/Newline
> 
> There are operating systems that like it the other way round.
> The BBC micro is no longer relevant (IMHO), but RISC OS
> spooled text output *may* be relevant as they released a stable
> version not that long ago.
> 
> But I would think this code would have issues with RISC OS
> text spooling without this patch as well.
> 
> Stefan

Fair enough, its not relevant to the series.  I was just pointing it
out.

-- 
Brandon Williams
